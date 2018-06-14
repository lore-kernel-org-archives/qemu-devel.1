Received: from eggs.gnu.org ([2001:4830:134:3::10]:54191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fTHTF-0003xj-Iq
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fTHTC-0006pY-H1
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:54:41 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60563)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fTHTC-0006pU-CR
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:54:38 -0400
Date: Wed, 13 Jun 2018 21:54:37 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180614015437.GA14538@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] TCG region page guards and transparent huge pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>

After a discussion with Richard yesterday on IRC, I ran some numbers on the
performance impact of the guard pages added at the end of TCG regions.
These 4kB guard pages prevent the use of transparent huge pages for the
last 2MB of a region.

The benchmark I used is the bootup+shutdown of debian on aarch64. This
generates code at a high rate (for a total of ~350MB), which
performance-wise makes it sensitive to changes to page lookup
latency for memory accesses to the TB cache.

Find here a chart with several -smp 1 runs for different configurations,
with the error bars delimiting a 95% confidence interval for the
average (IOW, there's a 95% chance that the true average is within
the error bars):

  https://imgur.com/G5Gd39O

I used -tb-size 1024, to make sure there aren't any flushes.
Configurations:

- master: single region. It does use huge pages whenever pages are
  written to (checked via /procs/$pid/smaps).
- 2/4M no guards: forced region size to 2/4 MB, and removed the guard
  pages at the end.
- 2/4M guards: same as above, but keeping the guard pages.
- nohuge: single region, but passing MADV_NOHUGEPAGE to madvise.

As seen in the chart, 2M-guards performs similarly to nohuge. This
makes sense, because they both result in not using hugepages.

Master, 2M-no-guards and 4M-no-guards have similar performance, about
3% better than nohuge/2M-guards. (There's quite a bit of noise
because I only ran these 7 times each, but the confidence intervals
have a wide overlap.)

4M-guards performs in between the above two groups. With 4M-guards,
one half of each region is a huge page (2M), while the other half is
broken into 4K pages due to the guard page.

The conclusion I draw from the above is that as long as we keep
regions sufficiently large (>=4M), we won't be able to measure
performance regressions due to less huge page use.

Given the above, I plotted what region sizes we obtain for different
-smp and -tb-size combinations:

  https://imgur.com/RDF56Nv

We can see how region_size == 2 only occurs when we either have
very large -smp's, or small TB cache sizes (<= 256 MB).

So, what to do based on all this?

I think the current implementation makes sense. That said, two
things we could consider doing are:

- Remove the guard pages. I'd rather keep them in though, since
  their cost is negligible in most scenarios. If we really wanted
  to recover this performance, we could just enable the guards
  (by calling mprotect) only under TCG_DEBUG.

- Change tcg_n_regions() to assign larger regions. I am not convinced
  of this, since at most we'd gain 3% in performance, but we might
  end up wasting more space (recall that not all vCPUs translate
  code at the same rate), or flushing more often (probably with
  a perf impact larger than 3%).

It is also possible that other workloads might be more sensitive
to the use of huge pages for the TB cache, but I couldn't
think of any. Besides, the bootup+shutdown test is very easy to run =)
So based on the above numbers, those are my thoughts.

Thanks,

		Emilio

PS. You can see both charts side-by-side here:
  https://imgur.com/a/cu6g0pA
