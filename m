Received: from eggs.gnu.org ([2001:4830:134:3::10]:54991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ew0CT-000553-3a
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ew0CP-0007Fi-8c
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:47:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:37558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ew0CO-0007DY-Tz
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:47:45 -0400
Message-ID: <5AA8C644.1020308@intel.com>
Date: Wed, 14 Mar 2018 14:50:44 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
	<1520426065-40265-5-git-send-email-wei.w.wang@intel.com>
	<20180313183050-mutt-send-email-mst@kernel.org>
	<5AA88BE0.3020004@intel.com>
	<20180314044737-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180314044737-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/4] migration: use the free page hint
 feature from balloon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On 03/14/2018 10:51 AM, Michael S. Tsirkin wrote:
> On Wed, Mar 14, 2018 at 10:41:36AM +0800, Wei Wang wrote:
>> On 03/14/2018 12:35 AM, Michael S. Tsirkin wrote:
>>> On Wed, Mar 07, 2018 at 08:34:25PM +0800, Wei Wang wrote:
>>>> Start the free page optimization after the migration bitmap is
>>>> synchronized. This can't be used in the stop&copy phase since the guest
>>>> is paused. Make sure the guest reporting has stopped before
>>>> synchronizing the migration dirty bitmap. Currently, the optimization is
>>>> added to precopy only.
>>>>
>>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>> CC: Juan Quintela <quintela@redhat.com>
>>>> CC: Michael S. Tsirkin <mst@redhat.com>
>>>> ---
>>>>    migration/ram.c | 19 ++++++++++++++++++-
>>>>    1 file changed, 18 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>> index e172798..7b4c9b1 100644
>>>> --- a/migration/ram.c
>>>> +++ b/migration/ram.c
>>>> @@ -51,6 +51,8 @@
>>>>    #include "qemu/rcu_queue.h"
>>>>    #include "migration/colo.h"
>>>>    #include "migration/block.h"
>>>> +#include "sysemu/balloon.h"
>>>> +#include "sysemu/sysemu.h"
>>>>    /***********************************************************/
>>>>    /* ram save/restore */
>>>> @@ -208,6 +210,8 @@ struct RAMState {
>>>>        uint32_t last_version;
>>>>        /* We are in the first round */
>>>>        bool ram_bulk_stage;
>>>> +    /* The free pages optimization feature is supported */
>>>> +    bool free_page_support;
>>>>        /* How many times we have dirty too many pages */
>>>>        int dirty_rate_high_cnt;
>>>>        /* these variables are used for bitmap sync */
>>>> @@ -775,7 +779,7 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>>>>        unsigned long *bitmap = rb->bmap;
>>>>        unsigned long next;
>>>> -    if (rs->ram_bulk_stage && start > 0) {
>>>> +    if (rs->ram_bulk_stage && start > 0 && !rs->free_page_support) {
>>>>            next = start + 1;
>>>>        } else {
>>>>            next = find_next_bit(bitmap, size, start);
>>>> @@ -833,6 +837,10 @@ static void migration_bitmap_sync(RAMState *rs)
>>>>        int64_t end_time;
>>>>        uint64_t bytes_xfer_now;
>>>> +    if (rs->free_page_support) {
>>>> +        balloon_free_page_stop();
>>>> +    }
>>>> +
>>>>        ram_counters.dirty_sync_count++;
>>>>        if (!rs->time_last_bitmap_sync) {
>>>> @@ -899,6 +907,10 @@ static void migration_bitmap_sync(RAMState *rs)
>>>>        if (migrate_use_events()) {
>>>>            qapi_event_send_migration_pass(ram_counters.dirty_sync_count, NULL);
>>>>        }
>>>> +
>>>> +    if (rs->free_page_support && runstate_is_running()) {
>>>> +        balloon_free_page_start();
>>>> +    }
>>>>    }
>>> I think some of these conditions should go into
>>> balloon_free_page_start/stop.
>>>
>>> Checking runstate is generally problematic unless you
>>> also handle run state change notifiers as it can
>>> be manipulated from QMP.
>> How about moving the check of runstate to
>> virtio_balloon_poll_free_page_hints:
>>
>> while (dev->free_page_report_status < FREE_PAGE_REPORT_S_STOP &&
>> runstate_is_running()) {
>> ...
>> }
> Hard to tell on the outset. E.g. why is just stop affected?  Pls add
> comments explaining what happens if VM is not running when start or stop
> is called.
>
>
>> In this case, I think we won't need a notifier - if the run state is changed
>> by qmp, the optimization thread will just exist.
> But you need to wake it up and notify the guest presumably?
>


I think it's not necessary to wake it up, because when the VM is not 
running, there will be no hints reported to the vq, and the optimization 
thread exits. (there is no issue in that case)
Probably we can add a notifier which calls 
virtio_balloon_free_page_stop() when qmp wakes up the VM.

Best,
Wei
