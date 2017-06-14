Received: from eggs.gnu.org ([2001:4830:134:3::10]:37605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dL4D0-0002sl-1U
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 05:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dL4Cz-0006Ti-8z
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 05:03:26 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:36751 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dL4Cy-0006Sn-Ud
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 05:03:25 -0400
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
	<20170602112158.232757-14-vsementsov@virtuozzo.com>
	<3c884dff-5736-5e27-c68a-f1df374e26b0@redhat.com>
	<80a6c118-bdef-7519-6405-e80970ddda96@virtuozzo.com>
	<e4af8c75-b217-3017-708a-8760a2689c00@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <566c473c-3669-ebde-e50a-0f85afac5f51@virtuozzo.com>
Date: Wed, 14 Jun 2017 12:03:05 +0300
MIME-Version: 1.0
In-Reply-To: <e4af8c75-b217-3017-708a-8760a2689c00@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v20 13/30] block: new
 bdrv_reopen_bitmaps_rw interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

13.06.2017 18:28, Max Reitz wrote:
> On 2017-06-13 12:25, Vladimir Sementsov-Ogievskiy wrote:
>> 09.06.2017 16:27, Max Reitz wrote:
>>> On 2017-06-02 13:21, Vladimir Sementsov-Ogievskiy wrote:
>>>> Add format driver handler, which should mark loaded read-only
>>>> bitmaps as 'IN_USE' in the image and unset read_only field in
>>>> corresponding BdrvDirtyBitmap's.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    block.c                   | 17 +++++++++++++++++
>>>>    include/block/block_int.h |  7 +++++++
>>>>    2 files changed, 24 insertions(+)
>>>>
>>>> diff --git a/block.c b/block.c
>>>> index 04af7697dc..161db9e32a 100644
>>>> --- a/block.c
>>>> +++ b/block.c
>>>> @@ -2946,12 +2946,16 @@ void bdrv_reopen_commit(BDRVReopenState
>>>> *reopen_state)
>>>>    {
>>>>        BlockDriver *drv;
>>>>        BlockDriverState *bs;
>>>> +    bool old_can_write, new_can_write;
>>>>          assert(reopen_state != NULL);
>>>>        bs = reopen_state->bs;
>>>>        drv = bs->drv;
>>>>        assert(drv != NULL);
>>>>    +    old_can_write =
>>>> +        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) &
>>>> BDRV_O_INACTIVE);
>>>> +
>>>>        /* If there are any driver level actions to take */
>>>>        if (drv->bdrv_reopen_commit) {
>>>>            drv->bdrv_reopen_commit(reopen_state);
>>>> @@ -2965,6 +2969,19 @@ void bdrv_reopen_commit(BDRVReopenState
>>>> *reopen_state)
>>>>        bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
>>>>          bdrv_refresh_limits(bs, NULL);
>>>> +
>>>> +    new_can_write =
>>>> +        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) &
>>>> BDRV_O_INACTIVE);
>>>> +    if (!old_can_write && new_can_write &&
>>>> drv->bdrv_reopen_bitmaps_rw) {
>>>> +        Error *local_err = NULL;
>>>> +        if (drv->bdrv_reopen_bitmaps_rw(bs, &local_err) < 0) {
>>>> +            /* This is not fatal, bitmaps just left read-only, so
>>>> all following
>>>> +             * writes will fail. User can remove read-only bitmaps
>>>> to unblock
>>>> +             * writes.
>>>> +             */
>>> In a sense, it pretty much is fatal. We were asked to make the image
>>> non-read-only but we failed because it effectively still is read-only.
>>>
>>> But I can't think of anything better, and you're right, removing the
>>> bitmaps would resolve the situation. This would require the user to know
>>> that updating the bitmaps was the issue, and local_err may not actually
>>> reflect that.
>>>
>>>> +            error_report_err(local_err);
>>> So I'd prepend this with something like "$node_name: Failed to make
>>> dirty bitmaps writable", and maybe append a hint like "Removing all
>>> persistent dirty bitmaps from this node will allow writing to it".
>> Ok for prepending, but I don't want to add last note, as for the user it
>> may better to retry an operation, leading reopening image rw..
> Which operation do you mean? The reopening? Because that operation
> already "succeeded" at this point, so you can't retry it...

So, firstly, reopen r-o again and then reopen r-w? Is it possible?

>
> Max
>

-- 
Best regards,
Vladimir
