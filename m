Received: from eggs.gnu.org ([2001:4830:134:3::10]:34048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQhbU-0006wb-J7
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQhbQ-0000bR-L5
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:35:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cQhbQ-0000aU-BF
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:35:40 -0500
References: <1483900123-7103-1-git-send-email-rami.rosen@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4ae785a3-1cac-99a9-a96d-a866ab9318db@redhat.com>
Date: Mon, 9 Jan 2017 15:35:36 -0600
MIME-Version: 1.0
In-Reply-To: <1483900123-7103-1-git-send-email-rami.rosen@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vXQ26SfgWhHaCDET7Lv8drgp0Sh6wlplE"
Subject: Re: [Qemu-devel] [PATCH] ui: fix format specifier in
 vnc_client_io_error() to avoid break in build.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rami Rosen <rami.rosen@intel.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vXQ26SfgWhHaCDET7Lv8drgp0Sh6wlplE
From: Eric Blake <eblake@redhat.com>
To: Rami Rosen <rami.rosen@intel.com>, qemu-devel@nongnu.org
Message-ID: <4ae785a3-1cac-99a9-a96d-a866ab9318db@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui: fix format specifier in
 vnc_client_io_error() to avoid break in build.
References: <1483900123-7103-1-git-send-email-rami.rosen@intel.com>
In-Reply-To: <1483900123-7103-1-git-send-email-rami.rosen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2017 12:28 PM, Rami Rosen wrote:
> When building qemu after setting _VNC_DEBUG to 1 (see ui/vnc.h),
> we get the following error and the build breaks:
> ...
> ui/vnc.c: In function =E2=80=98vnc_client_io_error=E2=80=99:
> ui/vnc.c:1262:13: error: format =E2=80=98%d=E2=80=99 expects argument o=
f type =E2=80=98int=E2=80=99, but argument 3 has type =E2=80=98ssize_t=E2=
=80=99 [-Werror=3Dformat=3D]
>              VNC_DEBUG("Closing down client sock: ret %d (%s)\n",
>              ^
> cc1: all warnings being treated as errors
> make: *** [ui/vnc.o] Error 1
> ...
>=20
> This patch solves this issue by fixing the print format specifier
> in vnc_client_io_error() to be %ld, which corresponds to the type
> of the "ret" variable.

NACK.  "ret" is ssize_t, which might be 'long' on some platforms, but is
'int' on others (32-bit platforms come to mind).

>=20
> Signed-off-by: Rami Rosen <rami.rosen@intel.com>
> ---
>  ui/vnc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 2c28a59..4b0a89c 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1259,7 +1259,7 @@ ssize_t vnc_client_io_error(VncState *vs, ssize_t=
 ret, Error **errp)
>          if (ret =3D=3D 0) {
>              VNC_DEBUG("Closing down client sock: EOF\n");
>          } else if (ret !=3D QIO_CHANNEL_ERR_BLOCK) {
> -            VNC_DEBUG("Closing down client sock: ret %d (%s)\n",
> +            VNC_DEBUG("Closing down client sock: ret %ld (%s)\n",

%zd is better than %ld.  Note that %zd is technically undefined -
neither C nor POSIX requires that the signed counterpart to 'size_t' be
ssize_t, nor that 'ssize_t' be the same size as 'size_t'; but it is safe
enough in qemu as we already have plenty of existing uses of this idiom
(and any platform that implements 'ssize_t' in a way that doesn't match
'%zd' is stupid when it comes to quality-of-implementation).

Looking forward to v2.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vXQ26SfgWhHaCDET7Lv8drgp0Sh6wlplE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdAIoAAoJEKeha0olJ0NqVDQH/ilskVUvPb+geUcUnYe78K/8
2TJI0zHFTlTRZOTSY04jKh9fwV8+XVci93bT5whXY5FYAtFYwIGsO3XI/kbzSBu+
w7fsfaTBFacqSYD6HlzTDCneVEFVwscT7I4OD5dthbwAB/n0BrgfYM9YFyIIQgrF
UQjLQor25vJHHhqVEIGKtKClEr0LND8ltEzw3k8irbJxNDkkIOVuPxFL4ct9lkcH
QpL+DDu5vEnzSsn8M5HP+CE2lpV5kGN8HPJ8xanGT6gQ2hI9cQES/xvk8nye4jR6
/nj19LZX+5zGuhDdNCVKYMHRjMLTt9hfzxvfRrG+y9m7HRA5UYYhon7eJNQjrfE=
=N4rO
-----END PGP SIGNATURE-----

--vXQ26SfgWhHaCDET7Lv8drgp0Sh6wlplE--
