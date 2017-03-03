Received: from eggs.gnu.org ([2001:4830:134:3::10]:54592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjmzO-0002Cr-QW
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:11:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjmzL-0007Ze-Li
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:11:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjmzL-0007Yz-DE
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:11:15 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  3 Mar 2017 14:11:08 +0100
Message-Id: <20170303131113.25898-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] tcg: fix icount super slowdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

icount has become much slower after tcg_cpu_exec has stopped
using the BQL.  There is also a latent bug that is masked by
the slowness.

The slowness happens because every occurrence of a QEMU_CLOCK_VIRTUAL
timer now has to wake up the I/O thread and wait for it.  The rendez-vous
is mediated by the BQL QemuMutex:

- handle_icount_deadline wakes up the I/O thread with BQL taken
- the I/O thread wakes up and waits on the BQL 
- the VCPU thread releases the BQL a little later
- the I/O thread raises an interrupt, which calls qemu_cpu_kick
- the VCPU thread notices the interrupt, takes the BQL to
  process it and waits on it

All this back and forth is extremely expensive, causing a 6 to 8-fold
slowdown when icount is turned on.

One may think that the issue is that the VCPU thread is too dependent
on the BQL, but then the latent bug comes in.  I first tried removing
the BQL completely from the x86 cpu_exec.  Every guest thern hung, and
the only way to fix it (and make everything slow again) was to add a dummy
BQL lock/unlock pair to qemu_tcg_wait_io_event.

This is because in -icount mode you really have to process the events
before the CPU restarts executing the next instruction.  Therefore, this
series moves the processing of QEMU_CLOCK_VIRTUAL timers straight in
the vCPU thread when running in icount mode.  This is only limited to the
main TimerListGroup.  QEMU_CLOCK_VIRTUAL timers in AioContexts still run
outside the vCPU thread.

With this change, icount mode is pretty much running as fast as in 2.8.
I tested the patches are on top of Alex's series with both x86 and aarch64
guests, but they should be pretty much independent.

The good thing is that the infrastructure to do this is basically
already there, in the form of QEMUTimerListNotifyCB.  It only needs to
be generalized a bit (patches 2 and 3) and bugfixed (patch 1 and 4---the
latter is necessary to avoid the "I/O thread spun for 1000 iterations
and consequent slowing down of vCPU thread).

The bad things are:

- I am not sure of what was different before the patch that removed the
BQL from tcg_cpu_exec (and I don't really have time to profile it right
now---I should not be fixing this in fact...).

- the solution sounds a bit ugly and it probably is---though the patch
itself is pretty small, adding only about 30 lines of new code.

Paolo

Paolo Bonzini (5):
  qemu-timer: fix off-by-one
  qemu-timer: do not include sysemu/cpus.h from util/qemu-timer.h
  cpus: define QEMUTimerListNotifyCB for QEMU system emulation
  main-loop: remove now unnecessary optimization
  icount: process QEMU_CLOCK_VIRTUAL timers in vCPU thread

 cpu-exec.c                   |  1 +
 cpus.c                       | 29 +++++++++++++++++++++++++++--
 hw/core/ptimer.c             |  1 +
 include/qemu/timer.h         | 29 ++++++++++++++++++++++++++---
 include/sysemu/cpus.h        |  3 +++
 kvm-all.c                    |  1 +
 monitor.c                    |  1 +
 replay/replay.c              |  1 +
 stubs/cpu-get-icount.c       |  6 ++++++
 tests/test-aio-multithread.c |  2 +-
 tests/test-aio.c             |  2 +-
 translate-all.c              |  1 +
 util/async.c                 |  2 +-
 util/main-loop.c             |  3 ++-
 util/qemu-timer.c            | 17 ++++++++++-------
 vl.c                         |  5 +----
 16 files changed, 84 insertions(+), 20 deletions(-)
