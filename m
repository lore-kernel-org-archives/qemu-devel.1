Received: from eggs.gnu.org ([2001:4830:134:3::10]:47700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4S8O-0005dx-1u
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4S8N-0008QK-1R
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:42:16 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:49769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e4S8M-0008Pq-Qr
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:42:14 -0400
Received: by mail-wm0-x233.google.com with SMTP id b189so3946080wmd.4
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 06:42:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506737310-21880-5-git-send-email-alindsay@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
	<1506737310-21880-5-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2017 14:41:52 +0100
Message-ID: <CAFEAcA94pxKuPZZgKOMXyW8xteHTBWz-JM6mGOX-ot6OeBt-tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/13] target/arm: Mask PMU register writes
 based on PMCR_EL0.N
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 30 September 2017 at 03:08, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> This is in preparation for enabling counters other than PMCCNTR
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ecf8c55..54070a3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -30,11 +30,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>                                 hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
>                                 target_ulong *page_size_ptr, uint32_t *fsr,
>                                 ARMMMUFaultInfo *fi);
> -
> -/* Definitions for the PMCCNTR and PMCR registers */
> -#define PMCRD   0x8
> -#define PMCRC   0x4
> -#define PMCRE   0x1
>  #endif
>
>  static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
> @@ -876,6 +871,17 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
>      REGINFO_SENTINEL
>  };
>
> +/* Definitions for the PMU registers */
> +#define PMCRN   0xf800

We usually name this kind of whole-field mask value something like PMCRN_MASK.

(We also have a FIELD() macro in hw/registerfields.h for defining
mask/length/shift constants; though it can be a bit verbose in
the length of the names it uses, so I don't insist on its use
if you don't like the results. I'm on the fence myself about it.)

> +#define PMCRN_SHIFT 11
> +#define PMCRD   0x8
> +#define PMCRC   0x4
> +#define PMCRE   0x1
> +
> +#define PMU_NUM_COUNTERS(env) ((env->cp15.c9_pmcr & PMCRN) >> PMCRN_SHIFT)
> +/* Bits allowed to be set/cleared for PMCNTEN* and PMINTEN* */
> +#define PMU_COUNTER_MASK(env) ((1 << 31) | ((1 << PMU_NUM_COUNTERS(env)) - 1))
> +
>  static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
>                                     bool isread)
>  {
> @@ -1060,14 +1066,14 @@ static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void pmcntenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                              uint64_t value)
>  {
> -    value &= (1 << 31);
> +    value &= (PMU_COUNTER_MASK(env) | (1 << 31));

PMU_COUNTER_MASK always contains bit 31, so why do we manually OR it in
again here?

>      env->cp15.c9_pmcnten |= value;
>  }
>
>  static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value)
>  {
> -    value &= (1 << 31);
> +    value &= (PMU_COUNTER_MASK(env) | (1 << 31));
>      env->cp15.c9_pmcnten &= ~value;
>  }
>
> @@ -1115,14 +1121,14 @@ static void pmintenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value)
>  {
>      /* We have no event counters so only the C bit can be changed */
> -    value &= (1 << 31);
> +    value &= PMU_COUNTER_MASK(env);
>      env->cp15.c9_pminten |= value;
>  }
>
>  static void pmintenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value)
>  {
> -    value &= (1 << 31);
> +    value &= PMU_COUNTER_MASK(env);
>      env->cp15.c9_pminten &= ~value;
>  }
>
> --
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.\nQualcomm Technologies, Inc. is a member of the\nCode Aurora Forum, a Linux Foundation Collaborative Project.

Shouldn't these '\n' in your sig be literal line breaks? :-)

thanks
-- PMM
