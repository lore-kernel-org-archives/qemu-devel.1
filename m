Received: from eggs.gnu.org ([2001:4830:134:3::10]:37952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f7vli-0004Bn-Qz
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 00:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f7vle-0002iZ-RV
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 00:29:30 -0400
Date: Mon, 16 Apr 2018 14:29:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180416042914.GD20551@umbus.fritz.box>
References: <6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<1516187433.31850.189.camel@kernel.crashing.org>
	<2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
	<1516224472.31850.193.camel@kernel.crashing.org>
	<20180211080831.GC11634@umbus.fritz.box>
	<1518389717.2312.245.camel@kernel.crashing.org>
	<20180412051653.GO9425@umbus.fritz.box>
	<d5ed04f5-6b8e-6844-eadb-badfb7c6bd73@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <d5ed04f5-6b8e-6844-eadb-badfb7c6bd73@kaod.org>
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


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 10:36:10AM +0200, C=E9dric Le Goater wrote:
> On 04/12/2018 07:16 AM, David Gibson wrote:
> > On Mon, Feb 12, 2018 at 09:55:17AM +1100, Benjamin Herrenschmidt wrote:
> >> On Sun, 2018-02-11 at 19:08 +1100, David Gibson wrote:
> >>> On Thu, Jan 18, 2018 at 08:27:52AM +1100, Benjamin Herrenschmidt wrot=
e:
> >>>> On Wed, 2018-01-17 at 15:39 +0100, C=E9dric Le Goater wrote:
> >>>>> Migration is a problem. We will need both backend QEMU objects to b=
e=20
> >>>>> available anyhow if we want to migrate. So we are back to the curre=
nt=20
> >>>>> solution creating both QEMU objects but we can try to defer some of=
 the=20
> >>>>> KVM inits and create the KVM device on demand at CAS time.
> >>>>
> >>>> Do we have a way to migrate a piece of info from the machine *first*
> >>>> that indicate what type of XICS/XIVE to instanciate ?
> >>>
> >>> Nope.  qemu migration doesn't work like that.  Yes, it should, and
> >>> everyone knows it, but changing it is a really long term project.
> >>
> >> Well, we have a problem then. It looks like Qemu broken migration is
> >> fundamentally incompatible with PAPR and CAS design...
> >=20
> > Hrm, the fit is very clunky certainly, but i think we can make it work.
> >=20
> >> I know we don't migrate the configuration, that's not exactly what I
> >> had in mind tho... Can we have some piece of *data* from the machine be
> >> migrated first, and use it on the target to reconfigure the interrupt
> >> controller before the stream arrives ?
> >=20
> > Sorta.. maybe.. but it would probably get really ugly if we don't
> > preserve the usual way object lifetimes work.
> >=20
> >> Otherwise, we have indeed no much choice but the horrible wart of
> >> creating both interrupt controllers with only one "active".
> >=20
> > I really think this is the way to go, warts and all.
> >=20
>=20
> Yes ... KVM makes it a little uglier.=20
>=20
> A KVM_DEVICE_DESTROY device is needed to cleanup the VM and a=20
> DISABLE_CAP to disconnect the vpcu from the current KVM XIVE/XICS=20
> device. I have used an extra arg on ENABLE_CAP for the moment.   =20
>=20
> At the QEMU level, we need to connect/reconnect at reset time to
> handle possible changes in CAS, and at post_load.

Right.

> Destroying the MemoryRegion is a bit problematic, I have not
> found a common layout compatible with both the emulated mode=20
> (std IO regions) and the KVM mode (ram device regions)

That sounds awkward, I guess we'll discuss the details of this later.


Btw, a secondary advantage of starting off with XIVE only under a
different machine type is that we can declare that one not to be
migration stable until we're ready.  So we can merge something that's
ok to experiment with, but reserve the right to incompatibly change
the migration format until we're confident we're ready and can merge
it into the "stable" machine type.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrUJpoACgkQbDjKyiDZ
s5KUxQ/+M/d8Szer1jNXq4dEnGnMBXoWv6YNRCJOq8MyAsi9Unms1DjvzTUxQskQ
kp1BnFbYNESFfwMaUdjPS2gr82Yz3XGJWeeObpxFMQ+QODa2CPUJpPMt1FltQ5IY
AECoxdDvQmZLF5KMbo9OCPfWahPOp+UQ8irNUnXi74foDFBdGy/im3cDdVXOIeQy
JiMgIyIw65O1PR+N0XloiA5BwxCOfNB+7rb+gSQMb1wgy1eomBNs2wildD+zm04j
F8pesAeqoUAnDh8kSr7AHC4mSl/vKmRaZIUfRq4aAV/WmyvhfiWw4cmM/jB8PmAj
97VUfamTh7PnS1Acomfdu+IyCUCQMFJCSID+gexUKONhC81RqMx35Q0DETC5XJ3E
Fmi7tqjlp9vAwwmNK4MhLTLjFwUHMVh+AuLYq8g5zbZm3PF4BHtA/26cgN9sbCHA
tioF8ee59ZtROuWcQ0WTG+exVv8239TFuPVkuZvsI0sjSuwese+yjEpLPwG8qa5/
yVp9Mm2k/3rRqNneEhh5Q+AVqK/gvSVyZi5e2AKH4gWwLHEiQawFN7RZ839EAQfq
ZRUENLsJeWqCCGDRGoqkfTccUxNAaIwYPYAJYluK5aBeaFamTFXobqUCnbkvE9HF
YMhIpwx4z7WvWpAyuBqQ3aZEfYCbI/1++GUwL+obNRn90Yz9UUo=
=fqvF
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
