Received: from eggs.gnu.org ([2001:4830:134:3::10]:50999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUKk7-00053V-SR
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUKk4-0007JR-NL
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:59:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cUKk4-0007Iy-ER
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:59:36 -0500
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
	<1484859998-25074-5-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa9a259a-a649-d399-5895-837a5a23f56c@redhat.com>
Date: Thu, 19 Jan 2017 15:59:33 -0600
MIME-Version: 1.0
In-Reply-To: <1484859998-25074-5-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Df7InsV8lAAbGDF3gb1ERou4wCjIVxwgg"
Subject: Re: [Qemu-devel] [PATCH v3 4/4] ARRAY_SIZE: check that argument is
 an array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Sergey Fedorov <serge.fdrv@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Df7InsV8lAAbGDF3gb1ERou4wCjIVxwgg
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Sergey Fedorov <serge.fdrv@gmail.com>
Message-ID: <aa9a259a-a649-d399-5895-837a5a23f56c@redhat.com>
Subject: Re: [PATCH v3 4/4] ARRAY_SIZE: check that argument is an array
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
 <1484859998-25074-5-git-send-email-mst@redhat.com>
In-Reply-To: <1484859998-25074-5-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 03:07 PM, Michael S. Tsirkin wrote:
> It's a familiar pattern: some code uses ARRAY_SIZE, then refactoring
> changes the argument from an array to a pointer to a dynamically
> allocated buffer.  Code keeps compiling but any ARRAY_SIZE calls now
> return the size of the pointer divided by element size.
>=20
> Let's add build time checks to ARRAY_SIZE before we allow more
> of these in the code-base.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qemu/osdep.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 689f253..56c9e22 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -198,8 +198,15 @@ extern int daemon(int, int);
>  #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
>  #endif
> =20
> +/*
> + * &(x)[0] is always a pointer - if it's same type as x then the argum=
ent is a
> + * pointer, not an array.
> + */
> +#define QEMU_IS_ARRAY(x) (!__builtin_types_compatible_p(typeof(x), \
> +                                                        typeof(&(x)[0]=
)))
>  #ifndef ARRAY_SIZE
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +#define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
> +                       QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))

We've got some double-negation going on here ("cause a build bug if the
negation of QEMU_IS_ARRAY() is not 0") which takes some mental
gymnastics, but it is the correct result.  [I kind of like that gnulib
uses positive logic in its 'verify(x)' meaning "verify that x is true,
or cause a build error"; compared to the negative logic in the kernal
'BUILD_BUG_ON[_ZERO](x)' meaning "cause a build bug if x is non-zero" -
but that's personal preference and not something for qemu to change]

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Df7InsV8lAAbGDF3gb1ERou4wCjIVxwgg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgTbFAAoJEKeha0olJ0NqbAEIAKIZG5AnIKS6fsQKajyFmGWL
PZoKqwAQ/LRfMvYTK/qZrN8o3xBsUwAOpPK0NQPcCGRzF9dh9xsofCfjU8XvsAmY
Ncg8l5Lxr4FHAo0bzNbPK+wtAKlLYm3E4aforrbWe0yy07bLZOQ7VqpKyEuZR6Lw
oQzSYoLaQNVCS7DYm61Ob9nKzJ4ucoUAggzKF1ww8akLJ6EciajAld2y2xBB6Y24
XOiUxrMrbCr5KiuoNv5/tcSbJOxgCb+SwNqDUL2Y3FJNzYFiJu7rrKHDboyXxPNC
R5qL94jwcA3wEfh79Xt0fvPSh8RrknW4P8scO3EZ1KZ/TH9XkYkejqqZYkyxQ2k=
=668x
-----END PGP SIGNATURE-----

--Df7InsV8lAAbGDF3gb1ERou4wCjIVxwgg--
