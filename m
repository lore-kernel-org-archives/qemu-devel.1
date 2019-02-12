Received: from eggs.gnu.org ([209.51.188.92]:54915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtdaQ-0002uY-HB
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtdLW-0007UU-8q
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:03:56 -0500
References: <20190212010248.11056-1-jsnow@redhat.com>
	<20190212010248.11056-4-jsnow@redhat.com>
	<85831164-fd1e-aa7b-4fc1-e840e38967f3@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f7521470-6b2a-7ecf-f383-5c3e3c45080b@redhat.com>
Date: Tue, 12 Feb 2019 14:03:30 -0500
MIME-Version: 1.0
In-Reply-To: <85831164-fd1e-aa7b-4fc1-e840e38967f3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] block/dirty-bitmap: change semantics
 of enabled predicate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 2/12/19 1:58 PM, Eric Blake wrote:
> On 2/11/19 7:02 PM, John Snow wrote:
>> Currently, enabled means something like "the status of the bitmap
>> is ACTIVE." After this patch, it should mean exclusively: "This
>> bitmap is recording guest writes, and is allowed to do so."
>>
>> In many places, this is how this predicate was already used.
>> We'll allow users to call user_locked if they're really curious about
>> finding out if the bitmap is in use by an operation.
>>
>> To accommodate this, modify the create_successor routine to now
>> explicitly disable the parent bitmap at creation time.
>>
>>
>> Justifications:
>>
>> 1. bdrv_dirty_bitmap_status suffers no change from the lack of
>>    1:1 parity with the new predicates because of the order in which
>>    the predicates are checked. This is now only for compatibility.
>>
>> 2. bdrv_set_dirty_bitmap is only used by mirror, which does not use
>>    disabled bitmaps -- all of these writes are internal usages.
>>    Therefore, we should allow writes even in the disabled state.
>>    The condition is removed.
>>
>> 3. bdrv_reset_dirty_bitmap Similarly, this is only used internally by
>>    mirror and migration. In these contexts it is always enabled anyway,
>>    but our API does not need to enforce this.
>>
>> 4. bdrv_set_dirty will skip recording writes from the guest here if
>>    we are disabled OR if we had a successor, which now changes.
>>    Accommodate the change by explicitly disabling bitmaps with successors.
> 
> I didn't quite follow this wording.  My try:
> 
> The code in bdrv_set_dirty() is unchanged: pre-patch, it was skipping
> bitmaps that were disabled or had a successor, while post-patch it is
> only skipping bitmaps that are disabled. But we have the same behavior
> because the change to create_successor now ensures that any bitmap with
> a successor is disabled.
> 

Yes, sorry, the final sentence there is doing a lot of heavy lifting.

>>
>> 5. qcow2/dirty-bitmap: This only ever wanted to check if the bitmap
> 
> Did you mean qcow2_store_persistent_dirty_bitmaps()?
> 

Ah, yeah, I skipped the function name. Yes, that function. It's the only
use in this file.

>>    was enabled or not. Theoretically if we save during an operation,
>>    this now gets set as enabled instead of disabled.
> 
> I'm not sure I see the theoretical change in behavior (let alone whether
> you could write an iotest to expose it).  Pre-patch, persistent bitmaps
> that were disabled or which had a successor did not have the AUTO bit
> set (although since we currently only write persistent bitmaps out to
> file at exit, when there should be no ongoing jobs and thus no
> successors); post-patch, only disabled bitmaps do not have the AUTO bit
> (but a bitmap with a successor is disabled because of the change to
> create_successor).  But I agree that this code did not need a change due
> to the new semantics of bdrv_dirty_bitmap_enabled.
> 

Right, the change is extremely subtle and likely should be impossible to
see. If you CAN see it, that's a bug!

>>
>> 6. block_dirty_bitmap_enable_prepare only ever cared if about the
> 
> s/if //
> 
>>    literal bit, and already checked for user_locked beforehand.
> 
> That is, the check for user_locked already ruled out the has_successor
> clause.
> 

Yes.

>>
>> 7. block_dirty_bitmap_disable_prepare ditto as above.
>>
>> 8. init_dirty_bitmap_migration also already checks user_locked,
>>    so this call can be a simple enabled/disabled check.
> 
> Looks like correct conversions to me.
> 
>> ---
>>  block/dirty-bitmap.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thanks!
