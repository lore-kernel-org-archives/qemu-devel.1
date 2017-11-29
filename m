Received: from eggs.gnu.org ([2001:4830:134:3::10]:50718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eK2es-0001vV-VF
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eK2ep-0006DB-RQ
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:44:15 -0500
Date: Wed, 29 Nov 2017 13:44:08 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171129134408.GB4281@stefanha-x1.localdomain>
References: <20171129102513.9153-1-pbonzini@redhat.com>
	<20171129102513.9153-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
In-Reply-To: <20171129102513.9153-2-pbonzini@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 11:25:10AM +0100, Paolo Bonzini wrote:
> From: Kevin Wolf <kwolf@redhat.com>
>=20
> The .drained_begin/end callbacks can (directly or indirectly via
> aio_poll()) cause block nodes to be removed or the current BdrvChild to
> point to a different child node.
>=20
> Use QLIST_FOREACH_SAFE() to make sure we don't access invalid
> BlockDriverStates or accidentally continue iterating the parents of the
> new child node instead of the node we actually came from.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Tested-by: Jeff Cody <jcody@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/io.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index 4fdf93a014..6773926fc1 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -42,9 +42,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockD=
riverState *bs,
> =20
>  void bdrv_parent_drained_begin(BlockDriverState *bs)
>  {
> -    BdrvChild *c;
> +    BdrvChild *c, *next;
> =20
> -    QLIST_FOREACH(c, &bs->parents, next_parent) {
> +    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
>          if (c->role->drained_begin) {
>              c->role->drained_begin(c);
>          }
> @@ -53,9 +53,9 @@ void bdrv_parent_drained_begin(BlockDriverState *bs)
> =20
>  void bdrv_parent_drained_end(BlockDriverState *bs)
>  {
> -    BdrvChild *c;
> +    BdrvChild *c, *next;
> =20
> -    QLIST_FOREACH(c, &bs->parents, next_parent) {
> +    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
>          if (c->role->drained_end) {
>              c->role->drained_end(c);
>          }

Hmm...not sure if this patch is enough.

Thinking about this more, if this sub-graph changes then
=2Edrained_begin() callbacks are not necessarily paired with
=2Edrained_end() callbacks.

In other words, all of the following are possible:

1. Only .drained_begin() is called
2. .drained_begin() is called, then .drained_end()
3. Only .drained_end() is called

It makes me wonder if we need to either:

Take references and ensure .drained_end() gets called if and only if
=2Edrained_begin() was also called.

OR

Document that .drained_begin/end() calls may not be paired and audit
existing code to check that this is safe.

Stefan

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaHrmoAAoJEJykq7OBq3PIe6IH/2Rl0SphRCv8BJV/A+Ozm+CB
oLi3UrKms9JTAnGS0NKxpF4dxbuAkfayMcKXcwYcrzUOaMn8MMTcB3yyWOBBuEOq
CJKh1o2MQbDniecFtrMgx2pTNMt6B6K9Z0s03ump12pBOUuXqvkbowSQ8l0T/tEi
empchx4v5Stwf+SrJ21LsX+7B2HcBIq9XLpXUn7q8tsHqPYPTBhCnGd77Ui1TXOV
ZmKLlAgytStjffe8y3hniT4WblOhjxfsCA6nbLCslwMxfg3+tI6M1kJj9vbuo7Fi
CMPhgj7KwI6hP16tWx5H6QSWzEitG5m1cjgmeqGjfR0MZrdbRC6y4d8ZTo00CcA=
=QYlT
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
