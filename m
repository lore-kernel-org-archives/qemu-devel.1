Received: from eggs.gnu.org ([2001:4830:134:3::10]:44046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ejneg-0007Ev-1x
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:58:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ejnec-00070b-VF
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:58:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:57144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ejnec-0006x7-PO
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:58:26 -0500
References: <CAJSP0QX8zOCKK9HTf4=VddZcYqWmuuC+L5PWiEwVtsnxPd8V2w@mail.gmail.com>
	<a7d46cd7-aba7-ebae-e1a0-4d321586705f@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6073fac9-f16c-27a5-b62e-3cfa893fa2ff@suse.de>
Date: Thu, 8 Feb 2018 15:58:21 +0100
MIME-Version: 1.0
In-Reply-To: <a7d46cd7-aba7-ebae-e1a0-4d321586705f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] libiscsi task cancellation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, ronnie sahlberg <ronniesahlberg@gmail.com>
Cc: Felipe Franciosi <felipe@nutanix.com>, Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>

On 02/08/2018 03:14 PM, Paolo Bonzini wrote:
> On 08/02/2018 15:08, Stefan Hajnoczi wrote:
>> Now on to libiscsi:
>>
>> The iscsi_task_mgmt_async() API documentation says:
>>
>>   * abort_task will also cancel the scsi task. The callback for the
>> scsi task will be invoked with
>>   *            SCSI_STATUS_CANCELLED
>>
>> I see that the ABORT TASK TMF response invokes the user's
>> iscsi_task_mgmt_async() callback but not the command callback.  I'm
>> not sure how the command callback is invoked with
>> SCSI_STATUS_CANCELLED unless libiscsi is relying on the target to send
>> that response.
>>
>> Is libiscsi honoring its iscsi_task_mgmt_async() contract?
>=20
> No, and QEMU is assuming the "wrong" behavior:
>=20
> static void
> iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *comm=
and_data,
>                     void *private_data)
> {
>     IscsiAIOCB *acb =3D private_data;
>=20
>     acb->status =3D -ECANCELED;
>     iscsi_schedule_bh(acb);
> }
>=20
The definition of ABORT TASK TMF in SAM is pretty much useless.
To quote:

A response of FUNCTION COMPLETE shall indicate that the task was aborted
or was not in the task set.

IE we have no idea if we ever managed to abort the task; if the task had
been in-flight by the time we've send the TMF we'll be getting a
FUNCTION COMPLETE, too.

So most FC HBA firmware implement the abort task with just a blacklist;
the TMF will be returned immediately and the command response will be
dropped if and when is arrives.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: F. Imend=C3=B6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=C3=BCrnberg)
