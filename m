Received: from eggs.gnu.org ([2001:4830:134:3::10]:43954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPAoV-0006L9-E6
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPAoQ-0007pa-Hv
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:22:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPAoQ-0007pU-9c
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:22:46 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D4E4129206
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:22:46 +0000 (UTC)
References: <20170105160321.21786-1-berrange@redhat.com>
	<20170105160321.21786-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3ff1cf4e-67c3-b182-1c3c-2e6dce546e85@redhat.com>
Date: Thu, 5 Jan 2017 10:22:43 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160321.21786-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bPfb8MOXtWHFroek3vL1xVFE4uCcIDU9d"
Subject: Re: [Qemu-devel] [PATCH 1/8] sockets: add ability to disable DNS
 resolution for InetSocketAddress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bPfb8MOXtWHFroek3vL1xVFE4uCcIDU9d
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3ff1cf4e-67c3-b182-1c3c-2e6dce546e85@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] sockets: add ability to disable DNS
 resolution for InetSocketAddress
References: <20170105160321.21786-1-berrange@redhat.com>
 <20170105160321.21786-2-berrange@redhat.com>
In-Reply-To: <20170105160321.21786-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:03 AM, Daniel P. Berrange wrote:
> Add a 'numeric' flag to the InetSocketAddress struct to allow the
> caller to indicate that DNS should be skipped for the host/port
> fields. This is useful if the caller knows the address is already
> numeric and wants to guarantee no (potentially blocking) DNS
> lookups are attempted.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qapi-schema.json    | 5 +++++
>  util/qemu-sockets.c | 3 +++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index a0d3b5d..d605c1e 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3070,6 +3070,10 @@
>  #
>  # @port: port part of the address, or lowest port if @to is present
>  #
> +# @numeric: #optional true if the host/port are guaranteed to be numer=
ic,
> +#           false if name resolution should be attempted. Defaults to =
false.
> +#           Since 2.8

2.9, actually.  I'm also not sure if Marc-Andre's work requires ()
brackets around the since designation on a per-member listing.

> @@ -3084,6 +3088,7 @@
>    'data': {
>      'host': 'str',
>      'port': 'str',
> +    'numeric':  'bool',

In order to be optional, it must be spelled '*numeric'.

>      '*to': 'uint16',
>      '*ipv4': 'bool',
>      '*ipv6': 'bool' } }

Thinking out loud: Do we even need a 'numeric' field?  If we could
create an alternate type that distinguishes between a 'str' (name, DNS
resolution required) and an 'int' (numeric, skip DNS), then we don't
need a field.  Except that an 'int' for IPv4 addresses is awkward, and
an 'int' for IPv6 addresses in insufficient - so even when the address
is numeric, you STILL have to pass it in as 'str'.  Okay, experiment
failed, your interface seems like the correct thing to do.

> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index fe1d07a..6f1c10a 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -141,6 +141,9 @@ static int inet_listen_saddr(InetSocketAddress *sad=
dr,
> =20
>      memset(&ai,0, sizeof(ai));
>      ai.ai_flags =3D AI_PASSIVE;
> +    if (saddr->numeric) {

if (saddr->has_numeric && saddr->numeric)

> +        ai.ai_flags |=3D AI_NUMERICHOST | AI_NUMERICSERV;
> +    }
>      ai.ai_family =3D inet_ai_family_from_address(saddr, &err);
>      ai.ai_socktype =3D SOCK_STREAM;
> =20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--bPfb8MOXtWHFroek3vL1xVFE4uCcIDU9d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbnLUAAoJEKeha0olJ0NqOGkH/0V9CEc4GhR4PEVXlQBBI4ri
LN7Lwg3fGDBEqe4ZfCdBQ2acGHdpCU0ncbiIxUaB2TthenOB8xoOciFxx9OFYVjg
bUKWgvXC5f9Sloctul/HXca9jED3l3Yh//Wop0VDbDBct06Fa5x29oGktY6S2QWm
QGT7jTZBlWYznmSNPF5D1YARqIuWK5PeDrcXimtoelOvaiv/d81835zl3KRe81y+
NdfqUH2z0LOwnKFFoHIuHeusXB4Iv43UL9JeZtt/zXc9rxMVqYFKwlYBUOv9dX94
bxl1DrgrLIkX4DBFyAE4xLteA3jhkLaWVsnO+ub3JY8Kj2imAp8yX5q5GQHJFkc=
=ayWc
-----END PGP SIGNATURE-----

--bPfb8MOXtWHFroek3vL1xVFE4uCcIDU9d--
