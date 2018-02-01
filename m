Received: from eggs.gnu.org ([2001:4830:134:3::10]:49731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ehAoM-0005va-8j
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ehAoJ-0005Uo-3n
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:05:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:46316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ehAoI-0005UZ-Tj
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:05:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ehAoH-0005B0-Ut
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 09:05:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DEBCF2E8024
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 09:05:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Feb 2018 08:53:13 -0000
From: Marshall Porter <1576347@bugs.launchpad.net>
Reply-To: Bug 1576347 <1576347@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160428174421.24544.77308.malonedeb@gac.canonical.com>
Message-Id: <151747519393.7673.3801832151902913082.malone@soybean.canonical.com>
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

Hello, I can also confirm that if you have a series of NVMe devices, at
first when just the OVMF boot menu has loaded, using qemu with a
-monitor and typing 'info pci', it appears that all are given valid bus
addresses.

However, once the Windows 10 x64 installer iso loads, it seems that
every other NVMe device stays initialized correctly, but the ones in-
between switch to a 0xfffff... bus address. So, for example, with 6
devices, numbers 1,3,5 will get initialized and recognized by the
Windows installer, and 2,4,6 will not. Not sure if this clue helps
identify this a qemu or Windows issue or not, but I thought it was worth
noting.

Also, I found that an alternative way to getting two or more NVMe
devices successfully recognized by Windows is to use multiple root PCIe
devices like so:

qemu-system-x86_64 \
-enable-kvm \
-machine pc-q35-2.11,accel=3Dkvm \
-nodefaults \
...
-device pcie-root-port,id=3Dpcie_r0,bus=3Dpcie.0,chassis=3D0,slot=3D0 \
-device nvme,drive=3Ddisk0,serial=3Dserial0,bus=3Dpcie_r0 \
-drive id=3Ddisk0,if=3Dnone,media=3Ddisk,cache=3Dnone,aio=3Dnative,format=
=3Draw,discard=3Dunmap,file=3D/opt/os.raw \
-device pcie-root-port,id=3Dpcie_r1,bus=3Dpcie.0,chassis=3D0,slot=3D1 \
-device nvme,drive=3Ddisk1,serial=3Dserial1,bus=3Dpcie_r1 \
-drive id=3Ddisk1,if=3Dnone,media=3Ddisk,cache=3Dnone,aio=3Dnative,format=
=3Draw,discard=3Dunmap,file=3D/opt/data.raw \

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
