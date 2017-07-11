Received: from eggs.gnu.org ([2001:4830:134:3::10]:36105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dV1Zb-0005B1-C0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dV1Za-0004wK-3z
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:52048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dV1ZZ-0004w0-UC
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dV1ZY-0001YB-BC
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 20:15:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4D3452E8193
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 20:15:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Jul 2017 19:58:23 -0000
From: Thomas Huth <1094950@bugs.launchpad.net>
Reply-To: Bug 1094950 <1094950@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121231204645.26308.5533.malonedeb@soybean.canonical.com>
Message-Id: <149980310352.15177.895793254767450065.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1094950] Re: crash at qemu_iohandler_poll
 (iohandler.c:124) on macos 10.8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem wit the latest release of QEMU
(currently version 2.9.0) and macOS, or could we close this bug
nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1094950

Title:
  crash at  qemu_iohandler_poll (iohandler.c:124) on macos 10.8.2

Status in QEMU:
  Incomplete

Bug description:
  I'm seeing consistent hangs / crashes on MacOS 10.8.2 with 1.3.0.
  I've tried both gcc-4.2 and clang.  I've tried a half a dozen
  different images/kernels.

  I configured qemu like this:

  ./configure --disable-sdl --disable-kvm --enable-cocoa --cc=3Dgcc-4.2
  --host-cc=3Dgcc-4.2 --enable-debug   --extra-cflags=3D-g   --extra-
  ldflags=3D-g

  And ran it like this:

  qemu-system-arm -nographic -M versatilepb -kernel
  vmlinuz-2.6.32-5-versatile -initrd initrd.img-2.6.32-5-versatile -hda
  debian_squeeze_armel_standard.qcow2 -append "root=3D/dev/sda1
  console=3DttyAMA0"

  With images, kernel, and initrd described here:

  http://psellos.com/2012/08/2012.08.qemu-arm-osx.html

  And I get:

  Program received signal EXC_BAD_ACCESS, Could not access memory.
  Reason: KERN_PROTECTION_FAILURE at address: 0x000000010142f2d0
  0x000000010142f2d0 in ?? ()

  (gdb) bt
  #0  0x000000010142f2d0 in ?? ()
  #1  0x000000010016e209 in qemu_iohandler_poll (readfds=3D0x10097ca00, wri=
tefds=3D0x10097ca80, xfds=3D0x10097cb00, ret=3D4) at iohandler.c:124
  #2  0x0000000100172acf in main_loop_wait (nonblocking=3D0) at main-loop.c=
:418
  #3  0x0000000100207bbf in main_loop () at vl.c:1765
  #4  0x000000010020e7b0 in qemu_main (argc=3D12, argv=3D0x7fff5fbff360, en=
vp=3D0x7fff5fbff3c8) at vl.c:3992
  #5  0x00000001001d6013 in main (argc=3D12, argv=3D0x7fff5fbff360) at ui/c=
ocoa.m:884
  (gdb) frame 1
  #1  0x000000010016e209 in qemu_iohandler_poll (readfds=3D0x10097ca00, wri=
tefds=3D0x10097ca80, xfds=3D0x10097cb00, ret=3D4) at iohandler.c:124
  124	                ioh->fd_read(ioh->opaque);
  Current language:  auto; currently c
  (gdb) p ioh
  $1 =3D (IOHandlerRecord *) 0x10142f110
  (gdb) p *ioh
  $2 =3D {
    fd_read_poll =3D 0, =

    fd_read =3D 0x10017212b <sigfd_handler>, =

    fd_write =3D 0, =

    opaque =3D 0x3, =

    next =3D {
      le_next =3D 0x0, =

      le_prev =3D 0x105d00bc0
    }, =

    fd =3D 3, =

    deleted =3D false
  }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1094950/+subscriptions
