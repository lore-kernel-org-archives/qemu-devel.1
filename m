Received: from eggs.gnu.org ([2001:4830:134:3::10]:56646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcxFo-0007aT-NQ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcxFl-0008NQ-H7
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:20:48 -0400
Received: from mail-co1nam03on0133.outbound.protection.outlook.com
	([104.47.40.133]:24803
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcxFl-0008Ml-52
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:20:45 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 18:20:39 +0000
Message-ID: <BN7PR08MB4868AD936FC8891A61F38D97C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-26-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-26-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 25/33] target/mips: Adjust set_pc() for
 nanoMIPS
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

> Subject: [PATCH v2 25/33] target/mips: Adjust set_pc() for nanoMIPS
>
> From: James Hogan <james.hogan@mips.com>
>
> ERET and ERETNC shouldn't clear MIPS_HFLAG_M16 for nanoMIPS since there
> is no ISA bit, so fix set_pc() to skip the hflags update.
>
> Signed-off-by: James Hogan <james.hogan@mips.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/op_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 5e10286..c55a1e6 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -2428,6 +2428,10 @@ static void debug_post_eret(CPUMIPSState *env)
>  static void set_pc(CPUMIPSState *env, target_ulong error_pc)
>  {
>      env->active_tc.PC =3D error_pc & ~(target_ulong)1;
> +    if (env->insn_flags & ISA_NANOMIPS32) {
> +        /* Don't clear MIPS_HFLAG_M16 */
> +        return;
> +    }
>      if (error_pc & 1) {
>          env->hflags |=3D MIPS_HFLAG_M16;
>      } else {
> --
> 2.7.4
>
>
