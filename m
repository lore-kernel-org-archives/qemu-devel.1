Received: from eggs.gnu.org ([2001:4830:134:3::10]:59567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDGHM-00048x-Q2
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:51:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDGHL-00060d-MI
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:51:56 -0500
References: <20171110203759.14018-1-mreitz@redhat.com>
	<20171110203759.14018-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <26945f48-b5dc-49f6-4184-b10379cf510c@redhat.com>
Date: Fri, 10 Nov 2017 14:51:43 -0600
MIME-Version: 1.0
In-Reply-To: <20171110203759.14018-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hpab8TbVMaFrsjXJ8P6mc5oPMrPpUvN8M"
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/1] qcow2: Repair unaligned
 preallocated zero clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hpab8TbVMaFrsjXJ8P6mc5oPMrPpUvN8M
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Message-ID: <26945f48-b5dc-49f6-4184-b10379cf510c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/1] qcow2: Repair unaligned
 preallocated zero clusters
References: <20171110203759.14018-1-mreitz@redhat.com>
 <20171110203759.14018-2-mreitz@redhat.com>
In-Reply-To: <20171110203759.14018-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 02:37 PM, Max Reitz wrote:
> We can easily repair unaligned preallocated zero clusters by discarding=

> them, so why not do it?
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-refcount.c     | 70 ++++++++++++++++++++++++++++++++++++++=
--------
>  tests/qemu-iotests/060     |  3 +-
>  tests/qemu-iotests/060.out |  9 ++++++
>  3 files changed, 69 insertions(+), 13 deletions(-)
>=20

> =20
> +            /* Correct offsets are cluster aligned */
> +            if (offset_into_cluster(s, offset)) {
> +                if (qcow2_get_cluster_type(l2_entry) =3D=3D
> +                    QCOW2_CLUSTER_ZERO_ALLOC)
> +                {
> +                    fprintf(stderr, "%s offset=3D%" PRIx64 ": Prealloc=
ated zero "
> +                            "cluster is not properly aligned; L2 entry=
 "
> +                            "corrupted.\n",
> +                            fix & BDRV_FIX_ERRORS ? "Repairing" : "ERR=
OR",
> +                            offset);

Is fprintf() still the right thing to be using?

> @@ -1586,13 +1637,6 @@ static int check_refcounts_l2(BlockDriverState *=
bs, BdrvCheckResult *res,
>              if (ret < 0) {
>                  goto fail;
>              }
> -
> -            /* Correct offsets are cluster aligned */
> -            if (offset_into_cluster(s, offset)) {
> -                fprintf(stderr, "ERROR offset=3D%" PRIx64 ": Cluster i=
s not "
> -                    "properly aligned; L2 entry corrupted.\n", offset)=
;

But it's no worse than what you are refactoring.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Hpab8TbVMaFrsjXJ8P6mc5oPMrPpUvN8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloGEV8ACgkQp6FrSiUn
Q2p5NAf/cmbDXMSsRE55qRhkXe+2Y2qp9suQISTvU8ZhMODQvxdHAcxvRr5ZuTjl
ELdnXWmB5ZpEjVQQDytUbq6xX1oIeCAn44asz8YsjK8sgpXE3Amuc6TsbNpfb5q/
g+QLR2wTTXmOQDGRiVOSnxswJZdFUwW/GppJDPwvJN2pwdIEJGPgz6sqoJeNCxJD
nYHdjbBo6NVHHS9UuK5eYy/aZeLS9qWEhvHxEgFEYv+XK6b0s2qx1kdiicHR7n0F
0rFoOFMG/hmpcMGaGTgvjXLXmyoodfNvKRS/jmWrnn3+u+AkgLv5YpRlGTs5l7ll
u2oM49BmvZI4u8AI4dCgiU94ucjhtw==
=HZ3y
-----END PGP SIGNATURE-----

--Hpab8TbVMaFrsjXJ8P6mc5oPMrPpUvN8M--
