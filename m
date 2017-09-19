Received: from eggs.gnu.org ([2001:4830:134:3::10]:46163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duHzQ-0004l8-3Y
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duHzL-0003aG-4U
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:51:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:56136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1duHzK-0003Yk-Ew
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:50:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1duHzG-0002JQ-Sg
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 12:50:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8D2752E8497
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 12:50:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Sep 2017 12:33:03 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
Reply-To: Bug 1715700 <1715700@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150480187483.29281.9921794433489304819.malonedeb@chaenomeles.canonical.com>
	<150582174627.23596.4716545390713156671.malone@wampee.canonical.com>
Message-Id: <29ad1f7b-a908-be32-e997-82731151a296@redhat.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1715700] Re: Windows 7 guest won't boot on
 qemu 2.10 (works on 2.9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 09/19/17 13:49, Gerd Hoffmann wrote:
> ovmf seems to not touch pam configuration, so rom remains mapped.

I don't understand; the code that I quoted above -- and that LaunchPad
messed up -- explicitly changes the PAM registers:

  //
  // Put the shim in place first.
  //
  Pam1Address =3D PCI_LIB_ADDRESS (0, 0, 0, 0x5A);
  //
  // low nibble covers 0xC0000 to 0xC3FFF
  // high nibble covers 0xC4000 to 0xC7FFF
  // bit1 in each nibble is Write Enable
  // bit0 in each nibble is Read Enable
  //
  Pam1 =3D PciRead8 (Pam1Address);
  PciWrite8 (Pam1Address, Pam1 | (BIT1 | BIT0));

...

  //
  // Clear Write Enable (bit1), keep Read Enable (bit0) set
  //
  PciWrite8 (Pam1Address, (Pam1 & ~BIT1) | BIT0);

> seabios in contrast maps the address range to ram instead.
> IIRC ovmf does that too in CSM mode.
> So, yes, probably this is fixable in ovmf.

I don't see how.

Thanks
Laszlo

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
