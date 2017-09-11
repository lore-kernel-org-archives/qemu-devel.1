Received: from eggs.gnu.org ([2001:4830:134:3::10]:55218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1drVRo-0001gv-3g
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1drVRk-000633-VP
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:36:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:53648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1drVRZ-0005hU-8S
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:36:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1drVRY-00087G-2z
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 20:36:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E5A832E848D
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 20:36:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Sep 2017 20:23:06 -0000
From: Nelson Chan <nelson_bigmouth@yahoo.com>
Reply-To: Bug 1615823 <1615823@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160822203622.9253.10775.malonedeb@wampee.canonical.com>
Message-Id: <150516138669.32169.10654652625556030659.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1615823] Re: Windows 10 reports no compatible TPM
 found yet device manager shows it?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

My laptop has a TPM 1.2 chip made by IFX (dmesg: tpm_tis 00:07: 1.2 TPM
(device-id 0x1B, rev-id 16))

I couldn't get it to work in libvirt (I am running ubuntu 17.04) until I
upgraded my Windows 10 to version 1607. I needed to change the CPU to
"core2duo" first before I could apply the version 1607 patch (if you
don't do that, you can never apply the patch). After applying this
Windows patch, Windows can detect and use the TPM device assigned to it
successfully.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1615823

Title:
  Windows 10 reports no compatible TPM found yet device manager shows
  it?

Status in QEMU:
  New

Bug description:
  Ubuntu 16.04 with stock kvm, libvirt, ovmf
  Qemu 2.5 installed from stock ubuntu ppa
  Qemu 2.6.1 built from tarball.
  Qemu 2.7.0-rc4 built from tarball.

  Windows 10 guest reports a TPM device is installed and the driver
  functional under Device Manager-->Security Devices.  TPM Administrator
  however advises no compatible TPM chip can be found.

  Qemu 2.5 is buggy and prevents the guest loading the TPM driver, this
  was addressed by
  http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D2b1c2e8e5f1990f0a201a8cb=
f9d366fca60f4aa8

  Have tested the below cmd out on both qemu-2.6.1 and qemu-2.7.0-rc4,
  both suffer the same problem.  My TPM is most certainly compatible as
  installing Win10Pro onto the same host as bare metal provides me the
  desired and expected functionality aka Bitlocker and TPM Administrator
  work.

  sudo ./qemu-system-x86_64 \
  -enable-kvm \
  -machine q35 \
  -cpu host \
  -m 4096 \
  -smp 4,sockets=3D1,cores=3D2,threads=3D2 \
  -device i82801b11-bridge,id=3Dpci.1,bus=3Dpcie.0,addr=3D0x1e \
  -device pci-bridge,chassis_nr=3D2,id=3Dpci.2,bus=3Dpci.1,addr=3D0x1 \
  -device qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vgam=
em_mb=3D16,bus=3Dpcie.0,addr=3D0x2 \
  -drive file=3D/usr/share/qemu/OVMF.fd,if=3Dpflash,format=3Draw,unit=3D0,r=
eadonly=3Don \
  -drive file=3D/mnt/120GB_SSD/wintpm_VARS.fd,if=3Dpflash,format=3Draw,unit=
=3D1 \
  -drive file=3D/mnt/120GB_SSD/wintpm.qcow2,format=3Dqcow2,if=3Dnone,id=3Dd=
rive-virtio-disk0 \
  -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.2,addr=3D0x3,drive=3Ddrive-vi=
rtio-disk0,id=3Dvirtio-disk0,bootindex=3D2 \
  -drive file=3D"/mnt/share/Filestorage/Images/Microsoft Windows 10 Pro x64=
.iso",format=3Draw,if=3Dnone,media=3Dcdrom,id=3Ddrive-sata0-0-0,readonly=3D=
on \
  -device ide-cd,bus=3Dide.0,drive=3Ddrive-sata0-0-0,id=3Dsata0-0-0 \
  -drive file=3D/mnt/share/Filestorage/Images/virtio-win-0.1.117.iso,format=
=3Draw,if=3Dnone,media=3Dcdrom,id=3Ddrive-sata0-0-1,readonly=3Don \
  -device ide-cd,bus=3Dide.1,drive=3Ddrive-sata0-0-1,id=3Dsata0-0-1 \
  -tpmdev passthrough,id=3Dtpm-tpm0,path=3D/dev/tpm0,cancel-path=3D/sys/cla=
ss/tpm/tpm0/device/cancel \
  -device tpm-tis,tpmdev=3Dtpm-tpm0,id=3Dtpm0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1615823/+subscriptions
