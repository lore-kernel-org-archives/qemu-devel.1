Received: from eggs.gnu.org ([2001:4830:134:3::10]:50902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fQXnM-0000lo-D8
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fQXnH-0006qx-DA
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:44:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fQXnH-0006pL-6I
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:44:03 -0400
References: <20180323122520.11270-1-kraxel@redhat.com>
	<43fc23c1-d72f-748a-5b9d-a816466d7406@redhat.com>
	<20180425140749.6x3w4h4i2n6uaq7o@sirius.home.kraxel.org>
	<1ed94b1c-b416-eebe-9cf3-91943a0e6c5a@redhat.com>
	<20180531084347.xb2r5aolkis2nmqg@sirius.home.kraxel.org>
	<4b65af58-8451-a365-6c81-52c49e42b6ff@redhat.com>
	<20180605110647.7ctaj7fiy6x4ewdw@sirius.home.kraxel.org>
	<a3fe57cf-1569-834d-5528-d85847b29f9f@redhat.com>
	<20180605131649.fu3cellm7vwaf4ao@sirius.home.kraxel.org>
	<20d457f0-647f-04e3-76c3-ed58f3494208@redhat.com>
	<20180606084900.77jv3z4il47bx5gi@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <149b77cf-d195-5bf1-d9b8-7e4a0e639411@redhat.com>
Date: Wed, 6 Jun 2018 14:43:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180606084900.77jv3z4il47bx5gi@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] ramfb: simple boot framebuffer,
 no legacy vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>

On 06/06/18 10:49, Gerd Hoffmann wrote:

> edk2:
>    QemuRamfbDxe driver, x86 wireup, incomplete arm wireup.

I'm looking at the patches very cursorily right now:

> Notes on QemuRamfbDxe:
>
> QemuRamfbDxe registers as VenHw device with a fresh generated uuid.
> The uuid should probably go to some header file, suggestions where to
> place it best?

(1) Under "OvmfPkg/Include/Guid/". The file "VirtioMmioTransport.h" is a
minimal example.

Please review commit 3765e030affb ("OvmfPkg: introduce
VIRTIO_MMIO_TRANSPORT_GUID", 2015-01-02) in its entirety though, as the
OvmfPkg.dec file should be modified as well.

> QemuRamfbDxe registers a acpi devpath node for the gop protocol.  It's
> appended to the VenHw path, but looks like that isn't enough to create
> it as child node of the VenHw device (according to devtree outout).
> Suggestions how to fix that?  Still this is good enough for
> consplitter to accept the device.

The UEFI Driver Writer's Guide, and the UEFI spec, treat this
extensively, but let's save ourselves some time:

(2) Please flip the MODULE_TYPE of the driver to DXE_DRIVER, from
UEFI_DRIVER. (This will also let you drop some of the other patches.)

(3) Try adding the following at the end of QemuRamfbDxe:

  VOID *DevicePath;

  ...

  gBS->OpenProtocol (
         RamfbHandle,
         &gEfiDevicePathProtocolGuid,
         &DevicePath,
         gImageHandle,
         GopHandle,
         EFI_OPEN_PROTOCOL_BY_CHILD_CONTROLLER
         );

See also iPXE commit d6817943d187 ("[efi] Install the HII config access
protocol on a child of the SNP handle", 2016-07-08), especially the call
to efi_child_add().

> The device path is added to the gPlatformConsole list,

Good idea.

Two notes on that:

(4) Once you add the venhw GUID as a standalone header file (see (1)),
you won't need to duplicate the constants between patches. In
"gQemuRamfbDevicePath", you'll be able to use the EFI_GUID structure
initializer macro from the header file.

(5) Does it work if you replace ACPI_ADR_DISPLAY_TYPE_VGA with
ACPI_ADR_DISPLAY_TYPE_EXTERNAL_DIGITAL? QemuVideoDxe uses the former,
but VirtioGpuDxe uses the latter. Windows has some really obscure
requirements dependent on "ACPI display type", if I remember correctly,
and "external" looked the most robust when I last checked.

> so consplitter will pick up the ramfb device even though it isn't a
> pci display device. The firmware display will show up on ramfb in
> addition to other display devices (if any).  Is that approach ok?

Absolutely, that's what we want.

> If so I'll do that for armvirt too.

(6) No extra steps should be necessary for ArmVirtPkg; in the
PlatformBootManagerBeforeConsole() function
[ArmVirtPkg/Library/PlatformBootManagerLib/PlatformBm.c], we have

>   //
>   // Find all display class PCI devices (using the handles from the previous
>   // step), and connect them non-recursively. This should produce a number of
>   // child handles with GOPs on them.
>   //
>   FilterAndProcess (&gEfiPciIoProtocolGuid, IsPciDisplay, Connect);
>
>   //
>   // Now add the device path of all handles with GOP on them to ConOut and
>   // ErrOut.
>   //
>   FilterAndProcess (&gEfiGraphicsOutputProtocolGuid, NULL, AddOutput);

The first call does not cover the new device, but that's fine: the new
child handle with the GOP instance on it is produced by a DXE_DRIVER in
its entry point function -- that is, not by a UEFI driver that follows
the UEFI driver model --, hence it need not be connected by platform BDS
explicitly. By the time BDS is entered in the first place, the GOP will
exist already.

Therefore, the second call will simply pick up the devpath from the new
child (GOP) handle automatically, and add it to both ConOut and ErrOut.

Does it not work for you?

Thanks
Laszlo
