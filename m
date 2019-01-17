Received: from eggs.gnu.org ([209.51.188.92]:33289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkDTR-0004Bk-55
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkDTQ-00088k-5x
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:09 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkDTP-00086p-BU
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:08 -0500
Received: by mail-oi1-x244.google.com with SMTP id x23so7119935oix.3
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 11:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20190117030917.18844-1-shannon.zhaosl@gmail.com>
In-Reply-To: <20190117030917.18844-1-shannon.zhaosl@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 19:36:54 +0000
Message-ID: <CAFEAcA8w-JSvCcU70W63Yr_L0ZS44H26LPrPn4TgL=rW+2FULQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] ARM: GIC: error out early when creating
 VGICv2 failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <shannon.zhaosl@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 17 Jan 2019 at 03:09, Shannon Zhao <shannon.zhaosl@gmail.com> wrote:
>
> Currently if creating a gicv2 VM on the platform without
> VGICv2 support, it failed in kvm_arm_pmu_set_irq while
> trying to set the interrupt number for PMU with below
> error message.
> KVM_SET_DEVICE_ATTR failed: Invalid argument
>
> This error log is a little confused. Also it should error
> out in kvm_arm_gic_realize early.
>
> Signed-off-by: Shannon Zhao <shannon.zhaosl@gmail.com>
> ---
>  hw/intc/arm_gic_kvm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
> index a611e8e..b4f2133 100644
> --- a/hw/intc/arm_gic_kvm.c
> +++ b/hw/intc/arm_gic_kvm.c
> @@ -554,8 +554,9 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
>                                KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true,
>                                &error_abort);
>          }
> -    } else if (ret != -ENODEV && ret != -ENOTSUP) {
> -        error_setg_errno(errp, -ret, "error creating in-kernel VGIC");
> +    } else if (ret != -ENOTSUP) {
> +        error_setg_errno(errp, -ret, "error creating in-kernel VGIC, maybe "
> +                                     "vGICv2 not support on this platform");
>          return;
>      }

Shouldn't we be able to tell specifically whether the
vGICv2 is not supported on this platform, without
having to emit an error message that says "we got
some error, maybe it was that there's no vGICv2
support but maybe it was something else" ?

It's not clear to me what the various
possible kvm_create_device returns are. We have
I guess several cases:
 * new device control API supported, vGICv2 supported:
   return >= 0
 * new device control API not supported at all (ie
   old host kernel version): return some error, which one?
 * new device control API supported, but vGICv2 not
   supported: return some error, which one?
 * new device control API supported, vGICv2 supported,
   but something unlikely went wrong in the kernel:
   return any other error

What are the errnos for the middle two cases, and can
we end up with userspace code that can distinguish
these four cases rather than merging some of them
together?

thanks
-- PMM
