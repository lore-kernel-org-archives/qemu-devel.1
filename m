Received: from eggs.gnu.org ([2001:4830:134:3::10]:44414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fbTpF-0008S2-Qe
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fbTpB-0000HI-Tr
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:43:17 -0400
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:44412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fbTpB-0000GN-Lh
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:43:13 -0400
Received: from player798.ha.ovh.net (unknown [10.109.120.28])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 1BDDBC8CFE
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 18:43:11 +0200 (CEST)
References: <20180706090713.15712-1-clg@kaod.org>
	<20180706090713.15712-2-clg@kaod.org>
	<28391e09-2e15-6050-e452-0493172a73a4@kaod.org>
	<20180706161638.07032b4f@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9c171d4c-32e1-73da-561d-cc0aa44b42fb@kaod.org>
Date: Fri, 6 Jul 2018 18:43:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180706161638.07032b4f@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/06/2018 04:16 PM, Greg Kurz wrote:
> On Fri, 6 Jul 2018 15:27:17 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>>   > +/*
>>> + * The register property of a VIO device is defined in livirt using =
a
>>> + * base number + 0x1000 increment and in QEMU by incrementing the ba=
se
>>> + * register number 0x71000000.
>>> + *
>>> + * The formula below tries to compute a unique index number from the
>>> + * register value that will be used to define the IRQ number of the
>>> + * VIO device. A maximum of 256 (0x100) VIO devices is covered.
>>> + *
>>> + * To minimize collisions, we define two distinct ranges depending o=
n
>>> + * the "reg" value definition:
>>> + *
>>> + *     [0x00 - 0x7f]    user/libvirt
>>> + *     [0x80 - 0xff]    QEMU VIO model
>>> + *
>>> + * Collisions will be detected when the IRQ is claimed.
>>> + */
>>> +static inline uint32_t spapr_vio_reg_to_irq(uint32_t reg)
>>> +{
>>> +    if (reg >=3D SPAPR_VIO_REG_BASE) {
>>> +        return SPAPR_IRQ_VIO | (reg & 0x7f) | 0x80;
>>> +    } else {
>>> +        return SPAPR_IRQ_VIO | ((reg & 0x7f) ^ ((reg >> 12) & 0x7f))=
; =20
>>
>> This is not good enough for the VIO devices with a user defined "reg".
>>
>> I propose to extract bits [29-28] and [16-12] to compose a 7bit index =
:
>>
>> 	(((reg >> 28) & 0x3) << 5) | ((reg >> 12) & 0x1f)
>>
>=20
> Looks good.

Thanks for the investigation you made in libvirt and the tests.=20

C.=20

>=20
>> That would give us a mapping :
>>
>> 	0x00000000  -> 0
>> 	0x00001000  -> 1
>> 		...
>> 	0x0001F000  -> 31
>> 	0x10000000  -> 32
>> 	0x10001000  -> 33
>> 		...
>> 	0x1001F000  -> 63
>> 	0x20000000  -> 64
>> 	0x20001000  -> 65
>> 		...
>> 	0x2001F000  -> 95
>> 	0x30000000  -> 96
>> 	0x30001000  -> 97
>> 		...
>> 	0x3001F000  -> 127
>>
>> C.
>>
>>
>=20
