Received: from eggs.gnu.org ([2001:4830:134:3::10]:37510)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1eo9ao-0006nS-Vy
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1eo9ak-00027J-1O
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:12:30 -0500
Received: from mx01.kamp.de ([82.141.2.16]:50867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1eo9aj-00026r-NA
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:12:25 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:12:21 +0100
References: <20180215111526.2464-1-stefanha@redhat.com>
	<ecc44671-4f09-5c52-57ea-4818b351795d@kamp.de>
	<20180215172714.GD8367@stefanha-x1.localdomain>
From: Peter Lieven <pl@kamp.de>
Message-ID: <0f7b3bc8-544f-ac52-9486-5a9b697ef2a3@kamp.de>
Date: Tue, 20 Feb 2018 16:12:22 +0100
MIME-Version: 1.0
In-Reply-To: <20180215172714.GD8367@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Felipe Franciosi <felipe@nutanix.com>

Am 15.02.2018 um 18:27 schrieb Stefan Hajnoczi:
> On Thu, Feb 15, 2018 at 03:24:54PM +0100, Peter Lieven wrote:
>> Am 15.02.2018 um 12:15 schrieb Stefan Hajnoczi:
>>> The libiscsi iscsi_task_mgmt_async() API documentation says:
>>>
>>>     abort_task will also cancel the scsi task. The callback for the scsi
>>>     task will be invoked with SCSI_STATUS_CANCELLED
>>>
>>> The libiscsi implementation does not fulfil this promise.  The task's
>>> callback is not invoked and its struct iscsi_pdu remains in the internal
>>> list (effectively leaked).
>> If that contract is fixed in libiscsi, will the Qemu iSCSI driver still work?
> In
>
> +    /* If the command callback hasn't been called yet, drop the task */
> +    if (!acb->bh) {
>
> and
>
> +    if (status == SCSI_STATUS_CANCELLED) {
> +        if (!acb->bh) {
>
> we're mindful of the fact that the callback may have been invoked by
> libiscsi already.  There is no risk of double-completion.

Hi Stefan,

thanks for the clarification. I am fine with this change. I will check with Ronnie for the
libiscsi fix.

Peter
