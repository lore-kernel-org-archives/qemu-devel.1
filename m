Received: from eggs.gnu.org ([2001:4830:134:3::10]:60892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebTqe-00053q-4n
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebTqa-0006Uc-Sg
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:12:28 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1516107870-8110-9-git-send-email-anton.nefedov@virtuozzo.com>
References: <1516107870-8110-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516107870-8110-9-git-send-email-anton.nefedov@virtuozzo.com>
Date: Tue, 16 Jan 2018 17:11:47 +0100
Message-ID: <w51h8rlwzp8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 8/9] qcow2: skip writing zero buffers to
 empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com

On Tue 16 Jan 2018 02:04:29 PM CET, Anton Nefedov wrote:

> iotest 060:
> write to the discarded cluster does not trigger COW anymore.
> so, break on write_aio event instead, will work for the test
> (but write won't fail anymore, so update reference output)

I'm wondering about this. The reason why the write doesn't fail anymore
is because after this patch we're breaking in write_aio as you say:

       BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
       trace_qcow2_writev_data(qemu_coroutine_self(),
                               cluster_offset + offset_in_cluster);
       ret = bdrv_co_pwritev(bs->file,
                             cluster_offset + offset_in_cluster,
                             cur_bytes, &hd_qiov, 0);

When the image is marked as corrupted then bs->drv is set to NULL, but
bs->file->drv is still valid. So QEMU goes forward and writes into the
image.

Should we check bs->drv after BLKDBG_EVENT() or perhaps set
bs->file->bs->drv = NULL when an image is corrupted?

> +static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
> +{
> +    if (bs->encrypted) {
> +        return false;
> +    }

I found this a bit confusing because is_zero_cow() can be interpreted as
"the region we're going to copy only contains zeroes" or "we're only
going to write zeroes".

In the first case the bs->encrypted test does not belong there, because
that region may perfectly well contain only zeroes and bs->encrypted
tells us nothing about it.

In the second case the test is fine because bs->encrypted means that
we're definitely going to write something other than zeroes.

I think it's worth adding a comment clarifying this in order to avoid
confusion, or perhaps renaming the function to make it more explicit
(cow_writes_as_zeroes() or something like that).

> +static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    QCowL2Meta *m;
> +
> +    for (m = l2meta; m != NULL; m = m->next) {
> +        int ret;
> +
> +        if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
> +            continue;
> +        }
> +
> +        if (!is_zero_cow(bs, m)) {
> +            continue;
> +        }
> +
> +        /* instead of writing zero COW buffers,
> +           efficiently zero out the whole clusters */
> +        ret = bdrv_co_pwrite_zeroes(bs->file, m->alloc_offset,
> +                                    m->nb_clusters * s->cluster_size,
> +                                    BDRV_REQ_ALLOCATE);
> +        if (ret < 0) {
> +            continue;
> +        }

Is it always fine to simply ignore the error and go on?

> --- a/tests/qemu-iotests/060
> +++ b/tests/qemu-iotests/060
> @@ -160,7 +160,7 @@ poke_file "$TEST_IMG" '131084' "\x00\x00" # 0x2000c
>  # any unallocated cluster, leading to an attempt to overwrite the second L2
>  # table. Finally, resume the COW write and see it fail (but not crash).
>  echo "open -o file.driver=blkdebug $TEST_IMG
> -break cow_read 0
> +break write_aio 0
>  aio_write 0k 1k
>  wait_break 0
>  write 64k 64k

Apart from what I wrote in the beginning of the e-mail, if you're
changing the semantics of this test you should also update the
comment. With your patch the COW no longer stops before doing the read,
and after being resumed it no longer crashes.

Berto
