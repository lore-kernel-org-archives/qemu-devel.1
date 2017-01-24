Received: from eggs.gnu.org ([2001:4830:134:3::10]:36132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVxHg-0006tk-T4
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVxHd-000432-Mj
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:21:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:47690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cVxHd-00042t-Gn
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:20:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cVxHb-0000Ni-5U
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:20:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 365CF2E80CA
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:20:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Jan 2017 09:06:56 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
Reply-To: Bug 1658634 <1658634@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170123095738.20994.7212.malonedeb@gac.canonical.com>
Message-Id: <20170124090656.12428.9471.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1658634] Re: Can't get correct display with
 latest QEMU and OVMF BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I downloaded "ubuntu-16.04.1-desktop-amd64.iso" (MD5:
17643c29e3c4609818f26becf76d29a3), and I can reproduce the issue -- the
grub2 display is corrupt. (I didn't even look further than that.) I also
confirm that it works fine with the same firmware, but using QEMU 2.7.

Here's the result of the bisection:

cd958edb1fae85d0c7d1e1acbff82d22724e8d64 is the first bad commit
commit cd958edb1fae85d0c7d1e1acbff82d22724e8d64
Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Date:   Fri Aug 26 13:47:11 2016 +0400

    console: skip same-size resize
    =

    virtio-gpu does a set-scanout at each frame (it might be a driver
    regression). qemu_console_resize() recreate a surface even if the size
    didn't change, and this shows up in profiling reports because the
    surface is cleared. With this patch, I get a +15-20% glmark2
    improvement.
    =

    Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Message-id: 20160826094711.14470-1-marcandre.lureau@redhat.com
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

If I revert this commit on top of current master -- it reverts cleanly
-- then the grub2 screen displays fine again.

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1658634

Title:
  Can't get correct display with latest QEMU and OVMF BIOS

Status in QEMU:
  Confirmed

Bug description:
  I tried to install a Ubuntu 16.04.1 Desktop 64bits with latest QEMU and O=
VMF UEFI BIOS, however I can't get correct display output with default vga =
configuration (-vga std). However, qemu works with a couple of different co=
nfigurations:
  1. "-vga cirrus" + "-bios OVMF.fd": works
  2. "-vga std" + non-UEFI bios: works

  The same error with QEMU 2.8.0 release. Everything works well on
  2.7.0/1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1658634/+subscriptions
