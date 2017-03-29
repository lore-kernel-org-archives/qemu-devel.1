Received: from eggs.gnu.org ([2001:4830:134:3::10]:34062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ctFv1-0007h4-Tz
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 11:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ctFuy-0002jx-P4
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 11:53:55 -0400
Received: from mail-db5eur01on0134.outbound.protection.outlook.com
	([104.47.2.134]:29616
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1ctFux-0002jc-Vg
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 11:53:52 -0400
References: <1490625488-7980-1-git-send-email-den@openvz.org>
	<20170328162620.GD11725@noname.redhat.com>
	<94ecee49-3d48-946f-aedb-c4ecba3f29e2@openvz.org>
	<20170329104149.GB16138@noname.redhat.com>
	<7a477fb8-1380-294a-1a20-bd6516eef852@openvz.org>
	<20170329141127.GC16138@noname.redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <721a7870-e6e2-c70d-869c-ffb010b32322@openvz.org>
Date: Wed, 29 Mar 2017 17:18:58 +0300
MIME-Version: 1.0
In-Reply-To: <20170329141127.GC16138@noname.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] parallels: wrong call to bdrv_truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On 03/29/2017 05:11 PM, Kevin Wolf wrote:
> Am 29.03.2017 um 15:53 hat Denis V. Lunev geschrieben:
>> On 03/29/2017 01:41 PM, Kevin Wolf wrote:
>>> Am 28.03.2017 um 19:12 hat Denis V. Lunev geschrieben:
>>>> On 03/28/2017 07:26 PM, Kevin Wolf wrote:
>>>>> [ Cc: qemu-block ]
>>>>>
>>>>> Am 27.03.2017 um 16:38 hat Denis V. Lunev geschrieben:
>>>>>> Parallels driver should not call bdrv_truncate if the image was opened
>>>>>> in the read-only mode. Without the patch
>>>>>>     qemu-img check harddisk.hds
>>>>>> asserts with
>>>>>>     bdrv_truncate: Assertion `child->perm & BLK_PERM_RESIZE' failed.
>>>>>>
>>>>>> Parameters used on the write path are not needed if the image is opened
>>>>>> in the read-only mode.
>>>>>>
>>>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>>>> Reported-by: Edgar Kaziahmedov <edos@virtuozzo.mipt.ru>
>>>>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>> ---
>>>>>>  block/parallels.c | 3 ++-
>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/block/parallels.c b/block/parallels.c
>>>>>> index 6bf9375..4173b3f 100644
>>>>>> --- a/block/parallels.c
>>>>>> +++ b/block/parallels.c
>>>>>> @@ -687,7 +687,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>>>>>>      if (local_err != NULL) {
>>>>>>          goto fail_options;
>>>>>>      }
>>>>>> -    if (!bdrv_has_zero_init(bs->file->bs) ||
>>>>>> +
>>>>>> +    if (!(flags & BDRV_O_RESIZE) || !bdrv_has_zero_init(bs->file->bs) ||
>>>>>>              bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs)) != 0) {
>>>>>>          s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
>>>>>>      }
>>>>> Relying on BDRV_O_RESIZE in block drivers is wrong. It is set in some
>>>>> paths (specifically the users of blk_new_open), but not in others. We
>>>>> should probably have filtered out the flag before passing it to the
>>>>> drivers.
>>>>>
>>>>> As a concrete example, if you're using -blockdev, the bdrv_truncate()
>>>>> call won't be executed after applying this patch.
>>>>>
>>>>> I think the correct way would be to check bdrv_is_read_only() instead.
>>>>>
>>>>> Kevin
>>>> hmmm. But why do we have
>>>>
>>>> int bdrv_truncate(BdrvChild *child, int64_t offset)
>>>> {
>>>>     BlockDriverState *bs = child->bs;
>>>>     BlockDriver *drv = bs->drv;
>>>>     int ret;
>>>>
>>>>     assert(child->perm & BLK_PERM_RESIZE);
>>>>
>>>>     if (!drv)
>>>>         return -ENOMEDIUM;
>>>>     if (!drv->bdrv_truncate)
>>>>         return -ENOTSUP;
>>>>     if (bs->read_only)
>>>>         return -EACCES;
>>>>
>>>>     ret = drv->bdrv_truncate(bs, offset);
>>>>
>>>> instead of
>>>>
>>>> int bdrv_truncate(BdrvChild *child, int64_t offset)
>>>> {
>>>>     BlockDriverState *bs = child->bs;
>>>>     BlockDriver *drv = bs->drv;
>>>>     int ret;
>>>>
>>>>     if (!drv)
>>>>         return -ENOMEDIUM;
>>>>     if (!drv->bdrv_truncate)
>>>>         return -ENOTSUP;
>>>>     if (bs->read_only)
>>>>         return -EACCES;
>>>>
>>>>     assert(child->perm & BLK_PERM_RESIZE);
>>>>     ret = drv->bdrv_truncate(bs, offset);
>>>>
>>>> technically this will work properly for my case and calling of
>>>> bdrv_truncate could be valid.
>>> The question is what the contract of bdrv_truncate() is. I think "you
>>> can only call this when you got resize permissions" is the clearest
>>> interface, and the current code enforces it.
>> but in the original patch I have made check exactly over this simple
>> condition and you says that it was not accurate. If this is wrong, I'll be
>> rejected later on with EACCESS and will still be on the safe side.
>> Original patch just avoids the assert().
> No, you checked BDRV_O_RESIZE in bs->open_flags, not BLK_PERM_RESIZE in
> child->perm. If you checked for BLK_PERM_RESIZE, that would work (though
> I still think that checking for read-only gets closer to the actual
> intent).
OK. That is clear now, I'll send a fixup.
Thank you for the explanation.


>
>>> Your proposal would change it into "you can only call this when you get
>>> resize permissions, except when it would fail anyway because the image
>>> is closed, the driver doesn't support resizing or the node is
>>> read-only". I wouldn't make such exceptions unless there is a good
>>> reason to have them, e.g. if it made the life of the callers
>>> substantially easier. But it don't think it does in this case.
>> Actually we have had an error condition as the image was really read-only
>> and all was safe. Right now we have an assert even if the image is
>> read-only.
>> This looks the same to me as to raise an assert in write for read-only
>> image. Is there any difference?
> Hm, no, not really. You're right that we're inconsistent there. Not sure
> which one we should change, but you do have a point there.
>
>>>> Another thing, should we add assert like added into bdrv_co_pwritev,
>>>> namely
>>>>     assert(!(bs->open_flags & BDRV_O_INACTIVE));
>>>> in the same place below access check.
>>> You mean asserting that we have write permission? We already do that in
>>> bdrv_aligned_pwritev(), which is called by bdrv_co_pwritev().
>> I mean that we should disallow image change if it is disallowed
>> by the contract. Current contract says that we can not change
>> image content once BDRV_O_INACTIVE is set. Should we
>> Do we have implicit rule that (child->perm & BLK_PERM_RESIZE)
>> is set only when INACTIVE is not set?
> Ah, you want to assert cleared BDRV_O_INACTIVE in bdrv_truncate()?
> That sounds like a good idea to me.
but this is for 2.10. I think it is too late to do that right now.

>>>> Technically, the requested change is not a problem it looks a bit
>>>> strange and not consistent to me.
>>> Hm, okay? Why do you think so? To me, it feels correct that
>>> bdrv_truncate() can only be called for writable images.
>> I was unclear here. I have trying to say that "the change requested by you
>> is not a problem, I'll do that once we will agree". Sorry :(
>>
>>> It's the current code in the parallels driver that calls it for
>>> read-only images and implicitly expects an error return on the normal
>>> code path (without even having a comment about this) that feels somewhat
>>> unclean to me.
>> Actually I tend to drop this truncate at all. It was set for a state of
>> insurance and should not be actually used.
> Well, that's the best solution then for this specific case. :-)
>
> Kevin
;)
