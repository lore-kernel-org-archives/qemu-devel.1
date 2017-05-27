Received: from eggs.gnu.org ([2001:4830:134:3::10]:60304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEemC-000663-GY
	for qemu-devel@nongnu.org; Sat, 27 May 2017 12:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEem9-0006Xq-BT
	for qemu-devel@nongnu.org; Sat, 27 May 2017 12:41:16 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEem9-0006Ww-6P
	for qemu-devel@nongnu.org; Sat, 27 May 2017 12:41:13 -0400
Received: by mail-oi0-x244.google.com with SMTP id w10so6090864oif.1
	for <qemu-devel@nongnu.org>; Sat, 27 May 2017 09:41:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170526211638.32301-1-rth@twiddle.net>
	<20170526211638.32301-17-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b5d119ec-b354-374a-f61b-284c81c313d5@amsat.org>
Date: Sat, 27 May 2017 13:41:10 -0300
MIME-Version: 1.0
In-Reply-To: <20170526211638.32301-17-rth@twiddle.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 16/26] tcg/arm: Clarify tcg_out_bx for
 arm4 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 05/26/2017 06:16 PM, Richard Henderson wrote:
> In theory this would re-enable usage of QEMU on an armv4 host.
> Whether this is worthwhile is debatable -- we've been unconditionally
> issuing the armv5t BX instruction in the prologue since 2011 without
> complaint.  Possibly we should simply require an armv6 host.
 >

I remember having some issue 2 years ago trying to run on a ARM926EJ-S 
but the gcc/newlib revisions were good candidates to give problem so I 
didn't go further. Few NAS still run on ARMv4 cpu (some StrongARM).
Anyway on boards running ARMv4 cpu, problems are more likely to come 
from available memory to run an OS and QEMU rather than the TCG codebase.

> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tcg/arm/tcg-target.inc.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index e75a6d4..590c57d 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -329,11 +329,6 @@ static const uint8_t tcg_cond_to_arm_cond[] = {
>      [TCG_COND_GTU] = COND_HI,
>  };
>
> -static inline void tcg_out_bx(TCGContext *s, int cond, int rn)
> -{
> -    tcg_out32(s, (cond << 28) | 0x012fff10 | rn);
> -}
> -
>  static inline void tcg_out_b(TCGContext *s, int cond, int32_t offset)
>  {
>      tcg_out32(s, (cond << 28) | 0x0a000000 |
> @@ -402,6 +397,18 @@ static inline void tcg_out_mov_reg(TCGContext *s, int cond, int rd, int rm)
>      }
>  }
>
> +static inline void tcg_out_bx(TCGContext *s, int cond, TCGReg rn)
> +{
> +    /* Unless the C portion of QEMU is compiled as thumb, we don't
> +       actually need true BX semantics; merely a branch to an address
> +       held in a register.  */
> +    if (use_armv5t_instructions) {
> +        tcg_out32(s, (cond << 28) | 0x012fff10 | rn);
> +    } else {
> +        tcg_out_mov_reg(s, cond, TCG_REG_PC, rn);
> +    }
> +}
> +
>  static inline void tcg_out_dat_imm(TCGContext *s,
>                  int cond, int opc, int rd, int rn, int im)
>  {
> @@ -977,7 +984,7 @@ static inline void tcg_out_st8(TCGContext *s, int cond,
>   * with the code buffer limited to 16MB we wouldn't need the long case.
>   * But we also use it for the tail-call to the qemu_ld/st helpers, which does.
>   */
> -static inline void tcg_out_goto(TCGContext *s, int cond, tcg_insn_unit *addr)
> +static void tcg_out_goto(TCGContext *s, int cond, tcg_insn_unit *addr)
>  {
>      intptr_t addri = (intptr_t)addr;
>      ptrdiff_t disp = tcg_pcrel_diff(s, addr);
> @@ -987,15 +994,9 @@ static inline void tcg_out_goto(TCGContext *s, int cond, tcg_insn_unit *addr)
>          return;
>      }
>
> +    assert(use_armv5t_instructions || (addri & 1) == 0);
>      tcg_out_movi32(s, cond, TCG_REG_TMP, addri);
> -    if (use_armv5t_instructions) {
> -        tcg_out_bx(s, cond, TCG_REG_TMP);
> -    } else {
> -        if (addri & 1) {
> -            tcg_abort();
> -        }
> -        tcg_out_mov_reg(s, cond, TCG_REG_PC, TCG_REG_TMP);
> -    }
> +    tcg_out_bx(s, cond, TCG_REG_TMP);
>  }
>
>  /* The call case is mostly used for helpers - so it's not unreasonable
>
