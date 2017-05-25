Received: from eggs.gnu.org ([2001:4830:134:3::10]:45638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDtkk-0003aR-Pr
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDtki-0006tW-Fb
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:28:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDtki-0006tN-5S
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:28:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FEFE7F4A9
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 14:28:35 +0000 (UTC)
References: <20170525101900.15950-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d090dbd-eb49-5e4e-6b7e-b52a3fdc1716@redhat.com>
Date: Thu, 25 May 2017 09:28:31 -0500
MIME-Version: 1.0
In-Reply-To: <20170525101900.15950-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WwV7Rbho7UTUnagwPfOd4beLjLgR2chNt"
Subject: Re: [Qemu-devel] [PATCH v3] sockets: improve error reporting if
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WwV7Rbho7UTUnagwPfOd4beLjLgR2chNt
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <3d090dbd-eb49-5e4e-6b7e-b52a3fdc1716@redhat.com>
Subject: Re: [PATCH v3] sockets: improve error reporting if UNIX socket path
 is too long
References: <20170525101900.15950-1-berrange@redhat.com>
In-Reply-To: <20170525101900.15950-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 05:19 AM, Daniel P. Berrange wrote:
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
> In solving this the code needed some refactoring to ensure we
> don't pass 'un.sun_path' directly to any APIs which expect
> NUL-terminated strings, because the path is not required to
> be terminated.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20

>      } else {
>          const char *tmpdir =3D getenv("TMPDIR");
>          tmpdir =3D tmpdir ? tmpdir : "/tmp";
> -        if (snprintf(un.sun_path, sizeof(un.sun_path), "%s/qemu-socket=
-XXXXXX",
> -                     tmpdir) >=3D sizeof(un.sun_path)) {
> -            error_setg_errno(errp, errno,
> -                             "TMPDIR environment variable (%s) too lar=
ge", tmpdir);
> -            goto err;

The old code fails early if the generated name is too long,...

> -        }
> +        path =3D pathbuf =3D g_strdup_printf("%s/qemu-socket-XXXXXX", =
tmpdir);
> =20
>          /*
>           * This dummy fd usage silences the mktemp() unsecure warning.=

> @@ -873,24 +868,32 @@ static int unix_listen_saddr(UnixSocketAddress *s=
addr,
>           * to unlink first and thus re-open the race window.  The
>           * worst case possible is bind() failing, i.e. a DoS attack.
>           */
> -        fd =3D mkstemp(un.sun_path);
> +        fd =3D mkstemp(pathbuf);

=2E..while the new code ends up creating a too-long name in the
file-system anyways,...

>          if (fd < 0) {
>              error_setg_errno(errp, errno,
>                               "Failed to make a temporary socket name i=
n %s", tmpdir);
>              goto err;
>          }
>          close(fd);
> -        if (update_addr) {
> -            g_free(saddr->path);
> -            saddr->path =3D g_strdup(un.sun_path);
> -        }
>      }
> =20
> -    if (unlink(un.sun_path) < 0 && errno !=3D ENOENT) {
> +    if (strlen(path) > sizeof(un.sun_path)) {
> +        error_setg(errp, "UNIX socket path '%s' is too long", path);
> +        error_append_hint(errp, "Path must be less than %zu bytes\n",
> +                          sizeof(un.sun_path));

The old message mentioned the name that was too long, the new does not.
That's a potential slight loss in error message quality, particularly
since you are no longer mentioning a UNIX socket (which may give the
user a clue why 108 is special), but I can probably live with it (it's
still pretty obvious from the message that you should investigate what
is too long).

> +        goto err;

=2E..here, you finally diagnose that the name is too long,...

> +    }
> +
> +    if (unlink(path) < 0 && errno !=3D ENOENT) {

=2E..but skip the unlink of the just-created too-long name.  Oops.

>          error_setg_errno(errp, errno,
> -                         "Failed to unlink socket %s", un.sun_path);
> +                         "Failed to unlink socket %s", path);
>          goto err;
>      }

I think you're okay if you just swap the unlink() with the length check.
 Although it seems rather sys-call heavy to mkstemp/unlink compared to
just doing a length check first, I do like how your refactoring ended up
with fewer conditionals rather than splitting the generated name code
across multiple conditionals.

> @@ -932,9 +942,16 @@ static int unix_connect_saddr(UnixSocketAddress *s=
addr,
>          qemu_set_nonblock(sock);
>      }
> =20
> +    if (strlen(saddr->path) > sizeof(un.sun_path)) {
> +        error_setg(errp, "UNIX socket path '%s' is too long", saddr->p=
ath);
> +        error_append_hint(errp, "Path must be less than %zu bytes\n",
> +                          sizeof(un.sun_path));

Again, potential loss in error message quality.

Hopefully fourth time is the charm!

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WwV7Rbho7UTUnagwPfOd4beLjLgR2chNt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJuoPAAoJEKeha0olJ0NqWxIIAIpnUm1Zu7Q85AECOSJMaABo
LUnza3HkLu2dStmpgNEXaZA+KKKrq6j+U4B+OYUBqooapn2dv+352BTzVFiWJIDX
btXtQZqWSvlSD0kusS5K2aHygVdrm40kECad7Id0EcKrsAyTesZCWbmEex8sqSs/
dV5EaZXhTGLlJfqM7Yf6hu6zMMzUE5Ir2cUC1XkFpOugnSi7Rs9/ZVaNWa+LYZj5
SAT2IknCXN3SLkHkx15QsQF62UrS50/2nGGnSoaQ4jIoLsNmCrrUUk8YJPQpy/cF
lJj14viL4ixjAKl+tDiBvXytp6xq4xeWIbR7gKRZQT1t3tx3zPrhfPXzqJCW1nk=
=gaMt
-----END PGP SIGNATURE-----

--WwV7Rbho7UTUnagwPfOd4beLjLgR2chNt--
