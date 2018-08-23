Received: from eggs.gnu.org ([2001:4830:134:3::10]:37621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fssqb-0007Hv-Hh
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fssqa-0001FH-9u
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:52:37 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fssqa-0001Ek-0a
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:52:36 -0400
Received: by mail-oi0-x243.google.com with SMTP id 13-v6so10470782ois.1
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:52:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1535039100-11248-2-git-send-email-gengdongjiu@huawei.com>
References: <1535039100-11248-1-git-send-email-gengdongjiu@huawei.com>
	<1535039100-11248-2-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 17:52:14 +0100
Message-ID: <CAFEAcA9DJ_GMkq1fGUjXJDu9GUM0cd6Pjm1HsXpm5rQ5n78Zew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 2/2] target: arm: Add support for VCPU
 event states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Linuxarm <linuxarm@huawei.com>

On 23 August 2018 at 16:45, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> This patch extends the qemu-kvm state sync logic with support for
> KVM_GET/SET_VCPU_EVENTS, giving access to yet missing SError exception.
> And also it can support the exception state migration.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

Did you forget to send a cover letter for this patchset?
I didn't see one. Our tooling prefers cover letters for
any patchset with more than one patch in it.

> ---
> Change since v5:
> address Peter's comments:
> 1. Move the "struct serror" before the "end_reset_fields" in CPUARMState
> 2. Remove ARM_FEATURE_RAS_EXT and add a variable have_inject_serror_esr
> 3. Use the variable have_inject_serror_esr to track whether the kernel has state we need to migrate
> 4. Remove printf() in kvm_arch_put_registers()
> 5. ras_needed/vmstate_ras to serror_needed/vmstate_serror
> 6. Check to use "return env.serror.pending != 0" instead of "arm_feature(env, ARM_FEATURE_RAS_EXT)" in the ras_needed()
>
> Change since v4:
> 1. Rebase the code to latest
>
> Change since v3:
> 1. Add a new new subsection with a suitable 'ras_needed' function
>    controlling whether it is present
> 2. Add a ARM_FEATURE_RAS feature bit for CPUARMState
> ---
>  target/arm/cpu.h     |  7 +++++++
>  target/arm/kvm64.c   | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/machine.c | 22 ++++++++++++++++++++
>  3 files changed, 88 insertions(+)


> +static int kvm_put_vcpu_events(ARMCPU *cpu)
> +{
> +    CPUARMState *env = &cpu->env;
> +    struct kvm_vcpu_events events = {};
> +
> +    if (!kvm_has_vcpu_events()) {
> +        return 0;
> +    }
> +
> +    memset(&events, 0, sizeof(events));
> +    events.exception.serror_pending = env->serror.pending;
> +
> +    if (have_inject_serror_esr) {
> +        events.exception.serror_has_esr = env->serror.has_esr;
> +        events.exception.serror_esr = env->serror.esr;
> +    }

I realised that the effect of this condition is that
if we migrate a VM from a machine which supports specifying the
SError ESR to one which does not, and at the point of migration
there is a pending SError with an ESR value, then we will
silently drop the specified ESR value. The other alternative
would be to fail the migration (by dropping the if() check,
and letting the host kernel fail the ioctl if that meant that
we asked it to set an SError ESR it couldn't manage.)

I guess that's OK? It's all hypothetical currently since
we don't support migration between different host CPU types.

> +
> +    return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
> +}
> +

> +static const VMStateDescription vmstate_serror = {
> +    .name = "cpu/ras",

You forgot to update the name here.

> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = serror_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(env.serror.pending, ARMCPU),
> +        VMSTATE_UINT32(env.serror.has_esr, ARMCPU),
> +        VMSTATE_UINT64(env.serror.esr, ARMCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static bool m_needed(void *opaque)
>  {
>      ARMCPU *cpu = opaque;
> @@ -726,6 +747,7 @@ const VMStateDescription vmstate_arm_cpu = {
>  #ifdef TARGET_AARCH64
>          &vmstate_sve,
>  #endif
> +        &vmstate_serror,
>          NULL
>      }
>  };
> --

thanks
-- PMM
