Received: from eggs.gnu.org ([2001:4830:134:3::10]:37243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dImQb-0001IL-KX
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 21:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dImQY-0006nx-ER
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 21:40:01 -0400
Date: Thu, 8 Jun 2017 11:39:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608013935.GP13397@umbus.fritz.box>
References: <20170606130534.11019-1-david@gibson.dropbear.id.au>
	<20170606130534.11019-3-david@gibson.dropbear.id.au>
	<149687574611.20132.13119959702428537045@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wQ8ANTl3uYPVjUZt"
Content-Disposition: inline
In-Reply-To: <149687574611.20132.13119959702428537045@loki>
Subject: Re: [Qemu-devel] [RFC 2/3] spapr: Start hotplugged PCI devices in
 ISOLATED state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--wQ8ANTl3uYPVjUZt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 05:49:06PM -0500, Michael Roth wrote:
> Quoting David Gibson (2017-06-06 08:05:33)
> > PCI DRCs, and only PCI DRCs, are immediately moved to UNISOLATED isolat=
ion
> > state once the device is attached.  This has been there from the initial
> > implementation, and it's not clear why.
> >=20
> > The state diagram in PAPR 13.4 suggests PCI devices should start in
> > ISOLATED state until the guest moves them into UNISOLATED, and the code=
 in
> > the guest-side drmgr tool seems to work that way too.
>=20
> I think this was a misguided attempt to disallow detach() to finalize a
> device immediately after attach(), but up until v1.3.3 drmgr actually
> explicitly put the device right back into ISOLATED before doing
> entity-sense, then back to UNISOLATED right before calling
> configure-connector and eventually bringing the device to a configured
> state. So I doesn't seem like this would have had any effect up until
> drmgr v1.3.3+.
>=20
> For drmgr v1.3.3+, this patch would have the effect of allowing detach()
> during the initial entity-sense/set-power-level RTAS calls the guest
> might be doing in response to attach(), but the guest code seems capable
> of dealing with that particular case gracefully.

Ah, ok.

> I'm a bit concerned if we have *multiple* attach()/detach() pairs being
> executed while drmgr is processing a single hotplug add event though:
>=20
> host               guest
>=20
> attach()
> notify
>                    rtas-set-indicator(DR_INDICATOR_ON)
>                    rtas-entity-sense =3D> device_present
>                    rtas-set-power-level(on)
> detach()
> attach()
>                    rtas-set-sensor-state(ISOLATION_STATE_UNISOLATED)
>                    rtas-configure-connector =3D> configured
>                    guest actually onlines device, but dr-indicator and
>                    power domain aren't necessarily in the expected
>                    state
>=20
> In practice, this one isn't a big issue since we emulate an
> 'automatic' power domain in QEMU that makes any rtas-set-power-level
> calls a no-op, and we don't rely on the dr-indicator (anymore, at
> least), but it does end up being the wrong value, and makes me think
> we should find some way to disallow immediate detach() after attach()
> outside of the scenarios set_signalled() was added for. So I think
> this patch seems reasonable, but maybe patch 3 should instead
> repurpose set_signalled to handle this, or be replaced with some
> other alternative that has the same effect.

I see your point, but I don't think it's really worth worrying aboutg.
For the DR-indicator, I don't particularly care about the state of a
virtual LED in weird edge cases like this.  From the guest POV it
seems bogus to me to adjust the LED state before unisolating the
device, but whatever.

If we do ever implement explicit power control (unlikely) then the
detach()/attach() would either not be permitted with device power on,
or it would revert power to off, in which case the attempt to move to
UNISOLATE would fail.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wQ8ANTl3uYPVjUZt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOKrVAAoJEGw4ysog2bOSQDkQAKElL375tHKa3G2rfo35HQ1s
yS3DIBmfAxxBe35BLxPNfKdr+eB5ltLcQOQWZTHcCWADq9Qrxe2pN53ryQr84Jng
tpq/CiPOPk4ZNeqGM8/OAbw7ZahYteyO6Q6S6btlnhWFN5pkdUXT27Bnw9E7S/Bt
hJ+USIri5jTcQcmUPclOtMI/k5PwMMhS7rlH+5wzAU2k8XQ9mR2OfuVICvW+AZ6m
95VgO1wxaVJnuojVa7VyjjZIeewynzDVZq+wyo7L/E4fI86/z/bGTkCkf1oFGyMY
loro19XxcL+Qnx+OR6hy146Hl1uPhKoNMLLGVKhh/3TcGC5xxe+0kbRffuP5VLrZ
7yUM1PmUCZ55zCcHZU0dNdZE5TqY20w9+3iQG+8hXtyaYx2pRDH7nSoOzAxOK5f8
QS0J/izGAlkqWRZz+btWFY8KVqFYHpw314haNpjpP1KtjfvuFtVvKqnie4+Wpqmy
kZApxgBWPzy69ZOjhb3oLm8HGhEgta2RQ+8BWRWPJVMjW3ebFwkka3ZcbOopCgpQ
225tPQ/P0+NQThFfGYhABQmmVAFV6IJ+9pkLHrKsN4HzsXtHN5RdLVlnTKdTr7dg
ZD2n9ynStwloOIkD7pwQsvRcWB3/l4B2Ma4y96+UXtIPtBpGouaQ3AIPppkg50Im
FcgC6jUk8bEsVJZXZc93
=7ot4
-----END PGP SIGNATURE-----

--wQ8ANTl3uYPVjUZt--
