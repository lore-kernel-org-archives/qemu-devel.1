Received: from eggs.gnu.org ([209.51.188.92]:58054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Gfh-0004H7-9c
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Gfd-0003sr-Cf
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:40:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2Gfb-0003aw-AT
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:40:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id z84so12617370wmg.4
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 06:40:17 -0800 (PST)
References: <20190308062455.29755-1-armbru@redhat.com>
	<481d398a-e26c-6c0a-20b7-7466ae1ebf1f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <026c2176-66a1-5818-15d4-23b1ab4a004b@redhat.com>
Date: Fri, 8 Mar 2019 15:40:15 +0100
MIME-Version: 1.0
In-Reply-To: <481d398a-e26c-6c0a-20b7-7466ae1ebf1f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7] pflash: Require backend size to match
 device, improve errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

On 3/8/19 12:47 PM, Laszlo Ersek wrote:
> On 03/08/19 07:24, Markus Armbruster wrote:
>> From: Alex Bennée <alex.bennee@linaro.org>
>>
>> We reject undersized backends with a rather enigmatic "failed to read
>> the initial flash content" error.
>>
>> We happily accept oversized images, ignoring their tail.  Throwing
>> away parts of firmware that way is pretty much certain to end in an
>> even more enigmatic failure to boot.
>>
>> Require the backend's size to match the device's size exactly.  Report
>> mismatch as "device requires N bytes, block backend 'NAME' provides M
>> bytes".
>>
>> Improve the error for actual read failures to "can't read initial
>> flash content from block backend 'NAME'.
>>
>> We disabled code to limit device sizes to 8, 16, 32 or 64MiB more than
>> a decade ago in commit 95d1f3edd5e and c8b153d7949, v0.9.1.  Bury.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/block/pflash_cfi01.c | 31 ++++++++++++++++++++++---------
>>  hw/block/pflash_cfi02.c | 31 +++++++++++++++++++++++--------
>>  2 files changed, 45 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index 9d1c356eb6..2e3a05c0b3 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -730,13 +730,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>>      }
>>      device_len = sector_len_per_device * blocks_per_device;
>>  
>> -    /* XXX: to be fixed */
>> -#if 0
>> -    if (total_len != (8 * 1024 * 1024) && total_len != (16 * 1024 * 1024) &&
>> -        total_len != (32 * 1024 * 1024) && total_len != (64 * 1024 * 1024))
>> -        return NULL;
>> -#endif
>> -
>>      memory_region_init_rom_device(
>>          &pfl->mem, OBJECT(dev),
>>          &pflash_cfi01_ops,
>> @@ -763,12 +756,32 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>>      }
>>  
>>      if (pfl->blk) {
>> +        /*
>> +         * Validate the backing store is the right size for pflash
>> +         * devices. If the user supplies a larger file we ignore the
>> +         * tail.
>> +         */
>> +        int64_t backing_len = blk_getlength(pfl->blk);
>> +
>> +        if (backing_len < 0) {
>> +            error_setg(errp, "can't get size of block backend '%s'",
>> +                       blk_name(pfl->blk));
>> +            return;
>> +        }
>> +        if (backing_len != total_len) {
>> +            error_setg(errp, "device requires %" PRIu64 " bytes, "
>> +                       "block backend '%s' provides %" PRIu64 " bytes",
>> +                       total_len, blk_name(pfl->blk), backing_len);
>> +            return;
>> +        }
>> +
>>          /* read the initial flash content */
>>          ret = blk_pread(pfl->blk, 0, pfl->storage, total_len);
>> -
>>          if (ret < 0) {
>>              vmstate_unregister_ram(&pfl->mem, DEVICE(pfl));
>> -            error_setg(errp, "failed to read the initial flash content");
>> +            error_setg(errp, "can't read initial flash content"
>> +                       " from block backend '%s'",
>> +                       blk_name(pfl->blk));
>>              return;
>>          }
>>      }
>> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
>> index 33779ce807..45b88d65d8 100644
>> --- a/hw/block/pflash_cfi02.c
>> +++ b/hw/block/pflash_cfi02.c
>> @@ -550,12 +550,6 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>>      }
>>  
>>      chip_len = pfl->sector_len * pfl->nb_blocs;
>> -    /* XXX: to be fixed */
>> -#if 0
>> -    if (total_len != (8 * 1024 * 1024) && total_len != (16 * 1024 * 1024) &&
>> -        total_len != (32 * 1024 * 1024) && total_len != (64 * 1024 * 1024))
>> -        return NULL;
>> -#endif
>>  
>>      memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl), pfl->be ?
>>                                    &pflash_cfi02_ops_be : &pflash_cfi02_ops_le,
>> @@ -581,11 +575,32 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>>      }
>>  
>>      if (pfl->blk) {
>> +        /*
>> +         * Validate the backing store is the right size for pflash
>> +         * devices. If the user supplies a larger file we ignore the
>> +         * tail.
>> +         */
>> +        int64_t backing_len = blk_getlength(pfl->blk);
>> +
>> +        if (backing_len < 0) {
>> +            error_setg(errp, "can't get size of block backend '%s'",
>> +                       blk_name(pfl->blk));
>> +            return;
>> +        }
>> +        if (backing_len != chip_len) {
>> +            error_setg(errp, "device requires %" PRIu32 " bytes, "
>> +                       "block backend '%s' provides %" PRIu64 " bytes",
>> +                       chip_len, blk_name(pfl->blk), backing_len);
>> +            return;
>> +        }
>> +
>>          /* read the initial flash content */
>>          ret = blk_pread(pfl->blk, 0, pfl->storage, chip_len);
>>          if (ret < 0) {
>> -            vmstate_unregister_ram(&pfl->orig_mem, DEVICE(pfl));
>> -            error_setg(errp, "failed to read the initial flash content");
>> +            vmstate_unregister_ram(&pfl->mem, DEVICE(pfl));
>> +            error_setg(errp, "can't read initial flash content"
>> +                       " from block backend '%s'",
>> +                       blk_name(pfl->blk));
>>              return;
>>          }
>>      }
>>
> 
> This one has got to be one of the longest bike-shedding sessions! :)
> 
> I'm fine with this patch, but I could suggest two improvements.
> 
> (1) When blk_getlength() fails, we could format the negative error code
> returned by it into the error message.

This one is a worthwhile a v8.

> (2) We could extract the common code to a new function in
> "hw/block/block.c". (It says "Common code for block device models" on
> the tin.)

Good idea, but I'd postpone that for the next dev cycle.

> I realize the vmstate_unregister_ram() rollbacks are not identical
> between cfi01 and cfi02. However, that difference only draws my
> attention to the fact that the unregister calls are not made on the
> other error branches in this patch anyway!
> 
> So we should have a common function like this:
> 
> void pflash_cfi_read_initial_content(BlockBackend *blk, uint64_t size,
>                                      void *buf, Error **errp)
> {
>     int64_t backing_len = blk_getlength(blk);
>     int ret;
> 
>     if (backing_len < 0) {
>         error_setg(...);
>         return;
>     }
> 
>     if (backing_len != size) {
>         error_setg(...);
>         return;
>     }
> 
>     ret = blk_pread(blk, 0, buf, size);
>     if (ret < 0) {
>         error_setg(...);
>     }
> }
> 
> And at the call sites, we can do
> 
>     if (pfl->blk) {
>         Error *local_err = NULL;
> 
>         pflash_cfi_read_initial_content(pfl->blk,
>                                         total_len OR chip_len,
>                                         pfl->storage,
>                                         &local_err);
>         if (local_err) {
>             error_propagate(errp, local_err);
>             vmstate_unregister_ram(...); // as appropriate for cfiXX
>             return;
>         }
>     }
> 
> Thanks
> Laszlo
> 
