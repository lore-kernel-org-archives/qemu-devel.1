Received: from eggs.gnu.org ([2001:4830:134:3::10]:60384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFfst-0008JQ-5y
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFfsp-0004pI-Uk
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:41:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:48150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gFfsp-0004oP-Mb
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:41:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gFfsn-0006dR-9b
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 13:41:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C87132E80CE
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 13:41:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Oct 2018 13:35:25 -0000
From: Chen Zhang <1793859@bugs.launchpad.net>
Reply-To: Bug 1793859 <1793859@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153760092554.29759.17075669747500120723.malonedeb@soybean.canonical.com>
Message-Id: <154047452526.24499.15215758450442003133.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1793859] Re: GTK display and mouse input area
 scaling fails when using vfio-pci device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, I have a hack for this issue.

In general, the gvt-g is buggy in that the kernel driver i915 failed to
provide the actual resolution for the vgpu and always report the largest
available one.

The following patch modified the gtk-egl implementation for DMA Buf
mode, to convert mouse movement/tablet position to the scaled window
coordinates.

See https://pastebin.com/96iBLdDx

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1793859

Title:
  GTK display and mouse input area scaling fails when using vfio-pci
  device

Status in QEMU:
  New

Bug description:
  Version qemu 3.0.0-1 running on Arch. Found on Windows 8.1 and Windows
  10 VM's when using Intel gvt-g device.

  While in fullscreen the GTK display is scaled larger than the x11
  screen or virtual machine resolution. Without choosing zoom-to-fit
  portions of the VM display are not shown on x11 screen regardless of
  the VM resolution. When zoom-to-fit is done the mouse that's shown on
  screen and actual input are off sync. The mouse can wander off screen
  when going left and down.

  This message is shown when changing from gxl-vga to vfio-pci in view menu=
. =

  (qemu-system-x86_64:6472): Gtk-WARNING **: 09:50:06.663: drawing failure =
for widget 'GtkDrawingArea': NULL pointer
  (qemu-system-x86_64:6472): Gtk-WARNING **: 09:50:06.664: drawing failure =
for widget 'GtkNotebook': NULL pointer
  (qemu-system-x86_64:6472): Gtk-WARNING **: 09:50:06.664: drawing failure =
for widget 'GtkBox': NULL pointer
  (qemu-system-x86_64:6472): Gtk-WARNING **: 09:50:06.664: drawing failure =
for widget 'GtkWindow': NULL pointer

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1793859/+subscriptions
