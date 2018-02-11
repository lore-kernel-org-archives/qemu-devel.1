Received: from eggs.gnu.org ([2001:4830:134:3::10]:57822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1el0Xd-0008Oz-3p
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 17:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1el0X7-0002ta-7a
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 17:56:12 -0500
Message-ID: <1518389717.2312.245.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 12 Feb 2018 09:55:17 +1100
In-Reply-To: <20180211080831.GC11634@umbus.fritz.box>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<1516187433.31850.189.camel@kernel.crashing.org>
	<2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
	<1516224472.31850.193.camel@kernel.crashing.org>
	<20180211080831.GC11634@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/19] spapr: introduce a skeleton for
 the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On Sun, 2018-02-11 at 19:08 +1100, David Gibson wrote:
> On Thu, Jan 18, 2018 at 08:27:52AM +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2018-01-17 at 15:39 +0100, C=C3=A9dric Le Goater wrote:
> > > Migration is a problem. We will need both backend QEMU objects to b=
e=20
> > > available anyhow if we want to migrate. So we are back to the curre=
nt=20
> > > solution creating both QEMU objects but we can try to defer some of=
 the=20
> > > KVM inits and create the KVM device on demand at CAS time.
> >=20
> > Do we have a way to migrate a piece of info from the machine *first*
> > that indicate what type of XICS/XIVE to instanciate ?
>=20
> Nope.  qemu migration doesn't work like that.  Yes, it should, and
> everyone knows it, but changing it is a really long term project.

Well, we have a problem then. It looks like Qemu broken migration is
fundamentally incompatible with PAPR and CAS design...

I know we don't migrate the configuration, that's not exactly what I
had in mind tho... Can we have some piece of *data* from the machine be
migrated first, and use it on the target to reconfigure the interrupt
controller before the stream arrives ?

Otherwise, we have indeed no much choice but the horrible wart of
creating both interrupt controllers with only one "active".

> >=20
> > > The next problem is the ICP object that currently needs the KVM dev=
ice=20
> > > fd to connect the vcpus ... So, we will need to change that also.=20
> > > That is probably the biggest problem today. We need a way to discon=
nect=20
> > > the vpcu from the KVM device and see how we can defer the connectio=
n.
> > > I need to make sure this is possible, I can check that without XIVE
> >=20
> > Ben.
> >=20
>=20
>=20
