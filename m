Received: from eggs.gnu.org ([2001:4830:134:3::10]:51474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTudi-0000E2-3f
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTudd-0002Ka-4F
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:06 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:43859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTudc-0002Jn-TI
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:01 -0400
Received: by mail-pg0-x234.google.com with SMTP id a14-v6so4852101pgw.10
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:44:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Jun 2018 09:43:35 -1000
Message-Id: <20180615194354.12489-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/19] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Since last:
  * fix clang build failure in patch 14,
  * include tb code gen overflow fix.


r~


Emilio G. Cota (17):
  qht: require a default comparison function
  qht: return existing entry when qht_insert fails
  tcg: track TBs with per-region BST's
  tcg: move tb_ctx.tb_phys_invalidate_count to tcg_ctx
  translate-all: iterate over TBs in a page with PAGE_FOR_EACH_TB
  translate-all: make l1_map lockless
  translate-all: remove hole in PageDesc
  translate-all: work page-by-page in tb_invalidate_phys_range_1
  translate-all: move tb_invalidate_phys_page_range up in the file
  translate-all: use per-page locking in !user-mode
  translate-all: add page_locked assertions
  translate-all: introduce assert_no_pages_locked
  translate-all: discard TB when tb_link_page returns an existing
    matching TB
  translate-all: protect TB jumps with a per-destination-TB lock
  cputlb: remove tb_lock from tlb_flush functions
  translate-all: remove tb_lock mention from cpu_restore_state_from_tb
  tcg: remove tb_lock

John Arbuckle (1):
  tcg/i386: Use byte form of xgetbv instruction

Richard Henderson (1):
  tcg: Reduce max TB opcode count

 accel/tcg/translate-all.h       |    6 +-
 include/exec/cpu-common.h       |    2 +-
 include/exec/exec-all.h         |   51 +-
 include/exec/memory-internal.h  |    6 +-
 include/exec/tb-context.h       |    4 -
 include/qemu/qht.h              |   32 +-
 tcg/tcg.h                       |   19 +-
 accel/tcg/cpu-exec.c            |   96 ++-
 accel/tcg/cputlb.c              |    8 -
 accel/tcg/translate-all.c       | 1045 +++++++++++++++++++++----------
 exec.c                          |   26 +-
 linux-user/main.c               |    3 -
 tcg/aarch64/tcg-target.inc.c    |    2 +-
 tcg/arm/tcg-target.inc.c        |    2 +-
 tcg/i386/tcg-target.inc.c       |    7 +-
 tcg/mips/tcg-target.inc.c       |    2 +-
 tcg/ppc/tcg-target.inc.c        |    4 +-
 tcg/s390/tcg-target.inc.c       |    2 +-
 tcg/sparc/tcg-target.inc.c      |    4 +-
 tcg/tcg.c                       |  218 ++++++-
 tcg/tci/tcg-target.inc.c        |    2 +-
 tests/qht-bench.c               |   18 +-
 tests/test-qht.c                |   23 +-
 util/qht.c                      |   41 +-
 docs/devel/multi-thread-tcg.txt |   24 +-
 25 files changed, 1157 insertions(+), 490 deletions(-)

-- 
2.17.1
