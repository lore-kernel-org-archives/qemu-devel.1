Received: from eggs.gnu.org ([2001:4830:134:3::10]:45177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1fOOgb-00028H-PZ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1fOOga-0006gC-JX
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:36:17 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-qWkhueUUnZ1RmhRuhHLstGpwmameHgsOM7UautJVxpw@mail.gmail.com>
References: <1527736557-11084-1-git-send-email-zhaoshenglong@huawei.com>
	<1527736557-11084-3-git-send-email-zhaoshenglong@huawei.com>
	<CAFEAcA-qWkhueUUnZ1RmhRuhHLstGpwmameHgsOM7UautJVxpw@mail.gmail.com>
From: Shannon Zhao <shannon.zhaosl@gmail.com>
Date: Thu, 31 May 2018 22:36:08 +0800
Message-ID: <CAOMwq8-H+iZ1L996G4jdky__zstwFo6x0qTucqLRstuXhs1CEA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

2018-05-31 21:50 GMT+08:00 Peter Maydell <peter.maydell@linaro.org>:

> On 31 May 2018 at 04:15, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> > While we skip the GIC_INTERNAL irqs, we don't change the register offset
> > accordingly. This will overlap the GICR registers value and leave the
> > last GIC_INTERNAL irq's registers out of update.
> >
> > Fix this by skipping the registers banked by GICR.
> >
> > Also for migration compatibility if the migration source (old version
> > qemu) doesn't send gicd_no_migration_shift_bug = 1 to destination, then
> > we shift the data of PPI to get the right data for SPI.
> >
> > Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
>
> > +    /*
> > +     * While this new version QEMU doesn't have this kind of bug as we
> fix it,
> > +     * so it's need to set the flag to true to indicate that and it's
> neccessary
> > +     * for next migration to work from this new version QEMU.
> > +     */
> > +    cs->gicd_no_migration_shift_bug = true;
>
> Nice catch; I would have forgotten that we needed to do this...
>
>
> >
> > +    /* For the KVM GICv3, affinity routing is always enabled, and the
> > +     * GICD_IGROUPR0/GICD_IGRPMODR0/GICD_ISENABLER0/GICD_ISPENDR0/
> > +     * GICD_ISACTIVER0 registers are always RAZ/WI. The corresponding
> > +     * functionality is replaced by the GICR registers. It doesn't need
> to sync
> > +     * them. So it should increase the offset to skip GIC_INTERNAL irqs.
> > +     * This matches the for_each_dist_irq_reg() macro which also skips
> the
> > +     * first GIC_INTERNAL irqs.
> > +     */
> > +    offset += (GIC_INTERNAL * 1) / 8;
> > +    if (clroffset != 0) {
> > +        clroffset += (1 * sizeof(uint32_t));
> > +    }
> > +
>
> Shouldn't we be adding the same thing to clroffset that we add to offset ?
>
> Yeah, right. It should like this

  clroffset += (GIC_INTERNAL * 1) / 8;

I don't remember why I didn't write this way. Anyway, Could you please fix
this when you apply this patch or I send a new version?

Thanks,
--
Shannon
