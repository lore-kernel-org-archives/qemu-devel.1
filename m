Received: from eggs.gnu.org ([209.51.188.92]:33646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2YAK-0004Og-1d
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2YAI-0002JV-FL
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:21:11 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190308062455.29755-1-armbru@redhat.com>
	<481d398a-e26c-6c0a-20b7-7466ae1ebf1f@redhat.com>
	<875zsteeih.fsf@dusky.pond.sub.org>
	<20190308133510.GC31583@localhost.localdomain>
	<87sgvxbft2.fsf@dusky.pond.sub.org>
	<20190308154043.GE31583@localhost.localdomain>
	<5186189a-9677-ff6e-323c-485990e07aef@redhat.com>
Date: Sat, 09 Mar 2019 10:20:58 +0100
In-Reply-To: <5186189a-9677-ff6e-323c-485990e07aef@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 8 Mar 2019 19:51:37
	+0100")
Message-ID: <87y35o5rph.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, alex.bennee@linaro.org, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 3/8/19 4:40 PM, Kevin Wolf wrote:
>> Am 08.03.2019 um 15:29 hat Markus Armbruster geschrieben:
>>> Kevin Wolf <kwolf@redhat.com> writes:
>>>
>>>> Am 08.03.2019 um 13:28 hat Markus Armbruster geschrieben:
>>>>> Laszlo Ersek <lersek@redhat.com> writes:
>>>>>> This one has got to be one of the longest bike-shedding sessions! :)
>>>>>>
>>>>>> I'm fine with this patch, but I could suggest two improvements.
>>>>>>
>>>>>> (1) When blk_getlength() fails, we could format the negative error c=
ode
>>>>>> returned by it into the error message.
>>>>>
>>>>> I can do that.
>>>>
>>>> By using error_setg_errno(), I assume. Not throwing away error details
>>>> is always good.
>>>>
>>>>>> (2) We could extract the common code to a new function in
>>>>>> "hw/block/block.c". (It says "Common code for block device models" on
>>>>>> the tin.)
>>>>>
>>>>> There's so much common code in these two files even before this patch=
...
>>>>
>>>> My understanding is that hw/block/block.c contains code that is
>>>> potentially useful to all kinds of block devices, not random code that
>>>> two specific similar devices happen to share.
>>>>
>>>> If we want to deduplicate some code in the flash devices, without any
>>>> expectation that other devices will use it at some point, I'd rather
>>>> create a new source file hw/block/pflash_common.c or something like
>>>> that.
>>>
>>> Yes.
>>>
>>> The helper I came up with (appended) isn't really specific to flash
>>> devices.  Would it be okay for hw/block/block.c even though only the two
>>> flash devices use it for now?
>>=20
>> Hm, it feels more like a helper for devices that can't decide whether
>> they want to be a block device or not. Or that actually don't want to be
>> a block device, but use a BlockBackend anyway. Reading in the whole
>> image isn't something that a normal block device would do.
>>=20
>> But yes, it doesn't have flash-specific knowledge, even though I hope
>> that it's functionality that will remain very specific to these two
>> devices.
>>=20
>> So it's your call, I don't have a strong opinion either way.
>>=20
>>>
>>> bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr s=
ize,
>>>                                  Error **errp)
>>> {
>>>     int64_t blk_len;
>>>     int ret;
>>>
>>>     blk_len =3D blk_getlength(blk);
>>>     if (blk_len < 0) {
>>>         error_setg_errno(errp, -blk_len,
>>>                          "can't get size of block backend '%s'",
>>>                          blk_name(blk));
>>>         return false;
>>>     }
>>>     if (blk_len !=3D size) {
>>>         error_setg(errp, "device requires %" PRIu64 " bytes, "
>>>                    "block backend '%s' provides %" PRIu64 " bytes",
>>>                    size, blk_name(blk), blk_len);
>>=20
>> Should size use HWADDR_PRIu?
>>=20
>> I'm not sure if printing the BlockBackend name is a good idea because
>> hopefully one day the BlockBackend will be anonymous even for the flash
>> devices.
>>=20
>>>         return false;
>>>     }
>>>
>>>     /* TODO for @size > BDRV_REQUEST_MAX_BYTES, we'd need to loop */
>>>     assert(size <=3D BDRV_REQUEST_MAX_BYTES);
>>=20
>> I don't think we'd ever want to read in more than 2 GB into a memory
>> buffer. Before we even get close to this point, the devices should be
>> reworked to be more like an actual block device and read only what is
>> actually accessed.
>
> The biggest NOR available in the market is 256 MiB (bigger size is
> barely ChipSelect MMIO-addressable).
>
> Maybe you can use:
>
> #define NOR_FLASH_MAX_BYTES (256 * MiB)
>
> and refuse bigger flashes.

The comment next to the definition of property "width" in pflash_cfi01.c
suggests the device model can emulate a bunch of flash chips wired
together:

    /* width here is the overall width of this QEMU device in bytes.
     * The QEMU device may be emulating a number of flash devices
     * wired up in parallel; the width of each individual flash
     * device should be specified via device-width. If the individual
     * devices have a maximum width which is greater than the width
     * they are being used for, this maximum width should be set via
     * max-device-width (which otherwise defaults to device-width).
     * So for instance a 32-bit wide QEMU flash device made from four
     * 16-bit flash devices used in 8-bit wide mode would be configured
     * with width =3D 4, device-width =3D 1, max-device-width =3D 2.
     *
     * If device-width is not specified we default to backwards
     * compatible behaviour which is a bad emulation of two
     * 16 bit devices making up a 32 bit wide QEMU device. This
     * is deprecated for new uses of this device.
     */

> We could also check what is the widest chip-select range addressable
> by all the supported architectures. I don't think it's worth it.
>
>>=20
>>>     ret =3D blk_pread(blk, 0, buf, size);
>
> OK, this function is named blk_check_size_and_read_all. Here we
> read_all. Refactoring this device we should be able to read at
> most sizeof(the biggest sector).
>
> But this implies some serious work.

Here's another thing to consider: shadowing in RAM.  Attractive when you
got the RAM, and it's faster than (parallel) flash.  If you shadow
anyway, you can just as well use serial flash, and throw in compression.
Now, emulated pflash can execute code just as fast es emulated RAM.  The
question is what kind of hardware the firmware expects.  Even if it
supports a variety of hardware, it may still have preferences.

>>>     if (ret < 0) {
>>>         error_setg_errno(errp, -ret, "can't read block backend '%s'",
>>>                          blk_name(blk));
>>>         return false;
>>>     }
>>>     return true;
>>> }
>>=20
>> Kevin
>>=20
