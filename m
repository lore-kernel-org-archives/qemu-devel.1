Received: from eggs.gnu.org ([2001:4830:134:3::10]:45953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imxikangjie@gmail.com>) id 1eMU8I-00022i-DC
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 02:28:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imxikangjie@gmail.com>) id 1eMU8H-00013Z-EJ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 02:28:42 -0500
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:44556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <imxikangjie@gmail.com>)
	id 1eMU8H-00013K-AB
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 02:28:41 -0500
Received: by mail-qt0-x22d.google.com with SMTP id m59so6766350qte.11
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 23:28:41 -0800 (PST)
MIME-Version: 1.0
From: Kangjie Xi <imxikangjie@gmail.com>
Date: Wed, 6 Dec 2017 15:28:40 +0800
Message-ID: <CAJqJJggWTki8i_U7xr2oRSFR4sZt4eK5hRO+B55iOYVMyfGwDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] About [PULL 20/25] block: Guard against NULL bs->drv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, qemu-devel@nongnu.org

Hi,

I encountered a qemu-nbd segfault, finally I found it was caused by
NULL bs-drv,  which is located in block/io.c function bdrv_co_flush
line 2377:

https://git.qemu.org/?p=qemu.git;a=blob;f=block/io.c;h=4fdf93a0144fa4761a14b8cc6b2a9a6b6e5d5bec;hb=d470ad42acfc73c45d3e8ed5311a491160b4c100#l2377

It is before the patch at line 2402, so the patch needs to be updated
to fix NULL bs-drv at line 2337.

https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03425.html

> @@ -2373,6 +2399,12 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
>      }
>
>      BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_DISK);
> +    if (!bs->drv) {
> +        /* bs->drv->bdrv_co_flush() might have ejected the BDS
> +         * (even in case of apparent success) */
> +        ret = -ENOMEDIUM;
> +        goto out;
> +    }
>      if (bs->drv->bdrv_co_flush_to_disk) {
>          ret = bs->drv->bdrv_co_flush_to_disk(bs);
>      } else if (bs->drv->bdrv_aio_flush) {

I have tested the latest qemu-2.11.0-rc2 and I am sure the qemu-nbd
segfault is caused by NULL bs-drv in block/io.c line 2337.

kernel: qemu-nbd[18768]: segfault at f8 ip 000055a24f7536a7 sp
00007f59b1137a40 error 4 in qemu-nbd[55a24f6d1000+188000]

However I have no methods to reproduce the segfault manually, the
qemu-nbd segfaut just occurs in my server cluster every week.

Thanks
-Kangjie
