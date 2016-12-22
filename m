Received: from eggs.gnu.org ([2001:4830:134:3::10]:45688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cJtZC-0006NE-Vy
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 21:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cJtZ8-0003o2-81
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 21:57:15 -0500
References: <1479555831-30960-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<20161206134211.GD4990@noname.str.redhat.com>
	<20161206152415.GF2125@work-vm>
	<5848F139.1020402@huawei.com> <20161208200230.GH2054@work-vm>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <585B40C5.9020603@huawei.com>
Date: Thu, 22 Dec 2016 10:56:05 +0800
MIME-Version: 1.0
In-Reply-To: <20161208200230.GH2054@work-vm>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] migration: re-active images when migration
 fails to complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: xuquan8@huawei.com, Kevin Wolf <kwolf@redhat.com>, amit.shah@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, quintela@redhat.com

On 2016/12/9 4:02, Dr. David Alan Gilbert wrote:
> * Hailiang Zhang (zhang.zhanghailiang@huawei.com) wrote:
>> Hi，
>>
>> On 2016/12/6 23:24, Dr. David Alan Gilbert wrote:
>>> * Kevin Wolf (kwolf@redhat.com) wrote:
>>>> Am 19.11.2016 um 12:43 hat zhanghailiang geschrieben:
>>>>> commit fe904ea8242cbae2d7e69c052c754b8f5f1ba1d6 fixed a case
>>>>> which migration aborted QEMU because it didn't regain the control
>>>>> of images while some errors happened.
>>>>>
>>>>> Actually, we have another case in that error path to abort QEMU
>>>>> because of the same reason:
>>>>>       migration_thread()
>>>>>           migration_completion()
>>>>>              bdrv_inactivate_all() ----------------> inactivate images
>>>>>              qemu_savevm_state_complete_precopy()
>>>>>                  socket_writev_buffer() --------> error because destination fails
>>>>>                qemu_fflush() -------------------> set error on migration stream
>>>>>              qemu_mutex_unlock_iothread() ------> unlock
>>>>>       qmp_migrate_cancel() ---------------------> user cancelled migration
>>>>>           migrate_set_state() ------------------> set migrate CANCELLING
>>>>
>>>> Important to note here: qmp_migrate_cancel() is executed by a concurrent
>>>> thread, it doesn't depend on any code paths in migration_completion().
>>>>
>>>>>       migration_completion() -----------------> go on to fail_invalidate
>>>>>           if (s->state == MIGRATION_STATUS_ACTIVE) -> Jump this branch
>>>>>       migration_thread() -----------------------> break migration loop
>>>>>         vm_start() -----------------------------> restart guest with inactive
>>>>>                                                   images
>>>>> We failed to regain the control of images because we only regain it
>>>>> while the migration state is "active", but here users cancelled the migration
>>>>> when they found some errors happened (for example, libvirtd daemon is shutdown
>>>>> in destination unexpectedly).
>>>>>
>>>>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>>>>> ---
>>>>>    migration/migration.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>> index f498ab8..0c1ee6d 100644
>>>>> --- a/migration/migration.c
>>>>> +++ b/migration/migration.c
>>>>> @@ -1752,7 +1752,8 @@ fail_invalidate:
>>>>>        /* If not doing postcopy, vm_start() will be called: let's regain
>>>>>         * control on images.
>>>>>         */
>>>>> -    if (s->state == MIGRATION_STATUS_ACTIVE) {
>>>>
>>>> This if condition tries to check whether we ran the code path that
>>>> called bdrv_inactivate_all(), so that we only try to reactivate images
>>>> it if we really inactivated them first.
>>>>
>>>> The problem with it is that it ignores a possible concurrent
>>>> modification of s->state.
>>>>
>>>>> +    if (s->state == MIGRATION_STATUS_ACTIVE ||
>>>>> +        s->state == MIGRATION_STATUS_CANCELLING) {
>>>>
>>>> This adds another state that we could end up with with a concurrent
>>>> modification, so that even in this case we undo the inactivation.
>>>>
>>>> However, it is no longer limited to the cases where we inactivated the
>>>> image. It also applies to other code paths (like the postcopy one) where
>>>> we didn't inactivate images.
>>>>
>>>> What saves the patch is that bdrv_invalidate_cache() is a no-op for
>>>> block devices that aren't inactivated, so calling it more often than
>>>> necessary is okay.
>>>>
>>>> But then, if we're going to rely on this, it would be much better to
>>>> just remove the if altogether. I can't say whether there are any other
>>>> possible values of s->state that we should consider, and by removing the
>>>> if we would be guaranteed to catch all of them.
>>>>
>>>> If we don't want to rely on it, just keep a local bool that remembers
>>>> whether we inactivated images and check that here.
>>>>
>>>>>            Error *local_err = NULL;
>>>>>
>>>>>            bdrv_invalidate_cache_all(&local_err);
>>>>
>>>> So in summary, this is a horrible patch because it checks the wrong
>>>> thing, and for I can't really say if it covers everything it needs to
>>>> cover, but arguably it happens to correctly fix the outcome of a
>>>> previously failing case.
>>>>
>>>> Normally I would reject such a patch and require a clean solution, but
>>>> then we're on the day of -rc3, so if you can't send v2 right away, we
>>>> might not have the time for it.
>>>>
>>>> Tough call...
>>>
>>> Hmm, this case is messy; I created this function having split it out
>>> of the main loop a couple of years back but it did get more messy
>>> with more s->state checks; as far as I can tell it's always
>>> done the transition to COMPLETED at the end well after the locked
>>> section, so there's always been that chance that cancellation sneaks
>>> in just before or just after the locked section.
>>>
>>> Some of the bad cases that can happen:
>>>      a) A cancel sneaks in after the ACTIVE check but before or after
>>>        the locked section;  should we reactivate the disks? Well that
>>>        depends on whether the destination actually got the full migration
>>>        stream - we don't know!
>>>           If the destination actually starts running we must not reactivate
>>>           the disk on the source even if the CPU is stopped.
>>>
>>
>> Yes, we didn't have a mechanism to know exactly whether or not the VM in
>> destination is well received.
>>
>>>      b) If the bdrv_inactive_all fails for one device, but the others
>>>         are fine, we go down the fail: label and don't reactivate, so
>>>         the source dies even though it might have been mostly OK.
>>>
>>
>>> We can move the _lock to before the check of s->state at the top,
>>> which would stop the cancel sneaking in early.
>>> In the case where postcopy was never enabled (!migrate_postcopy_ram())
>>> we can move the COMPLETED transition into the lock as well; so I think
>>> then we kind of become safe.
>>> In the case where postcopy was enabled I think we can do the COMPLETED
>>> transition before waiting for the return path to close - I think but
>>> I need to think more about that.
>>> And there seem to be some dodgy cases where we call the invalidate
>>> there after a late postcopy failure; that's bad, we shouldn't reactivate
>>> the source disks after going into postcopy.
>>>
>>> So, in summary; this function is a mess - it needs a much bigger
>>> fix than this patch.
>>>
>>
>> So what's the conclusion ?
>> Will you send a patch to fix it ? Or let's fix it step by step ?
>> I think Kevin's suggestion which just remove the *if* check is OK.
>
> I don't see any of the simple solutions are easy;  so I plan
> to look at it properly, but am not sure when;  if you have time
> to do it then feel free.
>

Hmm, we still have gaps between bdrv_inactivate_all() and migration thread
totally exit, which migration cancelling can slip in.
We do caught that case while we finished migration_completion() but
before the begin of cleanup work (It has global lock to be protected).
The related codes is:

                 migration_completion(s, current_active_state,
                                      &old_vm_running, &start_time);
                 break;
             }
         }
------------------------------------------------------> gap begin
         if (qemu_file_get_error(s->to_dst_file)) {
             migrate_set_state(&s->state, current_active_state,
                               MIGRATION_STATUS_FAILED);
             trace_migration_thread_file_err();
             break;
         }
         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         if (current_time >= initial_time + BUFFER_DELAY) {
             uint64_t transferred_bytes = qemu_ftell(s->to_dst_file) -
                                          initial_bytes;
             uint64_t time_spent = current_time - initial_time;
             double bandwidth = (double)transferred_bytes / time_spent;
             max_size = bandwidth * s->parameters.downtime_limit;

             s->mbps = (((double) transferred_bytes * 8.0) /
                     ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;

             trace_migrate_transferred(transferred_bytes, time_spent,
                                       bandwidth, max_size);
             /* if we haven't sent anything, we don't want to recalculate
                10000 is a small enough number for our purposes */
             if (s->dirty_bytes_rate && transferred_bytes > 10000) {
                 s->expected_downtime = s->dirty_bytes_rate / bandwidth;
             }

             qemu_file_reset_rate_limit(s->to_dst_file);
             initial_time = current_time;
             initial_bytes = qemu_ftell(s->to_dst_file);
         }
         if (qemu_file_rate_limit(s->to_dst_file)) {
             /* usleep expects microseconds */
             g_usleep((initial_time + BUFFER_DELAY - current_time)*1000);
         }
     }

     trace_migration_thread_after_loop();
     /* If we enabled cpu throttling for auto-converge, turn it off. */
     cpu_throttle_stop();
     end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
--------------------------------------------------------------> gap end
     qemu_mutex_lock_iothread();
     /*

So maybe we should call bdrv_invalidate_cache_all() in qmp_migrate_cancel()
directly ? which i think will cover all the cases. (Including another potential
case, which QEMU has finished the migration process, but libvirtd decides to
cancel the migration before shutdown it.)

The things here I'm not sure is, is it OK to call bdrv_invalidate_cache_all()
without bdrv_inactivate_all() has been called ? If not, we need to record
if we have inactive all blocks before call bdrv_invalidate_cache_all()。

Any ideas ?

Hailiang

> Dave
>
>>
>> Thanks,
>> Hailiang
>>
>>> Dave
>>>
>>>> Kevin
>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>
>>> .
>>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
> .
>
