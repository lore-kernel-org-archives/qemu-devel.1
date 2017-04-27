Received: from eggs.gnu.org ([2001:4830:134:3::10]:49182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3fvT-0000dA-7j
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3fvP-0007fJ-Co
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:41:27 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d3fvP-0007f4-3p
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:41:23 -0400
Received: by mail-wr0-x235.google.com with SMTP id z52so13806499wrc.2
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 02:41:22 -0700 (PDT)
References: <1493263764-18657-1-git-send-email-cota@braap.org>
	<1493263764-18657-8-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1493263764-18657-8-git-send-email-cota@braap.org>
Date: Thu, 27 Apr 2017 10:41:50 +0100
Message-ID: <878tmm89wh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 07/11] target/arm: optimize indirect
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, Pranith Kumar <bobby.prani+qemu@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Speed up indirect branches by jumping to the target if it is valid.
>
> Softmmu measurements (see later commit for user-mode results):
>
> Note: baseline (i.e. speedup == 1x) is QEMU v2.9.0.
>
> - Impact on Boot time
>
> | setup  | ARM debian jessie boot+shutdown time | stddev |
> |--------+--------------------------------------+--------|
> | v2.9.0 |                                 8.84 |   0.07 |
> | +cross |                                 8.85 |   0.03 |
> | +jr    |                                 8.83 |   0.06 |
>
> -                            NBench, arm-softmmu (debian jessie guest). Host: Intel i7-4790K @ 4.00GHz
>
>   1.3x +-+-------------------------------------------------------------------------------------------------------------+-+
>        |                                                                                                                 |
>        |   cross                                                          ####                                           |
>  1.25x +cross+jr..........................................................#++#.........................................+-+
>        |                                                        ####      #  #                                           |
>        |                                                     +++#  #      #  #                                           |
>        |                                      +++            ****  #      #  #                                           |
>   1.2x +-+...................................####............*..*..#......#..#.........................................+-+
>        |                                  ****  #            *  *  #      #  #     ####                                  |
>        |                                  *  *  #            *  *  #      #  #     #  #                                  |
>  1.15x +-+................................*..*..#............*..*..#......#..#.....#..#................................+-+
>        |                                  *  *  #            *  *  #      #  #     #  #                                  |
>        |                                  *  *  #      ####  *  *  #      #  #     #  #                                  |
>        |                                  *  *  #      #  #  *  *  #      #  #     #  #                         ####     |
>   1.1x +-+................................*..*..#......#..#..*..*..#......#..#.....#..#.........................#..#...+-+
>        |                                  *  *  #      #  #  *  *  #      #  #     #  #                         #  #     |
>        |                                  *  *  #      #  #  *  *  #      #  #     #  #                         #  #     |
>  1.05x +-+..........................####..*..*..#......#..#..*..*..#......#..#.....#..#......+++............*****..#...+-+
>        |                        *****  #  *  *  #      #  #  *  *  #  *****  #     #  #   +++ |    ****###  *   *  #     |
>        |                        *+++*  #  *  *  #      #  #  *  *  #  *+++*  #  ****  #  *****###  *  *  #  *   *  #     |
>        |     *****###  +++####  *   *  #  *  *  #  *****  #  *  *  #  *   *  #  *  *  #  * | *++#  *  *  #  *   *  #     |
>     1x +-++-+*+++*-+#++****++#++*+-+*++#+-*++*++#-+*+++*-+#++*++*++#++*+-+*++#+-*++*++#-+*+++*-+#++*++*++#++*+-+*++#+-++-+
>        |     *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
>        |     *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
>  0.95x +-+---*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###---+-+
>        ASSIGNMENT BITFIELD   FOURFP EMULATION   HUFFMAN   LU DECOMPOSITIONEURAL NNUMERIC SOSTRING SORT     hmean
>   png: http://imgur.com/eOLmZNR
>
> NB. 'cross' represents the previous commit.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>


Hmm not sure why but this doesn't cleanly apply to master.

> ---
>  target/arm/translate.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 02cad96..d46a576 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -65,6 +65,7 @@ static TCGv_i32 cpu_R[16];
>  TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
>  TCGv_i64 cpu_exclusive_addr;
>  TCGv_i64 cpu_exclusive_val;
> +static bool gen_jr;

Isn't this something that should be part of the DisasContext rather than
a global? I know we are unlikely to making the translators run
independently anytime soon but we shouldn't use globals where we can
help it.

>
>  /* FIXME:  These should be removed.  */
>  static TCGv_i32 cpu_F0s, cpu_F1s;
> @@ -221,6 +222,7 @@ static void store_reg(DisasContext *s, int reg, TCGv_i32 var)
>           */
>          tcg_gen_andi_i32(var, var, s->thumb ? ~1 : ~3);
>          s->is_jmp = DISAS_JUMP;
> +        gen_jr = true;
>      }
>      tcg_gen_mov_i32(cpu_R[reg], var);
>      tcg_temp_free_i32(var);
> @@ -893,6 +895,7 @@ static inline void gen_bx_im(DisasContext *s, uint32_t addr)
>          tcg_temp_free_i32(tmp);
>      }
>      tcg_gen_movi_i32(cpu_R[15], addr & ~1);
> +    gen_jr = true;
>  }
>
>  /* Set PC and Thumb state from var.  var is marked as dead.  */
> @@ -902,6 +905,7 @@ static inline void gen_bx(DisasContext *s, TCGv_i32 var)
>      tcg_gen_andi_i32(cpu_R[15], var, ~1);
>      tcg_gen_andi_i32(var, var, 1);
>      store_cpu_field(var, thumb);
> +    gen_jr = true;
>  }
>
>  /* Variant of store_reg which uses branch&exchange logic when storing
> @@ -12034,6 +12038,20 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
>              gen_set_pc_im(dc, dc->pc);
>              /* fall through */
>          case DISAS_JUMP:
> +            /*
> +             * gen_jr is not set on every DISAS_JUMP because for some of those
> +             * we do want to exit to the exec loop.
> +             */
> +            if (gen_jr) {
> +                TCGv addr = tcg_temp_new();
> +
> +                gen_jr = false;
> +                tcg_gen_extu_i32_tl(addr, cpu_R[15]);
> +                tcg_gen_lookup_and_goto_ptr(addr);
> +                tcg_temp_free(addr);
> +                break;
> +            }
> +            /* fall through */
>          default:
>              /* indicate that the hash table must be used to find the next TB */
>              tcg_gen_exit_tb(0);


--
Alex Bennée
