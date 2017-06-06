Received: from eggs.gnu.org ([2001:4830:134:3::10]:56284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dII2n-00013B-Bj
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dII2k-0004ld-76
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:13:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dII2j-0004lW-Ny
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:13:22 -0400
Date: Tue, 6 Jun 2017 13:13:20 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170606171320.GA8115@flamenco>
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
Subject: Re: [Qemu-devel] GSoC 2017 Proposal: TCG performance enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

On Sat, Mar 25, 2017 at 12:52:35 -0400, Pranith Kumar wrote:
(snip)
> * Implement an LRU translation block code cache.
> 
>   In the current TCG design, when the translation cache fills up, we flush all
>   the translated blocks (TBs) to free up space. We can improve this situation
>   by not flushing the TBs that were recently used i.e., by implementing an LRU
>   policy for freeing the blocks. This should avoid the re-translation overhead
>   for frequently used blocks and improve performance.

I doubt this will yield any benefits because:

- I still have not found a workload where the performance bottleneck is
  code retranslation due to unnecessary flushes (unless of course we
  artificially restrict the size of code_gen_buffer.)
- To keep track of LRU you need at least one extra instruction on every
  TB, e.g. to increase a counter or add a timestamp. This might be expensive
  and possibly a scalability bottleneck (e.g. what to do when several
  cores are executing the same TB?).
- tb_find_pc now does a simple binary search. This is easy because we
  know that TB's are allocated from code_gen_buffer in order. If they
  were out of order, we'd need another data structure (e.g. some sort of
  tree) to have quick searches. This is not a fast path though so this
  could be OK.

(snip)
> Please let me know if you have any comments or suggestions. Also please let me
> know if there are other enhancements that are easily implementable to increase
> TCG performance as part of this project or otherwise.

My not-necessarily-easy-to-implement wishlist would be:

- Reduction of tb_lock contention when booting many cores. For instance,
  booting 64 aarch64 cores on a 64-core host shows quite a bit of contention (host
  cores are 80% idle, i.e. waiting to acquire tb_lock); fortunately this is not a
  big deal (e.g. 4s for booting 1 core vs. ~14s to boot 64) and anyway most
  long-running workloads are cached a lot more effectively.
  Still, it would make sense to consider the option of not going through tb_lock
  etc. (via a private cache? or simply not caching at all) for code that is not
  executed many times. Another option is to translate privately, and only acquire
  tb_lock to copy the translated code to the shared buffer.

- Instrumentation. I think QEMU should have a good interface to enable
  dynamic binary instrumentation. This has many uses and in fact there
  are quite a few forks of QEMU doing this.
  I think Lluís Vilanova's work [1] is a good start to eventually get
  something upstream.

		Emilio

[1] https://projects.gso.ac.upc.edu/projects/qemu-dbi
