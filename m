Received: from eggs.gnu.org ([2001:4830:134:3::10]:32999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHvW5-0004mJ-1D
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHvW0-0003Bk-2K
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:46:56 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43865)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gHvVz-0003AR-P1
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:46:51 -0400
References: <20181005180201.11387-1-richard.henderson@linaro.org>
	<20181005180201.11387-9-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e2f0cc3d-ef03-0d03-cef5-d53369e93122@vivier.eu>
Date: Wed, 31 Oct 2018 19:46:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181005180201.11387-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 8/8] softfloat: Specialize udiv_qrnnd for
 ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 05/10/2018 20:02, Richard Henderson wrote:
> The ISA has a 128/64-bit division instruction, though it assumes the
> low 64-bits of the numerator are 0, and so requires a bit more fixup
> than a full 128-bit division insn.
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/fpu/softfloat-macros.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
> index eafc68932b..c86687fa5e 100644
> --- a/include/fpu/softfloat-macros.h
> +++ b/include/fpu/softfloat-macros.h
> @@ -647,6 +647,22 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
>      asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>      *r = n >> 64;
>      return n;
> +#elif defined(_ARCH_PPC64)
> +    /* From Power ISA 3.0B, programming note for divdeu.  */
> +    uint64_t q1, q2, Q, r1, r2, R;
> +    asm("divdeu %0,%2,%4; divdu %1,%3,%4"
> +        : "=&r"(q1), "=r"(q2)
> +        : "r"(n1), "r"(n0), "r"(d));
> +    r1 = -(q1 * d);         /* low part of (n1<<64) - (q1 * d) */
> +    r2 = n0 - (q2 * d);
> +    Q = q1 + q2;
> +    R = r1 + r2;
> +    if (R >= d || R < r2) { /* overflow implies R > d */
> +        Q += 1;
> +        R -= d;
> +    }
> +    *r = R;
> +    return Q;
>  #else
>      uint64_t d0, d1, q0, q1, r1, r0, m;
>  
> 

This breaks qemu-s390x (and probably some others) on PPC64.

sudo chroot chroot/s390x/stretch/ apt-get update --yes
Ign:1 http://ftp.de.debian.org/debian stretch InRelease
Hit:2 http://ftp.de.debian.org/debian stretch Release
0% [Working]Illegal instruction

I didn't find any relevant information with "QEMU_STRACE=
QEMU_SINGLESTEP= QEMU_LOG=in_asm,op,unimp,int"

I will try to add some traces manually.

Thanks,
Laurent
