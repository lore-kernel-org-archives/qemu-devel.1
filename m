Received: from eggs.gnu.org ([2001:4830:134:3::10]:34505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fbQlo-0000Wo-T1
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fbQlj-0000et-Vu
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:27:32 -0400
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:52898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fbQlj-0000eT-Ov
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:27:27 -0400
Received: from player739.ha.ovh.net (unknown [10.109.105.97])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 05A2510B5F9
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 15:27:25 +0200 (CEST)
References: <20180706090713.15712-1-clg@kaod.org>
	<20180706090713.15712-2-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <28391e09-2e15-6050-e452-0493172a73a4@kaod.org>
Date: Fri, 6 Jul 2018 15:27:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180706090713.15712-2-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

  > +/*
> + * The register property of a VIO device is defined in livirt using a
> + * base number + 0x1000 increment and in QEMU by incrementing the base
> + * register number 0x71000000.
> + *
> + * The formula below tries to compute a unique index number from the
> + * register value that will be used to define the IRQ number of the
> + * VIO device. A maximum of 256 (0x100) VIO devices is covered.
> + *
> + * To minimize collisions, we define two distinct ranges depending on
> + * the "reg" value definition:
> + *
> + *     [0x00 - 0x7f]    user/libvirt
> + *     [0x80 - 0xff]    QEMU VIO model
> + *
> + * Collisions will be detected when the IRQ is claimed.
> + */
> +static inline uint32_t spapr_vio_reg_to_irq(uint32_t reg)
> +{
> +    if (reg >= SPAPR_VIO_REG_BASE) {
> +        return SPAPR_IRQ_VIO | (reg & 0x7f) | 0x80;
> +    } else {
> +        return SPAPR_IRQ_VIO | ((reg & 0x7f) ^ ((reg >> 12) & 0x7f));

This is not good enough for the VIO devices with a user defined "reg".

I propose to extract bits [29-28] and [16-12] to compose a 7bit index :

	(((reg >> 28) & 0x3) << 5) | ((reg >> 12) & 0x1f)

That would give us a mapping :

	0x00000000  -> 0
	0x00001000  -> 1
		...
	0x0001F000  -> 31
	0x10000000  -> 32
	0x10001000  -> 33
		...
	0x1001F000  -> 63
	0x20000000  -> 64
	0x20001000  -> 65
		...
	0x2001F000  -> 95
	0x30000000  -> 96
	0x30001000  -> 97
		...
	0x3001F000  -> 127

C.
