Received: from eggs.gnu.org ([2001:4830:134:3::10]:37686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZbxQ-0003N4-Ft
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZbxP-0001JK-CX
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:23:12 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZbxP-0001IZ-5D
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:23:11 -0500
Received: by mail-wm0-x233.google.com with SMTP id c85so23797067wmi.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 03:23:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170201150553.9381-24-alex.bennee@linaro.org>
References: <20170201150553.9381-1-alex.bennee@linaro.org>
	<20170201150553.9381-24-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 11:22:49 +0000
Message-ID: <CAFEAcA9J4KgFLD5QiEjarw6HZY-T5WX4eSeSdGY6G2Y9ZAMOqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 23/25] target-arm: introduce
 ARM_CP_EXIT_PC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 1 February 2017 at 15:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Some helpers may trigger an immediate exit of the cpu_loop. If this
> happens the PC need to be rectified to ensure the restart will begin
> on the next instruction.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/cpu.h           | 3 ++-
>  target/arm/translate-a64.c | 4 ++++
>  target/arm/translate.c     | 4 ++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index d61793ca06..a3c4d07817 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1465,7 +1465,8 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpr=
egid)
>  #define ARM_CP_NZCV            (ARM_CP_SPECIAL | (3 << 8))
>  #define ARM_CP_CURRENTEL       (ARM_CP_SPECIAL | (4 << 8))
>  #define ARM_CP_DC_ZVA          (ARM_CP_SPECIAL | (5 << 8))
> -#define ARM_LAST_SPECIAL       ARM_CP_DC_ZVA
> +#define ARM_CP_EXIT_PC         (ARM_CP_SPECIAL | (6 << 8))
> +#define ARM_LAST_SPECIAL       ARM_CP_EXIT_PC

This shouldn't be a "special", because those are for
"this is a special case that is handled entirely in the translate
code", not "I need some extra behaviour on the code generated
for calling the helper functions" (which is what the
plain non-special ARM_CP flags do). Notice that all the other
"special" cases completely define the behaviour of the cp that
uses them, and the code implementing them ends the case
statement with "return", not "break".

Missing documentation comment change.

That said, I'm definitely becoming more strongly of the
opinion that longjumping out of this helper is not the
best way to implement this, so these remarks are a bit moot.

>  /* Used only as a terminator for ARMCPRegInfo lists */
>  #define ARM_CP_SENTINEL 0xffff
>  /* Mask of only the flag bits in a type field */
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 7e7131fe2f..98d4fac070 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1561,6 +1561,10 @@ static void handle_sys(DisasContext *s, uint32_t i=
nsn, bool isread,
>          tcg_rt =3D cpu_reg(s, rt);
>          gen_helper_dc_zva(cpu_env, tcg_rt);
>          return;
> +    case ARM_CP_EXIT_PC:
> +        /* The helper may exit the cpu_loop so ensure PC is correct */
> +        gen_a64_set_pc_im(s->pc);
> +        break;
>      default:
>          break;
>      }
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 24faa7c60c..e1f4a48720 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7510,6 +7510,10 @@ static int disas_coproc_insn(DisasContext *s, uint=
32_t insn)
>              gen_set_pc_im(s, s->pc);
>              s->is_jmp =3D DISAS_WFI;
>              return 0;
> +        case ARM_CP_EXIT_PC:
> +            /* The helper may exit the cpu_loop so ensure PC is correct =
*/
> +            gen_set_pc_im(s, s->pc);
> +            break;
>          default:
>              break;
>          }

thanks
-- PMM
