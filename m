Received: from eggs.gnu.org ([2001:4830:134:3::10]:54272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK2pz-0001cn-HP
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK2py-0001eS-IX
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:55:43 -0500
Date: Wed, 29 Nov 2017 14:55:28 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171129135528.GD3753@localhost.localdomain>
References: <20171129102513.9153-1-pbonzini@redhat.com>
	<20171129102513.9153-2-pbonzini@redhat.com>
	<20171129134408.GB4281@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <20171129134408.GB4281@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.11.2017 um 14:44 hat Stefan Hajnoczi geschrieben:
> On Wed, Nov 29, 2017 at 11:25:10AM +0100, Paolo Bonzini wrote:
> > From: Kevin Wolf <kwolf@redhat.com>
> >=20
> > The .drained_begin/end callbacks can (directly or indirectly via
> > aio_poll()) cause block nodes to be removed or the current BdrvChild to
> > point to a different child node.
> >=20
> > Use QLIST_FOREACH_SAFE() to make sure we don't access invalid
> > BlockDriverStates or accidentally continue iterating the parents of the
> > new child node instead of the node we actually came from.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Tested-by: Jeff Cody <jcody@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  block/io.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/block/io.c b/block/io.c
> > index 4fdf93a014..6773926fc1 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -42,9 +42,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bloc=
kDriverState *bs,
> > =20
> >  void bdrv_parent_drained_begin(BlockDriverState *bs)
> >  {
> > -    BdrvChild *c;
> > +    BdrvChild *c, *next;
> > =20
> > -    QLIST_FOREACH(c, &bs->parents, next_parent) {
> > +    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
> >          if (c->role->drained_begin) {
> >              c->role->drained_begin(c);
> >          }
> > @@ -53,9 +53,9 @@ void bdrv_parent_drained_begin(BlockDriverState *bs)
> > =20
> >  void bdrv_parent_drained_end(BlockDriverState *bs)
> >  {
> > -    BdrvChild *c;
> > +    BdrvChild *c, *next;
> > =20
> > -    QLIST_FOREACH(c, &bs->parents, next_parent) {
> > +    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
> >          if (c->role->drained_end) {
> >              c->role->drained_end(c);
> >          }
>=20
> Hmm...not sure if this patch is enough.

Depends on what you have in mind, but generally, no, it's certainly not
enough to fix all bad things that can happen during drain...

> Thinking about this more, if this sub-graph changes then
> .drained_begin() callbacks are not necessarily paired with
> .drained_end() callbacks.
>=20
> In other words, all of the following are possible:
>=20
> 1. Only .drained_begin() is called
> 2. .drained_begin() is called, then .drained_end()
> 3. Only .drained_end() is called

bdrv_replace_child_noperm() makes sure to call .drained_end() and
=2Edrained_begin() depending on whether the old and new child node are
currently drained. So I think this might actually work.

> It makes me wonder if we need to either:
>=20
> Take references and ensure .drained_end() gets called if and only if
> .drained_begin() was also called.
>=20
> OR
>=20
> Document that .drained_begin/end() calls may not be paired and audit
> existing code to check that this is safe.

How would the latter even possibly work? If the .drained_end is missing,
the parent would never know that it can send new requests again. A
missing .drained_begin could be ignored in the .drained_end callback,
but it wouldn't be safe because the parent wouldn't actually stop to
send new requests.

Kevin

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaHrxQAAoJEH8JsnLIjy/Wq7QP/ixeiii6zTOlwMKR4/j5c7ol
185kahNuHWtPyFCnacxEyFpKGwPX+DxNKiFEGp9YgLzsjWQFNSSjiyXm5TgHi/TI
2RQgNNvhommT2zdKwmuxB/iNir4lod7Hx1jLJ0+QUFdzr/jN000M9iMBm0SFLnfi
/zzIoLvC3MVDzed25D+d/PDua3mC94XtL5fglGdcp+MdQUlmsyFiOR2xMuAmAquF
SAwy0qRHa2n9kzZMEsnzaE4ts2+vxtdmp8BAmTZLa6vOdA3gwGhZ1g9wM0SXgAuD
5IuB/z5mAVNAtIgQiryQuLHuQq3i6jX7qmNeXKibFbL706vDTWPSTgXwO6/C9q4N
bWm7R/Cm4f+YDKWOghF3UHYzcRcHj4fVNI/51jQyBdHluaCfrcgMOfxbXEMre0lY
T+4gQwnPaYPvnylCPdr+ZlWaj7yTTH88Ro0+HQVnjRI20YkUkT8WPpCMdLCR1Np+
16pnMSwxELjf+WBfyxLnxangGB+KlKETJwkxZpHLpQeXQ3zZ/bb/FrbMgxWI6M91
gsxOq3AaTHnsLfI7hXzTuRreLs8M9bz2RJ5XwoBU+qibfkQyp4qykkDmcgxF2K1j
pOPTfqu+rIRghF0HDbquM5zAQHRdP+7iPU+ds7QQmpk0a9Qr5+zTvgnrPXG6zvQY
JfXffjPbI2lK5aQrdcpt
=LIZY
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
