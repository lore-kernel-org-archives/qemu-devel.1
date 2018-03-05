Received: from eggs.gnu.org ([2001:4830:134:3::10]:35281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1esuji-0001u8-Dd
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1esujf-0002bc-6i
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:21:22 -0500
Received: from indium.canonical.com ([91.189.90.7]:53516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1esujf-0002bB-0k
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:21:19 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1esujc-0008TC-L6
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 18:21:16 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C0ECD2E81F3
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 18:21:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Mar 2018 18:08:17 -0000
From: Daniel Berrange <1747056@bugs.launchpad.net>
Reply-To: Bug 1747056 <1747056@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151759534688.10002.1939402860055070584.malonedeb@wampee.canonical.com>
Message-Id: <152027329801.4118.10689472915626468206.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1747056] Re: FreeDOS / MS-Dos / Windows 3.11
 cannot perform reboot with 'isapc' machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We need to pull in a SeaBIOS update with this fix applied to resolve
this

commit 42812e062a77b27b0544c8e0d46d206afc3b2fae
Author: Kevin O'Connor <kevin@koconnor.net>
Date:   Thu Feb 22 20:29:27 2018 -0500

    shadow: Don't invoke a shutdown on reboot unless in a reboot loop
    =

    Old versions of KVM would map the same writable copy of the BIOS at
    both 0x000f0000 and 0xffff0000.  As a result, a reboot on these
    machines would result in a reboot loop.  So, the code attempts to
    check for that situation and invoke a shutdown instead.
    =

    Commit b837e68d changed the check to run prior to the first reboot.
    However, this broke reboots on the QEMU isapc machine type.  Change
    the reboot loop check to only be invoked after at least one reboot has
    been attempted.
    =

    Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
    Signed-off-by: Kevin O'Connor <kevin@koconnor.net>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1747056

Title:
  FreeDOS / MS-Dos / Windows 3.11 cannot perform reboot with 'isapc'
  machine

Status in QEMU:
  New

Bug description:
  I was installing MS-Dos 6.22 + Windows 3.11 in preparation for running
  Microsoft Bob, and noticed that when they try to perform a reboot,
  they just get stuck. The console cursor stays flashing on/off, but the
  DOS prompt no longer responds to input.

  It is fairly easy to reproduce, even FreeDOS is impacted - download
  the FreeDOS bootable CDROM image, then

  $ qemu-img create demo.img 100MB

  $ qemu-system-x86_64 -machine isapc -cdrom ~/Downloads/FD12CD.iso
  -hda demo.img  -monitor stdio

  Wait for the installer to startup, and then in the monitor console run

    sendkey ctrl-alt-delete

  It will fail to reboot

  Testing shows this is a regression from QEMU 2.8.0 onwards, and git
  bisect further narrowed it down to a SEABIOS update

  commit 6e99f5741ff1b408ea76e6caf2bd4f76df4060e9 (HEAD, tag: pull-seabios-=
20161027-2, tag: pull-seabios-20161027-1, refs/bisect/bad)
  Author: Gerd Hoffmann <kraxel@redhat.com>
  Date:   Thu Oct 27 16:42:28 2016 +0200

      seabios: update to 1.10.0 release.

  Note that this seems particular to the "isapc" machine type - with the
  "pc" machine type, reboot still works

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1747056/+subscriptions
