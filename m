Received: from eggs.gnu.org ([2001:4830:134:3::10]:49959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1caduu-0003Dk-SA
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 02:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1caduq-0000N5-5Q
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 02:40:52 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:24850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cadup-0000LV-Db
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 02:40:48 -0500
References: <1485327241-15104-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1485327241-15104-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170131100432.GB2395@work-vm>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <5898221E.9060602@huawei.com>
Date: Mon, 6 Feb 2017 15:13:34 +0800
MIME-Version: 1.0
In-Reply-To: <20170131100432.GB2395@work-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] savevm: split save/find
 loadvm_handlers entry into two helper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, amit.shah@redhat.com, quintela@redhat.com

On 2017/1/31 18:04, Dr. David Alan Gilbert wrote:
> * zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
>> COLO's checkpoint process is based on migration process,
>> everytime we do checkpoint we will repeat the process of savevm and loadvm.
>>
>> So we will call qemu_loadvm_section_start_full() repeatedly, It will
>> add all migration sections information into loadvm_handlers list everytime,
>> which will lead to memory leak.
>>
>> To fix it, we split the process of saving and finding section entry into two
>> helper functions, we will check if section info was exist in loadvm_handlers
>> list before save it.
>>
>> This modifications have no side effect for normal migration.
>>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   migration/savevm.c | 55 +++++++++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 40 insertions(+), 15 deletions(-)
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index f9c06e9..92b3d6c 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1805,6 +1805,37 @@ void loadvm_free_handlers(MigrationIncomingState *mis)
>>       }
>>   }
>>
>> +static LoadStateEntry *loadvm_save_section_entry(MigrationIncomingState *mis,
>
> Can you change that to loadvm_add_section_entry please;  it's a bit
> confusing using 'save' in a function name that's part of the 'load' path.
>

OK, will fix it in next version, thanks.

> Dave
>
>> +                                                 SaveStateEntry *se,
>> +                                                 uint32_t section_id,
>> +                                                 uint32_t version_id)
>> +{
>> +    LoadStateEntry *le;
>> +
>> +    /* Add entry */
>> +    le = g_malloc0(sizeof(*le));
>> +
>> +    le->se = se;
>> +    le->section_id = section_id;
>> +    le->version_id = version_id;
>> +    QLIST_INSERT_HEAD(&mis->loadvm_handlers, le, entry);
>> +    return le;
>> +}
>> +
>> +static LoadStateEntry *loadvm_find_section_entry(MigrationIncomingState *mis,
>> +                                                 uint32_t section_id)
>> +{
>> +    LoadStateEntry *le;
>> +
>> +    QLIST_FOREACH(le, &mis->loadvm_handlers, entry) {
>> +        if (le->section_id == section_id) {
>> +            break;
>> +        }
>> +    }
>> +
>> +    return le;
>> +}
>> +
>>   static int
>>   qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
>>   {
>> @@ -1847,15 +1878,12 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
>>           return -EINVAL;
>>       }
>>
>> -    /* Add entry */
>> -    le = g_malloc0(sizeof(*le));
>> -
>> -    le->se = se;
>> -    le->section_id = section_id;
>> -    le->version_id = version_id;
>> -    QLIST_INSERT_HEAD(&mis->loadvm_handlers, le, entry);
>> -
>> -    ret = vmstate_load(f, le->se, le->version_id);
>> +     /* Check if we have saved this section info before, if not, save it */
>> +    le = loadvm_find_section_entry(mis, section_id);
>> +    if (!le) {
>> +        le = loadvm_save_section_entry(mis, se, section_id, version_id);
>> +    }
>> +    ret = vmstate_load(f, se, version_id);
>>       if (ret < 0) {
>>           error_report("error while loading state for instance 0x%x of"
>>                        " device '%s'", instance_id, idstr);
>> @@ -1878,12 +1906,9 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
>>       section_id = qemu_get_be32(f);
>>
>>       trace_qemu_loadvm_state_section_partend(section_id);
>> -    QLIST_FOREACH(le, &mis->loadvm_handlers, entry) {
>> -        if (le->section_id == section_id) {
>> -            break;
>> -        }
>> -    }
>> -    if (le == NULL) {
>> +
>> +    le = loadvm_find_section_entry(mis, section_id);
>> +    if (!le) {
>>           error_report("Unknown savevm section %d", section_id);
>>           return -EINVAL;
>>       }
>> --
>> 1.8.3.1
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
> .
>
