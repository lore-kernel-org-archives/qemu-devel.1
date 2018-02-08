Received: from eggs.gnu.org ([2001:4830:134:3::10]:47098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ejns6-0003B6-TB
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ejns1-000051-0p
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:12:22 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ejns0-0008WR-QJ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:12:16 -0500
Received: by mail-wr0-x234.google.com with SMTP id s5so5082027wra.0
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 07:12:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6073fac9-f16c-27a5-b62e-3cfa893fa2ff@suse.de>
References: <CAJSP0QX8zOCKK9HTf4=VddZcYqWmuuC+L5PWiEwVtsnxPd8V2w@mail.gmail.com>
	<a7d46cd7-aba7-ebae-e1a0-4d321586705f@redhat.com>
	<6073fac9-f16c-27a5-b62e-3cfa893fa2ff@suse.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 8 Feb 2018 15:12:15 +0000
Message-ID: <CAJSP0QW6FsR9O17wjwJku-4c8n=4mddapvOoTYKk5kG9NRqtmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, ronnie sahlberg <ronniesahlberg@gmail.com>, Felipe Franciosi <felipe@nutanix.com>, Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Feb 8, 2018 at 2:58 PM, Hannes Reinecke <hare@suse.de> wrote:
> On 02/08/2018 03:14 PM, Paolo Bonzini wrote:
>> On 08/02/2018 15:08, Stefan Hajnoczi wrote:
>>> Now on to libiscsi:
>>>
>>> The iscsi_task_mgmt_async() API documentation says:
>>>
>>>   * abort_task will also cancel the scsi task. The callback for the
>>> scsi task will be invoked with
>>>   *            SCSI_STATUS_CANCELLED
>>>
>>> I see that the ABORT TASK TMF response invokes the user's
>>> iscsi_task_mgmt_async() callback but not the command callback.  I'm
>>> not sure how the command callback is invoked with
>>> SCSI_STATUS_CANCELLED unless libiscsi is relying on the target to send
>>> that response.
>>>
>>> Is libiscsi honoring its iscsi_task_mgmt_async() contract?
>>
>> No, and QEMU is assuming the "wrong" behavior:
>>
>> static void
>> iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *command_data,
>>                     void *private_data)
>> {
>>     IscsiAIOCB *acb = private_data;
>>
>>     acb->status = -ECANCELED;
>>     iscsi_schedule_bh(acb);
>> }
>>
> The definition of ABORT TASK TMF in SAM is pretty much useless.
> To quote:
>
> A response of FUNCTION COMPLETE shall indicate that the task was aborted
> or was not in the task set.
>
> IE we have no idea if we ever managed to abort the task; if the task had
> been in-flight by the time we've send the TMF we'll be getting a
> FUNCTION COMPLETE, too.
>
> So most FC HBA firmware implement the abort task with just a blacklist;
> the TMF will be returned immediately and the command response will be
> dropped if and when is arrives.

Great, thanks for confirming.

Stefan
