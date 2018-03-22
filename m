Received: from eggs.gnu.org ([2001:4830:134:3::10]:56569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eywHp-0006si-Ps
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eywHk-0007sG-QS
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:13:29 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eywHk-0007ru-J7
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:13:24 -0400
Received: by mail-wr0-f196.google.com with SMTP id z8so7872275wrh.7
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 02:13:24 -0700 (PDT)
References: <20180322085630.23654-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <46636940-7ebc-f424-6e92-618f9bde179c@redhat.com>
Date: Thu, 22 Mar 2018 10:13:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180322085630.23654-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] iothread: fix breakage on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>

On 22/03/2018 09:56, Peter Xu wrote:
> OOB can enable iothread for parsing even on Windows.  We need some tunes
> to enable that on Windows otherwise it'll break Windows users.  This
> patch fixes the breakage on Windows with qemu-system-ppc.exe.
> 
> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  iothread.c       | 4 ++++
>  util/aio-win32.c | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/iothread.c b/iothread.c
> index 1b3463cb00..9f52270ae1 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -31,11 +31,15 @@ typedef ObjectClass IOThreadClass;
>  #define IOTHREAD_CLASS(klass) \
>     OBJECT_CLASS_CHECK(IOThreadClass, klass, TYPE_IOTHREAD)
>  
> +#ifdef CONFIG_LINUX
>  /* Benchmark results from 2016 on NVMe SSD drives show max polling times around
>   * 16-32 microseconds yield IOPS improvements for both iodepth=1 and iodepth=32
>   * workloads.
>   */
>  #define IOTHREAD_POLL_MAX_NS_DEFAULT 32768ULL
> +#else
> +#define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
> +#endif
>  
>  static __thread IOThread *my_iothread;
>  
> diff --git a/util/aio-win32.c b/util/aio-win32.c
> index d6d5e02f00..a67b00c6ad 100644
> --- a/util/aio-win32.c
> +++ b/util/aio-win32.c
> @@ -410,5 +410,7 @@ void aio_context_setup(AioContext *ctx)
>  void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
>                                   int64_t grow, int64_t shrink, Error **errp)
>  {
> -    error_setg(errp, "AioContext polling is not implemented on Windows");
> +    if (max_ns) {
> +        error_setg(errp, "AioContext polling is not implemented on Windows");
> +    }
>  }
> 

Queued, thanks.

Paolo
