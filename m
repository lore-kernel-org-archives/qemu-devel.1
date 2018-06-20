Received: from eggs.gnu.org ([2001:4830:134:3::10]:35303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVgPQ-00062a-Od
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVgPN-0003vd-Fj
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:56:40 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:44692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVgPN-0003v6-9x
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:56:37 -0400
Received: by mail-ot0-x244.google.com with SMTP id w13-v6so262536ote.11
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 09:56:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1528403460-30526-3-git-send-email-gengdongjiu@huawei.com>
References: <1528403460-30526-1-git-send-email-gengdongjiu@huawei.com>
	<1528403460-30526-3-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 17:56:16 +0100
Message-ID: <CAFEAcA_k_-6LuMw_Av9sAvkBeb7OvvZnsppd=1aF6RYydOH=YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 RFC 2/2] target: arm: Add support for
 VCPU event states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: James Morse <james.morse@arm.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>

On 7 June 2018 at 21:31, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> This patch extends the qemu-kvm state sync logic with support for
> KVM_GET/SET_VCPU_EVENTS, giving access to yet missing SError exception.
> And also it can support the exception state migration.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  target/arm/cpu.h     |  5 ++++
>  target/arm/kvm64.c   | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/machine.c |  3 +++
>  3 files changed, 72 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8488273..b3d6682 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -645,6 +645,11 @@ typedef struct CPUARMState {
>      const struct arm_boot_info *boot_info;
>      /* Store GICv3CPUState to access from this struct */
>      void *gicv3state;
> +    struct {
> +        uint32_t pending;
> +        uint32_t has_esr;
> +        uint64_t esr;
> +    } serror;

What is this state? That is, what guest CPU architectural state
is it supposed to correspond to?

> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 2e28d08..5a359f4 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -695,6 +695,9 @@ const VMStateDescription vmstate_arm_cpu = {
>          VMSTATE_UINT32(env.exception.syndrome, ARMCPU),
>          VMSTATE_UINT32(env.exception.fsr, ARMCPU),
>          VMSTATE_UINT64(env.exception.vaddress, ARMCPU),
> +        VMSTATE_UINT32(env.serror.pending, ARMCPU),
> +        VMSTATE_UINT32(env.serror.has_esr, ARMCPU),
> +        VMSTATE_UINT64(env.serror.esr, ARMCPU),
>          VMSTATE_TIMER_PTR(gt_timer[GTIMER_PHYS], ARMCPU),
>          VMSTATE_TIMER_PTR(gt_timer[GTIMER_VIRT], ARMCPU),
>          {

You can't just add fields like this, as it breaks migration
compatibility. If these need to be migrated then you need a
new subsection with a suitable 'needed' function controlling
whether it is present. But we should determine first
whether this really is new guest CPU state...

thanks
-- PMM
