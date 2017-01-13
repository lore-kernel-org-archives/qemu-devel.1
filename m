Received: from eggs.gnu.org ([2001:4830:134:3::10]:35176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cS3Lc-0008CE-Gi
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cS3LY-00056z-MD
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:00:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cS3LY-00055x-DD
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:00:52 -0500
References: <1483513091-30661-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1483513091-30661-2-git-send-email-douly.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5e0a6a79-cb60-b1f0-06ab-2362f63afb78@redhat.com>
Date: Fri, 13 Jan 2017 09:00:49 -0600
MIME-Version: 1.0
In-Reply-To: <1483513091-30661-2-git-send-email-douly.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xdQAnFcqDQkHwoGShBPPPvrm03AcMsVUq"
Subject: Re: [Qemu-devel] [PATCH RFC v3 1/2] block/qapi: reduce the coupling
 between the bdrv_query_stats and bdrv_query_bds_stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, stefanha@redhat.com, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, famz@redhat.com
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xdQAnFcqDQkHwoGShBPPPvrm03AcMsVUq
From: Eric Blake <eblake@redhat.com>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, stefanha@redhat.com,
 kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, famz@redhat.com
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com,
 caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com
Message-ID: <5e0a6a79-cb60-b1f0-06ab-2362f63afb78@redhat.com>
Subject: Re: [PATCH RFC v3 1/2] block/qapi: reduce the coupling between the
 bdrv_query_stats and bdrv_query_bds_stats
References: <1483513091-30661-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1483513091-30661-2-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1483513091-30661-2-git-send-email-douly.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/04/2017 12:58 AM, Dou Liyang wrote:
> the bdrv_query_stats and bdrv_query_bds_stats functions need to call
> each other, that increases the coupling. it also makes the program
> complicated and makes some unnecessary judgements.

s/judgements/judgments/ - although I wonder if 'tests' would be a
simpler word.

>=20
> remove the call from bdrv_query_bds_stats to bdrv_query_stats, just
> take some recursion to make it clearly.
>=20
> avoid judging whether the blk is NULL during querying the bds stats.

Again, 'testing' might read nicer than 'judging'.

> it is unnecessary.
>=20
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  block/qapi.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>=20

> -static void bdrv_query_bds_stats(BlockStats *s, const BlockDriverState=
 *bs,
> +static BlockStats *bdrv_query_bds_stats(const BlockDriverState *bs,
>                                   bool query_backing)
>  {
> +    BlockStats *s =3D NULL;
> +
> +    s =3D g_malloc0(sizeof(*s));

Dead initialization to NULL since the very next statement overwrites it.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xdQAnFcqDQkHwoGShBPPPvrm03AcMsVUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYeOuhAAoJEKeha0olJ0NqKUoH/0eDceSFEEt4+s4IMYo07q8q
sQSd8bl2PUEfkUMc00OqyTVZN5j6yQJjTZKDLNfYJ6uy7ba+tJatu/B9B+fMo1wt
+/LkLqWspbeW5jc4mGsPSbgVO2pMcF4NosPbEzdiTjZpsD6eX0J6GkYoMgD1kPUO
rDS7PgLALjqPF0P8jKvRRsm1CZIpKN9zZoqDBEy00c9Wi6Xsz9S30KP6657wFj/c
7MQJ03ldfdBDDrGcnoHVX40LbdW8HL63eXUSpuhGcUjKk9ZHoXyyJTUMNiE6xJ8E
5jp0xME4HVucOQ6nvpFlUlmj+lCUfiWKMNBx+520wkMAmBlEfhKZcTgSJHZjJFY=
=sChu
-----END PGP SIGNATURE-----

--xdQAnFcqDQkHwoGShBPPPvrm03AcMsVUq--
