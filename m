Received: from eggs.gnu.org ([2001:4830:134:3::10]:33939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaHh-0001cN-PE
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaHd-0005ak-OM
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:26:17 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:33272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkaHd-0005aN-HW
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:26:13 -0400
Received: by mail-ua0-x241.google.com with SMTP id i4-v6so11057199uak.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 12:26:13 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-53-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <16d02724-2e7b-dfd8-9a02-050c9902ddd8@linaro.org>
Date: Tue, 31 Jul 2018 15:26:06 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-53-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 52/76] target/mips: Fix ERET/ERETNC
 behavior related to ADEL exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index c55a1e6..e6749c5 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -2430,6 +2430,13 @@ static void set_pc(CPUMIPSState *env, target_ulong error_pc)
>      env->active_tc.PC = error_pc & ~(target_ulong)1;
>      if (env->insn_flags & ISA_NANOMIPS32) {
>          /* Don't clear MIPS_HFLAG_M16 */
> +        if (error_pc & 1) {
> +            if (!(env->hflags & MIPS_HFLAG_DM)) {
> +                env->CP0_BadVAddr = error_pc;
> +            }
> +            env->active_tc.PC = error_pc;
> +            do_raise_exception(env, EXCP_AdEL, 0);
> +        }

Isn't this taken care of by decode_nanomips_opc?
What do you gain by checking twice?


r~
