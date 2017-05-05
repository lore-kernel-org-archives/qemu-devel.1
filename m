Received: from eggs.gnu.org ([2001:4830:134:3::10]:48467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6aLP-0007xw-9I
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6aLO-0008Cq-Ew
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:20:15 -0400
Date: Fri, 5 May 2017 18:19:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170505101955.GG21435@lemon.lan>
References: <20170505100255.11145-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505100255.11145-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] aio: add missing aio_notify() to
 aio_enable_external()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 05/05 11:02, Stefan Hajnoczi wrote:
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 406e323..b3d6f76 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -454,8 +454,14 @@ static inline void aio_disable_external(AioContext *ctx)
>   */
>  static inline void aio_enable_external(AioContext *ctx)
>  {
> -    assert(ctx->external_disable_cnt > 0);
> -    atomic_dec(&ctx->external_disable_cnt);
> +    int old;
> +
> +    old = atomic_dec_fetch(&ctx->external_disable_cnt);

Did you mean atomic_fetch_dec? atomic_dec_fetch is new, not old.

> +    assert(old > 0);
> +    if (old == 1) {
> +        /* Kick event loop so it re-arms file descriptors */
> +        aio_notify(ctx);
> +    }
>  }
>  
>  /**
> -- 
> 2.9.3
> 
