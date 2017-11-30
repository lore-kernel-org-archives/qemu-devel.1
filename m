Received: from eggs.gnu.org ([2001:4830:134:3::10]:49126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKPdu-0005CO-Au
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKPdk-0006MQ-Pg
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:16:46 -0500
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:48631)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eKPdk-0006Ln-Jb
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:16:36 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 36E661264DA
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 15:16:35 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-15-clg@kaod.org>
	<20171130044922.GC3023@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <36b5b7a1-63f1-30ac-0fa6-a22b49df065f@kaod.org>
Date: Thu, 30 Nov 2017 14:16:30 +0000
MIME-Version: 1.0
In-Reply-To: <20171130044922.GC3023@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/25] spapr: push the XIVE EQ data in OS
 event queue
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

On 11/30/2017 04:49 AM, David Gibson wrote:
> On Thu, Nov 23, 2017 at 02:29:44PM +0100, C=E9dric Le Goater wrote:
>> If a triggered event is let through, the Event Queue data defined in t=
he
>> associated IVE is pushed in the in-memory event queue. The latter is a
>> circular buffer provided by the OS using the H_INT_SET_QUEUE_CONFIG hc=
all,
>> one per server and priority couple. It is composed of Event Queue entr=
ies
>> which are 4 bytes long, the first bit being a 'generation' bit and the=
 31
>> following bits the EQ Data field.
>>
>> The EQ Data field provides a way to set an invariant logical event sou=
rce
>> number for an IRQ. It is set with the H_INT_SET_SOURCE_CONFIG hcall.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive.c | 67 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  1 file changed, 67 insertions(+)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index 983317a6b3f6..df14c5a88275 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -193,9 +193,76 @@ static sPAPRXiveICP *spapr_xive_icp_get(sPAPRXive=
 *xive, int server)
>>      return cpu ? SPAPR_XIVE_ICP(cpu->intc) : NULL;
>>  }
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
>=20
> This suggests that uint32_t data contains guest endian data, which it
> generally shouldn't.  Better to use stl_be_dma() (or whatever is
> appropriate for the endianness of the data field.

There are no requirement on the endianness of the data field and=20
it is just stored in the IVE in the hcall H_INT_SET_SOURCE_CONFIG.=20
So the guest can pass whatever it likes. =20

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
>>  static void spapr_xive_irq(sPAPRXive *xive, int lisn)
>>  {
>> +    XiveIVE *ive;
>> +    XiveEQ *eq;
>> +    uint32_t eq_idx;
>> +    uint8_t priority;
>> +
>> +    ive =3D spapr_xive_get_ive(xive, lisn);
>> +    if (!ive || !(ive->w & IVE_VALID)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lis=
n);
>=20
> As mentioned on other patches, I'm a little concerned by these
> guest-triggerable logs.  I guess the LOG_GUEST_ERROR mask will save
> us, though.

I want to track 'invalid' interrupts but I haven't seen these show up=20
in my tests. I agree there are a little too much and some could just=20
be asserts.

Thanks,

C.

>=20
>> +        return;
>> +    }
>> =20
>> +    if (ive->w & IVE_MASKED) {
>> +        return;
>> +    }
>> +
>> +    /* Find our XiveEQ */
>> +    eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
>> +    eq =3D spapr_xive_get_eq(xive, eq_idx);
>> +    if (!eq) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No EQ for LISN %d\n", l=
isn);
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
>> +
>> +        /* The EQ is masked. Can this happen ?  */
>> +        if (priority =3D=3D 0xff) {
>> +            g_assert_not_reached();
>> +        }
>> +    } else {
>> +        qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented\n"=
);
>> +    }
>>  }
>> =20
>>  /*
>=20
