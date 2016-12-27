Received: from eggs.gnu.org ([2001:4830:134:3::10]:49344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cLjOg-0006yV-0Z
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 23:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cLjOb-0001DL-3v
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 23:29:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:37017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cLjOa-0001D2-TD
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 23:29:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cLjOZ-0007W7-0K
	for <qemu-devel@nongnu.org>; Tue, 27 Dec 2016 04:29:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B03632E80DE
	for <qemu-devel@nongnu.org>; Tue, 27 Dec 2016 04:29:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Dec 2016 04:17:32 -0000
From: Launchpad Bug Tracker <974229@bugs.launchpad.net>
Reply-To: Bug 974229 <974229@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120405131052.2192.6517.malonedeb@gac.canonical.com>
Message-Id: <20161227041733.3765.6073.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 974229] Re: qemu-kvm-1.0: segfault using
 vnc-console => not threadsafe!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/974229

Title:
  qemu-kvm-1.0: segfault using vnc-console =3D> not threadsafe!

Status in QEMU:
  Expired
Status in qemu-kvm package in Ubuntu:
  Invalid

Bug description:
  after failure using qemu-kvm-0.14.1 I've tried v1.0, but there's a
  problem if compiled with vnc-thread-support:

  Program received signal SIGSEGV, Segmentation fault.
  0x0000000000000000 in ?? ()
  (gdb) bt
  #0  0x0000000000000000 in ?? ()
  #1  0x00007f3ac48ca10a in qemu_iohandler_poll (readfds=3D0x7fff12379ac0, =
writefds=3D0x7fff12379b40, xfds=3D0x7fff12379bc0, ret=3D3)
      at iohandler.c:124
  #2  0x00007f3ac4964387 in main_loop_wait (nonblocking=3D0) at main-loop.c=
:463
  #3  0x00007f3ac4958fb1 in main_loop () at /opt/workspace/oneiric64/qemu-k=
vm-1.0/vl.c:1482
  #4  0x00007f3ac495e1ec in main (argc=3D68, argv=3D0x7fff1237a088, envp=3D=
0x7fff1237a2b0)
      at /opt/workspace/oneiric64/qemu-kvm-1.0/vl.c:3523
  (gdb) up
  #1  0x00007f3ac48ca10a in qemu_iohandler_poll (readfds=3D0x7fff12379ac0, =
writefds=3D0x7fff12379b40, xfds=3D0x7fff12379bc0, ret=3D3)
      at iohandler.c:124
  124	                ioh->fd_write(ioh->opaque);

  (gdb) print *ioh
  $4 =3D {fd =3D 29, fd_read_poll =3D 0, fd_read =3D 0x7f3ac49de158 <vnc_cl=
ient_read>, fd_write =3D 0, deleted =3D 0, =

    opaque =3D 0x7f3ac7978d50, next =3D {le_next =3D 0x7f3ac6add2e0, le_pre=
v =3D 0x7f3ac52bde90}}

  =

  ok, how could that happen?
  loooking deeper at the code and backtraces shows, that iohandler.c:124 is=
 called within the main-loop, while iohandler.c:77 is called within the vnc=
-thread-loop

  mmmh, but where the hell is the threadsafe-locking of the ioh-
  structure????

  I didn't found anything...

  the resetting in line 77 is called from vnc_client_write_plain(),
  where following code can be found:

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
     if (vs->output.offset =3D=3D 0) {
          qemu_set_fd_handler2(vs->csock, NULL, vnc_client_read, NULL, vs);
      }
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  why should the function-ptrs should be zeroed?

  further tracing shows, that the vnc-thread sometimes seems to exits
  normally and a new one is started (I haven't verified that), but this
  would be a reason for zeroing function-ptrs, which may point to code
  inside the thread, which will exit...

  but why should this be done? and why there's no threadsafe-
  modification of the structure?

  well: disabling vnc-thread at configure-state leads into a normal
  running machine, but threading would be nice here...

  so a quick fix could be, to drop the call above and make the vnc-thread s=
taying for the whole session, but I don't know all mechanisms of vnc-suppor=
t within kvm.
  but a better solution would be usage of clean locking-mechanisms

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/974229/+subscriptions
