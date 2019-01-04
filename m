Received: from eggs.gnu.org ([208.118.235.92]:43910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=900e14805=Paul.Durrant@citrix.com>)
	id 1gfLeQ-0000eu-CC
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=900e14805=Paul.Durrant@citrix.com>)
	id 1gfLeI-0001IB-O9
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:20:20 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 4 Jan 2019 09:09:36 +0000
Message-ID: <f04669ca236a46808397642e77e96764@AMSPEX02CL03.citrite.net>
References: <20181220171439.11159-1-paul.durrant@citrix.com>
	<20181220171439.11159-10-paul.durrant@citrix.com>
In-Reply-To: <20181220171439.11159-10-paul.durrant@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 09/18] xen: remove unnecessary code from
 dataplane/xen-block.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Ping Anthony?

I dropped your R-b on v6 since I screwed it up. Are you ok with v7? It shou=
ld be back to how it was but with some whitespace fixes.

  Paul

> -----Original Message-----
> From: Paul Durrant [mailto:paul.durrant@citrix.com]
> Sent: 20 December 2018 17:15
> To: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; Anthony Perard
> <anthony.perard@citrix.com>; Stefano Stabellini <sstabellini@kernel.org>;
> Stefan Hajnoczi <stefanha@redhat.com>; Kevin Wolf <kwolf@redhat.com>; Max
> Reitz <mreitz@redhat.com>
> Subject: [PATCH v7 09/18] xen: remove unnecessary code from dataplane/xen=
-
> block.c
>=20
> Not all of the code duplicated from xen_disk.c is required as the basis
> for
> the new dataplane implementation so this patch removes extraneous code,
> along with the legacy #includes and calls to the legacy xen_pv_printf()
> function. Error messages are changed to be reported using error_report().
>=20
> NOTE: The code is still not yet built. Further transformations will be
>       required to make it correctly interface to the new XenBus/XenDevice
>       framework. They will be delivered in a subsequent patch.
>=20
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
>=20
> v6:
>  - v5 was messed up so fix the boilerplate again
>  - Drop Anthony's R-b so he can check it
>=20
> v2:
>  - Leave existing boilerplate alone, other than removing the now-incorrec=
t
>    description
> ---
>  hw/block/dataplane/xen-block.c | 429 ++-------------------------------
>  1 file changed, 23 insertions(+), 406 deletions(-)
>=20
> diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-
> block.c
> index 9fae50534e..228472320a 100644
> --- a/hw/block/dataplane/xen-block.c
> +++ b/hw/block/dataplane/xen-block.c
> @@ -1,45 +1,23 @@
>  /*
> - *  xen paravirt block device backend
> + * Copyright (c) 2018  Citrix Systems Inc.
> + * (c) Gerd Hoffmann <kraxel@redhat.com>
>   *
> - *  (c) Gerd Hoffmann <kraxel@redhat.com>
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; under version 2 of the License.
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; under version 2 of the License.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
>   *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> + * You should have received a copy of the GNU General Public License
> along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>   *
> - *  You should have received a copy of the GNU General Public License
> along
> - *  with this program; if not, see <http://www.gnu.org/licenses/>.
> - *
> - *  Contributions after 2012-01-13 are licensed under the terms of the
> - *  GNU GPL, version 2 or (at your option) any later version.
> + * Contributions after 2012-01-13 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.
>   */
>=20
> -#include "qemu/osdep.h"
> -#include "qemu/units.h"
> -#include <sys/ioctl.h>
> -#include <sys/uio.h>
> -
> -#include "hw/hw.h"
> -#include "hw/xen/xen_backend.h"
> -#include "xen_blkif.h"
> -#include "sysemu/blockdev.h"
> -#include "sysemu/iothread.h"
> -#include "sysemu/block-backend.h"
> -#include "qapi/error.h"
> -#include "qapi/qmp/qdict.h"
> -#include "qapi/qmp/qstring.h"
> -#include "trace.h"
> -
> -/* ------------------------------------------------------------- */
> -
> -#define BLOCK_SIZE  512
> -#define IOCB_COUNT  (BLKIF_MAX_SEGMENTS_PER_REQUEST + 2)
> -
>  struct ioreq {
>      blkif_request_t     req;
>      int16_t             status;
> @@ -101,8 +79,6 @@ struct XenBlkDev {
>      AioContext          *ctx;
>  };
>=20
> -/* ------------------------------------------------------------- */
> -
>  static void ioreq_reset(struct ioreq *ioreq)
>  {
>      memset(&ioreq->req, 0, sizeof(ioreq->req));
> @@ -183,11 +159,6 @@ static int ioreq_parse(struct ioreq *ioreq)
>      size_t len;
>      int i;
>=20
> -    xen_pv_printf(
> -        xendev, 3,
> -        "op %d, nr %d, handle %d, id %" PRId64 ", sector %" PRId64 "\n",
> -        ioreq->req.operation, ioreq->req.nr_segments,
> -        ioreq->req.handle, ioreq->req.id, ioreq->req.sector_number);
>      switch (ioreq->req.operation) {
>      case BLKIF_OP_READ:
>          break;
> @@ -202,28 +173,27 @@ static int ioreq_parse(struct ioreq *ioreq)
>      case BLKIF_OP_DISCARD:
>          return 0;
>      default:
> -        xen_pv_printf(xendev, 0, "error: unknown operation (%d)\n",
> -                      ioreq->req.operation);
> +        error_report("error: unknown operation (%d)", ioreq-
> >req.operation);
>          goto err;
>      };
>=20
>      if (ioreq->req.operation !=3D BLKIF_OP_READ && blkdev->mode[0] !=3D =
'w')
> {
> -        xen_pv_printf(xendev, 0, "error: write req for ro device\n");
> +        error_report("error: write req for ro device");
>          goto err;
>      }
>=20
>      ioreq->start =3D ioreq->req.sector_number * blkdev->file_blk;
>      for (i =3D 0; i < ioreq->req.nr_segments; i++) {
>          if (i =3D=3D BLKIF_MAX_SEGMENTS_PER_REQUEST) {
> -            xen_pv_printf(xendev, 0, "error: nr_segments too big\n");
> +            error_report("error: nr_segments too big");
>              goto err;
>          }
>          if (ioreq->req.seg[i].first_sect > ioreq->req.seg[i].last_sect) =
{
> -            xen_pv_printf(xendev, 0, "error: first > last sector\n");
> +            error_report("error: first > last sector");
>              goto err;
>          }
>          if (ioreq->req.seg[i].last_sect * BLOCK_SIZE >=3D XC_PAGE_SIZE) =
{
> -            xen_pv_printf(xendev, 0, "error: page crossing\n");
> +            error_report("error: page crossing");
>              goto err;
>          }
>=20
> @@ -232,7 +202,7 @@ static int ioreq_parse(struct ioreq *ioreq)
>          ioreq->size +=3D len;
>      }
>      if (ioreq->start + ioreq->size > blkdev->file_size) {
> -        xen_pv_printf(xendev, 0, "error: access beyond end of file\n");
> +        error_report("error: access beyond end of file");
>          goto err;
>      }
>      return 0;
> @@ -278,8 +248,7 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
>      rc =3D xen_be_copy_grant_refs(xendev, to_domain, segs, count);
>=20
>      if (rc) {
> -        xen_pv_printf(xendev, 0,
> -                      "failed to copy data %d\n", rc);
> +        error_report("failed to copy data %d", rc);
>          ioreq->aio_errors++;
>          return -1;
>      }
> @@ -298,8 +267,9 @@ static void qemu_aio_complete(void *opaque, int ret)
>      aio_context_acquire(blkdev->ctx);
>=20
>      if (ret !=3D 0) {
> -        xen_pv_printf(xendev, 0, "%s I/O error\n",
> -                      ioreq->req.operation =3D=3D BLKIF_OP_READ ? "read"=
 :
> "write");
> +        error_report("%s I/O error",
> +                     ioreq->req.operation =3D=3D BLKIF_OP_READ ?
> +                     "read" : "write");
>          ioreq->aio_errors++;
>      }
>=20
> @@ -605,8 +575,6 @@ static void blk_handle_requests(struct XenBlkDev
> *blkdev)
>      }
>  }
>=20
> -/* ------------------------------------------------------------- */
> -
>  static void blk_bh(void *opaque)
>  {
>      struct XenBlkDev *blkdev =3D opaque;
> @@ -634,346 +602,6 @@ static void blk_alloc(struct XenLegacyDevice
> *xendev)
>      blkdev->bh =3D aio_bh_new(blkdev->ctx, blk_bh, blkdev);
>  }
>=20
> -static void blk_parse_discard(struct XenBlkDev *blkdev)
> -{
> -    struct XenLegacyDevice *xendev =3D &blkdev->xendev;
> -    int enable;
> -
> -    blkdev->feature_discard =3D true;
> -
> -    if (xenstore_read_be_int(xendev, "discard-enable", &enable) =3D=3D 0=
) {
> -        blkdev->feature_discard =3D !!enable;
> -    }
> -
> -    if (blkdev->feature_discard) {
> -        xenstore_write_be_int(xendev, "feature-discard", 1);
> -    }
> -}
> -
> -static int blk_init(struct XenLegacyDevice *xendev)
> -{
> -    struct XenBlkDev *blkdev =3D container_of(xendev, struct XenBlkDev,
> xendev);
> -    int info =3D 0;
> -    char *directiosafe =3D NULL;
> -
> -    trace_xen_disk_init(xendev->name);
> -
> -    /* read xenstore entries */
> -    if (blkdev->params =3D=3D NULL) {
> -        char *h =3D NULL;
> -        blkdev->params =3D xenstore_read_be_str(xendev, "params");
> -        if (blkdev->params !=3D NULL) {
> -            h =3D strchr(blkdev->params, ':');
> -        }
> -        if (h !=3D NULL) {
> -            blkdev->fileproto =3D blkdev->params;
> -            blkdev->filename  =3D h + 1;
> -            *h =3D 0;
> -        } else {
> -            blkdev->fileproto =3D "<unset>";
> -            blkdev->filename  =3D blkdev->params;
> -        }
> -    }
> -    if (!strcmp("aio", blkdev->fileproto)) {
> -        blkdev->fileproto =3D "raw";
> -    }
> -    if (!strcmp("vhd", blkdev->fileproto)) {
> -        blkdev->fileproto =3D "vpc";
> -    }
> -    if (blkdev->mode =3D=3D NULL) {
> -        blkdev->mode =3D xenstore_read_be_str(xendev, "mode");
> -    }
> -    if (blkdev->type =3D=3D NULL) {
> -        blkdev->type =3D xenstore_read_be_str(xendev, "type");
> -    }
> -    if (blkdev->dev =3D=3D NULL) {
> -        blkdev->dev =3D xenstore_read_be_str(xendev, "dev");
> -    }
> -    if (blkdev->devtype =3D=3D NULL) {
> -        blkdev->devtype =3D xenstore_read_be_str(xendev, "device-type");
> -    }
> -    directiosafe =3D xenstore_read_be_str(xendev, "direct-io-safe");
> -    blkdev->directiosafe =3D (directiosafe && atoi(directiosafe));
> -
> -    /* do we have all we need? */
> -    if (blkdev->params =3D=3D NULL ||
> -        blkdev->mode =3D=3D NULL   ||
> -        blkdev->type =3D=3D NULL   ||
> -        blkdev->dev =3D=3D NULL) {
> -        goto out_error;
> -    }
> -
> -    /* read-only ? */
> -    if (strcmp(blkdev->mode, "w")) {
> -        info  |=3D VDISK_READONLY;
> -    }
> -
> -    /* cdrom ? */
> -    if (blkdev->devtype && !strcmp(blkdev->devtype, "cdrom")) {
> -        info  |=3D VDISK_CDROM;
> -    }
> -
> -    blkdev->file_blk  =3D BLOCK_SIZE;
> -
> -    /* fill info
> -     * blk_connect supplies sector-size and sectors
> -     */
> -    xenstore_write_be_int(xendev, "feature-flush-cache", 1);
> -    xenstore_write_be_int(xendev, "info", info);
> -
> -    xenstore_write_be_int(xendev, "max-ring-page-order",
> -                          MAX_RING_PAGE_ORDER);
> -
> -    blk_parse_discard(blkdev);
> -
> -    g_free(directiosafe);
> -    return 0;
> -
> -out_error:
> -    g_free(blkdev->params);
> -    blkdev->params =3D NULL;
> -    g_free(blkdev->mode);
> -    blkdev->mode =3D NULL;
> -    g_free(blkdev->type);
> -    blkdev->type =3D NULL;
> -    g_free(blkdev->dev);
> -    blkdev->dev =3D NULL;
> -    g_free(blkdev->devtype);
> -    blkdev->devtype =3D NULL;
> -    g_free(directiosafe);
> -    blkdev->directiosafe =3D false;
> -    return -1;
> -}
> -
> -static int blk_connect(struct XenLegacyDevice *xendev)
> -{
> -    struct XenBlkDev *blkdev =3D container_of(xendev, struct XenBlkDev,
> xendev);
> -    int index, qflags;
> -    bool readonly =3D true;
> -    bool writethrough =3D true;
> -    int order, ring_ref;
> -    unsigned int ring_size, max_grants;
> -    unsigned int i;
> -
> -    trace_xen_disk_connect(xendev->name);
> -
> -    /* read-only ? */
> -    if (blkdev->directiosafe) {
> -        qflags =3D BDRV_O_NOCACHE | BDRV_O_NATIVE_AIO;
> -    } else {
> -        qflags =3D 0;
> -        writethrough =3D false;
> -    }
> -    if (strcmp(blkdev->mode, "w") =3D=3D 0) {
> -        qflags |=3D BDRV_O_RDWR;
> -        readonly =3D false;
> -    }
> -    if (blkdev->feature_discard) {
> -        qflags |=3D BDRV_O_UNMAP;
> -    }
> -
> -    /* init qemu block driver */
> -    index =3D (xendev->dev - 202 * 256) / 16;
> -    blkdev->dinfo =3D drive_get(IF_XEN, 0, index);
> -    if (!blkdev->dinfo) {
> -        Error *local_err =3D NULL;
> -        QDict *options =3D NULL;
> -
> -        if (strcmp(blkdev->fileproto, "<unset>")) {
> -            options =3D qdict_new();
> -            qdict_put_str(options, "driver", blkdev->fileproto);
> -        }
> -
> -        /* setup via xenbus -> create new block driver instance */
> -        xen_pv_printf(xendev, 2, "create new bdrv (xenbus setup)\n");
> -        blkdev->blk =3D blk_new_open(blkdev->filename, NULL, options,
> -                                   qflags, &local_err);
> -        if (!blkdev->blk) {
> -            xen_pv_printf(xendev, 0, "error: %s\n",
> -                          error_get_pretty(local_err));
> -            error_free(local_err);
> -            return -1;
> -        }
> -        blk_set_enable_write_cache(blkdev->blk, !writethrough);
> -    } else {
> -        /* setup via qemu cmdline -> already setup for us */
> -        xen_pv_printf(xendev, 2,
> -                      "get configured bdrv (cmdline setup)\n");
> -        blkdev->blk =3D blk_by_legacy_dinfo(blkdev->dinfo);
> -        if (blk_is_read_only(blkdev->blk) && !readonly) {
> -            xen_pv_printf(xendev, 0, "Unexpected read-only drive");
> -            blkdev->blk =3D NULL;
> -            return -1;
> -        }
> -        /* blkdev->blk is not create by us, we get a reference
> -         * so we can blk_unref() unconditionally */
> -        blk_ref(blkdev->blk);
> -    }
> -    blk_attach_dev_legacy(blkdev->blk, blkdev);
> -    blkdev->file_size =3D blk_getlength(blkdev->blk);
> -    if (blkdev->file_size < 0) {
> -        BlockDriverState *bs =3D blk_bs(blkdev->blk);
> -        const char *drv_name =3D bs ? bdrv_get_format_name(bs) : NULL;
> -        xen_pv_printf(xendev, 1, "blk_getlength: %d (%s) | drv %s\n",
> -                      (int)blkdev->file_size, strerror(-blkdev-
> >file_size),
> -                      drv_name ?: "-");
> -        blkdev->file_size =3D 0;
> -    }
> -
> -    xen_pv_printf(xendev, 1, "type \"%s\", fileproto \"%s\", filename
> \"%s\","
> -                  " size %" PRId64 " (%" PRId64 " MB)\n",
> -                  blkdev->type, blkdev->fileproto, blkdev->filename,
> -                  blkdev->file_size, blkdev->file_size / MiB);
> -
> -    /* Fill in number of sector size and number of sectors */
> -    xenstore_write_be_int(xendev, "sector-size", blkdev->file_blk);
> -    xenstore_write_be_int64(xendev, "sectors",
> -                            blkdev->file_size / blkdev->file_blk);
> -
> -    if (xenstore_read_fe_int(xendev, "ring-page-order",
> -                             &order) =3D=3D -1) {
> -        blkdev->nr_ring_ref =3D 1;
> -
> -        if (xenstore_read_fe_int(xendev, "ring-ref",
> -                                 &ring_ref) =3D=3D -1) {
> -            return -1;
> -        }
> -        blkdev->ring_ref[0] =3D ring_ref;
> -
> -    } else if (order >=3D 0 && order <=3D MAX_RING_PAGE_ORDER) {
> -        blkdev->nr_ring_ref =3D 1 << order;
> -
> -        for (i =3D 0; i < blkdev->nr_ring_ref; i++) {
> -            char *key;
> -
> -            key =3D g_strdup_printf("ring-ref%u", i);
> -            if (!key) {
> -                return -1;
> -            }
> -
> -            if (xenstore_read_fe_int(xendev, key,
> -                                     &ring_ref) =3D=3D -1) {
> -                g_free(key);
> -                return -1;
> -            }
> -            blkdev->ring_ref[i] =3D ring_ref;
> -
> -            g_free(key);
> -        }
> -    } else {
> -        xen_pv_printf(xendev, 0, "invalid ring-page-order: %d\n",
> -                      order);
> -        return -1;
> -    }
> -
> -    if (xenstore_read_fe_int(xendev, "event-channel",
> -                             &xendev->remote_port) =3D=3D -1) {
> -        return -1;
> -    }
> -
> -    if (!xendev->protocol) {
> -        blkdev->protocol =3D BLKIF_PROTOCOL_NATIVE;
> -    } else if (strcmp(xendev->protocol, XEN_IO_PROTO_ABI_NATIVE) =3D=3D =
0) {
> -        blkdev->protocol =3D BLKIF_PROTOCOL_NATIVE;
> -    } else if (strcmp(xendev->protocol, XEN_IO_PROTO_ABI_X86_32) =3D=3D =
0) {
> -        blkdev->protocol =3D BLKIF_PROTOCOL_X86_32;
> -    } else if (strcmp(xendev->protocol, XEN_IO_PROTO_ABI_X86_64) =3D=3D =
0) {
> -        blkdev->protocol =3D BLKIF_PROTOCOL_X86_64;
> -    } else {
> -        blkdev->protocol =3D BLKIF_PROTOCOL_NATIVE;
> -    }
> -
> -    ring_size =3D XC_PAGE_SIZE * blkdev->nr_ring_ref;
> -    switch (blkdev->protocol) {
> -    case BLKIF_PROTOCOL_NATIVE:
> -    {
> -        blkdev->max_requests =3D __CONST_RING_SIZE(blkif, ring_size);
> -        break;
> -    }
> -    case BLKIF_PROTOCOL_X86_32:
> -    {
> -        blkdev->max_requests =3D __CONST_RING_SIZE(blkif_x86_32,
> ring_size);
> -        break;
> -    }
> -    case BLKIF_PROTOCOL_X86_64:
> -    {
> -        blkdev->max_requests =3D __CONST_RING_SIZE(blkif_x86_64,
> ring_size);
> -        break;
> -    }
> -    default:
> -        return -1;
> -    }
> -
> -    /* Add on the number needed for the ring pages */
> -    max_grants =3D blkdev->nr_ring_ref;
> -
> -    xen_be_set_max_grant_refs(xendev, max_grants);
> -    blkdev->sring =3D xen_be_map_grant_refs(xendev, blkdev->ring_ref,
> -                                          blkdev->nr_ring_ref,
> -                                          PROT_READ | PROT_WRITE);
> -    if (!blkdev->sring) {
> -        return -1;
> -    }
> -
> -    switch (blkdev->protocol) {
> -    case BLKIF_PROTOCOL_NATIVE:
> -    {
> -        blkif_sring_t *sring_native =3D blkdev->sring;
> -        BACK_RING_INIT(&blkdev->rings.native, sring_native, ring_size);
> -        break;
> -    }
> -    case BLKIF_PROTOCOL_X86_32:
> -    {
> -        blkif_x86_32_sring_t *sring_x86_32 =3D blkdev->sring;
> -
> -        BACK_RING_INIT(&blkdev->rings.x86_32_part, sring_x86_32,
> ring_size);
> -        break;
> -    }
> -    case BLKIF_PROTOCOL_X86_64:
> -    {
> -        blkif_x86_64_sring_t *sring_x86_64 =3D blkdev->sring;
> -
> -        BACK_RING_INIT(&blkdev->rings.x86_64_part, sring_x86_64,
> ring_size);
> -        break;
> -    }
> -    }
> -
> -    blk_set_aio_context(blkdev->blk, blkdev->ctx);
> -
> -    xen_be_bind_evtchn(xendev);
> -
> -    xen_pv_printf(xendev, 1, "ok: proto %s, nr-ring-ref %u, "
> -                  "remote port %d, local port %d\n",
> -                  xendev->protocol, blkdev->nr_ring_ref,
> -                  xendev->remote_port, xendev->local_port);
> -    return 0;
> -}
> -
> -static void blk_disconnect(struct XenLegacyDevice *xendev)
> -{
> -    struct XenBlkDev *blkdev =3D container_of(xendev, struct XenBlkDev,
> xendev);
> -
> -    trace_xen_disk_disconnect(xendev->name);
> -
> -    aio_context_acquire(blkdev->ctx);
> -
> -    if (blkdev->blk) {
> -        blk_set_aio_context(blkdev->blk, qemu_get_aio_context());
> -        blk_detach_dev(blkdev->blk, blkdev);
> -        blk_unref(blkdev->blk);
> -        blkdev->blk =3D NULL;
> -    }
> -    xen_pv_unbind_evtchn(xendev);
> -
> -    aio_context_release(blkdev->ctx);
> -
> -    if (blkdev->sring) {
> -        xen_be_unmap_grant_refs(xendev, blkdev->sring,
> -                                blkdev->nr_ring_ref);
> -        blkdev->sring =3D NULL;
> -    }
> -}
> -
>  static int blk_free(struct XenLegacyDevice *xendev)
>  {
>      struct XenBlkDev *blkdev =3D container_of(xendev, struct XenBlkDev,
> xendev);
> @@ -1006,14 +634,3 @@ static void blk_event(struct XenLegacyDevice
> *xendev)
>=20
>      qemu_bh_schedule(blkdev->bh);
>  }
> -
> -struct XenDevOps xen_blkdev_ops =3D {
> -    .flags      =3D DEVOPS_FLAG_NEED_GNTDEV,
> -    .size       =3D sizeof(struct XenBlkDev),
> -    .alloc      =3D blk_alloc,
> -    .init       =3D blk_init,
> -    .initialise =3D blk_connect,
> -    .disconnect =3D blk_disconnect,
> -    .event      =3D blk_event,
> -    .free       =3D blk_free,
> -};
> --
> 2.20.1.2.gb21ebb6
