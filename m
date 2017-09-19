Received: from eggs.gnu.org ([2001:4830:134:3::10]:49199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duHMq-0005Ey-Kt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duHMl-000201-L4
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:11:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:34112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1duHMl-0001zO-F8
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:11:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1duHMi-0007Bi-4X
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 12:11:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0B9AA2E8490
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 12:11:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Sep 2017 11:58:29 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
Reply-To: Bug 1715700 <1715700@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150480187483.29281.9921794433489304819.malonedeb@chaenomeles.canonical.com>
Message-Id: <150582231000.13645.13271569408662777261.malone@gac.canonical.com>
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

Re: comment 14, "is there a way to fix vbeshim instead of reverting RO
limitation that commit introduced?":

I don't think so; please see my earlier comments 15 and 17. To
elaborate:

If a user wants to boot Windows 7 on OVMF, they have *three* options:

(1) Build the SeaBIOS CSM (CONFIG_CSM=3Dy), and embed it into OVMF, like
described above. Then, boot Windows 7 in *Legacy Mode*.

--> Windows 7 will think that it runs on a plain BIOS machine. The VBE
Services will be provided to Windows 7 by (a) the edk2 CSM
infrastructure, (b) the SeaBIOS CSM, and (c) the VGABIOS PCI oprom
together.

(2) Build the SeaBIOS CSM (CONFIG_CSM=3Dy), and embed it into OVMF, like
described above. Then, boot Windows 7 in *UEFI Mode*.

--> Windows 7 will think that it runs on a UEFI machine, *but* because
Windows 7 has a bug, it will want to invoke VBE services nonetheless.
The VBE Services will be provided to Windows 7 by (a) the edk2 CSM
infrastructure, (b) the SeaBIOS CSM, and (c) the VGABIOS PCI oprom
together.

(3) Build OVMF without the SeaBIOS CSM, then boot Windows 7 in UEFI
Mode.

--> Windows 7 will think that it runs on a UEFI machine, *but* because
Windows 7 has a bug, it will want to invoke VBE services nonetheless.
The VBE Services will be provided to Windows 7 by the VBE Shim that OVMF
installs during boot.


Option #1 and option #2 no longer work because the CSM infrastructure in ed=
k2 needs to be able to write 0xc0000.

Option #3 no longer works because OVMF needs to put the VBE Shim into
place at 0xc0000.


Basically, Windows 7 wants to find the VBE services at 0xc0000, regardless =
of the method that it is booted with, ie. Legacy or UEFI. (As I said, this =
is a Windows 7 bug.) If that memory area is not writeable to the guest, the=
n OVMF cannot satisfy the (buggy) Windows 7 requirement, using either of op=
tions #1, #2 or #3.

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
