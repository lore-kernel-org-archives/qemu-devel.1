Received: from eggs.gnu.org ([2001:4830:134:3::10]:51875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eRBXH-0002VA-MW
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 01:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eRBXC-0002qB-PD
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 01:37:55 -0500
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:47881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eRBXC-0002mo-IS
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 01:37:50 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 03B019178A
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 07:37:40 +0100 (CET)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-4-clg@kaod.org>
	<0876c4bd-676f-276d-3cf6-aef4a2a562e5@kaod.org>
	<1513558781.2533.0.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5498d8f1-d0a9-c3fd-caa4-8b17867db2c2@kaod.org>
Date: Tue, 19 Dec 2017 07:37:31 +0100
MIME-Version: 1.0
In-Reply-To: <1513558781.2533.0.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/19] spapr: introduce the XIVE
 interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

On 12/18/2017 01:59 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2017-12-14 at 16:24 +0100, C=C3=A9dric Le Goater wrote:
>> The API between the source and the IVRE is extremely simple :
>>
>>   static void spapr_xive_irq(sPAPRXive *xive, int lisn)
>>
>> The IVRE then scans its IVT, finds the EQ, and moves on to the=20
>> presenter.
>=20
> In HW it's an MMIO store between the two units (from the source to the
> IVRE notification port). I wonder in the long run if we should model
> that the same way...

It's a problem for PowerNV. IVSEs should all have an 'IVT offset'=20
register and a 'notify trigger port address' address register for=20
this purpose. Real HW performs a 4bytes store of the IRQ number=20
to forward the notification to the IVRE. It even makes the model=20
a little simpler because we don't have to look for the appropriate=20
PnvXive object to handle the routing. =20

For sPAPR, we don't have such MMIOs but still, we could trigger=20
directly the sPAPRXive object without using the qemu_irq objects
which stand in the middle. XIVE IPIs don't use them at all and
only use MMIOs.   =20

>> So, we can keep the IVRE engine (sPAPRXive) attached directly to=20
>> the machine like we have today, this is good, and introduce multiple=20
>> XIVE source objects. The sPAPR machine would have :=20
>>
>>  - one for the IPIs [ 0 - nr_servers ]
>>  - one generic for the devices [ 4096 -  ]
>>  - one for each phb ?=20
>>
>> The source address in the overall ESB MMIO region would be calculated=20
>> from the offset of the source IRQ numbers in the IRQ number space.=20
>> The offset could very well be hardcoded for each device. I don't see=20
>> any XICS compatibility problems as we are sharing correctly the IRQ=20
>> number space already.
>>
>>
>> I am starting this discussion because the support for XIVE in the=20
>> QEMU PowerNV machine will need multiple sources, just like for=20
>> POWER8. PnvXive will be a bit different because the IVRE tables=20
>> (IVT and EQDT) are in the virtual machine memory. Most of the settings=
=20
>> are done in the VM. The QEMU PowerNV machine will still have to=20
>> implement the triggering and the routing logic using the guest tables.=
=20
