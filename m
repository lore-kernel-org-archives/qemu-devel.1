Received: from eggs.gnu.org ([209.51.188.92]:54424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1YGA-0002u4-Vk
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:15:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1YGA-0003uU-4F
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:15:06 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-3-jsnow@redhat.com>
	<d22251c0-bdca-4913-e8d3-aa6e032492db@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <401f0568-097e-322c-f7ca-bf1b3034eb9a@redhat.com>
Date: Wed, 6 Mar 2019 10:14:53 -0500
MIME-Version: 1.0
In-Reply-To: <d22251c0-bdca-4913-e8d3-aa6e032492db@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/7] block/dirty-bitmap: add
 inconsistent status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>



On 3/6/19 8:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> 01.03.2019 22:15, John Snow wrote:
>> Even though the status field is deprecated, we still have to support
>> it for a few more releases. Since this is a very new kind of bitmap
>> state, it makes sense for it to have its own status field.
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   qapi/block-core.json | 7 ++++++-
>>   block/dirty-bitmap.c | 7 ++++++-
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index e639ef6d1c..ae55cd0704 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -442,10 +442,15 @@
>>   #          recording new writes. If the bitmap was @disabled, it is not
>>   #          recording new writes. (Since 2.12)
>>   #
>> +# @inconsistent: This is a persistent dirty bitmap that was marked in-use on
>> +#                disk, and is unusable by QEMU. It can only be deleted.
>> +#                Please rely on the inconsistent field in @BlockDirtyInfo
>> +#                instead, as the status field is deprecated. (Since 4.0)
>> +#
>>   # Since: 2.4
>>   ##
>>   { 'enum': 'DirtyBitmapStatus',
>> -  'data': ['active', 'disabled', 'frozen', 'locked'] }
>> +  'data': ['active', 'disabled', 'frozen', 'locked', 'inconsistent'] }
>>   
>>   ##
>>   # @BlockDirtyInfo:
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 9e8630e1ac..71e0098396 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -209,10 +209,15 @@ bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap)
>>    *               or it can be Disabled and not recording writes.
>>    * (4) Locked:   Whether Active or Disabled, the user cannot modify this bitmap
>>    *               in any way from the monitor.
>> + * (5) Inconsistent: This is a persistent bitmap whose "in use" bit is set, and
> 
> "was", like in qapi is better than "is", as while qemu running other (not inconsistent)
> bitmaps' IN_USE bit is also set..
> 
> but I don't really care about deprecated comment:), anyway:
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Hm, this is a weird English thing. "Was set" references some event in
the past but doesn't necessarily imply that it is still set. "is set"
implies that it is still currently set, which I think is correct.

But, I don't care much about the deprecated comment either :)
