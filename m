Received: from eggs.gnu.org ([2001:4830:134:3::10]:58315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g743e-0000bR-Fn
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g743c-0003CE-3O
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:40:40 -0400
References: <20180821005843.5146-1-famz@redhat.com>
	<20180821005843.5146-2-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <390bde1b-dc91-0189-2dde-cf4765667143@redhat.com>
Date: Mon, 1 Oct 2018 21:40:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180821005843.5146-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Aghbc2xsbx34vWO4u7ShSZKZYLE83lJw3"
Subject: Re: [Qemu-devel] [PATCH v4 1/3] file-posix: Skip effectiveless OFD
 lock operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Aghbc2xsbx34vWO4u7ShSZKZYLE83lJw3
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <390bde1b-dc91-0189-2dde-cf4765667143@redhat.com>
Subject: Re: [PATCH v4 1/3] file-posix: Skip effectiveless OFD lock operations
References: <20180821005843.5146-1-famz@redhat.com>
 <20180821005843.5146-2-famz@redhat.com>
In-Reply-To: <20180821005843.5146-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.08.18 02:58, Fam Zheng wrote:
> If we know we've already locked the bytes, don't do it again; similarly=

> don't unlock a byte if we haven't locked it. This doesn't change the
> behavior, but fixes a corner case explained below.
>=20
> Libvirt had an error handling bug that an image can get its (ownership,=

> file mode, SELinux) permissions changed (RHBZ 1584982) by mistake behin=
d
> QEMU. Specifically, an image in use by Libvirt VM has:
>=20
>     $ ls -lhZ b.img
>     -rw-r--r--. qemu qemu system_u:object_r:svirt_image_t:s0:c600,c690 =
b.img
>=20
> Trying to attach it a second time won't work because of image locking.
> And after the error, it becomes:
>=20
>     $ ls -lhZ b.img
>     -rw-r--r--. root root system_u:object_r:virt_image_t:s0 b.img
>=20
> Then, we won't be able to do OFD lock operations with the existing fd.
> In other words, the code such as in blk_detach_dev:
>=20
>     blk_set_perm(blk, 0, BLK_PERM_ALL, &error_abort);
>=20
> can abort() QEMU, out of environmental changes.
>=20
> This patch is an easy fix to this and the change is regardlessly
> reasonable, so do it.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
>=20
> v3: Don't misuse s->perm and s->shared_perm.
> v2: For s =3D=3D NULL, unlock all bits. [Kevin]
> ---
>  block/file-posix.c | 54 +++++++++++++++++++++++++++++++++++++---------=

>  1 file changed, 44 insertions(+), 10 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Aghbc2xsbx34vWO4u7ShSZKZYLE83lJw3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluyeCgACgkQ9AfbAGHV
z0CkvwgAkHeslaxzxGUYMdyE6mAFQ7DBeS5UfiI1Zsm7kZDsLWVC6dQTYvFJNHJA
AqlEJATSRwOPVGFF4+pJ4B9O+v1k2JFAZSg4YVNk38gMWfPfC3x/ToAzZWG5jQMc
7a7EEaRsnoN514PF24MwIZAjAaE/W9ZfYGDW+g3On21kVWUTRqpz8OgYFpbVHxwi
PVhNCTzr/drfjIS9RauU6hhbr2e2XIJGIlmmjvBYeMR2gILjgdW9mGMXpWvJwEM9
+9tKB4xkCoVGONH18p1B3tobItn4ZLiSFLOwpyjyZB7vnMV1SpFqxvvKdmwV3fHi
IWX77TbFdvp8IaGmbSi654QE8uU4MA==
=wBxZ
-----END PGP SIGNATURE-----

--Aghbc2xsbx34vWO4u7ShSZKZYLE83lJw3--
