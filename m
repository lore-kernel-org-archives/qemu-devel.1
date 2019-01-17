Received: from eggs.gnu.org ([209.51.188.92]:47964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gk44r-0003CE-2w
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:35:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gk44q-0006UI-Bm
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:35:09 -0500
Date: Thu, 17 Jan 2019 10:25:57 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20190117092557.ivmyrym7gtyuubky@hawk.localdomain>
References: <20190117030917.18844-1-shannon.zhaosl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117030917.18844-1-shannon.zhaosl@gmail.com>
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
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org

On Thu, Jan 17, 2019 at 11:09:17AM +0800, Shannon Zhao wrote:
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

vGICv2 is not supported on this platform

>          return;
>      }
>  
> -- 
> 1.8.3.1
> 
> 

With the error message change

Reviewed-by: Andrew Jones <drjones@redhat.com>
