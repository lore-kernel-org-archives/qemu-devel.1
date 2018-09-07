Received: from eggs.gnu.org ([2001:4830:134:3::10]:44338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fyGz1-00065O-OC
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fyGyw-0005RX-NX
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:39:35 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:34326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fyGyw-0005QM-DF
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:39:30 -0400
From: Fei Li <fli@suse.com>
Date: Fri,  7 Sep 2018 21:38:58 +0800
Message-Id: <20180907133902.28462-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH v2 0/4] qemu_thread_create: propagate errors to
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
Cc: berrange@redhat.com, famz@redhat.com, armbru@redhat.com, eblake@redhat.com, fli@suse.com

Hi,

This idea comes from BiteSizedTasks, and this patch series implement
the error checking of qemu_thread_create: make qemu_thread_create
return a flag to indicate if it succeeded rather than failing with an
error; make all callers check it.

The first three patches apply to those call traces whose further
callers already have the *errp to pass, thus add a new Error paramater
in the call trace to propagate the error and let the further caller
check it. The last patch modifies the qemu_thread_create() and makes
it return a bool to all direct callers to indicate if it succeeds.

v2:
- Pass errp straightly instead of using a local_err & error_propagate
- Return a bool: false/true to indicate if one function succeeds
- Merge v1's last two patches into one to avoid the compling error
- Fix one omitted error in patch1 and update some error messages

Please help to review. Thanks.


Fei Li (4):
  Fix segmentation fault when qemu_signal_init fails
  ui/vnc.c: polish vnc_init_func
  qemu_init_vcpu: add a new Error parameter to propagate
  qemu_thread_create: propagate the error to callers to handle

 accel/tcg/user-exec-stub.c      |  2 +-
 cpus.c                          | 79 ++++++++++++++++++++++++++---------------
 dump.c                          |  6 ++--
 hw/misc/edu.c                   |  6 ++--
 hw/ppc/spapr_hcall.c            |  9 +++--
 hw/rdma/rdma_backend.c          |  3 +-
 hw/usb/ccid-card-emulated.c     | 13 ++++---
 include/qemu/osdep.h            |  2 +-
 include/qemu/thread.h           |  4 +--
 include/qom/cpu.h               |  2 +-
 include/ui/console.h            |  2 +-
 io/task.c                       |  3 +-
 iothread.c                      | 16 ++++++---
 migration/migration.c           | 49 +++++++++++++++++--------
 migration/postcopy-ram.c        | 12 +++++--
 migration/ram.c                 | 40 +++++++++++++++------
 migration/savevm.c              | 11 ++++--
 target/alpha/cpu.c              |  4 ++-
 target/arm/cpu.c                |  4 ++-
 target/cris/cpu.c               |  4 ++-
 target/hppa/cpu.c               |  4 ++-
 target/i386/cpu.c               |  4 ++-
 target/lm32/cpu.c               |  4 ++-
 target/m68k/cpu.c               |  4 ++-
 target/microblaze/cpu.c         |  4 ++-
 target/mips/cpu.c               |  4 ++-
 target/moxie/cpu.c              |  4 ++-
 target/nios2/cpu.c              |  4 ++-
 target/openrisc/cpu.c           |  4 ++-
 target/ppc/translate_init.inc.c |  4 ++-
 target/riscv/cpu.c              |  4 ++-
 target/s390x/cpu.c              |  4 ++-
 target/sh4/cpu.c                |  4 ++-
 target/sparc/cpu.c              |  4 ++-
 target/tilegx/cpu.c             |  4 ++-
 target/tricore/cpu.c            |  4 ++-
 target/unicore32/cpu.c          |  4 ++-
 target/xtensa/cpu.c             |  4 ++-
 tests/atomic_add-bench.c        |  3 +-
 tests/iothread.c                |  2 +-
 tests/qht-bench.c               |  3 +-
 tests/rcutorture.c              |  3 +-
 tests/test-aio.c                |  2 +-
 tests/test-rcu-list.c           |  3 +-
 ui/vnc-jobs.c                   | 17 ++++++---
 ui/vnc-jobs.h                   |  2 +-
 ui/vnc.c                        | 12 +++++--
 util/compatfd.c                 | 16 ++++++---
 util/main-loop.c                | 10 +++---
 util/oslib-posix.c              | 12 +++++--
 util/qemu-thread-posix.c        | 18 ++++++----
 util/qemu-thread-win32.c        | 15 +++++---
 util/rcu.c                      |  3 +-
 util/thread-pool.c              |  4 ++-
 54 files changed, 325 insertions(+), 143 deletions(-)

-- 
2.13.7
