Received: from eggs.gnu.org ([2001:4830:134:3::10]:35978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqbev-0004Bp-EK
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqbeq-0003VS-IG
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:34:53 -0500
Date: Tue, 27 Feb 2018 17:34:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180227093430.GE25412@lemon.usersys.redhat.com>
References: <20180122220806.22154-1-mreitz@redhat.com>
	<20180122220806.22154-15-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180122220806.22154-15-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 14/16] block/mirror: Add active mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, 01/22 23:08, Max Reitz wrote:
> @@ -1151,7 +1285,48 @@ static int coroutine_fn bdrv_mirror_top_preadv(BlockDriverState *bs,
>  static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
>      uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
>  {
> -    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
> +    MirrorOp *op = NULL;
> +    MirrorBDSOpaque *s = bs->opaque;
> +    QEMUIOVector bounce_qiov;
> +    void *bounce_buf;
> +    int ret = 0;
> +    bool copy_to_target;
> +
> +    copy_to_target = s->job->ret >= 0 &&
> +                     s->job->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING;
> +
> +    if (copy_to_target) {
> +        /* The guest might concurrently modify the data to write; but
> +         * the data on source and destination must match, so we have
> +         * to use a bounce buffer if we are going to write to the
> +         * target now. */
> +        bounce_buf = qemu_blockalign(bs, bytes);
> +        iov_to_buf_full(qiov->iov, qiov->niov, 0, bounce_buf, bytes);

Quorum doesn't use a bounce buffer, so I think we can get away without it too: a
guest concurrently modifying the buffer isn't a concern in practice.

> +
> +        qemu_iovec_init(&bounce_qiov, 1);
> +        qemu_iovec_add(&bounce_qiov, bounce_buf, bytes);
> +        qiov = &bounce_qiov;
> +
> +        op = active_write_prepare(s->job, offset, bytes);
> +    }
> +
> +    ret = bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    if (copy_to_target) {
> +        do_sync_target_write(s->job, offset, bytes, qiov, flags);
> +    }
> +
> +out:
> +    if (copy_to_target) {
> +        active_write_settle(op);
> +
> +        qemu_iovec_destroy(&bounce_qiov);
> +        qemu_vfree(bounce_buf);
> +    }
> +    return ret;
>  }
>  
>  static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)

Don't you need to update bdrv_mirror_top_pdiscard and bdrv_mirror_top_pwritev
too?

Fam
