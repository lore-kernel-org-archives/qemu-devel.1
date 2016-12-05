Received: from eggs.gnu.org ([2001:4830:134:3::10]:35977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxLb-0006bH-9Y
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxLa-0005FM-BV
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:46:39 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-4-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <37c840a9-b9c1-4308-fbff-2e22c8f57d09@twiddle.net>
Date: Mon, 5 Dec 2016 09:46:34 -0800
MIME-Version: 1.0
In-Reply-To: <1480937130-24561-4-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/13] target-ppc: implement lxvl
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 12/05/2016 03:25 AM, Nikunj A Dadhania wrote:
> lxvl: Load VSX Vector with Length
> 
> Little/Big-endian Storage:
> +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
> |“T”|“h”|“i”|“s”|“ ”|“i”|“s”|“ ”|“a”|“ ”|“T”|“E”|“S”|“T”|FF|FF|
> +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
> 
> Loading 14 bytes results in:
> 
> Vector (8-bit elements) in BE:
> +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
> |“T”|“h”|“i”|“s”|“ ”|“i”|“s”|“ ”|“a”|“ ”|“T”|“E”|“S”|“T”|00|00|
> +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
> 
> Vector (8-bit elements) in LE:
> +--+--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
> |00|00|“T”|“S”|“E”|“T”|“ ”|“a”|“ ”|“s”|“i”|“ ”|“s”|“i”|"h"|"T"|
> +--+--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target-ppc/helper.h                 |  1 +
>  target-ppc/mem_helper.c             | 25 +++++++++++++++++++++++++
>  target-ppc/translate/vsx-impl.inc.c | 27 +++++++++++++++++++++++++++
>  target-ppc/translate/vsx-ops.inc.c  |  1 +
>  4 files changed, 54 insertions(+)
> 
> diff --git a/target-ppc/helper.h b/target-ppc/helper.h
> index bc39efb..d9ccafd 100644
> --- a/target-ppc/helper.h
> +++ b/target-ppc/helper.h
> @@ -317,6 +317,7 @@ DEF_HELPER_3(lvewx, void, env, avr, tl)
>  DEF_HELPER_3(stvebx, void, env, avr, tl)
>  DEF_HELPER_3(stvehx, void, env, avr, tl)
>  DEF_HELPER_3(stvewx, void, env, avr, tl)
> +DEF_HELPER_4(lxvl, void, env, tl, tl, tl)
>  DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
>  DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
>  DEF_HELPER_4(vsum4sbs, void, env, avr, avr, avr)
> diff --git a/target-ppc/mem_helper.c b/target-ppc/mem_helper.c
> index 1ab8a6e..0a8ff54 100644
> --- a/target-ppc/mem_helper.c
> +++ b/target-ppc/mem_helper.c
> @@ -24,6 +24,7 @@
>  
>  #include "helper_regs.h"
>  #include "exec/cpu_ldst.h"
> +#include "internal.h"
>  
>  //#define DEBUG_OP
>  
> @@ -284,6 +285,30 @@ STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
>  #undef I
>  #undef LVE
>  
> +void helper_lxvl(CPUPPCState *env, target_ulong addr,
> +                 target_ulong xt_num, target_ulong rb)
> +{
> +    ppc_vsr_t xt;
> +
> +    getVSR(xt_num, &xt, env);
> +    if (unlikely((rb & 0xFF) == 0)) {
> +        xt.s128 = int128_make128(0, 0);
> +    } else {
> +        target_ulong end = ((rb & 0xFF) * 8) - 1;
> +        if (msr_le) {
> +            xt.u64[HI_IDX] = bswap64(cpu_ldq_data_ra(env, addr, GETPC()));
> +            addr = addr_add(env, addr, 8);
> +            xt.u64[LO_IDX] = bswap64(cpu_ldq_data_ra(env, addr, GETPC()));

hi/lo assignment reversed for le.

> +        } else {
> +            xt.u64[HI_IDX] = cpu_ldq_data_ra(env, addr, GETPC());
> +            addr = addr_add(env, addr, 8);
> +            xt.u64[LO_IDX] = cpu_ldq_data_ra(env, addr, GETPC());
> +        }
> +        xt.s128 = int128_and(xt.s128, mask_u128(0, end));

I don't think mask_u128 does the right thing for end > 127.
I think you need a check here.


r~
