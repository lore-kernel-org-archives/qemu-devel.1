Received: from eggs.gnu.org ([2001:4830:134:3::10]:37905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNfVF-0008Lb-OD
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNfVE-0006nU-2V
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:53:49 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNfVC-0006fP-JM
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:53:47 -0500
Received: by mail-oi1-x242.google.com with SMTP id a77so13909358oii.5
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 06:53:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181105185046.2802-4-aaron@os.amperecomputing.com>
References: <20181105185046.2802-1-aaron@os.amperecomputing.com>
	<20181105185046.2802-4-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 14:53:16 +0000
Message-ID: <CAFEAcA9va2QarkMFPWNMf43u_GRDoajM-=E0dwinVEgaqRgjHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 03/12] target/arm: Swap PMU values
 before/after migrations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

On 5 November 2018 at 18:51, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
> Because of the PMU's design, many register accesses have side effects
> which are inter-related, meaning that the normal method of saving CP
> registers can result in inconsistent state. These side-effects are
> largely handled in pmu_op_start/finish functions which can be called
> before and after the state is saved/restored. By doing this and adding
> raw read/write functions for the affected registers, we avoid
> migration-related inconsistencies.
>
> Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>

> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -604,6 +604,8 @@ static int cpu_pre_save(void *opaque)
>  {
>      ARMCPU *cpu = opaque;
>
> +    pmu_op_start(&cpu->env);
> +
>      if (kvm_enabled()) {
>          if (!write_kvmstate_to_list(cpu)) {
>              /* This should never fail */
> @@ -625,6 +627,20 @@ static int cpu_pre_save(void *opaque)
>      return 0;
>  }
>
> +static int cpu_post_save(void *opaque)
> +{
> +    ARMCPU *cpu = opaque;
> +    pmu_op_finish(&cpu->env);
> +    return 0;
> +}
> +
> +static int cpu_pre_load(void *opaque)
> +{
> +    ARMCPU *cpu = opaque;
> +    pmu_op_start(&cpu->env);
> +    return 0;
> +}
> +
>  static int cpu_post_load(void *opaque, int version_id)
>  {
>      ARMCPU *cpu = opaque;
> @@ -672,6 +688,8 @@ static int cpu_post_load(void *opaque, int version_id)
>      hw_breakpoint_update_all(cpu);
>      hw_watchpoint_update_all(cpu);
>
> +    pmu_op_finish(&cpu->env);
> +
>      return 0;
>  }

This will end up calling pmu_op_start() and pmu_op_finish()
even if the guest is running KVM and we're not using the
TCG code. Is that what you intended?

thanks
-- PMM
