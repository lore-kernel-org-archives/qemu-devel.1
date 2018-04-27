Received: from eggs.gnu.org ([2001:4830:134:3::10]:46842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fC2gS-0000MP-II
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fC2gO-0002w3-Au
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:41:04 -0400
Date: Fri, 27 Apr 2018 22:17:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180427121700.GP8800@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<1524151804.3017.9.camel@redhat.com>
	<20180420023542.GD2434@umbus.fritz.box>
	<1524216670.3017.11.camel@redhat.com>
	<20180420102117.GQ2434@umbus.fritz.box>
	<1524672566.23669.15.camel@redhat.com>
	<20180426005555.GA8800@umbus.fritz.box>
	<1524732340.23669.21.camel@redhat.com>
	<20180427021422.GL8800@umbus.fritz.box>
	<1524817870.23669.25.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vhqu5qQ3bjg0ZI9i"
Content-Disposition: inline
In-Reply-To: <1524817870.23669.25.camel@redhat.com>
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


--Vhqu5qQ3bjg0ZI9i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2018 at 10:31:10AM +0200, Andrea Bolognani wrote:
> On Fri, 2018-04-27 at 12:14 +1000, David Gibson wrote:
> > On Thu, Apr 26, 2018 at 10:45:40AM +0200, Andrea Bolognani wrote:
> > > Unfortunately, that pretty much seals the deal on libvirt *not* being
> > > able to infer the value from other guest settings :(
> > >=20
> > > The only reasonable candidate would be the size of host pages used for
> > > backing guest memory; however
> >=20
> > Right.
> >=20
> > >   * TCG, RPT and KVM PR guests can't infer anything from it, as they
> > >     are not tied to it. Having different behaviors for TCG and KVM
> > >     would be easy, but differentiating between HPT KVM HV guest and
> > >     all other kinds is something we can't do at the moment, and that
> > >     in the past have actively resisted doing;
> >=20
> > Yeah, I certainly wouldn't recommend that.  It's basically what we're
> > doing in qemu now, and I want to change, because it's a bad idea.
> >=20
> > It still would be possible to key off the host side hugepage size, but
> > apply the limit to all VMs - in a sense crippling TCG guests to give
> > them matching behaviour to KVM guests.
>=20
> As you yourself mention later...

Right, I basically already made the decision to cripple TCG for KVM
compatibility at the qemu level (by default, at least).

> > >   * the user might want to limit things further, eg. preventing an
> > >     HPT KVM HV guest backed by 16 MiB pages or an HPT TCG guest from
> > >     using hugepages.
> >=20
> > Right.. note that with the draft qemu patches a TCG guest will be
> > prevented from using hugepages *by default* (the default value of the
> > capability is 16).  You have to explicitly change it to allow
> > hugepages to be used in a TCG guest (but you don't have to supply
> > hugepage backing).
>=20
> ... this will already happen. That's okay[1], we can't really
> avoid it if we want to ensure consistent behavior between KVM and
> TCG.

So.. regarding [1].  The draft patches *do* change the behaviour on
older machine types.  I'll consider revisiting that, but I'd need to
be convinced.  Basically we have to choose between consistency between
accelerator and consistency between versions.  I think the former is
the better choice; at least I think it is given that we *can* get both
for the overwhelmingly common case in production (KVM HV).

> > > With the second use case in mind: would it make sense, or even be
> > > possible, to make it so the capability works for RPT guests too?
> >=20
> > Possible, maybe.. I think there's another property where RPT pagesizes
> > are advertised.  But I think it's a bad idea.  In order to have the
> > normal HPT case work consistently we need to set the default cap value
> > to 16 (64kiB page max).  If that applied to RPT guests as well, we'd
> > be unnecessarily crippling nearly all RPT guests.
> >=20
> > > Thinking even further, what about other architectures? Is this
> > > something they might want to do too? The scenario I have in mind is
> > > guests backed by regular pages being prevented from using hugepages
> > > with the rationale that they wouldn't have the same performance
> > > characteristics as if they were backed by hugepages; on the opposite
> > > side of the spectrum, you might want to ensure the pages used to
> > > back guest memory are as big as the biggest page you plan to use in
> > > the guest, in order to guarantee the performance characteristics
> > > fully match expectations.
> >=20
> > Hm, well, you'd have to ask other arch people if they see a use for
> > that.  It doesn't look very useful to me.  I don't think libvirt can
> > or should ensure identical performance characteristics for a guest
> > across all possible migrations.  But for HPT guests, it's not a matter
> > of performance characteristics: if it tries to use a large page size
> > and KVM doesn't have large enough backing pages, the guest will
> > quickly just freeze on a page fault that can never be satisfied.
>=20
> I realize only HPT guests *need* this, but I was trying to figure
> out whether giving the host administrator more control over the
> guest page size could be a useful feature in other cases as well,
> as it sounds to me like it's more generally applicable

Perhaps, but I don't see a strong case for it.

> Users already need to opt-in to using hugepages in the host; asking
> to opt-in to guest hugepages support as well doesn't seem too
> outlandish to me.
>=20
> Even if the specific flags required vary between architectures, we
> could expose this in a unified fashion in libvirt. However, if this
> is not something people would consider useful, we can just have a
> pSeries-specific setting instead.

The trouble is, if we made a generic knob for limiting guest
pagesizes, then I think we'd need *another* pseries specific knob so
that we can set the HPT and RPT limits differently:

It seems to be the common case is going to be to allow unlimited RPT
pagesizes (because there's really no downside to that), but limited
HPT pagesizes, so that we can migrate without requiring hugepage
backing everywhere.  A single knob that applied in all cases wouldn't
let us do that.

> [1] That's of course assuming you have made sure the restriction
>     only applies to the 2.13 machine type forward, and existing
>     guests are not affected by the change.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Vhqu5qQ3bjg0ZI9i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrjFLoACgkQbDjKyiDZ
s5L3YRAA5DtR8w7KuWosT5mzm4O9LkuHgmCrsJG5VV5WSvpKo65AFZm7UZwB0Jbq
kO/pltlo/EeVTZqEkbj/KrVpFdQUtVih1M7l01qVKSk92nLSKYsl9RqR7823vbNd
gm1ppbH7KLgLpZLAGROU2fXUYNdR+g3nOFZfprMVNFNr/BeXP5Jr+8mWG+D/dn03
AHrrHfgHYP2DaxR9KKN/F8SkQaywolBv9cNwvr52NIMRyXAWIs9W6OH0+zsHY7Jv
1ew0rFjpLWhhSiE8uaQfkRx8WAUibOwqQucHDgblItcRhdHRJsLzgCz5n8mgzZ7M
cbolVOnU9KGVyC4hhchyRlmwwAkX8HKNMJPLRL5ZX3uj+3xshL36gLmUxCwIsGgu
uxvXzKNlOP6tT/0uBJNBlJm7zBfepCYNG6kV6BVCw/0Q9TXBhh1ghne2JnJGWcr1
jKjw4zg+vUFp9I1ty21iJfpJ3/qfy/+dGqwRecBdm9l404o31ZeCilAbVkyhyW3N
zGndhkcQA5LUc7VRpSyP5OedxWoPA/ZlHbIqnHimhrIvGQwXYOLXFd3AD1SUqPUE
Rr8b0+x7DgECbNzY+9I8Srwg20/HiO4Tjh1J0aUmr1q9IYxK/1jREiI+rbiYwOw3
v84qOur+7Rskyd8EzN6HxNdMsp4hpBJz1oWYbKBsAuaYQa6OqY4=
=ANXP
-----END PGP SIGNATURE-----

--Vhqu5qQ3bjg0ZI9i--
