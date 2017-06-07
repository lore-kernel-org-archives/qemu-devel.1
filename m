Received: from eggs.gnu.org ([2001:4830:134:3::10]:42154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIaSt-0003tn-J0
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIaSp-0005Ia-NF
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:53:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:26986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dIaSp-0005HQ-Dt
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:53:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OR6006DEH542V90@mailout2.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:53:28 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <5d23d06f-9036-f867-fa99-989565ab3031@samsung.com>
Date: Wed, 07 Jun 2017 15:53:24 +0300
MIME-version: 1.0
In-reply-to: <87tw3sezor.fsf@secure.mitica>
Content-type: text/plain; charset=utf-8; format=flowed
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1496828798-27548-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607094729eucas1p119b3d77f7d869eb06c16c9e91215e8cd@eucas1p1.samsung.com>
	<1496828798-27548-7-git-send-email-a.perevalov@samsung.com>
	<87tw3sezor.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v8 06/11] migration: add postcopy blocktime
 ctx into MigrationIncomingState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, dgilbert@redhat.com

On 06/07/2017 03:43 PM, Juan Quintela wrote:
> Alexey Perevalov <a.perevalov@samsung.com> wrote:
>> This patch adds request to kernel space for UFFD_FEATURE_THREAD_ID,
>> in case when this feature is provided by kernel.
>>
> I think this function is wrong

migration_exit_cb will be called at QEMU exit, but see later

>
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
> Or you don't want to call it this awy.
>
> This will destroy the context at every migration state change.
>
> Or I am missing something here?  Look at ui/spice-core.c to see how to
> use it only for some states (I guess you will need to do it for
> error/cleanup/completion changes only).
I forgot, to remove

add_migration_state_change_notifier(&ctx->postcopy_notifier);

in previous version, here was callback with migration state check.

>
> Later, Juan.
>
>> +    return ctx;
>> +}
>>   
>>   /**
>>    * receive_ufd_features: check userfault fd features, to request only supported
>> @@ -155,6 +207,19 @@ static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis)
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
>
>

-- 
Best regards,
Alexey Perevalov
