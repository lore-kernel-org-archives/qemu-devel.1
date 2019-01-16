Received: from eggs.gnu.org ([209.51.188.92]:37497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjtVH-0006PN-O2
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjtVF-00067i-Py
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:17:43 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gjtVE-000621-0u
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:17:40 -0500
Received: by mail-pg1-x541.google.com with SMTP id t13so3427948pgr.11
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 14:17:30 -0800 (PST)
References: <20190116202349.29272-1-alex.bennee@linaro.org>
	<20190116202349.29272-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1bef2aae-06dc-5062-4ce6-8e2e9adefb46@linaro.org>
Date: Thu, 17 Jan 2019 09:17:21 +1100
MIME-Version: 1.0
In-Reply-To: <20190116202349.29272-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/7] softfloat: fallback to __int128
 maths for s390x and others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, cohuck@redhat.com, "open list:S390" <qemu-s390x@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 1/17/19 7:23 AM, Alex Bennée wrote:
> Apparently some versions of clang can't handle inline assembly with
> __int128 parameters, especially on s390. Instead of hand-coding the
> s390 divide provide a generic fallback for anything that provides
> __int128 capable maths.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Thomas Huth <thuth@redhat.com>
> ---
>  include/fpu/softfloat-macros.h | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
> index b1d772e6d4..1a43609eef 100644
> --- a/include/fpu/softfloat-macros.h
> +++ b/include/fpu/softfloat-macros.h
> @@ -641,12 +641,6 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
>      uint64_t q;
>      asm("divq %4" : "=a"(q), "=d"(*r) : "0"(n0), "1"(n1), "rm"(d));
>      return q;
> -#elif defined(__s390x__)
> -    /* Need to use a TImode type to get an even register pair for DLGR.  */
> -    unsigned __int128 n = (unsigned __int128)n1 << 64 | n0;
> -    asm("dlgr %0, %1" : "+r"(n) : "r"(d));
> -    *r = n >> 64;
> -    return n;
>  #elif defined(_ARCH_PPC64) && defined(_ARCH_PWR7)
>      /* From Power ISA 2.06, programming note for divdeu.  */
>      uint64_t q1, q2, Q, r1, r2, R;
> @@ -663,6 +657,10 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
>      }
>      *r = R;
>      return Q;
> +#elif defined(CONFIG_INT128)
> +    unsigned __int128 n = (unsigned __int128)n1 << 64 | n0;
> +    *r = n % d;
> +    return n / d;
>  #else

I thought that we'd shown that, at least at present, no compiler is taking
advantage of hardware insns for this, and is promoting this to a full 128-bit
divide.  And further that the version using 64-bit arithmetic was competitive
with the hardware insn.

I'd rather not include this hunk for now.


r~
