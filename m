Received: from eggs.gnu.org ([2001:4830:134:3::10]:41977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duOJh-0003Ns-Jq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duOJd-00065a-Fx
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:36:21 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:49257)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duOJd-00062d-3v
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:36:17 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 907ECA9EC6
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 21:36:14 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-12-clg@kaod.org> <20170919074556.GO27153@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2d91c586-ff31-ceb8-bee6-6d4531d1b5c0@kaod.org>
Date: Tue, 19 Sep 2017 21:36:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170919074556.GO27153@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 11/21] ppc/xive: push the EQ data in
 OS event queue
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

On 09/19/2017 09:45 AM, David Gibson wrote:
> On Mon, Sep 11, 2017 at 07:12:25PM +0200, C=E9dric Le Goater wrote:
>> If a triggered event is let through, the Event Queue data defined in
>> the associated IVE is pushed in the in-memory event queue. The latter
>> is a circular buffer provided by the OS using the H_INT_SET_QUEUE_CONF=
IG
>> hcall, one per target and priority couple. It is composed of Event
>> Queue entries which are 4 bytes long, the first bit being a
>> 'generation' bit and the 31 following bits the EQ Data field.
>>
>> The EQ Data field provides a way to set an invariant logical event
>> source number for an IRQ. It is set with the H_INT_SET_SOURCE_CONFIG
>> hcall.
>>
>> Notification of the CPU will be done in the following patch.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive.c | 67 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  1 file changed, 67 insertions(+)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index 557a7e2535b5..4bc61cfda67a 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -175,9 +175,76 @@ static const MemoryRegionOps spapr_xive_tm_ops =3D=
 {
>>      },
>>  };
>> =20
>> +static void spapr_xive_eq_push(XiveEQ *eq, uint32_t data)
>> +{
>> +    uint64_t qaddr_base =3D (((uint64_t)(eq->w2 & 0x0fffffff)) << 32)=
 | eq->w3;
>> +    uint32_t qsize =3D GETFIELD(EQ_W0_QSIZE, eq->w0);
>> +    uint32_t qindex =3D GETFIELD(EQ_W1_PAGE_OFF, eq->w1);
>> +    uint32_t qgen =3D GETFIELD(EQ_W1_GENERATION, eq->w1);
>> +
>> +    uint64_t qaddr =3D qaddr_base + (qindex << 2);
>> +    uint32_t qdata =3D cpu_to_be32((qgen << 31) | (data & 0x7fffffff)=
);
>> +    uint32_t qentries =3D 1 << (qsize + 10);
>> +
>> +    if (dma_memory_write(&address_space_memory, qaddr, &qdata, sizeof=
(qdata))) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to write EQ data @=
0x%"
>> +                      HWADDR_PRIx "\n", __func__, qaddr);
>> +        return;
>> +    }
>> +
>> +    qindex =3D (qindex + 1) % qentries;
>> +    if (qindex =3D=3D 0) {
>> +        qgen ^=3D 1;
>> +        eq->w1 =3D SETFIELD(EQ_W1_GENERATION, eq->w1, qgen);
>> +    }
>> +    eq->w1 =3D SETFIELD(EQ_W1_PAGE_OFF, eq->w1, qindex);
>> +}
>> +
>>  static void spapr_xive_irq(sPAPRXive *xive, int srcno)
>>  {
>> +    XiveIVE *ive;
>> +    XiveEQ *eq;
>> +    uint32_t eq_idx;
>> +    uint32_t priority;
>> +
>> +    ive =3D spapr_xive_get_ive(xive, srcno);
>> +    if (!ive || !(ive->w & IVE_VALID)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", src=
no);
>> +        return;
>> +    }
>> +
>> +    if (ive->w & IVE_MASKED) {
>> +        return;
>> +    }
>> +
>> +    /* Find our XiveEQ */
>> +    eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
>> +    eq =3D spapr_xive_get_eq(xive, eq_idx);
>> +    if (!eq) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No EQ for LISN %d\n", s=
rcno);
>> +        return;
>> +    }
>> +
>> +    if (eq->w0 & EQ_W0_ENQUEUE) {
>> +        spapr_xive_eq_push(eq, GETFIELD(IVE_EQ_DATA, ive->w));
>> +    } else {
>> +        qemu_log_mask(LOG_UNIMP, "XIVE: !ENQUEUE not implemented\n");
>> +    }
>> +
>> +    if (!(eq->w0 & EQ_W0_UCOND_NOTIFY)) {
>> +        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented=
\n");
>> +    }
>> +
>> +    if (GETFIELD(EQ_W6_FORMAT_BIT, eq->w6) =3D=3D 0) {
>> +        priority =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
>> =20
>> +        /* The EQ is masked. Can this happen ?  */
>> +        if (priority =3D=3D 0xff) {
>> +            return;
>=20
> How does the 8-bit priority field here interact with the 3-bit
> priority which selects which EQ to use?

priority OxFF is a special case kept for masking, see the hcall=20
h_int_set_source_config. It should never reach the EQ lookup=20
routines. So may be an assert would be better here.

C.=20

>=20
>> +        }
>> +    } else {
>> +        qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented\n"=
);
>> +    }
>>  }
>> =20
>>  /*
>=20
