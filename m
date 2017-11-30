Received: from eggs.gnu.org ([2001:4830:134:3::10]:59054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKRWe-0007tz-Tv
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKRWb-0001eX-KZ
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:17:24 -0500
Received: from 4.mo6.mail-out.ovh.net ([87.98.184.159]:58223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eKRWb-0001dc-Az
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:17:21 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id C87FC120D71
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 17:17:19 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-16-clg@kaod.org>
	<20171130050049.GD3023@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ccaf98b5-fbfb-6d0b-9929-9d84e7955ebc@kaod.org>
Date: Thu, 30 Nov 2017 16:17:14 +0000
MIME-Version: 1.0
In-Reply-To: <20171130050049.GD3023@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/25] spapr: notify the CPU when the XIVE
 interrupt priority is more privileged
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

On 11/30/2017 05:00 AM, David Gibson wrote:
> On Thu, Nov 23, 2017 at 02:29:45PM +0100, C=E9dric Le Goater wrote:
>> The Pending Interrupt Priority Register (PIPR) contains the priority
>> of the most favored pending notification. It is calculated from the
>> Interrupt Pending Buffer (IPB) which indicates a pending interrupt at
>> the priority corresponding to the bit number.
>>
>> If the PIPR is more favored (1) than the Current Processor Priority
>> Register (CPPR), the CPU interrupt line is raised and the EO bit of
>> the Notification Source Register is updated to notify the presence of
>> an exception for the O/S. The check needs to be done whenever the PIPR
>> or the CPPR is changed.
>>
>> Then, the O/S Exception is raised and the O/S acknowledges the
>> interrupt with a special read in the TIMA. If the EO bit of the
>> Notification Source Register (NSR) is set (and it should), the Current
>> Processor Priority Register (CPPR) takes the value of the Pending
>> Interrupt Priority Register (PIPR). The bit number in the Interrupt
>> Pending Buffer (IPB) corresponding to the priority of the pending
>> interrupt is reseted and so is the EO bit of the NSR.
>>
>> (1) numerically less than
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive.c | 77 +++++++++++++++++++++++++++++++++++++++++++=
++++++++-
>>  1 file changed, 76 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index df14c5a88275..fead9c7031f3 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -39,9 +39,63 @@ struct sPAPRXiveICP {
>>      XiveEQ    eqt[XIVE_PRIORITY_MAX + 1];
>>  };
>> =20
>> +/* Convert a priority number to an Interrupt Pending Buffer (IPB)
>> + * register, which indicates a pending interrupt at the priority
>> + * corresponding to the bit number
>> + */
>> +static uint8_t priority_to_ipb(uint8_t priority)
>> +{
>> +    return priority > XIVE_PRIORITY_MAX ?
>> +        0 : 1 << (XIVE_PRIORITY_MAX - priority);
>=20
> Does handling out of bounds values here make sense, or should you just
> assert() they're not passed in?

Looking at the code, I think we could assert, yes. I need to=20
check the SET_OS_PENDING command first.

>> +}
>> +
>> +/* Convert an Interrupt Pending Buffer (IPB) register to a Pending
>> + * Interrupt Priority Register (PIPR), which contains the priority of
>> + * the most favored pending notification.
>> + *
>> + * TODO:
>> + *
>> + *   PIPR is clamped to CPPR. So the value in the PIPR is:
>> + *
>> + *     v =3D leftmost_bit_of(ipb) (or 0xff);
>> + *     pipr =3D v < cppr ? v : cppr;
>> + *
>> + * Ben says: "which means it's never actually 0xff ... surprise !".
>> + * But, the CPPR can be set to 0xFF ... I am confused ...
>=20
> A resolution to this would be nice..

That's on my TODO list. Not a big issue.=20
=20
>> + */
>> +static uint8_t ipb_to_pipr(uint8_t ibp)
>> +{
>> +    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
>> +}
>> +
>>  static uint64_t spapr_xive_icp_accept(sPAPRXiveICP *icp)
>>  {
>> -    return 0;
>> +    uint8_t nsr =3D icp->tima_os[TM_NSR];
>> +
>> +    qemu_irq_lower(icp->output);
>> +
>> +    if (icp->tima_os[TM_NSR] & TM_QW1_NSR_EO) {
>> +        uint8_t cppr =3D icp->tima_os[TM_PIPR];
>> +
>> +        icp->tima_os[TM_CPPR] =3D cppr;
>> +
>> +        /* Reset the pending buffer bit */
>> +        icp->tima_os[TM_IPB] &=3D ~priority_to_ipb(cppr);
>=20
> What if multiple irqs of the same priority were queued?

When an interrupt is EOI'ed, the queue is scanned to check=20
for any pending interrupts. If so, a replay is forced with=20
a call to force_external_irq_replay()

C.=20

>=20
>> +        icp->tima_os[TM_PIPR] =3D ipb_to_pipr(icp->tima_os[TM_IPB]);
>> +
>> +        /* Drop Exception bit for OS */
>> +        icp->tima_os[TM_NSR] &=3D ~TM_QW1_NSR_EO;
>> +    }
>> +
>> +    return (nsr << 8) | icp->tima_os[TM_CPPR];
>> +}
>> +
>> +static void spapr_xive_icp_notify(sPAPRXiveICP *icp)
>> +{
>> +    if (icp->tima_os[TM_PIPR] < icp->tima_os[TM_CPPR]) {
>> +        icp->tima_os[TM_NSR] |=3D TM_QW1_NSR_EO;
>> +        qemu_irq_raise(icp->output);
>> +    }
>>  }
>> =20
>>  static void spapr_xive_icp_set_cppr(sPAPRXiveICP *icp, uint8_t cppr)
>> @@ -51,6 +105,9 @@ static void spapr_xive_icp_set_cppr(sPAPRXiveICP *i=
cp, uint8_t cppr)
>>      }
>> =20
>>      icp->tima_os[TM_CPPR] =3D cppr;
>> +
>> +    /* CPPR has changed, inform the ICP which might raise an exceptio=
n */
>> +    spapr_xive_icp_notify(icp);
>>  }
>> =20
>>  /*
>> @@ -224,6 +281,8 @@ static void spapr_xive_irq(sPAPRXive *xive, int li=
sn)
>>      XiveEQ *eq;
>>      uint32_t eq_idx;
>>      uint8_t priority;
>> +    uint32_t server;
>> +    sPAPRXiveICP *icp;
>> =20
>>      ive =3D spapr_xive_get_ive(xive, lisn);
>>      if (!ive || !(ive->w & IVE_VALID)) {
>> @@ -253,6 +312,13 @@ static void spapr_xive_irq(sPAPRXive *xive, int l=
isn)
>>          qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented=
\n");
>>      }
>> =20
>> +    server =3D GETFIELD(EQ_W6_NVT_INDEX, eq->w6);
>> +    icp =3D spapr_xive_icp_get(xive, server);
>> +    if (!icp) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No ICP for server %d\n"=
, server);
>> +        return;
>> +    }
>> +
>>      if (GETFIELD(EQ_W6_FORMAT_BIT, eq->w6) =3D=3D 0) {
>>          priority =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
>> =20
>> @@ -260,9 +326,18 @@ static void spapr_xive_irq(sPAPRXive *xive, int l=
isn)
>>          if (priority =3D=3D 0xff) {
>>              g_assert_not_reached();
>>          }
>> +
>> +        /* Update the IPB (Interrupt Pending Buffer) with the priorit=
y
>> +         * of the new notification and inform the ICP, which will
>> +         * decide to raise the exception, or not, depending the CPPR.
>> +         */
>> +        icp->tima_os[TM_IPB] |=3D priority_to_ipb(priority);
>> +        icp->tima_os[TM_PIPR] =3D ipb_to_pipr(icp->tima_os[TM_IPB]);
>>      } else {
>>          qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented\n"=
);
>>      }
>> +
>> +    spapr_xive_icp_notify(icp);
>>  }
>> =20
>>  /*
>=20
