Received: from eggs.gnu.org ([2001:4830:134:3::10]:58304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1duzeA-0008BA-6T
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1duze4-0007Aq-3O
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:27:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1duze3-00076y-Px
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:27:52 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <6b5a0775-d17b-946f-fb28-9e4c8839b789@samsung.com>
Date: Thu, 21 Sep 2017 14:27:45 +0300
MIME-version: 1.0
In-reply-to: <20170921101608.GA2717@work-vm>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1505839684-10046-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170919164824eucas1p23607e53e3ea38f8be4e885bb960e803f@eucas1p2.samsung.com>
	<1505839684-10046-7-git-send-email-a.perevalov@samsung.com>
	<20170921101608.GA2717@work-vm>
Subject: Re: [Qemu-devel] [PATCH v10 06/10] migration: add postcopy
 blocktime ctx into MigrationIncomingState
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

On 09/21/2017 01:16 PM, Dr. David Alan Gilbert wrote:
> * Alexey Perevalov (a.perevalov@samsung.com) wrote:
>> This patch adds request to kernel space for UFFD_FEATURE_THREAD_ID,
>> in case when this feature is provided by kernel.
>>
>> PostcopyBlocktimeContext is incapsulated inside postcopy-ram.c,
>> due to it's postcopy only feature.
>> Also it defines PostcopyBlocktimeContext's instance live time.
>> Information from PostcopyBlocktimeContext instance will be provided
>> much after postcopy migration end, instance of PostcopyBlocktimeContext
>> will live till QEMU exit, but part of it (vcpu_addr,
>> page_fault_vcpu_time) used only during calculation, will be released
>> when postcopy ended or failed.
>>
>> To enable postcopy blocktime calculation on destination, need to request
>> proper capabiltiy (Patch for documentation will be at the tail of the patch
>> set).
>>
>> As an example following command enable that capability, assume QEMU was
>> started with
>> -chardev socket,id=charmonitor,path=/var/lib/migrate-vm-monitor.sock
>> option to control it
>>
>> [root@host]#printf "{\"execute\" : \"qmp_capabilities\"}\r\n \
>> {\"execute\": \"migrate-set-capabilities\" , \"arguments\":   {
>> \"capabilities\": [ { \"capability\": \"postcopy-blocktime\", \"state\":
>> true } ] } }" | nc -U /var/lib/migrate-vm-monitor.sock
>>
>> Or just with HMP
>> (qemu) migrate_set_capability postcopy-blocktime on
>>
>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>> ---
>>   migration/migration.h    |  8 ++++++
>>   migration/postcopy-ram.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 73 insertions(+)
>>
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 56bf33c..770466b 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -21,6 +21,8 @@
>>   #include "qemu/coroutine_int.h"
>>   #include "hw/qdev.h"
>>   
>> +struct PostcopyBlocktimeContext;
>> +
>>   /* State for the incoming migration */
>>   struct MigrationIncomingState {
>>       QEMUFile *from_src_file;
>> @@ -58,6 +60,12 @@ struct MigrationIncomingState {
>>       /* The coroutine we should enter (back) after failover */
>>       Coroutine *migration_incoming_co;
>>       QemuSemaphore colo_incoming_sem;
>> +
>> +    /*
>> +     * PostcopyBlocktimeContext to keep information for postcopy
>> +     * live migration, to calculate vCPU block time
>> +     * */
>> +    struct PostcopyBlocktimeContext *blocktime_ctx;
>>   };
>>   
>>   MigrationIncomingState *migration_incoming_get_current(void);
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index bec6c2c..cc78981 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -61,6 +61,58 @@ struct PostcopyDiscardState {
>>   #include <sys/eventfd.h>
>>   #include <linux/userfaultfd.h>
>>   
>> +typedef struct PostcopyBlocktimeContext {
>> +    /* time when page fault initiated per vCPU */
>> +    int64_t *page_fault_vcpu_time;
>> +    /* page address per vCPU */
>> +    uint64_t *vcpu_addr;
>> +    int64_t total_blocktime;
>> +    /* blocktime per vCPU */
>> +    int64_t *vcpu_blocktime;
>> +    /* point in time when last page fault was initiated */
>> +    int64_t last_begin;
>> +    /* number of vCPU are suspended */
>> +    int smp_cpus_down;
>> +
>> +    /*
>> +     * Handler for exit event, necessary for
>> +     * releasing whole blocktime_ctx
>> +     */
>> +    Notifier exit_notifier;
>> +    /*
>> +     * Handler for postcopy event, necessary for
>> +     * releasing unnecessary part of blocktime_ctx
>> +     */
>> +    Notifier postcopy_notifier;
> Is this actually used? It's just that...
>
>> +} PostcopyBlocktimeContext;
>> +
>> +static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
>> +{
>> +    g_free(ctx->page_fault_vcpu_time);
>> +    g_free(ctx->vcpu_addr);
>> +    g_free(ctx->vcpu_blocktime);
>> +    g_free(ctx);
>> +}
>> +
>> +static void migration_exit_cb(Notifier *n, void *data)
>> +{
>> +    PostcopyBlocktimeContext *ctx = container_of(n, PostcopyBlocktimeContext,
>> +                                                 exit_notifier);
>> +    destroy_blocktime_context(ctx);
>> +}
>> +
>> +static struct PostcopyBlocktimeContext *blocktime_context_new(void)
>> +{
>> +    PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
>> +    ctx->page_fault_vcpu_time = g_new0(int64_t, smp_cpus);
>> +    ctx->vcpu_addr = g_new0(uint64_t, smp_cpus);
>> +    ctx->vcpu_blocktime = g_new0(int64_t, smp_cpus);
>> +
>> +    ctx->exit_notifier.notify = migration_exit_cb;
>> +    qemu_add_exit_notifier(&ctx->exit_notifier);
>> +    add_migration_state_change_notifier(&ctx->postcopy_notifier);
> Patch 7 removes that line, and I don't see what puts it back;
> and this line doesn't actually set up ctx->postcopy_notifier.
>
> Other than that, it looks OK.
Thank you, I really changed my mind, and decided to keep
blocktime context (and all calculated values) till the
stop of VM, but not till the end of migration.

-- 
Best regards,
Alexey Perevalov
>
> Dave
>
>> +    return ctx;
>> +}
>>   
>>   /**
>>    * receive_ufd_features: check userfault fd features, to request only supported
>> @@ -153,6 +205,19 @@ static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis)
>>           }
>>       }
>>   
>> +#ifdef UFFD_FEATURE_THREAD_ID
>> +    if (migrate_postcopy_blocktime() && mis &&
>> +        UFFD_FEATURE_THREAD_ID & supported_features) {
>> +        /* kernel supports that feature */
>> +        /* don't create blocktime_context if it exists */
>> +        if (!mis->blocktime_ctx) {
>> +            mis->blocktime_ctx = blocktime_context_new();
>> +        }
>> +
>> +        asked_features |= UFFD_FEATURE_THREAD_ID;
>> +    }
>> +#endif
>> +
>>       /*
>>        * request features, even if asked_features is 0, due to
>>        * kernel expects UFFD_API before UFFDIO_REGISTER, per
>> -- 
>> 1.9.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
>
