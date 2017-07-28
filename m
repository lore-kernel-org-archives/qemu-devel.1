Received: from eggs.gnu.org ([2001:4830:134:3::10]:33592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1db9R0-0002FP-4x
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1db9Qy-0005pB-Ni
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:52:22 -0400
MIME-Version: 1.0
References: <20170728163004.21905-1-marcandre.lureau@redhat.com>
	<ff7e40d0-bf1f-e4e5-1844-f1f61e6ab50f@redhat.com>
In-Reply-To: <ff7e40d0-bf1f-e4e5-1844-f1f61e6ab50f@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 28 Jul 2017 17:52:08 +0000
Message-ID: <CAJ+F1CJrki3DvYX_oOR++n_r8_Uai9OB+LiNyDnBtiU5qebtbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, "open list:iSCSI" <qemu-block@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Max Reitz <mreitz@redhat.com>

On Fri, Jul 28, 2017 at 6:58 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 28/07/2017 18:30, Marc-Andr=C3=A9 Lureau wrote:
> > The function does the same initialization, and matches with
> > scsi_free_scsi_task() usage, and qemu doesn't need to know the
> > allocator details.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  block/iscsi.c | 30 +++++++++++++++---------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
>
> Stupid question: what's the benefit?


scsi_create/scsi_free is a library API. If they have their own allocator,
we better use it, or it may easily break, no?


> Change malloc to g_new0 in the
> existing code, and we even make it shorter...
>

replacing malloc with g_new is the subject of another upcoming series :) (
https://github.com/elmarco/clang-tools-extra/blob/master/clang-tidy/qemu/Us=
eGnewCheck.cpp
)


>
> Paolo
>
> > v2:
> >  - set cdb_size if API_VERSION < 20150510
> >
> > diff --git a/block/iscsi.c b/block/iscsi.c
> > index d557c99668..9449c90631 100644
> > --- a/block/iscsi.c
> > +++ b/block/iscsi.c
> > @@ -1013,6 +1013,7 @@ static BlockAIOCB
> *iscsi_aio_ioctl(BlockDriverState *bs,
> >      struct iscsi_context *iscsi =3D iscsilun->iscsi;
> >      struct iscsi_data data;
> >      IscsiAIOCB *acb;
> > +    int xfer_dir;
> >
> >      acb =3D qemu_aio_get(&iscsi_aiocb_info, bs, cb, opaque);
> >
> > @@ -1034,31 +1035,30 @@ static BlockAIOCB
> *iscsi_aio_ioctl(BlockDriverState *bs,
> >          return NULL;
> >      }
> >
> > -    acb->task =3D malloc(sizeof(struct scsi_task));
> > -    if (acb->task =3D=3D NULL) {
> > -        error_report("iSCSI: Failed to allocate task for scsi command.
> %s",
> > -                     iscsi_get_error(iscsi));
> > -        qemu_aio_unref(acb);
> > -        return NULL;
> > -    }
> > -    memset(acb->task, 0, sizeof(struct scsi_task));
> > -
> >      switch (acb->ioh->dxfer_direction) {
> >      case SG_DXFER_TO_DEV:
> > -        acb->task->xfer_dir =3D SCSI_XFER_WRITE;
> > +        xfer_dir =3D SCSI_XFER_WRITE;
> >          break;
> >      case SG_DXFER_FROM_DEV:
> > -        acb->task->xfer_dir =3D SCSI_XFER_READ;
> > +        xfer_dir =3D SCSI_XFER_READ;
> >          break;
> >      default:
> > -        acb->task->xfer_dir =3D SCSI_XFER_NONE;
> > +        xfer_dir =3D SCSI_XFER_NONE;
> >          break;
> >      }
> >
> > -    acb->task->cdb_size =3D acb->ioh->cmd_len;
> > -    memcpy(&acb->task->cdb[0], acb->ioh->cmdp, acb->ioh->cmd_len);
> > -    acb->task->expxferlen =3D acb->ioh->dxfer_len;
> > +    acb->task =3D scsi_create_task(acb->ioh->cmd_len, acb->ioh->cmdp,
> > +                                 xfer_dir, acb->ioh->dxfer_len);
> > +    if (acb->task =3D=3D NULL) {
> > +        error_report("iSCSI: Failed to allocate task for scsi command.
> %s",
> > +                     iscsi_get_error(iscsi));
> > +        qemu_aio_unref(acb);
> > +        return NULL;
> > +    }
> >
> > +#if LIBISCSI_API_VERSION < 20150510
> > +    acb->task->cdb_size =3D acb->ioh->cmd_len; /* fixed in libiscsi
> 1.13.0 */
> > +#endif
> >      data.size =3D 0;
> >      qemu_mutex_lock(&iscsilun->mutex);
> >      if (acb->task->xfer_dir =3D=3D SCSI_XFER_WRITE) {
> >
>
>
> --
Marc-Andr=C3=A9 Lureau
