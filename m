Received: from eggs.gnu.org ([2001:4830:134:3::10]:43206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=655ddeee3=Paul.Durrant@citrix.com>)
	id 1fEcWh-0003f7-Vz
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=655ddeee3=Paul.Durrant@citrix.com>)
	id 1fEcWg-0005lw-LP
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:21:39 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 4 May 2018 15:21:29 +0000
Message-ID: <80fb47d07ec1483f889319885c8869e9@AMSPEX02CL03.citrite.net>
References: <1525442134-20488-1-git-send-email-paul.durrant@citrix.com>
	<1525442134-20488-8-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1525442134-20488-8-git-send-email-paul.durrant@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 7/8] xen_disk: use a single entry iovec
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
> Sent: 04 May 2018 14:56
> To: xen-devel@lists.xenproject.org; qemu-block@nongnu.org; qemu-
> devel@nongnu.org
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; Stefano Stabellini
> <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>;
> Kevin Wolf <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>
> Subject: [PATCH v2 7/8] xen_disk: use a single entry iovec
>=20
> Since xen_disk now always copies data to and from a guest there is no nee=
d
> to maintain a vector entry corresponding to every page of a request.
> This means there is less per-request state to maintain so the ioreq
> structure can shrink significantly.
>=20
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
>=20
> v2:
>  - Re-based

Unfortunately I managed to drop a hunk during rebase and so this patch is a=
ctually broken. I'll send a rectified v3 shortly.

  Paul

> ---
>  hw/block/xen_disk.c | 71 ++++++++++++++---------------------------------=
------
>  1 file changed, 18 insertions(+), 53 deletions(-)
>=20
> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> index 28be8b6..230961f 100644
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -46,13 +46,10 @@ struct ioreq {
>      /* parsed request */
>      off_t               start;
>      QEMUIOVector        v;
> +    void                *buf;
> +    size_t              size;
>      int                 presync;
>=20
> -    /* grant mapping */
> -    uint32_t            refs[BLKIF_MAX_SEGMENTS_PER_REQUEST];
> -    void                *page[BLKIF_MAX_SEGMENTS_PER_REQUEST];
> -    void                *pages;
> -
>      /* aio status */
>      int                 aio_inflight;
>      int                 aio_errors;
> @@ -110,12 +107,10 @@ static void ioreq_reset(struct ioreq *ioreq)
>      memset(&ioreq->req, 0, sizeof(ioreq->req));
>      ioreq->status =3D 0;
>      ioreq->start =3D 0;
> +    ioreq->buf =3D NULL;
> +    ioreq->size =3D 0;
>      ioreq->presync =3D 0;
>=20
> -    memset(ioreq->refs, 0, sizeof(ioreq->refs));
> -    memset(ioreq->page, 0, sizeof(ioreq->page));
> -    ioreq->pages =3D NULL;
> -
>      ioreq->aio_inflight =3D 0;
>      ioreq->aio_errors =3D 0;
>=20
> @@ -138,7 +133,7 @@ static struct ioreq *ioreq_start(struct XenBlkDev
> *blkdev)
>          ioreq =3D g_malloc0(sizeof(*ioreq));
>          ioreq->blkdev =3D blkdev;
>          blkdev->requests_total++;
> -        qemu_iovec_init(&ioreq->v, BLKIF_MAX_SEGMENTS_PER_REQUEST);
> +        qemu_iovec_init(&ioreq->v, 1);
>      } else {
>          /* get one from freelist */
>          ioreq =3D QLIST_FIRST(&blkdev->freelist);
> @@ -183,7 +178,6 @@ static void ioreq_release(struct ioreq *ioreq, bool
> finish)
>  static int ioreq_parse(struct ioreq *ioreq)
>  {
>      struct XenBlkDev *blkdev =3D ioreq->blkdev;
> -    uintptr_t mem;
>      size_t len;
>      int i;
>=20
> @@ -230,13 +224,10 @@ static int ioreq_parse(struct ioreq *ioreq)
>              goto err;
>          }
>=20
> -        ioreq->refs[i]   =3D ioreq->req.seg[i].gref;
> -
> -        mem =3D ioreq->req.seg[i].first_sect * blkdev->file_blk;
>          len =3D (ioreq->req.seg[i].last_sect - ioreq->req.seg[i].first_s=
ect + 1) *
> blkdev->file_blk;
> -        qemu_iovec_add(&ioreq->v, (void*)mem, len);
> +        ioreq->size +=3D len;
>      }
> -    if (ioreq->start + ioreq->v.size > blkdev->file_size) {
> +    if (ioreq->start + ioreq->size > blkdev->file_size) {
>          xen_pv_printf(&blkdev->xendev, 0, "error: access beyond end of
> file\n");
>          goto err;
>      }
> @@ -247,35 +238,6 @@ err:
>      return -1;
>  }
>=20
> -static void ioreq_free_copy_buffers(struct ioreq *ioreq)
> -{
> -    int i;
> -
> -    for (i =3D 0; i < ioreq->v.niov; i++) {
> -        ioreq->page[i] =3D NULL;
> -    }
> -
> -    qemu_vfree(ioreq->pages);
> -}
> -
> -static int ioreq_init_copy_buffers(struct ioreq *ioreq)
> -{
> -    int i;
> -
> -    if (ioreq->v.niov =3D=3D 0) {
> -        return 0;
> -    }
> -
> -    ioreq->pages =3D qemu_memalign(XC_PAGE_SIZE, ioreq->v.niov *
> XC_PAGE_SIZE);
> -
> -    for (i =3D 0; i < ioreq->v.niov; i++) {
> -        ioreq->page[i] =3D ioreq->pages + i * XC_PAGE_SIZE;
> -        ioreq->v.iov[i].iov_base =3D ioreq->page[i];
> -    }
> -
> -    return 0;
> -}
> -
>  static int ioreq_grant_copy(struct ioreq *ioreq)
>  {
>      struct XenBlkDev *blkdev =3D ioreq->blkdev;
> @@ -284,6 +246,7 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
>      int i, count, rc;
>      int64_t file_blk =3D ioreq->blkdev->file_blk;
>      bool to_domain =3D (ioreq->req.operation =3D=3D BLKIF_OP_READ);
> +    void *virt =3D ioreq->buf;
>=20
>      if (ioreq->v.niov =3D=3D 0) {
>          return 0;
> @@ -293,16 +256,17 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
>=20
>      for (i =3D 0; i < count; i++) {
>          if (to_domain) {
> -            segs[i].dest.foreign.ref =3D ioreq->refs[i];
> +            segs[i].dest.foreign.ref =3D ioreq->req.seg[i].gref;
>              segs[i].dest.foreign.offset =3D ioreq->req.seg[i].first_sect=
 * file_blk;
> -            segs[i].source.virt =3D ioreq->v.iov[i].iov_base;
> +            segs[i].source.virt =3D virt;
>          } else {
> -            segs[i].source.foreign.ref =3D ioreq->refs[i];
> +            segs[i].source.foreign.ref =3D ioreq->req.seg[i].gref;
>              segs[i].source.foreign.offset =3D ioreq->req.seg[i].first_se=
ct * file_blk;
> -            segs[i].dest.virt =3D ioreq->v.iov[i].iov_base;
> +            segs[i].dest.virt =3D virt;
>          }
>          segs[i].len =3D (ioreq->req.seg[i].last_sect
>                         - ioreq->req.seg[i].first_sect + 1) * file_blk;
> +        virt +=3D segs[i].len;
>      }
>=20
>      rc =3D xen_be_copy_grant_refs(xendev, to_domain, segs, count);
> @@ -314,6 +278,7 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
>          return -1;
>      }
>=20
> +    qemu_iovec_add(&ioreq->v, ioreq->buf, ioreq->size);
>      return rc;
>  }
>=20
> @@ -348,14 +313,14 @@ static void qemu_aio_complete(void *opaque, int
> ret)
>          if (ret =3D=3D 0) {
>              ioreq_grant_copy(ioreq);
>          }
> -        ioreq_free_copy_buffers(ioreq);
> +        qemu_vfree(ioreq->buf);
>          break;
>      case BLKIF_OP_WRITE:
>      case BLKIF_OP_FLUSH_DISKCACHE:
>          if (!ioreq->req.nr_segments) {
>              break;
>          }
> -        ioreq_free_copy_buffers(ioreq);
> +        qemu_vfree(ioreq->buf);
>          break;
>      default:
>          break;
> @@ -423,12 +388,12 @@ static int ioreq_runio_qemu_aio(struct ioreq
> *ioreq)
>  {
>      struct XenBlkDev *blkdev =3D ioreq->blkdev;
>=20
> -    ioreq_init_copy_buffers(ioreq);
> +    ioreq->buf =3D qemu_memalign(XC_PAGE_SIZE, ioreq->size);
>      if (ioreq->req.nr_segments &&
>          (ioreq->req.operation =3D=3D BLKIF_OP_WRITE ||
>           ioreq->req.operation =3D=3D BLKIF_OP_FLUSH_DISKCACHE) &&
>          ioreq_grant_copy(ioreq)) {
> -        ioreq_free_copy_buffers(ioreq);
> +        qemu_vfree(ioreq->buf);
>          goto err;
>      }
>=20
> --
> 2.1.4
