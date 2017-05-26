Received: from eggs.gnu.org ([2001:4830:134:3::10]:59748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dEALY-0005za-PY
	for qemu-devel@nongnu.org; Fri, 26 May 2017 04:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dEALX-0007RJ-Rj
	for qemu-devel@nongnu.org; Fri, 26 May 2017 04:11:44 -0400
Date: Fri, 26 May 2017 10:11:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170526081129.GA7211@noname.str.redhat.com>
References: <cover.1495536228.git.berto@igalia.com>
	<b3659d971731e5ef832399400a0f14daa580fce4.1495536228.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3659d971731e5ef832399400a0f14daa580fce4.1495536228.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow2: Make perform_cow() call
 do_perform_cow() twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>

Am 23.05.2017 um 13:22 hat Alberto Garcia geschrieben:
> Instead of calling perform_cow() twice with a different COW region
> each time, call it just once and make perform_cow() handle both
> regions.
> 
> This patch simply moves code around. The next one will do the actual
> reordering of the COW operations.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 6757875ec9..59a0ffba1a 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -414,6 +414,10 @@ static int coroutine_fn do_perform_cow(BlockDriverState *bs,
>      struct iovec iov;
>      int ret;
>  
> +    if (bytes == 0) {
> +        return 0;
> +    }
> +
>      iov.iov_len = bytes;
>      iov.iov_base = qemu_try_blockalign(bs, iov.iov_len);
>      if (iov.iov_base == NULL) {
> @@ -751,31 +755,40 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
>      return cluster_offset;
>  }
>  
> -static int perform_cow(BlockDriverState *bs, QCowL2Meta *m, Qcow2COWRegion *r)
> +static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
>  {
>      BDRVQcow2State *s = bs->opaque;
> +    Qcow2COWRegion *start = &m->cow_start;
> +    Qcow2COWRegion *end = &m->cow_end;
>      int ret;
>  
> -    if (r->nb_bytes == 0) {
> +    if (start->nb_bytes == 0 && end->nb_bytes == 0) {
>          return 0;
>      }

With this change, it can now happen that we call do_perform_cow() with
bytes == 0. Maybe it would be better for do_perform_cow() to check bytes
first so that it doesn't bdrv_co_preadv/pwritev() for 0 bytes?

Kevin
