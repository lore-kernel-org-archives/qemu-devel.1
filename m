Received: from eggs.gnu.org ([2001:4830:134:3::10]:58417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dv1V0-0000eo-EC
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dv1Uw-0008Dg-8C
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:26:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dv1Uv-0008D6-V5
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:26:34 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <0c0baef1-fbad-e6d2-8d8b-07f54d084ee9@samsung.com>
Date: Thu, 21 Sep 2017 16:26:27 +0300
MIME-version: 1.0
In-reply-to: <20170921123326.GD2717@work-vm>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1505839684-10046-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170919164825eucas1p21fd133a55091e4a09fdeee05d130260d@eucas1p2.samsung.com>
	<1505839684-10046-9-git-send-email-a.perevalov@samsung.com>
	<20170921123326.GD2717@work-vm>
Subject: Re: [Qemu-devel] [PATCH v10 08/10] migration: postcopy_blocktime
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com, quintela@redhat.com, heetae82.ahn@samsung.com

On 09/21/2017 03:33 PM, Dr. David Alan Gilbert wrote:
> * Alexey Perevalov (a.perevalov@samsung.com) wrote:
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> Although it does have my R-b it might be worth adding some clarification
> that it's a measure of when *all* cpus are blocked and so isn't a
> total measure of impact of postcopy (when blocking some of them).
yes, maybe additional clarification is necessary.
now we have both values:
{"return": {"postcopy-blocktime": 5691, "status": "completed", 
"postcopy-vcpu-blocktime": [7671, 6388]}}
where postcopy-blocktime is for *all* and postcopy-vcpu-blocktime is per 
vCPU,
it's really worth to describe it, like:

Blocktime is a postcopy live migration metric, intended to show
how long the vCPU was in state of interruptible sleep due to pagefault.
That metric is calculated both for all vCPUs as overlapped value, and
separately for each vCPU. These values are calculated on destination side.
To enable postcopy blocktime calculation, enter following command on destination
monitor:

migrate_set_capability postcopy-blocktime on

Postcopy blocktime can be retrieved by query-migrate qmp command.
postcopy-blocktime value of qmp command will show overlapped blocking time for all vCPU,
postcopy-vcpu-blocktime will show list of blocking time per vCPU.


-- 
Best regards,
Alexey Perevalov

>
> Dave
>
>> ---
>>   docs/devel/migration.txt | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/docs/devel/migration.txt b/docs/devel/migration.txt
>> index 1b940a8..4b625ca 100644
>> --- a/docs/devel/migration.txt
>> +++ b/docs/devel/migration.txt
>> @@ -402,6 +402,16 @@ will now cause the transition from precopy to postcopy.
>>   It can be issued immediately after migration is started or any
>>   time later on.  Issuing it after the end of a migration is harmless.
>>   
>> +Blocktime is a postcopy live migration metric, intended to show
>> +how long the vCPU was in state of interruptable sleep due to pagefault.
>> +This value is calculated on destination side.
>> +To enable postcopy blocktime calculation, enter following command on destination
>> +monitor:
>> +
>> +migrate_set_capability postcopy-blocktime on
>> +
>> +Postcopy blocktime can be retrieved by query-migrate qmp command.
>> +
>>   Note: During the postcopy phase, the bandwidth limits set using
>>   migrate_set_speed is ignored (to avoid delaying requested pages that
>>   the destination is waiting for).
>> -- 
>> 1.9.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
>
