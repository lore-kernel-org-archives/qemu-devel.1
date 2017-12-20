Received: from eggs.gnu.org ([2001:4830:134:3::10]:35039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRnHC-00008B-N0
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 17:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRnH9-0002a9-QS
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 17:55:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:34476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eRnH9-0002YW-FU
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 17:55:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eRnH7-0003Z6-9o
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 22:55:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 19A7B2E806F
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 22:55:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Dec 2017 22:40:00 -0000
From: Adam Williamson <awilliam@redhat.com>
Reply-To: Bug 1738283 <1738283@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151328724563.26325.11755910452939969450.malonedeb@wampee.canonical.com>
Message-Id: <151380960029.11069.17508491556099980788.malone@gac.canonical.com>
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

Aha. This looks like my bug!

I'm running into this in what I suspect is the same situation as Michal
Nowak: openQA. But in Fedora. openQA (well, its test runner, os-
autoinst) works by running virtual machines and interacting with them
over VNC. It seems that with qemu 2.11, typing certain characters
doesn't work right, where it worked fine with 2.10. The case I ran into
is the < case: when os-autoinst intends to type a < (which it does by
sending the keysym for shift and then the keysym 60, for <), it winds up
typing a > . This winds up causing os-autoinst's test suite to fail when
attempting to build the package on Fedora Rawhide. The test suite passes
on Fedora 27 (qemu 2.10).

The qemu command in my test is:

/usr/bin/qemu-system-i386 -serial file:serial0 -soundhw ac97 -vga cirrus
-m 1024 -netdev user,id=3Dqanet0 -device virtio-
net,netdev=3Dqanet0,mac=3D52:54:00:12:34:56 -device ide-
drive,drive=3Dhd1,serial=3D1 -drive
file=3Draid/l1,cache=3Dunsafe,if=3Dnone,id=3Dhd1,format=3Dqcow2 -drive
media=3Dcdrom,if=3Dnone,id=3Dcd0,format=3Draw,file=3D/builddir/build/BUILD/=
os-
autoinst-25191d50d54eaded10b6b26199bb986728dcd5c2/t/data//Core-7.2.iso
-device ide-cd,drive=3Dcd0 -boot once=3Dd,menu=3Don,splash-time=3D5000 -smp=
 1
-no-shutdown -vnc :90,share=3Dforce-shared -qmp
unix:qmp_socket,server,nowait -monitor unix:hmp_socket,server,nowait -S
-monitor telnet:127.0.0.1:15222,server,nowait

note there doesn't appear to be any explicit keyboard map setting there.

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
