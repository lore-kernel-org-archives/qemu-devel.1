Received: from eggs.gnu.org ([2001:4830:134:3::10]:47113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxUfI-0006ch-4K
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxUfE-000430-VM
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:27:12 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3026
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxUfD-00041j-SV
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:27:08 -0400
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-13-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170407171840.GE2623@work-vm>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58EB41C0.5060203@huawei.com>
Date: Mon, 10 Apr 2017 16:26:40 +0800
MIME-Version: 1.0
In-Reply-To: <20170407171840.GE2623@work-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/15] savevm: split the process of
 different stages for loadvm/savevm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, Juan Quintela <quintela@redhat.com>

On 2017/4/8 1:18, Dr. David Alan Gilbert wrote:
> * zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
>> There are several stages during loadvm/savevm process. In different stage,
>> migration incoming processes different types of sections.
>> We want to control these stages more accuracy, it will benefit COLO
>> performance, we don't have to save type of QEMU_VM_SECTION_START
>> sections everytime while do checkpoint, besides, we want to separate
>> the process of saving/loading memory and devices state.
>>
>> So we add three new helper functions: qemu_loadvm_state_begin(),
>> qemu_load_device_state() and qemu_savevm_live_state() to achieve
>> different process during migration.
>>
>> Besides, we make qemu_loadvm_state_main() and qemu_save_device_state()
>> public.
>>
>> Cc: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   include/sysemu/sysemu.h |  6 ++++++
>>   migration/savevm.c      | 55 ++++++++++++++++++++++++++++++++++++++++++-------
>>   2 files changed, 54 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 7ed665a..95cae41 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -132,7 +132,13 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
>>                                              uint64_t *start_list,
>>                                              uint64_t *length_list);
>>   
>> +void qemu_savevm_live_state(QEMUFile *f);
>> +int qemu_save_device_state(QEMUFile *f);
>> +
>>   int qemu_loadvm_state(QEMUFile *f);
>> +int qemu_loadvm_state_begin(QEMUFile *f);
>> +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>> +int qemu_load_device_state(QEMUFile *f);
>>   
>>   extern int autostart;
>>   
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 9c2d239..dac478b 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -54,6 +54,7 @@
>>   #include "qemu/cutils.h"
>>   #include "io/channel-buffer.h"
>>   #include "io/channel-file.h"
>> +#include "migration/colo.h"
>>   
>>   #ifndef ETH_P_RARP
>>   #define ETH_P_RARP 0x8035
>> @@ -1279,13 +1280,21 @@ done:
>>       return ret;
>>   }
>>   
>> -static int qemu_save_device_state(QEMUFile *f)
>> +void qemu_savevm_live_state(QEMUFile *f)
>>   {
>> -    SaveStateEntry *se;
>> +    /* save QEMU_VM_SECTION_END section */
>> +    qemu_savevm_state_complete_precopy(f, true);
>> +    qemu_put_byte(f, QEMU_VM_EOF);
>> +}
>>   
>> -    qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
>> -    qemu_put_be32(f, QEMU_VM_FILE_VERSION);
>> +int qemu_save_device_state(QEMUFile *f)
>> +{
>> +    SaveStateEntry *se;
>>   
>> +    if (!migration_in_colo_state()) {
>> +        qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
>> +        qemu_put_be32(f, QEMU_VM_FILE_VERSION);
>> +    }
> Note that got split out into qemu_savevm_state_header() at some point.

Do you mean i should use the wrapper qemu_savevm_state_heade() here ?

> Dave
>
>>       cpu_synchronize_all_states();
>>   
>>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> @@ -1336,8 +1345,6 @@ enum LoadVMExitCodes {
>>       LOADVM_QUIT     =  1,
>>   };
>>   
>> -static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>> -
>>   /* ------ incoming postcopy messages ------ */
>>   /* 'advise' arrives before any transfers just to tell us that a postcopy
>>    * *might* happen - it might be skipped if precopy transferred everything
>> @@ -1942,7 +1949,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
>>       return 0;
>>   }
>>   
>> -static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
>> +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
>>   {
>>       uint8_t section_type;
>>       int ret = 0;
>> @@ -2080,6 +2087,40 @@ int qemu_loadvm_state(QEMUFile *f)
>>       return ret;
>>   }
>>   
>> +int qemu_loadvm_state_begin(QEMUFile *f)
>> +{
>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>> +    Error *local_err = NULL;
>> +    int ret;
>> +
>> +    if (qemu_savevm_state_blocked(&local_err)) {
>> +        error_report_err(local_err);
>> +        return -EINVAL;
>> +    }
>> +    /* Load QEMU_VM_SECTION_START section */
>> +    ret = qemu_loadvm_state_main(f, mis);
>> +    if (ret < 0) {
>> +        error_report("Failed to loadvm begin work: %d", ret);
>> +    }
>> +    return ret;
>> +}
>> +
>> +int qemu_load_device_state(QEMUFile *f)
>> +{
>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>> +    int ret;
>> +
>> +    /* Load QEMU_VM_SECTION_FULL section */
>> +    ret = qemu_loadvm_state_main(f, mis);
>> +    if (ret < 0) {
>> +        error_report("Failed to load device state: %d", ret);
>> +        return ret;
>> +    }
>> +
>> +    cpu_synchronize_all_post_init();
>> +    return 0;
>> +}
>> +
>>   int save_vmstate(Monitor *mon, const char *name)
>>   {
>>       BlockDriverState *bs, *bs1;
>> -- 
>> 1.8.3.1
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
> .
>
