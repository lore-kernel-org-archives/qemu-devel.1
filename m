Received: from eggs.gnu.org ([2001:4830:134:3::10]:58882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fhuqr-0007WC-G6
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fhuqm-0004fj-Hj
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:47:33 -0400
Received: from mail-by2nam01on0095.outbound.protection.outlook.com
	([104.47.34.95]:18688
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fhuqm-0004f3-4G
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:47:28 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 24 Jul 2018 10:47:23 +0000
Message-ID: <BN7PR08MB48680F2F471E97F7E4F84FACC6550@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1532004912-13899-25-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-25-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 24/40] target/mips: Add updating
 BadInstr and BadInstrP registers for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Stefan Markovic <stefan.markovic@rt-rk.com>
> Sent: Thursday, July 19, 2018 2:54 PM
> Subject: [PATCH v3 24/40] target/mips: Add updating BadInstr and BadInstr=
P registers for nanoMIPS
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> Updating BadInstr and BadInstrP registers was addded for nanoMIPS.
> BadInstr and BadInstrP support for pre-nanoMIPS remains
> unimplemented.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/helper.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index e215af9..5299f21 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -683,7 +683,28 @@ static void set_hflags_for_handler (CPUMIPSState *en=
v)
>  static inline void set_badinstr_registers(CPUMIPSState *env)
>  {
>      if (env->hflags & MIPS_HFLAG_M16) {
> -        /* TODO: add BadInstr support for microMIPS */
> +        uint32_t instr;
> +        if (!(env->insn_flags & ISA_NANOMIPS32)) {
> +            /* TODO: add BadInstr support for pre-nanoMIPS */
> +             return;
> +        }
> +        if (env->CP0_Config3 & (1 << CP0C3_BI)) {
> +            instr =3D (cpu_lduw_code(env, env->active_tc.PC)) << 16;
> +            if ((env->insn_flags & ISA_NANOMIPS32) &&
> +                ((instr & 0x10000000) =3D=3D 0)) {
> +                instr |=3D cpu_lduw_code(env, env->active_tc.PC + 2);
> +            }
> +            env->CP0_BadInstr =3D instr;
> +        }
> +        if ((env->CP0_Config3 & (1 << CP0C3_BP)) &&
> +            (env->hflags & MIPS_HFLAG_BMASK)) {
> +            if (!(env->hflags & MIPS_HFLAG_B16)) {
> +                env->CP0_BadInstrP =3D cpu_ldl_code(env, env->active_tc.=
PC - 4);
> +            } else {
> +                env->CP0_BadInstrP =3D
> +                    (cpu_lduw_code(env, env->active_tc.PC - 2)) << 16;
> +            }
> +        }
>          return;
>      }
>      if (env->CP0_Config3 & (1 << CP0C3_BI)) {
> --
> 2.7.4

This new block should be placed before MIPS_HFLAG_M16 check. The whole patc=
h should be merged with the succeeding patch, as noted in other reviews.

Aleksandar
