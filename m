Received: from eggs.gnu.org ([2001:4830:134:3::10]:47751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpL-0005yJ-HV
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpG-0005hd-K7
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpG-0005gr-E3
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:16 -0400
Message-Id: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 00/22] tcg: tb_lock removal
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

This series applies on top of the "multiple TCG contexts" series, v4:
  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06769.html

Highlights:

- First, fix a few typos I encountered while working on this (patches 1-3).
  I could send them separately to qemu-trivial if you prefer.
- QHT: use a proper cmp function, instead of just checking pointer values
  to determine equality of matches.
- Use a binary search tree for each TCG region.
- Make l1_map lockless by using cmpxchg
- Introduce page locks (for !user-mode), so that tb_lock is not
  needed when operating on a page
  - Introduce page_collection, to lock a range of pages
- Introduce tb->jmp_lock to protect TB jump lists.
- Remove tb_lock. User-mode uses just mmap_lock and tb->jmp_lock's;
  !user-mode uses the same jump locks as well as page locks.

Performance numbers are in patch 22. We get nice speedups, but I still
see a lot of idling when booting many cores. I suspect it comes from
cross-CPU events (e.g. TLB invalidations), but I need to profile it
better (perf is not good for this; mutrace doesn't quite work). But
anyway that's for another patchset.

You can fetch these changes from:
  https://github.com/cota/qemu/tree/multi-tcg-v4-parallel

Please review!

Thanks,

		Emilio

diffstat:

 accel/tcg/cpu-exec.c            |  58 +-
 accel/tcg/cputlb.c              |   8 -
 accel/tcg/translate-all.c       | 958 +++++++++++++++--------
 accel/tcg/translate-all.h       |   6 +-
 disas/arm.c                     |   2 +-
 docs/devel/multi-thread-tcg.txt |  21 +-
 exec.c                          |  25 +-
 include/exec/cpu-common.h       |   1 -
 include/exec/exec-all.h         |  86 +-
 include/exec/tb-context.h       |   4 -
 include/qemu/qht.h              |  36 +-
 linux-user/main.c               |   3 -
 linux-user/syscall.c            |   2 +-
 tcg/tcg.c                       | 205 +++++
 tcg/tcg.h                       |  13 +-
 tests/qht-bench.c               |  18 +-
 tests/test-qht.c                |  20 +-
 util/qht.c                      |  30 +-
 18 files changed, 1022 insertions(+), 474 deletions(-)
