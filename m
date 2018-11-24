Received: from eggs.gnu.org ([2001:4830:134:3::10]:37877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gQUf6-0000G0-5w
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 04:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gQUf1-0007pa-7K
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 04:55:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:43672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gQUf1-0007gu-0J
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 04:55:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gQUez-00034c-LQ
	for <qemu-devel@nongnu.org>; Sat, 24 Nov 2018 09:55:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8D0552E80C8
	for <qemu-devel@nongnu.org>; Sat, 24 Nov 2018 09:55:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Nov 2018 09:49:20 -0000
From: Gao <1802465@bugs.launchpad.net>
Reply-To: Bug 1802465 <1802465@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154174980807.2749.13752196954108515323.malonedeb@gac.canonical.com>
Message-Id: <154305296063.16140.15074172223490123378.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1802465] Re: typing string via VNC is unreliable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In my case the problem is quite subtle. =

Nearly every time we send the key strokes, the guest os keeps receiving spa=
ce or tab or new line character. And ending part of the text is truncated, =
where the truncated part is fixed depending on the keystrokes we are sendin=
g. =

Additionally, the keystrokes are mis-ordered at a higher frequency than 1 o=
ut of a few hundreds as you said. =


In brief,
- Repeatedly receiving space, tab or new line character as ending
- Truncation regarding ending part of key strokes
- characters are mis-ordered, lost, repeated =


A question is, how can you make character transaction faster with
vncdotool? In my case, vncdotool is typing fairly slow.

I found this debian bug report quite useful, what do you think?
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D758881

Re-producing procedures
---

I re-produced the problem in a slightly different way since your method
seems not working for me.

> qemu-img create tumbleweed.img 40G
> qemu-system-x86_64 -drive file=3Dtumbleweed.img,if=3Dvirtio -boot d -cdro=
m openSUSE-Tumbleweed-DVD-x86_64-Snapshot20181119-Media.iso -m 2048 --enabl=
e-kvm -display vnc=3D:1
> qemu-system-x86_64 -drive file=3Dtumbleweed.img,if=3Dvirtio  -m 4G --enab=
le-kvm -display vnc=3D:1

** Bug watch added: Debian Bug tracker #758881
   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D758881

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1802465

Title:
  typing string via VNC is unreliable

Status in QEMU:
  New

Bug description:
  QEMU version is 3.0.0

  # Description

  The problem is that, when typing string through VNC, it can be
  unreliable -- sometimes some key strokes get skipped, sometimes get
  swapped, sometimes get repeated.  There's no problem when typing
  through VNC on physical hardware.

  # Steps to reproduce

  1. Launch virtual machine by:

      qemu-kvm -display vnc=3D:1 -m 2048 opensuse-leap-15.qcow2

  2. Connect to VNC by:

      vncviewer -Shared :5901

  3. Simulate a series of key strokes by "vncdotool" [1]:

      vncdotool -s 127.0.0.1::5901 typefile strings_to_be_typed.txt

  4. Usually after a few hundred keys are typed, something goes wrong.

  I attached a screenshot that it mistypes " hello" to "h ello".

  [1] https://github.com/sibson/vncdotool

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1802465/+subscriptions
