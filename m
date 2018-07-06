Received: from eggs.gnu.org ([2001:4830:134:3::10]:46755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbTzs-0003RY-2D
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbTzo-0008Ah-54
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:54:16 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:38808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbTzn-00089X-Vb
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:54:12 -0400
Received: by mail-qt0-x243.google.com with SMTP id c5-v6so10481509qth.5
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 09:54:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1530877732-26557-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1530877732-26557-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a7ea5d94-36a5-b0f8-8b37-c435f580119e@amsat.org>
Date: Fri, 6 Jul 2018 13:54:07 -0300
MIME-Version: 1.0
In-Reply-To: <1530877732-26557-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 5/8] target/mips: Add CP0 BadInstrX
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/06/2018 08:48 AM, Aleksandar Markovic wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Add CP0 BadInstrX register. This register will be used in nanoMIPS.
> 
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/mips/cpu.h       |  1 +
>  target/mips/machine.c   |  5 +++--
>  target/mips/translate.c | 30 +++++++++++++++++++++++++++++-
>  3 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 100b5f4..4cd918b 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -323,6 +323,7 @@ struct CPUMIPSState {
>      target_ulong CP0_BadVAddr;
>      uint32_t CP0_BadInstr;
>      uint32_t CP0_BadInstrP;
> +    uint32_t CP0_BadInstrX;
>      int32_t CP0_Count;
>      target_ulong CP0_EntryHi;
>  #define CP0EnHi_EHINV 10
> diff --git a/target/mips/machine.c b/target/mips/machine.c
> index 20100d5..5ba78ac 100644
> --- a/target/mips/machine.c
> +++ b/target/mips/machine.c
> @@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb = {
>  
>  const VMStateDescription vmstate_mips_cpu = {
>      .name = "cpu",
> -    .version_id = 10,
> -    .minimum_version_id = 10,
> +    .version_id = 11,
> +    .minimum_version_id = 11,
>      .post_load = cpu_post_load,
>      .fields = (VMStateField[]) {
>          /* Active TC */
> @@ -266,6 +266,7 @@ const VMStateDescription vmstate_mips_cpu = {
>          VMSTATE_UINTTL(env.CP0_BadVAddr, MIPSCPU),
>          VMSTATE_UINT32(env.CP0_BadInstr, MIPSCPU),
>          VMSTATE_UINT32(env.CP0_BadInstrP, MIPSCPU),
> +        VMSTATE_UINT32(env.CP0_BadInstrX, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Count, MIPSCPU),
>          VMSTATE_UINTTL(env.CP0_EntryHi, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Compare, MIPSCPU),
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 051dda5..00154d2 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -5315,7 +5315,17 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrP));
>              rn = "BadInstrP";
>              break;
> -        default:
> +        case 3:
> +            CP0_CHECK(ctx->bi);
> +            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
> +#if defined(TARGET_MIPS64)
> +            tcg_gen_andi_i64(arg, arg, ~0xffff);
> +#else
> +            tcg_gen_andi_i32(arg, arg, ~0xffff);
> +#endif

Please use tcg_gen_andi_tl() instead, it does exactly that.

> +            rn = "BadInstrX";
> +            break;
> +       default:
>              goto cp0_unimplemented;
>          }
>          break;
> @@ -6006,6 +6016,10 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              /* ignored */
>              rn = "BadInstrP";
>              break;
> +        case 3:
> +            /* ignored */
> +            rn = "BadInstrX";
> +            break;
>          default:
>              goto cp0_unimplemented;
>          }
> @@ -6711,6 +6725,16 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrP));
>              rn = "BadInstrP";
>              break;
> +        case 3:
> +            CP0_CHECK(ctx->bi);
> +            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
> +#if defined(TARGET_MIPS64)
> +            tcg_gen_andi_i64(arg, arg, ~0xffff);
> +#else
> +            tcg_gen_andi_i32(arg, arg, ~0xffff);
> +#endif

Ditto.

> +            rn = "BadInstrX";
> +            break;
>          default:
>              goto cp0_unimplemented;
>          }
> @@ -7385,6 +7409,10 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              /* ignored */
>              rn = "BadInstrP";
>              break;
> +        case 3:
> +            /* ignored */
> +            rn = "BadInstrX";
> +            break;
>          default:
>              goto cp0_unimplemented;
>          }
> 
