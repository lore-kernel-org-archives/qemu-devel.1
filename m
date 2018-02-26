Received: from eggs.gnu.org ([2001:4830:134:3::10]:35637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eqAxr-0000FW-6H
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 00:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eqAxn-0000Tp-2d
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 00:04:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:34508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eqAxm-0000Qs-OP
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 00:04:35 -0500
Message-ID: <5A93960B.9020102@intel.com>
Date: Mon, 26 Feb 2018 13:07:23 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
	<1517915299-15349-3-git-send-email-wei.w.wang@intel.com>
	<20180209115021.GB2428@work-vm>
In-Reply-To: <20180209115021.GB2428@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] migration: use the free page
 reporting feature from balloon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com

On 02/09/2018 07:50 PM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> Use the free page reporting feature from the balloon device to clear the
>> bits corresponding to guest free pages from the dirty bitmap, so that the
>> free memory are not sent.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> ---
>>   migration/ram.c | 24 ++++++++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index d6f462c..4fe16d2 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -49,6 +49,7 @@
>>   #include "qemu/rcu_queue.h"
>>   #include "migration/colo.h"
>>   #include "migration/block.h"
>> +#include "sysemu/balloon.h"
>>   
>>   /***********************************************************/
>>   /* ram save/restore */
>> @@ -206,6 +207,10 @@ struct RAMState {
>>       uint32_t last_version;
>>       /* We are in the first round */
>>       bool ram_bulk_stage;
>> +    /* The feature, skipping the transfer of free pages, is supported */
>> +    bool free_page_support;
>> +    /* Skip the transfer of free pages in the bulk stage */
>> +    bool free_page_done;
>>       /* How many times we have dirty too many pages */
>>       int dirty_rate_high_cnt;
>>       /* these variables are used for bitmap sync */
>> @@ -773,7 +778,7 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>>       unsigned long *bitmap = rb->bmap;
>>       unsigned long next;
>>   
>> -    if (rs->ram_bulk_stage && start > 0) {
>> +    if (rs->ram_bulk_stage && start > 0 && !rs->free_page_support) {
>>           next = start + 1;
>>       } else {
>>           next = find_next_bit(bitmap, size, start);
>> @@ -1653,6 +1658,8 @@ static void ram_state_reset(RAMState *rs)
>>       rs->last_page = 0;
>>       rs->last_version = ram_list.version;
>>       rs->ram_bulk_stage = true;
>> +    rs->free_page_support = balloon_free_page_support();
>> +    rs->free_page_done = false;
>>   }
>>   
>>   #define MAX_WAIT 50 /* ms, half buffered_file limit */
>> @@ -2135,7 +2142,7 @@ static int ram_state_init(RAMState **rsp)
>>       return 0;
>>   }
>>   
>> -static void ram_list_init_bitmaps(void)
>> +static void ram_list_init_bitmaps(RAMState *rs)
>>   {
>>       RAMBlock *block;
>>       unsigned long pages;
>> @@ -2145,7 +2152,11 @@ static void ram_list_init_bitmaps(void)
>>           QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>>               pages = block->max_length >> TARGET_PAGE_BITS;
>>               block->bmap = bitmap_new(pages);
>> -            bitmap_set(block->bmap, 0, pages);
>> +            if (rs->free_page_support) {
>> +                bitmap_set(block->bmap, 1, pages);
> I don't understand how it makes sense to do that here;
> ignoring anything ese it means that migration_dirty_pages is wrong
> which could end up with migration finishing before all real pages are
> sent.
>

The bulk stage treats all the pages as dirty pages, so we set all the 
bits to "1", this is needed by this optimization feature, because the 
free pages reported from the guest can then be directly cleared from the 
bitmap (we don't need any more bitmaps to record free pages).

Why is migration_dirty_pages incorrect?

Best,
Wei
