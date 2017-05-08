Received: from eggs.gnu.org ([2001:4830:134:3::10]:57752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7kzt-0001es-J8
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7kzs-0004nq-Ol
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:54:53 -0400
References: <20170507000552.20847-1-eblake@redhat.com>
	<20170507000552.20847-7-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3f3d454b-6ab4-52d4-eaac-adaeec3ca700@redhat.com>
Date: Mon, 8 May 2017 17:54:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170507000552.20847-7-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EvpF0l7icibhCoe4ePRE4StQV4RQd1Mnq"
Subject: Re: [Qemu-devel] [PATCH v13 06/12] qcow2: Make distinction between
 zero cluster types obvious
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EvpF0l7icibhCoe4ePRE4StQV4RQd1Mnq
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <3f3d454b-6ab4-52d4-eaac-adaeec3ca700@redhat.com>
Subject: Re: [PATCH v13 06/12] qcow2: Make distinction between zero cluster
 types obvious
References: <20170507000552.20847-1-eblake@redhat.com>
 <20170507000552.20847-7-eblake@redhat.com>
In-Reply-To: <20170507000552.20847-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.05.2017 02:05, Eric Blake wrote:
> Treat plain zero clusters differently from allocated ones, so that
> we can simplify the logic of checking whether an offset is present.
> Do this by splitting QCOW2_CLUSTER_ZERO into two new enums,
> QCOW2_CLUSTER_ZERO_PLAIN and QCOW2_CLUSTER_ZERO_ALLOC.
>=20
> I tried to arrange the enum so that we could use
> 'ret <=3D QCOW2_CLUSTER_ZERO_PLAIN' for all unallocated types, and
> 'ret >=3D QCOW2_CLUSTER_ZERO_ALLOC' for allocated types, although
> I didn't actually end up taking advantage of the layout.
>=20
> In many cases, this leads to simpler code, by properly combining
> cases (sometimes, both zero types pair together, other times,
> plain zero is more like unallocated while allocated zero is more
> like normal).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v13: s/!preallocated/cluster_type =3D=3D QCOW2_CLUSTER_ZERO_PLAIN/, fix=

> error message text (including iotest fallout), rebase to earlier cleanu=
ps
> v12: new patch
> ---
>  block/qcow2.h              |  8 +++--
>  block/qcow2-cluster.c      | 81 ++++++++++++++++++--------------------=
--------
>  block/qcow2-refcount.c     | 44 +++++++++++--------------
>  block/qcow2.c              |  9 ++++--
>  tests/qemu-iotests/060.out |  6 ++--
>  5 files changed, 64 insertions(+), 84 deletions(-)

[...]

> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index ed78a30..a4a3229 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c

[...]

> @@ -344,13 +343,13 @@ static int count_contiguous_clusters_unallocated(=
int nb_clusters,
>  {
>      int i;
>=20
> -    assert(wanted_type =3D=3D QCOW2_CLUSTER_ZERO ||
> +    assert(wanted_type =3D=3D QCOW2_CLUSTER_ZERO_PLAIN ||
>             wanted_type =3D=3D QCOW2_CLUSTER_UNALLOCATED);
>      for (i =3D 0; i < nb_clusters; i++) {
>          uint64_t entry =3D be64_to_cpu(l2_table[i]);
> -        int type =3D qcow2_get_cluster_type(entry);
> +        QCow2ClusterType type =3D qcow2_get_cluster_type(entry);

With this moved into the previous patch:

Reviewed-by: Max Reitz <mreitz@redhat.com>

(No, I'm not mentioning the fact that 060.out contains one more mention
of "Data cluster offset" that should definitely be a "Cluster allocation
offset" or even "Preallocated zero cluster offset" at
block/qcow2-cluster.c:1780, because let's really worry about this later)

>=20
> -        if (type !=3D wanted_type || entry & L2E_OFFSET_MASK) {
> +        if (type !=3D wanted_type) {
>              break;
>          }
>      }


--EvpF0l7icibhCoe4ePRE4StQV4RQd1Mnq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkQlMYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AgMkH/3UqmuWlsMHBGK+MexqyWh6bjGiSe330
p6V+sJdlAfEg9WM6duWVMrKihdyZ2lie52KOgKHMGcipchHDiriOEjLEu3KG6lVq
QSM7DDPZlkppn5Nu1nWB+7wWEaQWoERkhuURww/iFf/YDBr8+/YOT6/27GfzTDKw
elg2TYlwks/009QWFHNot+8MBpP37IkoSgonTCbM+a/OOL6SxqOeuz/xicr9ZMJZ
PoyIbiDDBS0jF68LFNmjfI5ZXwg5EMf5a4Uy3yHvjN2cBN2dYAMxHOjRGSLbT7Yc
tBXV5pu0oYz+y7lR0gpDzgaqXK1FxvZlvmBGQClpFZuGHReMZbcDJ68=
=BHiN
-----END PGP SIGNATURE-----

--EvpF0l7icibhCoe4ePRE4StQV4RQd1Mnq--
