Received: from eggs.gnu.org ([2001:4830:134:3::10]:49423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb6yy-0000Tw-J8
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb6yu-0006d1-2e
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:43:00 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb6yt-0006ci-Sk
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:42:56 -0500
Received: by mail-wm0-x22d.google.com with SMTP id v186so14175665wmd.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 06:42:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485879782-6075-5-git-send-email-vijay.kilari@gmail.com>
References: <1485879782-6075-1-git-send-email-vijay.kilari@gmail.com>
	<1485879782-6075-5-git-send-email-vijay.kilari@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 14:42:34 +0000
Message-ID: <CAFEAcA-Kty3EynELrP88fgNoFj3njh1w6XZ5DOpNsTC7edPmng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v7 RESEND 4/5] target-arm: Add
 GICv3CPUState in CPUARMState struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vijay Kilari <vijay.kilari@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Eric Auger <eric.auger@redhat.com>, Pavel Fedin <p.fedin@samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

On 31 January 2017 at 16:23,  <vijay.kilari@gmail.com> wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>
> Add gicv3state void pointer to CPUARMState struct
> to store GICv3CPUState.
>
> In case of usecase like CPU reset, we need to reset
> GICv3CPUState of the CPU. In such scenario, this pointer
> becomes handy.
>
> This patch take care of only GICv3.
>
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> ---
>  hw/intc/arm_gicv3_kvm.c | 8 ++++++++
>  target-arm/cpu.h        | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 77af32d..f91e0ac 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -644,6 +644,14 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>
>      gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
>
> +    for (i = 0; i < s->num_cpu; i++) {
> +        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
> +        CPUARMState *env = &cpu->env;
> +
> +        /* Store GICv3CPUState in CPUARMState gicv3state pointer */
> +        env->gicv3state = (void *)&s->cpu[i];
> +    }
> +
>      /* Try to create the device via the device control API */
>      s->dev_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_ARM_VGIC_V3, false);
>      if (s->dev_fd < 0) {

Please set the CPU's pointer to the GICv3 in arm_gicv3_common_realize(),
because that's where we set the GICv3's pointer to the CPU.
(We don't want the pointer to be specific to the KVM GICv3
anyway.)

thanks
-- PMM
