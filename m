Received: from eggs.gnu.org ([2001:4830:134:3::10]:35548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gRaU2-00052W-PP
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gRaTz-00055X-JX
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:20:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:11327)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gRaTz-00054L-9c
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:20:43 -0500
Message-ID: <5BFD1BA4.5040202@intel.com>
Date: Tue, 27 Nov 2018 18:25:40 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
	<1542276484-25508-6-git-send-email-wei.w.wang@intel.com>
	<20181127073802.GC3205@xz-x1>
In-Reply-To: <20181127073802.GC3205@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 5/8] migration/ram.c: add a notifier
 chain for precopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On 11/27/2018 03:38 PM, Peter Xu wrote:
> On Thu, Nov 15, 2018 at 06:08:01PM +0800, Wei Wang wrote:
>>   
>> +typedef enum PrecopyNotifyReason {
>> +    PRECOPY_NOTIFY_ERR = 0,
>> +    PRECOPY_NOTIFY_START_ITERATION = 1,
>> +    PRECOPY_NOTIFY_BEFORE_SYNC_BITMAP = 2,
>> +    PRECOPY_NOTIFY_AFTER_SYNC_BITMAP = 3,
>> +    PRECOPY_NOTIFY_MAX = 4,
> It would be nice to add some comments for each of the notify reason.
> E.g., from the name PRECOPY_NOTIFY_START_ITERATION seems more like a
> hook at the start of each iteration but according to [1] it should be
> at the start of migration rather than each iteration (or when
> migration restarts, though I'm not sure whether we really have this
> yet).

OK. I think It would be better if the name itself could be straightforward.
Probably we could change PRECOPY_NOTIFY_START_ITERATION to
PRECOPY_NOTIFY_START_MIGRATION.


>> +} PrecopyNotifyReason;
>> +
>> +void precopy_infrastructure_init(void);
>> +void precopy_add_notifier(Notifier *n);
>> +void precopy_remove_notifier(Notifier *n);
>> +
>>   void ram_mig_init(void);
>>   void qemu_guest_free_page_hint(void *addr, size_t len);
>>   
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 229b791..65b1223 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -292,6 +292,8 @@ struct RAMState {
>>       bool ram_bulk_stage;
>>       /* How many times we have dirty too many pages */
>>       int dirty_rate_high_cnt;
>> +    /* ram save states used for notifiers */
>> +    int ram_save_state;
> This can be removed?

Yes, thanks.

>
>>       /* these variables are used for bitmap sync */
>>       /* last time we did a full bitmap_sync */
>>       int64_t time_last_bitmap_sync;
>> @@ -328,6 +330,28 @@ typedef struct RAMState RAMState;
>>   
>>   static RAMState *ram_state;
>>   
>> +static NotifierList precopy_notifier_list;
>> +
>> +void precopy_infrastructure_init(void)
>> +{
>> +    notifier_list_init(&precopy_notifier_list);
>> +}
>> +
>> +void precopy_add_notifier(Notifier *n)
>> +{
>> +    notifier_list_add(&precopy_notifier_list, n);
>> +}
>> +
>> +void precopy_remove_notifier(Notifier *n)
>> +{
>> +    notifier_remove(n);
>> +}
>> +
>> +static void precopy_notify(PrecopyNotifyReason reason)
>> +{
>> +    notifier_list_notify(&precopy_notifier_list, &reason);
>> +}
>> +
>>   uint64_t ram_bytes_remaining(void)
>>   {
>>       return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_SIZE) :
>> @@ -1642,6 +1666,8 @@ static void migration_bitmap_sync(RAMState *rs)
>>       int64_t end_time;
>>       uint64_t bytes_xfer_now;
>>   
>> +    precopy_notify(PRECOPY_NOTIFY_BEFORE_SYNC_BITMAP);
>> +
>>       ram_counters.dirty_sync_count++;
>>   
>>       if (!rs->time_last_bitmap_sync) {
>> @@ -1699,6 +1725,8 @@ static void migration_bitmap_sync(RAMState *rs)
>>       if (migrate_use_events()) {
>>           qapi_event_send_migration_pass(ram_counters.dirty_sync_count);
>>       }
>> +
>> +    precopy_notify(PRECOPY_NOTIFY_AFTER_SYNC_BITMAP);
>>   }
>>   
>>   /**
>> @@ -2555,6 +2583,8 @@ static void ram_state_reset(RAMState *rs)
>>       rs->last_page = 0;
>>       rs->last_version = ram_list.version;
>>       rs->ram_bulk_stage = true;
>> +
>> +    precopy_notify(PRECOPY_NOTIFY_START_ITERATION);
> [1]
>
>>   }
>>   
>>   #define MAX_WAIT 50 /* ms, half buffered_file limit */
>> @@ -3324,6 +3354,7 @@ out:
>>   
>>       ret = qemu_file_get_error(f);
>>       if (ret < 0) {
>> +        precopy_notify(PRECOPY_NOTIFY_ERR);
> Could you show me which function is this line in?
>
> Line 3324 here is ram_save_complete(), but I cannot find this exact
> place.

Sure, it's in ram_save_iterate():
...
out:
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     qemu_fflush(f);
     ram_counters.transferred += 8;

     ret = qemu_file_get_error(f);
     if (ret < 0) {
+        precopy_notify(PRECOPY_NOTIFY_ERR);
         return ret;
     }

     return done;
}


>
> Another thing to mention about the "reasons" (though I see it more
> like "events"): have you thought about adding a PRECOPY_NOTIFY_END?
> It might help in some cases:
>
>    - then you don't need to trickily export the migrate_postcopy()
>      since you'll notify that before postcopy starts

I'm thinking probably we don't need to export migrate_postcopy even now.
It's more like a sanity check, and not needed because now we have the
notifier registered to the precopy specific callchain, which has ensured 
that
it is invoked via precopy.

>    - you'll have a solid point that you'll 100% guarantee that we'll
>      stop the free page hinting and don't need to worry about whether
>      there is chance the hinting will be running without an end [2].

Thanks, I think it makes sense. Plan to add PRECOPY_NOTIFY_END in 
ram_save_complete.


>
> Regarding [2] above: now the series only stops the hinting when
> PRECOPY_NOTIFY_BEFORE_SYNC_BITMAP is notified.  Could there be a case
> that it's missing?  E.g., what if we cancel/fail a migration during
> precopy?  Have you tried it?
>

I think it has been handled by the above PRECOPY_NOTIFY_ERR

Best,
Wei
