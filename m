Received: from eggs.gnu.org ([209.51.188.92]:56363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gkG8r-0002eH-TA
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gkG8r-0002HM-36
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:28:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gkG8q-0002FX-R0
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:28:05 -0500
Date: Thu, 17 Jan 2019 15:27:49 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190117152749.79e4737b@x1.home>
In-Reply-To: <20190111093116.17188-4-kraxel@redhat.com>
References: <20190111093116.17188-1-kraxel@redhat.com>
	<20190111093116.17188-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] vfio/display: add xres + yres
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, intel-gvt-dev@lists.freedesktop.org

On Fri, 11 Jan 2019 10:31:14 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> This allows configure the display resolution which the vgpu should use.
> The information will be passed to the guest using EDID, so the mdev
> driver must support the vfio edid region for this to work.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/vfio/pci.h     |  2 ++
>  hw/vfio/display.c | 10 ++++++++--
>  hw/vfio/pci.c     |  2 ++
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index b1ae4c0754..c11c3f1670 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -149,6 +149,8 @@ typedef struct VFIOPCIDevice {
>  #define VFIO_FEATURE_ENABLE_IGD_OPREGION \
>                                  (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT)
>      OnOffAuto display;
> +    uint32_t display_xres;
> +    uint32_t display_yres;
>      int32_t bootindex;
>      uint32_t igd_gms;
>      OffAutoPCIBAR msix_relo;
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 0ef4d77e21..3a10072823 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -43,8 +43,8 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled, int pref
>      qemu_edid_info edid = {
>          .maxx  = dpy->edid_regs->max_xres,
>          .maxy  = dpy->edid_regs->max_yres,
> -        .prefx = prefx,
> -        .prefy = prefy,
> +        .prefx = prefx ?: vdev->display_xres,
> +        .prefy = prefy ?: vdev->display_yres,
>      };
>  
>      dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_DOWN;
> @@ -120,6 +120,12 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
>      pread_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, max_yres);
>      dpy->edid_blob = g_malloc0(dpy->edid_regs->edid_max_size);
>  
> +    /* if xres + yres properties are unset use the maximum resolution */
> +    if (!vdev->display_xres)
> +        vdev->display_xres = dpy->edid_regs->max_xres;
> +    if (!vdev->display_yres)
> +        vdev->display_yres = dpy->edid_regs->max_yres;

Excessive curly braces here as well please.

> +
>      vfio_display_edid_update(vdev, true, 0, 0);
>      return;
>  
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c0cb1ec289..6f9b6992fc 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3182,6 +3182,8 @@ static Property vfio_pci_dev_properties[] = {
>      DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
>      DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>                              display, ON_OFF_AUTO_OFF),
> +    DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
> +    DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),

We're committing to supporting this then vs the x- prefix?  Shouldn't
these options generate an error if there's no display device or there's
no EDID region support to back the option?  Thanks,

Alex

>      DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
>                         intx.mmap_timeout, 1100),
>      DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
