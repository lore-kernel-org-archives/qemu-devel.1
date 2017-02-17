Received: from eggs.gnu.org ([2001:4830:134:3::10]:42455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepy3-0008Ix-0M
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:21:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepy1-0003i9-DI
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:21:27 -0500
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-22-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <49e87de6-431a-43b9-14d1-78abe9da7aaf@redhat.com>
Date: Fri, 17 Feb 2017 15:21:16 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-22-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DB2bmq22J9wIXtvlKCc5n1ETtsQboVhcN"
Subject: Re: [Qemu-devel] [PATCH 21/24] util/cutils: Let qemu_strtosz*()
 optionally reject trailing crap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DB2bmq22J9wIXtvlKCc5n1ETtsQboVhcN
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <49e87de6-431a-43b9-14d1-78abe9da7aaf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 21/24] util/cutils: Let qemu_strtosz*()
 optionally reject trailing crap
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-22-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-22-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:26 AM, Markus Armbruster wrote:
> Change the qemu_strtosz() & friends to return -EINVAL when @endptr is
> null and the conversion doesn't consume the string completely.
> Matches how qemu_strtol() & friends work.
>=20
> Only test_qemu_strtosz_simple() passes a null @endptr.  No functional
> change there, because its conversion consumes the string.
>=20
> Simplify callers that use @endptr only to fail when it doesn't point
> to '\0' to pass a null @endptr instead.
>=20
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
> Cc: Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
> Cc: Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
> Cc: qemu-block@nongnu.org (open list:Block layer core)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp.c               |  6 ++----
>  hw/misc/ivshmem.c   |  6 ++----
>  qapi/opts-visitor.c |  5 ++---
>  qemu-img.c          |  7 +------
>  qemu-io-cmds.c      |  7 +------
>  target/i386/cpu.c   |  5 ++---
>  tests/test-cutils.c |  6 ++++++
>  util/cutils.c       | 14 +++++++++-----
>  8 files changed, 25 insertions(+), 31 deletions(-)

Nice cleanup.

Reviewed-by: Eric Blake <eblake@redhat.com>


> +++ b/qemu-img.c
> @@ -370,14 +370,9 @@ static int add_old_style_options(const char *fmt, =
QemuOpts *opts,
> =20
>  static int64_t cvtnum(const char *s)
>  {

> +++ b/qemu-io-cmds.c
> @@ -137,14 +137,9 @@ static char **breakline(char *input, int *count)
> =20
>  static int64_t cvtnum(const char *s)
>  {
> -    char *end;

Why do we reimplement cvtnum() as copied static functions instead of
exporting it?  But that would be a separate cleanup (perhaps squashed
into 20/24, where you use cvtnum in qemu-img).

> @@ -217,7 +217,8 @@ static int64_t do_strtosz(const char *nptr, char **=
end,
>      errno =3D 0;
>      val =3D strtod(nptr, &endptr);
>      if (isnan(val) || endptr =3D=3D nptr || errno !=3D 0) {

Hmm - we explicitly reject "NaN", but not "infinity".  But when strtod()
accepts infinity, ...

> -        goto fail;
> +        retval =3D -EINVAL;
> +        goto out;
>      }
>      fraction =3D modf(val, &integral);

then modf() returns 0 with integral left at infinity...

>      if (fraction !=3D 0) {
> @@ -232,17 +233,20 @@ static int64_t do_strtosz(const char *nptr, char =
**end,
>          assert(mul >=3D 0);
>      }
>      if (mul =3D=3D 1 && mul_required) {
> -        goto fail;
> +        retval =3D -EINVAL;
> +        goto out;
>      }
>      if ((val * mul >=3D INT64_MAX) || val < 0) {

=2E..and the multiply exceeds INT64_MAX, so we still end up rejecting it
(with ERANGE instead of EINVAL).  Weird way but seems to work, and is
pre-existing, so not this patch's problem.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DB2bmq22J9wIXtvlKCc5n1ETtsQboVhcN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp2lMAAoJEKeha0olJ0NqV5gH/RJDIhRYdalLllVJwpvE28Ag
2Wk0lF5FdFfAtD6Zi8w7ShKm0PJwgOi9PeUE3y62+gpD/2PgZwQpkk5+ylfn2NyY
BodE05JjSZM9NqdpzogsmWcaRyN2dClK+6GFiHKnOKQ0Gqbhoe4fAbTLwUCzXqJP
lGQ4kBjjaSFxOkskeeCicmOjWpqMjVd+ggQoTmiosea37ld3lk5cLWB0V9ev7nOd
3MxHsfcdP+Fj3j3zK/RtAbivxWIbiq1Pp+H40Oq5Z/0lW9vWaR7MB4l/dIh/JOcI
f8F0SHdBsfUApJOKgw0xFmt/+Hw42VufVxQm+32bSVFcbH9r9ZDC9mLNnhIhHWo=
=SKYT
-----END PGP SIGNATURE-----

--DB2bmq22J9wIXtvlKCc5n1ETtsQboVhcN--
