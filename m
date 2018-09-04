Received: from eggs.gnu.org ([2001:4830:134:3::10]:48571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quan.xu0@gmail.com>) id 1fxAlU-0007Vb-RH
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 08:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quan.xu0@gmail.com>) id 1fxAlP-0006JN-JR
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 08:49:04 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <quan.xu0@gmail.com>) id 1fxAlP-0006Ix-DL
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 08:48:59 -0400
Received: by mail-oi0-x244.google.com with SMTP id 8-v6so6460665oip.0
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 05:48:59 -0700 (PDT)
References: <5ab76c3e-9310-0e08-2f1b-4ff52bf229f8@gmail.com>
	<87va7lvd71.fsf@trasno.org>
From: Quan Xu <quan.xu0@gmail.com>
Message-ID: <4602076e-2c15-39dc-8e79-e8b1492a8c80@gmail.com>
Date: Tue, 4 Sep 2018 20:48:51 +0800
MIME-Version: 1.0
In-Reply-To: <87va7lvd71.fsf@trasno.org>
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
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, kvm <kvm@vger.kernel.org>

on 2018/9/4 17:12, Juan Quintela wrote:
> Quan Xu <quan.xu0@gmail.com> wrote:
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
>>       }
>>   }
> 
> Hi
> 
> I don't oppose the change.
> But what I don't understand is _why_ it is needed (or to say it
> otherwise, how it worked until now). 

I run migration in a slow network throughput (about ~500mbps).
​ in my opion,  as the slow network throughput, there is more 'break' 
during iterate precopy (as the MAX_WAIT).
​as said in patch description, even to send both the rest pages and 
dirty pages, if in a higher network throughput,
​the downtime would look still within an acceptable range.



>  I was wondering about the opposit
> direction, and just initialize the number of dirty pages at the
> beggining of the loop and then let decrease it for each processed page.
>

I understand your concern. I also wanted to fix as your suggestion. 
however, to me, this would be an overhead to ​​maintain another count 
during migration.


Quan


> I don't remember either how big was the speedud of not walking the
> bitmap on the 1st stage to start with.
> 
> Later, Juan.
> 
