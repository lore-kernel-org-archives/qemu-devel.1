Received: from eggs.gnu.org ([2001:4830:134:3::10]:59260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dGYh5-00052u-VR
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dGYh4-00034h-Rf
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:35:52 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-10-vsementsov@virtuozzo.com>
	<33ce370d-939f-d02e-0177-1184ae9f4fa7@redhat.com>
	<47488066-bd0f-834d-85d8-63d7289cb0fd@virtuozzo.com>
	<18c4b1ad-bc30-a598-36b8-612c01b00dee@redhat.com>
	<67feecd0-ef75-5e26-aa7c-a70b69fde0ef@virtuozzo.com>
	<15564da8-3aa5-667a-addf-6d3617e64f67@redhat.com>
	<ed412d3c-b675-4e6f-41d8-acca126f4b23@virtuozzo.com>
	<2d9578e6-d61b-551f-8650-3fafee1bfe05@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8dd0157d-e07e-85ea-5772-0afb746342c7@redhat.com>
Date: Thu, 1 Jun 2017 18:35:38 -0400
MIME-Version: 1.0
In-Reply-To: <2d9578e6-d61b-551f-8650-3fafee1bfe05@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/25] block/dirty-bitmap: add readonly
 field to BdrvDirtyBitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 05/31/2017 11:53 AM, Max Reitz wrote:
> On 2017-05-31 17:05, Vladimir Sementsov-Ogievskiy wrote:
>> 31.05.2017 17:44, Max Reitz wrote:
>>> On 2017-05-31 16:29, Vladimir Sementsov-Ogievskiy wrote:
>>>> 31.05.2017 16:43, Max Reitz wrote:
>>>>> On 2017-05-30 08:50, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Thank you for this scenario. Hmm.
>>>>>>
>>>>>> So, as I need guarantee that image and bitmap are unchanged,
>>>>>> bdrv_set_dirty should return error and fail the whole write. Ok?
>>>>> I don't know. That would mean that you couldn't commit to an image that
>>>>> has a persistent auto-loading bitmap, which doesn't seem very nice
>>>>> to me.
>>>>>
>>>>> I'm not quite sure what to do myself. So first I'd definitely want the
>>>>> commit operation to succeed. That means we'd have to automatically make
>>>>> the bitmap non-readonly once we write to it. The "readonly" flag would
>>>>> then be an "unchanged" flag, rather, to signify that the bitmap has not
>>>>> been changed since it was loaded, which means that it does not need to
>>>>> be written back to the image file.
>>>>>
>>>>> Now the issue remains that if you modify a persistent bitmap that is
>>>>> stored in an image file that is opened RO when it's closed, you
>>>>> won't be
>>>>> able to write the modifications back.
>>>>>
>>>>> So in addition, I guess we'd need to "flush" all persistent bitmaps
>>>>> (that is, write all modifications back to the file and set the
>>>>> "unchanged" flag (you could also call it "dirty" and then mean the
>>>>> opposite) for each bitmap) not only when the image is closed or
>>>>> invalidated, but also when it is reopened read-only.
>>>>>
>>>>> (block-commit reopens the backing BDS R/W, then writes to them, thus
>>>>> modifying the dirty bitmaps, and finally reopens the BDS as read-only;
>>>>> before that happens, we will have to flush the modified bitmap data.)
>>>> Ok, understand.
>>>>
>>>> We need to consider also setting in_use flag in the image. We _must not_
>>>> write to image with dirty bitmap,
>>>> if in_use flag of this dirty bitmap is not set, as in case of something
>>>> fail we will have image with wrong bitmap with
>>>> unset in_use flag (which looks ok).
>>> Right.
>>>
>>>> I see two ways to handle it:
>>>>
>>>> variant 1:
>>>> 1. readonly field stays as is (see v19, with normal errors, not only
>>>> asserts)
>>>> 2. immediately after reopening r/w we do "reopening bitmaps r/w", i.e.
>>>> set in_use in the image and set BdrvDirtyBitmap.readonly = false
>>>> 3. in reopen_prepare, if reopening r-o do "reopening bitmaps r-o", i.e.
>>>> save them into the image and set BdrvDirtyBitmap.readonly = true
>>> Sounds good, yes.
>>>
>>>> variant 2:
>>>> 1. instead of 'readonly' add 'dirty' field, set dirty to 0 for all
>>>> bitmaps on create
>>>> 2. before write/discard check this field in all related bitmaps, and if
>>>> dirty=0 (and persistent=1), write IN_USE flag into the image first, set
>>>> dirty=1, and only then do write. (if writing IN_USE=1 failed, fail the
>>>> whole write)
>>>> 3. in reopen_prepare, if reopening r-o do "reopening bitmaps r-o", i.e.
>>>> save them into the image and set BdrvDirtyBitmap.dirty = 0
>>> Works, too.
>>>
>>> I think the second variant would the more "efficient" way (because you
>>> only have to flush out dirty dirty bitmaps), but the first one would be
>>> simpler and has the great advantage of not requiring a write to the
>>> image file when you just want to set a bit in the in-memory dirty
>>> bitmap. So I'd personally go for the first variant.
>>
>> Hmm, why not requiring? Both 1 and 2 do write in_use=1, but (1) do this
>> on open/reopen, and (2) before the first write to the image.
> 
> Oh, I didn't read the "before write/discard". Yes, if you check it
> before writing, then you won't have to set the flag through
> bdrv_set_dirty().
> 
>> "set a bit in the in-memory..." - are you saying about not-persistent
>> dirty bitmaps? In this case, of course, nothing should be written into
>> the image, just set dirty=1.
> 
> No, I did mean persistent bitmaps, but bdrv_set_dirty() just sets the
> bit in main memory, of course. It only gets written to the image later
> (on reopen/close/invalidate).
> 

There may be some benefit to setting in_use immediately as soon as we
admit that we are willing to tolerate writes to the bitmap. It's a
performance hit, but it may help on-disk consistency.

Or maybe that's a fool's errand? This is a design question we've largely
ignored so far, but it's something that will need investigating sooner
or later.

> Well, your choice. I think both will work. :-)
> 
> Max
> 
