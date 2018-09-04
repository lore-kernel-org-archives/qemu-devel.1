Received: from eggs.gnu.org ([2001:4830:134:3::10]:50268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fx9DG-0001Gx-1c
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fx9DC-0006LM-SZ
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:37 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:55023)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fx9DC-0006K8-IL
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:34 -0400
From: Fei Li <fli@suse.com>
Date: Tue,  4 Sep 2018 19:08:17 +0800
Message-Id: <20180904110822.12863-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH 0/5] qemu_thread_create: propagate errors to
 callers to check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fli@suse.com

Hi,

This idea comes from BiteSizedTasks, and this patch series implement
the error checking of qemu_thread_create: make qemu_thread_create
return a flag to indicate if it succeeded rather than failing with an
error; make all callers check it.

The first three patches apply to those call traces whose further
callers already have the *errp to pass, thus add a new Error paramater
in the call trace to propagate the error and let the final caller
check it. The fourth patch is dedicated for qemu_thread_create().
The fifth patch updates the direct callers of qemu_thread_create.

Please help to review. Thanks.


Fei Li (5):
  Fix segmentation fault when qemu_signal_init fails
  ui/vnc.c: polish vnc_init_func
  qemu_init_vcpu: add a new Error paramater to propagate
  qemu_thread_create: propagate the error to callers to check
  Propagate qemu_thread_create's error to all callers to handle

 cpus.c                          | 80 ++++++++++++++++++++++++++++++-----------
 dump.c                          |  6 +++-
 hw/misc/edu.c                   |  8 ++++-
 hw/ppc/spapr_hcall.c            |  9 ++++-
 hw/rdma/rdma_backend.c          |  3 +-
 hw/usb/ccid-card-emulated.c     | 13 +++++--
 include/qemu/osdep.h            |  2 +-
 include/qemu/thread.h           |  2 +-
 include/qom/cpu.h               |  2 +-
 include/ui/console.h            |  2 +-
 io/task.c                       |  3 +-
 iothread.c                      | 15 +++++---
 migration/migration.c           | 47 +++++++++++++++++-------
 migration/postcopy-ram.c        | 11 +++++-
 migration/ram.c                 | 32 ++++++++++++++---
 migration/savevm.c              |  8 ++++-
 target/alpha/cpu.c              |  6 +++-
 target/arm/cpu.c                |  6 +++-
 target/cris/cpu.c               |  6 +++-
 target/hppa/cpu.c               |  6 +++-
 target/i386/cpu.c               |  6 +++-
 target/lm32/cpu.c               |  6 +++-
 target/m68k/cpu.c               |  6 +++-
 target/microblaze/cpu.c         |  6 +++-
 target/mips/cpu.c               |  6 +++-
 target/moxie/cpu.c              |  6 +++-
 target/nios2/cpu.c              |  6 +++-
 target/openrisc/cpu.c           |  6 +++-
 target/ppc/translate_init.inc.c |  6 +++-
 target/riscv/cpu.c              |  6 +++-
 target/s390x/cpu.c              |  5 ++-
 target/sh4/cpu.c                |  6 +++-
 target/sparc/cpu.c              |  6 +++-
 target/tilegx/cpu.c             |  6 +++-
 target/tricore/cpu.c            |  6 +++-
 target/unicore32/cpu.c          |  6 +++-
 target/xtensa/cpu.c             |  6 +++-
 tests/atomic_add-bench.c        |  3 +-
 tests/iothread.c                |  2 +-
 tests/qht-bench.c               |  3 +-
 tests/rcutorture.c              |  3 +-
 tests/test-aio.c                |  2 +-
 tests/test-rcu-list.c           |  3 +-
 ui/vnc-jobs.c                   | 13 +++++--
 ui/vnc-jobs.h                   |  2 +-
 ui/vnc.c                        | 15 ++++++--
 util/compatfd.c                 | 25 +++++++++----
 util/main-loop.c                | 11 +++---
 util/oslib-posix.c              | 10 +++++-
 util/qemu-thread-posix.c        | 15 +++++---
 util/qemu-thread-win32.c        | 12 +++++--
 util/rcu.c                      |  3 +-
 util/thread-pool.c              |  4 ++-
 53 files changed, 386 insertions(+), 108 deletions(-)

-- 
2.13.7
