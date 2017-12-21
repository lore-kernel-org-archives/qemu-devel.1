Received: from eggs.gnu.org ([2001:4830:134:3::10]:40780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRoWZ-0000Om-3g
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 19:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRoWU-00007d-Ur
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 19:15:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:47998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eRoWU-00006A-OV
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 19:15:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eRoWT-0004Ns-NL
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 00:15:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ACF292E806E
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 00:15:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Dec 2017 00:10:15 -0000
From: Adam Williamson <awilliam@redhat.com>
Reply-To: Bug 1738283 <1738283@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151328724563.26325.11755910452939969450.malonedeb@wampee.canonical.com>
Message-Id: <151381501582.26146.6587088260526031148.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1738283] Re: 'Less than' (<), 'more than' (>),
 and 'pipe' (|) can't be typed via VNC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

FWIW, I think this keycode represents the key between the left shift key
and the first letter key on the fourth row, if there is one. European
keyboards have one, and on e.g. a UK keyboard it types a \ unshifted and
a | shifted - this is exactly how it looks in the en-gb keymap file:

# evdev 86 (0x56), QKeyCode "less", number 0x56
backslash 0x56
bar 0x56 shift
bar 0x56 altgr
brokenbar 0x56 shift altgr

The definition that somehow gets into the en-us keymap file appears to
be actually how the key is intended to work on *German* keyboards:

https://en.wikipedia.org/wiki/German_keyboard_layout

Note how the key is labelled with <, > and | characters there. The
French layout has the same key labelled with < and > but not |. So
basically it seems like that same definition for this key shows up when
you ask xkb for an en_US map.

Bonus historical note: modern US keyboards don't have a key there at
all, they're 101/104-key keyboards, where the left shift key is very
wide and the key next to it is the first letter key. But *old* US
keyboards, specifically the 83-key 'XT' layout, *DID* have a key there!

https://en.wikipedia.org/wiki/IBM_PC_keyboard#/media/File:IBM_Model_F_XT.png

>From that picture, the key was labelled with \ and | characters, like a
modern UK keyboard (presumably this is where the modern UK keyboard
derived its use for the key from). I wonder if there's a keyboard nerd
out there somewhere with a working US XT keyboard who we could ask to
press that key and see what keycode it generates...:) I suppose if it's
this keycode, we could arguably report a bug in xkb that for en_US, that
keycode should work like a modern UK keyboard (backslash / bar / bar /
brokenbar), not a modern German keyboard...:)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738283

Title:
  'Less than' (<), 'more than' (>), and 'pipe' (|) can't be typed via
  VNC

Status in QEMU:
  New

Bug description:
  If I start QEMU 2.11 (from
  https://build.opensuse.org/package/show/Virtualization/qemu) VM with
  VNC, I am unable to type following three characters: 'less than' (<),
  'more than' (>), and 'pipe' (|) on en_US QWERTY keyboard. Other
  characters work fine. QEMu version 2.10.1 worked fine.

  /usr/bin/qemu-kvm -m 2048 -cpu kvm64 -drive
  media=3Dcdrom,if=3Dnone,id=3Dcd0,format=3Draw,file=3DOI-hipster-
  minimal-20171031.iso -device ide-cd,drive=3Dcd0 -boot once=3Dd,menu=3Don
  ,splash-time=3D5000 -device usb-ehci -device usb-tablet -smp 1 -enable-
  kvm -vnc :91,share=3Dforce-shared

  The ISO can be downloaded here: https://www.openindiana.org/download/

  Also tried Fedora-Server-dvd-x86_64-25-1.3.iso and it's the same
  situation.

  If I run the same command without '-vnc :91,share=3Dforce-shared',
  everything works just fine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1738283/+subscriptions
