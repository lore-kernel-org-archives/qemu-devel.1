Received: from eggs.gnu.org ([2001:4830:134:3::10]:50065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dlNwR-00058p-Tw
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 19:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dlNwO-0006Yh-Oj
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 19:23:07 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54673)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dlNwO-0006Y7-Hb
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 19:23:04 -0400
Date: Fri, 25 Aug 2017 19:23:02 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170825232302.GA29654@flamenco>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH 00/22] tcg: tb_lock removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On Mon, Aug 07, 2017 at 19:52:16 -0400, Emilio G. Cota wrote:
> This series applies on top of the "multiple TCG contexts" series, v4:
>   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06769.html
> 
> Highlights:
> 
> - First, fix a few typos I encountered while working on this (patches 1-3).
>   I could send them separately to qemu-trivial if you prefer.
> - QHT: use a proper cmp function, instead of just checking pointer values
>   to determine equality of matches.
> - Use a binary search tree for each TCG region.
> - Make l1_map lockless by using cmpxchg
> - Introduce page locks (for !user-mode), so that tb_lock is not
>   needed when operating on a page
>   - Introduce page_collection, to lock a range of pages
> - Introduce tb->jmp_lock to protect TB jump lists.
> - Remove tb_lock. User-mode uses just mmap_lock and tb->jmp_lock's;
>   !user-mode uses the same jump locks as well as page locks.
> 
> Performance numbers are in patch 22. We get nice speedups, but I still
> see a lot of idling when booting many cores. I suspect it comes from
> cross-CPU events (e.g. TLB invalidations), but I need to profile it
> better (perf is not good for this; mutrace doesn't quite work). But
> anyway that's for another patchset.

The idling is due to BQL contention related to interrupt handling. In the
case of ARM, this boils down to the GICv3 code being single-threaded.
I don't have time right now to make it multi-threaded, but at least we
know where the scalability bottleneck is.

BTW if there's interest I can submit the lock profiler to the list. The code
is in this branch:
  https://github.com/cota/qemu/tree/lock-profiler
The first commit has sample output: https://github.com/cota/qemu/commit/c5bda634

Also, any feedback on the parent (tb_lock removal) patchset would be appreciated.

To make the 2.11 merge easier, I rebased this patchset (as well as the
multi-tcg-v4 set it is based on) on top of rth's tcg-generic-15, fixing a good
bunch of annoying conflicts. The resulting branch is available at:
  https://github.com/cota/qemu/tree/tcg-generic-15%2Bmulti-tcg-v4-parallel

Thanks,

		Emilio
