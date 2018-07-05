Received: from eggs.gnu.org ([2001:4830:134:3::10]:43543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb2U1-0008Tp-4R
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb2U0-0007Zg-AY
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:31:33 -0400
Date: Thu, 5 Jul 2018 13:31:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180705113124.GJ3309@localhost.localdomain>
References: <20180705073701.10558-1-famz@redhat.com>
	<20180705073701.10558-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705073701.10558-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/9] block: Extract common write req
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 05.07.2018 um 09:36 hat Fam Zheng geschrieben:
> As a mechanical refactoring patch, this is the first step towards
> unified and more correct write code paths. This is helpful because
> multiple BlockDriverState fields need to be updated after modifying
> image data, and it's hard to maintain in multiple places such as copy
> offload, discard and truncate.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Several lines are longer than 80 characters in this patch.

>  block/io.c | 70 ++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 44 insertions(+), 26 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 443a8584c4..03d9eb0a65 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1538,6 +1538,48 @@ fail:
>      return ret;
>  }
>  
> +static inline int coroutine_fn
> +bdrv_co_write_req_prepare(BdrvChild *child, BdrvTrackedRequest *req, int flags)
> +{
> +    BlockDriverState *bs = child->bs;
> +    bool waited;
> +    int64_t end_sector = DIV_ROUND_UP(req->offset + req->bytes, BDRV_SECTOR_SIZE);

You can't simply replace offset/bytes with req->offset/bytes, they are
not necessarily the same thing with unaligned requests. (If they were
the same thing, bdrv_aligned_pwritev() wouldn't need the extra
parameters).

(Multiple instances throughout the patch, I'll mention it only once).

> +
> +    if (bs->read_only) {
> +        return -EPERM;
> +    }
> +    assert(!(bs->open_flags & BDRV_O_INACTIVE));
> +    assert((bs->open_flags & BDRV_O_NO_IO) == 0);
> +    assert(!(flags & ~BDRV_REQ_MASK));
> +    waited = wait_serialising_requests(req);
> +    assert(!waited || !req->serialising);
> +    assert(req->overlap_offset <= req->offset);
> +    assert(req->offset + req->bytes <= req->overlap_offset + req->overlap_bytes);
> +    if (flags & BDRV_REQ_WRITE_UNCHANGED) {
> +        assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
> +    } else {
> +        assert(child->perm & BLK_PERM_WRITE);
> +    }
> +    assert(end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE);
> +    return notifier_with_return_list_notify(&bs->before_write_notifiers, req);
> +}

A few empty lines wouldn't hurt, to make it visually easier to find the
"real" code between the assertions.

Kevin
