Received: from eggs.gnu.org ([2001:4830:134:3::10]:38957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dmOSN-0003zr-7v
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 14:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dmOSM-0004gi-Br
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 14:08:15 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170824155849.30799-1-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <34d6f244-4dd7-1701-30b8-bb9cdc089681@twiddle.net>
Date: Mon, 28 Aug 2017 11:08:04 -0700
MIME-Version: 1.0
In-Reply-To: <20170824155849.30799-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 PATCH] tcg/softmmu: Increase size of TLB
 caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, "open list:Overall" <qemu-devel@nongnu.org>, "open list:AArch64 target" <qemu-arm@nongnu.org>

On 08/24/2017 08:58 AM, Pranith Kumar wrote:
> | TLB bits\vTLB entires |             8 |            16  |            32 |
> |                     8 | 952.94(+0.0%) | 929.99(+2.4%)  | 919.02(+3.6%) |
> |                    10 | 898.92(+5.6%) | 886.13(+7.0%)  | 887.03(+6.9%) |
> |                    12 | 878.56(+7.8%) | 873.53(+8.3%)* | 875.34(+8.1%) |

Thanks for collecting this.


> @@ -89,7 +89,7 @@ typedef uint64_t target_ulong;
>   * of tlb_table inside env (which is non-trivial but not huge).
>   */
>  #define CPU_TLB_BITS                                             \
> -    MIN(8,                                                       \
> +    MIN(CPU_TLB_BITS_MAX,                                        \
>          TCG_TARGET_TLB_DISPLACEMENT_BITS - CPU_TLB_ENTRY_BITS -  \
>          (NB_MMU_MODES <= 1 ? 0 :                                 \
>           NB_MMU_MODES <= 2 ? 1 :                                 \
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index 55a46ac825..f428e09c98 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -15,6 +15,7 @@
>  
>  #define TCG_TARGET_INSN_UNIT_SIZE  4
>  #define TCG_TARGET_TLB_DISPLACEMENT_BITS 24
> +#define CPU_TLB_BITS_MAX 12

I'd rather the definition in tcg-target.h reflect the actual maximum and limit
that to what we want (12) within cpu-defs.h.  So, here maybe

#define TCG_TARGET_TLB_MAX_INDEX_BITS  32

etc.


r~
