Received: from eggs.gnu.org ([2001:4830:134:3::10]:52896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ewnMo-00053I-TX
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ewnMk-0003Qd-SU
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:17:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:60252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ewnMk-0003QC-Io
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:17:42 -0400
Message-ID: <5AABA88C.8070000@intel.com>
Date: Fri, 16 Mar 2018 19:20:44 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
	<1520426065-40265-5-git-send-email-wei.w.wang@intel.com>
	<20180314194954.GJ3006@work-vm>
In-Reply-To: <20180314194954.GJ3006@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com

On 03/15/2018 03:49 AM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> Start the free page optimization after the migration bitmap is
>> synchronized. This can't be used in the stop&copy phase since the guest
>> is paused. Make sure the guest reporting has stopped before
>> synchronizing the migration dirty bitmap. Currently, the optimization is
>> added to precopy only.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   migration/ram.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index e172798..7b4c9b1 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -51,6 +51,8 @@
>>   #include "qemu/rcu_queue.h"
>>   #include "migration/colo.h"
>>   #include "migration/block.h"
>> +#include "sysemu/balloon.h"
>> +#include "sysemu/sysemu.h"
>>   
>>   /***********************************************************/
>>   /* ram save/restore */
>> @@ -208,6 +210,8 @@ struct RAMState {
>>       uint32_t last_version;
>>       /* We are in the first round */
>>       bool ram_bulk_stage;
>> +    /* The free pages optimization feature is supported */
>> +    bool free_page_support;
>>       /* How many times we have dirty too many pages */
>>       int dirty_rate_high_cnt;
>>       /* these variables are used for bitmap sync */
>> @@ -775,7 +779,7 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>>       unsigned long *bitmap = rb->bmap;
>>       unsigned long next;
>>   
>> -    if (rs->ram_bulk_stage && start > 0) {
>> +    if (rs->ram_bulk_stage && start > 0 && !rs->free_page_support) {
>>           next = start + 1;
> An easier thing is just to clear the ram_bulk_stage flag (and if you're
> doing it in the middle of the migration you need to reset some of the
> pointers; see postcopy_start for an example).
>
>>       } else {
>>           next = find_next_bit(bitmap, size, start);
>> @@ -833,6 +837,10 @@ static void migration_bitmap_sync(RAMState *rs)
>>       int64_t end_time;
>>       uint64_t bytes_xfer_now;
>>   
>> +    if (rs->free_page_support) {
>> +        balloon_free_page_stop();
> Does balloon_free_page_stop cause it to immediately stop, or does it
> just ask nicely?   Could a slow guest keep pumping advice to us even
> when it was stopped?
>

Yes, balloon_free_page_stop will cause the optimization thread to exit 
immediately. It doesn't rely on anything from the guest.
The guest won't keep reporting, since before the optimization thread 
exits, it sends a stop sign to the guest to stop reporting (but not 
waiting for any ACKs as that's not needed actually).

I also applied other comments in the new version, please have check v5 
patches. Thanks.

Best,
Wei
