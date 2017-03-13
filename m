Received: from eggs.gnu.org ([2001:4830:134:3::10]:51164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnY7p-0004kU-BX
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnY7o-0007pp-EE
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:07:33 -0400
References: <20170308025428.1037-1-eblake@redhat.com>
	<20170308025428.1037-4-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bbc01fff-d711-f620-b8fa-add26f4412fa@redhat.com>
Date: Mon, 13 Mar 2017 23:07:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170308025428.1037-4-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ePWbAjLpx4m5AT0BtwTJgSpE65JKQuiRr"
Subject: Re: [Qemu-devel] [PATCH v6 03/10] qcow2: Assert that cluster
 operations are aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ePWbAjLpx4m5AT0BtwTJgSpE65JKQuiRr
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <bbc01fff-d711-f620-b8fa-add26f4412fa@redhat.com>
Subject: Re: [PATCH v6 03/10] qcow2: Assert that cluster operations are
 aligned
References: <20170308025428.1037-1-eblake@redhat.com>
 <20170308025428.1037-4-eblake@redhat.com>
In-Reply-To: <20170308025428.1037-4-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 08.03.2017 03:54, Eric Blake wrote:
> qcow2_discard_clusters() is set up to silently ignore sub-cluster
> head or tail on unaligned requests.  However, it is easy to audit
> the various callers: qcow2_snapshot_create() has always passed
> aligned data since the call was introduced in 1ebf561;
> qcow2_co_pdiscard() has passed aligned clusters since commit
> ecdbead taught the block layer the preferred discard alignment (the
> block layer can still pass sub-cluster values, but those are
> handled directly in qcow2_co_pdiscard()); and qcow2_make_empty()
> was fixed to pass aligned clusters in commit a3e1505.  Replace
> rounding with assertions to hold us to the tighter contract,
> eliminating the now-impossible case of an early exit for a
> sub-cluster request.
>=20
> qcow2_zero_clusters() has always been called with cluster-aligned
> arguments from its lone caller qcow2_co_pwrite_zeroes() (like
> qcow2_co_pdiscard(), the caller takes care of sub-cluster requests
> from the block layer; and qcow2_zero_clusters() would have
> misbehaved on unaligned requests), but it deserves the same
> assertion for symmetry.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v6: avoid assertion on non-cluster-aligned image, use s->cluster_sector=
s
> to avoid a shift, drop R-b
> v5: no change
> v4: new patch
> ---
>  block/qcow2-cluster.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ePWbAjLpx4m5AT0BtwTJgSpE65JKQuiRr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljHGBwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ai1MIAK6oyBZpQ32Fw1+gpO3Sx0x7KbYa8NcY
A/idzRSIbwq+qSxplJ9BlNabpFeVgvwab0zeSaZlgl/9ReE3ZHHlJazpxtK6cdQI
fun9T5CgzK1t5aOg6Vpx31C+km+D3CNfeRbxxLFOpmwIbXGgT0Ig2izfpieDey1w
sjr6W4/J2se+/7jp8aWs+KX2vF8HjNZUddaU5V2HvgsKjbZtPDQfgT1uVFOH523K
3OmfuBm116JSthHwZqU6z1CgBXv8scSDHdMmr5OBqDYyN97ypYcLwM8n0mBCw4of
OWRYNo4lIZb5H3SJTOFqZxcsXJTF+X5lKWjlLqa3p7g7l323eqWGDO4=
=tTfK
-----END PGP SIGNATURE-----

--ePWbAjLpx4m5AT0BtwTJgSpE65JKQuiRr--
