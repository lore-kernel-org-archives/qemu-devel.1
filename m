Received: from eggs.gnu.org ([2001:4830:134:3::10]:59399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1conC9-0000i3-Kf
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 04:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1conC5-0003gA-Lb
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 04:25:09 -0400
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:45778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1conC5-0003fT-G8
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 04:25:05 -0400
Received: from player756.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id F100F5A71C
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 09:25:00 +0100 (CET)
References: <1447201710-10229-1-git-send-email-benh@kernel.crashing.org>
	<1447201710-10229-49-git-send-email-benh@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <22f93cf3-faa4-f912-2d98-41d7f149029b@kaod.org>
Date: Fri, 17 Mar 2017 09:24:58 +0100
MIME-Version: 1.0
In-Reply-To: <1447201710-10229-49-git-send-email-benh@kernel.crashing.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 48/77] ppc/pnv: Add model for
 Power8 PHB3 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

Ben,

Quick question,

> +/* This is called whenever the PHB LSI, MSI source ID register or
> + * the PBCQ irq filters are written.
> + */
> +void pnv_phb3_remap_irqs(PnvPhb3State *phb)
> +{
> +    uint32_t local, global, count, mask, comp;
> +    uint64_t baren;
> +
> +    /* First check if we are enabled. Unlike real HW we don't separate TX and RX
> +     * so we enable if both are set
> +     */
> +    baren = phb->pbcq->nest_regs[PBCQ_NEST_BAR_EN];
> +    if (!(baren & PBCQ_NEST_BAR_EN_IRSN_RX) ||
> +        !(baren & PBCQ_NEST_BAR_EN_IRSN_TX)) {
> +        phb->lsi_ics->offset = 0;
> +        return;
> +    }
> +
> +    /* Grab local LSI source ID */
> +    local = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]) << 3;
> +
> +    /* Grab global one and compare */
> +    global = GETFIELD(PBCQ_NEST_LSI_SRC,
> +                      phb->pbcq->nest_regs[PBCQ_NEST_LSI_SRC_ID]) << 3;
> +    if (global != local) {
> +        /* This happens during initialization, let's come back when we
> +         * are properly configured
> +         */
> +        phb->lsi_ics->offset = 0;
> +        return;
> +    }
> +
> +    /* Get the base on the powerbus */
> +    comp = GETFIELD(PBCQ_NEST_IRSN_COMP,
> +                    phb->pbcq->nest_regs[PBCQ_NEST_IRSN_COMPARE]);
> +    mask = GETFIELD(PBCQ_NEST_IRSN_COMP,
> +                    phb->pbcq->nest_regs[PBCQ_NEST_IRSN_MASK]);
> +    count = ((~mask) + 1) & 0x7ffff;
> +    phb->total_irq = count;
> +
> +    /* Sanity checks */
> +    if ((global + 8) > count) {
> +        DBG_MAP(phb, "LSIs out of reach: LSI base=%d total irq=%d",
> +                global, count);
> +    }
> +    if (count > 2048) {
> +        DBG_MAP(phb, "More interrupts than supported: %d", count);
> +    }
> +    if ((comp & mask) != comp) {
> +        DBG_MAP(phb, "IRQ compare bits not in mask: comp=0x%x mask=0x%x",
> +                comp, mask);
> +        comp &= mask;
> +    }
> +    /* Setup LSI offset */
> +    phb->lsi_ics->offset = comp + global;
> +
> +    /* Setup MSI offset */
> +    pnv_phb3_msi_update_config(phb->msis, comp, count);

I changed that to :

    pnv_phb3_msi_update_config(phb->msis, comp, count - PHB_NUM_LSI);

else the IRQ numbers overlap with the LSI and I think this why we were 
uselessly looping on the EOI.

Correct ? 

C.
 
> +
> +    DBG_MAP(phb, "Initialized for %d interrupts @0x%x, LSI off=%d",
> +            count, comp, global);
> +}
> +
