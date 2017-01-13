Received: from eggs.gnu.org ([2001:4830:134:3::10]:35911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cS1Q2-0002L9-BC
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cS1Px-00044m-8l
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:57:22 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cS1Px-00044C-1w
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:57:17 -0500
Received: by mail-wm0-f66.google.com with SMTP id r126so11506991wmr.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 04:57:16 -0800 (PST)
References: <1484311923-28637-1-git-send-email-laurent@vivier.eu>
	<1484311923-28637-6-git-send-email-laurent@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <cbfaab2a-2214-1a50-9ac1-ea461f157862@tuxfamily.org>
Date: Fri, 13 Jan 2017 13:57:08 +0100
MIME-Version: 1.0
In-Reply-To: <1484311923-28637-6-git-send-email-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] target-m68k: increment/decrement
 with SP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: rth@twiddle.net

On 13.01.2017 13:52, Laurent Vivier wrote:
> On 680x0 family only.
> 
> Address Register indirect With postincrement:
> 
> When using the stack pointer (A7) with byte size data, the register
> is incremented by two.
> 
> Address Register indirect With predecrement:
> 
> When using the stack pointer (A7) with byte size data, the register
> is decremented by two.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index cf5d8dd..727c189 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -725,7 +725,12 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
>          }
>          reg = get_areg(s, reg0);
>          tmp = tcg_temp_new();
> -        tcg_gen_subi_i32(tmp, reg, opsize_bytes(opsize));
> +        if (reg0 == 7 && opsize == OS_BYTE &&
> +            m68k_feature(s->env, M68K_FEATURE_M68000)) {
> +            tcg_gen_subi_i32(tmp, reg, 2);
> +        } else {
> +            tcg_gen_subi_i32(tmp, reg, opsize_bytes(opsize));
> +        }
>          return tmp;
>      case 5: /* Indirect displacement.  */
>          reg = get_areg(s, reg0);
> @@ -801,7 +806,12 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
>          result = gen_ldst(s, opsize, reg, val, what);
>          if (what == EA_STORE || !addrp) {
>              TCGv tmp = tcg_temp_new();
> -            tcg_gen_addi_i32(tmp, reg, opsize_bytes(opsize));
> +            if (reg0 == 7 && opsize == OS_BYTE &&
> +                m68k_feature(s->env, M68K_FEATURE_M68000)) {
> +                tcg_gen_subi_i32(tmp, reg, 2);
> +            } else {
> +                tcg_gen_addi_i32(tmp, reg, opsize_bytes(opsize));
> +            }
>              delay_set_areg(s, reg0, tmp, true);
>          }
>          return result;
> 

Reviewed-by: Thomas Huth <huth@tuxfamily.org>
