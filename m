Received: from eggs.gnu.org ([2001:4830:134:3::10]:59334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXq9x-0006r8-Lz
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXq9u-0003Ve-C5
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:41:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXq9u-0003VL-2R
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:41:02 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-3-anton.ivanov@cambridgegreys.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <03702920-f5b1-6579-0c59-a0d46274a6d9@redhat.com>
Date: Wed, 19 Jul 2017 09:40:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170718170819.28494-3-anton.ivanov@cambridgegreys.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VrGWtk6eQiHp7rR4o5oe4eRie2lQIbfJ2"
Subject: Re: [Qemu-devel] [PATCH 2/3] Unified Datagram Socket Transport -
 GRE support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: anton.ivanov@cambridgegreys.com, qemu-devel@nongnu.org
Cc: jasowang@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VrGWtk6eQiHp7rR4o5oe4eRie2lQIbfJ2
From: Eric Blake <eblake@redhat.com>
To: anton.ivanov@cambridgegreys.com, qemu-devel@nongnu.org
Cc: jasowang@redhat.com
Message-ID: <03702920-f5b1-6579-0c59-a0d46274a6d9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] Unified Datagram Socket Transport - GRE
 support
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
 <20170718170819.28494-3-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20170718170819.28494-3-anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 12:08 PM, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>=20
> This adds GRETAP support to the unified socket driver.
>=20
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>  net/Makefile.objs |   2 +-
>  net/clients.h     |   4 +
>  net/gre.c         | 313 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  net/net.c         |   5 +
>  qapi-schema.json  |  46 +++++++-
>  qemu-options.hx   |  63 ++++++++++-
>  6 files changed, 425 insertions(+), 8 deletions(-)
>  create mode 100644 net/gre.c
>=20

Just an interface review:

> +++ b/qapi-schema.json
> @@ -3847,7 +3847,41 @@
>      'txsession':    'uint32',
>      '*rxsession':   'uint32',
>      '*offset':      'uint32' } }
> -
> +##
> +# @NetdevGREOptions:
> +#
> +# Connect the VLAN to Ethernet over Ethernet over GRE (GRETAP) tunnel
> +#
> +# @src: source address
> +#
> +# @dst: destination address
> +#
> +# @ipv6: force the use of ipv6

This doesn't quite match what we do with other sockets (where we have
both ipv4 and ipv6 booleans to allow IPv4-only, IPv6-only, or both).  Is
this something where we can reuse InetSocketAddress instead of inventing
yet another way of doing things?

Then again, it does match what NetdevL2TPv3Options did :(

> +#
> +# @sequence: have sequence counter
> +#
> +# @pinsequence: pin sequence counter to zero -
> +#              workaround for buggy implementations or
> +#              networks with packet reorder
> +#
> +# @txkey: 32 bit transmit key
> +#
> +# @rxkey: 32 bit receive key

Worth listing what the defaults are for these optional fields when not
present?

> +#
> +# Note - gre checksums are not supported at present
> +#
> +#
> +# Since 2.9

You've missed 2.9 by a long shot.  You've also missed 2.10 softfreeze
for a new feature, so this should read since 2.11.

> @@ -3966,7 +4000,7 @@
>  ##
>  { 'enum': 'NetClientDriver',
>    'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde', '=
dump',
> -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
> +            'bridge', 'hubport', 'netmap', 'vhost-user', 'gre' ] }

Worth adding a comment that 'gre' is since 2.11 (look for other enums
that have had additions after the initial release of the enum, for an
example of the preferred format).

> =20
>  ##
>  # @Netdev:
> @@ -3996,7 +4030,8 @@
>      'bridge':   'NetdevBridgeOptions',
>      'hubport':  'NetdevHubPortOptions',
>      'netmap':   'NetdevNetmapOptions',
> -    'vhost-user': 'NetdevVhostUserOptions' } }
> +    'vhost-user': 'NetdevVhostUserOptions',
> +    'gre':      'NetdevGREOptions' } }

Okay.

> =20
>  ##
>  # @NetLegacy:
> @@ -4027,7 +4062,7 @@
>  ##
>  { 'enum': 'NetLegacyOptionsType',
>    'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> -           'dump', 'bridge', 'netmap', 'vhost-user'] }
> +           'dump', 'bridge', 'netmap', 'vhost-user', 'gre'] }

Not okay.  NetLegacy should never grow again (that's the whole point of
it being legacy - we're trying to phase it out).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VrGWtk6eQiHp7rR4o5oe4eRie2lQIbfJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllvb3sACgkQp6FrSiUn
Q2rkjAf/autiOT+3btPXnhYkN9RpwcWay78hZ7sQL8jZWMFTc8k8MGeW9N46qGea
fUuxR7OfyTDqcADiAoNhzTOG0iVScoQLoBY8eTFKKu5wK0XrOeJXwZWXFMwJTA+Z
9geyVpPZ4rKBUxMY1V5dGosMtl13hN5NGg/c6mbu+3ytQ1q7IjJJ8907qgd6sE4A
mj05oViShG8RlHW4Y/s1Yc7/25w1w+c7oNjMe9kiO/mlJr8tA2AH9fYK9gSyIPDG
Zwf6N72Xs7tFb2UJ3SZzPt+OVXhF7kQFBtV7P5TyHQPOxygw3l7OXRIrS3tbEcWt
3gHtA/SK8m2KgovXp7s+a7ntbunAPQ==
=EKlE
-----END PGP SIGNATURE-----

--VrGWtk6eQiHp7rR4o5oe4eRie2lQIbfJ2--
