Received: from eggs.gnu.org ([209.51.188.92]:59579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gx8rZ-0005U0-QA
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gx8rX-00016s-JU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:19:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gx8rV-0000po-T0
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:19:27 -0500
References: <20190222054939.19739-1-kraxel@redhat.com>
	<20190222054939.19739-4-kraxel@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <cd99a2cc-a7e8-ef80-69b3-2082d28a3352@oracle.com>
Date: Fri, 22 Feb 2019 11:19:11 +0000
MIME-Version: 1.0
In-Reply-To: <20190222054939.19739-4-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] vfio/display: delay link up event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, intel-gvt-dev@lists.freedesktop.org, Liam Merwick <Liam.Merwick@oracle.com>

On 22/02/2019 05:49, Gerd Hoffmann wrote:
> Kick the display link up event with a 0.1 sec delay,
> so the guest has a chance to notice the link down first.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Depending on your thoughts on the suggestion in patch 1 regarding a 
comment at the 'err' label - another candidate in 
vfio_display_edid_link_up().

Either way:

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> ---
>   include/hw/vfio/vfio-common.h |  1 +
>   hw/vfio/display.c             | 26 +++++++++++++++++++++++---
>   2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 5f7f709b95f1..b65a2f051886 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -151,6 +151,7 @@ typedef struct VFIODisplay {
>       struct vfio_region_info *edid_info;
>       struct vfio_region_gfx_edid *edid_regs;
>       uint8_t *edid_blob;
> +    QEMUTimer *edid_link_timer;
>       struct {
>           VFIORegion buffer;
>           DisplaySurface *surface;
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 8bf7c890be96..971e801dc05c 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -38,6 +38,21 @@
>           goto err;
>   
>   
> +static void vfio_display_edid_link_up(void *opaque)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    VFIODisplay *dpy = vdev->dpy;
> +    int fd = vdev->vbasedev.fd;
> +
> +    dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_UP;
> +    pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state);
> +    trace_vfio_display_edid_link_up();
> +    return;
> +
> +err:
> +    trace_vfio_display_edid_write_error();
> +}
> +
>   static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
>                                        int prefx, int prefy)
>   {
> @@ -50,6 +65,7 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
>           .prefy = prefy ?: vdev->display_yres,
>       };
>   
> +    timer_del(dpy->edid_link_timer);
>       dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_DOWN;
>       pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state);
>       trace_vfio_display_edid_link_down();
> @@ -77,9 +93,8 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
>           goto err;
>       }
>   
> -    dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_UP;
> -    pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state);
> -    trace_vfio_display_edid_link_up();
> +    timer_mod(dpy->edid_link_timer,
> +              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 100);
>       return;
>   
>   err:
> @@ -136,6 +151,9 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
>           vdev->display_yres = dpy->edid_regs->max_yres;
>       }
>   
> +    dpy->edid_link_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
> +                                        vfio_display_edid_link_up, vdev);
> +
>       vfio_display_edid_update(vdev, true, 0, 0);
>       return;
>   
> @@ -154,6 +172,8 @@ static void vfio_display_edid_exit(VFIODisplay *dpy)
>   
>       g_free(dpy->edid_regs);
>       g_free(dpy->edid_blob);
> +    timer_del(dpy->edid_link_timer);
> +    timer_free(dpy->edid_link_timer);
>   }
>   
>   static void vfio_display_update_cursor(VFIODMABuf *dmabuf,
> 
