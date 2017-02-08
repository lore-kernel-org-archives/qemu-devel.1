Received: from eggs.gnu.org ([2001:4830:134:3::10]:55814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cbQDM-0007Kr-Km
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 06:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cbQDJ-00007g-Cd
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 06:15:08 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:6658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cbQDI-00007L-IT
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 06:15:05 -0500
References: <1484657864-21708-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1484657864-21708-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170118110153.GA2085@work-vm>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <589AFD8D.3090900@huawei.com>
Date: Wed, 8 Feb 2017 19:14:21 +0800
MIME-Version: 1.0
In-Reply-To: <20170118110153.GA2085@work-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] COLO: Shutdown related socket fd while
 do failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, amit.shah@redhat.com, quintela@redhat.com, eddie.dong@intel.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com

On 2017/1/18 19:01, Dr. David Alan Gilbert wrote:
> * zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
>> If the net connection between primary host and secondary host breaks
>> while COLO/COLO incoming threads are doing read() or write().
>> It will block until connection is timeout, and the failover process
>> will be blocked because of it.
>>
>> So it is necessary to shutdown all the socket fds used by COLO
>> to avoid this situation. Besides, we should close the corresponding
>> file descriptors after failvoer BH shutdown them,
>> Or there will be an error.
>
> Hi,
>    There are two parts to this patch:
>     a) Add some semaphores to sequence failover
>     b) Use shutdown()
>
>    At first I wondered if perhaps they should be split; but I see
> the reason for the semaphores is mostly to stop the race between
> the fd's getting closed and the shutdown() calls; so I think it's
> OK.
>

Hi,

Yes, you are right, maybe i should add some comments about that.
Will do in next version.

> Do you have any problems with these semaphores during powering off the
> guest?
>

No, we didn't encounter any problems or trigger any bugs in our test
with this semaphores. In what places do you doubt it may has problems ? :)

Thanks,
Hailiang

> Dave
>
>
>
>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   include/migration/migration.h |  3 +++
>>   migration/colo.c              | 43 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/include/migration/migration.h b/include/migration/migration.h
>> index 487ac1e..7cac877 100644
>> --- a/include/migration/migration.h
>> +++ b/include/migration/migration.h
>> @@ -113,6 +113,7 @@ struct MigrationIncomingState {
>>       QemuThread colo_incoming_thread;
>>       /* The coroutine we should enter (back) after failover */
>>       Coroutine *migration_incoming_co;
>> +    QemuSemaphore colo_incoming_sem;
>>
>>       /* See savevm.c */
>>       LoadStateEntry_Head loadvm_handlers;
>> @@ -182,6 +183,8 @@ struct MigrationState
>>       QSIMPLEQ_HEAD(src_page_requests, MigrationSrcPageRequest) src_page_requests;
>>       /* The RAMBlock used in the last src_page_request */
>>       RAMBlock *last_req_rb;
>> +    /* The semaphore is used to notify COLO thread that failover is finished */
>> +    QemuSemaphore colo_exit_sem;
>>
>>       /* The semaphore is used to notify COLO thread to do checkpoint */
>>       QemuSemaphore colo_checkpoint_sem;
>> diff --git a/migration/colo.c b/migration/colo.c
>> index 08b2e46..3222812 100644
>> --- a/migration/colo.c
>> +++ b/migration/colo.c
>> @@ -59,6 +59,18 @@ static void secondary_vm_do_failover(void)
>>           /* recover runstate to normal migration finish state */
>>           autostart = true;
>>       }
>> +    /*
>> +     * Make sure COLO incoming thread not block in recv or send,
>> +     * If mis->from_src_file and mis->to_src_file use the same fd,
>> +     * The second shutdown() will return -1, we ignore this value,
>> +     * It is harmless.
>> +     */
>> +    if (mis->from_src_file) {
>> +        qemu_file_shutdown(mis->from_src_file);
>> +    }
>> +    if (mis->to_src_file) {
>> +        qemu_file_shutdown(mis->to_src_file);
>> +    }
>>
>>       old_state = failover_set_state(FAILOVER_STATUS_ACTIVE,
>>                                      FAILOVER_STATUS_COMPLETED);
>> @@ -67,6 +79,8 @@ static void secondary_vm_do_failover(void)
>>                        "secondary VM", FailoverStatus_lookup[old_state]);
>>           return;
>>       }
>> +    /* Notify COLO incoming thread that failover work is finished */
>> +    qemu_sem_post(&mis->colo_incoming_sem);
>>       /* For Secondary VM, jump to incoming co */
>>       if (mis->migration_incoming_co) {
>>           qemu_coroutine_enter(mis->migration_incoming_co);
>> @@ -81,6 +95,18 @@ static void primary_vm_do_failover(void)
>>       migrate_set_state(&s->state, MIGRATION_STATUS_COLO,
>>                         MIGRATION_STATUS_COMPLETED);
>>
>> +    /*
>> +     * Wake up COLO thread which may blocked in recv() or send(),
>> +     * The s->rp_state.from_dst_file and s->to_dst_file may use the
>> +     * same fd, but we still shutdown the fd for twice, it is harmless.
>> +     */
>> +    if (s->to_dst_file) {
>> +        qemu_file_shutdown(s->to_dst_file);
>> +    }
>> +    if (s->rp_state.from_dst_file) {
>> +        qemu_file_shutdown(s->rp_state.from_dst_file);
>> +    }
>> +
>>       old_state = failover_set_state(FAILOVER_STATUS_ACTIVE,
>>                                      FAILOVER_STATUS_COMPLETED);
>>       if (old_state != FAILOVER_STATUS_ACTIVE) {
>> @@ -88,6 +114,8 @@ static void primary_vm_do_failover(void)
>>                        FailoverStatus_lookup[old_state]);
>>           return;
>>       }
>> +    /* Notify COLO thread that failover work is finished */
>> +    qemu_sem_post(&s->colo_exit_sem);
>>   }
>>
>>   void colo_do_failover(MigrationState *s)
>> @@ -361,6 +389,14 @@ out:
>>
>>       timer_del(s->colo_delay_timer);
>>
>> +    /* Hope this not to be too long to wait here */
>> +    qemu_sem_wait(&s->colo_exit_sem);
>> +    qemu_sem_destroy(&s->colo_exit_sem);
>> +    /*
>> +     * Must be called after failover BH is completed,
>> +     * Or the failover BH may shutdown the wrong fd that
>> +     * re-used by other threads after we release here.
>> +     */
>>       if (s->rp_state.from_dst_file) {
>>           qemu_fclose(s->rp_state.from_dst_file);
>>       }
>> @@ -385,6 +421,7 @@ void migrate_start_colo_process(MigrationState *s)
>>       s->colo_delay_timer =  timer_new_ms(QEMU_CLOCK_HOST,
>>                                   colo_checkpoint_notify, s);
>>
>> +    qemu_sem_init(&s->colo_exit_sem, 0);
>>       migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>>                         MIGRATION_STATUS_COLO);
>>       colo_process_checkpoint(s);
>> @@ -423,6 +460,8 @@ void *colo_process_incoming_thread(void *opaque)
>>       uint64_t value;
>>       Error *local_err = NULL;
>>
>> +    qemu_sem_init(&mis->colo_incoming_sem, 0);
>> +
>>       migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>>                         MIGRATION_STATUS_COLO);
>>
>> @@ -533,6 +572,10 @@ out:
>>           qemu_fclose(fb);
>>       }
>>
>> +    /* Hope this not to be too long to loop here */
>> +    qemu_sem_wait(&mis->colo_incoming_sem);
>> +    qemu_sem_destroy(&mis->colo_incoming_sem);
>> +    /* Must be called after failover BH is completed */
>>       if (mis->to_src_file) {
>>           qemu_fclose(mis->to_src_file);
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
