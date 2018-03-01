Received: from eggs.gnu.org ([2001:4830:134:3::10]:42498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1erR6Q-0001pu-6y
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1erR6L-0005qs-0P
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:30:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:47480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1erR6K-0005qd-Pb
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:30:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1erR6J-0002OP-R4
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 16:30:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BE05F2E80CB
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 16:30:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Mar 2018 16:25:08 -0000
From: Leonid Myravjev <1752646@bugs.launchpad.net>
Reply-To: Bug 1752646 <1752646@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151992150884.16342.3804061030016543.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1752646] [NEW] Freezing VNC screen on some the
 UEFI framebuffer applications
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Hi folks!

I use TianCore (UEFI) formware on the qemu (master version last commit a6e0=
344).
When kernel/linux is start, it using UEFI Framebuffer. Then I run UEFI appl=
ication (which writes directly to the framebuffer) my VNS screen is freezin=
g. Then I restart vnclient I see only one frame.

When I run application, I getting in the file hw/display/vga.c on
function 'vga_ioport_write' some commands, it change "s->ar_index" from
0x20 -> 0x10

In the function vga_update_display:
1751         if (!(s->ar_index & 0x20)) {
1752             graphic_mode =3D GMODE_BLANK;
1753         } else {

And I got GMODE_BLANK mode. If I patch it:
1751         if (0) {

my VNC not freezing.

>From "Hardware Level VGA and SVGA Video Programming Information Page" I
saw, what ar_index is 0x3C0 (Attribute Controller Data Write Register),
0x20(5-bit) is PAS -- Palette Address Source

If there is a output via the UEFI framebuffer, does the difference have
a PAS or not? Why do we need to pause the output if the PAS is exposed?
Especially when the application outputs via framebuffer.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: framebuffer uefi vga

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1752646

Title:
  Freezing VNC screen on some the UEFI framebuffer applications

Status in QEMU:
  New

Bug description:
  Hi folks!

  I use TianCore (UEFI) formware on the qemu (master version last commit a6=
e0344).
  When kernel/linux is start, it using UEFI Framebuffer. Then I run UEFI ap=
plication (which writes directly to the framebuffer) my VNS screen is freez=
ing. Then I restart vnclient I see only one frame.

  When I run application, I getting in the file hw/display/vga.c on
  function 'vga_ioport_write' some commands, it change "s->ar_index"
  from 0x20 -> 0x10

  In the function vga_update_display:
  1751         if (!(s->ar_index & 0x20)) {
  1752             graphic_mode =3D GMODE_BLANK;
  1753         } else {

  And I got GMODE_BLANK mode. If I patch it:
  1751         if (0) {

  my VNC not freezing.

  From "Hardware Level VGA and SVGA Video Programming Information Page"
  I saw, what ar_index is 0x3C0 (Attribute Controller Data Write
  Register), 0x20(5-bit) is PAS -- Palette Address Source

  If there is a output via the UEFI framebuffer, does the difference
  have a PAS or not? Why do we need to pause the output if the PAS is
  exposed? Especially when the application outputs via framebuffer.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1752646/+subscriptions
