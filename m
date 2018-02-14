Received: from eggs.gnu.org ([2001:4830:134:3::10]:45429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1elzff-0006l4-8m
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1elzfb-0001UQ-9x
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:12:35 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:47332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1elzfa-0001Tx-V9
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:12:31 -0500
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 14 Feb 2018 16:12:16 +0000
Message-ID: <0C3855FD-CC94-4A02-B89F-338A21CA344E@nutanix.com>
References: <CAJSP0QX8zOCKK9HTf4=VddZcYqWmuuC+L5PWiEwVtsnxPd8V2w@mail.gmail.com>
	<a7d46cd7-aba7-ebae-e1a0-4d321586705f@redhat.com>
	<CAJSP0QVn2Mxw=BDGaBerLQp3-RDtHaBjPDWe1je9pTw_T7i44A@mail.gmail.com>
In-Reply-To: <CAJSP0QVn2Mxw=BDGaBerLQp3-RDtHaBjPDWe1je9pTw_T7i44A@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E4ECA0660E0B94B974B0C3C9E6CED65@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] libiscsi task cancellation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Hannes Reinecke <hare@suse.de>, Sreejith Mohanan <sreejit.mohanan@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, ronnie sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>


> On 8 Feb 2018, at 15:08, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> On Thu, Feb 8, 2018 at 2:14 PM, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
>> On 08/02/2018 15:08, Stefan Hajnoczi wrote:
>>> Now on to libiscsi:
>>>=20
>>> The iscsi_task_mgmt_async() API documentation says:
>>>=20
>>>  * abort_task will also cancel the scsi task. The callback for the
>>> scsi task will be invoked with
>>>  *            SCSI_STATUS_CANCELLED
>>>=20
>>> I see that the ABORT TASK TMF response invokes the user's
>>> iscsi_task_mgmt_async() callback but not the command callback.  I'm
>>> not sure how the command callback is invoked with
>>> SCSI_STATUS_CANCELLED unless libiscsi is relying on the target to send
>>> that response.
>>>=20
>>> Is libiscsi honoring its iscsi_task_mgmt_async() contract?
>>=20
>> No, and QEMU is assuming the "wrong" behavior:
>>=20
>> static void
>> iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *comma=
nd_data,
>>                    void *private_data)
>> {
>>    IscsiAIOCB *acb =3D private_data;
>>=20
>>    acb->status =3D -ECANCELED;
>>    iscsi_schedule_bh(acb);
>> }
>=20
> FWIW My recent use-after-free fix series is still pending review:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.org_arch=
ive_html_qemu-2Ddevel_2018-2D02_msg00570.html&d=3DDwIBaQ&c=3Ds883GpUCOChKOH=
iocYtGcg&r=3DCCrJKVC5zGot8PrnI-iYe00MdX4pgdQfMRigp14Ptmk&m=3DE9W0Q_a83TeT4c=
8PEn--G-Dk9dZ5UGO2CZRZzal0Sak&s=3DBC2keaBG9mG3yYI_IYPwAoA3_I69KmPZordXnDguF=
0I&e=3D
>=20
> It changes the code and fixes a QEMU bug, but it doesn't address the
> iscsi_task_mgmt_async() issue we're discussing now.
>=20
> I think users *can* work around the iscsi_task_mgmt_async() issue as foll=
ows:
>=20
> If the command callback has not been invoked yet when the ABORT TASK
> TMF callback is invoked, call iscsi_scsi_cancel_task() so that
> libiscsi invokes the command callback with SCSI_STATUS_CANCELLED and
> frees the PDU.
>=20
> Here is how that looks in QEMU:
>=20
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 8140baac15..7b4b43dc55 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -290,8 +290,12 @@ iscsi_abort_task_cb(struct iscsi_context *iscsi,
> int status, void *command_data,
> {
>     IscsiAIOCB *acb =3D private_data;
>=20
> -    acb->status =3D -ECANCELED;
> -    iscsi_schedule_bh(acb);
> +    /* If the command callback hasn't been called yet, drop the task */
> +    if (!acb->bh) {
> +        /* Call iscsi_aio_ioctl_cb() with SCSI_STATUS_CANCELLED */
> +        iscsi_scsi_cancel_task(iscsi, acb->task);
> +    }
> +
>     qemu_aio_unref(acb); /* acquired in iscsi_aio_cancel() */
> }

Reviewed-by: Felipe Franciosi <felipe@nutanix.com>
Tested-by: Sreejith Mohanan <sreejit.mohanan@nutanix.com>

We've been over this and Sreejith confirmed this fixes the issue we are see=
ing. Nevertheless, I think we should continue this conversation to clarify =
what are the expectations with regards to requests that may still be inflig=
ht.

F.=
