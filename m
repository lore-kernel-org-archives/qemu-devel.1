Received: from eggs.gnu.org ([2001:4830:134:3::10]:43356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciU5M-00042C-3M
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciU5K-0001hm-Qm
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:48:04 -0500
References: <cover.1488220970.git.jcody@redhat.com>
	<12a16b28300f871052a49897ec7875a082fc63e3.1488220970.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c5869fe5-fa51-3f2f-26d6-26a733c15493@redhat.com>
Date: Mon, 27 Feb 2017 16:47:54 -0600
MIME-Version: 1.0
In-Reply-To: <12a16b28300f871052a49897ec7875a082fc63e3.1488220970.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ncCGp2aha2d9F3LP4cRr4fjI66uWN9ENX"
Subject: Re: [Qemu-devel] [PATCH v2 5/5] block/rbd: add support for
 'mon_host', 'auth_supported' via QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ncCGp2aha2d9F3LP4cRr4fjI66uWN9ENX
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com
Message-ID: <c5869fe5-fa51-3f2f-26d6-26a733c15493@redhat.com>
Subject: Re: [PATCH v2 5/5] block/rbd: add support for 'mon_host',
 'auth_supported' via QAPI
References: <cover.1488220970.git.jcody@redhat.com>
 <12a16b28300f871052a49897ec7875a082fc63e3.1488220970.git.jcody@redhat.com>
In-Reply-To: <12a16b28300f871052a49897ec7875a082fc63e3.1488220970.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 12:58 PM, Jeff Cody wrote:
> This adds support for two additional options that may be specified
> by QAPI in blockdev-add:
>=20
>     mon_host: servername and port
>     auth_supported: either 'cephx' or 'none'

Please spell new options with '-'

>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/rbd.c          | 39 +++++++++++++++++++++++++++++++++++++++
>  qapi/block-core.json |  8 ++++++++
>  2 files changed, 47 insertions(+)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index e04a5e1..51e971e 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -394,6 +394,18 @@ static QemuOptsList runtime_opts =3D {
>              .name =3D "keyvalue-pairs",
>              .type =3D QEMU_OPT_STRING,
>          },
> +        {
> +            .name =3D "server.host",
> +            .type =3D QEMU_OPT_STRING,
> +        },
> +        {
> +            .name =3D "server.port",
> +            .type =3D QEMU_OPT_STRING,
> +        },

See Dan's comment about supporting more than one server via an array in
QAPI.

> +        {
> +            .name =3D "auth_supported",

Should be auth-supported in QAPI.


> @@ -604,6 +620,29 @@ static int qemu_rbd_open(BlockDriverState *bs, QDi=
ct *options, int flags,
>          goto failed_shutdown;
>      }
> =20
> +    /* if mon_host was specified */
> +    if (host) {
> +        const char *hostname =3D host;
> +        char *mon_host =3D NULL;
> +
> +        if (port) {
> +            mon_host =3D g_strdup_printf("%s:%s", host, port);

Does Ceph care about IPv6 (in which case you may need [host]:port when
host itself includes ':')?

> +            hostname =3D mon_host;
> +        }
> +        r =3D rados_conf_set(s->cluster, "mon_host", hostname);
> +        g_free(mon_host);
> +        if (r < 0) {
> +            goto failed_shutdown;
> +        }
> +    }
> +
> +    if (auth_supported) {
> +        r =3D rados_conf_set(s->cluster, "auth_supported", auth_suppor=
ted);

Translating QAPI auth-supported to rados auth_supported is fine.


> +++ b/qapi/block-core.json
> @@ -2680,6 +2680,12 @@
>  #
>  # @user:               #optional Ceph id name.
>  #
> +# @server:             #optional Monitor host address and port.  This =
maps
> +#                      to the "mon_host" Ceph option.
> +#
> +# @auth_supported:     #optional Authentication supported.
> +#                      Either "cephx" or"none".

Missing a space.

If you're going to support only a finite set of strings, this should be
a QAPI enum type, not 'str'.

> +#
>  # @password-secret:    #optional The ID of a QCryptoSecret object prov=
iding
>  #                       the password for the login.
>  #
> @@ -2691,6 +2697,8 @@
>              '*conf': 'str',
>              '*snapshot': 'str',
>              '*user': 'str',
> +            '*server': 'InetSocketAddress',
> +            '*auth_supported': 'str',
>              '*password-secret': 'str' } }
> =20
>  ##
>=20

Looks like we'll need a v3 to tweak this one.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ncCGp2aha2d9F3LP4cRr4fjI66uWN9ENX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtKyaAAoJEKeha0olJ0NqVZoH/1+lYGjByZO36Y+woubv428J
GEtILqscPVwBnbjOcR+7uZUQ7L6PH4G7G/7QayTm9Lkjdz2+67A+tBGS4zea+Gi+
b6SFYdUkQZkYSw2XhwtpV1bW3v2Rd93/buJpoT3e9JLoMl60R2X1jwS6GQMIdrjL
/+pfkJhAXPgiFdfUr3usaWxgVSPZNIvjHB8UVDlDc78YkbUGE9/N7hRrbJIq+MCO
gpXvceVkKJ7jEEOISvyMHlXq7XbKTDGgNydLfomOtwTuhEHQ8DSt3WxGS9QwCMSJ
Eff/LmzxDJHCBylJjiZieZT1wn5xlEG5SIityEcJ3IXFhRcx+GqByn64R92qek4=
=AOhe
-----END PGP SIGNATURE-----

--ncCGp2aha2d9F3LP4cRr4fjI66uWN9ENX--
