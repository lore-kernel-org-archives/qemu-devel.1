Received: from eggs.gnu.org ([2001:4830:134:3::10]:43876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cqJxi-0005Tu-GE
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cqJxf-0005NV-EQ
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:36:34 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:39983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cqJxf-0005Mw-7o
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:36:31 -0400
Received: from player739.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 01E942D4C6
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 14:36:28 +0100 (CET)
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
	<1488970371-8865-7-git-send-email-clg@kaod.org>
	<20170315061630.GF12603@umbus.fritz.box>
	<b6948010-fe70-0fa9-89fc-ce8061b7c119@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bf3a15e3-9ba5-0dcb-dc83-b24a9f36e085@kaod.org>
Date: Tue, 21 Mar 2017 14:36:19 +0100
MIME-Version: 1.0
In-Reply-To: <b6948010-fe70-0fa9-89fc-ce8061b7c119@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 6/8] ppc/pnv: Add cut down PSI
 bridge model and hookup external interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

[ ... ]

>>> +void pnv_psi_irq_set(PnvPsi *psi, PnvPsiIrq irq, bool state)
>>> +{
>>> +    ICSState *ics = &psi->ics;
>>> +    uint32_t xivr_reg;
>>> +    uint32_t stat_reg;
>>> +    uint64_t stat_bit;
>>> +    uint32_t src;
>>> +    bool masked;
>>> +
>>> +    if (!pnv_psi_irq_bits(psi, irq, &xivr_reg, &stat_reg, &stat_bit)) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "PSI: Unsupported irq %d\n", irq);
>>> +        return;
>>> +    }
>>> +
>>> +    src = (psi->regs[xivr_reg] & PSIHB_XIVR_SRC_MSK) >> PSIHB_XIVR_SRC_SH;
>>> +    masked = (psi->regs[xivr_reg] & PSIHB_XIVR_PRIO_MSK) == PSIHB_XIVR_PRIO_MSK;
>>> +    if (state) {
>>> +        psi->regs[stat_reg] |= stat_bit;
>>> +        /* XXX optimization: check mask here. That means re-evaluating
>>> +         * when unmasking, thus TODO
>>> +         */
>>> +        qemu_irq_raise(ics->qirqs[src]);
>>> +    } else {
>>> +        psi->regs[stat_reg] &= ~stat_bit;
>>> +
>>> +        /* FSP and PSI are muxed so don't lower if either still set */
>>> +        if (stat_reg != PSIHB_XSCOM_CR ||
>>> +            !(psi->regs[stat_reg] & (PSIHB_CR_PSI_IRQ | PSIHB_CR_FSP_IRQ))) {
>>> +            qemu_irq_lower(ics->qirqs[src]);
>>> +        } else {
>>> +            state = true;

ugly.

>>> +        }
>>> +    }
>>
>> It might be cleaner to just revaluate the irq level from scratch here,
>> and set the level, rather than doing this complicated dance to work
>> out if it has changed.
> 
> OK. I need to take a closer look at that.

So I took a closer a look and some parts are not clear, even if 
correct. The FSP and PSI interrupts are muxed and the above code 
tries to re-conciliate the IRQ triggering in a single routine. 
But we ended up (I think) using some hacks. See below PnvPsiIrq.

[ ... ]

>>> +static void pnv_psi_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    PnvPsi *psi = PNV_PSI(dev);
>>> +    ICSState *ics = &psi->ics;
>>> +    Object *obj;
>>> +    Error *err = NULL, *local_err = NULL;
>>> +    unsigned int i;
>>> +
>>> +    /* Initialize MMIO region */
>>> +    memory_region_init_io(&psi->regs_mr, OBJECT(dev), &psi_mmio_ops, psi,
>>> +                          "psihb", PNV_PSIHB_BAR_SIZE);
>>> +
>>> +    /* Default BAR. Use object properties ? */
>>> +    pnv_psi_set_bar(psi, PNV_PSIHB_BAR | PSIHB_BAR_EN);
>>> +
>>> +    /* Default sources in XIVR */
>>> +    psi->regs[PSIHB_XSCOM_XIVR_PSI] = PSIHB_XIVR_PRIO_MSK |
>>> +            (0ull << PSIHB_XIVR_SRC_SH);
>>> +    psi->regs[PSIHB_XSCOM_XIVR_OCC] = PSIHB_XIVR_PRIO_MSK |
>>> +            (1ull << PSIHB_XIVR_SRC_SH);
>>> +    psi->regs[PSIHB_XSCOM_XIVR_FSI] = PSIHB_XIVR_PRIO_MSK |
>>> +            (2ull << PSIHB_XIVR_SRC_SH);
>>> +    psi->regs[PSIHB_XSCOM_XIVR_LPCI2C] = PSIHB_XIVR_PRIO_MSK |
>>> +            (3ull << PSIHB_XIVR_SRC_SH);
>>> +    psi->regs[PSIHB_XSCOM_XIVR_LOCERR] = PSIHB_XIVR_PRIO_MSK |
>>> +            (4ull << PSIHB_XIVR_SRC_SH);
>>> +    psi->regs[PSIHB_XSCOM_XIVR_EXT] = PSIHB_XIVR_PRIO_MSK |
>>> +            (5ull << PSIHB_XIVR_SRC_SH);
>>> +

The above is not using a loop on PnvPsiIrq because the numbers
do not match the PSI IRQ definitions.

[ ... ]

>>> +
>>> +typedef enum PnvPsiIrq {
>>> +    PSIHB_IRQ_PSI, /* internal use only */
>>> +    PSIHB_IRQ_FSP, /* internal use only */
>>> +    PSIHB_IRQ_OCC,
>>> +    PSIHB_IRQ_FSI,
>>> +    PSIHB_IRQ_LPC_I2C,
>>> +    PSIHB_IRQ_LOCAL_ERR,
>>> +    PSIHB_IRQ_EXTERNAL,
>>> +} PnvPsiIrq;
>>> +
>>> +#define PSI_NUM_INTERRUPTS 6

a maximum of 6 interrupts for an enum containing 7 entries. It is a
little ugly.

I am going to rewrite this part in a more straight forward way.

C.


 
