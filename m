Received: from eggs.gnu.org ([209.51.188.92]:37714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gphd7-0001Xa-BF
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gphd5-0002HL-A4
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:49:49 -0500
References: <20190131010136.12007-1-jsnow@redhat.com>
	<bd72a7c8-e283-dd3a-66e8-ba50873a8717@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <25c4dfd9-9aa9-9eb0-88c0-58df87e17c25@redhat.com>
Date: Fri, 1 Feb 2019 17:49:32 -0500
MIME-Version: 1.0
In-Reply-To: <bd72a7c8-e283-dd3a-66e8-ba50873a8717@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/dirty-bitmap: Documentation and
 Comment fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>



On 1/31/19 3:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> 31.01.2019 4:01, John Snow wrote:
>> The meaning of the states has changed subtly over time,
>> this should bring the understanding more in-line with the
>> current, actual usages.
>>
>> Reported-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   block/dirty-bitmap.c | 19 +++++++++++++------
>>   qapi/block-core.json | 17 ++++++++++++-----
>>   2 files changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 00ea36f554..e2adf54dd3 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -29,12 +29,19 @@
>>   #include "block/blockjob.h"
>>   
>>   /**
>> - * A BdrvDirtyBitmap can be in three possible states:
>> - * (1) successor is NULL and disabled is false: full r/w mode
>> - * (2) successor is NULL and disabled is true: read only mode ("disabled")
>> - * (3) successor is set: frozen mode.
>> - *     A frozen bitmap cannot be renamed, deleted, anonymized, cleared, set,
>> - *     or enabled. A frozen bitmap can only abdicate() or reclaim().
>> + * A BdrvDirtyBitmap can be in four possible user-visible states:
>> + * (1) Active:   successor is NULL, and disabled is false: full r/w mode
>> + * (2) Disabled: successor is NULL, and disabled is true: qualified r/w mode,
>> + *               guest writes are dropped, but monitor writes are possible,
>> + *               through commands like merge and clear.
>> + * (3) Frozen:   successor is not null.
>> + *               A frozen bitmap cannot be renamed, deleted, cleared, set,
>> + *               enabled, merged to, etc. A frozen bitmap can only abdicate()
>> + *               or reclaim().
>> + *               In this state, the successor bitmap is Active and will
>> + *               generally be recording writes from the guest for us.
> 
> Not necessarily. Frozen bitmap may be disabled in the same time, and successor is then
> disabled too.
> 
> So, disabled/enabled is orthogonal to normal/frozen/locked..
> 

Ah, yeah, I was trying to communicate this but I failed. I shouldn't use
wiggly language like "generally." I'll clean this up to be more explicit.

> Hm, while looking at this, I see that we don't check in _create_successor for locked
> state, so we theoretically could create frozen-locked..
> 
> Also, I remember there was an idea of deprecating Frozen and reporting Locked for
> backup too, didn't you think about it? So, successors becomes internal and invisible by
> user in any sense, and we just say "Locked".
> 

That would be better. Would it cause any harm to clients that know about
"Frozen" but not about "Locked"? This might have to be a 3-releases
deprecation change.

> Anyway patch is good, I'd just prefer to fix it here, to show that Frozen may be disabled too.
> 
> 
>> + * (4) Locked:   Whether Active or Disabled, the user cannot modify this bitmap
>> + *               in any way from the monitor.
>>    */
>>   struct BdrvDirtyBitmap {
>>       QemuMutex *mutex;
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 91685be6c2..eba126c76e 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -418,10 +418,12 @@
>>   # An enumeration of possible states that a dirty bitmap can report to the user.
>>   #
>>   # @frozen: The bitmap is currently in-use by a backup operation or block job,
>> -#          and is immutable.
>> +#          and is immutable. New writes by the guest are being recorded in a
>> +#          cache, and are not lost.
>>   #
>> -# @disabled: The bitmap is currently in-use by an internal operation and is
>> -#            read-only. It can still be deleted.
>> +# @disabled: The bitmap is not currently recording new writes by the guest.
>> +#            This is requested explicitly via @block-dirty-bitmap-disable.
>> +#            It can still be cleared, deleted, or used for backup operations.
>>   #
>>   # @active: The bitmap is actively monitoring for new writes, and can be cleared,
>>   #          deleted, or used for backup operations.
>> @@ -1944,9 +1946,14 @@
>>   # @block-dirty-bitmap-merge:
>>   #
>>   # Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
>> -# The @bitmaps dirty bitmaps are unchanged.
>> +# Dirty bitmaps in @bitmaps will be unchanged.
> 
> except the case when @target is in @bitmaps too? Not sure about should we mention this.
> 

Oh, right. I guess I'll try to be more careful about the phrasing.

> About @frozen and @locked, we can also note that they can't be exported through NBD.
> We can summarize, that @frozen and @locked means that user can't use them in any
> command, and the only option is to list them. However even info->count information
> should not be considered as something meaningful, as bitmaps are under some operations.
> And we can also use same paragraph for @frozen and @locked, as a first step to @frozen
> deprecation.
> 

Good suggestion.

>> +# Any bits already set in @target will still be set after the merge.
>>   # On error, @target is unchanged.
>>   #
>> +# The resulting bitmap will count as dirty any clusters that were dirty in any
>> +# of the source bitmaps. This can be used to achieve backup checkpoints, or in
>> +# simpler usages, to copy bitmaps.
>> +#
>>   # Returns: nothing on success
>>   #          If @node is not a valid block device, DeviceNotFound
>>   #          If any bitmap in @bitmaps or @target is not found, GenericError
>> @@ -1981,7 +1988,7 @@
>>   ##
>>   # @x-debug-block-dirty-bitmap-sha256:
>>   #
>> -# Get bitmap SHA256
>> +# Get bitmap SHA256.
>>   #
>>   # Returns: BlockDirtyBitmapSha256 on success
>>   #          If @node is not a valid block device, DeviceNotFound
>>
> 
> 

Thanks!
