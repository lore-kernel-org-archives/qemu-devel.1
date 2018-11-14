Received: from eggs.gnu.org ([2001:4830:134:3::10]:36434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMz0Q-0007YE-CV
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMz0P-0002VJ-7p
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:31:10 -0500
References: <20180426134305.642080-1-eblake@redhat.com>
	<20180426134305.642080-4-eblake@redhat.com>
	<w5136zgbve8.fsf@maestria.local.igalia.com>
	<f7d5b3a3-e7d2-bff0-07c4-42f474e8b133@redhat.com>
	<w5160447tel.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3436e225-d1a6-1db5-f060-35d31d55c2b7@redhat.com>
Date: Wed, 14 Nov 2018 11:30:50 -0600
MIME-Version: 1.0
In-Reply-To: <w5160447tel.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] block: Removed unused
 sector-based blocking I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

[Reviving an old series]

On 5/3/18 8:36 AM, Alberto Garcia wrote:
> On Fri 27 Apr 2018 05:43:33 PM CEST, Eric Blake wrote:
>>>> -static int bdrv_rw_co(BdrvChild *child, int64_t sector_num, uint8_t *buf,
>>>> -                      int nb_sectors, bool is_write, BdrvRequestFlags flags)
>>>> -{
>>>> -    QEMUIOVector qiov;
>>>> -    struct iovec iov = {
>>>> -        .iov_base = (void *)buf,
>>>> -        .iov_len = nb_sectors * BDRV_SECTOR_SIZE,
>>>> -    };
>>>> -
>>>> -    if (nb_sectors < 0 || nb_sectors > BDRV_REQUEST_MAX_SECTORS) {
>>>> -        return -EINVAL;
>>>> -    }
>>>
>>> Do we have a check for BDRV_REQUEST_MAX_BYTES in the byte-based API?
>>
>> No, but we don't need one.  First, note that bs->bl.max_transfer is
>> currently uint32_t, so right now, no driver can set it any larger than
>> 4G
> 
> But note that the old limit was based on a signed integer.
> 
> BDRV_REQUEST_MAX_SECTORS is 2147483136 bytes (a bit less than 2GB).
> 
> For 32-bit integers, (INT_MAX - 1) & ~511 = 2147483136

The whole point of the byte-based callbacks is that they pass a 64-bit 
length BUT also honor the driver's max_transfer.  As long as drivers 
default to (or explicitly set) a max_transfer of 
BDRV_REQUEST_MAX_SECTORS or smaller, then the block layer has already 
taken care of fragmenting things so that the callers no longer have to 
worry about artificially fragmenting things themselves before handing 
something to the block layer that might overflow.  And you snipped the 
rest of my mail, where I argued:

> 
> But, having said that, you've made me wonder if it's time to increase
> max_transfer to [u]int64_t, then audit ALL drivers to ensure that they
> either properly handle requests >=4G or else set max_transfer <4G
> (ideally, the block layer will default max_transfer to the value of
> BDRV_REQUEST_MAX_BYTES, even if the audit means we no longer need that
> macro).  Should be a separate series, though.

I will concede that you are right that because we previously used a 
signed type, I should amend my argument to state that we should audit 
ALL drivers to ensure that they either properly handle requests >= 2G 
or else set max_transfer <2G, even though max_transfer is unsigned. 
Maybe it's time that I attempt that audit, before posting a v2 of this 
series for 4.0. (Fingers crossed that it will be a quick audit)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
