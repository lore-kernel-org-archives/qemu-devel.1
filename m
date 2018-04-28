Received: from eggs.gnu.org ([2001:4830:134:3::10]:50847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fCL0L-0004ho-7q
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 04:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fCL0J-0003Np-Iq
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 04:14:49 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:34385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1fCL0J-0003NQ-C3
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 04:14:47 -0400
Received: by mail-io0-x241.google.com with SMTP id p124-v6so5088412iod.1
	for <qemu-devel@nongnu.org>; Sat, 28 Apr 2018 01:14:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFXrp_dOLnuoBEhL0eUJtobRWq7gjgAR8X48Xb3JeNx1J4eHEw@mail.gmail.com>
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
	<CAFXrp_dOLnuoBEhL0eUJtobRWq7gjgAR8X48Xb3JeNx1J4eHEw@mail.gmail.com>
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Sat, 28 Apr 2018 09:14:25 +0100
Message-ID: <CAFXrp_duZgS=rPwsEa0Gv_=LSz0r-t4Oj0VSPR-0wA0JRKsuBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Fwd: [RFC PATCH 00/17] reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Forgetting about debugging, I belive there is a deadlock in the replay
at 63d426dfa4fbfac3d50cda3f553cd975de2b85ea , but it is rare.

I have only reproduced it on ARM so far, and I haven't checked pre-patch.

The setup is https://github.com/cirosantilli/qemu-test/tree/6a3497f0d84e7c86ef80f7322e24e8a149b93214
with images-ab21ef58deed8536bc159c2afd680a4fabd68510.zip

Then try to run it several times with:

i=0; while true; do date; echo $i; ../qemu-test/arm/rr; i=$(($i+1)); done

I think the deadlock can happen in a few different places, but the
most common is when the kernel is doing disk related stuff, the last
messages before getting stuck are:

[   11.530325] ALSA device list:
[   11.531451]   No soundcards found.

and what would follow on a normal replay would be:

[   11.551904] EXT4-fs (vda): couldn't mount as ext3 due to feature
incompatibilities
[   11.619238] EXT4-fs (vda): mounted filesystem without journal. Opts: (null)

I then attach GDB with:

gdb -q ./arm-softmmu/qemu-system-arm `pgrep qemu`

and then:

>>> thread apply all bt

Thread 5 (Thread 0x7f59c6efb700 (LWP 22096)):
#0  0x00007f59e7aa9072 in futex_wait_cancelable (private=<optimized
out>, expected=0, futex_word=0x55a8e99801d8) at
../sysdeps/unix/sysv/linux/futex-internal.h:88
#1  0x00007f59e7aa9072 in __pthread_cond_wait_common (abstime=0x0,
mutex=0x55a8e89cbf40 <qemu_global_mutex>, cond=0x55a8e99801b0) at
pthread_cond_wait.c:502
#2  0x00007f59e7aa9072 in __pthread_cond_wait (cond=0x55a8e99801b0,
mutex=0x55a8e89cbf40 <qemu_global_mutex>) at pthread_cond_wait.c:655
#3  0x000055a8e7f4f178 in qemu_cond_wait_impl (cond=0x55a8e99801b0,
mutex=0x55a8e89cbf40 <qemu_global_mutex>, file=0x55a8e80b10a8
"/home/ciro/git/qemu/cpus.c", line=1175) at
util/qemu-thread-posix.c:164
#4  0x000055a8e7999965 in qemu_tcg_rr_wait_io_event
(cpu=0x55a8e986b330) at /home/ciro/git/qemu/cpus.c:1175
#5  0x000055a8e799a1f5 in qemu_tcg_rr_cpu_thread_fn
(arg=0x55a8e986b330) at /home/ciro/git/qemu/cpus.c:1502
#6  0x00007f59e7aa27fc in start_thread (arg=0x7f59c6efb700) at
pthread_create.c:465
#7  0x00007f59e77cfb5f in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 4 (Thread 0x7f59c76fc700 (LWP 22095)):
#0  0x00007f59e77c3a4b in __GI_ppoll (fds=0x7f59b8000b10, nfds=1,
timeout=<optimized out>, sigmask=0x0) at
../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x000055a8e7f4a02e in qemu_poll_ns (fds=0x7f59b8000b10, nfds=1,
timeout=-1) at util/qemu-timer.c:322
#2  0x000055a8e7f4cb5e in aio_poll (ctx=0x55a8e978eab0, blocking=true)
at util/aio-posix.c:629
#3  0x000055a8e7b5f084 in iothread_run (opaque=0x55a8e970c710) at
iothread.c:64
#4  0x00007f59e7aa27fc in start_thread (arg=0x7f59c76fc700) at
pthread_create.c:465
#5  0x00007f59e77cfb5f in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 3 (Thread 0x7f59ced65700 (LWP 22093)):
#0  0x00007f59e77c9a49 in syscall () at
../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x00007f59e88456ef in g_cond_wait () at
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#2  0x000055a8e7f43157 in wait_for_trace_records_available () at
trace/simple.c:150
#3  0x000055a8e7f431b8 in writeout_thread (opaque=0x0) at
trace/simple.c:169
#4  0x00007f59e8827645 in  () at
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#5  0x00007f59e7aa27fc in start_thread (arg=0x7f59ced65700) at
pthread_create.c:465
#6  0x00007f59e77cfb5f in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 2 (Thread 0x7f59cf566700 (LWP 22092)):
#0  0x00007f59e77c9a49 in syscall () at
../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x000055a8e7f4f5d8 in qemu_futex_wait (f=0x55a8e8e48418
<rcu_call_ready_event>, val=4294967295) at
/home/ciro/git/qemu/include/qemu/futex.h:29
#2  0x000055a8e7f4f79f in qemu_event_wait (ev=0x55a8e8e48418
<rcu_call_ready_event>) at util/qemu-thread-posix.c:445
#3  0x000055a8e7f67d2d in call_rcu_thread (opaque=0x0) at
util/rcu.c:261
#4  0x00007f59e7aa27fc in start_thread (arg=0x7f59cf566700) at
pthread_create.c:465
#5  0x00007f59e77cfb5f in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 1 (Thread 0x7f59ecf03280 (LWP 22091)):
#0  0x00007f59e77c3a4b in __GI_ppoll (fds=0x55a8e9860aa0, nfds=5,
timeout=<optimized out>, sigmask=0x0) at
../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x000055a8e7f4a0c4 in qemu_poll_ns (fds=0x55a8e9860aa0, nfds=5,
timeout=1000000000) at util/qemu-timer.c:334
#2  0x000055a8e7f4b176 in os_host_main_loop_wait (timeout=1000000000)
at util/main-loop.c:258
#3  0x000055a8e7f4b241 in main_loop_wait (nonblocking=0) at
util/main-loop.c:522
#4  0x000055a8e7b66fed in main_loop () at vl.c:1943
#5  0x000055a8e7b6ead4 in main (argc=24, argv=0x7fff6fe0f328,
envp=0x7fff6fe0f3f0) at vl.c:4740

On Wed, Apr 25, 2018 at 1:45 PM, Pavel Dovgalyuk
<Pavel.Dovgaluk@ispras.ru> wrote:
> GDB remote protocol supports reverse debugging of the targets.
> It includes 'reverse step' and 'reverse continue' operations.
> The first one finds the previous step of the execution,
> and the second one is intended to stop at the last breakpoint that
> would happen when the program is executed normally.
>
> Reverse debugging is possible in the replay mode, when at least
> one snapshot was created at the record or replay phase.
> QEMU can use these snapshots for travelling back in time with GDB.
>
> Running the execution in replay mode allows using GDB reverse debugging
> commands:
>  - reverse-stepi (or rsi): Steps one instruction to the past.
>    QEMU loads on of the prior snapshots and proceeds to the desired
>    instruction forward. When that step is reaches, execution stops.
>  - reverse-continue (or rc): Runs execution "backwards".
>    QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
>    and replaying the execution. Then QEMU loads snapshots again and
>    replays to the latest breakpoint. When there are no breakpoints in
>    the examined section of the execution, QEMU finds one more snapshot
>    and tries again. After the first snapshot is processed, execution
>    stops at this snapshot.
>
> The set of patches include the following modifications:
>  - gdbstub update for reverse debugging support
>  - functions that automatically perform reverse step and reverse
>    continue operations
>  - hmp/qmp commands for manipulating the replay process
>  - improvement of the snapshotting for saving the execution step
>    in the snapshot parameters
>  - other record/replay fixes
>
> The patches are available in the repository:
> https://github.com/ispras/qemu/tree/rr-180207
>
> ---
>
> Pavel Dovgalyuk (17):
>       block: implement bdrv_snapshot_goto for blkreplay
>       replay: disable default snapshot for record/replay
>       replay: update docs for record/replay with block devices
>       replay: don't drain/flush bdrv queue while RR is working
>       replay: finish record/replay before closing the disks
>       migration: introduce icount field for snapshots
>       qcow2: introduce icount field for snapshots
>       replay: introduce info hmp/qmp command
>       replay: introduce breakpoint at the specified step
>       replay: implement replay_seek command to proceed to the desired step
>       replay: flush events when exitting
>       timer: remove replay clock probe in deadline calculation
>       replay: refine replay-time module
>       translator: fix breakpoint processing
>       replay: flush rr queue before loading the vmstate
>       gdbstub: add reverse step support in replay mode
>       gdbstub: add reverse continue support in replay mode
>
>
>  accel/tcg/translator.c    |    8 +
>  block/blkreplay.c         |    8 +
>  block/io.c                |   22 +++
>  block/qapi.c              |   11 +-
>  block/qcow2-snapshot.c    |    9 +
>  block/qcow2.h             |    2
>  blockdev.c                |    3
>  cpus.c                    |   19 ++-
>  docs/replay.txt           |   12 +-
>  exec.c                    |    6 +
>  gdbstub.c                 |   50 +++++++-
>  hmp-commands-info.hx      |   14 ++
>  hmp-commands.hx           |   30 +++++
>  hmp.h                     |    3
>  include/block/snapshot.h  |    1
>  include/sysemu/replay.h   |   18 +++
>  migration/savevm.c        |   11 +-
>  qapi/block-core.json      |    5 +
>  qapi/block.json           |    3
>  qapi/misc.json            |   69 +++++++++++
>  replay/Makefile.objs      |    3
>  replay/replay-debugging.c |  286 +++++++++++++++++++++++++++++++++++++++++++++
>  replay/replay-events.c    |   14 --
>  replay/replay-internal.h  |   10 +-
>  replay/replay-time.c      |   27 ++--
>  replay/replay.c           |   22 +++
>  stubs/replay.c            |   10 ++
>  util/qemu-timer.c         |   11 --
>  vl.c                      |   11 +-
>  29 files changed, 625 insertions(+), 73 deletions(-)
>  create mode 100644 replay/replay-debugging.c
>
> --
> Pavel Dovgalyuk
