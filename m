Received: from eggs.gnu.org ([2001:4830:134:3::10]:47913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhdoQ-00068m-PT
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhdoP-0000RM-So
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:35:54 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:40973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fhdoP-0000R2-CJ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:35:53 -0400
Received: by mail-pl0-x243.google.com with SMTP id w8-v6so446736ply.8
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 09:35:53 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-26-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2372b0c5-8cd3-5e94-47c3-a368e1eb5938@linaro.org>
Date: Mon, 23 Jul 2018 09:35:48 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-26-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 25/40] target/mips: Add updating CP0
 BadInstrX register for nanoMIPs only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index 5299f21..9535131 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -695,6 +695,12 @@ static inline void set_badinstr_registers(CPUMIPSState *env)
>                  instr |= cpu_lduw_code(env, env->active_tc.PC + 2);
>              }
>              env->CP0_BadInstr = instr;
> +
> +            if ((env->insn_flags & ISA_NANOMIPS32) &&
> +                ((instr & 0xFC000000) == 0x60000000)) {
> +                instr = cpu_lduw_code(env, env->active_tc.PC + 4) << 16;
> +                env->CP0_BadInstrX = instr;
> +            }

The nanomips condition has been checked just above.
This patch should probably be merged with 24/40.


r~
