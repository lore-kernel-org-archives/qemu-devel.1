Received: from eggs.gnu.org ([2001:4830:134:3::10]:46024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ2Ds-0006ul-0J
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 16:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ2Dq-0008FP-O1
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 16:13:47 -0500
References: <20170201123828.4815-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <29095c93-3899-3f1e-6044-60cc7cf2736f@redhat.com>
Date: Wed, 1 Feb 2017 22:13:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170201123828.4815-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="58fT4gq2EGfVrsT18kwMJRFHawN95AGex"
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: Optimize the refcount-block
 overlap check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--58fT4gq2EGfVrsT18kwMJRFHawN95AGex
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <29095c93-3899-3f1e-6044-60cc7cf2736f@redhat.com>
Subject: Re: [PATCH v2] qcow2: Optimize the refcount-block overlap check
References: <20170201123828.4815-1-berto@igalia.com>
In-Reply-To: <20170201123828.4815-1-berto@igalia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 01.02.2017 13:38, Alberto Garcia wrote:
> The metadata overlap checks introduced in a40f1c2add help detect
> corruption in the qcow2 image by verifying that data writes don't
> overlap with existing metadata sections.
>=20
> The 'refcount-block' check in particular iterates over the refcount
> table in order to get the addresses of all refcount blocks and check
> that none of them overlap with the region where we want to write.
>=20
> The problem with the refcount table is that since it always occupies
> complete clusters its size is usually very big. With the default
> values of cluster_size=3D64KB and refcount_bits=3D16 this table holds 8=
192
> entries, each one of them enough to map 2GB worth of host clusters.
>=20
> So unless we're using images with several TB of allocated data this
> table is going to be mostly empty, and iterating over it is a waste of
> CPU. If the storage backend is fast enough this can have an effect on
> I/O performance.
>=20
> This patch keeps the index of the last used (i.e. non-zero) entry in
> the refcount table and updates it every time the table changes. The
> refcount-block overlap check then uses that index instead of reading
> the whole table.
>=20
> In my tests with a 4GB qcow2 file stored in RAM this doubles the
> amount of write IOPS.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
> Changes:
>=20
> v2:
> - Handle tables with holes correctly in alloc_refcount_block()

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--58fT4gq2EGfVrsT18kwMJRFHawN95AGex
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliST4ASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+F8IAIDGPHShy+TpI4Nq+XlY75TTKMQCiby+
r0M0rza4lHpmQVVux+nu3oRc+1R21IvdkRSI+cj7pXPcjzlk7e8aN+/elhgslREr
jmMamT14+e7xTjr8qPj9R2B9ng7r+7D4F5BYIjEPqORAveTQ3o0OjvsTk7HIo5ac
L+jqNzi55Jv9tnE9EjaeHCGdWtZBMmewLM+QM/ziPsSmBiCUgGdjmFLOyqTKsSdn
PuAEnxtJtvrLqyhTxl05BBVb5hxGejt34vK4KZ9F6k9pyrrp8Uanxwb6nl5wDqNB
nRjNaGpItKYqKCjOs0ltotRxHBJEh7NtS0JD/xWOv1iAXQorEFpzosU=
=jMnr
-----END PGP SIGNATURE-----

--58fT4gq2EGfVrsT18kwMJRFHawN95AGex--
