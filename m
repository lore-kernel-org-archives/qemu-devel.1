Received: from eggs.gnu.org ([2001:4830:134:3::10]:42035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fGp4C-0001FP-F2
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fGp47-000419-HL
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:09:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49610 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fGp47-00040v-BV
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:09:15 -0400
References: <20180510143618.23673-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <38f1b68c-08a5-dd19-26c0-5005ad6943c0@redhat.com>
Date: Thu, 10 May 2018 19:09:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180510143618.23673-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] atomic.h: Work around gcc spurious "unused
 value" warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

On 10/05/2018 16:36, Peter Maydell wrote:
> Some versions of gcc produce a spurious warning if the result of
> __atomic_compare_echange_n() is not used and the type involved
> is a signed 8 bit value:
>   error: value computed is not used [-Werror=unused-value]
> This has been seen on at least
>  gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
> 
> Work around this by using an explicit cast to void to indicate
> that we don't care about the return value.
> 
> We don't currently use our atomic_cmpxchg() macro on any signed
> 8 bit types, but the upcoming support for the Arm v8.1-Atomics
> will require it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Sending out my workaround as an actual patch. If this is OK I'll
> put in via target-arm.next as it's a dependency for the v8.1-atomics
> series.

Yes, please go ahead!

Paolo

>  include/qemu/atomic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
> index d73c9e14d7..9ed39effd3 100644
> --- a/include/qemu/atomic.h
> +++ b/include/qemu/atomic.h
> @@ -187,7 +187,7 @@
>  /* Returns the eventual value, failed or not */
>  #define atomic_cmpxchg__nocheck(ptr, old, new)    ({                    \
>      typeof_strip_qual(*ptr) _old = (old);                               \
> -    __atomic_compare_exchange_n(ptr, &_old, new, false,                 \
> +    (void)__atomic_compare_exchange_n(ptr, &_old, new, false,           \
>                                __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);      \
>      _old;                                                               \
>  })
> 
