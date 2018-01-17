Received: from eggs.gnu.org ([2001:4830:134:3::10]:40679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eblcb-0001WS-UH
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eblcR-0001jT-To
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:11:09 -0500
Message-ID: <1516187433.31850.189.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 17 Jan 2018 22:10:33 +1100
In-Reply-To: <683d0912-ad48-927c-8235-5358417be44c@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
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
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On Wed, 2018-01-17 at 10:18 +0100, C=C3=A9dric Le Goater wrote:
> > > > Also, have we decided how the process of switching between XICS a=
nd
> > > > XIVE will work vs. CAS ?=20
> > >=20
> > > That's how it is described in the architecture. The current choice =
is
> > > to create both XICS and XIVE objects and choose at CAS which one to
> > > use. It relies today on the capability of the pseries machine to=20
> > > allocate IRQ numbers for both interrupt controller backends. These
> > > patches have been merged in QEMU.
> > >=20
> > > A change of interrupt mode results in a reset. The device tree is=20
> > > populated accordingly and the ICPs are switched for the model in=20
> > > use.=20
> >=20
> > For KVM we need to only instanciate one of them though.
>=20
> Hmm,
>=20
> How would we handle a guest rebooting on a kernel without XIVE support =
?=20

It will do CAS again and we can change the devices.

> Are you suggesting to create the XICS or XIVE device in the CAS negotia=
tion=20
> process ? So, the machine would not have any interrupt controller befor=
e=20
> CAS. That seems really late to me. grub uses the console for instance.=20

We start with XICS by default.

> I think it should prepare for both options, start in XIVE legacy mode,=20
> which is XICS, then possibly switch to XIVE exploitation mode.
>=20
> > > > And how that will interact with KVM ?=20
> > >=20
> > > I expect we will do the same, which is to create two KVM devices to=
=20
> > > be able to handle both interrupt controller backends depending on t=
he=20
> > > mode negotiated by the guest. =20
> >=20
> > That will be an ungodly mess, I'd rather we only instanciate the righ=
t
> > one.
>=20
> It's rather transparent currently in the emulated version. There are tw=
o=20
> sets of objects in QEMU, switching is done in CAS. KVM support should n=
ot=20
> change anything in that area.=20
>=20
> I expect the 'xive-kvm' object to get/set states for migration, just li=
ke=20
> for XICS and to setup the ESB+TIMA memory regions, which is new.=20

But both XICS and XIVE are completely different kernel KVM devices that w=
ill
need to "hook" into the same set of internal hooks for things like interr=
upts
being passed through, RTAS calls etc...=20

How does KVM knows which one to "activate" ?

I don't think the kernel should have both.=20

> > > > I was
> > > > thinking the kernel would implement a different KVM device type, =
ie
> > > > the "emulated XICS" would remain KVM_DEV_TYPE_XICS and XIVE would=
 be
> > > > KVM_DEV_TYPE_XIVE.
> > >=20
> > > yes. it makes sense. The new device will have a lot in common with =
the=20
> > > KVM_DEV_TYPE_XICS using kvm_xive_ops.
> >=20
> > Ben.
> >=20
