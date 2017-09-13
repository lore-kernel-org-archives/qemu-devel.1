Received: from eggs.gnu.org ([2001:4830:134:3::10]:57168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds25i-0005cR-D0
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds25e-0001QS-Bh
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:28:10 -0400
Date: Wed, 13 Sep 2017 17:19:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170913071955.GJ7550@umbus.fritz.box>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911105729.GC2784@umbus.fritz.box>
	<1d0c4384-fc32-05bb-7e42-44480f51610f@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zOcTNEe3AzgCmdo9"
Content-Disposition: inline
In-Reply-To: <1d0c4384-fc32-05bb-7e42-44480f51610f@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 3/4] ppc: add CPU access_type into the
 migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: aik@ozlabs.ru, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--zOcTNEe3AzgCmdo9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 05:52:10PM +0100, Mark Cave-Ayland wrote:
> On 11/09/17 11:57, David Gibson wrote:
>=20
> > On Sun, Sep 10, 2017 at 03:37:34PM +0100, Mark Cave-Ayland wrote:
> >> This is referenced in cpu_ppc_handle_mmu_fault() and so should be incl=
uded
> >> in the migration stream.
> >=20
> > That is not, on its own, sufficient reason.
> >=20
> >> Note: the vmstate_ppc version number has already been bumped by the pr=
evious
> >> patch in this series.
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >=20
> > As with 2/4 it breaks backwards migration.
> >=20
> > But more, I really disklike the idea of migrating this.  It's internal
> > state for one, and it's also essentially transitory state.  Can we
> > avoid putting it in the otherwise persistent structure at all? Can we
> > derive the state from elsewhere?  Can we prevent migration from
> > occurring in the small windows where this data is live?
>=20
> >From what I can see references to access_type are scattered throughout
> mmu_helper.c although I'm not necessarily familiar enough with PPC to
> know whether this is something that can be derived elsewhere instead.
> And once again it was something that was removed by a90db15.

Right, but the migration code prior to a90db15 was a complete mess.
It definitely included a number of things it didn't need to and
shouldn't as well as being missing other things that were needed.
It's not a good model.  And although it might have more-or-less worked
for certain machines like the ones you're reviving here, it was never
properly tested

> When pausing a VM, does execution stop at the end of the current TB
> rather than immediately? If so, perhaps someone could confirm that
> guarantee is good enough for access_type?

I'm pretty sure it has to; we'd have to come up out of an individual
TB in order to get to the main loop where we check the "please pause"
flag.  I'm not sure if that helps us here though - I *think* access
type is about carrying information from the point where we trigger an
exception to the point where we actually start processing the
exception.

This code is really ugly and I've never understood it well :(. It's
always seemed bogus to me that we have an essentially global variable
to carry information over that small gap, though.  Unfortunately it's
unlikely that I'd be able to dive into this and work out if it's
really needed any time soon.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zOcTNEe3AzgCmdo9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm43BsACgkQbDjKyiDZ
s5LF2RAA2ixud+TRDA+pT43bDhM406xmAphQ5o3Q51ZXPtEn4ssLMHUco26ZBebs
R2bfHgghj+ULJDLzRG1ix7UvKsobijOKfBdBwc47hK6m7H9AmbtBvkahxFLG25EX
lg/8Gp+TbYhfbHpBCTtPcvxqg+xsqOFAlqC4HZ/RvRqIbxzZUaPOYMJ5mm3BvGcc
+hdjhgMpNIjR9qaO70ZjKfeJnKSZtCfqH9+k2uq/s9+c4iAzA8toqvlJCm+bDLUH
w5mxdpoNsn0xwhwnR0tAgPAOSvzYtEDpCQcp7HP3QdAdBziunOapxtMJCyDe8Zrl
pCL+BBYTSwmKeOHLu7fbNujuIV0rI+UaHyiTLVryeUmgU+9ZPYJqgaRKoPlPS6Gq
oIOjgNOfhOV+RUardOkE+xfzNBnO4kp7ej0KvJopAObXo7bN3IkJHhreWK1LlraC
MAI/5qyJGoKbzq2Ri7YOHXOpkFJ73hRLCfarqDsX1gUJh4QO3kDZwn+QB7b3lY67
+4BexZUpSnr7C25/ZcjxHgMHzG+LL1Ht8FX2SLT2brt/SZVayScdY5G/2h+dWuno
J8NaA36pdXqEzrEKuoyZrI6Eb8VLDqpzGxii0817ioWV1YFUEz/zn8AQ/AYUBidX
cN6w5LPE138vwGNhDt/YaJ2OUwSaZHem5F3UXtgZGboPwGYuN/M=
=mht4
-----END PGP SIGNATURE-----

--zOcTNEe3AzgCmdo9--
