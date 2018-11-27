Received: from eggs.gnu.org ([2001:4830:134:3::10]:47957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gRfBO-0004Ed-2B
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gRf4y-0002A0-6r
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:15:16 -0500
Received: from indium.canonical.com ([91.189.90.7]:49108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gRf4y-00029f-0r
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:15:12 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gRf4x-0001wb-79
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 15:15:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 351222E80C0
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 15:15:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Nov 2018 15:02:43 -0000
From: Thomas Huth <1523811@bugs.launchpad.net>
Reply-To: Bug 1523811 <1523811@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151208084519.14688.79647.malonedeb@wampee.canonical.com>
Message-Id: <154333096533.32610.14233315884225698286.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1523811] Re: USB assert failure on dev-storage.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1523811

Title:
  USB assert failure on dev-storage.c

Status in QEMU:
  Incomplete

Bug description:
  On executing the attached python script in the guest OS, QEMU dies
  with assert failure:

  [run python script in guest root shell]
  # python a.py

  [host message]
  qemu-system-x86_64: hw/usb/dev-storage.c:445: usb_msd_handle_data: Assert=
ion `le32_to_cpu(s->csw.residue) =3D=3D 0' failed.
  Aborted (core dumped)

  =

  When I detach the kernel driver and send CBW and reattach it again, witho=
ut conforming to the command/data/status protocol, QEMU dies.
  I think this is due to misimplementation of Command/Data/Status protocol =
in Bulk-only transfer.
  This kind of assert failure can be misused by malwares to avoid being ana=
lyzed by terminating only in the virtual environments and still execute the=
 malicious code in real machines.
  Before running python script, make sure to change a.py that it should poi=
nts to usb mass storage's vid and pid.

  QEMU was running on these environment : =

  [CPU model]    Intel(R) Core(TM) i5-4590 CPU @ 3.30GHz
  [qemu version] QEMU 2.5.0-rc2 (compiled from source, gcc 4.8.4)
  [host info]    Ubuntu 14.04.3, x86_64, 3.19.0-32-generic
  [guest info]   Ubuntu 14.04.3, x86_64, 3.19.0-28-generic
  [QEMU argument]
  x86_64-softmmu/qemu-system-x86_64 -hda /media/hdd/img/ubuntu1404.qcow2.5 \
  	-m 512 \
  	--usbdevice disk:format=3Dqcow2:../usb.img.5 \
  	--enable-kvm

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1523811/+subscriptions
