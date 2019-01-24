Received: from eggs.gnu.org ([209.51.188.92]:43765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gmfwr-0003tG-0H
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gmfwo-0001CC-Nn
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:25:40 -0500
Received: from mail-eopbgr740120.outbound.protection.outlook.com
	([40.107.74.120]:35072
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1gmfwl-000161-Cj
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:25:37 -0500
From: Aleksandar Rikalo <arikalo@wavecomp.com>
Date: Thu, 24 Jan 2019 14:25:30 +0000
Message-ID: <DM5PR22MB16586A2CD6DC152E71DE76ECD29A0@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1548242160-16039-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1548242160-16039-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548242160-16039-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/9] target/mips: Extend gen_scwp()
 functionality to support EVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Wednesday, January 23, 2019 12:15 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH v2 5/9] target/mips: Extend gen_scwp() functionality to s=
upport EVA
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Extend gen_scwp() functionality to support EVA by adding an
> additional argument, modify internals of the function to handle
> new functionality, and accordingly change its invocations.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>

gen_scwp() and gen_sc() should be consistent (with this patch, they both su=
pport EVA, but their parameters are organized differently). But, since this=
 inconsistency does not effect the end result, and if you intend to do a si=
milar change to gen_sc(), I support this patch:

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index b362b03..aaf7dff 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -3714,7 +3714,7 @@ static void gen_st_cond (DisasContext *ctx, uint32_=
t opc, int rt,
>  }
>
>  static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
> -                    uint32_t reg1, uint32_t reg2)
> +                    uint32_t reg1, uint32_t reg2, bool eva)
>  {
>      TCGv taddr =3D tcg_temp_local_new();
>      TCGv lladdr =3D tcg_temp_local_new();
> @@ -3742,7 +3742,7 @@ static void gen_scwp(DisasContext *ctx, uint32_t ba=
se, int16_t offset,
>
>      tcg_gen_ld_i64(llval, cpu_env, offsetof(CPUMIPSState, llval_wp));
>      tcg_gen_atomic_cmpxchg_i64(val, taddr, llval, tval,
> -                               ctx->mem_idx, MO_64);
> +                               eva ? MIPS_HFLAG_UM : ctx->mem_idx, MO_64=
);
>      if (reg1 !=3D 0) {
>          tcg_gen_movi_tl(cpu_gpr[reg1], 1);
>      }
> @@ -21550,7 +21550,8 @@ static int decode_nanomips_32_48_opc(CPUMIPSState=
 *env, DisasContext *ctx)
>                          break;
>                      case NM_SCWP:
>                          check_xnp(ctx);
> -                        gen_scwp(ctx, rs, 0, rt, extract32(ctx->opcode, =
3, 5));
> +                        gen_scwp(ctx, rs, 0, rt, extract32(ctx->opcode, =
3, 5),
> +                                 false);
>                          break;
>                      }
>                      break;
> @@ -21654,7 +21655,8 @@ static int decode_nanomips_32_48_opc(CPUMIPSState=
 *env, DisasContext *ctx)
>                          check_xnp(ctx);
>                          check_eva(ctx);
>                          check_cp0_enabled(ctx);
> -                        gen_scwp(ctx, rs, 0, rt, extract32(ctx->opcode, =
3, 5));
> +                        gen_scwp(ctx, rs, 0, rt, extract32(ctx->opcode, =
3, 5),
> +                                 true);
>                          break;
>                      default:
>                          generate_exception_end(ctx, EXCP_RI);
> --
> 2.7.4
>
