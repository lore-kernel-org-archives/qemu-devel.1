Received: from eggs.gnu.org ([2001:4830:134:3::10]:36161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duH3E-00024g-SK
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duH3B-000649-Q1
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:50:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:41486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1duH3B-00063Y-Gs
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:50:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1duH37-00014C-6C
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:50:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EFAE92E8498
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:50:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Sep 2017 11:44:30 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
Reply-To: Bug 1715700 <1715700@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150480187483.29281.9921794433489304819.malonedeb@chaenomeles.canonical.com>
Message-Id: <150582147079.29110.11441479933779662312.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1715700] Re: Windows 7 guest won't boot on qemu
 2.10 (works on 2.9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

What I mentioned earlier was not that SeaBIOS would break.

Instead, I said that building OVMF, with the SeaBIOS CSM (Compatibility
Support Module) embedded into it, would break, exactly the same way as
the VBE Shim.

Quoting the CSM Spec from Intel: "The CSM provides compatibility support
between the Framework and traditional, legacy BIOS code and allows
booting a traditional OS or booting an EFI OS off a device that requires
a traditional option ROM (OpROM)."

https://github.com/tianocore/tianocore.github.io/wiki/Compatibility-
Support-Module

Upstream edk2 contains no such module out of the box. However, SeaBIOS
has been extended with a build target (CONFIG_CSM) that produces such a
binary. This binary can be then embedded in the edk2 source tree (see
"OvmfPkg/Csm/Csm16/ReadMe.txt"), and then OVMF can be built with -D
CSM_ENABLE.

This will allow OVMF to boot legacy OSes, and those OSes will think they
are being booted on a legacy BIOS machine.

While the SeaBIOS CSM itself is provided by the SeaBIOS project, the
infrastructure that sets it up under UEFI comes from edk2. The two
important drivers are -- built into OVMF only with -D CSM_ENABLE --:

- IntelFrameworkModulePkg/Csm/LegacyBiosDxe/LegacyBiosDxe.inf

- IntelFrameworkModulePkg/Csm/BiosThunk/VideoDxe/VideoDxe.inf

The former driver (LegacyBiosDxe) needs write access to the memory area
at 0xc0000, so that it can install legacy PCI option ROMs. The service
it provides is called "EFI_LEGACY_BIOS_PROTOCOL.InstallPciRom"; it loads
a traditional OpROM into traditional OpROM address space (0xC0000 to
0xFFFFF region).

The latter driver (VideoDxe) asks the former driver to install such an
option ROM (for video services) from the PCI ROM BAR.

Therefore, if the area at 0xc0000 is unwriteable for the guest, then
neither the VBE Shim, nor its alternative -- namely the full-blown
SeaBIOS CSM -- can function in OVMF.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715700

Title:
  Windows 7 guest won't boot on qemu 2.10 (works on 2.9)

Status in QEMU:
  New

Bug description:
  Qemu version: 2.10 stable.
  Guest: Windows 7 SP1 x64, virtio drivers are already installed in the gue=
st.
  Command line:
  qemu-system-x86_64 \
      -nodefaults \
      -nodefconfig \
      -machine type=3Dq35,accel=3Dkvm \
      -enable-kvm \
      -cpu host \
      -m 2048 \
      -vga virtio \
      -boot menu=3Don \
      -smbios file=3D/path/dmidecode_BIOS.bin \
      -acpitable file=3D/path/acpi_slic.bin \
      -bios /path/OVMF_CODE.fd \
      -net none \
      -drive if=3Dvirtio,media=3Ddisk,file=3D/media/win7.qcow2 \
      -device pcie-root-port \
      -device ich9-usb-ehci1 \
      -device ich9-usb-uhci1 \
      -device ich9-usb-uhci2 \
      -device ich9-usb-uhci3

  Windows hangs at boot with waving flag screen (flag doesn't freeze,
  keeps waving indefinitely). Same command line boots fine with Qemu
  2.9. I tried changing machine type to pc-q35-2.9 - same result.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715700/+subscriptions
