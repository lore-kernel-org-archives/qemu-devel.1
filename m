Received: from eggs.gnu.org ([209.51.188.92]:47772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjY9n-00086x-Ts
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjY9n-0002NY-2T
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:30:07 -0500
References: <20190108170655.29766-1-vsementsov@virtuozzo.com>
	<20190108170655.29766-5-vsementsov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bda00283-197d-4b1b-7be0-633a0410f87d@redhat.com>
Date: Wed, 16 Jan 2019 00:29:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190108170655.29766-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/9] qcow2-threads:
 qcow2_co_do_compress: protect queuing by mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, berto@igalia.com, den@openvz.org

On 08/01/19 18:06, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-threads.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
> index 20b2616529..156e0667be 100644
> --- a/block/qcow2-threads.c
> +++ b/block/qcow2-threads.c
> @@ -158,15 +158,19 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
>          .func = func,
>      };
>  
> +    qemu_co_mutex_lock(&s->lock);
>      while (s->nb_compress_threads >= MAX_COMPRESS_THREADS) {
> -        qemu_co_queue_wait(&s->compress_wait_queue, NULL);
> +        qemu_co_queue_wait(&s->compress_wait_queue, &s->lock);
>      }
> -
>      s->nb_compress_threads++;
> +    qemu_co_mutex_unlock(&s->lock);
> +
>      thread_pool_submit_co(pool, qcow2_compress_pool_func, &arg);
> -    s->nb_compress_threads--;
>  
> +    qemu_co_mutex_lock(&s->lock);
> +    s->nb_compress_threads--;
>      qemu_co_queue_next(&s->compress_wait_queue);
> +    qemu_co_mutex_unlock(&s->lock);
>  
>      return arg.ret;
>  }
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

but, some information would be nice to have in the commit message.

Paolo
