Received: from eggs.gnu.org ([2001:4830:134:3::10]:53889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr6i4-0005Sg-EN
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr6i3-0002SI-6Y
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr6i2-0002Ru-T5
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D52B21B1768
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 17:39:38 +0000 (UTC)
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <011d21ee-aa96-2541-2e54-16c423f07cce@redhat.com>
Date: Thu, 23 Mar 2017 12:39:35 -0500
MIME-Version: 1.0
In-Reply-To: <1490266548-22500-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Lodt2IRiqfnE3ajLgbljjqo8C9CcISdE3"
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] rbd: Rewrite the code to
 extract list-valued options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lodt2IRiqfnE3ajLgbljjqo8C9CcISdE3
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <011d21ee-aa96-2541-2e54-16c423f07cce@redhat.com>
Subject: Re: [PATCH for-2.9 3/5] rbd: Rewrite the code to extract list-valued
 options
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
 <1490266548-22500-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1490266548-22500-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 05:55 AM, Markus Armbruster wrote:
> We have two list-values options:
>=20
> * "server" is a list of InetSocketAddress.  We use members "host" and
>   "port", and silently ignore the rest.
>=20
> * "auth-supported" is a list of RbdAuthMethod.  We use its only member
>   "auth".
>=20
> Since qemu_rbd_open() takes options as a flattened QDict, options has
> keys of the form server.%d.host, server.%d.port and
> auth-supported.%d.auth, where %d counts up from zero.
>=20
> qemu_rbd_array_opts() extracts these values as follows.  First, it
> calls qdict_array_entries() to find the list's length.  For each list
> element, it first formats the list's key prefix (e.g. "server.0."),
> then creates a new QDict holding the options with that key prefix,
> then converts that to a QemuOpts, so it can finally get the member
> values from there.
>=20
> If there's one surefire way to make code using QDict more awkward,
> it's creating more of them and mixing in QemuOpts for good measure.

No kidding!

>=20
> The conversion to QemuOpts abuses runtime_opts, as described in the
> commit before previous.
>=20
> Rewrite to simply get the values straight from the options QDict.
> This removes the abuse of runtime_opts, so clean it up.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c | 151 +++++++++++++++++-----------------------------------=
--------
>  1 file changed, 42 insertions(+), 109 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index 59c822a..8ba0f79 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -13,6 +13,7 @@
> =20
>  #include "qemu/osdep.h"
> =20
> +#include <rbd/librbd.h>
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "block/block_int.h"
> @@ -20,8 +21,6 @@
>  #include "qemu/cutils.h"
>  #include "qapi/qmp/qstring.h"
> =20
> -#include <rbd/librbd.h>
> -

Not mentioned in the commit message, but also a useful cleanup for
hoisting <includes> prior to "includes".

> +static char *rbd_auth(QDict *options)
>  {
> -    int num_entries;
> -    QemuOpts *opts =3D NULL;
> -    QDict *sub_options;
> -    const char *host;
> -    const char *port;
> -    char *str;
> -    char *rados_str =3D NULL;
> -    Error *local_err =3D NULL;
> +    const char **vals =3D g_new(const char *, qdict_size(options));
> +    char keybuf[32];
> +    QObject *val;
> +    char *rados_str;
>      int i;
> =20
> -    assert(type =3D=3D RBD_MON_HOST || type =3D=3D RBD_AUTH_SUPPORTED)=
;
> -
> -    num_entries =3D qdict_array_entries(options, prefix);
> +    for (i =3D 0;; i++) {
> +        sprintf(keybuf, "auth-supported.%d.auth", i);

By my count, and including a trailing NUL, this is 21 bytes + the
maximum size of a formatted int to fit in keybuf[32]; 32-bit INT_MIN is
indeed 11 bytes.  Cutting it close there, but I don't see an overflow
(if gcc 7's new -Wformat-truncation spots something, then gcc is too
strict.)

> +static char *rbd_mon_host(QDict *options)
> +{
> +    const char **vals =3D g_new(const char *, qdict_size(options));
> +    char keybuf[32];
> +    QObject *val;
> +    const char *host, *port;
> +    char *rados_str;
> +    int i;
> =20
> -            value =3D host;
> -            if (port) {
> -                /* check for ipv6 */
> -                if (strchr(host, ':')) {
> -                    strbuf =3D g_strdup_printf("[%s]:%s", host, port);=

> -                } else {
> -                    strbuf =3D g_strdup_printf("%s:%s", host, port);

The old code only prints port information if it is present...

> -                }
> -                value =3D strbuf;
> -            } else if (strchr(host, ':')) {
> -                strbuf =3D g_strdup_printf("[%s]", host);
> -                value =3D strbuf;
> -            }
> -        } else {
> -            value =3D qemu_opt_get(opts, "auth");
> +    for (i =3D 0;; i++) {
> +        sprintf(keybuf, "server.%d.host", i);

Here, you've got more breathing room.

> +        val =3D qdict_get(options, keybuf);
> +        if (!val) {
> +            break;
>          }
> +        host =3D qstring_get_str(qobject_to_qstring(val));
> +        sprintf(keybuf, "server.%d.port", i);
> +        port =3D qdict_get_str(options, keybuf);
> =20
> -
> -        /* each iteration in the for loop will build upon the string, =
and if
> -         * rados_str is NULL then it is our first pass */
> -        if (rados_str) {
> -            /* separate options with ';', as that  is what rados_conf_=
set()
> -             * requires */
> -            rados_str_tmp =3D rados_str;
> -            rados_str =3D g_strdup_printf("%s;%s", rados_str_tmp, valu=
e);
> -            g_free(rados_str_tmp);
> +        if (strchr(host, ':')) {
> +            vals[i] =3D g_strdup_printf("[%s]:%s", host, port);
>          } else {
> -            rados_str =3D g_strdup(value);
> +            vals[i] =3D g_strdup_printf("%s:%s", host, port);

=2E..but the new code unconditionally prints port information, even when
port =3D=3D NULL.  Oops.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Lodt2IRiqfnE3ajLgbljjqo8C9CcISdE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1AhXAAoJEKeha0olJ0NqqN0IAK+F9Y9IEgT4x2SP5XpUl8sZ
1cqbj8RsBXB6BhFV077CcomULcJFQHecxkkRQNf6pxP6MLzYzMtWBpWhZjvNfJrS
+Q8KGmM9AWdRM0tuHbTEjcz997i0G7QNrQwEobA1alH+OPmnzHJ2TQqgxlXkhQEo
mUp+UCHDUwzSTzNZuJzmtHDn9qulwSJRuh1Z6/W6+aJEDYQT+mjhT4AzCQ0egoi5
jSz4foE59h8+YOR4vJ/H2unzCrFJ69kM2KZd7bATXf6MgAK1UYCRWa5CntjkJxkc
wDxaBuZX1mdfCuahxUtjpdEzmrrY6b1Z/aGEVUJ1R6mP1GbUYQOjZel++Y5IC68=
=V890
-----END PGP SIGNATURE-----

--Lodt2IRiqfnE3ajLgbljjqo8C9CcISdE3--
