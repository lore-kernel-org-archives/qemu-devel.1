Received: from eggs.gnu.org ([2001:4830:134:3::10]:44658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duerC-0002ZI-NC
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duer7-0000qE-SN
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:02 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:32803)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duer7-0000po-LV
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:15:57 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 2B625AC91A
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 11:40:43 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-14-clg@kaod.org> <20170919075300.GQ27153@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d3a85114-ab64-5086-31b0-27124c4a5fbb@kaod.org>
Date: Wed, 20 Sep 2017 11:40:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170919075300.GQ27153@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 13/21] ppc/xive: handle interrupt
 acknowledgment by the O/S
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On 09/19/2017 09:53 AM, David Gibson wrote:
> On Mon, Sep 11, 2017 at 07:12:27PM +0200, C=E9dric Le Goater wrote:
>> When an O/S Exception is raised, the O/S acknowledges the interrupt
>> with a special read in the TIMA. If the EO bit of the Notification
>> Source Register (NSR) is set (and it should), the Current Processor
>> Priority Register (CPPR) takes the value of the Pending Interrupt
>> Priority Register (PIPR), which contains the priority of the most
>> favored pending notification. The bit number corresponding to the
>> priority of the pending interrupt is reseted in the Interrupt Pending
>> Buffer (IPB) and so is the EO bit of the NSR.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index e5d4b723b7e0..ad3ff91b13ea 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -50,7 +50,24 @@ static uint8_t ipb_to_pipr(uint8_t ibp)
>> =20
>>  static uint64_t spapr_xive_icp_accept(ICPState *icp)
>>  {
>> -    return 0;
>> +    uint8_t nsr =3D icp->tima_os[TM_NSR];
>> +
>> +    qemu_irq_lower(icp->output);
>=20
> Ah, here's the lower.  This should not be in a different patch from
> the matching raise. =20

ok I can merge these.

> Plus, this doesn't seem right.  Shouldn't this
> recheck the CPPR against the PIPR, in case a higher priority irq has
> been delivered since the one the cpu is acking.

If a higher priority is delivered, it means that the CPPR was more=20
privileged and that we have now two bits set in the IPB by the time=20
the interrupt is acked. The high priority PIPR will become the new=20
CPPR and the IBP will be modified keeping only the lower priority.=20

if the CPPR is modified to the lower priority level, then the=20
first interrupt will be delivered again.=20

I think this is fine.

C.


>=20
>> +    if (icp->tima_os[TM_NSR] & TM_QW1_NSR_EO) {
>> +        uint8_t cppr =3D icp->tima_os[TM_PIPR];
>> +
>> +        icp->tima_os[TM_CPPR] =3D cppr;
>> +
>> +        /* Reset the pending buffer bit */
>> +        icp->tima_os[TM_IPB] &=3D ~priority_to_ipb(cppr);
>> +        icp->tima_os[TM_PIPR] =3D ipb_to_pipr(icp->tima_os[TM_IPB]);
>> +
>> +        /* Drop Exception bit for OS */
>> +        icp->tima_os[TM_NSR] &=3D ~TM_QW1_NSR_EO;
>> +    }
>> +
>> +    return (nsr << 8) | icp->tima_os[TM_CPPR];
>>  }
>> =20
>>  static void spapr_xive_icp_notify(ICPState *icp)
>=20
