Received: from eggs.gnu.org ([2001:4830:134:3::10]:55425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dR0CE-0000bg-Hr
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 13:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dR0CD-0005Q5-Fp
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 13:59:10 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-20-vsementsov@virtuozzo.com>
	<f92fea0e-fe66-6888-dcd2-10782aec4fd2@redhat.com>
	<b084acc4-a9d6-ecf5-e8f1-beb7c3a80072@redhat.com>
	<bddd14a1-5d18-58b2-8e4b-8579ad0e7f49@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <fc19b4a1-081e-008d-5573-59e29419786f@redhat.com>
Date: Fri, 30 Jun 2017 13:58:55 -0400
MIME-Version: 1.0
In-Reply-To: <bddd14a1-5d18-58b2-8e4b-8579ad0e7f49@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v22 19/30] qcow2: add persistent dirty
 bitmaps support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com



On 06/30/2017 01:47 PM, Eric Blake wrote:
> On 06/29/2017 09:23 PM, Max Reitz wrote:
>> On 2017-06-30 04:18, Eric Blake wrote:
>>> On 06/28/2017 07:05 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Store persistent dirty bitmaps in qcow2 image.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>>> ---
> 
>>>
>>> This grabs the size (currently in sectors, although I plan to fix it to
>>> be in bytes)...
>>>
>>>> +    const char *bm_name = bdrv_dirty_bitmap_name(bitmap);
>>>> +    uint8_t *buf = NULL;
>>>> +    BdrvDirtyBitmapIter *dbi;
>>>> +    uint64_t *tb;
>>>> +    uint64_t tb_size =
>>>> +            size_to_clusters(s,
>>>> +                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size));
>>>
>>> ...then finds out how many bytes are required to serialize the entire
>>> image, where bm_size should be the same as before...
>>>
>>>> +    while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
>>>> +        uint64_t cluster = sector / sbc;
>>>> +        uint64_t end, write_size;
>>>> +        int64_t off;
>>>> +
>>>> +        sector = cluster * sbc;
>>>> +        end = MIN(bm_size, sector + sbc);
>>>> +        write_size =
>>>> +            bdrv_dirty_bitmap_serialization_size(bitmap, sector, end - sector);
>>>
>>> But here, rather than tackling the entire image at once, you are
>>> subdividing your queries along arbitrary lines. But nowhere do I see a
>>> call to bdrv_dirty_bitmap_serialization_align() to make sure your
>>> end-sector value is properly aligned; if it is not aligned, you will
>>> trigger an assertion failure here...
>>
>> It's 4:21 am here, so I cannot claim to be right, but if I remember
>> correctly, it will automatically aligned because sbc is the number of
>> bits (and thus sectors) a bitmap cluster covers.
> 
> Okay, I re-read the spec.  First thing I noticed: we have a potential
> conflict if an image is allowed to be resized:
> 
> "All stored bitmaps are related to the virtual disk stored in the same
> image, so each bitmap size is equal to the virtual disk size."
> 
> If you resize an image, does the bitmap size have to be adjusted as
> well?  What if you create one bitmap, then take an internal snapshot,
> then resize?  Or do we declare that (at least for now) the presence of a
> bitmap is incompatible with the use of an internal snapshot?
> 
> Conversely, we state that:
> 
> 
> "Structure of a bitmap directory entry:
> ...
>          8 - 11:    bitmap_table_size
>                     Number of entries in the bitmap table of the bitmap."
> 

This is the number of bitmaps stored in the qcow2, not the size of one
particular bitmap.

> Since a bitmap therefore tracks its own size, I think the earlier
> statement that all bitmap sizes are equal to the virtual disk size is
> too strict (there seems to be no technical reason why a bitmap can't
> have a different size that the image).
> 
> 
> But, having read that, you are correct that we are subdividing our
> bitmaps according to what fits in a qcow2 cluster, and the smallest
> qcow2 cluster we can come up with is 512-bytes (or 4k bits of the
> bitmap).  Checking hbitmap.c, we are merely asserting that our alignment
> is always a multiple of 64 << hb->granularity.  But since we are
> partitioning a cluster at a time, our minimum alignment will be 512 <<
> hb->granularity, which is always aligned.
> 
> So all the more I need to do is add an assertion.
> 
>> I'm for fixing it later. I would have announced the series "applied" an
>> hour ago if I hadn't had to bisect iotest 055 breakage...
> 
> I'm working it into my v4 posting of dirty-bitmap cleanups.
> 
