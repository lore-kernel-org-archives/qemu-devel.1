Received: from eggs.gnu.org ([2001:4830:134:3::10]:44814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fOLL5-000192-BP
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fOLL4-0008Bm-Ez
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:01:51 -0400
References: <1527736557-11084-1-git-send-email-zhaoshenglong@huawei.com>
	<1527736557-11084-2-git-send-email-zhaoshenglong@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e7bb1cbd-7fad-5bd2-641c-885f0f473680@redhat.com>
Date: Thu, 31 May 2018 13:01:42 +0200
MIME-Version: 1.0
In-Reply-To: <1527736557-11084-2-git-send-email-zhaoshenglong@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/2] arm_gicv3_kvm:
 kvm_dist_get/put_priority: skip the registers banked by GICR_IPRIORITYR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, qemu-stable@nongnu.org

Hi,

On 05/31/2018 05:15 AM, Shannon Zhao wrote:
> While for_each_dist_irq_reg loop starts from GIC_INTERNAL, it forgot to
> offset the date array and index. This will overlap the GICR registers
> value and leave the last GIC_INTERNAL irq's registers out of update.
> 
> Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
> ---
>  hw/intc/arm_gicv3_kvm.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 3536795..147e691 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -135,7 +135,14 @@ static void kvm_dist_get_priority(GICv3State *s, uint32_t offset, uint8_t *bmp)
>      uint32_t reg, *field;
>      int irq;
>  
> -    field = (uint32_t *)bmp;
> +    /* For the KVM GICv3, affinity routing is always enabled, and the first 8
> +     * GICD_IPRIORITYR<n> registers are always RAZ/WI. The corresponding
> +     * functionality is replaced by GICR_IPRIORITYR<n>. It doesn't need to
> +     * sync them. So it needs to skip the field of GIC_INTERNAL irqs in bmp and
> +     * offset.
> +     */
> +    field = (uint32_t *)(bmp + GIC_INTERNAL);
> +    offset += (GIC_INTERNAL * 8) / 8;
>      for_each_dist_irq_reg(irq, s->num_irq, 8) {
>          kvm_gicd_access(s, offset, &reg, false);
>          *field = reg;
> @@ -149,7 +156,14 @@ static void kvm_dist_put_priority(GICv3State *s, uint32_t offset, uint8_t *bmp)
>      uint32_t reg, *field;
>      int irq;
>  
> -    field = (uint32_t *)bmp;
> +    /* For the KVM GICv3, affinity routing is always enabled, and the first 8
> +     * GICD_IPRIORITYR<n> registers are always RAZ/WI. The corresponding
> +     * functionality is replaced by GICR_IPRIORITYR<n>. It doesn't need to
> +     * sync them. So it needs to skip the field of GIC_INTERNAL irqs in bmp and
> +     * offset.
> +     */
> +    field = (uint32_t *)(bmp + GIC_INTERNAL);
> +    offset += (GIC_INTERNAL * 8) / 8;
>      for_each_dist_irq_reg(irq, s->num_irq, 8) {
>          reg = *field;
>          kvm_gicd_access(s, offset, &reg, true);
> 
