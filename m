Received: from eggs.gnu.org ([2001:4830:134:3::10]:50654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=86815d540=anthony.perard@citrix.com>)
	id 1gTsfI-0004bI-NE
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=86815d540=anthony.perard@citrix.com>)
	id 1gTsfH-0002XS-N0
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:09:52 -0500
Date: Mon, 3 Dec 2018 18:09:11 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181203180911.GQ14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-11-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-11-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 10/18] xen: add header and build
 dataplane/xen-qdisk.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Wed, Nov 21, 2018 at 03:12:03PM +0000, Paul Durrant wrote:
> This patch adds the transformations necessary to get dataplane/xen-qdisk.c
> to build against the new XenBus/XenDevice framework. MAINTAINERS is also
> updated due to the introduction of dataplane/xen-qdisk.h.
> 
> NOTE: Existing data structure names are retained for the moment. These will
>       be modified by subsequent patches. A typedef for XenQdiskDataPlane
>       has been added to the header (based on the old struct XenBlkDev name
>       for the moment) so that the old names don't need to leak out of the
>       dataplane code.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> diff --git a/hw/block/dataplane/xen-qdisk.c b/hw/block/dataplane/xen-qdisk.c
> index 8e4368e7af..b075aa975d 100644
> --- a/hw/block/dataplane/xen-qdisk.c
> +++ b/hw/block/dataplane/xen-qdisk.c
> @@ -5,65 +5,56 @@
>   * Based on original code (c) Gerd Hoffmann <kraxel@redhat.com>
>   */
>  
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "hw/hw.h"
> +#include "hw/xen/xen.h"

xen.h isn't needed, xen_common.h should be enough.

> +#include "hw/xen/xen_common.h"
> +#include "hw/block/block.h"

block.h isn't needed, block-backend.h should be enough.

> +#include "hw/block/xen_blkif.h"
> +#include "sysemu/blockdev.h"

blockdev.h doesn't seems to be used.

> +#include "sysemu/block-backend.h"
> +#include "sysemu/iothread.h"
> +#include "xen-qdisk.h"
> +
> @@ -227,20 +219,24 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
>                  file_blk;
>              segs[i].dest.virt = virt;
>          }
> -        segs[i].len = (ioreq->req.seg[i].last_sect
> -                       - ioreq->req.seg[i].first_sect + 1) * file_blk;
> +        segs[i].len = (ioreq->req.seg[i].last_sect -
> +                       ioreq->req.seg[i].first_sect + 1) * file_blk;
>          virt += segs[i].len;
>      }
>  
> -    rc = xen_be_copy_grant_refs(xendev, to_domain, segs, count);
> +    xen_device_copy_grant_refs(xendev, to_domain, segs, count, &local_err);
> +
> +    if (local_err) {
> +        const char *msg = error_get_pretty(local_err);
> +
> +        error_report("failed to copy data: %s", msg);
> +        error_free(local_err);

You can do the  following instead:
    error_prepend(local_err, "failed to copy data: ")
    error_report_err(local_err);

> +void xen_qdisk_dataplane_start(struct XenBlkDev *blkdev,
> +                               const unsigned int ring_ref[],
> +                               unsigned int nr_ring_ref,
> +                               unsigned int event_channel,
> +                               unsigned int protocol)
>  {
> -    struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
> +    XenDevice *xendev = blkdev->xendev;
> +    unsigned int ring_size;
> +    unsigned int i;
>  
> -    qemu_bh_schedule(blkdev->bh);
> +    blkdev->nr_ring_ref = nr_ring_ref;
> +    blkdev->ring_ref = g_new(unsigned int, nr_ring_ref);
> +
> +    for (i = 0; i < nr_ring_ref; i++) {
> +        blkdev->ring_ref[i] = ring_ref[i];
> +    }
> +
> +    blkdev->protocol = protocol;
> +
> +    ring_size = XC_PAGE_SIZE * blkdev->nr_ring_ref;
> +    switch (blkdev->protocol) {
> +    case BLKIF_PROTOCOL_NATIVE:
> +    {
> +        blkdev->max_requests = __CONST_RING_SIZE(blkif, ring_size);
> +        break;
> +    }
> +    case BLKIF_PROTOCOL_X86_32:
> +    {
> +        blkdev->max_requests = __CONST_RING_SIZE(blkif_x86_32, ring_size);
> +        break;
> +    }
> +    case BLKIF_PROTOCOL_X86_64:
> +    {
> +        blkdev->max_requests = __CONST_RING_SIZE(blkif_x86_64, ring_size);
> +        break;
> +    }
> +    default:
> +        assert(false);
> +        break;

This should return rather than keep going.
And maybe set an Error that could be added to the parameter of the
function.

> +    }
> +
> +    xen_device_set_max_grant_refs(xendev, blkdev->nr_ring_ref,
> +                                  &error_fatal);

Do we really want to exit() here if an error happen, rather than let the
caller know? (Same question for other uses of error_fatal.)

> diff --git a/hw/block/dataplane/xen-qdisk.h b/hw/block/dataplane/xen-qdisk.h
> new file mode 100644
> index 0000000000..16bcd500bf
> --- /dev/null
> +++ b/hw/block/dataplane/xen-qdisk.h
> @@ -0,0 +1,25 @@
> +/*
> + * Copyright (c) Citrix Systems Inc.
> + * All rights reserved.
> + */
> +
> +#ifndef HW_BLOCK_DATAPLANE_QDISK_H
> +#define HW_BLOCK_DATAPLANE_QDISK_H
> +
> +#include "hw/xen/xen-bus.h"
> +#include "sysemu/iothread.h"

I would add #include "hw/block/block.h" since it includes the definition
of BlockConf.

> +
> +typedef struct XenBlkDev XenQdiskDataPlane;
> +
> +XenQdiskDataPlane *xen_qdisk_dataplane_create(XenDevice *xendev,
> +                                              BlockConf *conf,
> +                                              IOThread *iothread);

Thanks,

-- 
Anthony PERARD
