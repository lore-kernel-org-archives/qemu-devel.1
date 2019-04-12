Received: from eggs.gnu.org ([209.51.188.92]:51029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEttI-0007hg-Kg
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEttF-0002QB-SA
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:58:39 -0400
Date: Fri, 12 Apr 2019 12:57:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190412105737.GC4522@linux.fritz.box>
References: <bf2decd3-b3cb-08eb-3449-b66f023b084a@huawei.com>
	<c57135ae-41a9-ed7b-976b-bf8fe43596a2@redhat.com>
	<b107e0c0-1c4c-3f0f-eb78-8929c315ce28@huawei.com>
	<a8144a1f-364e-cea5-b0a7-05342bdab936@redhat.com>
	<87bm1fiuo8.fsf@dusky.pond.sub.org>
	<20190409082852.GB6610@localhost.localdomain>
	<c03c51a7-1bb0-b05b-9027-2364ab00517c@huawei.com>
	<20190411122246.GB5694@linux.fritz.box>
	<0c6c32b7-46f8-cf80-b7a6-1b48995b84e4@huawei.com>
	<355cd139-2084-e282-9a60-3574fe0746bd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <355cd139-2084-e282-9a60-3574fe0746bd@huawei.com>
Subject: Re: [Qemu-devel] [RFC PATCH] hw/arm/virt: use variable size of
 flash device to save memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiang Zheng <zhengxiang9@huawei.com>
Cc: Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 12.04.2019 um 11:50 hat Xiang Zheng geschrieben:
> 
> On 2019/4/12 9:52, Xiang Zheng wrote:
> > On 2019/4/11 20:22, Kevin Wolf wrote:
> >> Okay, so your problem is that blk_pread() writes to the whole buffer,
> >> writing explicit zeroes for unallocated parts of the image, while you
> >> would like to leave those parts of the buffer untouched so that we don't
> >> actually allocate the memory, but can just use the shared zero page.
> >>
> >> If you just want to read the non-zero parts of the image, that can be
> >> done by using a loop that calls bdrv_block_status() and only reads from
> >> the image if the BDRV_BLOCK_ZERO bit is clear.
> >>
> >> Would this solve your problem?
> > 
> > Sounds good! What if guest tried to read/write the zero parts?
> > 
> 
> I wrote the below patch (refer to bdrv_make_zero()) for test, it seems
> that everything is OK and the memory is also exactly allocated on demand.
> 
> This requires pflash devices to use sparse files backend. Thus I have to
> create images like:
> 
>    dd of="QEMU_EFI-pflash.raw" if="/dev/zero" bs=1M seek=64 count=0
>    dd of="QEMU_EFI-pflash.raw" if="QEMU_EFI.fd" conv=notrunc
> 
>    dd of="empty_VARS.fd" if="/dev/zero" bs=1M seek=64 count=0
> 
> 
> ---8>---
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index f78e82a..ed8ca87 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1379,6 +1379,12 @@ BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
>                          flags | BDRV_REQ_ZERO_WRITE, cb, opaque);
>  }
> 
> +int blk_pread_nonzeroes(BlockBackend *blk, void *buf)
> +{
> +    int ret = bdrv_pread_nonzeroes(blk->root, buf);
> +    return ret;
> +}

I don't think this deserves a place in the public block layer interface,
as it's only a single device that makes use of it.

Maybe you wrote things this way because there is no blk_block_status(),
but you can get the BlockDriverState with blk_bs(blk) and then implement
everything inside hw/block/block.c.

>  int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int count)
>  {
>      int ret = blk_prw(blk, offset, buf, count, blk_read_entry, 0);
> diff --git a/block/io.c b/block/io.c
> index dfc153b..83e5ea7 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -882,6 +882,38 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
>                          BDRV_REQ_ZERO_WRITE | flags);
>  }
> 
> +int bdrv_pread_nonzeroes(BdrvChild *child, void *buf)
> +{
> +    int ret;
> +    int64_t target_size, bytes, offset = 0;
> +    BlockDriverState *bs = child->bs;
> +
> +    target_size = bdrv_getlength(bs);
> +    if (target_size < 0) {
> +        return target_size;
> +    }
> +
> +    for (;;) {
> +        bytes = MIN(target_size - offset, BDRV_REQUEST_MAX_BYTES);
> +        if (bytes <= 0) {
> +            return 0;
> +        }
> +        ret = bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        if (ret & BDRV_BLOCK_ZERO) {
> +            offset += bytes;
> +            continue;
> +        }
> +        ret = bdrv_pread(child, offset, buf, bytes);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        offset += bytes;

I think the code becomes simpler the other way round:

    if (!(ret & BDRV_BLOCK_ZERO)) {
        ret = bdrv_pread(child, offset, buf, bytes);
        if (ret < 0) {
            return ret;
        }
    }
    offset += bytes;

You don't increment buf, so if you have a hole in the file, this will
corrupt the buffer. You need to either increment buf, too, or use
(uint8_t*) buf + offset for the bdrv_pread() call.

> +    }
> +}
> +
>  /*
>   * Completely zero out a block device with the help of bdrv_pwrite_zeroes.
>   * The operation is sped up by checking the block status and only writing

Kevin
