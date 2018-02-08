Received: from eggs.gnu.org ([2001:4830:134:3::10]:52571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1ejoDE-0004ki-HZ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1ejoDB-00067e-8X
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:34:12 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:40256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1ejoDA-00065I-VT
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:34:09 -0500
From: Felipe Franciosi <felipe@nutanix.com>
Date: Thu, 8 Feb 2018 15:33:54 +0000
Message-ID: <729A4CEB-EB30-475E-AED3-1C024DDFBA71@nutanix.com>
References: <CAJSP0QX8zOCKK9HTf4=VddZcYqWmuuC+L5PWiEwVtsnxPd8V2w@mail.gmail.com>
	<a7d46cd7-aba7-ebae-e1a0-4d321586705f@redhat.com>
	<6073fac9-f16c-27a5-b62e-3cfa893fa2ff@suse.de>
In-Reply-To: <6073fac9-f16c-27a5-b62e-3cfa893fa2ff@suse.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C4C44639F3008B45AB784E51A9F7EA32@namprd02.prod.outlook.com>
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
To: Hannes Reinecke <hare@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, ronnie sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>


> On 8 Feb 2018, at 14:58, Hannes Reinecke <hare@suse.de> wrote:
>=20
> On 02/08/2018 03:14 PM, Paolo Bonzini wrote:
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
>>=20
> The definition of ABORT TASK TMF in SAM is pretty much useless.
> To quote:
>=20
> A response of FUNCTION COMPLETE shall indicate that the task was aborted
> or was not in the task set.
>=20
> IE we have no idea if we ever managed to abort the task; if the task had
> been in-flight by the time we've send the TMF we'll be getting a
> FUNCTION COMPLETE, too.

Why is that a problem? I am under the impression that drivers can cope with=
 that. You can complete the TMF after the original request completed (succe=
ssfully or not).

> So most FC HBA firmware implement the abort task with just a blacklist;
> the TMF will be returned immediately and the command response will be
> dropped if and when is arrives.

That sounds very dangerous, but maybe it's safe for FC (I don't know detail=
s about it). What happens if you complete the TMF immediately and the OS be=
lieves the IO (eg. a write) has been aborted, then issue another write for =
the same LBA and that completes successfully before the original request (w=
hich is still outstanding)?

In our implementation, we sit on the TMF and wait for the original request =
to either complete or abort. Only then we respond the TMF to the issuing OS=
.

Cheers,
Felipe=
