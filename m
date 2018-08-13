Received: from eggs.gnu.org ([2001:4830:134:3::10]:43309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpE4D-00060w-T9
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpE4A-0007nu-QQ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:43:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpE4A-0007na-K4
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:43:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so9145932wma.1
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 07:43:30 -0700 (PDT)
References: <20180813022006.7216-1-mreitz@redhat.com>
	<20180813022006.7216-10-mreitz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <400a8b57-a930-2eee-a4a0-bf5a0733db1a@redhat.com>
Date: Mon, 13 Aug 2018 16:43:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180813022006.7216-10-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 09/17] mirror: Lock AioContext
 in mirror_co_perform()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 13/08/2018 04:19, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Locking AioContext should not be needed anywhere here.  mirror_run is
called via aio_co_enter or aio_co_wake, so the lock is actually already
taken every time you call aio_context_acquire.

It was needed only because AIO callbacks do *not* take the lock, but
it's not needed anymore since the conversion to coroutines.

Paolo

>  block/mirror.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 85b08086cc..6330269156 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -196,7 +196,6 @@ static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret)
>  {
>      MirrorBlockJob *s = op->s;
>  
> -    aio_context_acquire(blk_get_aio_context(s->common.blk));
>      if (ret < 0) {
>          BlockErrorAction action;
>  
> @@ -207,14 +206,12 @@ static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret)
>          }
>      }
>      mirror_iteration_done(op, ret);
> -    aio_context_release(blk_get_aio_context(s->common.blk));
>  }
>  
>  static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
>  {
>      MirrorBlockJob *s = op->s;
>  
> -    aio_context_acquire(blk_get_aio_context(s->common.blk));
>      if (ret < 0) {
>          BlockErrorAction action;
>  
> @@ -230,7 +227,6 @@ static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
>                               op->qiov.size, &op->qiov, 0);
>          mirror_write_complete(op, ret);
>      }
> -    aio_context_release(blk_get_aio_context(s->common.blk));
>  }
>  
>  /* Clip bytes relative to offset to not exceed end-of-file */
> @@ -387,12 +383,16 @@ static void coroutine_fn mirror_co_perform(void *opaque)
>  {
>      MirrorOp *op = opaque;
>      MirrorBlockJob *s = op->s;
> +    AioContext *aio_context;
>      int ret;
>  
> +    aio_context = blk_get_aio_context(s->common.blk);
> +    aio_context_acquire(aio_context);
> +
>      switch (op->mirror_method) {
>      case MIRROR_METHOD_COPY:
>          mirror_co_read(opaque);
> -        return;
> +        goto done;
>      case MIRROR_METHOD_ZERO:
>          ret = mirror_co_zero(s, op->offset, op->bytes);
>          break;
> @@ -404,6 +404,9 @@ static void coroutine_fn mirror_co_perform(void *opaque)
>      }
>  
>      mirror_write_complete(op, ret);
> +
> +done:
> +    aio_context_release(aio_context);
>  }
>  
>  /* If mirror_method == MIRROR_METHOD_COPY, *offset and *bytes will be
> 
