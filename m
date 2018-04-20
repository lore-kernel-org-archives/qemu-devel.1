Received: from eggs.gnu.org ([2001:4830:134:3::10]:55320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9MMu-0002hk-KJ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9MMr-0007LX-DC
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:05:48 -0400
Date: Fri, 20 Apr 2018 12:35:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180420023542.GD2434@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<1524151804.3017.9.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline
In-Reply-To: <1524151804.3017.9.camel@redhat.com>
Subject: Re: [Qemu-devel] [RFC for-2.13 0/7] spapr: Clean up pagesize
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 05:30:04PM +0200, Andrea Bolognani wrote:
> On Thu, 2018-04-19 at 16:29 +1000, David Gibson wrote:
> > Currently the "pseries" machine type will (usually) advertise
> > different pagesizes to the guest when running under KVM and TCG, which
> > is not how things are supposed to work.
> >=20
> > This comes from poor handling of hardware limitations which mean that
> > under KVM HV the guest is unable to use pagesizes larger than those
> > backing the guest's RAM on the host side.
> >=20
> > The new scheme turns things around by having an explicit machine
> > parameter controlling the largest page size that the guest is allowed
> > to use.  This limitation applies regardless of accelerator.  When
> > we're running on KVM HV we ensure that our backing pages are adequate
> > to supply the requested guest page sizes, rather than adjusting the
> > guest page sizes based on what KVM can supply.
> >=20
> > This means that in order to use hugepages in a PAPR guest it's
> > necessary to add a "cap-hpt-mps=3D24" machine parameter as well as
> > setting the mem-path correctly.  This is a bit more work on the user
> > and/or management side, but results in consistent behaviour so I think
> > it's worth it.
>=20
> libvirt guests already need to explicitly opt-in to hugepages, so
> adding this new option automagically based on that shouldn't be too
> difficult.

Right.  We have to be a bit careful with automagic though, because
treating hugepage as a boolean is one of the problems that this
parameter is there to address.

If libvirt were to set the parameter based on the pagesize of the
hugepage mount, then it might not be consistent across a migration
(e.g. p8 to p9).  Now the new code would at least catch that and
safely fail the migration, but that might be confusing to users.

> A couple of questions:
>=20
>   * I see the option accepts values 12, 16, 24 and 34, with 16
>     being the default.

In fact it should accept any value >=3D 12, though the ones that you
list are the interesting ones.  This does mean, for example, that if
it was just set to the hugepage size on a p9, 21 (2MiB) things should
work correctly (in practice it would act identically to setting it to
16).

> I guess 34 corresponds to 1 GiB hugepages?

No, 16GiB hugepages, which is the "colossal page" size on HPT POWER
machines.  It's a simple shift, (1 << 34) =3D=3D 16 GiB, 1GiB pages would
be 30 (but wouldn't let the guest do any more than 24 ~ 16 MiB in
practice).

>     Also, in what scenario would 12 be used?

So RHEL, at least, generally configures ppc64 kernels to use 64kiB
pages, but 4kiB pages are still supported upstream (not sure if there
are any distros that still use that mode).  If your host uses 4kiB
pages you wouldn't be able to start a (KVM HV) guest without setting
this to 12 (or using a 64kiB hugepage mount).

>   * The name of the property suggests this setting is only relevant
>     for HPT guests. libvirt doesn't really have the notion of HPT
>     and RPT, and I'm not really itching to introduce it. Can we
>     safely use this option for all guests, even RPT ones?

Yes.  The "hpt" in the main is meant to imply that its restriction
only applies when the guest is in HPT mode, but it can be safely set
in any mode.  In RPT mode guest and host pagesizes are independent of
each other, so we don't have to deal with this mess.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrZUfwACgkQbDjKyiDZ
s5Lzvg//ZcQHL8tiFjiWjsZe196/6YUlwS8hwVW+YXc7u7LSUtTazOAJmA94MmDm
Usbsu3v8ezVb9AacyXBDLdIw7dGyNzpsY7Y6oqTmlfB3s4QQTzcgHJccJTWFINO3
MRvh4A/KMRIhzj5cSsrHjRa5OSkSkNbLBPpnYPdlLSslBbBMj1/n8VaGe+RluHJg
W0DP5SdOUpfvEC6O+8mut50iDafGuiHpZJMN/B9q91/jmkiUXc9udGWa6NCXgcmE
rzNYL4dTBB97S/AfoaX+uac8peYwm9f5qNe9zRJ17kvNxqxneLDVUBBDPwnSFatE
h+VdmAXIri2i2qB3GspQtI0LcXWTrxMbkkMUeUkTW/7fVWdJJnJPDVDr+IpOj6fO
n0+8aselp2fnS2J+WE35iFp9fEjjQDwrCy2SMbZWr3G4cZPGK4RgLkR1+2hJVMhY
6TfD1YfooeyyKmhBDdlLvvvhpMtPf9YRvzpKACDGp7gl8kV86ViVzj9BYQSj4Lie
WPmH/BbbT2RXbHMSHyyTtAG+VPvPLujVoK/vJqxw5OInPWTS1icfrVLSgP5JPGAF
87vBsdJKNlDXyDy+qz0DZKpkiPAE5vJ4dgCwtJE4tcv5CGMLxJV6nsEdO8Nxvg3E
gadLa9dMfhMPCn/kkgt7OfFHyGUuicmsX/vlBMwxdff5hVziGck=
=5N4+
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--
