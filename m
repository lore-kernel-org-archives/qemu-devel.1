Received: from eggs.gnu.org ([2001:4830:134:3::10]:44125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTE7o-0004c3-Uu
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTE7n-00024i-Vf
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:43:33 -0500
References: <20170111181432.18868-1-mreitz@redhat.com>
	<20170111181432.18868-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ee5ed185-f4d7-be4e-868d-07091fa6fad8@redhat.com>
Date: Mon, 16 Jan 2017 14:43:24 -0600
MIME-Version: 1.0
In-Reply-To: <20170111181432.18868-5-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EkWjElH20rs4wdTXKFqg42PxPeWqP1CFs"
Subject: Re: [Qemu-devel] [PATCH v4 04/25] block: Respect backing bs in
 bdrv_refresh_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EkWjElH20rs4wdTXKFqg42PxPeWqP1CFs
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <ee5ed185-f4d7-be4e-868d-07091fa6fad8@redhat.com>
Subject: Re: [PATCH v4 04/25] block: Respect backing bs in
 bdrv_refresh_filename
References: <20170111181432.18868-1-mreitz@redhat.com>
 <20170111181432.18868-5-mreitz@redhat.com>
In-Reply-To: <20170111181432.18868-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 12:14 PM, Max Reitz wrote:

The mail archives show this series stopping at 4/25; what happened to 5-2=
5?
https://lists.gnu.org/archive/html/qemu-devel/2017-01/threads.html#01912

> Basically, bdrv_refresh_filename() should respect all children of a
> BlockDriverState. However, generally those children are driver-specific=
,
> so this function cannot handle the general case. On the other hand,
> there are only few drivers which use other children than @file and
> @backing (that being vmdk, quorum, and blkverify).
>=20
> Most block drivers only use @file and/or @backing (if they use any
> children at all). Both can be implemented directly in
> bdrv_refresh_filename.
>=20
> The user overriding the file's filename is already handled, however, th=
e
> user overriding the backing file is not. If this is done, opening the
> BDS with the plain filename of its file will not be correct, so we may
> not set bs->exact_filename in that case.
>=20
> iotest 051 contains test cases for overwriting the backing file, and so=

> its output changes with this patch applied (which I consider a good
> thing).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c                       | 12 +++++++++++-
>  tests/qemu-iotests/051.out    |  8 ++++----
>  tests/qemu-iotests/051.pc.out |  8 ++++----
>  3 files changed, 19 insertions(+), 9 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/tests/qemu-iotests/051.out
> @@ -59,7 +59,7 @@ QEMU X.Y.Z monitor - type 'help' for more information=

>  Testing: -drive file=3DTEST_DIR/t.qcow2,driver=3Dqcow2,backing.file.fi=
lename=3DTEST_DIR/t.qcow2.orig,if=3Dnone,id=3Ddrive0 -nodefaults
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) i=1B[K=1B[Din=1B[K=1B[D=1B[Dinf=1B[K=1B[D=1B[D=1B[Dinfo=1B[K=1B=
[D=1B[D=1B[D=1B[Dinfo =1B[K=1B[D=1B[D=1B[D=1B[D=1B[Dinfo b=1B[K=1B[D=1B[D=
=1B[D=1B[D=1B[D=1B[Dinfo bl=1B[K=1B[D=1B[D=1B[D=1B[D=1B[D=1B[D=1B[Dinfo b=
lo=1B[K=1B[D=1B[D=1B[D=1B[D=1B[D=1B[D=1B[D=1B[Dinfo bloc=1B[K=1B[D=1B[D=1B=
[D=1B[D=1B[D=1B[D=1B[D=1B[D=1B[Dinfo block=1B[K
> -drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
> +drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/t.qcow2.orig"}}, "driver": "qcow2", "=
file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)

These test files are a pain to read, but I concur that the resulting
output looks better now that it is obvious that the backing file has
been overridden.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--EkWjElH20rs4wdTXKFqg42PxPeWqP1CFs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfTBsAAoJEKeha0olJ0Nq8VoH/0xjqerH9vpzsW0WjCHowzx3
u6QzC9dtHRirOYrhKJEv2NZ2yogiGmcCSQbAcIm/chiKt45FqbVrTzGLhA+fuhfn
Q4h+BK440HOnZld1sVjAMKXEwFPvpypfOaqd9XlS0j3ixnaXdKBOd1UUKW1K5MT4
T0aUoVWK7Ke2xjpJv82hMXzUyYx3mXaijGHQKAgD38CB9L3kccdmuccIc+phyhL5
/XXC+oZVLg6rmtmLMtfFsqPTr6NrsyONWhnaP5w4A6wz2JpRr+28OfiLWIVVxMaD
/KpC9RgXeQ8ITZSmGpmVoxAGrapOvA1VYwxNO8GhACeMQs2skJ/4DEpyHbvrTH8=
=Otld
-----END PGP SIGNATURE-----

--EkWjElH20rs4wdTXKFqg42PxPeWqP1CFs--
