Received: from eggs.gnu.org ([2001:4830:134:3::10]:37427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEDnC-0005IE-8d
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEDnB-0008SO-By
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:20:14 -0500
Date: Tue, 6 Dec 2016 12:20:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161206112004.GC4990@noname.str.redhat.com>
References: <20161206110836.21687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161206110836.21687-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix in-flight count for qemu-img
 bench
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

Am 06.12.2016 um 12:08 hat Paolo Bonzini geschrieben:
> With aio=native (qemu-img bench -n) one or more requests can be completed
> when a new request is submitted.  This in turn can cause bench_cb to
> recurse before b->in_flight is updated.  The blk_aio_pwritev coroutines
> are never freed, and qemu-img aborts.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qemu-img.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 6949b73..607dbe5 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3559,6 +3559,9 @@ static void bench_cb(void *opaque, int ret)
>      }
>  
>      while (b->n > b->in_flight && b->in_flight < b->nrreq) {
> +        b->in_flight++;
> +        b->offset += b->step;
> +        b->offset %= b->image_size;
>          if (b->write) {
>              acb = blk_aio_pwritev(b->blk, b->offset, b->qiov, 0,
>                                    bench_cb, b);

This implicitly adds b->step to the initial offset because the write
request now uses the already updated offset. We should probably save the
old value and use that for the request.

Also, maybe add a short comment to the code (rather than just to the
commit message) that explains why the update has to be first?

Kevin
