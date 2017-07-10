Received: from eggs.gnu.org ([2001:4830:134:3::10]:43754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dUg6o-0000F9-GZ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dUg6n-0000wB-Id
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:20:46 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-6-eblake@redhat.com>
	<6871f1c0-ad00-84b1-3045-657a998748c3@redhat.com>
	<dfae7b01-7a6a-d081-57b2-a02f4932a4e7@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <9856187b-014c-681e-bc68-e371509c1084@redhat.com>
Date: Mon, 10 Jul 2017 17:20:37 -0400
MIME-Version: 1.0
In-Reply-To: <dfae7b01-7a6a-d081-57b2-a02f4932a4e7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 05/17] dirty-bitmap: Change
 bdrv_dirty_bitmap_size() to report bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/10/2017 05:19 PM, Eric Blake wrote:
> On 07/10/2017 04:09 PM, John Snow wrote:
>>
>>
>> On 07/03/2017 11:10 AM, Eric Blake wrote:
>>> We are still using an internal hbitmap that tracks a size in sectors,
>>> with the granularity scaled down accordingly, because it lets us
>>> use a shortcut for our iterators which are currently sector-based.
>>> But there's no reason we can't track the dirty bitmap size in bytes,
>>> since it is (mostly) an internal-only variable (remember, the size
>>> is how many bytes are covered by the bitmap, not how many bytes the
>>> bitmap occupies).  Furthermore, we're already reporting bytes for
>>> bdrv_dirty_bitmap_granularity(); mixing bytes and sectors in our
>>> return values is a recipe for confusion.
>>>
>>> The only external caller in qcow2-bitmap.c is temporarily more verbose
>>> (because it is still using sector-based math), but will later be
>>> switched to track progress by bytes instead of sectors.
>>>
>>> Use is_power_of_2() while at it, instead of open-coding that.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>
> 
>>> @@ -305,8 +307,10 @@ BdrvDirtyBitmap
>>> *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
>>>    void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
>>>    {
>>>        BdrvDirtyBitmap *bitmap;
>>> -    uint64_t size = bdrv_nb_sectors(bs);
>>> +    int64_t size = bdrv_getlength(bs);
>>>
>>> +    assert(size >= 0);
>>> +    size = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
>>
>> Do we need a TODO here as well, or are we going to track these in terms
>> of "sectors" permanently?
> 
> The rounding goes away in patch 17/17 when I flip the internals to
> byte-based.  If a TODO comment here (that goes away in patch 17) makes
> review easier, I can add that.
> 

Email confirmation is enough for me, personally.

--js
