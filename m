Received: from eggs.gnu.org ([2001:4830:134:3::10]:58309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciAGy-0007iS-79
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 20:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciAGv-0003Hw-34
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 20:38:44 -0500
Date: Mon, 27 Feb 2017 12:00:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170227010024.GL17615@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-17-git-send-email-clg@kaod.org>
	<20170223024238.GB12577@umbus.fritz.box>
	<6eb9d5d8-ea57-dc2b-afd7-7796b7e3295b@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9j9z4uig7ElIUlwi"
Content-Disposition: inline
In-Reply-To: <6eb9d5d8-ea57-dc2b-afd7-7796b7e3295b@kaod.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 16/22] ppc/xics: register the
 reset handler of ICP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--9j9z4uig7ElIUlwi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 12:27:35PM +0100, C=E9dric Le Goater wrote:
> On 02/23/2017 03:42 AM, David Gibson wrote:
> > On Thu, Feb 16, 2017 at 02:47:39PM +0100, C=E9dric Le Goater wrote:
> >> The reset of the ICP objects is currently handled by XICS but this can
> >> be done for each individual ICP.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Hrm.  I think whether device_reset() gets called automatically depends
> > on how the device is wired into the composition tree, and I'm not sure
> > the icps are in the right place for it to work.
>=20
> reset gets called only if it under sysbus or if you have registered=20
> a reset_handler. previously, XICS was a sysbus object so=20
> xics_common_reset() was getting called automatically.

Right.  Hmm.  So I think artificially placing the ics under the sysbus
is not the right way to get the reset called - I think explicitly
registering a reset handler is better.

The only thing that concerns me about that is that the MMIO ICS
variants we'll want for powernv really _do_ have a bus presence,
either on sysbus or some descendent, so that will get its reset called
automatically.  I'm not sure what the best way to ensure the reset
gets called exactly once in all cases.

> > This doesn't replace the code in xics_common_reset() so if it does
> > work it means we must have previously been resetting the ICPs twice.
> > Is that right?
>=20
> no. but there has been some confusion with the recent changes
> on XICS.
>=20
> What replace the code in xics_common_reset() is :
>=20
> 	qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());
>=20
> That's how the reset handlers get called from QOM objects.

Right, I saw that later on.

>=20
> C.
>=20
> >> ---
> >>  hw/intc/xics.c | 18 ------------------
> >>  hw/ppc/spapr.c |  1 +
> >>  2 files changed, 1 insertion(+), 18 deletions(-)
> >>
> >> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> >> index dd41340d41a5..3ad7e8cf8ec4 100644
> >> --- a/hw/intc/xics.c
> >> +++ b/hw/intc/xics.c
> >> @@ -137,29 +137,11 @@ static void ics_simple_pic_print_info(InterruptS=
tatsProvider *obj,
> >>  /*
> >>   * XICS Common class - parent for emulated XICS and KVM-XICS
> >>   */
> >> -static void xics_common_reset(DeviceState *d)
> >> -{
> >> -    XICSState *xics =3D XICS_COMMON(d);
> >> -    int i;
> >> -
> >> -    for (i =3D 0; i < xics->nr_servers; i++) {
> >> -        device_reset(DEVICE(&xics->ss[i]));
> >> -    }
> >> -}
> >> -
> >> -static void xics_common_class_init(ObjectClass *oc, void *data)
> >> -{
> >> -    DeviceClass *dc =3D DEVICE_CLASS(oc);
> >> -
> >> -    dc->reset =3D xics_common_reset;
> >> -}
> >> -
> >>  static const TypeInfo xics_common_info =3D {
> >>      .name          =3D TYPE_XICS_COMMON,
> >>      .parent        =3D TYPE_DEVICE,
> >>      .instance_size =3D sizeof(XICSState),
> >>      .class_size    =3D sizeof(XICSStateClass),
> >> -    .class_init    =3D xics_common_class_init,
> >>  };
> >> =20
> >>  /*
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 9c1772f93155..445d9a6ddad4 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -130,6 +130,7 @@ static XICSState *try_create_xics(sPAPRMachineStat=
e *spapr,
> >>          ICPState *icp =3D &xics->ss[i];
> >> =20
> >>          object_initialize(icp, sizeof(*icp), type_icp);
> >> +        qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());
> >>          object_property_add_child(OBJECT(xics), "icp[*]", OBJECT(icp)=
, NULL);
> >>          object_property_add_const_link(OBJECT(icp), "xics", OBJECT(xi=
cs), NULL);
> >>          object_property_set_bool(OBJECT(icp), true, "realized", &err);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9j9z4uig7ElIUlwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYs3ooAAoJEGw4ysog2bOSk5EQAJnxUh7RCCr+Dl+LB/YyDI2i
SfumH/1QFWA+YB+h1g2eWmgaEOBMMkNAAQIbs7WY/mXbf5WD1GDEVULavCN4XD/b
TAHpH2Ra8OVXXilgRFktqeWPSPZmrFoOsc2d6BnxOB1l6J8dvDL566OvMAa8vHvA
YGH+5UjrRDuWPkEwauYKb34SuIU6swpAUBkcTduP5jkJ4lkBsbN1HyzVdF3LyPPI
DA1HkYhVuAbhJqN2Jb7Hr0itLeIcfQ49heOSmYEYXtLjwxIcRXZ0sASURD3GD+T7
bE/T+Bg9MyYKLQuLGuR71fLvkrPPldU+eJolTK4Fa4SbaEyFpMmojlKWHEtmE3QB
3z204E8MctgL4IfazY/V45oSUtErWRj+gA1kYtQdgqFsCAzaA5IaShU1IandyP9u
2wNURfyTxobnAmMkuK/sbYURBS0CkEmTEcvqKJP9T2t+cy93b9pSl3NPQ3IoHtNE
HyX/RnZrFumrVv6krpjrhaG3C5z93FCnU/9oLKyuUa8sZAY5kGB+Mt9iFvECCrD4
pNN9X0kDaUkOHO4WPHgvY42qn+PLDMcEMEy1W8hZmjtu18Ua9zm7n0Iu2+ZjQjnB
NpXF8uW9K5V1d1Rig0KsMSO2lgOdKsX39gauUapDRDtVqyQ/PLqV3XxofWdLrZJR
GJkBIT4HP7MyiYtufJyT
=HaL8
-----END PGP SIGNATURE-----

--9j9z4uig7ElIUlwi--
