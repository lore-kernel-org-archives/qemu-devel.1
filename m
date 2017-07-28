Received: from eggs.gnu.org ([2001:4830:134:3::10]:59508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1db8ad-0005Xw-AD
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1db8ac-0005cO-B3
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:58:15 -0400
References: <20170728163004.21905-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff7e40d0-bf1f-e4e5-1844-f1f61e6ab50f@redhat.com>
Date: Fri, 28 Jul 2017 18:58:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170728163004.21905-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] iscsi: use scsi_create_task()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>

On 28/07/2017 18:30, Marc-Andr=C3=A9 Lureau wrote:
> The function does the same initialization, and matches with
> scsi_free_scsi_task() usage, and qemu doesn't need to know the
> allocator details.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/iscsi.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Stupid question: what's the benefit?  Change malloc to g_new0 in the
existing code, and we even make it shorter...

Paolo

> v2:
>  - set cdb_size if API_VERSION < 20150510
>=20
> diff --git a/block/iscsi.c b/block/iscsi.c
> index d557c99668..9449c90631 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -1013,6 +1013,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverSta=
te *bs,
>      struct iscsi_context *iscsi =3D iscsilun->iscsi;
>      struct iscsi_data data;
>      IscsiAIOCB *acb;
> +    int xfer_dir;
> =20
>      acb =3D qemu_aio_get(&iscsi_aiocb_info, bs, cb, opaque);
> =20
> @@ -1034,31 +1035,30 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverS=
tate *bs,
>          return NULL;
>      }
> =20
> -    acb->task =3D malloc(sizeof(struct scsi_task));
> -    if (acb->task =3D=3D NULL) {
> -        error_report("iSCSI: Failed to allocate task for scsi command.=
 %s",
> -                     iscsi_get_error(iscsi));
> -        qemu_aio_unref(acb);
> -        return NULL;
> -    }
> -    memset(acb->task, 0, sizeof(struct scsi_task));
> -
>      switch (acb->ioh->dxfer_direction) {
>      case SG_DXFER_TO_DEV:
> -        acb->task->xfer_dir =3D SCSI_XFER_WRITE;
> +        xfer_dir =3D SCSI_XFER_WRITE;
>          break;
>      case SG_DXFER_FROM_DEV:
> -        acb->task->xfer_dir =3D SCSI_XFER_READ;
> +        xfer_dir =3D SCSI_XFER_READ;
>          break;
>      default:
> -        acb->task->xfer_dir =3D SCSI_XFER_NONE;
> +        xfer_dir =3D SCSI_XFER_NONE;
>          break;
>      }
> =20
> -    acb->task->cdb_size =3D acb->ioh->cmd_len;
> -    memcpy(&acb->task->cdb[0], acb->ioh->cmdp, acb->ioh->cmd_len);
> -    acb->task->expxferlen =3D acb->ioh->dxfer_len;
> +    acb->task =3D scsi_create_task(acb->ioh->cmd_len, acb->ioh->cmdp,
> +                                 xfer_dir, acb->ioh->dxfer_len);
> +    if (acb->task =3D=3D NULL) {
> +        error_report("iSCSI: Failed to allocate task for scsi command.=
 %s",
> +                     iscsi_get_error(iscsi));
> +        qemu_aio_unref(acb);
> +        return NULL;
> +    }
> =20
> +#if LIBISCSI_API_VERSION < 20150510
> +    acb->task->cdb_size =3D acb->ioh->cmd_len; /* fixed in libiscsi 1.=
13.0 */
> +#endif
>      data.size =3D 0;
>      qemu_mutex_lock(&iscsilun->mutex);
>      if (acb->task->xfer_dir =3D=3D SCSI_XFER_WRITE) {
>=20
