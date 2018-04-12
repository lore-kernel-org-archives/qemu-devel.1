Received: from eggs.gnu.org ([2001:4830:134:3::10]:51916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6UcY-000714-04
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 01:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6UcU-0005Pu-My
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 01:18:05 -0400
Date: Thu, 12 Apr 2018 15:10:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180412051031.GM9425@umbus.fritz.box>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C01fF7hLGvN0zd9s"
Content-Disposition: inline
In-Reply-To: <683d0912-ad48-927c-8235-5358417be44c@kaod.org>
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
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--C01fF7hLGvN0zd9s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 10:18:43AM +0100, C=E9dric Le Goater wrote:
> >>> Also, have we decided how the process of switching between XICS and
> >>> XIVE will work vs. CAS ?=20
> >>
> >> That's how it is described in the architecture. The current choice is
> >> to create both XICS and XIVE objects and choose at CAS which one to
> >> use. It relies today on the capability of the pseries machine to=20
> >> allocate IRQ numbers for both interrupt controller backends. These
> >> patches have been merged in QEMU.
> >>
> >> A change of interrupt mode results in a reset. The device tree is=20
> >> populated accordingly and the ICPs are switched for the model in=20
> >> use.=20
> >=20
> > For KVM we need to only instanciate one of them though.
>=20
> Hmm,
>=20
> How would we handle a guest rebooting on a kernel without XIVE support ?=
=20
> Are you suggesting to create the XICS or XIVE device in the CAS negotiati=
on=20
> process ? So, the machine would not have any interrupt controller before=
=20
> CAS. That seems really late to me. grub uses the console for instance.=20
>=20
> I think it should prepare for both options, start in XIVE legacy mode,=20
> which is XICS, then possibly switch to XIVE exploitation mode.

I think for our first draft we should have XIVE and XICS based
platforms as separate machine types (or a machine option, I guess).

We do want to allow this to be autonegotiated, but I feel like
emphasising that at the beginning is causing unnatural design
decisions in the XIVE model itself.

>=20
> >>> And how that will interact with KVM ?
> >>
> >> I expect we will do the same, which is to create two KVM devices to=20
> >> be able to handle both interrupt controller backends depending on the=
=20
> >> mode negotiated by the guest. =20
> >=20
> > That will be an ungodly mess, I'd rather we only instanciate the right
> > one.
>=20
> It's rather transparent currently in the emulated version. There are two=
=20
> sets of objects in QEMU, switching is done in CAS. KVM support should not=
=20
> change anything in that area.=20
>=20
> I expect the 'xive-kvm' object to get/set states for migration, just like=
=20
> for XICS and to setup the ESB+TIMA memory regions, which is new.=20
>=20
> C.=20
> =20
> >>> I was
> >>> thinking the kernel would implement a different KVM device type, ie
> >>> the "emulated XICS" would remain KVM_DEV_TYPE_XICS and XIVE would be
> >>> KVM_DEV_TYPE_XIVE.
> >>
> >> yes. it makes sense. The new device will have a lot in common with the=
=20
> >> KVM_DEV_TYPE_XICS using kvm_xive_ops.
> >=20
> > Ben.
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C01fF7hLGvN0zd9s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrO6kcACgkQbDjKyiDZ
s5I0LA//XsH8/L/uG5pUNsZjKm1e0rbf2/8ecZ4Bct9YdS/cGbJjIR3RRyGGT1wA
HW17Dr2lQcCIGeBusHWLJKhss0qXi5x7tFIyrc644totKRCFvxTRVed5+OswoEC5
cYiNiDOA9xyXmBYPx8wfxjVFcZ2VrwtiP3vf9qTBkFlJIih4BVqE2cNH6bf2Esgv
hFPhHercL5uqzVSVyw+wjkDTBvUCr4ZObMoawntqvsd27fwN7qnkBkIgki9OWvNy
INe+OLpMiPbEI6TT90TTLJE1SI+sJbzkfJEc7qqfuZLiihzKhgTHsB+s0hKSHT6H
stZwCVmpVjKVAKyZf4sshEIgU1lGUjWu4g40n6eQGaY3YwcIF2aEmXIHGcyR6+Pp
+Ftpd3l/k8p57kU5N6/hgs2FwK7RVQD9CoMebQK+hpBEfwHCGT5REmRh5Y+4uUgX
iswf0hWM6XhGvOF87UsDVjpJkLz+1T9BI9accUUoBicbmbKWV3tU4BWBSBC8P1Pe
izmGZ6afMnQth+bZWYqqP34Gm0uX3QrINNDmGdAuPI8Z75Sy0SyDpozmsjfTxD1T
5uQijlZA0PNZFJzqIPg2LiFGO+/i+80HT+O+4PdYefihupz7dMj6/UYLxjW2NzoK
r7RzOQbr7Bln5oWHJHmG9ue8j6CUR6jrRMtAKZPX1GjzTuFiJSY=
=E+cj
-----END PGP SIGNATURE-----

--C01fF7hLGvN0zd9s--
