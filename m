Received: from eggs.gnu.org ([2001:4830:134:3::10]:45704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSOqF-0007bU-0S
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSOqD-0008W4-Uv
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:34:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1528720922-20799-1-git-send-email-wangjie88@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cea8a777-f79b-5781-b49c-2e49f2980de3@amsat.org>
Date: Mon, 11 Jun 2018 12:34:35 -0300
MIME-Version: 1.0
In-Reply-To: <1528720922-20799-1-git-send-email-wangjie88@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] util/async: avoid NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jie Wang <wangjie88@huawei.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, eric.fangyi@huawei.com, stefanha@redhat.com, wu.wubin@huawei.com

Hi Jie,

On 06/11/2018 09:42 AM, Jie Wang wrote:
> if laio_init create linux_aio failed and return NULL, NULL pointer
> dereference will occur when laio_attach_aio_context dereference
> linux_aio in aio_get_linux_aio. Let's avoid it and report error.
> 
> Signed-off-by: Jie Wang <wangjie88@huawei.com>
> ---
>  block/file-posix.c | 19 +++++++++++++++++--
>  util/async.c       |  5 ++++-
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 513d371bb1..653017d7a5 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1665,6 +1665,11 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
>  #ifdef CONFIG_LINUX_AIO
>          } else if (s->use_linux_aio) {
>              LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
> +            if (!aio) {
> +                s->use_linux_aio = false;
> +                error_report("Failed to get linux aio");
> +                return -EIO;
> +            }
>              assert(qiov->size == bytes);
>              return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
>  #endif
> @@ -1695,7 +1700,12 @@ static void raw_aio_plug(BlockDriverState *bs)
>      BDRVRawState *s = bs->opaque;
>      if (s->use_linux_aio) {
>          LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
> -        laio_io_plug(bs, aio);
> +        if (aio) {
> +            laio_io_plug(bs, aio);
> +        } else {
> +            s->use_linux_aio = false;
> +            error_report("Failed to get linux aio");
> +        }

Can you use the same form you used in raw_co_prw() ?

           if (!aio) {
               s->use_linux_aio = false;
               error_report("Failed to get linux aio");
               return;
           }
           laio_io_plug(bs, aio);

This is safer in case someone are more code bellow in the future.

>      }
>  #endif
>  }
> @@ -1706,7 +1716,12 @@ static void raw_aio_unplug(BlockDriverState *bs)
>      BDRVRawState *s = bs->opaque;
>      if (s->use_linux_aio) {
>          LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
> -        laio_io_unplug(bs, aio);
> +        if (aio) {
> +            laio_io_unplug(bs, aio);
> +        } else {
> +            s->use_linux_aio = false;
> +            error_report("Failed to get linux aio");
> +        }

Ditto.

>      }
>  #endif
>  }
> diff --git a/util/async.c b/util/async.c
> index 03f62787f2..08d71340f8 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -327,8 +327,11 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
>  {
>      if (!ctx->linux_aio) {
>          ctx->linux_aio = laio_init();
> -        laio_attach_aio_context(ctx->linux_aio, ctx);
> +        if (ctx->linux_aio) {
> +            laio_attach_aio_context(ctx->linux_aio, ctx);
> +        }
>      }
> +
>      return ctx->linux_aio;
>  }
>  #endif
> 
