Received: from eggs.gnu.org ([2001:4830:134:3::10]:45376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fbRXa-0002Yz-AI
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fbRXV-0002yd-9J
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:16:54 -0400
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:55256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fbRXV-0002xz-3L
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:16:49 -0400
Received: from player734.ha.ovh.net (unknown [10.109.105.107])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 6BE711C2122
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 16:16:47 +0200 (CEST)
Date: Fri, 6 Jul 2018 16:16:38 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180706161638.07032b4f@bahia.lan>
In-Reply-To: <28391e09-2e15-6050-e452-0493172a73a4@kaod.org>
References: <20180706090713.15712-1-clg@kaod.org>
	<20180706090713.15712-2-clg@kaod.org>
	<28391e09-2e15-6050-e452-0493172a73a4@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri, 6 Jul 2018 15:27:17 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

>   > +/*
> > + * The register property of a VIO device is defined in livirt using a
> > + * base number + 0x1000 increment and in QEMU by incrementing the base
> > + * register number 0x71000000.
> > + *
> > + * The formula below tries to compute a unique index number from the
> > + * register value that will be used to define the IRQ number of the
> > + * VIO device. A maximum of 256 (0x100) VIO devices is covered.
> > + *
> > + * To minimize collisions, we define two distinct ranges depending on
> > + * the "reg" value definition:
> > + *
> > + *     [0x00 - 0x7f]    user/libvirt
> > + *     [0x80 - 0xff]    QEMU VIO model
> > + *
> > + * Collisions will be detected when the IRQ is claimed.
> > + */
> > +static inline uint32_t spapr_vio_reg_to_irq(uint32_t reg)
> > +{
> > +    if (reg >=3D SPAPR_VIO_REG_BASE) {
> > +        return SPAPR_IRQ_VIO | (reg & 0x7f) | 0x80;
> > +    } else {
> > +        return SPAPR_IRQ_VIO | ((reg & 0x7f) ^ ((reg >> 12) & 0x7f)); =
=20
>=20
> This is not good enough for the VIO devices with a user defined "reg".
>=20
> I propose to extract bits [29-28] and [16-12] to compose a 7bit index :
>=20
> 	(((reg >> 28) & 0x3) << 5) | ((reg >> 12) & 0x1f)
>=20

Looks good.

> That would give us a mapping :
>=20
> 	0x00000000  -> 0
> 	0x00001000  -> 1
> 		...
> 	0x0001F000  -> 31
> 	0x10000000  -> 32
> 	0x10001000  -> 33
> 		...
> 	0x1001F000  -> 63
> 	0x20000000  -> 64
> 	0x20001000  -> 65
> 		...
> 	0x2001F000  -> 95
> 	0x30000000  -> 96
> 	0x30001000  -> 97
> 		...
> 	0x3001F000  -> 127
>=20
> C.
>=20
>=20
