Received: from eggs.gnu.org ([2001:4830:134:3::10]:33466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhiUG-00042n-Gb
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 17:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhiUD-0005vd-DJ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 17:35:24 -0400
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:38657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fhiUC-0005up-Kz
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 17:35:21 -0400
Received: from player779.ha.ovh.net (unknown [10.109.159.136])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id D453B1CC1DD
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 23:35:18 +0200 (CEST)
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0612746d-2d5d-51f4-685d-a01e90ad8198@kaod.org>
Date: Mon, 23 Jul 2018 23:35:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180718061230.GE2102@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index 6ac8a9392da6..966a996c2eac 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -194,6 +194,7 @@ void icp_set_mfrr(ICPState *icp, uint8_t mfrr);
>>  uint32_t icp_accept(ICPState *ss);
>>  uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr);
>>  void icp_eoi(ICPState *icp, uint32_t xirr);
>> +void icp_irq(ICSState *ics, int server, int nr, uint8_t priority);
> 
> Hrm... are you sure you need to expose this?
> 
>>  void ics_simple_write_xive(ICSState *ics, int nr, int server,
>>                             uint8_t priority, uint8_t saved_priority);
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index b9f1a3c97214..59e2a5217dcc 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -230,7 +230,7 @@ void icp_eoi(ICPState *icp, uint32_t xirr)
>>      }
>>  }
>>  
>> -static void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
>> +void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
>>  {
>>      ICPState *icp = xics_icp_get(ics->xics, server);
>>  

[ ... ]

>> +
>> +static void phb3_msi_try_send(Phb3MsiState *msi, int srcno, bool ignore_p)
>> +{
>> +    ICSState *ics = ICS_BASE(msi);
>> +    uint64_t ive;
>> +    uint64_t server, prio, pq, gen;
>> +
>> +    if (!phb3_msi_read_ive(msi->phb, srcno, &ive)) {
>> +        return;
>> +    }
>> +
>> +    server = GETFIELD(IODA2_IVT_SERVER, ive);
>> +    prio = GETFIELD(IODA2_IVT_PRIORITY, ive);
>> +    pq = GETFIELD(IODA2_IVT_Q, ive);
>> +    if (!ignore_p) {
>> +        pq |= GETFIELD(IODA2_IVT_P, ive) << 1;
>> +    }
>> +    gen = GETFIELD(IODA2_IVT_GEN, ive);
>> +
>> +    /*
>> +     * The low order 2 bits are the link pointer (Type II interrupts).
>> +     * Shift back to get a valid IRQ server.
>> +     */
>> +    server >>= 2;
>> +
>> +    switch (pq) {
>> +    case 0: /* 00 */
>> +        if (prio == 0xff) {
>> +            /* Masked, set Q */
>> +            phb3_msi_set_q(msi, srcno);
>> +        } else {
>> +            /* Enabled, set P and send */
>> +            phb3_msi_set_p(msi, srcno, gen);
>> +            icp_irq(ics, server, srcno + ics->offset, prio);
> 
> Can't you just pulse the right qirq here, which will use the core ICS
> logic to propagate to the ICP?

The interrupt vector entries are maintained in the guest memory. We don't 
have an entry in the device model (hcall, mmio on a register) to update 
an IRQ state. So we need to find the target when the IRQ is triggered.  

The interrupt source unit logic of the phb3 device is closer to the Type 3 
architecture (XIVE) in fact.

C.
