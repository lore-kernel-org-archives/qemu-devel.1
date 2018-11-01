Received: from eggs.gnu.org ([2001:4830:134:3::10]:59235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gILrM-00024p-Or
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 18:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gILly-0007ih-4S
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 18:49:08 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:48759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gILlx-0007iC-Pi
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 18:49:06 -0400
References: <20181101202617.6437-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <44220f80-a8a3-78a3-180b-ef7fd7699d3b@vivier.eu>
Date: Thu, 1 Nov 2018 23:49:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181101202617.6437-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] softfloat: Don't execute divdeu without
 power7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 01/11/2018 21:26, Richard Henderson wrote:
> The divdeu instruction was added to ISA 2.06 (Power7).
> Exclude this block from older cpus.
> 
> Fixes: 27ae5109a2ba (softfloat: Specialize udiv_qrnnd for ppc64)
> Reported-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/fpu/softfloat-macros.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
> index c86687fa5e..b1d772e6d4 100644
> --- a/include/fpu/softfloat-macros.h
> +++ b/include/fpu/softfloat-macros.h
> @@ -647,8 +647,8 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
>      asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>      *r = n >> 64;
>      return n;
> -#elif defined(_ARCH_PPC64)
> -    /* From Power ISA 3.0B, programming note for divdeu.  */
> +#elif defined(_ARCH_PPC64) && defined(_ARCH_PWR7)
> +    /* From Power ISA 2.06, programming note for divdeu.  */
>      uint64_t q1, q2, Q, r1, r2, R;
>      asm("divdeu %0,%2,%4; divdu %1,%3,%4"
>          : "=&r"(q1), "=r"(q2)
> 

Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
