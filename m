Received: from eggs.gnu.org ([2001:4830:134:3::10]:36787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyP-0006pw-OW
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyL-0005eQ-Nr
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:31:57 -0400
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:44023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTXyL-0005dz-FC
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:31:53 -0400
Received: by mail-pl0-x22f.google.com with SMTP id c41-v6so4064349plj.10
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:31:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Jun 2018 09:31:29 -1000
Message-Id: <20180614193147.29680-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/18] tcg queued patches
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

The following changes since commit 2ab09bf2f9f55b9fb8d2de6eb2ba2a8570e268e2:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180612-pull-request' into staging (2018-06-12 15:34:34 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20180614

for you to fetch changes up to ba3e9674da7b60ad627e122a6496d3e13f20c34f:

  tcg: remove tb_lock (2018-06-12 08:26:19 -1000)

----------------------------------------------------------------
Workaround macos assembler lossage.
Eliminate tb_lock.

----------------------------------------------------------------
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
      translate-all: discard TB when tb_link_page returns an existing matching TB
      translate-all: protect TB jumps with a per-destination-TB lock
      cputlb: remove tb_lock from tlb_flush functions
      translate-all: remove tb_lock mention from cpu_restore_state_from_tb
      tcg: remove tb_lock

John Arbuckle (1):
      tcg/i386: Use byte form of xgetbv instruction

 accel/tcg/translate-all.h       |    6 +-
 include/exec/cpu-common.h       |    2 +-
 include/exec/exec-all.h         |   51 +-
 include/exec/memory-internal.h  |    6 +-
 include/exec/tb-context.h       |    4 -
 include/qemu/qht.h              |   32 +-
 tcg/tcg.h                       |   13 +-
 accel/tcg/cpu-exec.c            |   96 ++--
 accel/tcg/cputlb.c              |    8 -
 accel/tcg/translate-all.c       | 1045 +++++++++++++++++++++++++++------------
 exec.c                          |   26 +-
 linux-user/main.c               |    3 -
 tcg/i386/tcg-target.inc.c       |    5 +-
 tcg/tcg.c                       |  205 ++++++++
 tests/qht-bench.c               |   18 +-
 tests/test-qht.c                |   23 +-
 util/qht.c                      |   41 +-
 docs/devel/multi-thread-tcg.txt |   24 +-
 18 files changed, 1131 insertions(+), 477 deletions(-)
