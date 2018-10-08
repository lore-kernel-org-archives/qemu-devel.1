Received: from eggs.gnu.org ([2001:4830:134:3::10]:45660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9V1F-0005tG-8r
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9UrG-0000Ca-8G
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:41:59 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9UrF-0000C1-Tt
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:41:58 -0400
Received: by mail-ot1-x343.google.com with SMTP id w67so19428205ota.7
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 05:41:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538579266-8389-10-git-send-email-edgar.iglesias@gmail.com>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-10-git-send-email-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 13:41:36 +0100
Message-ID: <CAFEAcA88T=VWXq5aSY2srgbo8PF7tLFJn-28nNpt3=ZGh5xM1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 09/12] target-arm: powerctl: Enable HVC
 when starting CPUs to EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 3 October 2018 at 16:07, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> When QEMU provides the equivalent of the EL3 firmware, we
> need to enable HVCs in scr_el3 when turning on CPUs that
> target EL2.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/arm/arm-powerctl.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
> index ce55eeb..54f2974 100644
> --- a/target/arm/arm-powerctl.c
> +++ b/target/arm/arm-powerctl.c
> @@ -63,6 +63,7 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
>      struct CpuOnInfo *info = (struct CpuOnInfo *) data.host_ptr;
>
>      /* Initialize the cpu we are turning on */
> +    qemu_log("CPU%d reset\n", target_cpu_state->cpu_index);

qemu_log logging should always be masked to a particular
log kind (either via qemu_log_mask() or by explicit check on
the log level). If this was accidentally left-in debug, you could
just drop it :-)

>      cpu_reset(target_cpu_state);
>      target_cpu_state->halted = 0;
>
> @@ -103,6 +104,16 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
>      } else {
>          /* Processor is not in secure mode */
>          target_cpu->env.cp15.scr_el3 |= SCR_NS;
> +
> +        /*
> +         * If QEMU is providing the equivalent of EL3 firmware, then we need
> +         * to make sure a CPU targeting EL2 comes out of reset with a
> +         * functional HVC insn.
> +         */
> +        if (arm_feature(&target_cpu->env, ARM_FEATURE_EL3)
> +            && info->target_el == 2) {
> +            target_cpu->env.cp15.scr_el3 |= SCR_HCE;
> +        }
>      }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
This is definitely required for PSCI and I think it makes sense
in other cases that end up in this powerctl code with EL3 set.

thanks
-- PMM
