Received: from eggs.gnu.org ([2001:4830:134:3::10]:36930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRT0-0001zi-He
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRSu-00054L-AG
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:00:58 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:7207)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRSu-00053w-1s
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:00:52 -0400
References: <20170304185652.10675-1-f4bug@amsat.org>
	<20170304185652.10675-6-f4bug@amsat.org>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <a7c114b5-1350-d886-4e1c-08b991cf6921@imgtec.com>
Date: Mon, 13 Mar 2017 15:00:50 +0000
MIME-Version: 1.0
In-Reply-To: <20170304185652.10675-6-f4bug@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/5] target-mips: replace few LOG_DISAS()
 with trace points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org



On 04/03/2017 18:56, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  Makefile.objs            |  1 +
>  target/mips/trace-events |  5 +++++
>  target/mips/translate.c  | 25 +++++++++++--------------
>  3 files changed, 17 insertions(+), 14 deletions(-)
>  create mode 100644 target/mips/trace-events
>=20
> diff --git a/Makefile.objs b/Makefile.objs
> index e740500e2d..6167e7b17d 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -157,6 +157,7 @@ trace-events-subdirs +=3D audio
>  trace-events-subdirs +=3D net
>  trace-events-subdirs +=3D target/arm
>  trace-events-subdirs +=3D target/i386
> +trace-events-subdirs +=3D target/mips
>  trace-events-subdirs +=3D target/sparc
>  trace-events-subdirs +=3D target/s390x
>  trace-events-subdirs +=3D target/ppc
> diff --git a/target/mips/trace-events b/target/mips/trace-events
> new file mode 100644
> index 0000000000..43824089b3
> --- /dev/null
> +++ b/target/mips/trace-events
> @@ -0,0 +1,5 @@
> +# See docs/tracing.txt for syntax documentation.
> +
> +# target/mips/translate.c
> +mips_translate_c0(const char *instr, const char *rn, int reg, int sel)=
 "%s %s (reg %d sel %d)"
> +mips_translate_tr(const char *instr, int rt, int u, int sel, int h) "%=
s (reg %d u %d sel %d h %d)"
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index fc11e15a17..78b7264add 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -33,6 +33,7 @@
>  #include "sysemu/kvm.h"
>  #include "exec/semihost.h"
> =20
> +#include "target/mips/trace.h"
>  #include "trace-tcg.h"
>  #include "exec/log.h"
> =20
> @@ -4866,9 +4867,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
>      default:
>          goto cp0_unimplemented;
>      }
> -
> -    (void)rn; /* avoid a compiler warning */
> -    LOG_DISAS("mfhc0 %s (reg %d sel %d)\n", rn, reg, sel);
> +    trace_mips_translate_c0("mfhc0", rn, reg, sel);
>      return;
> =20
>  cp0_unimplemented:
> @@ -4941,8 +4940,8 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
>      default:
>          goto cp0_unimplemented;
>      }
> +    trace_mips_translate_c0("mthc0", rn, reg, sel);
> =20
> -    (void)rn; /* avoid a compiler warning */
>  cp0_unimplemented:
>      qemu_log_mask(LOG_UNIMP, "mthc0 %s (reg %d sel %d)\n", rn, reg, se=
l);
>  }
> @@ -5622,8 +5621,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
>      default:
>         goto cp0_unimplemented;
>      }
> -    (void)rn; /* avoid a compiler warning */
> -    LOG_DISAS("mfc0 %s (reg %d sel %d)\n", rn, reg, sel);
> +    trace_mips_translate_c0("mfc0", rn, reg, sel);
>      return;
> =20
>  cp0_unimplemented:
> @@ -6284,8 +6282,8 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
>      default:
>         goto cp0_unimplemented;
>      }
> -    (void)rn; /* avoid a compiler warning */
> -    LOG_DISAS("mtc0 %s (reg %d sel %d)\n", rn, reg, sel);
> +    trace_mips_translate_c0("mtc0", rn, reg, sel);
> +
>      /* For simplicity assume that all writes can cause interrupts.  */
>      if (ctx->tb->cflags & CF_USE_ICOUNT) {
>          gen_io_end();
> @@ -6923,8 +6921,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
>      default:
>          goto cp0_unimplemented;
>      }
> -    (void)rn; /* avoid a compiler warning */
> -    LOG_DISAS("dmfc0 %s (reg %d sel %d)\n", rn, reg, sel);
> +    trace_mips_translate_c0("dmfc0", rn, reg, sel);
>      return;
> =20
>  cp0_unimplemented:
> @@ -7583,8 +7580,8 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
>      default:
>          goto cp0_unimplemented;
>      }
> -    (void)rn; /* avoid a compiler warning */
> -    LOG_DISAS("dmtc0 %s (reg %d sel %d)\n", rn, reg, sel);
> +    trace_mips_translate_c0("dmtc0", rn, reg, sel);
> +
>      /* For simplicity assume that all writes can cause interrupts.  */
>      if (ctx->tb->cflags & CF_USE_ICOUNT) {
>          gen_io_end();
> @@ -7803,7 +7800,7 @@ static void gen_mftr(CPUMIPSState *env, DisasCont=
ext *ctx, int rt, int rd,
>      default:
>          goto die;
>      }
> -    LOG_DISAS("mftr (reg %d u %d sel %d h %d)\n", rt, u, sel, h);
> +    trace_mips_translate_tr("mftr", rt, u, sel, h);
>      gen_store_gpr(t0, rd);
>      tcg_temp_free(t0);
>      return;
> @@ -8008,7 +8005,7 @@ static void gen_mttr(CPUMIPSState *env, DisasCont=
ext *ctx, int rd, int rt,
>      default:
>          goto die;
>      }
> -    LOG_DISAS("mttr (reg %d u %d sel %d h %d)\n", rd, u, sel, h);
> +    trace_mips_translate_tr("mttr", rd, u, sel, h);
>      tcg_temp_free(t0);
>      return;
> =20
>=20
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
