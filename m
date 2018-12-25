Received: from eggs.gnu.org ([208.118.235.92]:33107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnKl-0001Is-BF
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnKh-0003fs-5A
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:23 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:50400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gbnKe-0003d3-6a
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:17 -0500
From: Fei Li <fli@suse.com>
Date: Tue, 25 Dec 2018 22:04:33 +0800
Message-Id: <20181225140449.15786-1-fli@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-4.0 v9 00/16] qemu_thread_create: propagate
 the error to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: lifei1214@126.com

Hi,

This idea comes from BiteSizedTasks, and this patch series implement
the error checking of qemu_thread_create: make qemu_thread_create
return a flag to indicate if it succeeded rather than failing with an
error; make all callers check it.

The first and the last patch fixes some segmentation faults occured
during the debugging.   The 6/7 patch modifies the
qemu_thread_create() by passing &error_abort and makes it return a
bool to all direct callers to indicate if it succeeds.   The next 9
patches will improve on &error_abort for callers who can handle more
properly.   The middle four fix some migration issues.

BTW, I am leaving my current company now, and will use
"Fei Li <shirley17fei@gmail.com>" to continue with this patch series.

Please help to review, thanks a lot! :)

v9:
- To ease the review and involve the appropriate maintainers, split
  the previous 6/7 patch into 10 patches: the 6/16 patch passes
  the &error_abort to qemu_thread_create() everywhere, and the next
  9 patches will improve on &error_abort for callers who need.
- Add a new patch 5/7 to unify error handling for
  process_incoming_migration_co().
- Merge the previous 2/7 to current 7/16 to collaboratively handle
  for qemu_X_start_vcpu and for the qemu_init_vpcu in each arch.
- Add comment for multifd_recv_new_channel() in current patch 2/7.

v8:
- Remove previous two patches trying to fix the multifd issue on the
  source side, as we are still waiting for maintainer's opinions.
- Use atomic_read to get multifd_recv_state->count in patch 3/7.
- Get three more "Reviewed-by:".

v7:
- Split the previous multifd-migration into two patches: the src and
  the dst. For the dst, only dump the error instead of quitting.
- Safely do the cleanup for postcopy_ram_enable_notify().
- Split the previous migration-error-handling patch into two patches.

v6:
- Add a new migration-multifd related patch. BTW, delete the previous
  vnc related patch as it has been upstreamed.
- Use error_setg_errno() to set the errno when qemu_thread_create()
  fails for both Linux and Windows implementation.
- Optimize the first patch, less codes are needed

v5:
- Remove `errno = err` in qemu_thread_create() for Linux, and change
  `return errno` to `return -1` in qemu_signal_init() to indicate
  the error in case qemu_thread_create() fails.
- Delete the v4-added qemu_cond/mutex_destroy() in iothread_complete()
  as the destroy() will be done by its callers' object_unref().

v4:
- Separate the migration compression patch from this series
- Add one more error handling patch related with migration
- Add more cleaning up code for touched functions

v3:
- Add two migration related patches to fix the segmentaion fault
- Extract the segmentation fault fix from v2's last patch to be a 
  separate patch

v2:
- Pass errp straightly instead of using a local_err & error_propagate
- Return a bool: false/true to indicate if one function succeeds
- Merge v1's last two patches into one to avoid the compile error
- Fix one omitted error in patch1 and update some error messages


Fei Li (16):
  Fix segmentation fault when qemu_signal_init fails
  migration: fix the multifd code when receiving less channels
  migration: remove unused &local_err parameter in multifd_save_cleanup
  migration: add more error handling for postcopy_ram_enable_notify
  migration: unify error handling for process_incoming_migration_co
  qemu_thread: Make qemu_thread_create() handle errors properly
  qemu_thread: supplement error handling for qemu_X_start_vcpu
  qemu_thread: supplement error handling for qmp_dump_guest_memory
  qemu_thread: supplement error handling for pci_edu_realize
  qemu_thread: supplement error handling for h_resize_hpt_prepare
  qemu_thread: supplement error handling for emulated_realize
  qemu_thread: supplement error handling for
    iothread_complete/qemu_signalfd_compat
  qemu_thread: supplement error handling for migration
  qemu_thread: supplement error handling for vnc_start_worker_thread
  qemu_thread: supplement error handling for touch_all_pages
  qemu_thread_join: fix segmentation fault

 accel/tcg/user-exec-stub.c      |  3 +-
 cpus.c                          | 79 ++++++++++++++++++++++++++---------------
 dump.c                          |  6 ++--
 hw/misc/edu.c                   |  7 ++--
 hw/ppc/spapr_hcall.c            | 10 ++++--
 hw/rdma/rdma_backend.c          |  3 +-
 hw/usb/ccid-card-emulated.c     | 14 +++++---
 include/qemu/thread.h           |  4 +--
 include/qom/cpu.h               |  2 +-
 io/task.c                       |  3 +-
 iothread.c                      | 16 ++++++---
 migration/channel.c             | 11 +++---
 migration/migration.c           | 68 ++++++++++++++++++++++-------------
 migration/migration.h           |  2 +-
 migration/postcopy-ram.c        | 15 ++++++--
 migration/ram.c                 | 68 ++++++++++++++++++++++++-----------
 migration/ram.h                 |  4 +--
 migration/savevm.c              | 12 +++++--
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
 ui/vnc.c                        |  4 ++-
 util/compatfd.c                 | 11 ++++--
 util/main-loop.c                |  8 ++---
 util/oslib-posix.c              | 24 ++++++++-----
 util/qemu-thread-posix.c        | 30 ++++++++++++----
 util/qemu-thread-win32.c        | 18 +++++++---
 util/rcu.c                      |  3 +-
 util/thread-pool.c              |  4 ++-
 55 files changed, 378 insertions(+), 170 deletions(-)

-- 
2.13.7
