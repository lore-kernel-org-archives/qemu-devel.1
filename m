Received: from eggs.gnu.org ([2001:4830:134:3::10]:52295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eoCC4-0006CR-UV
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:59:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eoCC4-0007Jl-3l
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:59:09 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eoCC3-0007JE-Sp
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:59:08 -0500
Received: by mail-wr0-x235.google.com with SMTP id s5so16927100wra.0
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 09:59:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0f7b3bc8-544f-ac52-9486-5a9b697ef2a3@kamp.de>
References: <20180215111526.2464-1-stefanha@redhat.com>
	<ecc44671-4f09-5c52-57ea-4818b351795d@kamp.de>
	<20180215172714.GD8367@stefanha-x1.localdomain>
	<0f7b3bc8-544f-ac52-9486-5a9b697ef2a3@kamp.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 20 Feb 2018 17:59:06 +0000
Message-ID: <CAJSP0QXy18dcfWNK7-oWucYv1TNpVnNDB=E55b6KcTx58HjJCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] block/iscsi: cancel libiscsi task when
 ABORT TASK TMF completes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Felipe Franciosi <felipe@nutanix.com>

On Tue, Feb 20, 2018 at 3:12 PM, Peter Lieven <pl@kamp.de> wrote:
> Am 15.02.2018 um 18:27 schrieb Stefan Hajnoczi:
>>
>> On Thu, Feb 15, 2018 at 03:24:54PM +0100, Peter Lieven wrote:
>>>
>>> Am 15.02.2018 um 12:15 schrieb Stefan Hajnoczi:
>>>>
>>>> The libiscsi iscsi_task_mgmt_async() API documentation says:
>>>>
>>>>     abort_task will also cancel the scsi task. The callback for the scsi
>>>>     task will be invoked with SCSI_STATUS_CANCELLED
>>>>
>>>> The libiscsi implementation does not fulfil this promise.  The task's
>>>> callback is not invoked and its struct iscsi_pdu remains in the internal
>>>> list (effectively leaked).
>>>
>>> If that contract is fixed in libiscsi, will the Qemu iSCSI driver still
>>> work?
>>
>> In
>>
>> +    /* If the command callback hasn't been called yet, drop the task */
>> +    if (!acb->bh) {
>>
>> and
>>
>> +    if (status == SCSI_STATUS_CANCELLED) {
>> +        if (!acb->bh) {
>>
>> we're mindful of the fact that the callback may have been invoked by
>> libiscsi already.  There is no risk of double-completion.
>
>
> Hi Stefan,
>
> thanks for the clarification. I am fine with this change. I will check with
> Ronnie for the
> libiscsi fix.

Great, then this patch can go via Paolo's SCSI tree.

Stefan
