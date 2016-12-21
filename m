Received: from eggs.gnu.org ([2001:4830:134:3::10]:46559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cJoHK-0006em-Ae
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 16:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cJoHJ-00044C-8o
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 16:18:26 -0500
References: <20161207150827.23791-1-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ab051ebd-bda2-e17a-ddf7-330825644f3a@redhat.com>
Date: Wed, 21 Dec 2016 16:18:17 -0500
MIME-Version: 1.0
In-Reply-To: <20161207150827.23791-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qemu-img: fix in-flight
 count for qemu-img bench
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org



On 12/07/2016 10:08 AM, Paolo Bonzini wrote:
> With aio=native (qemu-img bench -n) one or more requests can be completed
> when a new request is submitted.  This in turn can cause bench_cb to
> recurse before b->in_flight is updated.  This causes multiple I/Os
> to be submitted with the same offset and, furthermore, the blk_aio_*
> coroutines are never freed and qemu-img aborts.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qemu-img.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 6949b73..5df66fe 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3559,20 +3559,23 @@ static void bench_cb(void *opaque, int ret)
>      }
>  
>      while (b->n > b->in_flight && b->in_flight < b->nrreq) {
> +        int64_t offset = b->offset;
> +        /* blk_aio_* might look for completed I/Os and kick bench_cb
> +         * again, so make sure this operation is counted by in_flight
> +         * and b->offset is ready for the next submission.
> +         */
> +        b->in_flight++;
> +        b->offset += b->step;
> +        b->offset %= b->image_size;
>          if (b->write) {
> -            acb = blk_aio_pwritev(b->blk, b->offset, b->qiov, 0,
> -                                  bench_cb, b);
> +            acb = blk_aio_pwritev(b->blk, offset, b->qiov, 0, bench_cb, b);
>          } else {
> -            acb = blk_aio_preadv(b->blk, b->offset, b->qiov, 0,
> -                                 bench_cb, b);
> +            acb = blk_aio_preadv(b->blk, offset, b->qiov, 0, bench_cb, b);
>          }
>          if (!acb) {
>              error_report("Failed to issue request");
>              exit(EXIT_FAILURE);
>          }
> -        b->in_flight++;
> -        b->offset += b->step;
> -        b->offset %= b->image_size;
>      }
>  }
>  
> 

Reviewed-by: John Snow <jsnow@redhat.com>
