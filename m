Received: from eggs.gnu.org ([209.51.188.92]:46116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hHfGt-0007qt-Jv
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 21:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hHfEE-0005fc-NI
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 21:55:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:52274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hHfEE-0005dk-HP
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 21:55:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hHfEC-0007kG-Q3
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 01:55:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C1C9D2E80C7
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 01:55:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Apr 2019 01:46:59 -0000
From: =?utf-8?b?6LSe6LS15p2O?= <1824053@bugs.launchpad.net>
Reply-To: Bug 1824053 <1824053@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155486495593.20543.13567634487304856304.malonedeb@chaenomeles.canonical.com>
Message-Id: <155572482105.16887.16306481647202878247.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1824053] Re: Qemu-img convert appears to be stuck
 on aarch64 host with low probability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Released =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824053

Title:
  Qemu-img convert appears to be stuck on aarch64 host with low
  probability

Status in QEMU:
  Confirmed

Bug description:
  Hi,  I found a problem that qemu-img convert appears to be stuck on
  aarch64 host with low probability.

  The convert command  line is  "qemu-img convert -f qcow2 -O raw
  disk.qcow2 disk.raw ".

  The bt is below:

  Thread 2 (Thread 0x40000b776e50 (LWP 27215)):
  #0  0x000040000a3f2994 in sigtimedwait () from /lib64/libc.so.6
  #1  0x000040000a39c60c in sigwait () from /lib64/libpthread.so.0
  #2  0x0000aaaaaae82610 in sigwait_compat (opaque=3D0xaaaac5163b00) at uti=
l/compatfd.c:37
  #3  0x0000aaaaaae85038 in qemu_thread_start (args=3Dargs@entry=3D0xaaaac5=
163b90) at util/qemu_thread_posix.c:496
  #4  0x000040000a3918bc in start_thread () from /lib64/libpthread.so.0
  #5  0x000040000a492b2c in thread_start () from /lib64/libc.so.6

  Thread 1 (Thread 0x40000b573370 (LWP 27214)):
  #0  0x000040000a489020 in ppoll () from /lib64/libc.so.6
  #1  0x0000aaaaaadaefc0 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<o=
ptimized out>, __fds=3D<optimized out>) at /usr/include/bits/poll2.h:77
  #2  qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>, timeout=
=3D<optimized out>) at qemu_timer.c:391
  #3  0x0000aaaaaadae014 in os_host_main_loop_wait (timeout=3D<optimized ou=
t>) at main_loop.c:272
  #4  0x0000aaaaaadae190 in main_loop_wait (nonblocking=3D<optimized out>) =
at main_loop.c:534
  #5  0x0000aaaaaad97be0 in convert_do_copy (s=3D0xffffdc32eb48) at qemu-im=
g.c:1923
  #6  0x0000aaaaaada2d70 in img_convert (argc=3D<optimized out>, argv=3D<op=
timized out>) at qemu-img.c:2414
  #7  0x0000aaaaaad99ac4 in main (argc=3D7, argv=3D<optimized out>) at qemu=
-img.c:5305

  =

  The problem seems to be very similar to the phenomenon described by this =
patch (https://resources.ovirt.org/pub/ovirt-4.1/src/qemu-kvm-ev/0025-aio_n=
otify-force-main-loop-wakeup-with-SIGIO-aarch64.patch), =


  which force main loop wakeup with SIGIO.  But this patch was reverted
  by the patch (http://ovirt.repo.nfrance.com/src/qemu-kvm-ev/kvm-
  Revert-aio_notify-force-main-loop-wakeup-with-SIGIO-.patch).

  The problem still seems to exist in aarch64 host. The qemu version I used=
 is 2.8.1. The host version is 4.19.28-1.2.108.aarch64.
   Do you have any solutions to fix it?  Thanks for your reply !

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824053/+subscriptions
