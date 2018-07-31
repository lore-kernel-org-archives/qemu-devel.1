Received: from eggs.gnu.org ([2001:4830:134:3::10]:60513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaCZ-0006fn-Rq
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaCZ-0001XF-5G
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:20:59 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:34000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkaCZ-0001Ww-05
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:20:59 -0400
Received: by mail-ua0-x241.google.com with SMTP id r10-v6so11047358uao.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 12:20:58 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-52-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <db9f7a33-257d-45f5-0fd9-5cb26db6e1ff@linaro.org>
Date: Tue, 31 Jul 2018 15:20:52 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-52-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 51/76] target/mips: Adjust set_pc() for
 nanoMIPS
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
> From: James Hogan <james.hogan@mips.com>
> 
> ERET and ERETNC shouldn't clear MIPS_HFLAG_M16 for nanoMIPS since there
> is no ISA bit, so fix set_pc() to skip the hflags update.
> 
> Signed-off-by: James Hogan <james.hogan@mips.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/op_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 5e10286..c55a1e6 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -2428,6 +2428,10 @@ static void debug_post_eret(CPUMIPSState *env)
>  static void set_pc(CPUMIPSState *env, target_ulong error_pc)
>  {
>      env->active_tc.PC = error_pc & ~(target_ulong)1;

You don't want this for nanomips either, surely.

> +    if (env->insn_flags & ISA_NANOMIPS32) {
> +        /* Don't clear MIPS_HFLAG_M16 */
> +        return;
> +    }

Likewise re nanomips not setting M16.


r~
