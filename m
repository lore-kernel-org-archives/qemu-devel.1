Received: from eggs.gnu.org ([2001:4830:134:3::10]:54345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g0Nx4-0007O5-S0
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 05:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g0Nx1-0006Hw-Ja
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 05:30:18 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:44837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g0Nx1-0006DF-D4
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 05:30:15 -0400
Received: from player760.ha.ovh.net (unknown [10.109.159.62])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id D52AEF4AA0
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 11:30:06 +0200 (CEST)
References: <20180911055503.2303-1-clg@kaod.org>
	<20180911055503.2303-3-clg@kaod.org>
	<20180913022534.GU7978@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <40d86635-fe58-f642-336d-c1df91344073@kaod.org>
Date: Thu, 13 Sep 2018 11:30:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180913022534.GU7978@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] spapr: increase the size of the IRQ
 number space
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

On 09/13/2018 04:25 AM, David Gibson wrote:
> On Tue, Sep 11, 2018 at 07:55:03AM +0200, C=E9dric Le Goater wrote:
>> The new layout using static IRQ number does not leave much space to
>> the dynamic MSI range, only 0x100 IRQ numbers. Increase the total
>> number of IRQS for newer machines and introduce a legacy XICS backend
>> for pre-3.1 machines to maintain compatibility.
>>
>> For the old backend, provide a 'nr_msis' value covering the full IRQ
>> number space as it does not use the bitmap allocator to allocate MSI
>> interrupt numbers.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Applied to ppc-for-3.1, thanks.

I think we are ready for Xive now ?

The patchset is organized as below. The patches tagged v4 have not change=
d but the others have and a resend will be needed.=20

* Device models for Source, Router, EQs, Presenter, Controller :

  ppc/xive: introduce a XIVE interrupt source model (v4)
  ppc/xive: add support for the LSI interrupt sources (v4)
  ppc/xive: introduce the XiveFabric interface (v4)
  ppc/xive: introduce the XiveRouter model (v4)
  ppc/xive: introduce the XIVE Event Queues (v4)
  ppc/xive: add support for the EQ Event State buffers (v4)
  ppc/xive: introduce the XIVE interrupt thread context (v4)
  ppc/xive: introduce a simplified XIVE presenter (v4)
  ppc/xive: notify the CPU when the interrupt priority is more privileged=
 (v4)
  spapr/xive: introduce a XIVE interrupt controller (v4)
  spapr/xive: use the VCPU id as a VP identifier (v5)

* Integration in the sPAPR machine (we can add pnv also)

  spapr: initialize VSMT before initializing the IRQ backend  (v5)
  spapr: introdude a new machine IRQ backend for XIVE  (v5)
  spapr: add hcalls support for the XIVE exploitation interrupt mode  (v5=
)
  spapr: add device tree support for the XIVE exploitation mode  (v5)
  spapr: allocate the interrupt thread context under the CPU core  (v5)
  spapr: add a 'pseries-3.1-xive' machine type (v5)


* KVM support (KVM XIVE device interfaces)

  spapr: add classes for the XIVE models (v5+)
  target/ppc/kvm: add Linux KVM definitions for XIVE (v5+)
  spapr/xive: add models for KVM support (v5+)
 =20
* KVM migration (more KVM XIVE device interfaces)

  spapr/xive: add migration support for KVM (v5+)
  spapr: fix XICS migration  (v5+)


Greg is giving it some tests on TCG and now KVM as XIVE is a building=20
block for the OpenCAPI passthrough.=20

Thanks,

C.
