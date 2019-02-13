Received: from eggs.gnu.org ([209.51.188.92]:41217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtmhD-0004do-Jk
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtmZX-0002R7-53
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:55:00 -0500
Date: Wed, 13 Feb 2019 15:54:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213045427.GK1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-8-clg@kaod.org>
	<20190212055900.GN1884@umbus.fritz.box>
	<56a5772ae88c5b5f65c969e2191a02d62cca5055.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n0t7pLec3q0yZKtb"
Content-Disposition: inline
In-Reply-To: <56a5772ae88c5b5f65c969e2191a02d62cca5055.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH 07/19] target/ppc: Make special ORs match
 x86 pause and don't generate on mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--n0t7pLec3q0yZKtb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 11:03:12AM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2019-02-12 at 16:59 +1100, David Gibson wrote:
> > On Mon, Jan 28, 2019 at 10:46:13AM +0100, C=E9dric Le Goater wrote:
> > > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > >=20
> > > There's no point in going out of translation on an SMT OR with
> > > mttcg since the backend won't do anything useful such as pausing,
> > > it's only useful on traditional TCG to give time to other
> > > processors.
> >=20
> > Is it actively harmful in the MTTCG case, or just pointless?
>=20
> I think it can hurt performance, I don't remember for sure :)
>=20
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > > ---
> > >  target/ppc/translate.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > > index e169c43643a1..7d40a1fbe6bd 100644
> > > --- a/target/ppc/translate.c
> > > +++ b/target/ppc/translate.c
> > > @@ -1580,7 +1580,7 @@ static void gen_pause(DisasContext *ctx)
> > >      tcg_temp_free_i32(t0);
> > > =20
> > >      /* Stop translation, this gives other CPUs a chance to run */
> > > -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> > > +    gen_exception_nip(ctx, EXCP_INTERRUPT, ctx->base.pc_next);
> >=20
> > I don't see how this change relates to the rest.
>=20
> Yeah not sure anymore :-)

Oh.  That certainly doesn't make this easier to review.

So, all these target/ppc patches are only indirectly related to XIVE
pnv support.  C=E9dric, can you split them out into their own series on
the next spin.

>=20
> > >  }
> > >  #endif /* defined(TARGET_PPC64) */
> > > =20
> > > @@ -1662,7 +1662,9 @@ static void gen_or(DisasContext *ctx)
> > >           * than no-op, e.g., miso(rs=3D26), yield(27), mdoio(29), md=
oom(30),
> > >           * and all currently undefined.
> > >           */
> > > -        gen_pause(ctx);
> > > +        if (!mttcg_enabled) {
> > > +            gen_pause(ctx);
> > > +        }
> > >  #endif
> > >  #endif
> > >      }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--n0t7pLec3q0yZKtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjowMACgkQbDjKyiDZ
s5LAxBAA5ziEApJAyFoPgveyXZvh4svGQjB2C1mMSthO9Q/WUL4LYsjbIJQZYLP0
+SJ6+Z2UJ7CNhuvohr/+4byNy8RHAs0bNk6BqhQ0QxRQBY4b5/olsMpxJolbt7JS
bbZbbY/OWep2W8G8J9vaWhV8F7OUNL1Ph/QJJyUV92zJGCOWcMsq1kdlbS/Gf92i
acZHPZd4Otel50yeFwsd9cTqtJB91GDungY7/0BBYMp8BiA10eEkQCDPG+RjxCNq
XD9WTOEiOi925x9CbIw9ZtgoM3kmNLy7ERbAB/INR9hUufIgcN7Bsr8acbyYL8Ji
DvB/vjn2zg5R9DkXE+vDElz2ILIcxJwqifMU3LFrtog8kZS00ZjleyA/oB/UjClR
UXimjWyKfzfeh2DvPUKr5KRyq/GNEGn/s/k9u9Rrl3Q1VG+ileemvOIaupUK0c6Q
jhudOFxpRpOvnye4ZdfIifF4H8vX/m9d2uxmYTrx1IC4A+1rwHAYRVObihTrocXr
Ju0gsh4lWoXf24/i8XqHtQGoZGj1TUqmqsi0pKmhOoT0AdJeES6sxdBof2J7gyTj
z0EX7HvyLfypTTnc10NsVuqZzXf665LnasYrFi0hPtsyiS+K9L7GKPMaQYfW7FkB
VprNYYnjxY/vbSqHdgWP4j8OVUaUqTX2VLI0MbgJ5YwnhaEqf0M=
=DXjX
-----END PGP SIGNATURE-----

--n0t7pLec3q0yZKtb--
