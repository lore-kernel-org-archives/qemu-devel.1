Received: from eggs.gnu.org ([2001:4830:134:3::10]:36006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fOIQ8-0005Js-7N
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fOIQ7-0003OA-Jb
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:54:52 -0400
References: <1527750994-14360-1-git-send-email-zhaoshenglong@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <84171c12-e281-8de5-ec3d-ac0aaf3c3dbb@redhat.com>
Date: Thu, 31 May 2018 09:54:42 +0200
MIME-Version: 1.0
In-Reply-To: <1527750994-14360-1-git-send-email-zhaoshenglong@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] KVM: GIC: Fix memory leak due to calling
 kvm_init_irq_routing twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org

Hi Shannon,

On 05/31/2018 09:16 AM, Shannon Zhao wrote:
> kvm_irqchip_create called by kvm_init will call kvm_init_irq_routing to
> initialize global capability variables. If we call kvm_init_irq_routing in
> GIC realize function, previous allocated memory will leak.
> 
> Fix this by deleting the unnecessary call.
> 
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
openpic_kvm seems to suffer the same leak. Don't you want to fix it as
well?

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/intc/arm_gic_kvm.c   | 1 -
>  hw/intc/arm_gicv3_kvm.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
> index 6f467e6..204369d 100644
> --- a/hw/intc/arm_gic_kvm.c
> +++ b/hw/intc/arm_gic_kvm.c
> @@ -572,7 +572,6 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
>  
>      if (kvm_has_gsi_routing()) {
>          /* set up irq routing */
> -        kvm_init_irq_routing(kvm_state);
>          for (i = 0; i < s->num_irq - GIC_INTERNAL; ++i) {
>              kvm_irqchip_add_irq_route(kvm_state, i, 0, i);
>          }
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 001d82b..aa4c7c5 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -813,7 +813,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>  
>      if (kvm_has_gsi_routing()) {
>          /* set up irq routing */
> -        kvm_init_irq_routing(kvm_state);
>          for (i = 0; i < s->num_irq - GIC_INTERNAL; ++i) {
>              kvm_irqchip_add_irq_route(kvm_state, i, 0, i);
>          }
> 
