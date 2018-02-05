Received: from eggs.gnu.org ([2001:4830:134:3::10]:57473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eifSP-0003CF-Go
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eifSF-0005pD-US
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:01:09 -0500
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
	<20180116125427.18540-6-vsementsov@virtuozzo.com>
	<87mv0qf46w.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5cfead5d-4979-bb47-7975-9246a33a44d3@virtuozzo.com>
Date: Mon, 5 Feb 2018 15:00:46 +0300
MIME-Version: 1.0
In-Reply-To: <87mv0qf46w.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 5/6] qapi: add block-dirty-bitmap-merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org, jsnow@redhat.com

03.02.2018 19:06, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   qapi/block-core.json         | 38 ++++++++++++++++++++++++++++++++++++++
>>   include/block/dirty-bitmap.h |  2 ++
>>   block/dirty-bitmap.c         | 18 ++++++++++++++++++
>>   blockdev.c                   | 30 ++++++++++++++++++++++++++++++
>>   4 files changed, 88 insertions(+)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index b3851ee760..9f9cfa0a44 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1604,6 +1604,20 @@
>>               '*persistent': 'bool', '*autoload': 'bool' } }
>>   
>>   ##
>> +# @BlockDirtyBitmapMerge:
>> +#
>> +# @node: name of device/node which the bitmap is tracking
>> +#
>> +# @dst_name: name of the destination dirty bitmap
>> +#
>> +# @src_name: name of the source dirty bitmap
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'struct': 'BlockDirtyBitmapMerge',
>> +  'data': { 'node': 'str', 'dst_name': 'str', 'src_name': 'str' } }
> Please use '-' instead of '_' in QAPI.  Exceptions are possible for
> consistency with existing (mal-)practice.

Ok.

>
>> +
>> +##
>>   # @block-dirty-bitmap-add:
>>   #
>>   # Create a dirty bitmap with a name on the node, and start tracking the writes.
>> @@ -1714,6 +1728,30 @@
>>         'data': 'BlockDirtyBitmap' }
>>   
>>   ##
>> +# @block-dirty-bitmap-merge:
>> +#
>> +# Merge @src_name dirty bitmap to @dst_name dirty bitmap. @src_name dirty
>> +# bitmap is unchanged.
>> +#
>> +# Returns: nothing on success
>> +#          If @node is not a valid block device, DeviceNotFound
>> +#          If @dst_name or @src_name is not found, GenericError
>> +#          If bitmaps has different sizes or granularities, GenericError
> The less error classes other than GenericError are used, the happier I
> am...  Do users really need to distinguish between the first error and
> other errors?

this semantic is already used for other bitmap related commands..

>
>> +#
>> +# Since: 2.12
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "block-dirty-bitmap-merge",
>> +#      "arguments": { "node": "drive0", "dst_name": "bitmap0",
>> +#                     "src_name": "bitmap1" } }
>> +# <- { "return": {} }
>> +#
>> +##
>> +      { 'command': 'block-dirty-bitmap-merge',
>> +        'data': 'BlockDirtyBitmapMerge' }
>> +
>> +##
>>   # @BlockDirtyBitmapSha256:
>>   #
>>   # SHA256 hash of dirty bitmap data
> [...]


-- 
Best regards,
Vladimir
