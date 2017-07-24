Received: from eggs.gnu.org ([2001:4830:134:3::10]:60191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZfSM-0007Q6-Qn
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZfSH-0006Hl-VT
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:39:38 -0400
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:48724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dZfSH-0006Ga-Oj
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:39:33 -0400
Received: from player732.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 2BB33123F06
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 17:39:32 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-8-git-send-email-clg@kaod.org>
	<3f109bf4-3de0-a665-d066-9d91ac883aad@ozlabs.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d580ddf7-6332-4725-07c4-85d6d82d56f5@kaod.org>
Date: Mon, 24 Jul 2017 17:39:26 +0200
MIME-Version: 1.0
In-Reply-To: <3f109bf4-3de0-a665-d066-9d91ac883aad@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 07/26] ppc/xive: add MMIO handlers to
 the XIVE interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org

On 07/24/2017 08:50 AM, Alexey Kardashevskiy wrote:
> On 06/07/17 03:13, C=C3=A9dric Le Goater wrote:
>> Each interrupt source is associated with a 2-bit state machine called
>> an Event State Buffer (ESB). It is controlled by MMIO to trigger
>> events.
>>
>> See code for more details on the states.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/xive.c        | 230 +++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  include/hw/ppc/xive.h |   3 +
>>  2 files changed, 233 insertions(+)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 9ff14c0da595..816031b8ac81 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -32,6 +32,226 @@ static void xive_icp_irq(XiveICSState *xs, int lis=
n)
>>  }
>> =20
>>  /*
>> + * "magic" Event State Buffer (ESB) MMIO offsets.
>> + *
>> + * Each interrupt source has a 2-bit state machine called ESB
>> + * which can be controlled by MMIO. It's made of 2 bits, P and
>> + * Q. P indicates that an interrupt is pending (has been sent
>> + * to a queue and is waiting for an EOI). Q indicates that the
>> + * interrupt has been triggered while pending.
>> + *
>> + * This acts as a coalescing mechanism in order to guarantee
>> + * that a given interrupt only occurs at most once in a queue.
>> + *
>> + * When doing an EOI, the Q bit will indicate if the interrupt
>> + * needs to be re-triggered.
>> + *
>> + * The following offsets into the ESB MMIO allow to read or
>> + * manipulate the PQ bits. They must be used with an 8-bytes
>> + * load instruction. They all return the previous state of the
>> + * interrupt (atomically).
>> + *
>> + * Additionally, some ESB pages support doing an EOI via a
>> + * store at 0 and some ESBs support doing a trigger via a
>> + * separate trigger page.
>> + */
>> +#define XIVE_ESB_GET            0x800
>> +#define XIVE_ESB_SET_PQ_00      0xc00
>> +#define XIVE_ESB_SET_PQ_01      0xd00
>> +#define XIVE_ESB_SET_PQ_10      0xe00
>> +#define XIVE_ESB_SET_PQ_11      0xf00
>> +
>> +#define XIVE_ESB_VAL_P          0x2
>> +#define XIVE_ESB_VAL_Q          0x1
>=20
>=20
> These are not used. I'd suggest defining the states below using these t=
wo.

yes. I will add a VAL_PQ also.

>=20
>> +
>> +#define XIVE_ESB_RESET          0x0
>> +#define XIVE_ESB_PENDING        0x2
>> +#define XIVE_ESB_QUEUED         0x3
>> +#define XIVE_ESB_OFF            0x1
>> +
>> +static uint8_t xive_pq_get(XIVE *x, uint32_t lisn)
>> +{
>> +    uint32_t idx =3D lisn;
>> +    uint32_t byte =3D idx / 4;
>> +    uint32_t bit  =3D (idx % 4) * 2;
>> +    uint8_t* pqs =3D (uint8_t *) x->sbe;
>> +
>> +    return (pqs[byte] >> bit) & 0x3;
>> +}
>> +
>> +static void xive_pq_set(XIVE *x, uint32_t lisn, uint8_t pq)
>> +{
>> +    uint32_t idx =3D lisn;
>> +    uint32_t byte =3D idx / 4;
>> +    uint32_t bit  =3D (idx % 4) * 2;
>> +    uint8_t* pqs =3D (uint8_t *) x->sbe;
>> +
>> +    pqs[byte] &=3D ~(0x3 << bit);
>> +    pqs[byte] |=3D (pq & 0x3) << bit;
>> +}
>> +
>> +static bool xive_pq_eoi(XIVE *x, uint32_t lisn)
>=20
>=20
> Should not it return uint8_t as well (like xive_pq_get() does)? The val=
ue
> than returned from .read() is uint64_t (a binary value).

Yes. The bool only reflects the state machine specs but we can=20
change that in the code.  =20

Thanks,

C.=20
