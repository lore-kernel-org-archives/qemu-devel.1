Received: from eggs.gnu.org ([2001:4830:134:3::10]:54965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1etYae-0005xN-8H
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1etYaa-0000x5-Ar
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:54:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:26378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1etYaa-0000wi-1P
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:54:36 -0500
Message-ID: <5A9FE1BB.6040105@intel.com>
Date: Wed, 07 Mar 2018 20:57:31 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1519980450-3404-1-git-send-email-wei.w.wang@intel.com>
	<1519980450-3404-4-git-send-email-wei.w.wang@intel.com>
	<20180307123209.GD3089@work-vm>
In-Reply-To: <20180307123209.GD3089@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] migration: use the free page hint
 feature from balloon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On 03/07/2018 08:32 PM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> Start the free page optimization when the bulk stage starts. In case the
>> guest is slow in reporting, actively stops it when the bulk stage ends.
>> The optimization avoids sending guest free pages during the bulk stage.
>> Currently, the optimization is added to precopy only.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
> I think this is OK, but with the only problem being that postcopy will
> break;  we need to disable the mechanism if postcopy is enabled.
>
> Dave
>
>> ---
>>   migration/ram.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 769a0f6..f6af7e6 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -51,6 +51,7 @@
>>   #include "qemu/rcu_queue.h"
>>   #include "migration/colo.h"
>>   #include "migration/block.h"
>> +#include "sysemu/balloon.h"
>>   
>>   /***********************************************************/
>>   /* ram save/restore */
>> @@ -208,6 +209,8 @@ struct RAMState {
>>       uint32_t last_version;
>>       /* We are in the first round */
>>       bool ram_bulk_stage;
>> +    /* The free pages optimization feature is supported */
>> +    bool free_page_support;
>>       /* How many times we have dirty too many pages */
>>       int dirty_rate_high_cnt;
>>       /* these variables are used for bitmap sync */
>> @@ -775,7 +778,7 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>>       unsigned long *bitmap = rb->bmap;
>>       unsigned long next;
>>   
>> -    if (rs->ram_bulk_stage && start > 0) {
>> +    if (rs->ram_bulk_stage && start > 0 && !rs->free_page_support) {
>>           next = start + 1;
>>       } else {
>>           next = find_next_bit(bitmap, size, start);
>> @@ -1225,6 +1228,10 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss, bool *again)
>>               /* Flag that we've looped */
>>               pss->complete_round = true;
>>               rs->ram_bulk_stage = false;
>> +            if (rs->free_page_support) {
>> +                balloon_free_page_stop();
>> +                rs->free_page_support = false;
>> +            }
>>               if (migrate_use_xbzrle()) {
>>                   /* If xbzrle is on, stop using the data compression at this
>>                    * point. In theory, xbzrle can do better than compression.
>> @@ -1656,6 +1663,8 @@ static void ram_state_reset(RAMState *rs)
>>       rs->last_page = 0;
>>       rs->last_version = ram_list.version;
>>       rs->ram_bulk_stage = true;
>> +    rs->free_page_support = balloon_free_page_support() &
>> +                            !migration_in_postcopy();

We checked the postcopy here :)

Best,
Wei
