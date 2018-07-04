Received: from eggs.gnu.org ([2001:4830:134:3::10]:36166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faoR5-0004Vq-Hc
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faoR2-000528-AV
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:31:35 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:44450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faoR2-00051y-4n
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:31:32 -0400
Received: by mail-qk0-x241.google.com with SMTP id v17-v6so971341qkb.11
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 13:31:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1530732637-28606-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1530732637-28606-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <57a2af86-a882-7974-645b-048b630e9ef7@amsat.org>
Date: Wed, 4 Jul 2018 17:31:27 -0300
MIME-Version: 1.0
In-Reply-To: <1530732637-28606-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/8] target/mips: Add CP0 BadInstrX
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

Hi Aleksandar,

On 07/04/2018 04:30 PM, Aleksandar Markovic wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Add CP0 BadInstrX register. This register will be used in nanoMIPS.
> 
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/cpu.h       |  1 +
>  target/mips/machine.c   |  5 +++--
>  target/mips/translate.c | 20 +++++++++++++++++++-
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index edbb66d..8ccbc21 100644
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
> index 88699ae..0562851 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -5315,7 +5315,12 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrP));
>              rn = "BadInstrP";
>              break;
> -        default:
> +        case 3:
> +            CP0_CHECK(ctx->bi);
> +            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
> +            rn = "BadInstrX";
> +            break;
> +       default:
>              goto cp0_unimplemented;
>          }
>          break;
> @@ -6006,6 +6011,10 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
> @@ -6711,6 +6720,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrP));
>              rn = "BadInstrP";
>              break;
> +        case 3:
> +            CP0_CHECK(ctx->bi);
> +            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));

I'm unsure re-using gen_mfc0_load32() is enough, shouldn't we zero the
16 lower bits?

> +            rn = "BadInstrX";
> +            break;
>          default:
>              goto cp0_unimplemented;
>          }
> @@ -7385,6 +7399,10 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
