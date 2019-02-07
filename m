Received: from eggs.gnu.org ([209.51.188.92]:41815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grobj-0002vL-VN
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:41:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grobg-00025d-3E
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:41:05 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:35616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grobe-0001tg-Qf
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:41:03 -0500
Received: by mail-ot1-x332.google.com with SMTP id 81so1599136otj.2
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:40:52 -0800 (PST)
MIME-Version: 1.0
References: <20190114162605.5330-1-eblake@redhat.com>
	<20190114162605.5330-20-eblake@redhat.com>
In-Reply-To: <20190114162605.5330-20-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 18:40:39 +0000
Message-ID: <CAFEAcA83L0jFLVDK8ebF2pxtAqoM+YsTU2vYUx2y7-PbSuEW9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 19/20] nbd: Merge nbd_export_bitmap into
 nbd_export_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Mon, 14 Jan 2019 at 16:47, Eric Blake <eblake@redhat.com> wrote:
>
> We only have one caller that wants to export a bitmap name,
> which it does right after creation of the export. But there is
> still a brief window of time where an NBD client could see the
> export but not the dirty bitmap, which a robust client would
> have to interpret as meaning the entire image should be treated
> as dirty.  Better is to eliminate the window entirely, by
> inlining nbd_export_bitmap() into nbd_export_new(), and refusing
> to create the bitmap in the first place if the requested bitmap
> can't be located.


>  NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t size,
>                            const char *name, const char *description,
> -                          uint16_t nbdflags, void (*close)(NBDExport *),
> -                          bool writethrough, BlockBackend *on_eject_blk,
> -                          Error **errp)
> +                          const char *bitmap, uint16_t nbdflags,
> +                          void (*close)(NBDExport *), bool writethrough,
> +                          BlockBackend *on_eject_blk, Error **errp)
>  {
>      AioContext *ctx;
>      BlockBackend *blk;
> @@ -1507,6 +1507,43 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t size,
>      }
>      exp->size -= exp->size % BDRV_SECTOR_SIZE;
>
> +    if (bitmap) {
> +        BdrvDirtyBitmap *bm = NULL;
> +        BlockDriverState *bs = blk_bs(blk);

lgtm.com points out that this local variable 'bs' shadows
the 'bs' argument to the function. Is this intentional?
I think that the two can't ever be different, in which case
you could just delete the variable declaration here, but
I'm not an expert on the block layer APIs.

thanks
-- PMM
