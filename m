Received: from eggs.gnu.org ([2001:4830:134:3::10]:54791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ftEAn-0002r2-Ti
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ftEAk-0004kj-On
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:38:53 -0400
Received: from 10.mo1.mail-out.ovh.net ([178.32.96.102]:45746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ftEAk-0004k5-II
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:38:50 -0400
Received: from player755.ha.ovh.net (unknown [10.109.146.143])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 4BDD611F38A
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 17:38:49 +0200 (CEST)
Date: Fri, 24 Aug 2018 17:38:39 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180824173839.03f8c29b@bahia.lan>
In-Reply-To: <7a3389a5-ffc5-58d9-659d-fbc46e88ca24@kaod.org>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
	<20180821043343.7514-26-david@gibson.dropbear.id.au>
	<CAFEAcA8k7u6HoAuS3v-FUzDA37-1a9Sy=QrqXvJVEKjRtCWsAA@mail.gmail.com>
	<7a3389a5-ffc5-58d9-659d-fbc46e88ca24@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 25/26] spapr_pci: factorize the use of
 SPAPR_MACHINE_GET_CLASS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Laurent Vivier <lvivier@redhat.com>

On Fri, 24 Aug 2018 17:30:12 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 08/24/2018 05:09 PM, Peter Maydell wrote:
> > On 21 August 2018 at 05:33, David Gibson <david@gibson.dropbear.id.au> =
wrote: =20
> >> From: C=C3=A9dric Le Goater <clg@kaod.org>
> >>
> >> It should save us some CPU cycles as these routines perform a lot of
> >> checks.
> >>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >> ---
> >>  hw/ppc/spapr_pci.c | 11 ++++++-----
> >>  1 file changed, 6 insertions(+), 5 deletions(-) =20
> >=20
> > Hi; Coverity points out in CID 1395183 that there's a bug in
> > this part of this patch:
> >  =20
> >> @@ -1558,6 +1559,7 @@ static void spapr_phb_realize(DeviceState *dev, =
Error **errp)
> >>      sPAPRMachineState *spapr =3D
> >>          (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
> >>                                                    TYPE_SPAPR_MACHINE);
> >> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr); =20
> >=20
> > This has moved the call to SPAPR_MACHINE_GET_CLASS() above
> > the check for "is spapr NULL", which is wrong, because it
> > will unconditionally dereference the pointer you pass to it. =20
>=20

I've sent a trivial patch to fix this.

> I see. This is a simple fix but the root reason for this check is=20
> commit f7d6bfcdc0fe ("spapr_pci: fail gracefully with non-pseries=20
> machine types").=20
>=20

Yeah, we also have one in spapr_cpu_core_realize() for the very
same reason.

> Is there a way to specify which device type can or can not be=20
> plugged on a machine ?=20
>=20
> I suppose we cannot use :=20
>=20
> 	machine_class_allow_dynamic_sysbus_dev()=20
>=20
> for cold plugged devices. Or can we ? That would be better.
>=20

Hmm... not sure this would help. The root problem is that many
places in spapr_pci and spapr_cpu_core assume the machine is
sPAPR.

> Thanks,
>=20
> C.
