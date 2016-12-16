Received: from eggs.gnu.org ([2001:4830:134:3::10]:43707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHqUF-0003t4-BP
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHqUB-0006FT-Ss
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:15:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:47435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cHqUB-0006Eb-Ll
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:15:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cHqUA-0005dk-Kf
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 11:15:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9A9942E80C3
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 11:15:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Dec 2016 11:01:45 -0000
From: Thomas Huth <691424@bugs.launchpad.net>
Reply-To: Bug 691424 <691424@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101217063430.31066.66219.malonedeb@palladium.canonical.com>
Message-Id: <20161216110145.20636.43962.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 691424] Re: qemu/kvm SDL over ssh -X broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

OK, thanks a lot for testing it again!

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/691424

Title:
  qemu/kvm SDL over ssh -X broken

Status in QEMU:
  Fix Released

Bug description:
  qemu/kvm by default uses SDL to render the output of its emulated VGA gra=
phics.
  This is broken over ssh -X since quite a while.
  The only workaround I know, is to use qemu -vnc :0
  and connect using vncviewer

  =

  How To Reproduce:
  1. zypper in qemu
  2. ssh -X localhost qemu -cdrom ANYISOFILE

  Actual Results:
  qemu hangs in an endless loop on the BIOS display screen

  Expected Results:
  should boot up the iso as 0.10 versions did

  Reproducible: Always

  =

  this is what broke it:
  $ git bisect bad
  c18a2c360e3100bbd71162cf922dcd8c429a8b71 is first bad commit
  commit c18a2c360e3100bbd71162cf922dcd8c429a8b71
  Author: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
  Date:   Wed Jun 24 11:58:25 2009 +0100

      sdl zooming

      Hi all,
      this patch implements zooming capabilities for the sdl interface.
      A new sdl_zoom_blit function is added that is able to scale and blit a
      portion of a surface into another.
      This way we can enable SDL_RESIZABLE and have a real_screen surface w=
ith
      a different size than the guest surface and let sdl_zoom_blit take ca=
re
      of the problem.

      Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
      Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

  :100644 100644 a06c9bfc22cc6de1c6e5e9068d6bf59d89613767 f8dc5065dd27010bf=
dbb6bcfb0c6e3af25024cdb M      Makefile
  :100644 100644 417217582363a87ee67e746ba798e285a64b6cdc 35183399f65de6f50=
f3baa4767ab7d4d11d45bca M      console.h
  :100644 100644 178b5532b8d9dd2194a8662fbfdcd49b4bc04222 d81399e51276e1c97=
fa1f7272ef16ea4c312b51b M      sdl.c
  :000000 100644 0000000000000000000000000000000000000000 56d3604fc3d79e4cc=
4622be8437c78bf70075da3 A      sdl_zoom.c
  :000000 100644 0000000000000000000000000000000000000000 33dc63408b43a37fd=
6b1acde3fa62b1a51315e75 A      sdl_zoom.h
  :000000 100644 0000000000000000000000000000000000000000 64bbca849bd3af678=
c2259b4d8cc0e48c6a6b43c A      sdl_zoom_template.h

  =

  This problem occurs on both Debian and openSUSE.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/691424/+subscriptions
