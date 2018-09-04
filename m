Received: from eggs.gnu.org ([2001:4830:134:3::10]:37102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quan.xu0@gmail.com>) id 1fxBTO-00055M-UG
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 09:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quan.xu0@gmail.com>) id 1fxBTI-0005mR-VW
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 09:34:26 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:42051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <quan.xu0@gmail.com>) id 1fxBTI-0005m7-Mo
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 09:34:20 -0400
Received: by mail-oi0-x236.google.com with SMTP id k81-v6so6662105oib.9
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 06:34:20 -0700 (PDT)
References: <5ab76c3e-9310-0e08-2f1b-4ff52bf229f8@gmail.com>
	<20180904090928.GA2529@work-vm>
From: Quan Xu <quan.xu0@gmail.com>
Message-ID: <e627a6e0-fe4e-6bb4-fe0b-1a562234ecb4@gmail.com>
Date: Tue, 4 Sep 2018 21:34:14 +0800
MIME-Version: 1.0
In-Reply-To: <20180904090928.GA2529@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH RFC] migration: make sure to run iterate
 precopy during the bulk stage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, kvm <kvm@vger.kernel.org>

on 2018/9/4 17:09, Dr. David Alan Gilbert wrote:
> * Quan Xu (quan.xu0@gmail.com) wrote:
>>  From 8dbf7370e7ea1caab0b769d0d4dcdd072d14d421 Mon Sep 17 00:00:00 2001
>> From: Quan Xu <quan.xu0@gmail.com>
>> Date: Wed, 29 Aug 2018 21:33:14 +0800
>> Subject: [PATCH RFC] migration: make sure to run iterate precopy during the
>>   bulk stage
>>
>> Since the bulk stage assumes in (migration_bitmap_find_dirty) that every
>> page is dirty, return a rough total ram as pending size to make sure that
>> migration thread continues to run iterate precopy during the bulk stage.
>>
>> Otherwise the downtime grows unpredictably, as migration thread needs to
>> send both the rest of pages and dirty pages during complete precopy.
>>
>> Signed-off-by: Quan Xu <quan.xu0@gmail.com>
> 
> Hi,
>    Can you explain a bit more about the problem you're seeing?
> I think you're saying it's exiting the iteration near the end of
> the bulk stage, before it's done the first sync?
>

Dr.Gilbert,

yes,
a bit more background, I run migration in a slow network throughput 
(about ~500mbps).
as the slow network throughput, there is more 'break' during iterate 
precopy (as the MAX_WAIT).
if it runs in a higher network throughput, the downtime would be still 
within an acceptable range.

second, I patch the current code to support live migraion/hotplug  with 
VFIO for some 'special ability'
​hardware device.. I break the ram loop and start to scan from the first 
block to the last block during complete precopy. if migration is still 
in the bulk stage, the downtime grows unpredictably. I hope this would 
not confuse you.


>> ---
>>   migration/ram.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 79c8942..cfa304c 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -3308,7 +3308,8 @@ static void ram_save_pending(QEMUFile *f, void
>> *opaque, uint64_t max_size,
>>           /* We can do postcopy, and all the data is postcopiable */
>>           *res_compatible += remaining_size;
>>       } else {
>> -        *res_precopy_only += remaining_size;
>> +        *res_precopy_only += (rs->ram_bulk_stage ?
>> +                              ram_bytes_total() : remaining_size);
> 
> So that's assuming that the whole of RAM is dirty, even if we're
> near the end of the bulk stage?



I understand your concern. there is maybe an extra iteration. I also 
wanted to fix as your suggestion. however, this would be an overhead to
maintain another count.


Quan

> 
> Dave
> 
>>       }
>>   }
>>
>> --
>> 1.8.3.1
>>
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
