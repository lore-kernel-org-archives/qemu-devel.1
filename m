Received: from eggs.gnu.org ([2001:4830:134:3::10]:51166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66809d549=Paul.Durrant@citrix.com>)
	id 1fJKyZ-0006ca-GP
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66809d549=Paul.Durrant@citrix.com>)
	id 1fJKyX-000778-Q6
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:37:55 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 17 May 2018 15:37:42 +0000
Message-ID: <605277850062465fb8f7d3d37c77942a@AMSPEX02CL03.citrite.net>
References: <1526571358-26685-1-git-send-email-paul.durrant@citrix.com>
	<1526571358-26685-10-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1526571358-26685-10-git-send-email-paul.durrant@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 9/9] xen_disk: be consistent with use of
 xendev and blkdev->xendev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

> -----Original Message-----
> From: Paul Durrant [mailto:paul.durrant@citrix.com]
> Sent: 17 May 2018 16:36
> To: xen-devel@lists.xenproject.org; qemu-block@nongnu.org; qemu-
> devel@nongnu.org
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; Stefano Stabellini
> <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>;
> Kevin Wolf <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>
> Subject: [PATCH v4 9/9] xen_disk: be consistent with use of xendev and
> blkdev->xendev
>=20
> Certain functions in xen_disk are called with a pointer to xendev
> (struct XenDevice *). They then use container_of() to acces the surroundi=
ng
> blkdev (struct XenBlkDev) but then in various places use &blkdev->xendev
> when use of the original xendev pointer is shorter to express and clearly
> equivalent.
>=20
> This patch is a purely cosmetic patch which makes sure there is a xendev
> pointer on stack for any function where the pointer is need on multiple
> occasions modified those functions to use it consistently.
>=20
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Apologies to Anthony. This is already:

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
>=20
> v2:
>  - Re-based
> ---
>  hw/block/xen_disk.c | 90 +++++++++++++++++++++++++++------------------
> --------
>  1 file changed, 46 insertions(+), 44 deletions(-)
>=20
> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> index 28651c5..9fbc0cd 100644
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -178,10 +178,11 @@ static void ioreq_release(struct ioreq *ioreq, bool
> finish)
>  static int ioreq_parse(struct ioreq *ioreq)
>  {
>      struct XenBlkDev *blkdev =3D ioreq->blkdev;
> +    struct XenDevice *xendev =3D &blkdev->xendev;
>      size_t len;
>      int i;
>=20
> -    xen_pv_printf(&blkdev->xendev, 3,
> +    xen_pv_printf(xendev, 3,
>                    "op %d, nr %d, handle %d, id %" PRId64 ", sector %" PR=
Id64 "\n",
>                    ioreq->req.operation, ioreq->req.nr_segments,
>                    ioreq->req.handle, ioreq->req.id, ioreq->req.sector_nu=
mber);
> @@ -199,28 +200,28 @@ static int ioreq_parse(struct ioreq *ioreq)
>      case BLKIF_OP_DISCARD:
>          return 0;
>      default:
> -        xen_pv_printf(&blkdev->xendev, 0, "error: unknown operation
> (%d)\n",
> +        xen_pv_printf(xendev, 0, "error: unknown operation (%d)\n",
>                        ioreq->req.operation);
>          goto err;
>      };
>=20
>      if (ioreq->req.operation !=3D BLKIF_OP_READ && blkdev->mode[0] !=3D =
'w') {
> -        xen_pv_printf(&blkdev->xendev, 0, "error: write req for ro devic=
e\n");
> +        xen_pv_printf(xendev, 0, "error: write req for ro device\n");
>          goto err;
>      }
>=20
>      ioreq->start =3D ioreq->req.sector_number * blkdev->file_blk;
>      for (i =3D 0; i < ioreq->req.nr_segments; i++) {
>          if (i =3D=3D BLKIF_MAX_SEGMENTS_PER_REQUEST) {
> -            xen_pv_printf(&blkdev->xendev, 0, "error: nr_segments too bi=
g\n");
> +            xen_pv_printf(xendev, 0, "error: nr_segments too big\n");
>              goto err;
>          }
>          if (ioreq->req.seg[i].first_sect > ioreq->req.seg[i].last_sect) =
{
> -            xen_pv_printf(&blkdev->xendev, 0, "error: first > last secto=
r\n");
> +            xen_pv_printf(xendev, 0, "error: first > last sector\n");
>              goto err;
>          }
>          if (ioreq->req.seg[i].last_sect * BLOCK_SIZE >=3D XC_PAGE_SIZE) =
{
> -            xen_pv_printf(&blkdev->xendev, 0, "error: page crossing\n");
> +            xen_pv_printf(xendev, 0, "error: page crossing\n");
>              goto err;
>          }
>=20
> @@ -228,7 +229,7 @@ static int ioreq_parse(struct ioreq *ioreq)
>          ioreq->size +=3D len;
>      }
>      if (ioreq->start + ioreq->size > blkdev->file_size) {
> -        xen_pv_printf(&blkdev->xendev, 0, "error: access beyond end of
> file\n");
> +        xen_pv_printf(xendev, 0, "error: access beyond end of file\n");
>          goto err;
>      }
>      return 0;
> @@ -244,7 +245,7 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
>      struct XenDevice *xendev =3D &blkdev->xendev;
>      XenGrantCopySegment segs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
>      int i, count, rc;
> -    int64_t file_blk =3D ioreq->blkdev->file_blk;
> +    int64_t file_blk =3D blkdev->file_blk;
>      bool to_domain =3D (ioreq->req.operation =3D=3D BLKIF_OP_READ);
>      void *virt =3D ioreq->buf;
>=20
> @@ -272,7 +273,7 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
>      rc =3D xen_be_copy_grant_refs(xendev, to_domain, segs, count);
>=20
>      if (rc) {
> -        xen_pv_printf(&ioreq->blkdev->xendev, 0,
> +        xen_pv_printf(xendev, 0,
>                        "failed to copy data %d\n", rc);
>          ioreq->aio_errors++;
>          return -1;
> @@ -287,11 +288,12 @@ static void qemu_aio_complete(void *opaque, int
> ret)
>  {
>      struct ioreq *ioreq =3D opaque;
>      struct XenBlkDev *blkdev =3D ioreq->blkdev;
> +    struct XenDevice *xendev =3D &blkdev->xendev;
>=20
>      aio_context_acquire(blkdev->ctx);
>=20
>      if (ret !=3D 0) {
> -        xen_pv_printf(&blkdev->xendev, 0, "%s I/O error\n",
> +        xen_pv_printf(xendev, 0, "%s I/O error\n",
>                        ioreq->req.operation =3D=3D BLKIF_OP_READ ? "read"=
 : "write");
>          ioreq->aio_errors++;
>      }
> @@ -625,16 +627,17 @@ static void blk_alloc(struct XenDevice *xendev)
>=20
>  static void blk_parse_discard(struct XenBlkDev *blkdev)
>  {
> +    struct XenDevice *xendev =3D &blkdev->xendev;
>      int enable;
>=20
>      blkdev->feature_discard =3D true;
>=20
> -    if (xenstore_read_be_int(&blkdev->xendev, "discard-enable", &enable)
> =3D=3D 0) {
> +    if (xenstore_read_be_int(xendev, "discard-enable", &enable) =3D=3D 0=
) {
>          blkdev->feature_discard =3D !!enable;
>      }
>=20
>      if (blkdev->feature_discard) {
> -        xenstore_write_be_int(&blkdev->xendev, "feature-discard", 1);
> +        xenstore_write_be_int(xendev, "feature-discard", 1);
>      }
>  }
>=20
> @@ -649,7 +652,7 @@ static int blk_init(struct XenDevice *xendev)
>      /* read xenstore entries */
>      if (blkdev->params =3D=3D NULL) {
>          char *h =3D NULL;
> -        blkdev->params =3D xenstore_read_be_str(&blkdev->xendev, "params=
");
> +        blkdev->params =3D xenstore_read_be_str(xendev, "params");
>          if (blkdev->params !=3D NULL) {
>              h =3D strchr(blkdev->params, ':');
>          }
> @@ -669,18 +672,18 @@ static int blk_init(struct XenDevice *xendev)
>          blkdev->fileproto =3D "vpc";
>      }
>      if (blkdev->mode =3D=3D NULL) {
> -        blkdev->mode =3D xenstore_read_be_str(&blkdev->xendev, "mode");
> +        blkdev->mode =3D xenstore_read_be_str(xendev, "mode");
>      }
>      if (blkdev->type =3D=3D NULL) {
> -        blkdev->type =3D xenstore_read_be_str(&blkdev->xendev, "type");
> +        blkdev->type =3D xenstore_read_be_str(xendev, "type");
>      }
>      if (blkdev->dev =3D=3D NULL) {
> -        blkdev->dev =3D xenstore_read_be_str(&blkdev->xendev, "dev");
> +        blkdev->dev =3D xenstore_read_be_str(xendev, "dev");
>      }
>      if (blkdev->devtype =3D=3D NULL) {
> -        blkdev->devtype =3D xenstore_read_be_str(&blkdev->xendev, "devic=
e-
> type");
> +        blkdev->devtype =3D xenstore_read_be_str(xendev, "device-type");
>      }
> -    directiosafe =3D xenstore_read_be_str(&blkdev->xendev, "direct-io-sa=
fe");
> +    directiosafe =3D xenstore_read_be_str(xendev, "direct-io-safe");
>      blkdev->directiosafe =3D (directiosafe && atoi(directiosafe));
>=20
>      /* do we have all we need? */
> @@ -706,10 +709,10 @@ static int blk_init(struct XenDevice *xendev)
>      /* fill info
>       * blk_connect supplies sector-size and sectors
>       */
> -    xenstore_write_be_int(&blkdev->xendev, "feature-flush-cache", 1);
> -    xenstore_write_be_int(&blkdev->xendev, "info", info);
> +    xenstore_write_be_int(xendev, "feature-flush-cache", 1);
> +    xenstore_write_be_int(xendev, "info", info);
>=20
> -    xenstore_write_be_int(&blkdev->xendev, "max-ring-page-order",
> +    xenstore_write_be_int(xendev, "max-ring-page-order",
>                            MAX_RING_PAGE_ORDER);
>=20
>      blk_parse_discard(blkdev);
> @@ -761,7 +764,7 @@ static int blk_connect(struct XenDevice *xendev)
>      }
>=20
>      /* init qemu block driver */
> -    index =3D (blkdev->xendev.dev - 202 * 256) / 16;
> +    index =3D (xendev->dev - 202 * 256) / 16;
>      blkdev->dinfo =3D drive_get(IF_XEN, 0, index);
>      if (!blkdev->dinfo) {
>          Error *local_err =3D NULL;
> @@ -773,11 +776,11 @@ static int blk_connect(struct XenDevice *xendev)
>          }
>=20
>          /* setup via xenbus -> create new block driver instance */
> -        xen_pv_printf(&blkdev->xendev, 2, "create new bdrv (xenbus
> setup)\n");
> +        xen_pv_printf(xendev, 2, "create new bdrv (xenbus setup)\n");
>          blkdev->blk =3D blk_new_open(blkdev->filename, NULL, options,
>                                     qflags, &local_err);
>          if (!blkdev->blk) {
> -            xen_pv_printf(&blkdev->xendev, 0, "error: %s\n",
> +            xen_pv_printf(xendev, 0, "error: %s\n",
>                            error_get_pretty(local_err));
>              error_free(local_err);
>              return -1;
> @@ -785,11 +788,11 @@ static int blk_connect(struct XenDevice *xendev)
>          blk_set_enable_write_cache(blkdev->blk, !writethrough);
>      } else {
>          /* setup via qemu cmdline -> already setup for us */
> -        xen_pv_printf(&blkdev->xendev, 2,
> +        xen_pv_printf(xendev, 2,
>                        "get configured bdrv (cmdline setup)\n");
>          blkdev->blk =3D blk_by_legacy_dinfo(blkdev->dinfo);
>          if (blk_is_read_only(blkdev->blk) && !readonly) {
> -            xen_pv_printf(&blkdev->xendev, 0, "Unexpected read-only driv=
e");
> +            xen_pv_printf(xendev, 0, "Unexpected read-only drive");
>              blkdev->blk =3D NULL;
>              return -1;
>          }
> @@ -802,7 +805,7 @@ static int blk_connect(struct XenDevice *xendev)
>      if (blkdev->file_size < 0) {
>          BlockDriverState *bs =3D blk_bs(blkdev->blk);
>          const char *drv_name =3D bs ? bdrv_get_format_name(bs) : NULL;
> -        xen_pv_printf(&blkdev->xendev, 1, "blk_getlength: %d (%s) | drv
> %s\n",
> +        xen_pv_printf(xendev, 1, "blk_getlength: %d (%s) | drv %s\n",
>                        (int)blkdev->file_size, strerror(-blkdev->file_siz=
e),
>                        drv_name ?: "-");
>          blkdev->file_size =3D 0;
> @@ -814,15 +817,15 @@ static int blk_connect(struct XenDevice *xendev)
>                    blkdev->file_size, blkdev->file_size >> 20);
>=20
>      /* Fill in number of sector size and number of sectors */
> -    xenstore_write_be_int(&blkdev->xendev, "sector-size", blkdev-
> >file_blk);
> -    xenstore_write_be_int64(&blkdev->xendev, "sectors",
> +    xenstore_write_be_int(xendev, "sector-size", blkdev->file_blk);
> +    xenstore_write_be_int64(xendev, "sectors",
>                              blkdev->file_size / blkdev->file_blk);
>=20
> -    if (xenstore_read_fe_int(&blkdev->xendev, "ring-page-order",
> +    if (xenstore_read_fe_int(xendev, "ring-page-order",
>                               &order) =3D=3D -1) {
>          blkdev->nr_ring_ref =3D 1;
>=20
> -        if (xenstore_read_fe_int(&blkdev->xendev, "ring-ref",
> +        if (xenstore_read_fe_int(xendev, "ring-ref",
>                                   &ring_ref) =3D=3D -1) {
>              return -1;
>          }
> @@ -839,7 +842,7 @@ static int blk_connect(struct XenDevice *xendev)
>                  return -1;
>              }
>=20
> -            if (xenstore_read_fe_int(&blkdev->xendev, key,
> +            if (xenstore_read_fe_int(xendev, key,
>                                       &ring_ref) =3D=3D -1) {
>                  g_free(key);
>                  return -1;
> @@ -854,18 +857,18 @@ static int blk_connect(struct XenDevice *xendev)
>          return -1;
>      }
>=20
> -    if (xenstore_read_fe_int(&blkdev->xendev, "event-channel",
> -                             &blkdev->xendev.remote_port) =3D=3D -1) {
> +    if (xenstore_read_fe_int(xendev, "event-channel",
> +                             &xendev->remote_port) =3D=3D -1) {
>          return -1;
>      }
>=20
> -    if (!blkdev->xendev.protocol) {
> +    if (!xendev->protocol) {
>          blkdev->protocol =3D BLKIF_PROTOCOL_NATIVE;
> -    } else if (strcmp(blkdev->xendev.protocol, XEN_IO_PROTO_ABI_NATIVE)
> =3D=3D 0) {
> +    } else if (strcmp(xendev->protocol, XEN_IO_PROTO_ABI_NATIVE) =3D=3D =
0) {
>          blkdev->protocol =3D BLKIF_PROTOCOL_NATIVE;
> -    } else if (strcmp(blkdev->xendev.protocol, XEN_IO_PROTO_ABI_X86_32)
> =3D=3D 0) {
> +    } else if (strcmp(xendev->protocol, XEN_IO_PROTO_ABI_X86_32) =3D=3D =
0) {
>          blkdev->protocol =3D BLKIF_PROTOCOL_X86_32;
> -    } else if (strcmp(blkdev->xendev.protocol, XEN_IO_PROTO_ABI_X86_64)
> =3D=3D 0) {
> +    } else if (strcmp(xendev->protocol, XEN_IO_PROTO_ABI_X86_64) =3D=3D =
0) {
>          blkdev->protocol =3D BLKIF_PROTOCOL_X86_64;
>      } else {
>          blkdev->protocol =3D BLKIF_PROTOCOL_NATIVE;
> @@ -896,7 +899,6 @@ static int blk_connect(struct XenDevice *xendev)
>      max_grants =3D blkdev->nr_ring_ref;
>=20
>      xen_be_set_max_grant_refs(xendev, max_grants);
> -
>      blkdev->sring =3D xen_be_map_grant_refs(xendev, blkdev->ring_ref,
>                                            blkdev->nr_ring_ref,
>                                            PROT_READ | PROT_WRITE);
> @@ -929,12 +931,12 @@ static int blk_connect(struct XenDevice *xendev)
>=20
>      blk_set_aio_context(blkdev->blk, blkdev->ctx);
>=20
> -    xen_be_bind_evtchn(&blkdev->xendev);
> +    xen_be_bind_evtchn(xendev);
>=20
> -    xen_pv_printf(&blkdev->xendev, 1, "ok: proto %s, nr-ring-ref %u, "
> +    xen_pv_printf(xendev, 1, "ok: proto %s, nr-ring-ref %u, "
>                    "remote port %d, local port %d\n",
> -                  blkdev->xendev.protocol, blkdev->nr_ring_ref,
> -                  blkdev->xendev.remote_port, blkdev->xendev.local_port)=
;
> +                  xendev->protocol, blkdev->nr_ring_ref,
> +                  xendev->remote_port, xendev->local_port);
>      return 0;
>  }
>=20
> @@ -952,7 +954,7 @@ static void blk_disconnect(struct XenDevice *xendev)
>          blk_unref(blkdev->blk);
>          blkdev->blk =3D NULL;
>      }
> -    xen_pv_unbind_evtchn(&blkdev->xendev);
> +    xen_pv_unbind_evtchn(xendev);
>=20
>      aio_context_release(blkdev->ctx);
>=20
> --
> 2.1.4
