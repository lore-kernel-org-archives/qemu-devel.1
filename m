Received: from eggs.gnu.org ([2001:4830:134:3::10]:59881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcxRt-00068s-4r
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcxRq-0006XU-0c
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:33:17 -0400
Received: from mail-eopbgr700096.outbound.protection.outlook.com
	([40.107.70.96]:23232
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcxRp-0006XB-Np
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:33:13 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 18:33:09 +0000
Message-ID: <BN7PR08MB48685B014B52A2DFA5A297C0C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-32-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-32-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 31/33] gdbstub: Disable handling of
 nanoMIPS ISA bit in the MIPS gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "f4bug@amsat.org" <f4bug@amsat.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> Subject: [PATCH v2 31/33] gdbstub: Disable handling of nanoMIPS ISA bit i=
n the MIPS gdbstub
>
> From: James Hogan <james.hogan@mips.com>
>
> nanoMIPS has no ISA bit in the PC, so remove the handling of the low bit
> of the PC in the MIPS gdbstub for nanoMIPS. This prevents the PC being
> read as e.g. 0xbfc00001, and prevents writing to the PC clearing
> MIPS_HFLAG_M16.
>
> Signed-off-by: James Hogan <james.hogan@mips.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/gdbstub.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
> index 18e0e6d..559b69f 100644
> --- a/target/mips/gdbstub.c
> +++ b/target/mips/gdbstub.c
> @@ -60,7 +60,8 @@ int mips_cpu_gdb_read_register(CPUState *cs, uint8_t *m=
em_buf, int n)
>          return gdb_get_regl(mem_buf, (int32_t)env->CP0_Cause);
>      case 37:
>          return gdb_get_regl(mem_buf, env->active_tc.PC |
> -                                     !!(env->hflags & MIPS_HFLAG_M16));
> +                                     (!(env->insn_flags & ISA_NANOMIPS32=
) &&
> +                                      env->hflags & MIPS_HFLAG_M16));
>      case 72:
>          return gdb_get_regl(mem_buf, 0); /* fp */
>      case 89:
> @@ -131,10 +132,12 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8=
_t *mem_buf, int n)
>          break;
>      case 37:
>          env->active_tc.PC =3D tmp & ~(target_ulong)1;
> -        if (tmp & 1) {
> -            env->hflags |=3D MIPS_HFLAG_M16;
> -        } else {
> -            env->hflags &=3D ~(MIPS_HFLAG_M16);
> +        if (!(env->insn_flags & ISA_NANOMIPS32)) {
> +            if (tmp & 1) {
> +                env->hflags |=3D MIPS_HFLAG_M16;
> +            } else {
> +                env->hflags &=3D ~(MIPS_HFLAG_M16);
> +            }
>          }
>          break;
>      case 72: /* fp, ignored */
> --
> 2.7.4
>
>
