Received: from eggs.gnu.org ([2001:4830:134:3::10]:39935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNKbQ-0001wc-1S
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNKbK-0001e6-0F
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:34:48 -0500
References: <20181115020334.1189829-1-eblake@redhat.com>
	<20181115020334.1189829-14-eblake@redhat.com>
	<20181115162428.GF12677@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fd219514-bb0c-f4e7-1b57-178533d97a0f@redhat.com>
Date: Thu, 15 Nov 2018 10:34:26 -0600
MIME-Version: 1.0
In-Reply-To: <20181115162428.GF12677@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/13] block: Enforce non-zero
 bl.max_transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

On 11/15/18 10:24 AM, Kevin Wolf wrote:
> Am 15.11.2018 um 03:03 hat Eric Blake geschrieben:
>> The raw format driver and the filter drivers default to picking
>> up the same limits as what they wrap, and I've audited that they
>> are otherwise simple enough in their passthrough to be 64-bit
>> clean; it's not worth changing their .bdrv_refresh_limits to
>> advertise anything different.  Previous patches changed all
>> remaining byte-based format and protocol drivers to supply an
>> explicit max_transfer consistent with an audit (or lack thereof)
>> of their code.  And for drivers still using sector-based
>> callbacks (gluster, iscsi, parallels, qed, replication, sheepdog,
>> ssh, vhdx), we can easily supply a 2G default limit while waiting
>> for a later per-driver conversion and auditing while moving to
>> byte-based callbacks.
>>
>> With that, we can assert that max_transfer is now always set (either
>> by sector-based default, by merge with a backing layer, or by
>> explicit settings), and enforce that it be non-zero by the end
>> of bdrv_refresh_limits().  This in turn lets us simplify portions
>> of the block layer to use MIN() instead of MIN_NON_ZERO(), while
>> still fragmenting things to no larger than 2G chunks.  Also, we no
>> longer need to rewrite the driver's bl.max_transfer to a value below
>> 2G.  There should be no semantic change from this patch, although
>> it does open the door if a future patch wants to let the block layer
>> choose a larger value than 2G while still honoring bl.max_transfer
>> for fragmentation.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> [hmm - in sending this email, I realize that I didn't specifically
>> check whether quorum always picks up a sane limit from its children,
>> since it is byte-based but lacks a .bdrv_refresh_limits]
>>
>>   include/block/block_int.h | 10 +++++-----
>>   block/io.c                | 25 ++++++++++++-------------
>>   2 files changed, 17 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index b19d94dac5f..410553bb0cc 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -548,11 +548,11 @@ typedef struct BlockLimits {
>>       uint32_t opt_transfer;
>>
>>       /* Maximal transfer length in bytes.  Need not be power of 2, but
>> -     * must be multiple of opt_transfer and bl.request_alignment, or 0
>> -     * for no 32-bit limit.  The block layer fragments all actions
>> -     * below 2G, so setting this value to anything larger than INT_MAX
>> -     * implies that the driver has been audited for 64-bit
>> -     * cleanness. */
>> +     * must be larger than opt_transfer and request_alignment (the
>> +     * block layer rounds it down as needed).  The block layer
>> +     * fragments all actions below 2G, so setting this value to
>> +     * anything larger than INT_MAX implies that the driver has been
>> +     * audited for 64-bit cleanness. */
>>       uint64_t max_transfer;
>>
>>       /* memory alignment, in bytes so that no bounce buffer is needed */
>> diff --git a/block/io.c b/block/io.c
>> index 4911a1123eb..0024be0bf31 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -129,6 +129,9 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
>>       /* Default alignment based on whether driver has byte interface */
>>       bs->bl.request_alignment = (drv->bdrv_co_preadv ||
>>                                   drv->bdrv_aio_preadv) ? 1 : 512;
>> +    /* Default cap at 2G for drivers without byte interface */
>> +    if (bs->bl.request_alignment == 1)
>> +        bs->bl.max_transfer = BDRV_REQUEST_MAX_BYTES;
> 
> Missing braces, and comment and code don't match (the comment suggests
> that the condition should be != 1).

Indeed. I shouldn't send patches late at night ;)  In fact, it proves I 
didn't run iotests on any of the protocol drivers that would be impacted 
by this code (gluster, iscsi, sheepdog, ssh), and thus, would probably 
fail the added assertion when they leave bl.max_transfer at 0 because I 
didn't initialize a default for them.  The format drivers (parallels, 
qed, replication, vhdx) would probably still work because we merge in 
the max_transfer of bs->file before the assert that bl.max_transfer is 
non-zero.

Lesson learned - don't submit v3 of this patch until I've at least done 
better due diligence at running iotests on some of the impacted drivers.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
