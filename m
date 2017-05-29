Received: from eggs.gnu.org ([2001:4830:134:3::10]:53977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFMov-0003kA-Ep
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFMou-0000Nq-Ao
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:43:01 -0400
References: <20170529152316.27647-1-mreitz@redhat.com>
	<20170529152316.27647-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <27c8dfc9-cef6-9d55-195a-20ef3a9a85e9@redhat.com>
Date: Mon, 29 May 2017 10:42:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170529152316.27647-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qfl9lkQN6VuMHcT43WSWIldVgQN6Wox7g"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] iotests: Use absolute paths for
 executables
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
--qfl9lkQN6VuMHcT43WSWIldVgQN6Wox7g
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <27c8dfc9-cef6-9d55-195a-20ef3a9a85e9@redhat.com>
Subject: Re: [PATCH v3 1/2] iotests: Use absolute paths for executables
References: <20170529152316.27647-1-mreitz@redhat.com>
 <20170529152316.27647-2-mreitz@redhat.com>
In-Reply-To: <20170529152316.27647-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/29/2017 10:23 AM, Max Reitz wrote:
> A user may specify a relative path for accessing qemu, qemu-img, etc.
> through environment variables ($QEMU_PROG and friends) or a symlink.
>=20
> If a test decides to change its working directory, relative paths will
> cease to work, however. Work around this by making all of the paths to
> programs that should undergo testing absolute. Besides "realpath", we
> also have to use "which" to support programs in $PATH.

'type -p' is more portable than 'which' - especially since our scripts
are bash scripts, and type is a bash builtin while which is not.

>=20
> As a side effect, this fixes specifying these programs as symlinks for
> out-of-tree builds: Before, you would have to create two symlinks, one
> in the build and one in the source tree (the first one for common.confi=
g
> to find, the second one for the iotest to use). Now it is sufficient to=

> create one in the build tree because common.config will resolve it.
>=20
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/common.config | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/comm=
on.config
> index d1b45f5..08aac56 100644
> --- a/tests/qemu-iotests/common.config
> +++ b/tests/qemu-iotests/common.config
> @@ -103,6 +103,12 @@ if [ -z "$QEMU_VXHS_PROG" ]; then
>      export QEMU_VXHS_PROG=3D"`set_prog_path qnio_server`"
>  fi
> =20
> +export QEMU_PROG=3D$(realpath "$(which "$QEMU_PROG")")
> +export QEMU_IMG_PROG=3D$(realpath "$(which "$QEMU_IMG_PROG")")
> +export QEMU_IO_PROG=3D$(realpath "$(which "$QEMU_IO_PROG")")
> +export QEMU_NBD_PROG=3D$(realpath "$(which "$QEMU_NBD_PROG")")
> +export QEMU_VXHS_PROG=3D$(realpath "$(which "$QEMU_VXHS_PROG")")

If you switch all of these to $(realpath -- "$(type -p "$QEMU_...")"),
you can add:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qfl9lkQN6VuMHcT43WSWIldVgQN6Wox7g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLEF7AAoJEKeha0olJ0NqAQoH/iG6kikU124+l+HHXizQBMTV
ejeN1hROdC8sNWOEMVN/0eBybLJTrIRVe0wU9Ma1n365zF0QLZDM3BkUEuf1ufuH
Y4nZvibk/FgOViWHYKdh6atWHDt5TDIHVFUoxc373u+mfSAlNxV7YZ5zp/i36n88
vBrV0gKh3s97bMLR0iHTx9+fvRaNbycJW3T3ipDqfvdz2K1g3VCE+ybCH4P3P196
c6N9af2q/fsIZFupCop2IUDpOcNlaTbJXW3yCW9pZ8UwLeQmzufQt90hOHCXJggk
0gKuggSbBK2GX+0421x6IO3UjsGmWO66akNp5d+2Lgu+9xiDz34ot+PJ6meD7Uk=
=egvI
-----END PGP SIGNATURE-----

--qfl9lkQN6VuMHcT43WSWIldVgQN6Wox7g--
