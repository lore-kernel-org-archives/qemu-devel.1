Received: from eggs.gnu.org ([2001:4830:134:3::10]:41567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=869086d29=anthony.perard@citrix.com>)
	id 1gU9tn-0006oS-81
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=869086d29=anthony.perard@citrix.com>)
	id 1gU9tm-0003Ko-3L
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:33:59 -0500
Date: Tue, 4 Dec 2018 12:33:49 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181204123349.GU14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-15-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-15-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 14/18] xen: add implementations of
 xen-qdisk connect and disconnect functions...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Nov 21, 2018 at 03:12:07PM +0000, Paul Durrant wrote:
> diff --git a/hw/block/xen-qdisk.c b/hw/block/xen-qdisk.c
> index 35f7b70480..8c88393832 100644
> --- a/hw/block/xen-qdisk.c
> +++ b/hw/block/xen-qdisk.c
>  static void xen_qdisk_connect(XenQdiskDevice *qdiskdev, Error **errp)
>  {
>      XenQdiskVdev *vdev = &qdiskdev->vdev;
> +    XenDevice *xendev = XEN_DEVICE(qdiskdev);
> +    unsigned int order, nr_ring_ref, *ring_ref, event_channel, protocol;
> +    char *str;
>  
>      trace_xen_qdisk_connect(vdev->disk, vdev->partition);
> +
> +    if (xen_device_frontend_scanf(xendev, "ring-page-order", "%u",
> +                                  &order) != 1) {
> +        nr_ring_ref = 1;
> +        ring_ref = g_new(unsigned int, nr_ring_ref);
> +
> +        if (xen_device_frontend_scanf(xendev, "ring-ref", "%u",
> +                                      &ring_ref[0]) != 1) {
> +            error_setg(errp, "failed to read ring-ref");

Don't you need to free `ring_ref`?

> +            return;
> +        }
[...]

> diff --git a/include/hw/xen/xen-qdisk.h b/include/hw/xen/xen-qdisk.h
> index ade0866037..d7dd2bf0ee 100644
> --- a/include/hw/xen/xen-qdisk.h
> +++ b/include/hw/xen/xen-qdisk.h
> @@ -6,7 +6,15 @@
>  #ifndef HW_XEN_QDISK_H
>  #define HW_XEN_QDISK_H
>  
> +#include "hw/xen/xen.h"
>  #include "hw/xen/xen-bus.h"
> +#include "hw/block/block.h"
> +#include "hw/block/xen_blkif.h"
> +#include "hw/block/dataplane/xen-qdisk.h"
> +#include "sysemu/blockdev.h"
> +#include "sysemu/iothread.h"
> +#include "sysemu/block-backend.h"
> +#include "sysemu/iothread.h"

You don't need that many includes, especially not iothread.h twice ;-).

I think those new includes would be enough:
#include "hw/block/block.h"; for BlockConf
#include "sysemu/iothread.h"
#include "hw/block/dataplane/xen-qdisk.h"

>  
>  typedef enum XenQdiskVdevType {
>      XEN_QDISK_VDEV_TYPE_DP,
> @@ -33,6 +41,10 @@ typedef struct XenQdiskDevice XenQdiskDevice;
>  struct XenQdiskDevice {
>      XenDevice xendev;
>      XenQdiskVdev vdev;
> +    BlockConf conf;
> +    unsigned int max_ring_page_order;
> +    IOThread *iothread;
> +    XenQdiskDataPlane *dataplane;
>  };
>  
>  #endif /* HW_XEN_QDISK_H */

-- 
Anthony PERARD
