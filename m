Received: from eggs.gnu.org ([2001:4830:134:3::10]:57179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cmNzB-0004E6-Rv
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 12:05:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cmNz8-0007Us-7m
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 12:05:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:50909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cmNz7-0007U4-Uo
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 12:05:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cmNz7-0000en-1z
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 17:05:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F13A42E80C2
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 17:05:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Mar 2017 16:54:19 -0000
From: Mohammed Gamal <m.gamal005@gmail.com>
Reply-To: Bug 1671876 <1671876@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170310164750.14977.41006.malonedeb@soybean.canonical.com>
Message-Id: <20170310165419.23367.51404.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1671876] Re: qemu 2.7.0 segfaults in
 qemu_co_queue_run_restart()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Another stack trace

---------------------------------------------------------------------
(gdb) bt
#0  qemu_co_queue_run_restart (co=3D0x7f668be15260) at /build/pb-qemu-pssKU=
p/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:59
#1  0x0000564cb19f59a9 in qemu_coroutine_enter (co=3D0x7f668be15260) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#2  0x0000564cb19f5fa0 in qemu_co_enter_next (queue=3Dqueue@entry=3D0x564cb=
35e55e0) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:=
106
#3  0x0000564cb1994060 in timer_cb (blk=3D0x564cb35e5590, is_write=3D<optim=
ized out>) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/block/throttle-groups.c:4=
00
#4  0x0000564cb1951615 in timerlist_run_timers (timer_list=3D0x564cb3651e80=
) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/qemu-timer.c:528
#5  0x0000564cb1951679 in timerlistgroup_run_timers (tlg=3Dtlg@entry=3D0x56=
4cb487fcf8) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/qemu-timer.c:564
#6  0x0000564cb1951f47 in aio_dispatch (ctx=3Dctx@entry=3D0x564cb487fbb0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/aio-posix.c:357
#7  0x0000564cb19520e8 in aio_poll (ctx=3D0x564cb487fbb0, blocking=3D<optim=
ized out>) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/aio-posix.c:479
#8  0x0000564cb17b3c79 in iothread_run (opaque=3D0x564cb487f960) at /build/=
pb-qemu-pssKUp/pb-qemu-2.7.0/iothread.c:46
#9  0x00007f684b0b30a4 in allocate_stack (stack=3D<synthetic pointer>, pdp=
=3D<synthetic pointer>, attr=3D0x0) at allocatestack.c:416
#10 __pthread_create_2_1 (newthread=3D<error reading variable: Cannot acces=
s memory at address 0xffffffffffffff48>, attr=3D<error reading variable: Ca=
nnot access memory at address 0xffffffffffffff40>, =

    start_routine=3D<error reading variable: Cannot access memory at addres=
s 0xffffffffffffff58>, arg=3D<error reading variable: Cannot access memory =
at address 0xffffffffffffff50>) at pthread_create.c:539
Backtrace stopped: Cannot access memory at address 0x8
---------------------------------------------------------------------------=
--------------------


Here is a bit of examination of the data
---------------------------------------------------------------------------=
--------------------
(gdb) print *(&co->co_queue_wakeup->sqh_first)
$1 =3D (struct Coroutine *) 0xc54b578
(gdb) print *(&co->co_queue_wakeup->sqh_first->co_queue_next)
Cannot access memory at address 0xc54b5a8
---------------------------------------------------------------------------=
--------------------

Again seems to be pointing at an invalid address. It's worth noting here
that it the number of restarted and re-run co-routines is much smaller.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1671876

Title:
  qemu 2.7.0 segfaults in qemu_co_queue_run_restart()

Status in QEMU:
  New

Bug description:
  Hi,

  I've been experiencing frequent segfaults lately with qemu 2.7.0
  running Ubuntu 16.04 guests. The crash usually happens in
  qemu_co_queue_run_restart(). I haven't seen this so far with any other
  guests or distros.

  Here is one back trace I obtained from one of the crashing VMs.

  --------------------------------------------------------------------------
  (gdb) bt
  #0  qemu_co_queue_run_restart (co=3D0x7fba8ff05aa0) at /build/pb-qemu-pss=
KUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:59
  #1  0x000055c1656f39a9 in qemu_coroutine_enter (co=3D0x7fba8ff05aa0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #2  0x000055c1656f3e74 in qemu_co_queue_run_restart (co=3D0x7fba8dd20430)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #3  0x000055c1656f39a9 in qemu_coroutine_enter (co=3D0x7fba8dd20430) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #4  0x000055c1656f3e74 in qemu_co_queue_run_restart (co=3D0x7fba8dd14ea0)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #5  0x000055c1656f39a9 in qemu_coroutine_enter (co=3D0x7fba8dd14ea0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #6  0x000055c1656f3e74 in qemu_co_queue_run_restart (co=3D0x7fba80c11dc0)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #7  0x000055c1656f39a9 in qemu_coroutine_enter (co=3D0x7fba80c11dc0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #8  0x000055c1656f3e74 in qemu_co_queue_run_restart (co=3D0x7fba8dd0bd70)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #9  0x000055c1656f39a9 in qemu_coroutine_enter (co=3D0x7fba8dd0bd70) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #10 0x000055c1656f3fa0 in qemu_co_enter_next (queue=3Dqueue@entry=3D0x55c=
1669e75e0) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.=
c:106
  #11 0x000055c165692060 in timer_cb (blk=3D0x55c1669e7590, is_write=3D<opt=
imized out>) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/block/throttle-groups.c=
:400
  #12 0x000055c16564f615 in timerlist_run_timers (timer_list=3D0x55c166a53e=
80) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/qemu-timer.c:528
  #13 0x000055c16564f679 in timerlistgroup_run_timers (tlg=3Dtlg@entry=3D0x=
55c167c81cf8) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/qemu-timer.c:564
  #14 0x000055c16564ff47 in aio_dispatch (ctx=3Dctx@entry=3D0x55c167c81bb0)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/aio-posix.c:357
  #15 0x000055c1656500e8 in aio_poll (ctx=3D0x55c167c81bb0, blocking=3D<opt=
imized out>) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/aio-posix.c:479
  #16 0x000055c1654b1c79 in iothread_run (opaque=3D0x55c167c81960) at /buil=
d/pb-qemu-pssKUp/pb-qemu-2.7.0/iothread.c:46
  #17 0x00007fbc4b64f0a4 in allocate_stack (stack=3D<synthetic pointer>, pd=
p=3D<synthetic pointer>, attr=3D0x0) at allocatestack.c:416
  #18 __pthread_create_2_1 (newthread=3D<error reading variable: Cannot acc=
ess memory at address 0xffffffffffffff48>, attr=3D<error reading variable: =
Cannot access memory at address 0xffffffffffffff40>,
  =C2=A0=C2=A0=C2=A0=C2=A0start_routine=3D<error reading variable: Cannot a=
ccess memory at address 0xffffffffffffff58>, arg=3D<error reading variable:=
 Cannot access memory at address 0xffffffffffffff50>) at pthread_create.c:5=
39
  Backtrace stopped: Cannot access memory at address 0x8
  --------------------------------------------------------------------------

  The code that crashes is this
  --------------------------------------------------------------------------
  void qemu_co_queue_run_restart(Coroutine *co)
  {
  =C2=A0=C2=A0=C2=A0=C2=A0Coroutine *next;

  =C2=A0=C2=A0=C2=A0=C2=A0trace_qemu_co_queue_run_restart(co);
  =C2=A0=C2=A0=C2=A0=C2=A0while ((next =3D QSIMPLEQ_FIRST(&co->co_queue_wak=
eup))) {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QSIMPLEQ_REMOVE_HEAD(&co-=
>co_queue_wakeup, co_queue_next);       <--- Crash occurs here this time
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_coroutine_enter(next=
);
  =C2=A0=C2=A0=C2=A0=C2=A0}
  }
  --------------------------------------------------------------------------

  Expanding the macro QSIMPLEQ_REMOVE_HEAD gives us
  --------------------------------------------------------------------------
  #define QSIMPLEQ_REMOVE_HEAD(head, field) do {                          \
  =C2=A0=C2=A0=C2=A0=C2=A0if (((head)->sqh_first =3D (head)->sqh_first->fie=
ld.sqe_next) =3D=3D NULL)\
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(head)->sqh_last =3D &(he=
ad)->sqh_first;                          \
  } while (/*CONSTCOND*/0)
  --------------------------------------------------------------------------

  which corrsponds to
  --------------------------------------------------------------------------
  if (((&co->co_queue_wakeup)->sqh_first =3D (&co->co_queue_wakeup)->sqh_fi=
rst->co_queue_next.sqe_next) =3D=3D NULL)\
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(&co->co_queue_wakeup)->s=
qh_last =3D &(&co->co_queue_wakeup)->sqh_first;
  --------------------------------------------------------------------------

  Debugging the list we see
  --------------------------------------------------------------------------
  (gdb) print *(&co->co_queue_wakeup->sqh_first)
  $6 =3D (struct Coroutine *) 0x1000
  (gdb) print *(&co->co_queue_wakeup->sqh_first->co_queue_next)
  Cannot access memory at address 0x1030
  --------------------------------------------------------------------------

  So the data in co->co_queue_wakeup->sqh_first is corrupted and
  represents an invalid address. Any idea why is that?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1671876/+subscriptions
