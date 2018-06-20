Received: from eggs.gnu.org ([2001:4830:134:3::10]:49940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fVb1i-000522-FH
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fVb1d-0002cF-Iu
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:11:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:61151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fVb1c-0002Xp-AO
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:11:45 -0400
Message-ID: <5B2A375A.4030504@intel.com>
Date: Wed, 20 Jun 2018 19:15:38 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
	<1528445443-43406-5-git-send-email-wei.w.wang@intel.com>
	<20180612075016.GD15344@xz-mi> <5B1FAAAF.4030705@intel.com>
	<20180619173109.GM2368@work-vm>
In-Reply-To: <20180619173109.GM2368@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 4/6] migration/ram.c: add ram save state
 notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On 06/20/2018 01:31 AM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> On 06/12/2018 03:50 PM, Peter Xu wrote:
>>> On Fri, Jun 08, 2018 at 04:10:41PM +0800, Wei Wang wrote:
>>>> This patch adds a ram save state notifier list, and expose RAMState for
>>>> the notifer callbacks to use.
>>>>
>>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>> CC: Juan Quintela <quintela@redhat.com>
>>>> CC: Michael S. Tsirkin <mst@redhat.com>
>>>> CC: Peter Xu <peterx@redhat.com>
>>>> ---
>>>>    include/migration/misc.h | 52 +++++++++++++++++++++++++++++++++++++++
>>>>    migration/ram.c          | 64 +++++++++++++++++-------------------------------
>>>>    2 files changed, 75 insertions(+), 41 deletions(-)
>>>>
>>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>>> index 113320e..b970d7d 100644
>>>> --- a/include/migration/misc.h
>>>> +++ b/include/migration/misc.h
>>>> @@ -16,9 +16,61 @@
>>>>    #include "exec/cpu-common.h"
>>>>    #include "qemu/notify.h"
>>>> +#include "qemu/thread.h"
>>>>    /* migration/ram.c */
>>>> +typedef enum RamSaveState {
>>>> +    RAM_SAVE_ERR = 0,
>>>> +    RAM_SAVE_RESET = 1,
>>>> +    RAM_SAVE_BEFORE_SYNC_BITMAP = 2,
>>>> +    RAM_SAVE_AFTER_SYNC_BITMAP = 3,
>>>> +    RAM_SAVE_MAX = 4,
>>>> +} RamSaveState;
>>>> +
>>>> +/* State of RAM for migration */
>>>> +typedef struct RAMState {
>>>> +    /* QEMUFile used for this migration */
>>>> +    QEMUFile *f;
>>>> +    /* Last block that we have visited searching for dirty pages */
>>>> +    RAMBlock *last_seen_block;
>>>> +    /* Last block from where we have sent data */
>>>> +    RAMBlock *last_sent_block;
>>>> +    /* Last dirty target page we have sent */
>>>> +    ram_addr_t last_page;
>>>> +    /* last ram version we have seen */
>>>> +    uint32_t last_version;
>>>> +    /* We are in the first round */
>>>> +    bool ram_bulk_stage;
>>>> +    /* How many times we have dirty too many pages */
>>>> +    int dirty_rate_high_cnt;
>>>> +    /* ram save states used for notifiers */
>>>> +    int ram_save_state;
>>>> +    /* these variables are used for bitmap sync */
>>>> +    /* last time we did a full bitmap_sync */
>>>> +    int64_t time_last_bitmap_sync;
>>>> +    /* bytes transferred at start_time */
>>>> +    uint64_t bytes_xfer_prev;
>>>> +    /* number of dirty pages since start_time */
>>>> +    uint64_t num_dirty_pages_period;
>>>> +    /* xbzrle misses since the beginning of the period */
>>>> +    uint64_t xbzrle_cache_miss_prev;
>>>> +    /* number of iterations at the beginning of period */
>>>> +    uint64_t iterations_prev;
>>>> +    /* Iterations since start */
>>>> +    uint64_t iterations;
>>>> +    /* number of dirty bits in the bitmap */
>>>> +    uint64_t migration_dirty_pages;
>>>> +    /* protects modification of the bitmap */
>>>> +    QemuMutex bitmap_mutex;
>>>> +    /* The RAMBlock used in the last src_page_requests */
>>>> +    RAMBlock *last_req_rb;
>>>> +    /* Queue of outstanding page requests from the destination */
>>>> +    QemuMutex src_page_req_mutex;
>>>> +    QSIMPLEQ_HEAD(src_page_requests, RAMSrcPageRequest) src_page_requests;
>>>> +} RAMState;
>>> Why move these chunk?  Can it be avoided?
>>>
>>>> +
>>>> +void add_ram_save_state_change_notifier(Notifier *notify);
>>>>    void ram_mig_init(void);
>>>>    void qemu_guest_free_page_hint(void *addr, size_t len);
>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>> index 237f11e..d45b5a4 100644
>>>> --- a/migration/ram.c
>>>> +++ b/migration/ram.c
>>>> @@ -56,6 +56,9 @@
>>>>    #include "qemu/uuid.h"
>>>>    #include "savevm.h"
>>>> +static NotifierList ram_save_state_notifiers =
>>>> +    NOTIFIER_LIST_INITIALIZER(ram_save_state_notifiers);
>>>> +
>>>>    /***********************************************************/
>>>>    /* ram save/restore */
>>>> @@ -267,49 +270,18 @@ struct RAMSrcPageRequest {
>>>>        QSIMPLEQ_ENTRY(RAMSrcPageRequest) next_req;
>>>>    };
>>>> -/* State of RAM for migration */
>>>> -struct RAMState {
>>>> -    /* QEMUFile used for this migration */
>>>> -    QEMUFile *f;
>>>> -    /* Last block that we have visited searching for dirty pages */
>>>> -    RAMBlock *last_seen_block;
>>>> -    /* Last block from where we have sent data */
>>>> -    RAMBlock *last_sent_block;
>>>> -    /* Last dirty target page we have sent */
>>>> -    ram_addr_t last_page;
>>>> -    /* last ram version we have seen */
>>>> -    uint32_t last_version;
>>>> -    /* We are in the first round */
>>>> -    bool ram_bulk_stage;
>>>> -    /* How many times we have dirty too many pages */
>>>> -    int dirty_rate_high_cnt;
>>>> -    /* these variables are used for bitmap sync */
>>>> -    /* last time we did a full bitmap_sync */
>>>> -    int64_t time_last_bitmap_sync;
>>>> -    /* bytes transferred at start_time */
>>>> -    uint64_t bytes_xfer_prev;
>>>> -    /* number of dirty pages since start_time */
>>>> -    uint64_t num_dirty_pages_period;
>>>> -    /* xbzrle misses since the beginning of the period */
>>>> -    uint64_t xbzrle_cache_miss_prev;
>>>> -    /* number of iterations at the beginning of period */
>>>> -    uint64_t iterations_prev;
>>>> -    /* Iterations since start */
>>>> -    uint64_t iterations;
>>>> -    /* number of dirty bits in the bitmap */
>>>> -    uint64_t migration_dirty_pages;
>>>> -    /* protects modification of the bitmap */
>>>> -    QemuMutex bitmap_mutex;
>>>> -    /* The RAMBlock used in the last src_page_requests */
>>>> -    RAMBlock *last_req_rb;
>>>> -    /* Queue of outstanding page requests from the destination */
>>>> -    QemuMutex src_page_req_mutex;
>>>> -    QSIMPLEQ_HEAD(src_page_requests, RAMSrcPageRequest) src_page_requests;
>>>> -};
>>>> -typedef struct RAMState RAMState;
>>>> -
>>>>    static RAMState *ram_state;
>>>> +void add_ram_save_state_change_notifier(Notifier *notify)
>>>> +{
>>>> +    notifier_list_add(&ram_save_state_notifiers, notify);
>>>> +}
>>>> +
>>>> +static void notify_ram_save_state_change_notifier(void)
>>>> +{
>>>> +    notifier_list_notify(&ram_save_state_notifiers, ram_state);
>>>> +}
>>>> +
>>>>    uint64_t ram_bytes_remaining(void)
>>>>    {
>>>>        return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_SIZE) :
>>>> @@ -1139,6 +1111,9 @@ static void migration_bitmap_sync(RAMState *rs)
>>>>        int64_t end_time;
>>>>        uint64_t bytes_xfer_now;
>>>> +    rs->ram_save_state = RAM_SAVE_BEFORE_SYNC_BITMAP;
>>> What's the point to keep this state after all?...
>>>
>>>> +    notify_ram_save_state_change_notifier();
>>>> +
>>>>        ram_counters.dirty_sync_count++;
>>>>        if (!rs->time_last_bitmap_sync) {
>>>> @@ -1205,6 +1180,9 @@ static void migration_bitmap_sync(RAMState *rs)
>>>>        if (migrate_use_events()) {
>>>>            qapi_event_send_migration_pass(ram_counters.dirty_sync_count, NULL);
>>>>        }
>>>> +
>>>> +    rs->ram_save_state = RAM_SAVE_AFTER_SYNC_BITMAP;
>>>> +    notify_ram_save_state_change_notifier();
>>>>    }
>>>>    /**
>>>> @@ -1961,6 +1939,8 @@ static void ram_state_reset(RAMState *rs)
>>>>        rs->last_page = 0;
>>>>        rs->last_version = ram_list.version;
>>>>        rs->ram_bulk_stage = true;
>>>> +    rs->ram_save_state = RAM_SAVE_RESET;
>>> ... and this state is much more meaningless afaict ...
>>>
>>>> +    notify_ram_save_state_change_notifier();
>>>>    }
>>>>    #define MAX_WAIT 50 /* ms, half buffered_file limit */
>>>> @@ -2709,6 +2689,8 @@ out:
>>>>        ret = qemu_file_get_error(f);
>>>>        if (ret < 0) {
>>>> +        rs->ram_save_state = RAM_SAVE_ERR;
>>>> +        notify_ram_save_state_change_notifier();
>>>>            return ret;
>>>>        }
>>> Also, I would prefer to add a general event framework for migration
>>> rather than "ram save" specific.  Then we add SYNC_START/SYNC_END
>>> events.  These notifiers aren't a lot, it'll be a bit awkward to
>>> introduce the framework multiple times for similar purpuse (after we
>>> have a common notifier we can merge the postcopy notifiers AFAIU).
>> Hi Peter,
>>
>> Thanks for the review. We just got a little accident in the kernel part,
>> which may cause some modifications to the QEMU side interfaces. So I will
>> implement a new version and let you review in v9 patches.
> Yes, but please do try and keep RAMState private to ram.c.
>

OK, will use functions to expose the related fields (e.g. ram_bulk_stage).

Best,
Wei
