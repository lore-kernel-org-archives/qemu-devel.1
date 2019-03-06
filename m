Received: from eggs.gnu.org ([209.51.188.92]:46062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1MOt-00085C-TK
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 21:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1MOr-00081o-HR
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 21:35:19 -0500
Date: Wed, 6 Mar 2019 11:58:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190306005824.GH19715@umbus.fritz.box>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
	<20190214043916.22128-2-david@gibson.dropbear.id.au>
	<20190228083317-mutt-send-email-mst@kernel.org>
	<20190305005207.GA7877@umbus.fritz.box>
	<20190304211451-mutt-send-email-mst@kernel.org>
	<20190305050300.GI7877@umbus.fritz.box>
	<20190305094050-mutt-send-email-mst@kernel.org>
	<20190305233512.GB19715@umbus.fritz.box>
	<20190305191334-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Content-Disposition: inline
In-Reply-To: <20190305191334-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio-balloon: Remove unnecessary
 MADV_WILLNEED on deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2019 at 07:14:09PM -0500, Michael S. Tsirkin wrote:
> On Wed, Mar 06, 2019 at 10:35:12AM +1100, David Gibson wrote:
> > On Tue, Mar 05, 2019 at 09:41:34AM -0500, Michael S. Tsirkin wrote:
> > > On Tue, Mar 05, 2019 at 04:03:00PM +1100, David Gibson wrote:
> > > > On Mon, Mar 04, 2019 at 09:29:24PM -0500, Michael S. Tsirkin wrote:
> > > > > On Tue, Mar 05, 2019 at 11:52:08AM +1100, David Gibson wrote:
> > > > > > On Thu, Feb 28, 2019 at 08:36:58AM -0500, Michael S. Tsirkin wr=
ote:
> > > > > > > On Thu, Feb 14, 2019 at 03:39:12PM +1100, David Gibson wrote:
> > > > > > > > When the balloon is inflated, we discard memory place in it=
 using madvise()
> > > > > > > > with MADV_DONTNEED.  And when we deflate it we use MADV_WIL=
LNEED, which
> > > > > > > > sounds like it makes sense but is actually unnecessary.
> > > > > > > >=20
> > > > > > > > The misleadingly named MADV_DONTNEED just discards the memo=
ry in question,
> > > > > > > > it doesn't set any persistent state on it in-kernel; all th=
at's necessary
> > > > > > > > to bring the memory back is to touch it.  MADV_WILLNEED in =
contrast
> > > > > > > > specifically says that the memory will be used soon and fau=
lts it in.
> > > > > > > >=20
> > > > > > > > This patch simplify's the balloon operation by dropping the=
 madvise()
> > > > > > > > on deflate.  This might have an impact on performance - it =
will move a
> > > > > > > > delay at deflate time until that memory is actually touched=
, which
> > > > > > > > might be more latency sensitive.  However:
> > > > > > > >=20
> > > > > > > >   * Memory that's being given back to the guest by deflatin=
g the
> > > > > > > >     balloon *might* be used soon, but it equally could just=
 sit around
> > > > > > > >     in the guest's pools until needed (or even be faulted o=
ut again if
> > > > > > > >     the host is under memory pressure).
> > > > > > > >=20
> > > > > > > >   * Usually, the timescale over which you'll be adjusting t=
he balloon
> > > > > > > >     is long enough that a few extra faults after deflation =
aren't
> > > > > > > >     going to make a difference.
> > > > > > > >=20
> > > > > > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > > > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > > > > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > >=20
> > > > > > > I'm having second thoughts about this. It might affect perfor=
mance but
> > > > > > > probably won't but we have no idea.  Might cause latency jitt=
er after
> > > > > > > deflate where it previously didn't happen.  This kind of patc=
h should
> > > > > > > really be accompanied by benchmarking results, not philosophy.
> > > > > >=20
> > > > > > I guess I see your point, much as it's annoying to spend time
> > > > > > benchmarking a device that's basically broken by design.
> > > > >=20
> > > > > Because of 4K page thing?
> > > >=20
> > > > For one thing.  I believe David H has bunch of other reasons.
> > > >=20
> > > > > It's an annoying bug for sure.  There were
> > > > > patches to add a feature bit to just switch to plan s/g format, b=
ut they
> > > > > were abandoned. You are welcome to revive them though.
> > > > > Additionally or alternatively, we can easily add a field specifyi=
ng
> > > > > page size.
> > > >=20
> > > > We could, but I'm pretty disinclined to work on this when virtio-mem
> > > > is a better solution in nearly every way.
> > >=20
> > > Then one way would be to just let balloon be. Make it behave same as
> > > always and don't make changes to it :)
> >=20
> > I'd love to, but it is in real world use, so I think we do need to fix
> > serious bugs in it - at least if they can be fixed on one side,
> > without needing to roll out both qemu and guest changes (which adding
> > page size negotiation would require).
>=20
>=20
> Absolutely I'm just saying don't add optimizations in that case :)

I don't plan to.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx/GzAACgkQbDjKyiDZ
s5Kf+g//VpzlnFhtbrkaojSPN6pOAzcFa3DvEPw0nVq+x3qMu3jlwW0SuMbqUIv/
YIgT4oroj/gYb7cdrmtkdnKCsPMITanJWKwPcB1moAW/g+giGmDKfPom5hSYrF8T
NbJOHhfWyfDbAam00ZtPcIj3o2IRqmalbdUaId5BR0BxOl8gNtf6l9Ye+pn+Ahsu
nNkoqt9QO/6mOpyXGlL048bXSUKzur/u7fDiXHJbRmQdTZboyaeD0i8U6KtzqlZC
cNXYOD4OPhEwcGQWwGYFBde5LqAKRpVnkdV+7ruZJxbLe9agFFanhja9LDBheAT9
i6JyMu/0Ql5/YTZjDNqOfD4pWvw1lO8UinQLyngWihqevKXr9UmorqSyTrVqJkby
PuooTUw951kCFfq2bXt2tNtA3Fu53YCYwlmv5vVdkf1MAPuVtwWpS1TxNpaV66Up
FtwU79rT5v3UQx9bvoOZ4qofgmGg2bQa4OktYZsdz3d2+Y65vXPfXNAGCBN7yM1p
PQZkyWp5yKuP+O3ELhTsbSyZ8WKmgIxh8fueF0O9RPzFaAesWcusfK8xKEVn3rpM
LBPDRC/kJ2Pk+mmyVKsqbYNvRyhnatqA4lefT+SqqDUecYGFmYxPZMZimwBkgHj2
IfFDr9U1yEwaevk5Z1lq2CaArx/264xseunsW/+ZePg4MfsK6VY=
=q2nz
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
