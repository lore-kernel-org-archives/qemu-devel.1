Received: from eggs.gnu.org ([2001:4830:134:3::10]:52544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cfs7S-0006DY-8r
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 12:51:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cfs7O-0003Ic-3Z
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 12:51:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cfs7N-0003IV-QG
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 12:51:22 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEE7E3D953
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 17:51:21 +0000 (UTC)
References: <1487603763-14932-1-git-send-email-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <611fb3de-e096-da28-52b6-c6fd642b1033@redhat.com>
Date: Mon, 20 Feb 2017 18:51:18 +0100
MIME-Version: 1.0
In-Reply-To: <1487603763-14932-1-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RfC PATCH] vga: wire up -g <width>x<height>
 switch for virtio and qxl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 02/20/17 16:16, Gerd Hoffmann wrote:
> FIXME: qxl not working yet.
> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  arch_init.c             |  8 ++++++--
>  hw/display/qxl.c        | 18 ++++++++++++++++++
>  hw/display/virtio-gpu.c |  9 +++++++--
>  qemu-options.hx         |  6 ++++--
>  4 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/arch_init.c b/arch_init.c
> index 0810116..9cd3dfc 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -34,14 +34,18 @@
>  #include "hw/acpi/acpi.h"
>  #include "qemu/help_option.h"
>  
> -#ifdef TARGET_SPARC
> +#if defined(TARGET_SPARC)
>  int graphic_width = 1024;
>  int graphic_height = 768;
>  int graphic_depth = 8;
> -#else
> +#elif defined(TARGET_PPC)
>  int graphic_width = 800;
>  int graphic_height = 600;
>  int graphic_depth = 32;
> +#else
> +int graphic_width;
> +int graphic_height;
> +int graphic_depth;
>  #endif
>  
>  
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index af4c0ca..c29ee7b 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -368,6 +368,24 @@ static void init_qxl_rom(PCIQXLDevice *d)
>      rom->num_pages          = cpu_to_le32(num_pages);
>      rom->ram_header_offset  = cpu_to_le32(d->vga.vram_size - ram_header_size);
>  
> +#if 0
> +    /*
> +     * FIXME:
> +     *
> +     * Not working that simple.  Seems the driver doesn't check this
> +     * without notification.  So we have to try something more clever,
> +     * and pay attention that we don't screw up the spice guest agent
> +     * monitor configuration ...
> +     */
> +    if (graphic_width && graphic_height) {
> +        rom->client_monitors_config.count = 1;
> +        rom->client_monitors_config.heads[0].left = 0;
> +        rom->client_monitors_config.heads[0].top = 0;
> +        rom->client_monitors_config.heads[0].right = graphic_width;
> +        rom->client_monitors_config.heads[0].bottom = graphic_height;
> +    }
> +#endif
> +
>      d->shadow_rom = *rom;
>      d->rom        = rom;
>      d->modes      = modes;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 9b530ab..04ba221 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1170,8 +1170,13 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>      virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
>                  g->config_size);
>  
> -    g->req_state[0].width = 1024;
> -    g->req_state[0].height = 768;
> +    if (graphic_width && graphic_height) {
> +        g->req_state[0].width = graphic_width;
> +        g->req_state[0].height = graphic_height;
> +    } else {
> +        g->req_state[0].width = 1024;
> +        g->req_state[0].height = 768;
> +    }
>  
>      if (virtio_gpu_virgl_enabled(g->conf)) {
>          /* use larger control queue in 3d mode */
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5633d39..734a87b 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1233,11 +1233,13 @@ ETEXI
>  
>  DEF("g", 1, QEMU_OPTION_g ,
>      "-g WxH[xDEPTH]  Set the initial graphical resolution and depth\n",
> -    QEMU_ARCH_PPC | QEMU_ARCH_SPARC)
> +    QEMU_ARCH_ALL)
>  STEXI
>  @item -g @var{width}x@var{height}[x@var{depth}]
>  @findex -g
> -Set the initial graphical resolution and depth (PPC, SPARC only).
> +Set the initial graphical resolution and depth.
> +On PPC and SPARC the firmware will configure the display accordingly.
> +On other archs this is supported by virtio and qxl (FIXME) display adapters.
>  ETEXI
>  
>  DEF("vnc", HAS_ARG, QEMU_OPTION_vnc ,
> 

Alas, it's not so simple with edk2 :(

(1) In edk2 / PI / UEFI, instances of graphics hardware are driven by
various UEFI_DRIVER modules. UEFI_DRIVER modules have access to device
registers alright, but UEFI_DRIVER is also the module type that is
dispatched among the latest during boot. QXL and virtio-gpu-pci are
driven by UEFI_DRIVER modules.

(2) Console output is multiplexed (mirrored) to all graphics devices, by
ConSplitterDxe (another UEFI_DRIVER). ConSplitterDxe builds an
intersection of graphics resolutions that are supported by *all*
EFI_GRAPHICS_OUTPUT_PROTOCOL instances in the system (*), and then
provides a synthetic EFI_GRAPHICS_OUTPUT_PROTOCOL on top. Blits to this
synthetic GOP are then reflected to all the real GOPs. Mode changes
(which are restricted to the intersection, see before) are also
reflected to all GOPs.

((*) The intersection is never empty, because the UEFI spec "more or
less" requires all GOPs to support 800x60x32 and/or 640x480x32.)

(3) The "preferred resolution" is tracked by two dynamic PCDs (more or
less: firmware-wide global variables), namely
PcdVideoHorizontalResolution and PcdVideoVerticalResolution. The
defaults are 800 and 600, respectively.

These PCDs determine the resolution that you see on the TianoCore splash
screen, which -- see (2) above -- is reflected to all graphics devices,
and thereby determines their individual resolutions too.

The PCDs also affect UEFI applications like "grub". (They can change the
resolution just fine, if they want to, but this is what they get first.)

What's more, if a guest OS does not have a native driver for some of the
graphics hardware, and it just inherits the framebuffer from the
respective GOP (assuming the GOP has a framebuffer -- virtio-gpu-pci
doesn't), then the above settings *also* determine the resolution used /
inherited by the guest OS. (This is for example the case if you boot
Windows 8 on QXL, and don't install the guest drivers.)

Long story short, if an edk2 platform like OVMF or ArmVirtQemu wants to
change the default resolution for the UEFI console (as reflected to all
display hardware), it has to change these PCDs dynamically.

And, here comes the kicker: those PCDs need to be set *without* specific
hardware access; namely, in the DXE phase, by a DXE driver that we
usually call "PlatformDxe". That driver is dispatched before UEFI_DRIVER
modules -- i.e., before graphics hardware access is available.

(4) In OVMF and ArmVirtQemu, we use OvmfPkg/PlatformDxe for this, which:

- maintains the preferred video resolution in a UEFI global variable,

- at boot it reads the variable and sets the PCDs from it, in its entry
point function,

- PlatformDxe also provides a visual HII form for setting the
resolution. (HII stands for "Human Interface Infrastructure", so this is
basically a TUI dialog). The form is available under Device Manager |
OVMF Platform Configuration, after you hit ESC on the TianoCore splash
screen.

Note that changing the resolution here only affects the *next* boot --
so you need a reset for the new settings to take effect --, because
re-setting the PCDs here would be too late; we're "too deep" into the
boot process (we're already in the BDS phase).

(5) Summary: setting these registers will have no effect on OVMF and
ArmVirtQemu, only on the guest OS's native drivers. Given that the
default is 800x600x32 for both of these firmwares, I think they should
be fine already.

(IIRC, Dave's complaint was "too large resolutions", and anyway the
firmware is very soon replaced by the native guest OS drivers).

*If* this is not acceptable, that is, we absolutely want to control the
firmware too, then the preference will have to be exposed via fw_cfg,
and I'll have to find a way for PlatformDxe to prioritize that
resolution, over whatever can be read from the UEFI variable.

For now, my request is that the QEMU manual be a bit more precise on
this, such as:

  Set the initial graphical resolution and depth.

  This setting may be masked by guest firmware temporarily.

  On PPC and SPARC, the guest firmware will configure the display from
  this setting, and the guest OS will inherit the display resolution
  and depth.

  On x86 and ARM, if the guest firmware is an edk2 (UEFI) platform,
  the firmware may initially configure the display according to its own,
  persistent, independent settings. The guest OS drivers, once loaded,
  should adhere to "-g" however, for virtio and qxl adapters.

Thanks
Laszlo
