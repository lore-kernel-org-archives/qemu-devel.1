Received: from eggs.gnu.org ([2001:4830:134:3::10]:43660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1elzbt-0002RE-7y
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1elzbs-00078q-6M
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:08:41 -0500
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 14 Feb 2018 16:08:19 +0000
Message-ID: <14919042-6A53-4A58-9666-25EF7677FD87@nutanix.com>
References: <20180203061621.7033-1-stefanha@redhat.com>
	<20180203061621.7033-4-stefanha@redhat.com>
In-Reply-To: <20180203061621.7033-4-stefanha@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7024B086320A1D4DA8A647C3937565D4@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block/iscsi: fix ioctl cancel
 use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter
	Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>, Sreejith Mohanan <sreejit.mohanan@nutanix.com>


> On 3 Feb 2018, at 06:16, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> iscsi_aio_cancel() does not increment the request's reference count,
> causing a use-after-free when ABORT TASK finishes after the request has
> already completed.
>=20
> There are some additional issues with iscsi_aio_cancel():
> 1. Several ABORT TASKs may be sent for the same task if
>   iscsi_aio_cancel() is invoked multiple times.  It's better to avoid
>   this just in case the command identifier is reused.
> 2. The iscsilun->mutex protection is missing in iscsi_aio_cancel().
>=20
> Reported-by: Felipe Franciosi <felipe@nutanix.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Felipe Franciosi <felipe@nutanix.com>
Tested-by: Sreejith Mohanan <sreejit.mohanan@nutanix.com>

> ---
> block/iscsi.c | 21 ++++++++++++++++++---
> 1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 1cfe1c647c..8140baac15 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -119,6 +119,7 @@ typedef struct IscsiAIOCB {
> #ifdef __linux__
>     sg_io_hdr_t *ioh;
> #endif
> +    bool cancelled;
> } IscsiAIOCB;
>=20
> /* libiscsi uses time_t so its enough to process events every second */
> @@ -282,6 +283,7 @@ static void iscsi_co_init_iscsitask(IscsiLun *iscsilu=
n, struct IscsiTask *iTask)
>     };
> }
>=20
> +/* Called (via iscsi_service) with QemuMutex held. */
> static void
> iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *comman=
d_data,
>                     void *private_data)
> @@ -290,6 +292,7 @@ iscsi_abort_task_cb(struct iscsi_context *iscsi, int =
status, void *command_data,
>=20
>     acb->status =3D -ECANCELED;
>     iscsi_schedule_bh(acb);
> +    qemu_aio_unref(acb); /* acquired in iscsi_aio_cancel() */
> }
>=20
> static void
> @@ -298,14 +301,25 @@ iscsi_aio_cancel(BlockAIOCB *blockacb)
>     IscsiAIOCB *acb =3D (IscsiAIOCB *)blockacb;
>     IscsiLun *iscsilun =3D acb->iscsilun;
>=20
> -    if (acb->status !=3D -EINPROGRESS) {
> +    qemu_mutex_lock(&iscsilun->mutex);
> +
> +    /* If it was cancelled or completed already, our work is done here *=
/
> +    if (acb->cancelled || acb->status !=3D -EINPROGRESS) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
>         return;
>     }
>=20
> +    acb->cancelled =3D true;
> +
> +    qemu_aio_ref(acb); /* released in iscsi_abort_task_cb() */
> +
>     /* send a task mgmt call to the target to cancel the task on the targ=
et */
> -    iscsi_task_mgmt_abort_task_async(iscsilun->iscsi, acb->task,
> -                                     iscsi_abort_task_cb, acb);
> +    if (iscsi_task_mgmt_abort_task_async(iscsilun->iscsi, acb->task,
> +                                         iscsi_abort_task_cb, acb) < 0) =
{
> +        qemu_aio_unref(acb); /* since iscsi_abort_task_cb() won't be cal=
led */
> +    }
>=20
> +    qemu_mutex_unlock(&iscsilun->mutex);
> }
>=20
> static const AIOCBInfo iscsi_aiocb_info =3D {
> @@ -1000,6 +1014,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState=
 *bs,
>     acb->bh          =3D NULL;
>     acb->status      =3D -EINPROGRESS;
>     acb->ioh         =3D buf;
> +    acb->cancelled   =3D false;
>=20
>     if (req !=3D SG_IO) {
>         iscsi_ioctl_handle_emulated(acb, req, buf);
> --=20
> 2.14.3
>=20
