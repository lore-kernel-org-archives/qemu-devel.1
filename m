Received: from eggs.gnu.org ([2001:4830:134:3::10]:33499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eroWy-0003Gz-C2
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eroWx-0005N6-56
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:31:40 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eroWw-0005MY-UQ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:31:39 -0500
Received: by mail-oi0-x242.google.com with SMTP id x10so7578581oig.2
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 09:31:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <94eef4a24e618d73f9f23a88dd270123d48954d4.1520010339.git.alistair.francis@xilinx.com>
References: <cover.1520010339.git.alistair.francis@xilinx.com>
	<94eef4a24e618d73f9f23a88dd270123d48954d4.1520010339.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 17:31:17 +0000
Message-ID: <CAFEAcA-P9R-4epwwx-ccPrkJxJDRZ9G-FErnLDEdD8PsDH3uSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/2] target/arm: Add a cluster size
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On 2 March 2018 at 17:06, Alistair Francis <alistair.francis@xilinx.com> wrote:

Subject should say "core count" rather than "cluster size" ?

> The cortex A53 TRM specifices that bits 24 and 25 of the L2CTLR register

"specifies"

> specify the number of cores present and not the number of processors. To

"the number of cores in the processor, not the total number of cores
in the system".

> report this correctly on machines with multiple CPU clusters (ARM's
> big.LITTLE or Xilinx's ZynqMP) we need to allow the machine to overwrite
> this value. To do this let's add an optional property.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>
>  target/arm/cpu.h   |  5 +++++
>  target/arm/cpu.c   |  1 +
>  target/arm/cpu64.c | 11 +++++++++--
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8dd6b788df..3fa8fdad21 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -745,6 +745,11 @@ struct ARMCPU {
>      /* Uniprocessor system with MP extensions */
>      bool mp_is_up;
>
> +    /* Specify the number of cores in this CPU cluster. Used for the L2CTLR
> +     * register.
> +     */
> +    int32_t core_count;
> +
>      /* The instance init functions for implementation-specific subclasses
>       * set these fields to specify the implementation-dependent values of
>       * various constant registers and reset values of non-constant
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 6b77aaa445..7a17ba1418 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1765,6 +1765,7 @@ static Property arm_cpu_properties[] = {
>      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
>                          mp_affinity, ARM64_AFFINITY_INVALID),
>      DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
> +    DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
>      DEFINE_PROP_END_OF_LIST()
>  };
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 4228713b19..5e5ae44aeb 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -42,8 +42,15 @@ static inline void unset_feature(CPUARMState *env, int feature)
>  #ifndef CONFIG_USER_ONLY
>  static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> -    /* Number of processors is in [25:24]; otherwise we RAZ */
> -    return (smp_cpus - 1) << 24;
> +    ARMCPU *cpu = arm_env_get_cpu(env);
> +
> +    /* Number of cores is in [25:24]; otherwise we RAZ */
> +    if (cpu->core_count == -1) {
> +        /* No core_count specified, default to smp_cpus. */
> +        return (smp_cpus - 1) << 24;
> +    } else {
> +        return (cpu->core_count - 1) << 24;
> +    }
>  }
>  #endif

I think having arm_cpu_realizefn do
    if (cpu->core_count == -1) {
        cpu->core_count = smp_cpus;
    }

would be neater than doing that check when the register is read.

thanks
-- PMM
