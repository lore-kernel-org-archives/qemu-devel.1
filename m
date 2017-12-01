Received: from eggs.gnu.org ([2001:4830:134:3::10]:40098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKnTD-0005f4-Ch
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKnSX-0001rp-5c
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:43:19 -0500
Date: Fri, 1 Dec 2017 10:13:21 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171201101321.GG23501@stefanha-x1.localdomain>
References: <20171129102513.9153-1-pbonzini@redhat.com>
	<20171129102513.9153-2-pbonzini@redhat.com>
	<20171129134408.GB4281@stefanha-x1.localdomain>
	<20171129135528.GD3753@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
Content-Disposition: inline
In-Reply-To: <20171129135528.GD3753@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/4] block: Expect graph
 changes in bdrv_parent_drained_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 02:55:28PM +0100, Kevin Wolf wrote:
> Am 29.11.2017 um 14:44 hat Stefan Hajnoczi geschrieben:
> > On Wed, Nov 29, 2017 at 11:25:10AM +0100, Paolo Bonzini wrote:
> > > From: Kevin Wolf <kwolf@redhat.com>
> > >=20
> > > The .drained_begin/end callbacks can (directly or indirectly via
> > > aio_poll()) cause block nodes to be removed or the current BdrvChild =
to
> > > point to a different child node.
> > >=20
> > > Use QLIST_FOREACH_SAFE() to make sure we don't access invalid
> > > BlockDriverStates or accidentally continue iterating the parents of t=
he
> > > new child node instead of the node we actually came from.
> > >=20
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > Tested-by: Jeff Cody <jcody@redhat.com>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Reviewed-by: Jeff Cody <jcody@redhat.com>
> > > ---
> > >  block/io.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/block/io.c b/block/io.c
> > > index 4fdf93a014..6773926fc1 100644
> > > --- a/block/io.c
> > > +++ b/block/io.c
> > > @@ -42,9 +42,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bl=
ockDriverState *bs,
> > > =20
> > >  void bdrv_parent_drained_begin(BlockDriverState *bs)
> > >  {
> > > -    BdrvChild *c;
> > > +    BdrvChild *c, *next;
> > > =20
> > > -    QLIST_FOREACH(c, &bs->parents, next_parent) {
> > > +    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
> > >          if (c->role->drained_begin) {
> > >              c->role->drained_begin(c);
> > >          }
> > > @@ -53,9 +53,9 @@ void bdrv_parent_drained_begin(BlockDriverState *bs)
> > > =20
> > >  void bdrv_parent_drained_end(BlockDriverState *bs)
> > >  {
> > > -    BdrvChild *c;
> > > +    BdrvChild *c, *next;
> > > =20
> > > -    QLIST_FOREACH(c, &bs->parents, next_parent) {
> > > +    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
> > >          if (c->role->drained_end) {
> > >              c->role->drained_end(c);
> > >          }
> >=20
> > Hmm...not sure if this patch is enough.
>=20
> Depends on what you have in mind, but generally, no, it's certainly not
> enough to fix all bad things that can happen during drain...
>=20
> > Thinking about this more, if this sub-graph changes then
> > .drained_begin() callbacks are not necessarily paired with
> > .drained_end() callbacks.
> >=20
> > In other words, all of the following are possible:
> >=20
> > 1. Only .drained_begin() is called
> > 2. .drained_begin() is called, then .drained_end()
> > 3. Only .drained_end() is called
>=20
> bdrv_replace_child_noperm() makes sure to call .drained_end() and
> .drained_begin() depending on whether the old and new child node are
> currently drained. So I think this might actually work.
>=20
> > It makes me wonder if we need to either:
> >=20
> > Take references and ensure .drained_end() gets called if and only if
> > .drained_begin() was also called.
> >=20
> > OR
> >=20
> > Document that .drained_begin/end() calls may not be paired and audit
> > existing code to check that this is safe.
>=20
> How would the latter even possibly work? If the .drained_end is missing,
> the parent would never know that it can send new requests again. A
> missing .drained_begin could be ignored in the .drained_end callback,
> but it wouldn't be safe because the parent wouldn't actually stop to
> send new requests.

Yesterday I looked at a similar issue in Fam's new RFC that moves
=2Edrained_begin()/.drained_end() to AioContext.  I came to the conclusion
that while it's easy to implement unmatched begin/end calls (as we do
today) it's not possible to get useful semantics out of them :).  So we
have to ensure the the begin/end calls match.

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaIStBAAoJEJykq7OBq3PIhw8H/R89L442kPurz1WYtKlMDrCz
M59AYrOZCrA/szDGPMSGoCFZnLRkqSEuYpbu1nijD9lZLPk139PAo9RLXuvhnz2v
paPiDYPrD9VuAVavwylGQz5DnZXCE7bMECdpsscGc8g5Ssde/p3N6bXBKgp4T6EN
mmyY+9HLtLTdwDqAY7PfV4UqsgnUwOOecZ08kzBGhzt6djPKfET0CNFn8XxY5isA
FVPsPkSpOPbr7aYBTJRFLrpf+uHndKJ01QqRp/QL6dLLfGrnle9d0TaRL7WjnzqA
1w0SPdlK01YfNKuRXTLzYmAWVTQ9D3rD84lcCOIXkeIvPi27z6LFBpsqbCcAEPw=
=is/5
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--
