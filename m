Received: from eggs.gnu.org ([2001:4830:134:3::10]:49567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cX65s-0004pk-Gt
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 07:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cX65r-0005FX-Cc
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 07:57:32 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:32949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cX65r-0005Ei-5W
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 07:57:31 -0500
Received: by mail-it0-x241.google.com with SMTP id e137so8211817itc.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 04:57:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170127081510.11805-1-rth@twiddle.net>
References: <20170127081510.11805-1-rth@twiddle.net>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 27 Jan 2017 13:57:08 +0100
Message-ID: <CACXAS8CbChA8EXVwEHCj4d0FvYVOSRrcCz2AoS7Ar9uZ_f-8kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] target/sparc: Restore ldstub of odd asis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Russo <mike@papersolve.com>, Bug 1622547 <1622547@bugs.launchpad.net>
Cc: qemu-devel <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>

On Fri, Jan 27, 2017 at 9:15 AM, Richard Henderson <rth@twiddle.net> wrote:
> Fixes the booting of ss20 roms.

Mike, can you please test this fix?

> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Initially Reported-by: Michael Russo <mike@papersolve.com>

> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/sparc/translate.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 655060c..aa6734d 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -2448,8 +2448,31 @@ static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
>          gen_ldstub(dc, dst, addr, da.mem_idx);
>          break;
>      default:
> -        /* ??? Should be DAE_invalid_asi.  */
> -        gen_exception(dc, TT_DATA_ACCESS);
> +        /* ??? In theory, this should be raise DAE_invalid_asi.
> +           But the SS-20 roms do ldstuba [%l0] #ASI_M_CTL, %o1.  */
> +        if (parallel_cpus) {
> +            gen_helper_exit_atomic(cpu_env);
> +        } else {
> +            TCGv_i32 r_asi = tcg_const_i32(da.asi);
> +            TCGv_i32 r_mop = tcg_const_i32(MO_UB);
> +            TCGv_i64 s64, t64;
> +
> +            save_state(dc);
> +            t64 = tcg_temp_new_i64();
> +            gen_helper_ld_asi(t64, cpu_env, addr, r_asi, r_mop);
> +
> +            s64 = tcg_const_i64(0xff);
> +            gen_helper_st_asi(cpu_env, addr, s64, r_asi, r_mop);
> +            tcg_temp_free_i64(s64);
> +            tcg_temp_free_i32(r_mop);
> +            tcg_temp_free_i32(r_asi);
> +
> +            tcg_gen_trunc_i64_tl(dst, t64);
> +            tcg_temp_free_i64(t64);
> +
> +            /* End the TB.  */
> +            dc->npc = DYNAMIC_PC;
> +        }
>          break;
>      }
>  }
> --
> 2.9.3
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
