Received: from eggs.gnu.org ([2001:4830:134:3::10]:55441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evNhl-0004lx-7S
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evNhh-0007sr-6u
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:41:33 -0400
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
	<20180309182202.31206-2-farosas@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ef7445b2-073c-d51f-a753-bb9f01287513@redhat.com>
Date: Mon, 12 Mar 2018 14:41:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180309182202.31206-2-farosas@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Yl6HKNBJEJUH1mXlmITo13fnanN1l2Gdf"
Subject: Re: [Qemu-devel] [PATCH 1/5] block/replication: Remove
 protocol_name field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yl6HKNBJEJUH1mXlmITo13fnanN1l2Gdf
From: Max Reitz <mreitz@redhat.com>
To: Fabiano Rosas <farosas@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <ef7445b2-073c-d51f-a753-bb9f01287513@redhat.com>
Subject: Re: [PATCH 1/5] block/replication: Remove protocol_name field
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
 <20180309182202.31206-2-farosas@linux.vnet.ibm.com>
In-Reply-To: <20180309182202.31206-2-farosas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-09 19:21, Fabiano Rosas wrote:
> The replication driver is only selected explicitly (via
> driver=3Dreplication,mode=3Dprimary,...) so it is not a protocol driver=
=2E

That's not really the point.  It isn't a protocol driver because it has
a "file" child (opened in replication_open).  All in all it's a filter
driver.

Apart from that, having a protocol_name might still be OK even for
non-protocol drivers; for instance, blkdebug and blkverify are both
filter drivers, but since they implement bdrv_parse_filename() it's OK
for them to specify protocol_name.

So your sentence is half correct.  Because it can only be selected
explicitly (for several reasons), giving a protocol_name doesn't make
sense.  (Independently of whether it is a protocol driver or not.)

But anyway:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> This patch removes the protocol_name field from the brdv_replication
> structure so that attempts to invoke this driver using protocol
> syntax (i.e. replication:<filename:options:...>) will fail gracefully:
>=20
>   $ qemu-img info replication:foo
>   qemu-img: Could not open 'replication:': Unknown protocol 'replicatio=
n'
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1726733
> Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
> ---
>  block/replication.c | 1 -
>  replication.h       | 1 -
>  2 files changed, 2 deletions(-)
>=20
> diff --git a/block/replication.c b/block/replication.c
> index f98ef094b9..6c0c7186d9 100644
> --- a/block/replication.c
> +++ b/block/replication.c
> @@ -703,7 +703,6 @@ static void replication_stop(ReplicationState *rs, =
bool failover, Error **errp)
> =20
>  BlockDriver bdrv_replication =3D {
>      .format_name                =3D "replication",
> -    .protocol_name              =3D "replication",
>      .instance_size              =3D sizeof(BDRVReplicationState),
> =20
>      .bdrv_open                  =3D replication_open,
> diff --git a/replication.h b/replication.h
> index 8faefe005f..4c8354de23 100644
> --- a/replication.h
> +++ b/replication.h
> @@ -67,7 +67,6 @@ typedef struct ReplicationState ReplicationState;
>   *
>   * BlockDriver bdrv_replication =3D {
>   *     .format_name                =3D "replication",
> - *     .protocol_name              =3D "replication",
>   *     .instance_size              =3D sizeof(BDRVReplicationState),
>   *
>   *     .bdrv_open                  =3D replication_open,
>=20



--Yl6HKNBJEJUH1mXlmITo13fnanN1l2Gdf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqmg3ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+98IAKYObiI7Q4kBm0BN7QVES8nP32DrYAR+
Ff55UWvDwINwHe7IjljT7KEuieQlZHcXCaHo1cZ74XbcGz3HqeDMMtV0obyRa5MF
VqU24VS4ZtIhkS7RWPlFTx+cfoj0+Tb7Iy35pHJTeqUDqdQsTPWCNiuYy1piCPbk
BfVhAJ+51NrnnNfptf3pvoh+HIIm4y08xgFC9mzy/o1gMmlVGxRt+JLtyTA6H47H
41I0rrwThD3K2D9RxtUnsEChf835TbCrML9iKyEJZq2tE0Z90YYmPI1GLdbjCv9H
HGxSbb2eKkxGzb2uxj22UZSu5Os92Y1y49yG4pNFzZauBI0luurpt+8=
=ilBW
-----END PGP SIGNATURE-----

--Yl6HKNBJEJUH1mXlmITo13fnanN1l2Gdf--
