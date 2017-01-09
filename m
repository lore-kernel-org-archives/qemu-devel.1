Received: from eggs.gnu.org ([2001:4830:134:3::10]:50722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRFZr-0006Uc-C0
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRFZq-0002Da-HG
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:52:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRFZq-0002DM-8F
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:52:18 -0500
Date: Mon, 9 Jan 2017 17:05:57 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170109170557.GN30228@stefanha-x1.localdomain>
References: <1483513091-30661-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KCXyoJ//PRyfzsc9"
Content-Disposition: inline
In-Reply-To: <1483513091-30661-1-git-send-email-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 0/2] block/qapi: refactor and
 optimize the qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, famz@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com


--KCXyoJ//PRyfzsc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2017 at 02:58:09PM +0800, Dou Liyang wrote:
> Change log v2 -> v3:
>  1. Remove the unnecessary code for the bdrv_next_node().
>  2. Remove the change of the locking rules.
>     Even if this change can improve the performance, but it may
>     effect the consistency.
>=20
> For the multi-disks guest, we can use the dataplane feature to
> hold performance does not drop, if we execute some slow monitor
> commands, such as "info blockstats". But, without this feature,=20
> How to reduce the decline in performance?
>=20
> These patches aim to refactor the qmp_query_blockstats() and
> improve the performance by reducing the running time of it.
>=20
> There are the two jobs:
>=20
> 1 For the performance:
>=20
> 1.1 the time it takes(ns) in each time:
> the disk numbers     | 10    | 500
> -------------------------------------
> before these patches | 19429 | 667722=20
> after these patches  | 18536 | 627945
>=20
> 1.2 the I/O performance is degraded(%) during the monitor:
>=20
> the disk numbers     | 10    | 500
> -------------------------------------
> before these patches | 1.3   | 14.2
> after these patches  | 1.0   | 11.3
>=20
> used the dd command likes this to test:=20
> dd if=3Ddate_1.dat of=3Ddate_2.dat conv=3Dfsync oflag=3Ddirect bs=3D1k co=
unt=3D100k.
>=20
> 2 refactor qmp_query_blockstats():
>=20
> From:
>=20
> +--------------+      +---------------------+
>  | 1            |      | 4.                  |
>  |next_query_bds|      |bdrv_query_bds_stats +---+
>  |              |      |                     |   |
>  +--------^-----+      +-------------^-------+   |
>           |                          |           |
> +---------+----------+      +--------+-------+   |
> | 0.                 |      | 2.             |   |
> |qmp_query_blockstats+------>bdrv_query_stats<----
> |                    |      |                |
> +--------------------+      +--------+-------+
>                                      |
>                        +-------------v-------+
>                        | 3.                  |
>                        |bdrv_query_blk_stats |
>                        |                     |
>                        +---------------------+
>=20
> To:
>=20
>                                     +--------------+
>                                     |              |
>                            +--------v-----------+  |
>                        +--->  3.                |  |
> +-------------------+  |   |bdrv_query_bds_stats+--+
> | 1.                +--+   |                    |
> |                   +      +--------------------+
> |qmp_query_blockstats--+
> |                   |  |
> +-------------------+  |   +--------------------+
>                        |   | 2.                 |
>                        +--->                    |
>                            |bdrv_query_blk_stats|
>                            |                    |
>                            +--------------------+
>=20
> Dou Liyang (2):
>   block/qapi: reduce the coupling between the bdrv_query_stats and
>     bdrv_query_bds_stats
>   block/qapi: reduce the execution time of qmp_query_blockstats
>=20
>  block/qapi.c | 94 ++++++++++++++++++++++++++----------------------------=
------
>  1 file changed, 40 insertions(+), 54 deletions(-)

Leaving review to Markus Armbruster since he maintains this area.

--KCXyoJ//PRyfzsc9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYc8L1AAoJEJykq7OBq3PIW7gH/jAQkKv85WpxmAnbnSpmXEpi
zSkqlhtOlAZik79rpJjz5hlkx8NPa9oI1jHOGTBEiykOf0siuXvTXSWlXj17Wqge
314aqGSHMKYwUTy+CyBNGXu/feM9Gb7D2tG5ZcvTE9idWNzwdfu9Q5toQ+aBWXXE
8lSVQEqdbiUY1WobTP6BEmO12RacaAGt1bqJwQ17uzKcjScfDC9Jr1w51rVuEdOZ
728Zld1PIJ9cPBYdI15I/jggAS20udCctYIr0GdrgxBOVatc3T9Kj0k3SbKr3cQ5
FFog9qeVEEIESDE6TdfbI42/IXjc7NAf/LYtHpy21VZRjJk39QooOv/QK4cK1x0=
=45nE
-----END PGP SIGNATURE-----

--KCXyoJ//PRyfzsc9--
