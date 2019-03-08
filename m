Received: from eggs.gnu.org ([209.51.188.92]:55078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Kar-0005Uu-Nv
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Kaq-0002Kh-Lb
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:51:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2Kaq-0002Jf-DC
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:51:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id r5so22443253wrg.9
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 10:51:40 -0800 (PST)
References: <20190308062455.29755-1-armbru@redhat.com>
	<481d398a-e26c-6c0a-20b7-7466ae1ebf1f@redhat.com>
	<875zsteeih.fsf@dusky.pond.sub.org>
	<20190308133510.GC31583@localhost.localdomain>
	<87sgvxbft2.fsf@dusky.pond.sub.org>
	<20190308154043.GE31583@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5186189a-9677-ff6e-323c-485990e07aef@redhat.com>
Date: Fri, 8 Mar 2019 19:51:37 +0100
MIME-Version: 1.0
In-Reply-To: <20190308154043.GE31583@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, mreitz@redhat.com, alex.bennee@linaro.org

On 3/8/19 4:40 PM, Kevin Wolf wrote:
> Am 08.03.2019 um 15:29 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>
>>> Am 08.03.2019 um 13:28 hat Markus Armbruster geschrieben:
>>>> Laszlo Ersek <lersek@redhat.com> writes:
>>>>> This one has got to be one of the longest bike-shedding sessions! :)
>>>>>
>>>>> I'm fine with this patch, but I could suggest two improvements.
>>>>>
>>>>> (1) When blk_getlength() fails, we could format the negative error code
>>>>> returned by it into the error message.
>>>>
>>>> I can do that.
>>>
>>> By using error_setg_errno(), I assume. Not throwing away error details
>>> is always good.
>>>
>>>>> (2) We could extract the common code to a new function in
>>>>> "hw/block/block.c". (It says "Common code for block device models" on
>>>>> the tin.)
>>>>
>>>> There's so much common code in these two files even before this patch...
>>>
>>> My understanding is that hw/block/block.c contains code that is
>>> potentially useful to all kinds of block devices, not random code that
>>> two specific similar devices happen to share.
>>>
>>> If we want to deduplicate some code in the flash devices, without any
>>> expectation that other devices will use it at some point, I'd rather
>>> create a new source file hw/block/pflash_common.c or something like
>>> that.
>>
>> Yes.
>>
>> The helper I came up with (appended) isn't really specific to flash
>> devices.  Would it be okay for hw/block/block.c even though only the two
>> flash devices use it for now?
> 
> Hm, it feels more like a helper for devices that can't decide whether
> they want to be a block device or not. Or that actually don't want to be
> a block device, but use a BlockBackend anyway. Reading in the whole
> image isn't something that a normal block device would do.
> 
> But yes, it doesn't have flash-specific knowledge, even though I hope
> that it's functionality that will remain very specific to these two
> devices.
> 
> So it's your call, I don't have a strong opinion either way.
> 
>>
>> bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
>>                                  Error **errp)
>> {
>>     int64_t blk_len;
>>     int ret;
>>
>>     blk_len = blk_getlength(blk);
>>     if (blk_len < 0) {
>>         error_setg_errno(errp, -blk_len,
>>                          "can't get size of block backend '%s'",
>>                          blk_name(blk));
>>         return false;
>>     }
>>     if (blk_len != size) {
>>         error_setg(errp, "device requires %" PRIu64 " bytes, "
>>                    "block backend '%s' provides %" PRIu64 " bytes",
>>                    size, blk_name(blk), blk_len);
> 
> Should size use HWADDR_PRIu?
> 
> I'm not sure if printing the BlockBackend name is a good idea because
> hopefully one day the BlockBackend will be anonymous even for the flash
> devices.
> 
>>         return false;
>>     }
>>
>>     /* TODO for @size > BDRV_REQUEST_MAX_BYTES, we'd need to loop */
>>     assert(size <= BDRV_REQUEST_MAX_BYTES);
> 
> I don't think we'd ever want to read in more than 2 GB into a memory
> buffer. Before we even get close to this point, the devices should be
> reworked to be more like an actual block device and read only what is
> actually accessed.

The biggest NOR available in the market is 256 MiB (bigger size is
barely ChipSelect MMIO-addressable).

Maybe you can use:

#define NOR_FLASH_MAX_BYTES (256 * MiB)

and refuse bigger flashes.

We could also check what is the widest chip-select range addressable
by all the supported architectures. I don't think it's worth it.

> 
>>     ret = blk_pread(blk, 0, buf, size);

OK, this function is named blk_check_size_and_read_all. Here we
read_all. Refactoring this device we should be able to read at
most sizeof(the biggest sector).

But this implies some serious work.

>>     if (ret < 0) {
>>         error_setg_errno(errp, -ret, "can't read block backend '%s'",
>>                          blk_name(blk));
>>         return false;
>>     }
>>     return true;
>> }
> 
> Kevin
> 
