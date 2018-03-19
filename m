Received: from eggs.gnu.org ([2001:4830:134:3::10]:59634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1exr7s-0000lJ-K3
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1exr7n-0007xf-Mc
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:30:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:41456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1exr7n-0007xG-GQ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:30:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1exr7m-0004BD-Hx
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 09:30:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 86CC72E8054
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 09:30:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Mar 2018 09:16:05 -0000
From: Daniel Berrange <1756519@bugs.launchpad.net>
Reply-To: Bug 1756519 <1756519@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152127850171.4068.8714943507984957739.malonedeb@gac.canonical.com>
Message-Id: <152145096594.14674.8405436712568177792.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1756519] Re: qemu linux-user crash in QOM path
 canonicalization during do_fork() call to cpu_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Summary changed:

- qemu linux-user glib hash table crash in qom/object.c
+ qemu linux-user crash in QOM path canonicalization during do_fork() call =
to cpu_create

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1756519

Title:
  qemu linux-user crash in QOM path canonicalization during do_fork()
  call to cpu_create

Status in QEMU:
  New

Bug description:
  qemu-riscv64 version 2.11.50 (v2.11.0-2491-g2bb39a657a)  crashes
  running gcc libgomp.c/sort-1.c testsuite test case with the following
  message:

  (process:11683): GLib-CRITICAL **: g_hash_table_iter_next: assertion 'ri-=
>version =3D=3D ri->hash_table->version' failed
  **
  ERROR:qom/object.c:1665:object_get_canonical_path_component: code should =
not be reached
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6013=
9c16

  =

  Backtrace obtained via gdb:

  #0  raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.c:51
  #1  0x0000000060139b21 in abort () at abort.c:79
  #2  0x0000000060100505 in g_assertion_message (domain=3Ddomain@entry=3D0x=
0, file=3Dfile@entry=3D0x60213ca1 "qom/object.c", line=3Dline@entry=3D1665, =

      func=3Dfunc@entry=3D0x60214420 <__func__.18106> "object_get_canonical=
_path_component", message=3Dmessage@entry=3D0x7fffe8000cd0 "code should not=
 be reached")
      at gtestutils.c:2430
  #3  0x0000000060100586 in g_assertion_message_expr (domain=3D0x0, file=3D=
0x60213ca1 "qom/object.c", line=3D1665, =

      func=3D0x60214420 <__func__.18106> "object_get_canonical_path_compone=
nt", expr=3D<optimized out>) at gtestutils.c:2453
  #4  0x0000000060098334 in object_get_canonical_path_component (obj=3D0x7f=
ffe81340b0) at qom/object.c:1665
  #5  0x0000000060098366 in object_get_canonical_path (obj=3D0x7fffe81340b0=
) at qom/object.c:1675
  #6  0x000000006008e152 in device_set_realized (obj=3D0x7fffe81340b0, valu=
e=3Dtrue, errp=3D0x7ffff762fe68) at hw/core/qdev.c:874
  #7  0x0000000060098bf4 in property_set_bool (obj=3D0x7fffe81340b0, v=3D0x=
7fffe80fd3c0, name=3D0x60213694 "realized", opaque=3D0x7fffe80fd140, errp=
=3D0x7ffff762fe68)
      at qom/object.c:1926
  #8  0x0000000060096fee in object_property_set (obj=3D0x7fffe81340b0, v=3D=
0x7fffe80fd3c0, name=3D0x60213694 "realized", errp=3D0x7ffff762fe68) at qom=
/object.c:1122
  #9  0x0000000060099ebd in object_property_set_qobject (obj=3D0x7fffe81340=
b0, value=3D0x7fffe80fd310, name=3D0x60213694 "realized", errp=3D0x7ffff762=
fe68)
      at qom/qom-qobject.c:27
  #10 0x0000000060097274 in object_property_set_bool (obj=3D0x7fffe81340b0,=
 value=3Dtrue, name=3D0x60213694 "realized", errp=3D0x7ffff762fe68) at qom/=
object.c:1191
  #11 0x0000000060092ec5 in cpu_create (typename=3D0x6250e1a0 "any-riscv-cp=
u") at qom/cpu.c:61
  #12 0x000000006009301a in cpu_generic_init (typename=3D0x601dd58f "riscv-=
cpu", cpu_model=3D0x601dd527 "any") at qom/cpu.c:98
  #13 0x000000006004cb61 in cpu_copy (env=3D0x7ffff008cd60) at /opt/qemu/li=
nux-user/main.c:3881
  #14 0x000000006005b79a in do_fork (env=3D0x7ffff008cd60, flags=3D4001536,=
 newsp=3D275531880704, parent_tidptr=3D275531882704, newtls=3D275531884288, =

      child_tidptr=3D275531882704) at /opt/qemu/linux-user/syscall.c:6348
  #15 0x0000000060063e56 in do_syscall (cpu_env=3D0x7ffff008cd60, num=3D220=
, arg1=3D4001536, arg2=3D275531880704, arg3=3D275531882704, arg4=3D27553188=
4288, =

      arg5=3D275531882704, arg6=3D275531884288, arg7=3D0, arg8=3D0) at /opt=
/qemu/linux-user/syscall.c:10001
  #16 0x000000006004c89f in cpu_loop (env=3D0x7ffff008cd60) at /opt/qemu/li=
nux-user/main.c:3600
  #17 0x000000006005b68f in clone_func (arg=3D0x7ffff7775050) at /opt/qemu/=
linux-user/syscall.c:6311
  #18 0x0000000060121797 in start_thread (arg=3D0x7ffff7632700) at pthread_=
create.c:463
  #19 0x000000006019b4fb in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95

  =

  Attached is a test case source code extracted from libgomp test suite.

  Note that it is a multi-threaded and requires 5 or more threads to
  fail. Number of launched threads is controlled by OMP_NUM_THREADS
  evironment variable, defaulting to number of hardware threads.
  Changing constants in the test case makes it fail with different
  numbers of threads.

  I will attach statically linked riscv64 binary executable if size
  limits permit.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1756519/+subscriptions
