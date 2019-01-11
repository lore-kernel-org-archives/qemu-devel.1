Received: from eggs.gnu.org ([209.51.188.92]:37359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi0Zv-00057k-1b
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi0Zt-0006pN-2H
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:26:42 -0500
References: <20190111163519.11457-1-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <55fa3efa-232f-afe3-3858-11a4b491317d@redhat.com>
Date: Fri, 11 Jan 2019 11:26:31 -0600
MIME-Version: 1.0
In-Reply-To: <20190111163519.11457-1-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lwxqAxsVXAR9d7GMkMKufa5sjroF5PK3J"
Subject: Re: [Qemu-devel] [PATCH] qemu-nbd: Rename 'exp' variable clashing
 with math::exp() symbol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lwxqAxsVXAR9d7GMkMKufa5sjroF5PK3J
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <55fa3efa-232f-afe3-3858-11a4b491317d@redhat.com>
Subject: Re: [PATCH] qemu-nbd: Rename 'exp' variable clashing with math::exp()
 symbol
References: <20190111163519.11457-1-philmd@redhat.com>
In-Reply-To: <20190111163519.11457-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 10:35 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> The use of a variable named 'exp' prevents includes to import <math.h>.=

>=20
> Rename it to avoid:
>=20
>   qemu-nbd.c:64:19: error: =E2=80=98exp=E2=80=99 redeclared as differen=
t kind of symbol
>    static NBDExport *exp;
>                      ^~~
>   In file included from /usr/include/features.h:428,
>                    from /usr/include/bits/libc-header-start.h:33,
>                    from /usr/include/stdint.h:26,
>                    from /usr/lib/gcc/x86_64-redhat-linux/8/include/stdi=
nt.h:9,
>                    from /source/qemu/include/qemu/osdep.h:80,
>                    from /source/qemu/qemu-nbd.c:19:
>   /usr/include/bits/mathcalls.h:95:1: note: previous declaration of =E2=
=80=98exp=E2=80=99 was here
>     __MATHCALL_VEC (exp,, (_Mdouble_ __x));
>     ^~~~~~~~~~~~~~
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qemu-nbd.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Why did you need to import math.h?

But it's reasonable enough. Will queue through my NBD tree; in part
because it has conflicts with other pending NBD patches (so
trivial-patches taking it would actually cost me more efforts than me
just fixing the conflicts).

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/qemu-nbd.c
> @@ -61,7 +61,7 @@
> =20
>  #define MBR_SIZE 512
> =20
> -static NBDExport *exp;
> +static NBDExport *export;

This one is a definite problem (POSIX says you shouldn't name any static
variable the same as a standard function entry point, even if it happens
to lnik)...

>  static int verbose;
>  static char *srcpath;
>  static SocketAddress *saddr;
> @@ -335,7 +335,7 @@ static int nbd_can_accept(void)
>      return state =3D=3D RUNNING && nb_fds < shared;
>  }
> =20
> -static void nbd_export_closed(NBDExport *exp)
> +static void nbd_export_closed(NBDExport *export)

=2E..this one just silences a -Wshadow but is permitted by strict C. We
have too many other -Wshadow violations in our code base, but I don't
mind getting rid of this one.

> @@ -1015,10 +1015,11 @@ int main(int argc, char **argv)
>          }
>      }
> =20
> -    exp =3D nbd_export_new(bs, dev_offset, fd_size, nbdflags, nbd_expo=
rt_closed,
> -                         writethrough, NULL, &error_fatal);
> -    nbd_export_set_name(exp, export_name);
> -    nbd_export_set_description(exp, export_description);
> +    export =3D nbd_export_new(bs, dev_offset, fd_size, nbdflags,
> +                            nbd_export_closed, writethrough,
> +                            NULL, &error_fatal);
> +    nbd_export_set_name(export, export_name);
> +    nbd_export_set_description(export, export_description);

Here's where my pending to add 'qemu-nbd --bitmap' conflict; I don't
mind fixing it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--lwxqAxsVXAR9d7GMkMKufa5sjroF5PK3J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw40ccACgkQp6FrSiUn
Q2qrogf/WzSWhmD9qeqttCq+rvQTSLN+NsuGReJkAaxm85oyhN95VfYvNFSKtrub
7DZ+N24YPqgOB4PjvU3OPxE3awMp6gvMAP3nVX+Bmhl3q6brBvPpKgZrxsazp8z8
2iBs7Fqlm24CnGM9KTMpzxcOCn5bZfERslCcn3Pv7SbPINOmHAQk0QPeKOxUJqsK
k47QVQ2HMYyqskTSwEZjPWXnM4OcVBqR/vOgZCxIRW7rv8AtaqhKe7oAoZZsOPoA
NJl259PG/5jrs6Pl7Fet6+pijz1Mzxi3VaBRn5qxxXtx7m5HuFoe9hHh9SjvO9VJ
SKDbJFNXL9WF2YQjIDIRf6QHncGqlw==
=ZFr5
-----END PGP SIGNATURE-----

--lwxqAxsVXAR9d7GMkMKufa5sjroF5PK3J--
