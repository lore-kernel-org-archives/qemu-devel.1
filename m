Received: from eggs.gnu.org ([2001:4830:134:3::10]:59897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gFh5S-0003jm-Li
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gFguw-0007wc-LZ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:24 -0400
Received: from ozlabs.org ([203.11.71.1]:44189)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gFguv-0007hc-HP
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:22 -0400
Date: Thu, 25 Oct 2018 15:37:00 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181025143657.GA2697@umbus.hotspot.internet-for-guests.com>
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20181023152306.3123-2-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/7] qapi: use qemu_strtoi64() in
 parse_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Tue, Oct 23, 2018 at 05:23:00PM +0200, David Hildenbrand wrote:
> The qemu api claims to be easier to use, and the resulting code seems to
> agree.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  qapi/string-input-visitor.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>=20
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index b3fdd0827d..c1454f999f 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -20,6 +20,7 @@
>  #include "qemu/option.h"
>  #include "qemu/queue.h"
>  #include "qemu/range.h"
> +#include "qemu/cutils.h"
> =20
> =20
>  struct StringInputVisitor
> @@ -46,10 +47,10 @@ static void free_range(void *range, void *dummy)
> =20
>  static int parse_str(StringInputVisitor *siv, const char *name, Error **=
errp)
>  {
> -    char *str =3D (char *) siv->string;
> -    long long start, end;
> +    const char *str =3D (char *) siv->string;
> +    const char *endptr;
> +    int64_t start, end;
>      Range *cur;
> -    char *endptr;
> =20
>      if (siv->ranges) {
>          return 0;
> @@ -60,9 +61,7 @@ static int parse_str(StringInputVisitor *siv, const cha=
r *name, Error **errp)
>      }
> =20
>      do {
> -        errno =3D 0;
> -        start =3D strtoll(str, &endptr, 0);
> -        if (errno =3D=3D 0 && endptr > str) {
> +        if (!qemu_strtoi64(str, &endptr, 0, &start)) {
>              if (*endptr =3D=3D '\0') {
>                  cur =3D g_malloc0(sizeof(*cur));
>                  range_set_bounds(cur, start, start);
> @@ -71,11 +70,7 @@ static int parse_str(StringInputVisitor *siv, const ch=
ar *name, Error **errp)
>                  str =3D NULL;
>              } else if (*endptr =3D=3D '-') {
>                  str =3D endptr + 1;
> -                errno =3D 0;
> -                end =3D strtoll(str, &endptr, 0);
> -                if (errno =3D=3D 0 && endptr > str && start <=3D end &&
> -                    (start > INT64_MAX - 65536 ||
> -                     end < start + 65536)) {
> +                if (!qemu_strtoi64(str, &endptr, 0, &end) && start < end=
) {
>                      if (*endptr =3D=3D '\0') {
>                          cur =3D g_malloc0(sizeof(*cur));
>                          range_set_bounds(cur, start, end);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvR1QQACgkQbDjKyiDZ
s5IjmRAA3KKkuXR3ge7at7vRv22tdH8ICPvL4yow9WkvXTW7WPYtCVEUQFWohKL/
iYwPijLg86TifOGUZSc9NVNMriUmY2RUL/++AiAKU+dRyXL8lwqPrGKvacHRFRTG
xBSf+wToGLHoG9o93TqYWCh40vzEM8n8SPq4vxBORGZCb+/B/6mlWXVs2Hx5zoKA
YQYEoNh6JGETF52UnYfZL/erEz6sYk6YqJFb30SA7tDnsXShdBy3J5pMpAUSewd5
trUZ+eAMkvLuJFGh9WwtSfwGizxrm1pulgW0lYbz3aWA662l4fLlnSFqxzXk6y1G
JLgyj0+uAuSTIr/cUYm9uMva2bx+6dpCwrnrwZ20ORLAEG8MfNpCycgcQUp3r1UH
Apb4bGw8LNzHuv3dnx3tV+hGbjKv8EFcMIplS/1OuGgSblchL/j22KmxWLMGzhyP
g8dAp843sK0OmVJ6CepC/D22I9ZBaWV3Do8bj85rPgZYfva9vsQGVTjLwp9wV6zd
qhhFMcM8bQU+9JbF7zcgwQmpPJyNICTaLlKUymw0oGK/Q35oOMkit879kFV8oBjW
nggq6Ff95fIXTrzELV34ib9EepkBaARiuR7bEeq/AudXar4TfQ2KvsVVl+VIyfl+
EQHgbi2KgjrtqKbd5+2jmhqN6N+vN76d8jPN1aYfh6sDaFHSP0I=
=iMTl
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
