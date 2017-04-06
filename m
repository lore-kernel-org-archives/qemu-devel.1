Received: from eggs.gnu.org ([2001:4830:134:3::10]:43894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw6mb-0007Wg-PO
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw6mY-0005X2-NU
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:45:01 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:49050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cw6mY-0005Vo-GT
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:44:58 -0400
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id E401878AE3
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 14:44:56 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-4-git-send-email-clg@kaod.org>
	<20170406020256.GA1991@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5e61337a-135c-9574-993f-de00fab26777@kaod.org>
Date: Thu, 6 Apr 2017 14:44:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170406020256.GA1991@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/21] ppc/pnv: Add support for POWER8+ LPC
 Controller
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

On 04/06/2017 04:02 AM, David Gibson wrote:
> On Wed, Apr 05, 2017 at 02:41:28PM +0200, C=E9dric Le Goater wrote:
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>
>> It adds the Naples chip which supports proper LPC interrupts via the
>> LPC controller rather than via an external CPLD.
>>
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> [clg: - updated for qemu-2.9
>>       - ported on latest PowerNV patchset ]
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/ppc/pnv.c             | 13 ++++++++++++-
>>  hw/ppc/pnv_lpc.c         | 47 +++++++++++++++++++++++++++++++++++++++=
++++++--
>>  include/hw/ppc/pnv_lpc.h |  9 +++++++++
>>  3 files changed, 66 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 24e523f554c6..78133e5d20e1 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -373,7 +373,14 @@ static void pnv_lpc_isa_irq_handler_cpld(void *op=
aque, int n, int level)
>> =20
>>  static void pnv_lpc_isa_irq_handler(void *opaque, int n, int level)
>>  {
>> -     /* XXX TODO */
>> +    PnvChip *chip =3D opaque;
>> +    PnvLpcController *lpc =3D &chip->lpc;
>> +
>> +    /* The Naples HW latches the 1 levels, clearing is done by SW */
>> +    if (level) {
>> +        lpc->lpc_hc_irqstat |=3D LPC_HC_IRQ_SERIRQ0 >> n;
>> +        pnv_lpc_eval_irqs(lpc);
>> +    }
>>  }
>=20
> Now that you have a more complete LPC model, I think this function,
> and the allocation of the LPC irqs should move into pnv_lpc.c.
>=20
>=20
> Apart from that, looks fine.

While I am at changing things, we have a 'cpld_irqstate' under the=20
machine to model the state of the CPLD chip. It is only used in :=20

	static void pnv_lpc_isa_irq_handler_cpld(void *opaque, int n, int level)
	{
	    PnvMachineState *pnv =3D POWERNV_MACHINE(qdev_get_machine());
	    uint32_t old_state =3D pnv->cpld_irqstate;
	    PnvLpcController *lpc =3D opaque;

	    if (level) {
	        pnv->cpld_irqstate |=3D 1u << n;
	    } else {
	        pnv->cpld_irqstate &=3D ~(1u << n);
	    }

	    if (pnv->cpld_irqstate !=3D old_state) {
	        pnv_psi_irq_set(lpc->psi, PSIHB_IRQ_EXTERNAL, pnv->cpld_irqstate=
 !=3D 0);
	    }
	}

May be we could move that under the LPC object even if it is not strictly
correct from a HW pov ?=20

Thanks,

C.=20
