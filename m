Received: from eggs.gnu.org ([2001:4830:134:3::10]:44676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eJkXS-0002sU-K4
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eJkXO-0007gD-Dr
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:23:22 -0500
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:54494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eJkXO-0007fh-7W
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:23:18 -0500
Received: from player738.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id B45F94A50F
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 19:23:16 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-12-clg@kaod.org>
	<20171128064034.GQ11775@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7ec4da86-6fe8-07ca-b81a-5de85905bc8a@kaod.org>
Date: Tue, 28 Nov 2017 18:23:12 +0000
MIME-Version: 1.0
In-Reply-To: <20171128064034.GQ11775@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/25] spapr: describe the XIVE interrupt
 source flags
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

On 11/28/2017 06:40 AM, David Gibson wrote:
> On Thu, Nov 23, 2017 at 02:29:41PM +0100, C=E9dric Le Goater wrote:
>> The XIVE interrupt sources can have different characteristics dependin=
g
>> on their nature and the HW level in use. The sPAPR specs provide a set=
 of
>> flags to describe them :
>>
>>  - XIVE_SRC_H_INT_ESB  the Event State Buffers are controlled with a
>>                        specific hcall H_INT_ESB and not with MMIO
>>  - XIVE_SRC_LSI        LSI or MSI source (ICSIRQState level)
>>  - XIVE_SRC_TRIGGER    the full function page supports trigger
>>  - XIVE_SRC_STORE_EOI  EOI can be done with a store.
>>
>> Our QEMU emulation of XIVE for the sPAPR machine gathers all sources u=
nder
>> a same model and provides a common source with the XIVE_SRC_TRIGGER ty=
pe.
>> So, the above list is mostly informative apart from the XIVE_SRC_LSI f=
lag
>> which will be deduced from the XIVE_STATUS_LSI flag.
>>
>> The OS retrieves this information on the source with the
>> H_INT_GET_SOURCE_INFO hcall.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive.c        | 4 ++++
>>  include/hw/ppc/spapr_xive.h | 7 +++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index f45f50fd017e..b1e3f8710cff 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -368,6 +368,10 @@ static void spapr_xive_realize(DeviceState *dev, =
Error **errp)
>>      /* Allocate the IVT (Interrupt Virtualization Table) */
>>      xive->ivt =3D g_malloc0(xive->nr_irqs * sizeof(XiveIVE));
>> =20
>> +    /* All sources are emulated under the XIVE object and share the
>> +     * same characteristic */
>> +    xive->flags =3D XIVE_SRC_TRIGGER;
>=20
> You never actually use this field.  And since it always has the same
> value, is there a point to storing it?

yep. not much. This is a left over.=20

I will keep the defines and move the value to the XIVE hcall layer where=20
it is used.

Thanks,

C. =20

>> +
>>      /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per byte=
 */
>>      xive->sbe_size =3D DIV_ROUND_UP(xive->nr_irqs, 4);
>>      xive->sbe =3D g_malloc0(xive->sbe_size);
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 84c910e62e56..7a308fb4db2b 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -40,6 +40,13 @@ struct sPAPRXive {
>>  #define XIVE_STATUS_SENT               0x4
>>      uint8_t      *status;
>> =20
>> +    /* Interrupt source flags */
>> +#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60))
>> +#define XIVE_SRC_LSI           (1ull << (63 - 61))
>> +#define XIVE_SRC_TRIGGER       (1ull << (63 - 62))
>> +#define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
>> +    uint32_t     flags;
>> +
>>      /* XIVE internal tables */
>>      XiveIVE      *ivt;
>>      uint8_t      *sbe;
>=20
