Received: from eggs.gnu.org ([2001:4830:134:3::10]:38234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9UYa-0002JQ-Gh
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 07:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9UYW-0001UA-EF
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 07:50:24 -0400
Date: Fri, 20 Apr 2018 20:21:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180420102117.GQ2434@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<1524151804.3017.9.camel@redhat.com>
	<20180420023542.GD2434@umbus.fritz.box>
	<1524216670.3017.11.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gblAvmLjk8yGG9If"
Content-Disposition: inline
In-Reply-To: <1524216670.3017.11.camel@redhat.com>
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


--gblAvmLjk8yGG9If
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 11:31:10AM +0200, Andrea Bolognani wrote:
> On Fri, 2018-04-20 at 12:35 +1000, David Gibson wrote:
> > On Thu, Apr 19, 2018 at 05:30:04PM +0200, Andrea Bolognani wrote:
> > > On Thu, 2018-04-19 at 16:29 +1000, David Gibson wrote:
> > > > This means that in order to use hugepages in a PAPR guest it's
> > > > necessary to add a "cap-hpt-mps=3D24" machine parameter as well as
> > > > setting the mem-path correctly.  This is a bit more work on the user
> > > > and/or management side, but results in consistent behaviour so I th=
ink
> > > > it's worth it.
> > >=20
> > > libvirt guests already need to explicitly opt-in to hugepages, so
> > > adding this new option automagically based on that shouldn't be too
> > > difficult.
> >=20
> > Right.  We have to be a bit careful with automagic though, because
> > treating hugepage as a boolean is one of the problems that this
> > parameter is there to address.
> >=20
> > If libvirt were to set the parameter based on the pagesize of the
> > hugepage mount, then it might not be consistent across a migration
> > (e.g. p8 to p9).  Now the new code would at least catch that and
> > safely fail the migration, but that might be confusing to users.
>=20
> Good point.
>=20
> I'll have to look into it to be sure, but I think it should be
> possible for libvirt to convert a generic
>=20
>   <memoryBacking>
>     <hugepages/>
>   </memoryBacking>
>=20
> to a more specific
>=20
>   <memoryBacking>
>     <hugepages>
>       <page size=3D"16384" unit=3D"KiB"/>
>     </hugepages>
>   </memoryBacking>
>=20
> by figuring out the page size for the default hugepage mount,
> which actually sounds like a good idea regardless. Of course users
> user would still be able to provide the page size themselves in the
> first place.

Sounds like a good approach.

> Is the 16 MiB page size available for both POWER8 and POWER9?

No.  That's a big part of what makes this such a mess.  HPT has 16MiB
and 16GiB hugepages, RPT has 2MiB and 1GiB hugepages.  (Well, I guess
tecnically Power9 does have 16MiB pages - but only in hash mode, which
the host won't be).

I've been looking into whether it's feasible to make a 16MiB hugepage
pool for POWER9 RPT.  The hardware can't actually use that as a
pagesize, but we could still allocate them physically contiguous, map
them using a bunch of 2MiB PTEs in RPT mode and allow them to be
mapped by guests in HPT mode.

I *think* it won't be too hard, but I haven't looked close enough to
rule out horrible gotchas yet.

> > > A couple of questions:
> > >=20
> > >   * I see the option accepts values 12, 16, 24 and 34, with 16
> > >     being the default.
> >=20
> > In fact it should accept any value >=3D 12, though the ones that you
> > list are the interesting ones.
>=20
> Well, I copied them from the QEMU help text, and I kinda assumed
> that you wouldn't just list completely random values there O:-)

Ah, right, of course.

> > This does mean, for example, that if
> > it was just set to the hugepage size on a p9, 21 (2MiB) things should
> > work correctly (in practice it would act identically to setting it to
> > 16).
>=20
> Wouldn't that lead to different behavior depending on whether you
> start the guest on a POWER9 or POWER8 machine? The former would be
> able to use 2 MiB hugepages, while the latter would be stuck using
> regular 64 KiB pages.

Well, no, because 2MiB hugepages aren't a thing in HPT mode.  In RPT
mode it'd be able to use 2MiB hugepages either way, because the
limitations only apply to HPT mode.

> Migration of such a guest from POWER9 to
> POWER8 wouldn't work because the hugepage allocation couldn't be
> fulfilled,

Sort of, you couldn't even get as far as staring the incoming qemu
with hpt-mps=3D21 on the POWER8 (unless you gave it 16MiB hugepages for
backing).

> but the other way around would probably work and lead to
> different page sizes being available inside the guest after a power
> cycle, no?

Well.. there are a few cases here.  If you migrated p8 -> p8 with
hpt-mps=3D21 on both ends, you couldn't actually start the guest on the
source without giving it hugepage backing.  In which case it'll be
fine on the p9 with hugepage mapping.

If you had hpt-mps=3D16 on the source and hpt-mps=3D21 on the other end,
well, you don't get to count on anything because you changed the VM
definition.  In fact it would work in this case, and you wouldn't even
get new page sizes after restart because HPT mode doesn't support any
pagesizes between 64kiB and 16MiB.

> > > I guess 34 corresponds to 1 GiB hugepages?
> >=20
> > No, 16GiB hugepages, which is the "colossal page" size on HPT POWER
> > machines.  It's a simple shift, (1 << 34) =3D=3D 16 GiB, 1GiB pages wou=
ld
> > be 30 (but wouldn't let the guest do any more than 24 ~ 16 MiB in
> > practice).
>=20
> Isn't 1 GiB hugepages support at least being worked on[1]?

That's for radix mode.  Hash mode has 16MiB and 16GiB, no 1GiB.

> > >     Also, in what scenario would 12 be used?
> >=20
> > So RHEL, at least, generally configures ppc64 kernels to use 64kiB
> > pages, but 4kiB pages are still supported upstream (not sure if there
> > are any distros that still use that mode).  If your host uses 4kiB
> > pages you wouldn't be able to start a (KVM HV) guest without setting
> > this to 12 (or using a 64kiB hugepage mount).
>=20
> Mh, that's annoying, as needing to support 4 KiB pages would most
> likely mean we'd have to turn this into a stand-alone configuration
> knob rather than deriving it entirely from existing ones, which I'd
> prefer as it's clearly much more user-friendly.

Yeah, there's really no way around it though.  Well other than always
restricting to 4kiB pages by default, which would suck for performance
with guests that want to use 64kIB pages.

> I'll check out what other distros are doing: if all the major ones
> are defaulting to 64 KiB pages these days, it might be reasonable
> to do the same and pretend smaller page sizes don't exist at all in
> order to avoid the pain of having to tweak yet another knob, even
> if that means leaving people compiling their own custom kernels
> with 4 KiB page size in the dust.

That's my guess.

> > >   * The name of the property suggests this setting is only relevant
> > >     for HPT guests. libvirt doesn't really have the notion of HPT
> > >     and RPT, and I'm not really itching to introduce it. Can we
> > >     safely use this option for all guests, even RPT ones?
> >=20
> > Yes.  The "hpt" in the main is meant to imply that its restriction
> > only applies when the guest is in HPT mode, but it can be safely set
> > in any mode.  In RPT mode guest and host pagesizes are independent of
> > each other, so we don't have to deal with this mess.
>=20
> Good :)
>=20
>=20
> [1] https://patchwork.kernel.org/patch/9729991/

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gblAvmLjk8yGG9If
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrZvxoACgkQbDjKyiDZ
s5Ju2RAA1LSAU1xqg7LmgtvDRV98DCk3jVhgB8qV2c5IIEHzlkfStu8b7vtZTdsq
G9aeab7e1JQYLIFMSQS0cxCa+WUVWpKqM6x9IYYtyr4Rc3zQaRCmMOBNfuUBf2SJ
EqF89p6B0o9HFYTYBle2BefNtWeR3KlQNC8xEnS/iIFEs/qw8iqEZadC2e4KDSaN
0lnp9QKX94fvPmLQIRQ0X6wHyzU3dJ/IzAWPSOVIw2didKAV3HeCtMLwPpFqONMO
usCaF2P/d0wqxSPrl3N1aqd13M5yaD2aDOcaEBOITCFTEbWHDvw3x3VJ7mmg9CrB
6TfZz5B5sAjS8YGKMEQxljvjeq1/b7WAmj8VWJX2DaGZTuB/ppCV2wXgXMQteCho
vaTUiRBja1581Q/7bAjmK3cIn01r6UN0j0xETBJiP9FsD0l7mGfOfiZifnEt7LJw
0H6EBgf4MmksZWIP1YiH7rF2SAG/AkPtChR7vl3PAEjcf8YdbZeGxqQ1Ax3uqr6f
QzaSc6GsZYMrbhXyus3NauKNzZXIWXElRcFXkOMihH1UwDwkC0FkvprPvvdACMXX
LyyaL39v4XrZwU4wzN+0x3PcbIe8vVY23ghLb/4kmCWODxE4Oq4+ht0p5C+jLe5v
ygdiBePUACV4oO9m7S1KtROgLr9f2IVfmnDyhWQf3PV1+YX+3Sg=
=u8gw
-----END PGP SIGNATURE-----

--gblAvmLjk8yGG9If--
