Received: from eggs.gnu.org ([2001:4830:134:3::10]:55251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gRQt6-00085S-Vj
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 19:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gRQt3-0007Hb-5I
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 19:06:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:58674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gRQt1-0007EE-7F
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 19:05:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gRQsu-0004gd-NK
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 00:05:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 462EC2E80CE
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 00:05:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Nov 2018 23:54:21 -0000
From: dann frazier <dann.frazier@canonical.com>
Reply-To: Bug 1805256 <1805256@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154327283728.15443.11625169757714443608.malonedeb@soybean.canonical.com>
Message-Id: <154327646188.15950.10914858047273642604.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1805256] Re: qemu-img hangs on high core count
 ARM system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ext4 filesystem, SATA drive:

(gdb) thread apply all bt

Thread 3 (Thread 0xffff9bffc9a0 (LWP 9015)):
#0  0x0000ffffaaa462cc in __GI___sigtimedwait (set=3D<optimized out>, =

    set@entry=3D0xaaaae725c070, info=3Dinfo@entry=3D0xffff9bffbf18, =

    timeout=3D0x3ff0000000000001, timeout@entry=3D0x0)
    at ../sysdeps/unix/sysv/linux/sigtimedwait.c:42
#1  0x0000ffffaab7dfac in __sigwait (set=3Dset@entry=3D0xaaaae725c070, =

    sig=3Dsig@entry=3D0xffff9bffbff4) at ../sysdeps/unix/sysv/linux/sigwait=
.c:28
#2  0x0000aaaad998a628 in sigwait_compat (opaque=3D0xaaaae725c070)
    at util/compatfd.c:36
#3  0x0000aaaad998bce0 in qemu_thread_start (args=3D<optimized out>)
    at util/qemu-thread-posix.c:498
#4  0x0000ffffaab73088 in start_thread (arg=3D0xffffc528531f)
    at pthread_create.c:463
#5  0x0000ffffaaae34ec in thread_start ()
    at ../sysdeps/unix/sysv/linux/aarch64/clone.S:78

Thread 2 (Thread 0xffffa0e779a0 (LWP 9014)):
#0  syscall () at ../sysdeps/unix/sysv/linux/aarch64/syscall.S:38
#1  0x0000aaaad998c9e8 in qemu_futex_wait (val=3D<optimized out>, f=3D<opti=
mized out>)
    at /home/ubuntu/qemu/include/qemu/futex.h:29
#2  qemu_event_wait (ev=3Dev@entry=3D0xaaaad9a091c0 <rcu_call_ready_event>)
    at util/qemu-thread-posix.c:442
#3  0x0000aaaad99a6834 in call_rcu_thread (opaque=3D<optimized out>)
    at util/rcu.c:261
#4  0x0000aaaad998bce0 in qemu_thread_start (args=3D<optimized out>)
    at util/qemu-thread-posix.c:498
#5  0x0000ffffaab73088 in start_thread (arg=3D0xffffc528542f)
    at pthread_create.c:463
#6  0x0000ffffaaae34ec in thread_start ()
    at ../sysdeps/unix/sysv/linux/aarch64/clone.S:78

Thread 1 (Thread 0xffffa0fa8010 (LWP 9013)):
#0  0x0000ffffaaada154 in __GI_ppoll (fds=3D0xaaaae7291dc0, nfds=3D18765077=
1816320, =

    timeout=3D<optimized out>, timeout@entry=3D0x0, sigmask=3D0xffffc52852e=
0)
    at ../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x0000aaaad9987f00 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<opt=
imized out>, =

    __fds=3D<optimized out>) at /usr/include/aarch64-linux-gnu/bits/poll2.h=
:77
#2  qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>, =

    timeout=3Dtimeout@entry=3D-1) at util/qemu-timer.c:322
#3  0x0000aaaad9988f80 in os_host_main_loop_wait (timeout=3D-1)
    at util/main-loop.c:233
#4  main_loop_wait (nonblocking=3D<optimized out>) at util/main-loop.c:497
#5  0x0000aaaad98b7a30 in convert_do_copy (s=3D0xffffc52854e8) at qemu-img.=
c:1980
#6  img_convert (argc=3D<optimized out>, argv=3D<optimized out>) at qemu-im=
g.c:2456
#7  0x0000aaaad98b033c in main (argc=3D7, argv=3D<optimized out>) at qemu-i=
mg.c:4975

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1805256

Title:
  qemu-img hangs on high core count ARM system

Status in QEMU:
  New

Bug description:
  On the HiSilicon D06 system - a 96 core NUMA arm64 box - qemu-img
  frequently hangs (~50% of the time) with this command:

  qemu-img convert -f qcow2 -O qcow2 /tmp/cloudimg /tmp/cloudimg2

  Where "cloudimg" is a standard qcow2 Ubuntu cloud image. This
  qcow2->qcow2 conversion happens to be something uvtool does every time
  it fetches images.

  Once hung, attaching gdb gives the following backtrace:

  (gdb) bt
  #0  0x0000ffffae4f8154 in __GI_ppoll (fds=3D0xaaaae8a67dc0, nfds=3D187650=
274213760, =

      timeout=3D<optimized out>, timeout@entry=3D0x0, sigmask=3D0xffffc123b=
950)
      at ../sysdeps/unix/sysv/linux/ppoll.c:39
  #1  0x0000aaaabbefaf00 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<o=
ptimized out>, =

      __fds=3D<optimized out>) at /usr/include/aarch64-linux-gnu/bits/poll2=
.h:77
  #2  qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>, =

      timeout=3Dtimeout@entry=3D-1) at util/qemu-timer.c:322
  #3  0x0000aaaabbefbf80 in os_host_main_loop_wait (timeout=3D-1)
      at util/main-loop.c:233
  #4  main_loop_wait (nonblocking=3D<optimized out>) at util/main-loop.c:497
  #5  0x0000aaaabbe2aa30 in convert_do_copy (s=3D0xffffc123bb58) at qemu-im=
g.c:1980
  #6  img_convert (argc=3D<optimized out>, argv=3D<optimized out>) at qemu-=
img.c:2456
  #7  0x0000aaaabbe2333c in main (argc=3D7, argv=3D<optimized out>) at qemu=
-img.c:4975

  Reproduced w/ latest QEMU git (@ 53744e0a182)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1805256/+subscriptions
