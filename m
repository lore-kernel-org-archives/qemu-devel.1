Received: from eggs.gnu.org ([2001:4830:134:3::10]:45349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fk483-00005B-Lp
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 05:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fk47y-0001zj-Sn
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 05:06:11 -0400
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:55486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fk47y-0001yU-Md
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 05:06:06 -0400
Received: from player759.ha.ovh.net (unknown [10.109.146.173])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 374801C13AD
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 11:06:03 +0200 (CEST)
References: <20180726133723.17041-1-clg@kaod.org>
	<20180726133723.17041-2-clg@kaod.org>
	<20180727035611.GG3694@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bd62d2e5-eab6-84c5-c110-dfd93768885d@kaod.org>
Date: Mon, 30 Jul 2018 11:05:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180727035611.GG3694@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 07/27/2018 05:56 AM, David Gibson wrote:
> On Thu, Jul 26, 2018 at 03:37:21PM +0200, C=E9dric Le Goater wrote:
>> This proposal introduces a new IRQ number space layout using static
>> numbers for all devices, depending on a device index, and a bitmap
>> allocator for the MSI IRQ numbers which are negotiated by the guest at
>> runtime.
>>
>> As the VIO device model does not have a device index but a "reg"
>> property, we introduce a formula to compute an IRQ number from a "reg"
>> value. It should minimize most of the collisions.
>>
>> The previous layout is kept in pre-3.1 machines raising the
>> 'legacy_irq_allocation' machine class flag.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> One nit left..
>=20
> [snip]
>> +static inline uint32_t spapr_vio_reg_to_irq(uint32_t reg)
>> +{
>> +    uint32_t irq;
>> +
>> +    if (reg >=3D SPAPR_VIO_REG_BASE) {
>> +        /*
>> +         * VIO device register values when allocated by QEMU. For
>> +         * these, we simply mask the high bits to fit the overall
>> +         * range: [0x00 - 0xff].
>> +         *
>> +         * The nvram VIO device (reg=3D0x71000000) is a static device=
 of
>> +         * the pseries machine and so is always allocated by QEMU. It=
s
>> +         * IRQ number is 0x0.
>> +         */
>> +        irq =3D reg & 0xff;
>> +
>> +    } else if (reg >=3D 0x30000000) {
>> +        /*
>> +         * VIO tty devices register values, when allocated by livirt,
>> +         * are mapped in range [0xf0 - 0xff], gives us a maximum of 1=
6
>> +         * vtys.
>> +         */
>> +        irq =3D 0xf0 | ((reg >> 12) & 0xf);
>> +
>> +    } else {
>> +        /*
>> +         * Other VIO devices register values, when allocated by
>> +         * livirt, are mapped in range [0x00 - 0xef].
>> +         */
>> +        irq =3D (reg >> 12) & 0xef;
>=20
> This mask doesn't do what you intend - it will map 0x10 to 0, for
> example.  You could use % 0xf0, but actually you might as well just
> use & 0xff.  Yes, it could collide with the vty devices, but either
> way you can still have collisions if you try hard enough.  And, either
> way, they'll get detected later.
>=20


David,

Shall I resend a v6 with this fix or should I wait for the patch adding=20
3.1. I could also send a 3.1 pseries machine also if you prefer.

Thanks,

C.
