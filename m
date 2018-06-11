Received: from eggs.gnu.org ([2001:4830:134:3::10]:40077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fSJ8v-0000MH-8A
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fSJ8u-0000ko-CK
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:29:41 -0400
Date: Mon, 11 Jun 2018 17:29:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180611092931.GA25583@lemon.usersys.redhat.com>
References: <1528700647-58638-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528700647-58638-1-git-send-email-wangjie88@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] util/async: avoid NULL pointer dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jie Wang <wangjie88@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com, eblake@redhat.com, eric.fangyi@huawei.com, wu.wubin@huawei.com

On Mon, 06/11 15:04, Jie Wang wrote:
> if laio_init create linux_aio failed and return NULL, NULL pointer
> dereference will occur when laio_attach_aio_context dereference
> linux_aio in aio_get_linux_aio, so add assert to avoid it.
> 
> Signed-off-by: Jie Wang <wangjie88@huawei.com>
> ---
>  util/async.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/util/async.c b/util/async.c
> index 03f62787f2..7766bcd8bc 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -327,6 +327,7 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
>  {
>      if (!ctx->linux_aio) {
>          ctx->linux_aio = laio_init();
> +        assert(ctx->linux_aio);
>          laio_attach_aio_context(ctx->linux_aio, ctx);
>      }
>      return ctx->linux_aio;
> -- 

I'm afraid this is not the correct fix. If laio_init() can fail, this function
should skip laio_attach_aio_context() and return NULL, then callers should check
the return value and handle the error. E.g. Set s->use_linux_aio to false and
fall back to posix I/O, and perhaps report the error with error_report. Or even
better, call laio_init during raw_open and use error_setg(errp, ...).

assert() will simply crash the program, it is not the right way to catch errors.

Fam
