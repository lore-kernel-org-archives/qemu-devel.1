Received: from eggs.gnu.org ([2001:4830:134:3::10]:45556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fYvRe-0001Kz-OR
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fYvRd-0003UK-67
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:36:22 -0400
References: <1529415820-7750-1-git-send-email-ari@tuxera.com>
	<1529415820-7750-3-git-send-email-ari@tuxera.com>
	<20180629100752.GE15588@localhost.localdomain>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <7d9b8648-a919-307e-b4e9-cd47148d4de0@tuxera.com>
Date: Fri, 29 Jun 2018 18:36:07 +0300
MIME-Version: 1.0
In-Reply-To: <20180629100752.GE15588@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/8] block: Add a mechanism for passing
 a block driver a block configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, "open list:Block I/O path" <qemu-block@nongnu.org>

On 06/29/2018 01:07 PM, Kevin Wolf wrote:
> Am 19.06.2018 um 15:43 hat Ari Sundholm geschrieben:
>> A block driver may need to know about the block configuration, most
>> critically the sector sizes, of a block backend for alignment purposes
>> or for some other reason.
> 
> It makes sense to me that you need to know alignment constraints of the
> thing you are calling (i.e. your child nodes), but I don't really see
> why you would need to know anything about the parent nodes. I'm doubtful
> that this is a good thing to add.
> 

I guess I should explain the exact use case here to show where we are 
coming from.

The use case is the new blklogwrites driver (introduced in this patch 
set), which we use to test file system implementations. It needs to log 
the writes to whatever guest block device is used (for instance, a 
-device scsi-hd). These block devices may have different kinds of 
logical sector sizes, as determined by their configuration (such as 
physical_block_size=4096,logical_block_size=512). In order to properly 
log the writes that hit such a block device, we need to do this at a 
granularity of its logical sector size for the log to be most useful. 
For this, we need to get this information from the direction of the parent.

This patch set proposes a mechanism for exposing that information to 
blklogwrites (and all other block drivers that may use this 
information), along with other information in the block configuration, 
to allow it to automatically adjust to it.

> I hope that the rest of the series will tell me why you are wanting this
> information, but if we keep it, it needs a better explanation in the
> commit message.
> 
>> It doesn't seem like qemu has an existing
>> mechanism for a block backend to convey the required information to
>> the relevant block driver when it is being realized.
>>
>> The need for this mechanism rises from the fact that a drive may not
>> have a backend at the time it is created, as devices are created after
>> drives during qemu startup. Therefore, a driver requiring information
>> about the block configuration can get this information when a backend
>> is created for it at the earliest. The most natural place for this to
>> take place seems to be in the realization functions of the various
>> block device drivers, such as scsi-hd. The interface proposed here
>> allows the block driver to receive information about the block
>> configuration and the associated backend through a new callback.
>>
>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> 
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 327e478..74c470e 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -465,6 +465,15 @@ struct BlockDriver {
>>       void (*bdrv_abort_perm_update)(BlockDriverState *bs);
>>   
>>       /**
>> +     * Called to inform the driver of the block configuration of the virtual
>> +     * block device.
>> +     *
>> +     * This function is called by a block device realization function if the
>> +     * device wants to inform the block driver of its block configuration.
>> +     */
>> +    void (*bdrv_apply_blkconf)(BlockDriverState *bs, BlockConf *conf);
> 
> This interface can't really work. Block nodes (BlockDriverStates) can
> have an arbitrary number of parents, which can be attached and detached
> dynamically. This interface basically assumes that there is one device
> attached to the node, it will always stay attached and its configuration
> stays the same.
> 
> Is this function supposed to be called only once? (That assumption
> wouldn't hold true.) If not, does a second call mean that a second
> parent was attached, or does it update the information of the existing
> parent?
> 
> How is this information useful when one parent calls the function and
> provides BlockConf, but the other doesn't and the block driver doesn't
> know about this?
> 

Yes, the interface needs work when you consider the general case. It 
should be considered a first approximation towards a proper one. As it 
is, it doesn't handle the removal of a block backend properly. Also, it 
can be cumbersome to manage the block configurations provided by the 
various parents and use them as constraints for the operation of the 
block driver. It is very general as it is, though, as block drivers can 
freely choose what to do with the block configuration.

I see you proposed dropping this interface entirely in your review of 
patch 8. I think having an interface like this can be valuable, but it 
seems that it requires more work, so I think I will move the definition 
of a proper interface to a separate patch set and opt for manual 
configuration of the log settings in blklogwrites, as you suggested.

>> diff --git a/block/io.c b/block/io.c
>> index b7beaee..3a06843 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -2932,3 +2932,25 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
>>       bdrv_dec_in_flight(dst_bs);
>>       return ret;
>>   }
>> +
>> +void bdrv_apply_blkconf(BlockDriverState *bs, BlockConf *conf)
>> +{
>> +    BlockDriver *drv = bs->drv;
>> +
>> +    if (!drv) {
>> +        return;
>> +    }
>> +
>> +    if (drv->bdrv_apply_blkconf) {
>> +        drv->bdrv_apply_blkconf(bs, conf);
>> +        return;
>> +    }
>> +
>> +    if (bs->file && bs->file->bs) {
>> +        bdrv_apply_blkconf(bs->file->bs, conf);
>> +    }
>> +
>> +    if (bs->drv->supports_backing && backing_bs(bs)) {
>> +        bdrv_apply_blkconf(backing_bs(bs), conf);
>> +    }
>> +}
> 
> You probably want to propagate to all children instead of singling out
> bs->file and bs->backing.
> 

Oops, this was on my TODO list, but I apparently never did that change.

Thank you,
Ari Sundholm
ari@tuxera.com
