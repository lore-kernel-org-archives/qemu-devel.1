Received: from eggs.gnu.org ([209.51.188.92]:34346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2Iud-0003I7-O0
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2Iub-0004kE-NK
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:03:58 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190308062455.29755-1-armbru@redhat.com>
	<481d398a-e26c-6c0a-20b7-7466ae1ebf1f@redhat.com>
	<875zsteeih.fsf@dusky.pond.sub.org>
	<20190308133510.GC31583@localhost.localdomain>
	<87sgvxbft2.fsf@dusky.pond.sub.org>
	<20190308154043.GE31583@localhost.localdomain>
Date: Fri, 08 Mar 2019 18:03:37 +0100
In-Reply-To: <20190308154043.GE31583@localhost.localdomain> (Kevin Wolf's
	message of "Fri, 8 Mar 2019 16:40:44 +0100")
Message-ID: <87bm2l8fiu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, philmd@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org

Kevin Wolf <kwolf@redhat.com> writes:

> Am 08.03.2019 um 15:29 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > Am 08.03.2019 um 13:28 hat Markus Armbruster geschrieben:
>> >> Laszlo Ersek <lersek@redhat.com> writes:
>> >> > This one has got to be one of the longest bike-shedding sessions! :)
>> >> >
>> >> > I'm fine with this patch, but I could suggest two improvements.
>> >> >
>> >> > (1) When blk_getlength() fails, we could format the negative error code
>> >> > returned by it into the error message.
>> >> 
>> >> I can do that.
>> >
>> > By using error_setg_errno(), I assume. Not throwing away error details
>> > is always good.
>> >
>> >> > (2) We could extract the common code to a new function in
>> >> > "hw/block/block.c". (It says "Common code for block device models" on
>> >> > the tin.)
>> >> 
>> >> There's so much common code in these two files even before this patch...
>> >
>> > My understanding is that hw/block/block.c contains code that is
>> > potentially useful to all kinds of block devices, not random code that
>> > two specific similar devices happen to share.
>> >
>> > If we want to deduplicate some code in the flash devices, without any
>> > expectation that other devices will use it at some point, I'd rather
>> > create a new source file hw/block/pflash_common.c or something like
>> > that.
>> 
>> Yes.
>> 
>> The helper I came up with (appended) isn't really specific to flash
>> devices.  Would it be okay for hw/block/block.c even though only the two
>> flash devices use it for now?
>
> Hm, it feels more like a helper for devices that can't decide whether
> they want to be a block device or not. Or that actually don't want to be
> a block device, but use a BlockBackend anyway.

I think the latter's precisely what the two pflash devices are.

>                                                Reading in the whole
> image isn't something that a normal block device would do.

No argument.

> But yes, it doesn't have flash-specific knowledge, even though I hope
> that it's functionality that will remain very specific to these two
> devices.
>
> So it's your call, I don't have a strong opinion either way.

Understood.

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

Yes.

> I'm not sure if printing the BlockBackend name is a good idea because
> hopefully one day the BlockBackend will be anonymous even for the flash
> devices.

Hmm.  Tell me what else I can use to identify the troublemaker to the
user.

For the second error, I could sidestep the issue and point to frontend
instead (oh, now I have an even thornier issue).  The first and third
error are *backend* errors, only related to the frontend since the
frontend happens to use them.  I could perhaps identify them as "backend
of frontend F".  If we want to do that going forward, we need suitable
helpers, so we don't reinvent this wheel in every block frontend.

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

I'll steal from that to turn the comment into a proper excuse for my
lazy assertion.  Thanks!

>>     ret = blk_pread(blk, 0, buf, size);
>>     if (ret < 0) {
>>         error_setg_errno(errp, -ret, "can't read block backend '%s'",
>>                          blk_name(blk));
>>         return false;
>>     }
>>     return true;
>> }
>
> Kevin
