Received: from eggs.gnu.org ([209.51.188.92]:55875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2GV2-0008Ui-Mf
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2GV0-0006WH-UX
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:29:24 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190308062455.29755-1-armbru@redhat.com>
	<481d398a-e26c-6c0a-20b7-7466ae1ebf1f@redhat.com>
	<875zsteeih.fsf@dusky.pond.sub.org>
	<20190308133510.GC31583@localhost.localdomain>
Date: Fri, 08 Mar 2019 15:29:13 +0100
In-Reply-To: <20190308133510.GC31583@localhost.localdomain> (Kevin Wolf's
	message of "Fri, 8 Mar 2019 14:35:10 +0100")
Message-ID: <87sgvxbft2.fsf@dusky.pond.sub.org>
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
Cc: qemu-block@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, mreitz@redhat.com, alex.bennee@linaro.org

Kevin Wolf <kwolf@redhat.com> writes:

> Am 08.03.2019 um 13:28 hat Markus Armbruster geschrieben:
>> Laszlo Ersek <lersek@redhat.com> writes:
>> > This one has got to be one of the longest bike-shedding sessions! :)
>> >
>> > I'm fine with this patch, but I could suggest two improvements.
>> >
>> > (1) When blk_getlength() fails, we could format the negative error code
>> > returned by it into the error message.
>> 
>> I can do that.
>
> By using error_setg_errno(), I assume. Not throwing away error details
> is always good.
>
>> > (2) We could extract the common code to a new function in
>> > "hw/block/block.c". (It says "Common code for block device models" on
>> > the tin.)
>> 
>> There's so much common code in these two files even before this patch...
>
> My understanding is that hw/block/block.c contains code that is
> potentially useful to all kinds of block devices, not random code that
> two specific similar devices happen to share.
>
> If we want to deduplicate some code in the flash devices, without any
> expectation that other devices will use it at some point, I'd rather
> create a new source file hw/block/pflash_common.c or something like
> that.

Yes.

The helper I came up with (appended) isn't really specific to flash
devices.  Would it be okay for hw/block/block.c even though only the two
flash devices use it for now?


bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
                                 Error **errp)
{
    int64_t blk_len;
    int ret;

    blk_len = blk_getlength(blk);
    if (blk_len < 0) {
        error_setg_errno(errp, -blk_len,
                         "can't get size of block backend '%s'",
                         blk_name(blk));
        return false;
    }
    if (blk_len != size) {
        error_setg(errp, "device requires %" PRIu64 " bytes, "
                   "block backend '%s' provides %" PRIu64 " bytes",
                   size, blk_name(blk), blk_len);
        return false;
    }

    /* TODO for @size > BDRV_REQUEST_MAX_BYTES, we'd need to loop */
    assert(size <= BDRV_REQUEST_MAX_BYTES);
    ret = blk_pread(blk, 0, buf, size);
    if (ret < 0) {
        error_setg_errno(errp, -ret, "can't read block backend '%s'",
                         blk_name(blk));
        return false;
    }
    return true;
}
