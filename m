Received: from eggs.gnu.org ([2001:4830:134:3::10]:59707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imxikangjie@gmail.com>) id 1eMWdC-00068y-Bu
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imxikangjie@gmail.com>) id 1eMWd7-0001AK-Py
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:08:46 -0500
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:36243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <imxikangjie@gmail.com>)
	id 1eMWd7-0001AA-Kc
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:08:41 -0500
Received: by mail-qt0-x229.google.com with SMTP id a16so7631872qtj.3
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 02:08:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171206091243.GC4207@localhost.localdomain>
References: <CAJqJJggWTki8i_U7xr2oRSFR4sZt4eK5hRO+B55iOYVMyfGwDg@mail.gmail.com>
	<20171206091243.GC4207@localhost.localdomain>
From: Kangjie Xi <imxikangjie@gmail.com>
Date: Wed, 6 Dec 2017 18:08:40 +0800
Message-ID: <CAJqJJgiDPrM1jxOXoooKPXd5oVQ5YQRBc63YEG7vazqrgRwNNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] About [PULL 20/25] block: Guard against NULL
 bs->drv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com

2017-12-06 17:12 GMT+08:00 Kevin Wolf <kwolf@redhat.com>:
> Am 06.12.2017 um 08:28 hat Kangjie Xi geschrieben:
>> Hi,
>>
>> I encountered a qemu-nbd segfault, finally I found it was caused by
>> NULL bs-drv,  which is located in block/io.c function bdrv_co_flush
>> line 2377:
>>
>> https://git.qemu.org/?p=qemu.git;a=blob;f=block/io.c;h=4fdf93a0144fa4761a14b8cc6b2a9a6b6e5d5bec;hb=d470ad42acfc73c45d3e8ed5311a491160b4c100#l2377
>>
>> It is before the patch at line 2402, so the patch needs to be updated
>> to fix NULL bs-drv at line 2337.
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03425.html
>
> Can you please post a full backtrace? Do you see any error message
> on stderr before the process crashes?

No, I have no full backtrace, the qemu-nbd in our server cluster is
release version, I can't run a debug version, the performance is very
poor.

When the segfault happens, the qemu-ndb process's state is
uninterruptible sleep, I can't kill it and have to reboot the server.

There are errors in /var/log/message:

Dec  1 09:42:07 server kernel: block nbd10: Other side returned error (5)
Dec  1 09:42:07 server kernel: blk_update_request: I/O error, dev
nbd10, sector 32572640
Dec  1 09:42:07 server kernel: Buffer I/O error on dev nbd10p1,
logical block 4071324, lost async page write
Dec  1 09:42:07 server kernel: block nbd10: Other side returned error (5)
Dec  1 09:42:07 server kernel: blk_update_request: I/O error, dev
nbd10, sector 32605376
Dec  1 09:42:07 server kernel: Buffer I/O error on dev nbd10p1,
logical block 4075416, lost async page write
Dec  1 09:42:07 server kernel: qemu-nbd[18768]: segfault at f8 ip
000055a24f7536a7 sp 00007f59b1137a40 error 4 in
qemu-nbd[55a24f6d1000+188000]
Dec  1 09:42:07 server kernel: Buffer I/O error on dev nbd10p1,
logical block 4075417, lost async page write
Dec  1 09:42:07 server kernel: Buffer I/O error on dev nbd10p1,
logical block 4075418, lost async page write
Dec  1 09:42:07 server kernel: Buffer I/O error on dev nbd10p1,
logical block 4075419, lost async page write
Dec  1 09:42:07 server kernel: Buffer I/O error on dev nbd10p1,
logical block 4075420, lost async page write
Dec  1 09:42:07 server kernel: Buffer I/O error on dev nbd10p1,
logical block 4075421, lost async page write
Dec  1 09:42:07 server kernel: Buffer I/O error on dev nbd10p1,
logical block 4075422, lost async page write
Dec  1 09:42:07 server kernel: Buffer I/O error on dev nbd10p1,
logical block 4075423, lost async page write
Dec  1 09:42:07 server kernel: Buffer I/O error on dev nbd10p1,
logical block 4075424, lost async page write
Dec  1 09:42:07 server kernel: block nbd10: Other side returned error (5)
Dec  1 09:42:07 server kernel: blk_update_request: I/O error, dev
nbd10, sector 32605632
Dec  1 09:42:07 server kernel: block nbd10: Other side returned error (5)
Dec  1 09:42:07 server kernel: blk_update_request: I/O error, dev
nbd10, sector 32605888
Dec  1 09:42:07 server kernel: block nbd10: Other side returned error (22)
Dec  1 09:42:07 server kernel: blk_update_request: I/O error, dev
nbd10, sector 32607168
Dec  1 09:42:07 server kernel: block nbd10: Other side returned error (22)
Dec  1 09:42:07 server kernel: blk_update_request: I/O error, dev
nbd10, sector 32606144
Dec  1 09:42:07 server kernel: block nbd10: Other side returned error (22)
Dec  1 09:42:07 server kernel: blk_update_request: I/O error, dev
nbd10, sector 32606656
Dec  1 09:42:07 server kernel: block nbd10: Other side returned error (22)
Dec  1 09:42:07 server kernel: blk_update_request: I/O error, dev
nbd10, sector 32606400
Dec  1 09:42:07 server kernel: block nbd10: Other side returned error (22)
Dec  1 09:42:07 server kernel: blk_update_request: I/O error, dev
nbd10, sector 32606912
Dec  1 09:42:07 server kernel: block nbd10: Other side returned error (22)
Dec  1 09:42:07 server kernel: blk_update_request: I/O error, dev
nbd10, sector 32607424
Dec  1 09:42:07 server kernel: block nbd10: Other side returned error (22)
Dec  1 09:42:07 server kernel: block nbd10: Other side returned error (22)
Dec  1 09:42:07 server kernel: block nbd10: Receive control failed (result -512)
Dec  1 09:42:07 server kernel: block nbd10: pid 18770, qemu-nbd, got signal 9

I just use objdump disassemble the qemu-nbd, confirm the segfault
happens in  block/io.c line 2337.

-Kangjie

> I don't see at the moment how this can happen, except the case that Max
> mentioned where bs->drv = NULL is set when an image corruption is
> detected - this involves an error message, though.
>
> We check bdrv_is_inserted() as the first thing, which includes a NULL
> check for bs->drv. So it must have been non-NULL at the start of the
> function and then become NULL. I suppose this can theoretically happen
> in qemu_co_queue_wait() if another flush request detects image
> corruption.
>
> Max: I think bs->drv = NULL in the middle of a request was a stupid
> idea. In fact, it's already a stupid idea to have any BDS with
> bs->drv = NULL. Maybe it would be better to schedule a BH that replaces
> the qcow2 node with a dummy node (null-co?) and properly closes the
> qcow2 one.
>
> Kevin
>
>> > @@ -2373,6 +2399,12 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
>> >      }
>> >
>> >      BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_DISK);
>> > +    if (!bs->drv) {
>> > +        /* bs->drv->bdrv_co_flush() might have ejected the BDS
>> > +         * (even in case of apparent success) */
>> > +        ret = -ENOMEDIUM;
>> > +        goto out;
>> > +    }
>> >      if (bs->drv->bdrv_co_flush_to_disk) {
>> >          ret = bs->drv->bdrv_co_flush_to_disk(bs);
>> >      } else if (bs->drv->bdrv_aio_flush) {
>>
>> I have tested the latest qemu-2.11.0-rc2 and I am sure the qemu-nbd
>> segfault is caused by NULL bs-drv in block/io.c line 2337.
>>
>> kernel: qemu-nbd[18768]: segfault at f8 ip 000055a24f7536a7 sp
>> 00007f59b1137a40 error 4 in qemu-nbd[55a24f6d1000+188000]
>>
>> However I have no methods to reproduce the segfault manually, the
>> qemu-nbd segfaut just occurs in my server cluster every week.
>>
>> Thanks
>> -Kangjie
