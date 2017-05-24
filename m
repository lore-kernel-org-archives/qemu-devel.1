Received: from eggs.gnu.org ([2001:4830:134:3::10]:36620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDZUQ-0006BP-3J
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:50:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDZUM-0003NW-0r
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:50:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDZUL-0003Ld-OD
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:50:21 -0400
References: <20170524161812.5886-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e20cd1a3-e5e2-6d44-1490-8c090b42251e@redhat.com>
Date: Wed, 24 May 2017 11:50:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170524161812.5886-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i5JIvvit9jcCbUDDQ0wkBC3PvhCMIvR84"
Subject: Re: [Qemu-devel] [PATCH v2] sockets: improve error reporting if
 UNIX socket path is too long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Simon <qemu.bugs@whitewinterwolf.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i5JIvvit9jcCbUDDQ0wkBC3PvhCMIvR84
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Simon <qemu.bugs@whitewinterwolf.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <e20cd1a3-e5e2-6d44-1490-8c090b42251e@redhat.com>
Subject: Re: [PATCH v2] sockets: improve error reporting if UNIX socket path
 is too long
References: <20170524161812.5886-1-berrange@redhat.com>
In-Reply-To: <20170524161812.5886-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/24/2017 11:18 AM, Daniel P. Berrange wrote:
> The 'struct sockaddr_un' only allows 108 bytes for the socket
> path.
>=20
> If the user supplies a path, QEMU uses snprintf() to silently
> truncate it when too long. This is undesirable because the user
> will then be unable to connect to the path they asked for.
>=20
> If the user doesn't supply a path, QEMU builds one based on
> TMPDIR, but if that leads to an overlong path, it mistakenly
> uses error_setg_errno() with a stale errno value, because
> snprintf() does not set errno on truncation.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)


> +    pathlen =3D saddr->path ? strlen(saddr->path) : 0;
> +    if (pathlen !=3D 0) {
> +        if (pathlen > sizeof(un.sun_path)) {
> +            error_setg(errp, "UNIX socket path '%s' is too long", sadd=
r->path);
> +            error_append_hint(errp, "Path must be less than %zu bytes\=
n",
> +                              sizeof(un.sun_path));
> +            goto err;
> +        }
> +        strncpy(un.sun_path, saddr->path, sizeof(un.sun_path));

Does NOT nul-terminate if pathlen is exactly 108 - but it looks like
Linux is just fine with a Unix socket name that long.

>      } else {
> +        const char *template =3D "qemu-socket-XXXXXX";
>          const char *tmpdir =3D getenv("TMPDIR");
>          tmpdir =3D tmpdir ? tmpdir : "/tmp";
> -        if (snprintf(un.sun_path, sizeof(un.sun_path), "%s/qemu-socket=
-XXXXXX",
> -                     tmpdir) >=3D sizeof(un.sun_path)) {
> -            error_setg_errno(errp, errno,
> -                             "TMPDIR environment variable (%s) too lar=
ge", tmpdir);
> +        if (snprintf(un.sun_path, sizeof(un.sun_path), "%s/%s",
> +                     tmpdir, template) >=3D sizeof(un.sun_path)) {
> +            error_setg(errp,
> +                       "TMPDIR environment variable (%s) too large", t=
mpdir);
> +            error_append_hint(errp, "Path must be less than %zu bytes\=
n",
> +                              sizeof(un.sun_path) - strlen(template) -=
 1);

Meanwhile, this branch requires nul-termination (that is, a maximum
generated name of 107), but that's because we then pass un.sun_path to
mkstemp() and g_strdup(), both of which require nul-termination.  It's a
bit odd to see the asymmetry between a user-specified name going all the
way to 108 while generated cannot, but not the end of the world.

You do, however, have one more problem to fix:

    if (unlink(un.sun_path) < 0 && errno !=3D ENOENT) {

That now needs to be 'if (unlink(saddr->path) ...', because un.sun_path
is no longer guaranteed to be NUL-terminated (although saddr->path is).
Likewise for the two error_setg_errno() calls after that point.

With that fixed,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--i5JIvvit9jcCbUDDQ0wkBC3PvhCMIvR84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJbm6AAoJEKeha0olJ0NqLkIIAKngsLlvB7+h48QotpY2ayuR
KscIH+SRO+h6HYZrM1wI2s4sxn4W1yo9QjRAkNhjaR7iIqxL61SAI4zSY9C/gztg
4v6q1kx7l+Cj3NQbwIpbuEMyY8NtC9lWtsiUm9AcqJLa1IvYqpYtr2xjoQ+pbZIm
0R9hE+H2K4urt2Py3WyejQo8FyM1bkYvF1QgXiWuLJ5szJP9ZGegX/0EqjcBkBz0
VJcYEv7Jh7FYnHEUPuxzHxV5OLsgKpo+V8ER2BUFQeRq3dACH/YKH2wOQU4Cr50O
7+CZJ6hKUIako1uMcWmobsf2rxcoMitF4OCKmOrn66eNdyW04OMr8q8Xl8OzVhg=
=Fb+g
-----END PGP SIGNATURE-----

--i5JIvvit9jcCbUDDQ0wkBC3PvhCMIvR84--
