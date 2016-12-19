Received: from eggs.gnu.org ([2001:4830:134:3::10]:50799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cIyn4-0006xs-UR
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cIyn0-0007RE-1o
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:19:46 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cIymz-0007QT-Q1
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:19:41 -0500
Received: by mail-wm0-x243.google.com with SMTP id u144so18893138wmu.0
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 06:19:41 -0800 (PST)
Date: Mon, 19 Dec 2016 14:19:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161219141938.GF17374@stefanha-x1.localdomain>
References: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1482137486-9843-2-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Content-Disposition: inline
In-Reply-To: <1482137486-9843-2-git-send-email-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 1/4] block: refactor bdrv_next_node
 for readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: stefanha@redhat.com, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, famz@redhat.com, danpb@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, qemu-devel@nongnu.org


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2016 at 04:51:23PM +0800, Dou Liyang wrote:
> make the bdrv_next_node() clearly and add some comments.
>=20
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  block.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 39ddea3..01c9e51 100644
> --- a/block.c
> +++ b/block.c
> @@ -2931,12 +2931,20 @@ bool bdrv_chain_contains(BlockDriverState *top, B=
lockDriverState *base)
>      return top !=3D NULL;
>  }
> =20
> +/*
> + * Return the BlockDriverStates of all the named nodes.

This sentence describes how this function is used in a loop.  The
semantics of one call to this function are different: only a *single*
named node's BlockDriverState is returned.

> + * If @bs is null, return the first one.
> + * Else, return @bs's next sibling, which may be null.
> + *
> + * To iterate over all BlockDriverStates, do
> + * for (bs =3D bdrv_next_node(NULL); bs; bs =3D bdrv_next_node(blk)) {
> + *     ...
> + * }
> + */
>  BlockDriverState *bdrv_next_node(BlockDriverState *bs)
>  {
> -    if (!bs) {
> -        return QTAILQ_FIRST(&graph_bdrv_states);
> -    }
> -    return QTAILQ_NEXT(bs, node_list);
> +    return bs ? QTAILQ_NEXT(bs, node_list)
> +            : QTAILQ_FIRST(&graph_bdrv_states);

The conditional operator (?:) is often considered harder to read than an
if statement.  I see no reason to modify the code.

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYV+x6AAoJEJykq7OBq3PIsH0H/29WBGGPY3CN1eh4sIIbNQBK
qm9A0zietb48ynabKCpQR8cAX/d1PTVeii1CqdFP7IJcmxKaFsaRt02BQ2vSjkp4
VivQXKkH2GTO/ULqVMIcVeZACWB5aETU/9/C6jL5EBIsV58tBWiQtnTL5Jz48tzR
U4ph4Ho/qVPAOYbyjpOYZbw9SPxEVR1EsQOm5a4HLDKEdyUTxhJsslC/hjVRodgR
lj0ao93pHvw9shOKdH2lAbOwoBVhi2rymtYI13Oga700wujQ2suvFhsrSGqeY5I1
ZaITuBtmCbSQno6BTsMto59irFc8ySny7j3Qfk0DQzWk5vXCe7pegvxMGQzSkW4=
=dLre
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
