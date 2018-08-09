Received: from eggs.gnu.org ([2001:4830:134:3::10]:45020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnibT-0004pP-KE
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnibO-0005Dm-US
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:55:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fnibO-0005DV-G3
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:55:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id h9-v6so4774391wro.3
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 03:55:34 -0700 (PDT)
References: <20180809034033.10579-1-richard.henderson@linaro.org>
	<20180809034033.10579-11-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180809034033.10579-11-richard.henderson@linaro.org>
Date: Thu, 09 Aug 2018 11:55:32 +0100
Message-ID: <87in4jq063.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/11] target/arm: Dump SVE state if enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-stable@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Also fold the FPCR/FPSR state onto the same line as PSTATE,
> and mention but do not dump disabled FPU state.
>
> Cc: qemu-stable@nongnu.org (3.0.1)
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 95 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 83 insertions(+), 12 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 358f169c75..b29dc49c4f 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -152,8 +152,7 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
>      } else {
>          ns_status =3D "";
>      }
> -
> -    cpu_fprintf(f, "\nPSTATE=3D%08x %c%c%c%c %sEL%d%c\n",
> +    cpu_fprintf(f, "PSTATE=3D%08x %c%c%c%c %sEL%d%c",
>                  psr,
>                  psr & PSTATE_N ? 'N' : '-',
>                  psr & PSTATE_Z ? 'Z' : '-',
> @@ -163,17 +162,89 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
>                  el,
>                  psr & PSTATE_SP ? 'h' : 't');
>
> -    if (flags & CPU_DUMP_FPU) {
> -        int numvfpregs =3D 32;
> -        for (i =3D 0; i < numvfpregs; i++) {
> -            uint64_t *q =3D aa64_vfp_qreg(env, i);
> -            uint64_t vlo =3D q[0];
> -            uint64_t vhi =3D q[1];
> -            cpu_fprintf(f, "q%02d=3D%016" PRIx64 ":%016" PRIx64 "%c",
> -                        i, vhi, vlo, (i & 1 ? '\n' : ' '));
> +    if (!(flags & CPU_DUMP_FPU)) {
> +        cpu_fprintf(f, "\n");
> +        return;
> +    }
> +    cpu_fprintf(f, "     FPCR=3D%08x FPSR=3D%08x\n",
> +                vfp_get_fpcr(env), vfp_get_fpsr(env));
> +
> +    if (arm_feature(env, ARM_FEATURE_SVE)) {
> +        int j, zcr_len =3D env->vfp.zcr_el[1] & 0xf; /* fix for system m=
ode */
> +
> +        for (i =3D 0; i <=3D FFR_PRED_NUM; i++) {
> +            bool eol;
> +            if (i =3D=3D FFR_PRED_NUM) {
> +                cpu_fprintf(f, "FFR=3D");
> +                /* It's last, so end the line.  */
> +                eol =3D true;
> +            } else {
> +                cpu_fprintf(f, "P%02d=3D", i);
> +                switch (zcr_len) {
> +                case 0:
> +                    eol =3D i % 8 =3D=3D 7;
> +                    break;
> +                case 1:
> +                    eol =3D i % 6 =3D=3D 5;
> +                    break;
> +                case 2:
> +                case 3:
> +                    eol =3D i % 3 =3D=3D 2;
> +                    break;
> +                default:
> +                    /* More than one quadword per predicate.  */
> +                    eol =3D true;
> +                    break;
> +                }
> +            }
> +            for (j =3D zcr_len / 4; j >=3D 0; j--) {
> +                int digits;
> +                if (j * 4 + 4 <=3D zcr_len + 1) {
> +                    digits =3D 16;
> +                } else {
> +                    digits =3D (zcr_len % 4 + 1) * 4;
> +                }
> +                cpu_fprintf(f, "%0*" PRIx64 "%s", digits,
> +                            env->vfp.pregs[i].p[j],
> +                            j ? ":" : eol ? "\n" : " ");
> +            }
> +        }
> +
> +        for (i =3D 0; i < 32; i++) {
> +            if (zcr_len =3D=3D 0) {
> +                cpu_fprintf(f, "Z%02d=3D%016" PRIx64 ":%016" PRIx64 "%s",
> +                            i, env->vfp.zregs[i].d[1],
> +                            env->vfp.zregs[i].d[0], i & 1 ? "\n" : " ");
> +            } else if (zcr_len =3D=3D 1) {
> +                cpu_fprintf(f, "Z%02d=3D%016" PRIx64 ":%016" PRIx64
> +                            ":%016" PRIx64 ":%016" PRIx64 "\n",
> +                            i, env->vfp.zregs[i].d[3], env->vfp.zregs[i]=
.d[2],
> +                            env->vfp.zregs[i].d[1], env->vfp.zregs[i].d[=
0]);
> +            } else {
> +                for (j =3D zcr_len; j >=3D 0; j--) {
> +                    bool odd =3D (zcr_len - j) % 2 !=3D 0;
> +                    if (j =3D=3D zcr_len) {
> +                        cpu_fprintf(f, "Z%02d[%x-%x]=3D", i, j, j - 1);
> +                    } else if (!odd) {
> +                        if (j > 0) {
> +                            cpu_fprintf(f, "   [%x-%x]=3D", j, j - 1);
> +                        } else {
> +                            cpu_fprintf(f, "     [%x]=3D", j);
> +                        }
> +                    }
> +                    cpu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%s",
> +                                env->vfp.zregs[i].d[j * 2 + 1],
> +                                env->vfp.zregs[i].d[j * 2],
> +                                odd || j =3D=3D 0 ? "\n" : ":");
> +                }
> +            }
> +        }
> +    } else {
> +        for (i =3D 0; i < 32; i++) {
> +            uint64_t *q =3D aa64_vfp_qreg(env, i);
> +            cpu_fprintf(f, "Q%02d=3D%016" PRIx64 ":%016" PRIx64 "%s",
> +                        i, q[1], q[0], (i & 1 ? "\n" : " "));
>          }
> -        cpu_fprintf(f, "FPCR: %08x  FPSR: %08x\n",
> -                    vfp_get_fpcr(env), vfp_get_fpsr(env));
>      }
>  }


--
Alex Benn=C3=A9e
