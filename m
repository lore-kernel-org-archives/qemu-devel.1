Received: from eggs.gnu.org ([2001:4830:134:3::10]:43870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7kAE-0007JM-E8
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7kAB-0003rz-Sn
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:01:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d7kAB-0003rn-Jd
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:01:27 -0400
References: <20170508141536.20690-1-stefanha@redhat.com>
	<20170508141536.20690-5-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <68fd3173-ae56-50ed-4cfc-f9c19904aa30@redhat.com>
Date: Mon, 8 May 2017 10:00:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170508141536.20690-5-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lS0GcFHcMQ6DAFrCtXTuWlx2OViT7N0Wk"
Subject: Re: [Qemu-devel] [PATCH v6 4/9] qcow2: make refcount size
 calculation conservative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lS0GcFHcMQ6DAFrCtXTuWlx2OViT7N0Wk
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>,
 John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <68fd3173-ae56-50ed-4cfc-f9c19904aa30@redhat.com>
Subject: Re: [PATCH v6 4/9] qcow2: make refcount size calculation conservative
References: <20170508141536.20690-1-stefanha@redhat.com>
 <20170508141536.20690-5-stefanha@redhat.com>
In-Reply-To: <20170508141536.20690-5-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 09:15 AM, Stefan Hajnoczi wrote:
> The refcount metadata size calculation is inaccurate and can produce
> numbers that are too small.  This is bad because we should calculate a
> conservative number - one that is guaranteed to be large enough.
>=20
> This patch switches the approach to a fixed point calculation because
> the existing equation is hard to solve when inaccuracies are taken care=

> of.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 82 ++++++++++++++++++++++++++++++---------------------=
--------
>  1 file changed, 42 insertions(+), 40 deletions(-)
>=20

> -    nrefblocke =3D (aligned_total_size + meta_size + cluster_size)
> -        / (cluster_size - rces - rces * sizeof(uint64_t)
> -                / cluster_size);
> -    meta_size +=3D DIV_ROUND_UP(nrefblocke, refblock_size) * cluster_s=
ize;
> -
> -    /* total size of refcount tables */
> -    nreftablee =3D nrefblocke / refblock_size;
> -    nreftablee =3D align_offset(nreftablee, cluster_size / sizeof(uint=
64_t));
> -    meta_size +=3D nreftablee * sizeof(uint64_t);
> +    /* total size of refcount table and blocks */
> +    meta_size +=3D qcow2_refcount_metadata_size(
> +            (meta_size + aligned_total_size) / cluster_size,

How does this interact with Max's patch which avoids truncating division
in favor of rounding up?
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00690.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lS0GcFHcMQ6DAFrCtXTuWlx2OViT7N0Wk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEIgeAAoJEKeha0olJ0NqHPoH/A/Yrft9QppBhAFfWJYlLOIJ
WoARbJa2WtgmGG5e9cRa03JxQC3aZbwfAUC0Ydmf9R+2d6ZptkHfxBp2d7K4SMwx
8uqhvyqACu9RNi/yvS3eRu+zHx+tEbkuOX0cjozVaE4txH5eVvShgLxKp+MH3mEM
FgFE/Z6qdOLTjXcLXhjdehhVaIsb8EGH0kuFM8Rr7/yDzqQ8cIsftDcm3GDf624O
e+kEdNTp5Zd1vieeIRvFswr+B2gcCGf2atRtMSedBzWpyFaPFapdITOZvXV4oSWk
olk6x5BRTYEXmbXkZQ325FmnrkGR4mpIKUQ5kikNWgYpO25cWI2oIylW8tgM86U=
=hDmr
-----END PGP SIGNATURE-----

--lS0GcFHcMQ6DAFrCtXTuWlx2OViT7N0Wk--
