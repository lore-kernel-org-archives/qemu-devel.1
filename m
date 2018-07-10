Received: from eggs.gnu.org ([2001:4830:134:3::10]:57412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcxHU-00007k-Rp
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcxHR-0000kK-Li
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:22:32 -0400
Received: from mail-co1nam03on0124.outbound.protection.outlook.com
	([104.47.40.124]:59616
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcxHR-0000jl-9v
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:22:29 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 18:22:25 +0000
Message-ID: <BN7PR08MB4868AFE369CE2DD08FA57422C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-27-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-27-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 26/33] target/mips: Fix ERET/ERETNC
 behavior related to ADEL exception
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

> Subject: [PATCH v2 26/33] target/mips: Fix ERET/ERETNC behavior related t=
o ADEL exception
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> Fix ERET/ERETNC so that ADEL exception can be raised.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/op_helper.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index c55a1e6..e6749c5 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -2430,6 +2430,13 @@ static void set_pc(CPUMIPSState *env, target_ulong=
 error_pc)
>      env->active_tc.PC =3D error_pc & ~(target_ulong)1;
>      if (env->insn_flags & ISA_NANOMIPS32) {
>          /* Don't clear MIPS_HFLAG_M16 */
> +        if (error_pc & 1) {
> +            if (!(env->hflags & MIPS_HFLAG_DM)) {
> +                env->CP0_BadVAddr =3D error_pc;
> +            }
> +            env->active_tc.PC =3D error_pc;
> +            do_raise_exception(env, EXCP_AdEL, 0);
> +        }
>          return;
>      }
>      if (error_pc & 1) {
> @@ -2467,10 +2474,12 @@ void helper_eretnc(CPUMIPSState *env)
>  void helper_deret(CPUMIPSState *env)
>  {
>      debug_pre_eret(env);
> -    set_pc(env, env->CP0_DEPC);
>
>      env->hflags &=3D ~MIPS_HFLAG_DM;
>      compute_hflags(env);
> +
> +    set_pc(env, env->CP0_DEPC);
> +
>      debug_post_eret(env);
>  }
>  #endif /* !CONFIG_USER_ONLY */
> --
> 2.7.4
>
>
