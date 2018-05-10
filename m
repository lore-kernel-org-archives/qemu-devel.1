Received: from eggs.gnu.org ([2001:4830:134:3::10]:56459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fGsNI-0004zZ-Ae
	for qemu-devel@nongnu.org; Thu, 10 May 2018 16:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fGsND-0003lR-H2
	for qemu-devel@nongnu.org; Thu, 10 May 2018 16:41:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:57410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fGsND-0003kZ-AK
	for qemu-devel@nongnu.org; Thu, 10 May 2018 16:41:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fGsNB-00081M-Vg
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 20:41:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ECBAF2E8056
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 20:41:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 May 2018 20:35:05 -0000
From: Peter Wu <lekensteyn@gmail.com>
Reply-To: Bug 1726910 <1726910@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150885852349.17651.9958840122130941388.malonedeb@wampee.canonical.com>
Message-Id: <152598450511.27637.5801839595090815703.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1726910] Re: UI request: add a function key
 toolbar (f1-f12)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Current QEMU code (at least, v2.12.0-329-ge5cd695266) does not grab the
F10 key ("menubar activate"), accelerators (Ctrl-Alt-1) or menu bar
"mnemonic"s (such as Alt-V for _V_iew).

This comment nicely summarizes what kind of grabs is needed:
https://bugzilla.redhat.com/show_bug.cgi?id=3D499362#c1
This is the corresponding implementation:
https://github.com/SPICE/virt-viewer/blob/4048d28de853854a57835e91fb8758e78=
bc9ecd5/src/virt-viewer-window.c#L696

Changing the "gtk-enable-accels" setting on the window should still work
in order to disable accelerators such as Ctrl-Alt-G and Ctrl-Alt-1.
Being able to switch to the monitor (e.g. to issue "sendkey ..." is
important, so something else should probably catch this. Or else just
accept that the grab key has to be pressed first.

Alt-M (Menu) and Alt-V (View) are not that commonly used shortcuts,
these could be removed/disabled with a grab if desired, but otherwise I
am not annoyed by it.

The F10 key however is used for various purposes in applications and must b=
e passed to the guest.
Unfortunately, Timm B=C3=A4der removed the "gtk-menu-bar-accel" property in=
 GTK+ 3.22.1-295-gb082fb598d (Oct 2016) which means that the F10 shortcut c=
an no longer be disabled using said property. So now another hack is needed=
 to prevent "gtk_window_activate_key" (gtk/gtkwindow.c) from triggering thi=
s menu bar.

** Bug watch added: Red Hat Bugzilla #499362
   https://bugzilla.redhat.com/show_bug.cgi?id=3D499362

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1726910

Title:
  UI request: add a function key toolbar (f1-f12)

Status in QEMU:
  New

Bug description:
  I run old DOS programs under FreeDOS using QEMU.

  It's common when running/testing DOS applications to use the function
  keys. Some of these (such as F10) are intercepted by the window
  system. For example, some DOS program installers use F10 to install
  the software, but F10 is intecepted by the window system.

  The standard solution is to jump to the QEMU console and use sendkey
  to send a specific function key to the QEMU guest (often needed for
  'sendkey f10'). But this does not seem to be very user friendly for
  new users. Nor is it very fast if you need to this often.

  I propose QEMU add a toolbar with the function keys.

  I've attached a mockup of one possible design, with a simple toolbar
  for F1-F12. A possible modification would be to add "modifier" buttons
  for Ctrl and Shift and Alt to make it easier for users to enter
  combinations like Ctrl-F12 or Alt-F10 or Shift-F1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1726910/+subscriptions
