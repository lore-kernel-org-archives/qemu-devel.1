Received: from eggs.gnu.org ([2001:4830:134:3::10]:45263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTYpA-00042a-7S
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTYp7-0004A5-4g
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:49:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:47651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTYp6-00049K-Tg
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:49:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTYp5-0000fm-TK
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:49:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C69462E80C0
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:49:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 18:38:14 -0000
From: Thomas Huth <1581936@bugs.launchpad.net>
Reply-To: Bug 1581936 <1581936@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160515095432.8440.97382.malonedeb@soybean.canonical.com>
Message-Id: <20170117183814.20557.58022.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1581936] Re: Frozen Windows 7 VMs with VGA
 CVE-2016-3712 fix (2.6.0 and 2.5.1.1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit 94ef4f337fb614f18b7 has been released with QEMU version 2.7

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1581936

Title:
  Frozen Windows 7 VMs with VGA CVE-2016-3712 fix (2.6.0 and 2.5.1.1)

Status in QEMU:
  Fix Released

Bug description:
  Hi,

  As already posted on the QEMU devel list [1] I stumbled upon a problem
  with QEMU in version 2.5.1.1 and 2.6.0.

  the VM shows Windows loading
  files for the installation, then the "Starting Windows" screen appears
  here it hangs and never continues.

  Changing the "-vga" option to cirrus solves this, the installation can
  proceed and finish. When changing back to std (or also qxl, vmware) the
  installed VM also hangs on the "Starting Windows" screen while qemu
  showing a little but no excessive load.

  This phenomena appears also with QEMU 2.6.0 but not with 2.6.0-rc4, a
  git bisect shows fd3c136b3e1482cd0ec7285d6bc2a3e6a62c38d7 (vga: make
  sure vga register setup for vbe stays intact (CVE-2016-3712)) as the
  culprit for this regression, as its a fix for a DoS its not an option to
  just revert it, I guess.

  The bisect log is:

  git bisect start
  # bad: [bfc766d38e1fae5767d43845c15c79ac8fa6d6af] Update version for v2.6=
.0 release
  git bisect bad bfc766d38e1fae5767d43845c15c79ac8fa6d6af
  # good: [975eb6a547f809608ccb08c221552f666611af25] Update version for v2.=
6.0-rc4 release
  git bisect good 975eb6a547f809608ccb08c221552f666611af25
  # good: [2068192dcccd8a80dddfcc8df6164cf9c26e0fc4] vga: update vga regist=
er setup on vbe changes
  git bisect good 2068192dcccd8a80dddfcc8df6164cf9c26e0fc4
  # bad: [53db932604dfa7bb9241d132e0173894cf54261c] Merge remote-tracking b=
ranch 'remotes/kraxel/tags/pull-vga-20160509-1' into staging
  git bisect bad 53db932604dfa7bb9241d132e0173894cf54261c
  # bad: [fd3c136b3e1482cd0ec7285d6bc2a3e6a62c38d7] vga: make sure vga regi=
ster setup for vbe stays intact (CVE-2016-3712).
  git bisect bad fd3c136b3e1482cd0ec7285d6bc2a3e6a62c38d7
  # first bad commit: [fd3c136b3e1482cd0ec7285d6bc2a3e6a62c38d7] vga: make =
sure vga register setup for vbe stays intact (CVE-2016-3712).

  =

  I could reproduce that with QEMU 2.5.1 and QEMU 2.6 on a Debian derivate
  (Promox VE) with 4.4 Kernel and also with QEMU 2.6 on an Arch Linux
  System with a 4.5 Kernel, so it should not be host distro depended. Both
  machines have Intel x86_64 processors.
  The problem should be reproducible with said Versions or a build from
  git including the above mentioned commit (fd3c136) by starting a VM with
  an Windows 7 ISO, e.g.:

  Freezing installation (as vga defaults to std I marked it as optional):
  ./x86_64-softmmu/qemu-system-x86_64 -boot d -cdrom win7.iso -m 1024 [-vga=
 (std|qxl|vmware)]

  Working installation:
  ./x86_64-softmmu/qemu-system-x86_64 -boot d -cdrom win7.iso -m 1024 -vga =
cirrus

  If someone has already an installed Windows 7 VM this behaviour should be
  also observable when trying to start it with the new versions of QEMU.

  Noteworthy may be that Windows 10 is working, I do not had time to get
  other Windows versions and test them, I'll do that as soon as possible.
  Various Linux system also seems do work fine, at least I did not ran
  into an issue there yet.

  I also tried testing with SeaBIOS and OVMF as firmware, as initially I
  had no idea what broke, both lead to the same result - without the =

  CVE-2016-3712 fix they both work, with not.
  Further, KVM enabled and disabled does not make any difference.

  =

  [1] http://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg02416.html

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1581936/+subscriptions
