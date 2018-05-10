Received: from eggs.gnu.org ([2001:4830:134:3::10]:37772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGn1w-0003l1-Fc
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGn1u-0000eE-02
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:58:52 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:44041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGn1t-0000e1-Q0
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:58:49 -0400
Received: by mail-qt0-x241.google.com with SMTP id d3-v6so2903788qtp.11
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 07:58:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180510143618.23673-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6bac6039-96dc-ba2c-b865-8afecbc60daa@amsat.org>
Date: Thu, 10 May 2018 11:58:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180510143618.23673-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 05/10/2018 11:36 AM, Peter Maydell wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> Sending out my workaround as an actual patch. If this is OK I'll
> put in via target-arm.next as it's a dependency for the v8.1-atomics
> series.
> 
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
