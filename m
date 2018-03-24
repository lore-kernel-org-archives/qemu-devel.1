Received: from eggs.gnu.org ([2001:4830:134:3::10]:35914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ezaDU-0001AN-DM
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 23:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ezaDS-0004Tu-Ct
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 23:51:40 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:54551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ezaDS-0004TN-6n
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 23:51:38 -0400
Received: by mail-it0-x244.google.com with SMTP id w3-v6so4837605itc.4
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 20:51:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <43fc23c1-d72f-748a-5b9d-a816466d7406@redhat.com>
References: <20180323122520.11270-1-kraxel@redhat.com>
	<43fc23c1-d72f-748a-5b9d-a816466d7406@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 24 Mar 2018 03:51:36 +0000
Message-ID: <CAKv+Gu-o1CLzmoj_RdF2SFqb+u1ZEv9Q30roW6hHBpb_65M7oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>

Hi all,

On 23 March 2018 at 13:27, Laszlo Ersek <lersek@redhat.com> wrote:
> Adding Ard and Marc, and keeping the context undisturbed for his sake.
> Comments at the bottom.
>
> On 03/23/18 13:25, Gerd Hoffmann wrote:
>>   Hi,
>>
>> Ok folks, here is a experimental patch series for a legacy free boot
>> framebuffer.  If you want play with it I recommend getting the bits from
>>
>>       https://www.kraxel.org/cgit/qemu/log/?h=sirius/ramfb
>>
>> because they come with an updated seabios and a new vgabios rom and an
>> experimental OVMF build.
>>
>> Functional overview
>> -------------------
>>
>> The boot framebuffer is expected to be configured by the firmware, so it
>> uses fw_cfg as interface.  Initialization goes as follows:
>>
>>   (1) Check whenever etc/ramfb is present.
>>   (2) Allocate framebuffer from RAM.
>>   (3) Fill struct RAMFBCfg, write it to etc/ramfb.
>>
>> Done.  You can write stuff to the framebuffer now, and it should appear
>> automagically on the screen.
>>
>> Note that this isn't very efficient because it does a full display
>> update on each refresh.  No dirty tracking.  Dirty tracking would have
>> to be active for the whole ram slot, so that wouldn't be very efficient
>> either.  So it is *really* intended to be only active for a short time
>> at boot, before the guest loaded the drivers for the real display
>> hardware.
>>
>> Firmware support -- seabios
>> ---------------------------
>>
>> seavgabios is able to emulate vga text mode on top of a framebuffer, for
>> coreboot native graphics initialialization.  Which works fine for
>> everything which writes text using the vgabios interface (basically
>> everyhing which works with sgabios).
>>
>> So I hacked that up to work with ramfb.  Right now it's proof-of-concept
>> code with too much cut+paste, so it will clearly need a bunch of
>> cleanups if this approach turns out to be workable.  Look here:
>>
>>       https://www.kraxe.org/cgit/seabios/log/?h=ramfb
>>
>> Firmware support -- edk2
>> ------------------------
>>
>> There is a EFI driver too.  Likewise a hackish proof-of-concept thing,
>> clearly not in a mergeable state, but good enough for playing.  Note
>> that the build disables QemuVideoDxe and VirtoGpu drivers, so ramfb is
>> the only supported display.  Code is here:
>>
>>       https://github.com/kraxel/edk2/commits/ramfb
>>
>> Firmware blob is in pc-bios/OVMF-ramfb.fd, to be used with -bios.
>>
>> So, how to play?
>> ----------------
>>
>> There is ramfb-testdev.  Standalone device, for testing purposes.  Also
>> can listen on vga ports and logs any access, so we can see the bad boys.
>> Use "qemu -vga none -device ramfb-testdev".  Add "vgalog=on" to watch
>> guests accessing vga registers.
>>
>> There is virtio-ramfb.  Simliar to virtio-vga, but using ramfb instead of
>> adding vga compatibility.  Shows how you can wire up ramfb support to
>> some display device.  Unlike virtio-vga it should work fine on arm.  Use
>> "qemu -vga none -device virtio-ramfb" for this one.
>>
>> Tried to add qxl-ramfb, for windows guest tests, but that doesn't work
>> yet.  Don't use, unless you want help debugging ;)
>>
>> There is virtio-pci-ramfb, which provides boot display support to vgpu
>> devices.
>>
>> In general using UEFI works better than BIOS, because guests don't
>> expect legacy vga being present then.
>>
>> What works?
>> -----------
>>
>> Both windows and linux UEFI guests handle the ramfb GOP just fine.
>>
>> BIOS boot loaders for linux all use vgabios calls for text mode, so they
>> show up just fine.  Also ipxe, seabios itself of course.  So you can
>> boot up your linux guest.  vesafb works too.
>>
>> What doesn't work?
>> ------------------
>>
>> vgacon (direct vga hardware access).  Linux boots just fine
>> nevertheless, the only effect is that you don't see any boot messages
>> until the drm driver loads.
>>
>> Windows in BIOS mode.  Boot logo shows up just fine.  But at some point
>> windows does lots of vga register accesses (even though it sets the
>> video mode via vesa bios interface) and appears to be unhappy that
>> things don't work as expected because there is no vga hardware
>> emulation.
>>
>> Known issues
>> ------------
>>
>> Handover from ramfb-backed efifb to the native linux driver is tricky.
>> Usually efifb gets kicked out when the native driver loads because of
>> overlapping ressources.  With efifb being in RAM instead of using a GPU
>> PCI bar this doesn't happen though, so you'll end up with two
>> framebuffer devices.
>>

This exact issue occurs on actual hardware as well:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1755304

so if anyone has a clue how to address it, I'm all ears.


>> In case vgaarb classifies the GPU as primary display device fbcon will
>> switch all VTs over to the framebuffer device of the real GPU, so there
>> isn't a noticable difference.  Otherwise you'll end up with a
>> non-visible fbcon, because it continues to run on ramfb whereas qemu
>> switched over to the GPU because the native linux driver initialized the
>> display.
>>
>> xorg/wayland will show up on the GPU in any case because they prefer drm
>> over fbdev, so they wouldn't run on efifb.
>>
>> Not tested yet
>> --------------
>>
>> ARM.
>>
>> ramfb -> gpu handover with windows guests (only ramfb-testdev so far).
>>
>> enjoy,
>>   Gerd
>>
>> Gerd Hoffmann (7):
>>   [testing] update bios, add vgabios-ramfb
>>   [testing] add ovmf build with ramfb support
>>   hw/display: add ramfb, a simple boot framebuffer living in guest ram
>>   hw/display: add ramfb-testdev
>>   hw/display: add virtio-ramfb
>>   hw/vfio/display: add ramfb support
>>   [wip] hw/display: add qxl-ramfb
>>
>>  hw/display/qxl.h              |   2 +
>>  include/hw/display/ramfb.h    |   8 +++
>>  include/hw/vfio/vfio-common.h |   2 +
>>  hw/display/qxl.c              |  47 +++++++++++--
>>  hw/display/ramfb-testdev.c    |  96 +++++++++++++++++++++++++++
>>  hw/display/ramfb.c            |  95 +++++++++++++++++++++++++++
>>  hw/display/virtio-ramfb.c     | 149 ++++++++++++++++++++++++++++++++++++++++++
>>  hw/vfio/display.c             |  10 +++
>>  hw/vfio/pci.c                 |  15 +++++
>>  ui/spice-display.c            |   6 ++
>>  hw/display/Makefile.objs      |   5 +-
>>  pc-bios/OVMF-ramfb.fd         | Bin 0 -> 2097152 bytes
>>  pc-bios/bios-256k.bin         | Bin 262144 -> 262144 bytes
>>  pc-bios/bios.bin              | Bin 131072 -> 131072 bytes
>>  pc-bios/vgabios-ramfb.bin     | Bin 0 -> 28160 bytes
>>  15 files changed, 430 insertions(+), 5 deletions(-)
>>  create mode 100644 include/hw/display/ramfb.h
>>  create mode 100644 hw/display/ramfb-testdev.c
>>  create mode 100644 hw/display/ramfb.c
>>  create mode 100644 hw/display/virtio-ramfb.c
>>  create mode 100644 pc-bios/OVMF-ramfb.fd
>>  create mode 100644 pc-bios/vgabios-ramfb.bin
>>
>
> I believe the only point of this device model (and the associated guest
> fw driver) is Windows-on-KVM/aarch64.
>
> Would it be possible to make this stuff available for testing to the
> guy(s) who reported
> <https://bugzilla.tianocore.org/show_bug.cgi?id=785>? (Registration in
> the TianoCore bugzilla is open, and once you log in, you can read email
> addresses, and/or comment on BZs of course.)
>
> My earlier comments from
> <http://mid.mail-archive.com/4ea6f197-0aee-50d6-e53c-f98a6a8f999a@redhat.com>
> apply, to the OVMF driver:
>
>> We should make sure that any device model that combines ramfb with
>> another PCI display device is not matched by the OVMF driver for that
>> PCI display device. IOW, we should use separate PCI IDs or subsystem
>> IDs (I don't recall the details off-hand). I'd like to avoid messing
>> with the current device probing code in OVMF. It just wouldn't be nice
>> if two independent drivers (e.g. VirtioGpuDxe and a supposed
>> "RamFbDxe") bound the two interfaces at the same time.
>
> For example, virtio-vga is already problematic like this (it could be
> driven by both Virtio10Dxe+VirtioGpuDxe, and QemuVideoDxe), and it had
> to be hacked around in Virtio10Dxe. So I'm strongly in favor of a device
> model that clearly looks like one device and one device only to the full
> set of edk2 drivers, without cross-driver hacks.
>
> (I'm not saying the "combined" device models should be removed, just
> that they should never be specified on the QEMU command line when the
> guest runs OVMF or ArmVirtQemu. Unless, of course, the combined device
> models had separate PCI-level identifiers from the original PCI display
> devices, so the fw would never be tempted to bind the PCI-based drivers
> to the combined devices.)
>
> If Ard agrees that this device model & matching edk2 driver are a good
> thing for Windows-on-KVM/aarch64, I can help clean up QemuRamfbDxe. (It
> should be a DXE driver; it should start the device path with a VenHw()
> node; the memory we allocate should be reserved memory, not runtime
> memory etc...)
>
> I vaguely remember that Ard argued against allocating (reserved) RAM for
> such purposes, because it is lost for the OS even after the OS switches
> to the native display driver.
>
> BTW I recently re-read Marc's presentation on this:
>
> http://mid.mail-archive.com/86muzgb181.wl-marc.zyngier@arm.com
> http://events17.linuxfoundation.org/sites/events/files/slides/slides_10.pdf
>
> Has anyone tried the following idea from those: "perform cache
> maintenance from userspace in QEMU based on the dirty tracking bitmap
> that it uses for the VGA memory"?
>
>
> Anyway, again, personally I'm fine with this, and I'm willing to help
> clean up the edk2 driver, if:
> - Ard thinks it's a good thing for Windows-on-KVM/aarch64, and
> - the device model stays out of the way of the existing edk2 display
> drivers (if that is solved with QEMU cmdline restrictions spelled out in
> documentation, that's fine).
>
> Thanks
> Laszlo
