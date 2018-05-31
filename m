Received: from eggs.gnu.org ([2001:4830:134:3::10]:33604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fONyg-00081I-ON
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fONyf-0005pt-SW
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:50:54 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:37894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fONyf-0005pF-OI
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:50:53 -0400
Received: by mail-ot0-x244.google.com with SMTP id n3-v6so25352393ota.5
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 06:50:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527736557-11084-3-git-send-email-zhaoshenglong@huawei.com>
References: <1527736557-11084-1-git-send-email-zhaoshenglong@huawei.com>
	<1527736557-11084-3-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 14:50:32 +0100
Message-ID: <CAFEAcA-qWkhueUUnZ1RmhRuhHLstGpwmameHgsOM7UautJVxpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/2] arm_gicv3_kvm: kvm_dist_get/put:
 skip the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-stable <qemu-stable@nongnu.org>

On 31 May 2018 at 04:15, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> While we skip the GIC_INTERNAL irqs, we don't change the register offset
> accordingly. This will overlap the GICR registers value and leave the
> last GIC_INTERNAL irq's registers out of update.
>
> Fix this by skipping the registers banked by GICR.
>
> Also for migration compatibility if the migration source (old version
> qemu) doesn't send gicd_no_migration_shift_bug = 1 to destination, then
> we shift the data of PPI to get the right data for SPI.
>
> Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>

> +    /*
> +     * While this new version QEMU doesn't have this kind of bug as we fix it,
> +     * so it's need to set the flag to true to indicate that and it's neccessary
> +     * for next migration to work from this new version QEMU.
> +     */
> +    cs->gicd_no_migration_shift_bug = true;

Nice catch; I would have forgotten that we needed to do this...


>
> +    /* For the KVM GICv3, affinity routing is always enabled, and the
> +     * GICD_IGROUPR0/GICD_IGRPMODR0/GICD_ISENABLER0/GICD_ISPENDR0/
> +     * GICD_ISACTIVER0 registers are always RAZ/WI. The corresponding
> +     * functionality is replaced by the GICR registers. It doesn't need to sync
> +     * them. So it should increase the offset to skip GIC_INTERNAL irqs.
> +     * This matches the for_each_dist_irq_reg() macro which also skips the
> +     * first GIC_INTERNAL irqs.
> +     */
> +    offset += (GIC_INTERNAL * 1) / 8;
> +    if (clroffset != 0) {
> +        clroffset += (1 * sizeof(uint32_t));
> +    }
> +

Shouldn't we be adding the same thing to clroffset that we add to offset ?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
