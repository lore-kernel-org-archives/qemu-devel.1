Received: from eggs.gnu.org ([2001:4830:134:3::10]:55572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=86438351b=anthony.perard@citrix.com>)
	id 1gSOpg-0003RY-EM
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=86438351b=anthony.perard@citrix.com>)
	id 1gSOpe-0002SI-LO
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:06:28 -0500
Date: Thu, 29 Nov 2018 16:05:41 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181129160541.GG14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-4-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-4-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 03/18] xen: introduce 'xen-qdisk'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Wed, Nov 21, 2018 at 03:11:56PM +0000, Paul Durrant wrote:
> This patch adds a new XenDevice: 'xen-qdisk' [1]. This will eventually
> replace the 'xen_disk' legacy PV backend but it is illustrative to build
> up the implementation incrementally, along with the XenBus/XenDevice
> framework. Subsequent patches will therefore add to this device's
> implementation as new features are added to the framework.
> 
> After this patch has been applied it is possible to instantiate a new
> 'xen-qdisk' device with a single 'vdev' parameter, which accepts values
> adhering to the Xen VBD naming scheme [2]. For example, a command-line
> instantiation of a xen-qdisk can be done with an argument similar to the
> following:
> 
> -device xen-qdisk,vdev=hda

That works when QEMU boot, but doing the same thing once the guest have
booted, via QMP, doesn't. Here is the result (tested in qmp-shell):

(QEMU) device_add driver=xen-qdisk vdev=hda
{
    "error": {
        "class": "GenericError", 
        "desc": "Bus 'xen-bus.0' does not support hotplugging"
    }
}

That's probably why I've asked about the hotplug capability on the
previous patch.

> The implementation of the vdev parameter formulates the appropriate VBD
> number for use in the PV protocol.
> 
> [1] The name 'qdisk' as always been the name given to the QEMU
>     implementation of the Xen PV block protocol backend implementation
> [2] http://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=docs/man/xen-vbd-interface.markdown.7

Maybe a link to the generated docs would be better:
https://xenbits.xen.org/docs/unstable/man/xen-vbd-interface.7.html

Also, it would be useful to have the same link in the source code.

> diff --git a/hw/block/xen-qdisk.c b/hw/block/xen-qdisk.c
> new file mode 100644
> index 0000000000..72122073f7
> --- /dev/null
> +++ b/hw/block/xen-qdisk.c
[...]
> +static char *disk_to_vbd_name(unsigned int disk)
> +{
> +    unsigned int len = DIV_ROUND_UP(disk, 26);
> +    char *name = g_malloc0(len + 1);
> +
> +    do {
> +        name[len--] = 'a' + (disk % 26);
> +        disk /= 26;
> +    } while (disk != 0);
> +    assert(len == 0);
> +
> +    return name;
> +}

That function doesn't work.

For a simple xvdp, (so disk==15), it return "", I mean "\0p".

For a more complicated 'xvdbhwza', we have len == 22901. And the assert failed.

Maybe the recursing algo in libxl would be fine, with a buffer that is
big enough, and could probably be on the stack (in _get_vdev).

> +
> +    switch (vdev->type) {
> +    case XEN_QDISK_VDEV_TYPE_DP:
> +    case XEN_QDISK_VDEV_TYPE_XVD:
> +        if (vdev->disk < (1 << 4) && vdev->partition < (1 << 4)) {
> +            vdev->number = (202 << 8) | (vdev->disk << 4) |
> +                vdev->partition;
> +        } else if (vdev->disk < (1 << 20) && vdev->partition < (1 << 8)) {
> +            vdev->number = (1 << 28) | (vdev->disk << 8) |
> +                vdev->partition;
> +        } else {
> +            goto invalid;
> +        }
> +        break;
> +
> +    case XEN_QDISK_VDEV_TYPE_HD:
> +        if ((vdev->disk == 0 || vdev->disk == 1) &&
> +            vdev->partition < (1 << 4)) {

I think that should be:

    vdev->partition < (1 << 6)

Because hd disk have 0..63 partitions.

> +            vdev->number = (3 << 8) | (vdev->disk << 6) | vdev->partition;
> +        } else if ((vdev->disk == 2 || vdev->disk == 3) &&
> +                   vdev->partition < (1 << 4)) {

same here.

> +            vdev->number = (22 << 8) | ((vdev->disk - 2) << 6) |
> +                vdev->partition;
> +        } else {
> +            goto invalid;
> +        }
> +        break;
> +
> +    case XEN_QDISK_VDEV_TYPE_SD:
> +        if (vdev->disk < (1 << 4) && vdev->partition < (1 << 4)) {
> +            vdev->number = (8 << 8) | (vdev->disk << 4) | vdev->partition;
> +        } else {
> +            goto invalid;
> +        }
> +        break;
> +
> +    default:
> +        goto invalid;
> +    }
> +
> +    g_free(str);
> +    vdev->valid = true;
> +    return;
> +
> +invalid:
> +    error_setg(errp, "invalid virtual disk specifier");
> +    g_free(str);

:(, g_free is called twice.

maybe we could have:
    vdev->valid=true;
    out:
      if (!vdev->valid)
        error_setg(...);
      g_free;

> diff --git a/include/hw/xen/xen-qdisk.h b/include/hw/xen/xen-qdisk.h
> new file mode 100644
> index 0000000000..ade0866037
> --- /dev/null
> +++ b/include/hw/xen/xen-qdisk.h
> @@ -0,0 +1,38 @@
> +/*
> + * Copyright (c) Citrix Systems Inc.
> + * All rights reserved.
> + */
> +
> +#ifndef HW_XEN_QDISK_H
> +#define HW_XEN_QDISK_H
> +
> +#include "hw/xen/xen-bus.h"
> +
> +typedef enum XenQdiskVdevType {
> +    XEN_QDISK_VDEV_TYPE_DP,

Maybe we could set type_dp value to 1, so that, when vdev->type isn't
set, we can detect it later.


> +    XEN_QDISK_VDEV_TYPE_XVD,
> +    XEN_QDISK_VDEV_TYPE_HD,
> +    XEN_QDISK_VDEV_TYPE_SD,
> +    XEN_QDISK_VDEV_TYPE__MAX
> +} XenQdiskVdevType;

Thanks,

-- 
Anthony PERARD
