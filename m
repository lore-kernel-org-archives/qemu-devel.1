Received: from eggs.gnu.org ([2001:4830:134:3::10]:40222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gADIm-0000yh-88
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gADIg-0000TZ-UZ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:09:19 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:43642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gADIe-0000Ol-Si
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:09:14 -0400
From: Fei Li <fli@suse.com>
Date: Wed, 10 Oct 2018 20:08:34 +0800
Message-Id: <20181010120841.13214-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH RFC v5 0/7] qemu_thread_create: propagate
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
Cc: famz@redhat.com, peterx@redhat.com, armbru@redhat.com, berrange@redhat.com, quintela@redhat.com, dgilbert@redhat.com, eblake@redhat.com

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
The middle three fix some segmentation fault when using GDB to debug.

###### Here I have a concern about using multifd migration. ######
It is about "[PATCH RFC v4 5/7] migration: fix the multifd code".
In our current code, when multifd is used during migration, if there
is an error before the destination receives all new channels (I mean
multifd_recv_new_channel(ioc)), the destination does not exit but
keeps waiting (Hang in recvmsg() in qio_channel_socket_readv) until
the source exits. I know hang is not right, but so sorry that I did
not come up with a good idea on handling this. Not so familiar with
that part of code.. Hope @Juan could give a hand. Thanks!

Please help to review, thanks. :)

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
  ui/vnc.c: polish vnc_init_func
  qemu_init_vcpu: add a new Error parameter to propagate
  qemu_thread_join: fix segmentation fault
  migration: fix the multifd code
  migration: fix some error handling
  qemu_thread_create: propagate the error to callers to handle

 accel/tcg/user-exec-stub.c      |  2 +-
 cpus.c                          | 79 ++++++++++++++++++++++++++---------------
 dump.c                          |  6 ++--
 hw/misc/edu.c                   |  6 ++--
 hw/ppc/spapr_hcall.c            | 10 ++++--
 hw/rdma/rdma_backend.c          |  4 ++-
 hw/usb/ccid-card-emulated.c     | 13 ++++---
 include/qemu/osdep.h            |  2 +-
 include/qemu/thread.h           |  4 +--
 include/qom/cpu.h               |  2 +-
 include/ui/console.h            |  2 +-
 io/task.c                       |  3 +-
 iothread.c                      | 16 ++++++---
 migration/migration.c           | 54 ++++++++++++++++++----------
 migration/postcopy-ram.c        | 17 +++++++--
 migration/ram.c                 | 68 ++++++++++++++++++++++++-----------
 migration/ram.h                 |  2 +-
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
 util/compatfd.c                 | 18 +++++++---
 util/main-loop.c                | 11 +++---
 util/oslib-posix.c              | 17 ++++++---
 util/qemu-thread-posix.c        | 25 ++++++++-----
 util/qemu-thread-win32.c        | 18 +++++++---
 util/rcu.c                      |  3 +-
 util/thread-pool.c              |  4 ++-
 55 files changed, 366 insertions(+), 162 deletions(-)

-- 
2.13.7
