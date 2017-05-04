Received: from eggs.gnu.org ([2001:4830:134:3::10]:57858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d655y-0005ID-W5
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d655y-0008VA-2C
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:58:15 -0400
References: <20170503231120.23507-1-mreitz@redhat.com>
	<20170503231120.23507-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1d1d5a4d-26ee-4bef-f7f2-4ab7944e65ce@redhat.com>
Date: Wed, 3 May 2017 19:58:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170503231120.23507-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mK7WgSow71vOq7QL8ljwfeRDF3IdAPb3q"
Subject: Re: [Qemu-devel] [PATCH 2/4] qcow2: Reuse preallocated zero clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mK7WgSow71vOq7QL8ljwfeRDF3IdAPb3q
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <1d1d5a4d-26ee-4bef-f7f2-4ab7944e65ce@redhat.com>
Subject: Re: [PATCH 2/4] qcow2: Reuse preallocated zero clusters
References: <20170503231120.23507-1-mreitz@redhat.com>
 <20170503231120.23507-3-mreitz@redhat.com>
In-Reply-To: <20170503231120.23507-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/03/2017 06:11 PM, Max Reitz wrote:
> Instead of just freeing preallocated zero clusters and completely
> allocating them from scratch, reuse them.
>=20
> We cannot do this in handle_copied(), however, since this is a COW
> operation. Therefore, we have to add the new logic to handle_alloc() an=
d
> simply return the existing offset if it exists. The only catch is that
> we have to convince qcow2_alloc_cluster_link_l2() not to free the old
> clusters (because we have reused them).
>=20
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.h         |  3 ++
>  block/qcow2-cluster.c | 80 +++++++++++++++++++++++++++++++++++--------=
--------
>  2 files changed, 59 insertions(+), 24 deletions(-)
>=20

> =20
> -    assert(qcow2_get_cluster_type(first_entry) =3D=3D QCOW2_CLUSTER_NO=
RMAL);
> +    /* must be allocated */
> +    first_cluster_type =3D qcow2_get_cluster_type(first_entry);
> +    assert(first_cluster_type =3D=3D QCOW2_CLUSTER_NORMAL ||
> +           (first_cluster_type =3D=3D QCOW2_CLUSTER_ZERO &&
> +            (first_entry & L2E_OFFSET_MASK) !=3D 0));

I wonder if we should have separate QCOW2_CLUSTER_ZERO_PLAIN and
QCOW2_CLUSTER_ZERO_ALLOCATED, so we don't have to keep checking
first_entry & L2E_OFFSET_MASK.  But I think that can be a separate
followup if we want it.


Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mK7WgSow71vOq7QL8ljwfeRDF3IdAPb3q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCnyfAAoJEKeha0olJ0NqcN8IAIY2QbZzSI2j85MdSZcm23Nw
odrKrQ0oeaMsb5kuw/AEgbTIO6AINMisM+PZI+LbOBMHqHMp+DijsU+b7YLHcEp0
ku0owSQC3/lI8U4C/SKfn/qsrk//1tmXyYNHPOZn+jurt6Wr6zp/LBYIW7P/xZg5
X5ZTtzjMNvyCnLtufHB4WAea+GxS0FFWZ94ebtyy/yoDr4S2Kgj7zLdtY00c+jHp
2PJxF6Koe+3KCuotlErzG3limYvrkjonaoB/keWBqiWVndFHgsL7AhJnmI+r58NO
ccPBdOl7bVaKQnKcLfYc9WGkE2MUXvQyKOc1QSsTlPTVAqKjgTHFk1IaEw0iedM=
=5BIP
-----END PGP SIGNATURE-----

--mK7WgSow71vOq7QL8ljwfeRDF3IdAPb3q--
