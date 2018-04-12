Received: from eggs.gnu.org ([2001:4830:134:3::10]:42958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6f1O-0002BL-VL
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6f1O-0002Ag-46
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:24:26 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:39587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6f1N-0002AJ-Ue
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:24:26 -0400
Received: by mail-ot0-x243.google.com with SMTP id a14-v6so6675549otf.6
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 09:24:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-7-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-7-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 17:24:04 +0100
Message-ID: <CAFEAcA_hsh+virQsKPdDGOQXaBYiTX+G+gJ8=Qi0gsC_==zO5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 06/22] target/arm: Mask PMU register
 writes based on PMCR_EL0.N
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 16 March 2018 at 20:31, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> This is in preparation for enabling counters other than PMCCNTR
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 6480b80..5d5c738 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -52,11 +52,6 @@ typedef struct V8M_SAttributes {
>  static void v8m_security_lookup(CPUARMState *env, uint32_t address,
>                                  MMUAccessType access_type, ARMMMUIdx mmu_idx,
>                                  V8M_SAttributes *sattrs);
> -
> -/* Definitions for the PMCCNTR and PMCR registers */
> -#define PMCRD   0x8
> -#define PMCRC   0x4
> -#define PMCRE   0x1
>  #endif
>
>  static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
> @@ -906,6 +901,17 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
>      REGINFO_SENTINEL
>  };
>
> +/* Definitions for the PMU registers */
> +#define PMCRN_MASK  0xf800
> +#define PMCRN_SHIFT 11
> +#define PMCRD   0x8
> +#define PMCRC   0x4
> +#define PMCRE   0x1
> +
> +#define PMU_NUM_COUNTERS(env) ((env->cp15.c9_pmcr & PMCRN_MASK) >> PMCRN_SHIFT)
> +/* Bits allowed to be set/cleared for PMCNTEN* and PMINTEN* */
> +#define PMU_COUNTER_MASK(env) ((1 << 31) | ((1 << PMU_NUM_COUNTERS(env)) - 1))

These would be better as inline functions I think.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
