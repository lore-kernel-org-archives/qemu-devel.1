Received: from eggs.gnu.org ([2001:4830:134:3::10]:46236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eyvaO-0006S8-Nk
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eyvaN-00067W-Qr
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:28:36 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:35154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1eyvaN-00066t-MJ
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:28:35 -0400
Received: by mail-oi0-x232.google.com with SMTP id x20-v6so6392518oie.2
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 01:28:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180322051938.GG32362@xz-mi>
References: <CABLmASFYSu4zQ_35WJLJ6izNGdyn-JuLTzgVm_Bxc3MOkkGo6w@mail.gmail.com>
	<fc09dac9-edbb-cd35-d02a-8db797879363@redhat.com>
	<CABLmASEF+e-h-nKunLd6QrnKaCAiR0d=GJZq9tN+CrvZh5iL7A@mail.gmail.com>
	<035198fa-b9e1-6084-d9c2-4d344e7058d7@redhat.com>
	<CABLmASFEhaKB1Hh91p+RM+TX+zTTDuNixWy=16rUC+GC_0KKtg@mail.gmail.com>
	<397a5759-de49-33a1-300a-67e8b7022678@redhat.com>
	<CABLmASHkjz=UDbHMRRtJKhu1bF28NGTzRjTo-GKbCd6dp-6qQQ@mail.gmail.com>
	<84d2ded7-fdd5-0367-ad5d-b0443c4a945a@redhat.com>
	<CABLmASFvQED-tsDGCgmw3LYx_CkLeKTGoQ_oU9qLHpGu=a=-hg@mail.gmail.com>
	<ed9c25bd-e5be-bde1-2447-775c3bfc93ad@redhat.com>
	<20180322051938.GG32362@xz-mi>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 22 Mar 2018 09:28:34 +0100
Message-ID: <CABLmASEOqo3cixnksUNg9kiHrA+NdLkE9+RcYTnK0BM+CjhVig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Bug AioContext polling is not implemented on
 Windows with qemu-system-ppc.exe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

> Hi, Howard,
>
> Thanks for reporting the problem.  Could you try applying below patch
> to your rc0 tree and rebuild QEMU, to see whether it fixes your problem?
>
> -----------------------------
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
> -----------------------------
>
> Thanks,
>
> --
> Peter Xu

Hi Peter,

Thanks, that patch does indeed fix the problem.

Best,
Howard
