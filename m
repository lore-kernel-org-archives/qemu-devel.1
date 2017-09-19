Received: from eggs.gnu.org ([2001:4830:134:3::10]:41223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duGRB-00041o-Sm
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duGR4-0004XT-IX
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:11:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:59678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1duGR4-0004Uc-7l
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:11:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1duGR1-0007hc-3k
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:11:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C88802E848E
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:11:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Sep 2017 10:59:51 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
Reply-To: Bug 1715700 <1715700@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150480187483.29281.9921794433489304819.malonedeb@chaenomeles.canonical.com>
Message-Id: <150581879144.23300.16307542832099306368.malone@wampee.canonical.com>
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

Thanks, Gerd, for the CC -- I agree, this commit (208fa0e43645) almost
certainly breaks the VBE Shim. Displaying the patch with a bit larger
context,

> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 22e16031b03b..59435390ba62 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1442,8 +1442,11 @@ void pc_memory_init(PCMachineState *pcms,
>  =

>      option_rom_mr =3D g_malloc(sizeof(*option_rom_mr));
>      memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
>                             &error_fatal);
> +    if (pcmc->pci_enabled) {
> +        memory_region_set_readonly(option_rom_mr, true);
> +    }
>      memory_region_add_subregion_overlap(rom_memory,
>                                          PC_ROM_MIN_VGA,
>                                          option_rom_mr,
>                                          1);

and PC_ROM_MIN_VGA is #defined as 0xc0000 in "include/hw/loader.h".

OVMF places the VBE Shim into the C segment, and points the 0x10
interrupt vector at it. See "OvmfPkg/QemuVideoDxe/VbeShim.c", function
InstallVbeShim():

>   SegmentC =3D 0xC0000;
> =

>   [...]
> =

>   //
>   // Put the shim in place first.
>   //
>   Pam1Address =3D PCI_LIB_ADDRESS (0, 0, 0, 0x5A);
>   //
>   // low nibble covers 0xC0000 to 0xC3FFF
>   // high nibble covers 0xC4000 to 0xC7FFF
>   // bit1 in each nibble is Write Enable
>   // bit0 in each nibble is Read Enable
>   //
>   Pam1 =3D PciRead8 (Pam1Address);
>   PciWrite8 (Pam1Address, Pam1 | (BIT1 | BIT0));
> =

>   //
>   // We never added memory space during PEI or DXE for the C segment, so =
we
>   // don't need to (and can't) allocate from there. Also, guest operating
>   // systems will see a hole in the UEFI memory map there.
>   //
>   SegmentCPages =3D 4;
> =

>   ASSERT (sizeof mVbeShim <=3D EFI_PAGES_TO_SIZE (SegmentCPages));
>   CopyMem ((VOID *)(UINTN)SegmentC, mVbeShim, sizeof mVbeShim);
> =

>   [...]
> =

>   //
>   // Clear Write Enable (bit1), keep Read Enable (bit0) set
>   //
>   PciWrite8 (Pam1Address, (Pam1 & ~BIT1) | BIT0);
> =

>   //
>   // Second, point the Int10h vector at the shim.
>   //
>   Int0x10->Segment =3D (UINT16) ((UINT32)SegmentC >> 4);
>   Int0x10->Offset  =3D (UINT16) ((UINTN) (VbeModeInfo + 1) - SegmentC);

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
