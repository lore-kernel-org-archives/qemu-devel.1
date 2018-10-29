Received: from eggs.gnu.org ([2001:4830:134:3::10]:50047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gH787-00007K-Pc
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gH782-0002Jy-Uv
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:58:51 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:42954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gH782-0002Ft-EM
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:58:46 -0400
From: Fei Li <fli@suse.com>
Date: Mon, 29 Oct 2018 20:58:11 +0800
Message-Id: <20181029125818.28720-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH RFC v6 0/7] qemu_thread_create: propagate
 errors to callers to check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, famz@redhat.com, peterx@redhat.com, quintela@redhat.com

Hi,

This idea comes from BiteSizedTasks, and this patch series implement
the error checking of qemu_thread_create: make qemu_thread_create
return a flag to indicate if it succeeded rather than failing with an
error; make all callers check it.

The first and the third patch fixes some segmentation faults occured
during the debugging.   The second patch paves the way for the last
patch as that patch is too long.   The last patch modifies the
qemu_thread_create() and makes it return a bool to all direct callers
to indicate if it succeeds.   The middle three fixes some migration
issues.

Please help to review, thanks. :)

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
- Add cleaning up code for touched functions
- Update some error messages

v2:
- Pass errp straightly instead of using a local_err & error_propagate
- Return a bool: false/true to indicate if one function succeeds
- Merge v1's last two patches into one to avoid the compile error
- Fix one omitted error in patch1 and update some error messages

Fei Li (7):
  Fix segmentation fault when qemu_signal_init fails
  qemu_init_vcpu: add a new Error parameter to propagate
  qemu_thread_join: fix segmentation fault
  migration: fix some segmentation faults when using multifd
  migration: fix the multifd code when receiving less channels
  migration: fix some error handling
  qemu_thread_create: propagate the error to callers to handle

 accel/tcg/user-exec-stub.c      |  3 +-
 cpus.c                          | 79 +++++++++++++++++++++-------------
 dump.c                          |  6 ++-
 hw/misc/edu.c                   |  6 ++-
 hw/ppc/spapr_hcall.c            | 10 ++++-
 hw/rdma/rdma_backend.c          |  4 +-
 hw/usb/ccid-card-emulated.c     | 13 ++++--
 include/qemu/thread.h           |  4 +-
 include/qom/cpu.h               |  2 +-
 io/task.c                       |  3 +-
 iothread.c                      | 16 ++++---
 migration/channel.c             |  7 +++-
 migration/migration.c           | 66 ++++++++++++++++++-----------
 migration/migration.h           |  2 +-
 migration/postcopy-ram.c        | 17 +++++++-
 migration/ram.c                 | 93 ++++++++++++++++++++++++++++++-----------
 migration/ram.h                 |  4 +-
 migration/savevm.c              | 11 +++--
 target/alpha/cpu.c              |  4 +-
 target/arm/cpu.c                |  4 +-
 target/cris/cpu.c               |  4 +-
 target/hppa/cpu.c               |  4 +-
 target/i386/cpu.c               |  4 +-
 target/lm32/cpu.c               |  4 +-
 target/m68k/cpu.c               |  4 +-
 target/microblaze/cpu.c         |  4 +-
 target/mips/cpu.c               |  4 +-
 target/moxie/cpu.c              |  4 +-
 target/nios2/cpu.c              |  4 +-
 target/openrisc/cpu.c           |  4 +-
 target/ppc/translate_init.inc.c |  4 +-
 target/riscv/cpu.c              |  4 +-
 target/s390x/cpu.c              |  4 +-
 target/sh4/cpu.c                |  4 +-
 target/sparc/cpu.c              |  4 +-
 target/tilegx/cpu.c             |  4 +-
 target/tricore/cpu.c            |  4 +-
 target/unicore32/cpu.c          |  4 +-
 target/xtensa/cpu.c             |  4 +-
 tests/atomic_add-bench.c        |  3 +-
 tests/iothread.c                |  2 +-
 tests/qht-bench.c               |  3 +-
 tests/rcutorture.c              |  3 +-
 tests/test-aio.c                |  2 +-
 tests/test-rcu-list.c           |  3 +-
 ui/vnc-jobs.c                   | 17 +++++---
 ui/vnc-jobs.h                   |  2 +-
 ui/vnc.c                        |  4 +-
 util/compatfd.c                 | 12 +++++-
 util/main-loop.c                |  8 ++--
 util/oslib-posix.c              | 17 ++++++--
 util/qemu-thread-posix.c        | 27 ++++++++----
 util/qemu-thread-win32.c        | 18 +++++---
 util/rcu.c                      |  3 +-
 util/thread-pool.c              |  4 +-
 55 files changed, 393 insertions(+), 165 deletions(-)

-- 
2.13.7
