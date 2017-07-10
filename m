Received: from eggs.gnu.org ([2001:4830:134:3::10]:42058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUbJg-0008Ro-Tq
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUbJf-0002XG-KN
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:13:44 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUbJf-0002WU-Ac
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:13:43 -0400
Received: by mail-wr0-x22e.google.com with SMTP id c11so145072721wrc.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 09:13:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170710154749.13624-3-alex.bennee@linaro.org>
References: <20170710154749.13624-1-alex.bennee@linaro.org>
	<20170710154749.13624-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 17:13:21 +0100
Message-ID: <CAFEAcA8OjCS9=UJ6NV2_PgT7zciOmcnvrzpTY6FL55D8x965aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/6] target/arm/translate.c: make
 DISAS_UPDATE match declared semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 10 July 2017 at 16:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> DISAS_UPDATE should be used when the wider CPU state other than just
> the PC has been updated and we should therefor exit the TCG runtime
> and return to the main execution loop rather assuming DISAS_JUMP would
> do that.
>
> As some DISAS_UPDATE users may update the PC dynamically via a helper
> we also push the updating to the PC to hhe call sites which set
> ->is_jmp to DISAS_UPDATE.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/translate.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 0862f9e4aa..f9c4aee1b6 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -4430,6 +4430,7 @@ static void gen_msr_banked(DisasContext *s, int r, =
int sysm, int rn)
>      tcg_temp_free_i32(tcg_tgtmode);
>      tcg_temp_free_i32(tcg_regno);
>      tcg_temp_free_i32(tcg_reg);
> +    gen_set_pc_im(s, s->pc);
>      s->is_jmp =3D DISAS_UPDATE;
>  }
>
> @@ -4452,6 +4453,7 @@ static void gen_mrs_banked(DisasContext *s, int r, =
int sysm, int rn)
>      tcg_temp_free_i32(tcg_tgtmode);
>      tcg_temp_free_i32(tcg_regno);
>      store_reg(s, rn, tcg_reg);
> +    gen_set_pc_im(s, s->pc);
>      s->is_jmp =3D DISAS_UPDATE;
>  }
>
> @@ -8058,6 +8060,7 @@ static void gen_srs(DisasContext *s,
>          tcg_temp_free_i32(tmp);
>      }
>      tcg_temp_free_i32(addr);
> +    gen_set_pc_im(s, s->pc);
>      s->is_jmp =3D DISAS_UPDATE;
>  }
>
> @@ -8146,6 +8149,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
>              /* setend */
>              if (((insn >> 9) & 1) !=3D !!(s->be_data =3D=3D MO_BE)) {
>                  gen_helper_setend(cpu_env);
> +                gen_set_pc_im(s, s->pc);
>                  s->is_jmp =3D DISAS_UPDATE;
>              }
>              return;
> @@ -11619,6 +11623,7 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
>                  ARCH(6);
>                  if (((insn >> 3) & 1) !=3D !!(s->be_data =3D=3D MO_BE)) =
{
>                      gen_helper_setend(cpu_env);
> +                    gen_set_pc_im(s, s->pc);
>                      s->is_jmp =3D DISAS_UPDATE;
>                  }
>                  break;
> @@ -12076,7 +12081,6 @@ void gen_intermediate_code(CPUARMState *env, Tran=
slationBlock *tb)
>              break;
>          case DISAS_NEXT:
>          case DISAS_UPDATE:
> -            gen_set_pc_im(dc, dc->pc);
>              /* fall through */
>          default:
>              /* FIXME: Single stepping a WFI insn will not halt the CPU. =
*/
> @@ -12095,12 +12099,11 @@ void gen_intermediate_code(CPUARMState *env, Tr=
anslationBlock *tb)
>          case DISAS_NEXT:
>              gen_goto_tb(dc, 1, dc->pc);
>              break;
> -        case DISAS_UPDATE:
> -            gen_set_pc_im(dc, dc->pc);
> -            /* fall through */
>          case DISAS_JUMP:
>              gen_goto_ptr();
>              break;
> +        case DISAS_UPDATE:
> +            /* fall through */
>          default:
>              /* indicate that the hash table must be used to find the nex=
t TB */
>              tcg_gen_exit_tb(0);

I'm not a great fan of this, because we've taken five cases that
all want the same behaviour for ending the TB, and we've made
them handle part of it themselves rather than just letting
the end-of-TB code do it for them.

Also, now the "synchronize the CPU state which we only write at the
end of the TB" code is split up -- we write the PC in the places
that set s->is_jmp, but we write the condexec bits in the end
of TB common code.

thanks
-- PMM
