Received: from eggs.gnu.org ([2001:4830:134:3::10]:37178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYlFT-0005dL-44
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 22:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYlFP-00041O-Vt
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 22:06:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cYlFP-00040z-Mi
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 22:06:15 -0500
References: <1484467275-27919-1-git-send-email-douly.fnst@cn.fujitsu.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1a4f4e94-7d31-e8de-dc28-516120ed03b7@redhat.com>
Date: Wed, 1 Feb 2017 04:06:10 +0100
MIME-Version: 1.0
In-Reply-To: <1484467275-27919-1-git-send-email-douly.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xc3i2mSC9049jo3dE235QuQbHoFw1X2V9"
Subject: Re: [Qemu-devel] [PATCH v4 0/2] block/qapi: refactor and optimize
 the qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, stefanha@redhat.com, kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xc3i2mSC9049jo3dE235QuQbHoFw1X2V9
From: Max Reitz <mreitz@redhat.com>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, stefanha@redhat.com,
 kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com,
 caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com
Message-ID: <1a4f4e94-7d31-e8de-dc28-516120ed03b7@redhat.com>
Subject: Re: [PATCH v4 0/2] block/qapi: refactor and optimize the
 qmp_query_blockstats()
References: <1484467275-27919-1-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1484467275-27919-1-git-send-email-douly.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 15.01.2017 09:01, Dou Liyang wrote:
> Change log v3 -> v4:
>  1. Develop these into the non-RFC patches.
>  2. Fix some comments.
>  3. do declarations first.
>=20
> Change log v2 -> v3:
>  1. Remove the unnecessary code for the bdrv_next_node().
>  2. Remove the change of the locking rules.
>     Even if this change can improve the performance, but it may
>     effect the consistency.
>=20
> The Qemu uses the qmp_query_blockstats() function to get the
> blockstats. As the function has been changed several times, it
> becomes more complex and longer.
>=20
> For the multi-disks guest, if we want to execute I/O operations
> and this function at the same time. we can use the dataplane
> feature to hold I/O performance does not drop. But, Normally
> without this feature, How to reduce the decline in performance?
>=20
> These patches refactor the qmp_query_blockstats() to make the
> code easier to follow, and shorter as follows:
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
>=20
> They also optimize the fuction by reducing its running time.
>=20
> 1. The function running time
>=20
> the time it takes(ns) in each requests:
> the disk numbers     | 10    | 500
> -------------------------------------
> before these patches | 19429 | 667722=20
> after these patches  | 18536 | 627945
>=20
> 2. For the performance
> used the dd command likes this to test:=20
> dd if=3Ddate_1.dat of=3Ddate_2.dat conv=3Dfsync oflag=3Ddirect bs=3D1k =
count=3D100k.
>=20
> the I/O performance is degraded(%) during the monitor:
> the disk numbers     | 10    | 500
> -------------------------------------
> before these patches | 1.3   | 14.2
> after these patches  | 1.0   | 11.3
>=20
> Dou Liyang (2):
>   block/qapi: reduce the coupling between the bdrv_query_stats and
>     bdrv_query_bds_stats
>   block/qapi: reduce the execution time of qmp_query_blockstats
>=20
>  block/qapi.c | 95 ++++++++++++++++++++++++++--------------------------=
--------
>  1 file changed, 41 insertions(+), 54 deletions(-)

Thanks, dropped one of the duplicate info->value assignments in patch 2
and applied the series to my block tree:

https://github.com/XanClic/qemu/commits/block

(Assuming Markus' R-b meant that he does not intends to take it through
his tree.)

Max


--Xc3i2mSC9049jo3dE235QuQbHoFw1X2V9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRUKISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AUW4IAK8bPh7OGui+/QWP2h7jYJ+rFJvCGUak
BcV9fXjS581y0vqZtGjm65kHv6XaYuIhtaVZP/oV/xDJewyAVH6TbeDO7T4AIDgr
gkxBpL5jyfKjciYA0XO1w1YjpQYolwkS44ewbgP/9n+vPxuUV/CRrcvL3gP4LHRX
5aDH4q6sIpOfLFg7GJXhLqdBb7tIwVlCcZ00USkQoHsMvfKKUyAEpONk4XoyO2M2
xKUhSFm2SmREoR3Dv4HmSrHHasc9doypQytuur9RdizTXILPAycpUhDJw6GPmnFm
QWlKQp9zyzhoPxiJSSy1MpUeA2jy2nGmmaxBilmsd2iP2gFf5Tjkh3g=
=SSRf
-----END PGP SIGNATURE-----

--Xc3i2mSC9049jo3dE235QuQbHoFw1X2V9--
