Received: from eggs.gnu.org ([209.51.188.92]:56577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj3Ic-0007sp-6w
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj3Ia-0004b3-Di
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:33:10 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-4-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <02429c8e-6453-3160-df89-1ae51d1abf7b@redhat.com>
Date: Mon, 14 Jan 2019 15:32:43 +0100
MIME-Version: 1.0
In-Reply-To: <20181229122027.42245-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ppriowc6re6eW3ajUsLABfwDCdRNRmZy8"
Subject: Re: [Qemu-devel] [PATCH v5 03/11] block: improve should_update_child
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ppriowc6re6eW3ajUsLABfwDCdRNRmZy8
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com, jsnow@redhat.com
Message-ID: <02429c8e-6453-3160-df89-1ae51d1abf7b@redhat.com>
Subject: Re: [PATCH v5 03/11] block: improve should_update_child
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-4-vsementsov@virtuozzo.com>
In-Reply-To: <20181229122027.42245-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
> As it already said in the comment, we don't want to create loops in
> parent->child relations. So, when we try to append @to to @c, we should=

> check that @c is not in @to children subtree, and we should check it
> recursively, not only the first level. The patch provides BFS-based
> search, to check the relations.
>=20
> This is needed for further fleecing-hook filter usage: we need to
> append it to source, when the hook is already a parent of target, and
> source may be in a backing chain of target (fleecing-scheme). So, on
> appending, the hook should not became a child (direct or through
> children subtree) of the target.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)

Just two technical details:

> diff --git a/block.c b/block.c
> index 4f5ff2cc12..8f04f293da 100644
> --- a/block.c
> +++ b/block.c
> @@ -3536,7 +3536,7 @@ void bdrv_close_all(void)
> =20
>  static bool should_update_child(BdrvChild *c, BlockDriverState *to)
>  {
> -    BdrvChild *to_c;
> +    GList *queue =3D NULL, *pos;

GSList should be sufficient, I think.

> =20
>      if (c->role->stay_at_node) {
>          return false;
> @@ -3572,13 +3572,36 @@ static bool should_update_child(BdrvChild *c, B=
lockDriverState *to)
>       * if A is a child of B, that means we cannot replace A by B there=

>       * because that would create a loop.  Silently detaching A from B
>       * is also not really an option.  So overall just leaving A in
> -     * place there is the most sensible choice. */
> -    QLIST_FOREACH(to_c, &to->children, next) {
> -        if (to_c =3D=3D c) {
> -            return false;
> +     * place there is the most sensible choice.
> +     *
> +     * We would also create a loop in any cases where @c is only
> +     * indirectly referenced by @to. Prevent this by returning false
> +     * if @c is found (by breadth-first search) anywhere in the whole
> +     * subtree of @to.
> +     */
> +
> +    pos =3D queue =3D g_list_append(queue, to);
> +    while (pos) {
> +        BlockDriverState *v =3D pos->data;
> +        BdrvChild *c2;
> +
> +        QLIST_FOREACH(c2, &v->children, next) {
> +            if (c2 =3D=3D c) {
> +                g_list_free(queue);
> +                return false;
> +            }
> +
> +            if (g_list_find(queue, c2->bs)) {
> +                continue;
> +            }
> +
> +            queue =3D g_list_append(queue, c2->bs);

Appending to pos should be a bit quicker, I presume.  (And you can
probably ignore the result, or just assert that the first argument was
returned.)

Max

>          }
> +
> +        pos =3D pos->next;
>      }
> =20
> +    g_list_free(queue);
>      return true;
>  }
> =20
>=20



--Ppriowc6re6eW3ajUsLABfwDCdRNRmZy8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw8nYsACgkQ9AfbAGHV
z0DMLQf/Wt9yjyMv+90v9/7HqtOq6mEAB53uFlu/+jxEBdogOG7SEBFjjgkHbAIK
ohSOTyKGQ0XujPOpw3+tW92K9yH1mQUFkaCNcQDqt7lKZv+vHZ4CfSy2etjiMFl8
ViMzuP0+oBaXGNnq/aMC6MmZTeBmycqH4gTPHFp9gNIGdRZ7FbseaJ7NEYEXOeQQ
wzE20qV/U2mxoENYPCBCqWqVCgUuXpBvV910pVB49bEUbmahkLlGphMUM1vteciz
+v8leSDgMSOmtW2UNLUQuP5YFJkMjItS+VNfb95FVuCI94E8MQInfxQxORacPiwK
bWg5H9Vpo1krvGE012WV22weN6/05Q==
=Mxm2
-----END PGP SIGNATURE-----

--Ppriowc6re6eW3ajUsLABfwDCdRNRmZy8--
