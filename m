Received: from eggs.gnu.org ([2001:4830:134:3::10]:56864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f4JhW-00004t-2g
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 01:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f4JhS-0006HX-SH
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 01:14:14 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:55299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1f4JhS-0006HJ-In
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 01:14:10 -0400
Received: by mail-it0-x243.google.com with SMTP id 142-v6so201824itl.5
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 22:14:09 -0700 (PDT)
References: <20180405012241.25714-1-f4bug@amsat.org>
	<20180405012241.25714-5-f4bug@amsat.org>
	<fc68eee3-cd18-016c-a323-3e62250e4ea8@adacore.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <aca2ee26-8b6d-0385-5a90-1ee753fea16a@ozlabs.ru>
Date: Fri, 6 Apr 2018 15:14:03 +1000
MIME-Version: 1.0
In-Reply-To: <fc68eee3-cd18-016c-a323-3e62250e4ea8@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/4] memory: Add
 memory_region_set_priority()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On 5/4/18 6:44 pm, KONRAD Frederic wrote:
> 
> 
> On 04/05/2018 03:22 AM, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Sadly I'm missing something, this does not work.
> 
> Hmmm is that supposed to work dynamically?
> 
> If so I think you might need to call
> memory_region_update_container_subregions(..) because it will
> actually change the map?
> 
> Take a look at how memory_add_subregion works.


Ah, right, I guess it should be:

memory_region_transaction_begin();
mr->priority = priority;
memory_region_update_pending = true;
memory_region_transaction_commit();


as the priority may change the final layout of flatview.


> 
> Thanks,
> Fred
> 
>>
>>   memory.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/memory.c b/memory.c
>> index eaa5fa7f23..ae45ea7779 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -1225,6 +1225,22 @@ static void memory_region_get_priority(Object
>> *obj, Visitor *v,
>>       visit_type_int32(v, name, &value, errp);
>>   }
>>   +static void memory_region_set_priority(Object *obj, Visitor *v,
>> +                                       const char *name, void *opaque,
>> +                                       Error **errp)
>> +{
>> +    MemoryRegion *mr = MEMORY_REGION(obj);
>> +    int32_t priority;
>> +    Error *local_err = NULL;
>> +
>> +    visit_type_int32(v, name, &priority, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +    mr->priority = priority;
>> +}
>> +
>>   static void memory_region_get_size(Object *obj, Visitor *v, const char
>> *name,
>>                                      void *opaque, Error **errp)
>>   {
>> @@ -1260,7 +1276,7 @@ static void memory_region_initfn(Object *obj)
>>                           NULL, NULL, &error_abort);
>>       object_property_add(OBJECT(mr), "priority", "int32",
>>                           memory_region_get_priority,
>> -                        NULL, /* memory_region_set_priority */
>> +                        memory_region_set_priority,
>>                           NULL, NULL, &error_abort);
>>       object_property_add(OBJECT(mr), "size", "uint64",
>>                           memory_region_get_size,
>>


-- 
Alexey
