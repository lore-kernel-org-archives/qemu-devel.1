Received: from eggs.gnu.org ([2001:4830:134:3::10]:36126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr7Do-0005ie-7O
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr7Dj-00073P-9h
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:12:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr7Dj-00073J-1H
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:12:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FA9361D36
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 18:12:23 +0000 (UTC)
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <324733bf-8e2c-2fac-2103-5dbaa461565c@redhat.com>
Date: Thu, 23 Mar 2017 13:12:20 -0500
MIME-Version: 1.0
In-Reply-To: <1490266548-22500-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xSg28rTKCDwsisrBONAowwgL826qwuaO8"
Subject: Re: [Qemu-devel] [PATCH for-2.9 5/5] rbd: Reject options
 server.*.{numeric, to, ipv4, ipv6}
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
--xSg28rTKCDwsisrBONAowwgL826qwuaO8
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <324733bf-8e2c-2fac-2103-5dbaa461565c@redhat.com>
Subject: Re: [PATCH for-2.9 5/5] rbd: Reject options
 server.*.{numeric,to,ipv4,ipv6}
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
 <1490266548-22500-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1490266548-22500-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 05:55 AM, Markus Armbruster wrote:
> We use InetSocketAddress in the QAPI schema.  However, the code
> doesn't use inet_connect_saddr(), but formats "host" and "port" into a
> configuration string for rados_conf_set().  Thus, members "numeric",
> "to", "ipv4" and "ipv6" are silently ignored.  Not nice.
>=20
> Factor a suitable InetSocketAddressBase out of InetSocketAddress, and
> use that.  "numeric", "to", "ipv4" and "ipv6" are now rejected.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi-schema.json     | 21 ++++++++++++++-------
>  qapi/block-core.json |  2 +-
>  2 files changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 68a4327..b921994 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4051,19 +4051,27 @@
>    'data': [ 'all', 'rx', 'tx' ] }
> =20
>  ##
> +# @InetSocketAddressBase:
> +#
> +# @host: host part of the address
> +# @port: port part of the address
> +##

No Since: - but we've argued that 'Since' on types is somewhat awkward
anyways, so I'm fine with it.

> +{ 'struct': 'InetSocketAddressBase',
> +  'data': {
> +    'host': 'str',
> +    'port': 'str' } }
> +
> +##

> @@ -4072,9 +4080,8 @@
>  # Since: 1.3
>  ##
>  { 'struct': 'InetSocketAddress',
> +  'base': 'InetSocketAddressBase',
>    'data': {
> -    'host': 'str',
> -    'port': 'str',
>      '*numeric':  'bool',
>      '*to': 'uint16',
>      '*ipv4': 'bool',

Slick example of how to split out the common portion into a base class
when refactoring (now I can point the thread on IOThrottle back to this
patch).

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index fe1e40f..a57c9e8 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2641,7 +2641,7 @@
>              '*conf': 'str',
>              '*snapshot': 'str',
>              '*user': 'str',
> -            '*server': ['InetSocketAddress'],
> +            '*server': ['InetSocketAddressBase'],
>              '*auth-supported': ['RbdAuthMethod'],
>              '*password-secret': 'str' } }
> =20
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xSg28rTKCDwsisrBONAowwgL826qwuaO8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1BAEAAoJEKeha0olJ0NqDqwH/08JCRc+ogs54bBh12tWNd8r
OPrEB3cO/q169G/vtkhO9Fm+scuRvZRfXospGXn5FtXyail4/l9x7xgVNvaqM/iy
TXv+pHKNMeIZUwB4wEBhHz219fkQAQwKyvainPalZG5scK/DNuvupIMZJFHz1OYT
CwZ0c4pVBw8QWaN+YlcWk1xFP0QMrSuy7JXRxoOUEQnFQs+OS1YJgHZOyX45S6Rd
F7fJWrBWQ5+hPrLTVGoYW216tr+dmcPsgGM/QL31zg0Sse4qTB+5h01Fq5fgKkJ+
E598Uk7pO3/CpKDL/SVjfuQh9Ylh3tDpgCgTbvkZzqlba32nyXOhO2MoK232n1U=
=ws58
-----END PGP SIGNATURE-----

--xSg28rTKCDwsisrBONAowwgL826qwuaO8--
