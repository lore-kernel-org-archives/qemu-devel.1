Received: from eggs.gnu.org ([2001:4830:134:3::10]:55936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cei4t-0005iN-Fv
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cei4r-0004jg-VY
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:55:59 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:36126 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cei4r-0004j5-Fk
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:55:57 -0500
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-10-git-send-email-vsementsov@virtuozzo.com>
	<20170216114533.GC4869@noname.redhat.com>
	<20170216124753.GE4869@noname.redhat.com>
	<f257ad53-748b-64b6-1b70-ddbbfb79c965@virtuozzo.com>
	<20170217122154.GD5338@noname.redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4109eae4-2871-00c5-4e1e-ffbaeff659c4@virtuozzo.com>
Date: Fri, 17 Feb 2017 15:55:43 +0300
MIME-Version: 1.0
In-Reply-To: <20170217122154.GD5338@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v15 09/25] qcow2: add
 .bdrv_load_autoloading_dirty_bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: famz@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com

17.02.2017 15:21, Kevin Wolf wrote:
> Am 17.02.2017 um 13:07 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 16.02.2017 15:47, Kevin Wolf wrote:
>>> Sorry, this was sent too early. Next attempt...
>>>
>>> Am 16.02.2017 um 12:45 hat Kevin Wolf geschrieben:
>>>> Am 15.02.2017 um 11:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>>> Auto loading bitmaps are bitmaps in Qcow2, with the AUTO flag set. They
>>>>> are loaded when the image is opened and become BdrvDirtyBitmaps for the
>>>>> corresponding drive.
>>>>>
>>>>> Extra data in bitmaps is not supported for now.
>> [...]
>>
>>>>> hdx.o vhdx-endian.o vhdx-log.o
>>>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>>>> new file mode 100644
>>>>> index 0000000..e08e46e
>>>>> --- /dev/null
>>>>> +++ b/block/qcow2-bitmap.c
>> [...]
>>
>>>>> +
>>>>> +static int update_header_sync(BlockDriverState *bs)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = qcow2_update_header(bs);
>>>>> +    if (ret < 0) {
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    /* We don't return bdrv_flush error code. Even if it fails, write was
>>>>> +     * successful and it is more logical to consider that header is in the new
>>>>> +     * state than in the old.
>>>>> +     */
>>>>> +    ret = bdrv_flush(bs);
>>>>> +    if (ret < 0) {
>>>>> +        fprintf(stderr, "Failed to flush qcow2 header");
>>>>> +    }
>>> I don't think I can agree with this one. If you don't care whether the
>>> new header is actually on disk, don't call bdrv_flush(). But if you do
>>> care, then bdrv_flush() failure means that most likely the new header
>>> has not made it to the disk, but is just sitting in some volatile cache.
>> And what should be done on bdrv_flush fail? Current solution was
>> proposed by Max.
> Pass an error up and let the calling operation fail, because we can't
> promise that it actually executed correctly.

It was my first option. The problem is that resulting state is 
absolutely inconsistent - it is not guaranteed  to be the old one or 
new.. However with current approach it may be inconsistent too, but 
without an error..

So, error message should contain information that all dirty bitmaps may 
be inconsistent even if in the image all flags says that bitmaps are OK.


>
>>>>> +    return 0;
>>>>> +}
>>>>> +
>> [...]
>>
>>>>> +
>>>>> +/* This function returns the number of disk sectors covered by a single cluster
>>>>> + * of bitmap data. */
>>>>> +static uint64_t disk_sectors_in_bitmap_cluster(const BDRVQcow2State *s,
>>>>> +                                               const BdrvDirtyBitmap *bitmap)
>>>>> +{
>>>>> +    uint32_t sector_granularity =
>>>>> +            bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
>>>>> +
>>>>> +    return (uint64_t)sector_granularity * (s->cluster_size << 3);
>>>>> +}
>>> This has nothing to do with disk sectors, neither of the guest disk nor
>>> of the host disk. It's just using a funny 512 bytes unit. Is there a
>>> good reason for introducing this funny unit in new code?
>>>
>>> I'm also not sure what this function calculates, but it's not what the
>>> comment says. The unit of the result is something like sectors * bytes,
>>> and even when normalising it to a single base unit, I've never seen a
>>> use for square bytes so far.
>> sector granularity is number of disk sectors, corresponding to one
>> bit of the dirty bitmap, (disk-sectors/bitmap-bit)
> Please don't use the word "disk sectors", it's misleading because it's
> not a sector size of any specific disk. It's best to say just "sectors",
> which is a fixed qemu block layer unit of 512 bytes.
>
>> cluster_size << 3 is a number of bits in one cluster, (bitmap-bit)
>>
>> so, we have
>> sector_granularity (disk-sector/bitmap-bit) * <cluster size in bits>
>> (bitmapbit)  = some disk sectors, corresponding to one cluster of
>> bitmap data.
> Aha! I completely misunderstood what a bitmap cluster is supposed to
> be. I expected it to be a chunk of bitmap data whose size corresponds to
> the bitmap granularity, whereas it's really about qcow2 clusters.
>
> I wonder if we can rephrase the comment to make this more obvious. Maybe
> "...covered by a single qcow2 cluster containing bitmap data"? And the
> function could be called sectors_covered_by_bitmap_cluster() or
> something.

No problem with that, I'm always for better wording)

s/containing/of/ looks better for me, as it shouldbe covered by bitmap 
data, not by cluster.

>
> Kevin


-- 
Best regards,
Vladimir
