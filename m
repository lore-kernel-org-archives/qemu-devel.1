Received: from eggs.gnu.org ([2001:4830:134:3::10]:47832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSlx-0000Ap-R8
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSlu-00042L-P4
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:54:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dTSlu-000425-FS
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:54:10 -0400
Date: Fri, 7 Jul 2017 14:54:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170707145402.30187319@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499423224-23060-4-git-send-email-thuth@redhat.com>
References: <1499423224-23060-1-git-send-email-thuth@redhat.com>
	<1499423224-23060-4-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/8] pc-bios/s390-ccw: Move
 virtio-block related functions into a separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On Fri,  7 Jul 2017 12:26:59 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The netboot code is going to link against the code from virtio.c, too,
> so we've got to move the virtio-block related code out of the way.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/Makefile     |   2 +-
>  pc-bios/s390-ccw/main.c       |   2 +-
>  pc-bios/s390-ccw/s390-ccw.h   |   2 +-
>  pc-bios/s390-ccw/virtio-blk.c | 296 ++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio.c     | 273 +-------------------------------------
>  pc-bios/s390-ccw/virtio.h     |   4 +
>  6 files changed, 307 insertions(+), 272 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/virtio-blk.c
> 

> diff --git a/pc-bios/s390-ccw/virtio-blk.c b/pc-bios/s390-ccw/virtio-blk.c
> new file mode 100644
> index 0000000..6cb77bc
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-blk.c
> @@ -0,0 +1,296 @@
> +/*
> + * Virtio driver bits
> + *
> + * Copyright (c) 2013 Alexander Graf <agraf@suse.de>

The original code carries the same copyright notice, but there's a lot
of IBM code in there. Just saying.

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#include "libc.h"
> +#include "s390-ccw.h"
> +#include "virtio.h"
> +#include "virtio-scsi.h"
> +
> +static int virtio_blk_read_many(VDev *vdev,
> +                                ulong sector, void *load_addr, int sec_num)
> +{
> +    VirtioBlkOuthdr out_hdr;
> +    u8 status;
> +    VRing *vr = &vdev->vrings[vdev->cmd_vr_idx];
> +
> +    /* Tell the host we want to read */
> +    out_hdr.type = VIRTIO_BLK_T_IN;
> +    out_hdr.ioprio = 99;
> +    out_hdr.sector = virtio_sector_adjust(sector);
> +
> +    vring_send_buf(vr, &out_hdr, sizeof(out_hdr), VRING_DESC_F_NEXT);
> +
> +    /* This is where we want to receive data */
> +    vring_send_buf(vr, load_addr, virtio_get_block_size() * sec_num,
> +                   VRING_DESC_F_WRITE | VRING_HIDDEN_IS_CHAIN |
> +                   VRING_DESC_F_NEXT);
> +
> +    /* status field */
> +    vring_send_buf(vr, &status, sizeof(u8),
> +                   VRING_DESC_F_WRITE | VRING_HIDDEN_IS_CHAIN);
> +
> +    /* Now we can tell the host to read */
> +    vring_wait_reply();
> +
> +    if (drain_irqs(vr->schid)) {
> +        /* Well, whatever status is supposed to contain... */
> +        status = 1;
> +    }
> +    return status;
> +}
> +
> +int virtio_read_many(ulong sector, void *load_addr, int sec_num)
> +{
> +    VDev *vdev = virtio_get_device();
> +
> +    switch (vdev->senseid.cu_model) {
> +    case VIRTIO_ID_BLOCK:
> +        return virtio_blk_read_many(vdev, sector, load_addr, sec_num);
> +    case VIRTIO_ID_SCSI:
> +        return virtio_scsi_read_many(vdev, sector, load_addr, sec_num);

This is scsi, not blk. Should virtio_read_many() stay in virtio.c?

> +    }
> +    panic("\n! No readable IPL device !\n");
> +    return -1;
> +}

(...)

> +void virtio_assume_scsi(void)
> +{
> +    VDev *vdev = virtio_get_device();
> +
> +    switch (vdev->senseid.cu_model) {
> +    case VIRTIO_ID_BLOCK:
> +        vdev->guessed_disk_nature = VIRTIO_GDN_SCSI;
> +        vdev->config.blk.blk_size = VIRTIO_SCSI_BLOCK_SIZE;
> +        vdev->config.blk.physical_block_exp = 0;
> +        vdev->blk_factor = 1;
> +        break;
> +    case VIRTIO_ID_SCSI:
> +        vdev->scsi_block_size = VIRTIO_SCSI_BLOCK_SIZE;

More scsi. Maybe the file just needs a different name :)

> +        break;
> +    }
> +}

General ack on splitting out this code.
