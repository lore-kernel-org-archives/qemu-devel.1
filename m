Received: from eggs.gnu.org ([2001:4830:134:3::10]:49067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBwwB-0004t7-CV
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBww7-0007tt-Aa
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:32:55 -0400
Date: Fri, 27 Apr 2018 16:32:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180427063211.GO8800@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-4-clg@kaod.org>
	<20180423064644.GG19804@umbus.fritz.box>
	<8d1cb270-d62f-f08f-9167-3f130906f910@kaod.org>
	<20180424064629.GP19804@umbus.fritz.box>
	<3b57fde8-ee11-81a0-271b-9e514ed63856@kaod.org>
	<20180426035452.GE8800@umbus.fritz.box>
	<b11688ae-a08f-320f-2bb5-46262ccb6376@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="31zvzas5NXT9fief"
Content-Disposition: inline
In-Reply-To: <b11688ae-a08f-320f-2bb5-46262ccb6376@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 03/35] ppc/xive: introduce the
 XiveFabric interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--31zvzas5NXT9fief
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 12:30:42PM +0200, C=E9dric Le Goater wrote:
> On 04/26/2018 05:54 AM, David Gibson wrote:
> > On Tue, Apr 24, 2018 at 11:33:11AM +0200, C=E9dric Le Goater wrote:
> >> On 04/24/2018 08:46 AM, David Gibson wrote:
> >>> On Mon, Apr 23, 2018 at 09:58:43AM +0200, C=E9dric Le Goater wrote:
> >>>> On 04/23/2018 08:46 AM, David Gibson wrote:
> >>>>> On Thu, Apr 19, 2018 at 02:42:59PM +0200, C=E9dric Le Goater wrote:
> >>>>>> The XiveFabric offers a simple interface, between the XiveSourve
> >>>>>> object and the device model owning the interrupt sources, to forwa=
rd
> >>>>>> an event notification to the XIVE interrupt controller of the mach=
ine
> >>>>>> and if the owner is the controller, to call directly the routing
> >>>>>> sub-engine.
> >>>>>>
> >>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>>>> ---
> >>>>>>  hw/intc/xive.c        | 37 ++++++++++++++++++++++++++++++++++++-
> >>>>>>  include/hw/ppc/xive.h | 25 +++++++++++++++++++++++++
> >>>>>>  2 files changed, 61 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >>>>>> index 060976077dd7..b4c3d06c1219 100644
> >>>>>> --- a/hw/intc/xive.c
> >>>>>> +++ b/hw/intc/xive.c
> >>>>>> @@ -17,6 +17,21 @@
> >>>>>>  #include "hw/ppc/xive.h"
> >>>>>> =20
> >>>>>>  /*
> >>>>>> + * XIVE Fabric
> >>>>>> + */
> >>>>>> +
> >>>>>> +static void xive_fabric_route(XiveFabric *xf, int lisn)
> >>>>>> +{
> >>>>>> +
> >>>>>> +}
> >>>>>> +
> >>>>>> +static const TypeInfo xive_fabric_info =3D {
> >>>>>> +    .name =3D TYPE_XIVE_FABRIC,
> >>>>>> +    .parent =3D TYPE_INTERFACE,
> >>>>>> +    .class_size =3D sizeof(XiveFabricClass),
> >>>>>> +};
> >>>>>> +
> >>>>>> +/*
> >>>>>>   * XIVE Interrupt Source
> >>>>>>   */
> >>>>>> =20
> >>>>>> @@ -97,11 +112,19 @@ static bool xive_source_pq_trigger(XiveSource=
 *xsrc, uint32_t srcno)
> >>>>>> =20
> >>>>>>  /*
> >>>>>>   * Forward the source event notification to the associated XiveFa=
bric,
> >>>>>> - * the device owning the sources.
> >>>>>> + * the device owning the sources, or perform the routing if the d=
evice
> >>>>>> + * is the interrupt controller.
> >>>>>>   */
> >>>>>>  static void xive_source_notify(XiveSource *xsrc, int srcno)
> >>>>>>  {
> >>>>>> =20
> >>>>>> +    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xsrc->xive);
> >>>>>> +
> >>>>>> +    if (xfc->notify) {
> >>>>>> +        xfc->notify(xsrc->xive, srcno + xsrc->offset);
> >>>>>> +    } else {
> >>>>>> +        xive_fabric_route(xsrc->xive, srcno + xsrc->offset);
> >>>>>> +    }
> >>>>>
> >>>>> Why 2 cases?  Can't the XiveFabric object just make its notify equal
> >>>>> to xive_fabric_route if that's what it wants?
> >>>> Under sPAPR, all the sources, IPIs and virtual device interrupts,=20
> >>>> generate events which are directly routed by xive_fabric_route().=20
> >>>> There is no need of an extra hop. Indeed.=20
> >>>
> >>> Ok.
> >>>
> >>>> Under PowerNV, some sources forward the notification to the routing=
=20
> >>>> engine using a specific MMIO load on a notify address which is store=
d=20
> >>>> in one of the controller registers. So we need a hop to reach the=20
> >>>> device model, owning the sources, and do that load :
> >>>
> >>> Hm.  So you're saying that in pnv some sources send their notification
> >>> to some other unit,=20
> >>
> >> Not to any unit/device, to the device owning the sources.
> >>
> >> For the XiveSource object under PSI, the XIVEFabric interface is the=
=20
> >> PSI device object it self, which knows how to forward the notification=
=20
> >> on the XIVE Power "bus". To be more precise, the PSI HB device has=20
> >> 14 interrupt sources, which notifications are forwarded using a MMIO=
=20
> >> load to some address. The load address is configured (by skiboot) in=
=20
> >> one of the PSI device registers, and points to a MMIO region of the=20
> >> main XIVE interrupt controller.=20
> >>
> >> The PHB4 sources should be the same.
> >>
> >> For the XiveSource object (all interrupts) under sPAPRXive, the=20
> >> XIVEFabric is the main interrupt controller sPAPRXive.
> >>
> >> For the XiveSource object (IPIs) under PnvXive, the XIVEFabric is=20
> >> also the main interrupt controller PnvXive.
> >=20
> > Hrm.  Apparently I'm missing something, I'm really not getting what
> > you're trying to explain here.
>=20
> I see that. Let's try again.
>=20
> >>> that would then (after possible masking) forward on to the overall> x=
ive fabric ?=20
> >>
> >> yes. May be XIVEFabric is a confusing name. What about XIVEForwarder ?=
=20
> >=20
> > Maybe..?
> >=20
> >>> That seems like a property of the source object,=20
> >>
> >> The source object is generic. It's a bunch of PQ bits that can be=20
> >> controlled by MMIOs. Nothing more.
> >=20
> > Hmm.  Isn't the source object also responsible for forwarding the
> > interrupt to something up the chain (whatever that is)?
>=20
> Yes but it can not forward directly. The XiveSource is generic and=20
> can only call a handler :
>=20
> 	xfc->notify(xsrc->xive, srcno + xsrc->offset);

But.. your patch doesn't do that always, it's conditional which I
still don't understand.

> The device model owner, the parent of the XiveSource object, would=20
> do the real forward.

Why?  I mean the XiveSource basically represents the xive irq related
logic of the PHB or whatever, why would it not represent *all* of
that, rather than just the ESB bits, meaning the owner has to have
some more xive logic for the forwarding.

Note that I don't think the fact that some sources notify via mmio and
some are internal really matters.  It's not like we're modelling the
power bus down to the wire-transaction level.

> It's very similar to what we have today with XICS :
>=20
> 	- The sPAPR model has an ICSState =20
> 	- The PnvPSI model has an ICSState=20
> 	- The PnvPHB3 model has two ICSStates
>=20
> and the 'xics' pointer in ICSState points to the 'interrupt unit' of=20
> the machine to do resends and to grab ICPs. So it used for routing=20
> essentially.

Hmm.  I think you and I are looking at XICSFabric kind of
differently.  As I see it, it's not really an active component at
all.  Rather it's basically a global "map" of the xics components so
that they can find each other.

> in Xive=20
>=20
> 	- sPAPRXive model has a XiveSource
> 	- PnvXive model has a XiveSource
> 	- PnvPSI model has a XiveSource
> 	- PnvPHB4 model should have also.
>=20
> and the 'xive' pointer in XiveSource points to the parent object,

Uh.. yeah.. the xics pointer in ICS units doesn't point to the parent
object, except maybe by accident.  It's absolutely intended to be
global, and so points to the machine.

> which will handle the event notification forwarding or routing.

Ok, how about this for a partial model.  We have:

XiveSource objects:
	* Owns an ESB table
	* Knows the mapping of its local irq offsets to global irq
	  numbers
	* Provides the mmio interface for ESB manipulation
	* When neccessary, notifies a new interrupt to a XiveRouter

XiveRouter objects:
	* Responsible for a fixed range of global irq numbers
	* Owns an IVT (but what that means can vary, see below)
	* When notified of an irq, routes it to the appropriate EQ
	  (haven't thought about this part yet)
	* Abstract class - needs subclasses to define how to get IVEs

XiveFabric interface:
	* Lets XIVE components locate each other
	* get_router() method: maps a global irq number to XiveRouter
	  object
	* Always global (implemented on the machine)

On pseries we have:

	? XiveSource objects.  We probably only need one, but 1 for
	LSI and one for MSI might be convenient.  More wouldn't break
	the model

	1 sPAPRXiveRouter.  This is a subclass of XiveRouter that
	holds the IVT internall (and migrates it).

	the XiveFabric implementation always returns the single global
	router for get_router()

On powernv we have:
	N XiveSource objects.  Some in PHBs, some extra ones on each
	chip

	(#chips) PowerXiveRouter objects.  This subclass of XiveRouter
	stores the register giving the IVT base address and migrates
	that, but the IVT contents are in RAM

	the XiveFabric get_router() implementation returns the right
	chip's router based on the irq number

Obviously the router->EQ sides still needs a bunch of thought.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--31zvzas5NXT9fief
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlriw+kACgkQbDjKyiDZ
s5JylQ/+OCgor55s6j7Uu/Ol0/xVFyNTMHdMjXyqYOGu69y9SiVNU/8mxYUzcyxT
W4muA+JDzPsTYY9cJ4s6PH8L/kyAxcEayv7YPlQfR2sg+jUK9yoNrQFLfXusU6H1
jAjMwMsyZfcVGV9AEfnfBWOilO32y4BYOLGwU906/SH2WgbyRtbym/ZJeVyTGiMd
27hmZjAXo9YEshTuY14mhI9i7pmiBNxGkTKt4EVqy2y+7uqU1w/i9x1gp3i7VB6J
tgrrs3AwNLXUyxZCNUWefeiRFDpF9TQE8MmdhrUAUEigRnYa6UIJXfJGvheun28Q
2NhvF7n6X2bKpCZxdTAuOlV3TKJwAazdqFkQGP3szEHMe4Oy9jQIRVAIhVkNfJgO
8uX8v9qFtvXefIon1MKe8OFIxmYRAW2GDTMTRSEplBrJlgF5+s3i0Tj75BuGi17G
kjSQRUC95lumQu7YrriugOfSZ5zWNAKHD9l2VU7DjIzxDCePzUjrtFShRQwEcI9s
xChwuvLGNnAjOt+Wj/8CuLb+yzzpMk/Dv7eIacl7xKXwfbI8etiHY8K+cTUJLl40
V6ysGacE2NNZ2EIbflyJ0oZvD2Jc0e7lc6Lcgj0KXPPySDB/ghfdhi3/rG1l3i1W
E2H+aDIxpg2pqKcwT435NT0yFrFfb+1noyOUO6RNX0+4QvgTNEU=
=GVxn
-----END PGP SIGNATURE-----

--31zvzas5NXT9fief--
