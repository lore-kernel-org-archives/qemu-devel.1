Received: from eggs.gnu.org ([2001:4830:134:3::10]:41167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1di5ym-0008WH-Ef
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1di5yj-0002LN-B2
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:35:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:39570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1di5yj-0002Km-4H
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:35:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1di5yh-0006Tq-T7
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 21:35:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DB1262E805B
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 21:35:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Aug 2017 21:18:56 -0000
From: Sergey Blagodurov <1576347@bugs.launchpad.net>
Reply-To: Bug 1576347 <1576347@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160428174421.24544.77308.malonedeb@gac.canonical.com>
Message-Id: <150291833686.16815.16398127979286321280.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1576347] Re: Only one NVMe device is usable in
 Windows (10) guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Trying it on Windows 10 guest and QEMU 2.8.0 has the same issue. However, I=
 noticed that:
  Supplying 1 NVMe drive -> Win10 sees it.
  Supplying 2 NVMe drives -> Win10 sees only one of them.
  Supplying 3 NVMe drives -> Win10 sees only two of them.
So I still have been able to create a ReFS mirrored storage space with two =
NVMe disks under QEMU, I just had to pass three drives instead of two:

qemu-system-x86_64 -enable-kvm <...> -drive
file=3D/media/ssd/NVMe_drvA.qcow2,id=3DdiskNVMeA,format=3Dqcow2,if=3Dnone -=
drive
file=3D/media/ssd/NVMe_drvB.qcow2,id=3DdiskNVMeB,format=3Dqcow2,if=3Dnone -=
drive
file=3D/media/ssd/NVMe_drvC.qcow2,id=3DdiskNVMeC,format=3Dqcow2,if=3Dnone
-device nvme,drive=3DdiskNVMeA,serial=3Dfoo -device
nvme,drive=3DdiskNVMeB,serial=3Dfoo -device nvme,drive=3DdiskNVMeC,serial=
=3Dfoo

Hope this helps,
--Sergey

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1576347

Title:
  Only one NVMe device is usable in Windows (10) guest

Status in QEMU:
  New

Bug description:
  Full command: qemu-system-x86_64 -enable-kvm -cpu host -smp cores=3D4 -m
  4G -net bridge -net nic -full-screen -drive
  file=3Dovmf_x64.bin,format=3Draw,if=3Dpflash -drive
  file=3Ddisks/win16_ide.img,format=3Draw,cache=3Dnone,aio=3Dnative -drive
  file=3Ddisks/one.img,if=3Dnone,format=3Dqcow2,id=3Done -drive
  file=3Ddisks/two.img,if=3Dnone,format=3Dqcow2,id=3Dtwo -device
  nvme,drive=3Done,serial=3DE86C3CFC43518D6F -device
  nvme,drive=3Dtwo,serial=3D2BDAC262CF831698

  QEMU version: 2.5.0

  Kernel: 4.5.1 (Arch Linux)

  When there are two NVMe devices specified, only the second one will be
  usable in Windows. The following error is shown under "Device status"
  of the failed NVMe controller in Device Manager:

  "This device cannot start. (Code 10)

  The I/O device is configured incorrectly or the configuration
  parameters to the driver are incorrect."

  The only thing seems suspicious to me is that the nvme emulation in
  qemu does not have WWN/EUI-64 set for the devices, though I have no
  idea at all whether that is mandatory:

  "C:\Windows\system32>sg_vpd -i PD1
  Device Identification VPD page:
    Addressed logical unit:
      designator type: SCSI name string,  code set: UTF-8
        SCSI name string:
        8086QEMU NVMe Ctrl                          00012BDAC262CF831698

  C:\Windows\system32>sg_vpd -p sn PD1
  Unit serial number VPD page:
    Unit serial number: 0000_0000_0000_0000."

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1576347/+subscriptions
