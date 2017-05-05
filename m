Received: from eggs.gnu.org ([2001:4830:134:3::10]:37629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6gZe-0005tK-U0
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6gZa-0006ZH-Mq
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:59:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6gZa-0006Yr-DA
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:59:18 -0400
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
	<149399503288.29022.13904385823492355197.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <093d42d3-a4a5-94bd-3a7a-b2a2f867ae89@redhat.com>
Date: Fri, 5 May 2017 11:59:15 -0500
MIME-Version: 1.0
In-Reply-To: <149399503288.29022.13904385823492355197.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rWJccGdxBTQjtV13U21SkEEWR46EDSaXn"
Subject: Re: [Qemu-devel] [PATCH 2/5] 9pfs: local: resolve special
 directories in paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?L=c3=a9o_Gaspard?= <leo@gaspard.io>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rWJccGdxBTQjtV13U21SkEEWR46EDSaXn
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?L=c3=a9o_Gaspard?= <leo@gaspard.io>
Message-ID: <093d42d3-a4a5-94bd-3a7a-b2a2f867ae89@redhat.com>
Subject: Re: [PATCH 2/5] 9pfs: local: resolve special directories in paths
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
 <149399503288.29022.13904385823492355197.stgit@bahia.lan>
In-Reply-To: <149399503288.29022.13904385823492355197.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2017 09:37 AM, Greg Kurz wrote:
> When using the mapped-file security mode, the creds of a path /foo/bar
> are stored in the /foo/.virtfs_metadata/bar file. This is okay for all
> paths unless they end with '.' or '..', because we cannot create the
> corresponding file in the metadata directory.
>=20
> This patch ensures that '.' and '..' are resolved in all paths.
>=20
> The core code only passes path elements (no '/') to the backend, with
> the notable exception of the '/' path, which refers to the virtfs root.=

> This patch preserve the current behavior of converting it to '.' so

s/preserve/preserves/

> that it can be passed to "*at()" syscalls ('/' would mean the host root=
).
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index f3ebca4f7a56..92262f3c3e37 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1097,14 +1097,30 @@ static int local_name_to_path(FsContext *ctx, V=
9fsPath *dir_path,
>                                const char *name, V9fsPath *target)
>  {
>      if (dir_path) {
> -        v9fs_path_sprintf(target, "%s/%s", dir_path->data, name);
> -    } else if (strcmp(name, "/")) {
> -        v9fs_path_sprintf(target, "%s", name);
> +        if (!strcmp(name, ".")) {
> +            /* "." relative to "foo/bar" is "foo/bar" */
> +            v9fs_path_copy(target, dir_path);
> +        } else if (!strcmp(name, "..")) {
> +            if (!strcmp(dir_path->data, ".")) {
> +                /* ".." relative to the root is "." */
> +                v9fs_path_sprintf(target, ".");
> +            } else {
> +                char *tmp =3D g_path_get_dirname(dir_path->data);
> +                /* ".." relative to "foo/bar" is equivalent to "foo" *=
/

True only if bar is not a symlink to some other directory.  What
guarantees do you have that you are not going to be inadvertently
skipping a traversal through symlinks and thereby picking the wrong
location for '..'?

> +                v9fs_path_sprintf(target, "%s", tmp);
> +                g_free(tmp);
> +            }
> +        } else {
> +            assert(!strchr(name, '/'));
> +            v9fs_path_sprintf(target, "%s/%s", dir_path->data, name);
> +        }
> +    } else if (!strcmp(name, "/") || !strcmp(name, ".") ||
> +               !strcmp(name, "..")) {
> +            /* This is the root fid */
> +        v9fs_path_sprintf(target, ".");
>      } else {
> -        /* We want the path of the export root to be relative, otherwi=
se
> -         * "*at()" syscalls would treat it as "/" in the host.
> -         */
> -        v9fs_path_sprintf(target, "%s", ".");
> +        assert(!strchr(name, '/'));
> +        v9fs_path_sprintf(target, "./%s", name);
>      }
>      return 0;
>  }
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rWJccGdxBTQjtV13U21SkEEWR46EDSaXn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDK9jAAoJEKeha0olJ0Nq37QH/RZyEF+uQzrHNNjd6ZEuB95o
ov8jkEAIXGkwCiN1OkHLfEQHhJQ2xP5yIH4ObEG55F16kjJ11hEhkMk+dhP/dml/
3T1o777h+Q58d3viRWR+bWMpB+Fj1jXM6EqSsxC+wPEqDkQF/DSMXvhNoFXljxyd
NZft0MUdnA8AqpdbuHi+2Ht/SbZe+3JJ9fUh/ds9hbFt3SEfVQQH8LM1iaNUyt0X
KZjmgtatHWMmtPiIcPsnLc2rBpzj1JYXVpVrwMnwVNPO1R1ZCzIoMW/8HxL5c6qo
s/MkdXXDAQU38H0xQb0DXuTsaFtI9Vk3i9SPJ0HtkkUS651Wgi+XbB3BEaBROOE=
=1f1S
-----END PGP SIGNATURE-----

--rWJccGdxBTQjtV13U21SkEEWR46EDSaXn--
