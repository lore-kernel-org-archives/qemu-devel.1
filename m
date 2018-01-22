Received: from eggs.gnu.org ([2001:4830:134:3::10]:55095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1edY74-0001ZP-RC
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1edY73-0000VK-Mv
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:09:58 -0500
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
	<20180116125427.18540-4-vsementsov@virtuozzo.com>
	<887a889a-e5bc-1a38-7fc9-87bf5d7a6e1b@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d838bf06-3198-79b4-53d0-1c729e9ce580@virtuozzo.com>
Date: Mon, 22 Jan 2018 12:09:42 +0300
MIME-Version: 1.0
In-Reply-To: <887a889a-e5bc-1a38-7fc9-87bf5d7a6e1b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add
 block-dirty-bitmap-enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

20.01.2018 02:50, John Snow wrote:
>
> On 01/16/2018 07:54 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   qapi/block-core.json | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   blockdev.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 84 insertions(+)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 827254db22..b3851ee760 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1672,6 +1672,48 @@
>>     'data': 'BlockDirtyBitmap' }
>>   
>>   ##
>> +# @block-dirty-bitmap-enable:
>> +#
>> +# Enable dirty bitmap, so that it will continue tracking disk changes.
>> +#
> suggest:
> "Enables a dirty bitmap so that it will begin tracking disk changes."
>
> Key item here is "begin" instead of "continue".

agree.

>
>> +# Returns: nothing on success
>> +#          If @node is not a valid block device, DeviceNotFound
>> +#          If @name is not found, GenericError with an explanation
>> +#
>> +# Since: 2.12
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "block-dirty-bitmap-enable",
>> +#      "arguments": { "node": "drive0", "name": "bitmap0" } }
>> +# <- { "return": {} }
>> +#
>> +##
>> +  { 'command': 'block-dirty-bitmap-enable',
>> +    'data': 'BlockDirtyBitmap' }
>> +
>> +##
>> +# @block-dirty-bitmap-disable:
>> +#
>> +# Disable dirty bitmap, so that it will stop tracking disk changes.
>> +#
> suggest:
> "Disables a dirty bitmap so that it will stop tracking disk changes."
>
>> +# Returns: nothing on success
>> +#          If @node is not a valid block device, DeviceNotFound
>> +#          If @name is not found, GenericError with an explanation
>> +#
>> +# Since: 2.12
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "block-dirty-bitmap-disable",
>> +#      "arguments": { "node": "drive0", "name": "bitmap0" } }
>> +# <- { "return": {} }
>> +#
>> +##
>> +    { 'command': 'block-dirty-bitmap-disable',
>> +      'data': 'BlockDirtyBitmap' }
>> +
>> +##
>>   # @BlockDirtyBitmapSha256:
>>   #
>>   # SHA256 hash of dirty bitmap data
>> diff --git a/blockdev.c b/blockdev.c
>> index 8068cbd606..997a6f514c 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -2821,6 +2821,48 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
>>       bdrv_clear_dirty_bitmap(bitmap, NULL);
>>   }
>>   
>> +void qmp_block_dirty_bitmap_enable(const char *node, const char *name,
>> +                                   Error **errp)
>> +{
>> +    BlockDriverState *bs;
>> +    BdrvDirtyBitmap *bitmap;
>> +
>> +    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
>> +    if (!bitmap || !bs) {
>> +        return;
>> +    }
>> +
>> +    if (bdrv_dirty_bitmap_frozen(bitmap)) {
>> +        error_setg(errp,
>> +                   "Bitmap '%s' is currently frozen and cannot be enabled",
>> +                   name);
>> +        return;
>> +    }
>> +
>> +    bdrv_enable_dirty_bitmap(bitmap);
>> +}
>> +
>> +void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
>> +                                    Error **errp)
>> +{
>> +    BlockDriverState *bs;
>> +    BdrvDirtyBitmap *bitmap;
>> +
>> +    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
>> +    if (!bitmap || !bs) {
>> +        return;
>> +    }
>> +
>> +    if (bdrv_dirty_bitmap_frozen(bitmap)) {
>> +        error_setg(errp,
>> +                   "Bitmap '%s' is currently frozen and cannot be disabled",
>> +                   name);
>> +        return;
>> +    }
>> +
>> +    bdrv_disable_dirty_bitmap(bitmap);
>> +}
>> +
>>   BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
>>                                                                 const char *name,
>>                                                                 Error **errp)
>>
> I have to admit exposing this interface still makes me nervous, but :)
>
> Mechanically correct, and with suggesting phrasing changes:
>
> Reviewed-by: John Snow <jsnow@redhat.com>



-- 
Best regards,
Vladimir
