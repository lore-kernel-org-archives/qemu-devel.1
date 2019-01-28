Received: from eggs.gnu.org ([209.51.188.92]:33858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goAyg-0007KD-24
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goAye-0008V1-MK
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:45:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1goAye-0008QD-Ch
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:45:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14E3E804EB
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 17:45:31 +0000 (UTC)
References: <20190128170321.16936-1-dgilbert@redhat.com>
	<20190128170321.16936-3-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <743a07c4-0c9f-8b51-f792-7132e82dc0dc@redhat.com>
Date: Mon, 28 Jan 2019 11:45:27 -0600
MIME-Version: 1.0
In-Reply-To: <20190128170321.16936-3-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xOKqYRXcOGkGrhMdkMIjDSqmFY7HsXdYI"
Subject: Re: [Qemu-devel] [PATCH 2/9] migration: Add announce parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xOKqYRXcOGkGrhMdkMIjDSqmFY7HsXdYI
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com,
 mst@redhat.com, armbru@redhat.com, berrange@redhat.com
Message-ID: <743a07c4-0c9f-8b51-f792-7132e82dc0dc@redhat.com>
Subject: Re: [PATCH 2/9] migration: Add announce parameters
References: <20190128170321.16936-1-dgilbert@redhat.com>
 <20190128170321.16936-3-dgilbert@redhat.com>
In-Reply-To: <20190128170321.16936-3-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/28/19 11:03 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Add migration parameters that control RARP/GARP announcement timeouts.
>=20
> Based on earlier patches by myself and
>   Vladislav Yasevich <vyasevic@redhat.com>
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---

> +++ b/qapi/migration.json
> @@ -6,6 +6,7 @@
>  ##
> =20
>  { 'include': 'common.json' }
> +{ 'include': 'net.json' }
> =20
>  ##
>  # @MigrationStats:
> @@ -480,6 +481,18 @@
>  #
>  # Migration parameters enumeration
>  #
> +# @announce-initial: Inital delay (in ms) before sending the first ann=
ounce

s/Inital/Initial/ [2]

> +#          (Since 4.0)
> +#
> +# @announce-max: Maximum delay (in ms) between packets in the announcm=
ent
> +#          (Since 4.0)
> +#
> +# @announce-rounds: Number of self-announce packets sent after migrati=
on
> +#          (Since 4.0)
> +#
> +# @announce-step: Increase in delay (in ms) between subsequent packets=
 in
> +#          the announcement (Since 4.0)
> +#

The new parameters are optional below [1]; should they have a default
value documented, and are there any constraints such that if you set
one, you must set all four to match the previous' patch having all four
be non-optional?


> @@ -653,7 +681,11 @@
>  # TODO either fuse back into MigrationParameters, or make
>  # MigrationParameters members mandatory
>  { 'struct': 'MigrateSetParameters',
> -  'data': { '*compress-level': 'int',
> +  'data': { '*announce-initial': 'size',
> +            '*announce-max': 'size',
> +            '*announce-rounds': 'size',
> +            '*announce-step': 'size',
> +            '*compress-level': 'int',

[1] mentioned above

>              '*compress-threads': 'int',
>              '*compress-wait-thread': 'bool',
>              '*decompress-threads': 'int',
> @@ -692,6 +724,18 @@
>  #
>  # The optional members aren't actually optional.
>  #
> +# @announce-initial: Inital delay (in ms) before sending the first ann=
ounce
> +#          (Since 4.0)

[2] again


> @@ -769,7 +813,11 @@
>  # Since: 2.4
>  ##
>  { 'struct': 'MigrationParameters',
> -  'data': { '*compress-level': 'uint8',
> +  'data': { '*announce-initial': 'size',
> +            '*announce-max': 'size',
> +            '*announce-rounds': 'size',
> +            '*announce-step': 'size',
> +            '*compress-level': 'uint8',

[1] again

>              '*compress-threads': 'uint8',
>              '*compress-wait-thread': 'bool',
>              '*decompress-threads': 'uint8',
> @@ -785,7 +833,7 @@
>              '*x-multifd-page-count': 'uint32',
>              '*xbzrle-cache-size': 'size',
>  	    '*max-postcopy-bandwidth': 'size',
> -            '*max-cpu-throttle':'uint8'} }
> +            '*max-cpu-throttle':'uint8' } }

Why the whitespace churn?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--xOKqYRXcOGkGrhMdkMIjDSqmFY7HsXdYI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxPP7cACgkQp6FrSiUn
Q2r9Zwf+LGnUWHJ3VL86Q3MHgGlMauVPGWmAOnYRd28IEZsfoSgWZ3JOhaTJXnBY
0WgS36UB5Qnt7TVvy0NNX6EZ/NRg2CcphPOqv3sMP998UYmudrE2yedkhSv1MM+o
Oy+rrQOL1qBfhx+JxniQqnwikyKqAc9WyE5foJfr6dO6HryKoEIrpIuScfm+5D1U
bKyXIqZO0QHtFdqnMkoHUJ9axjTLHTUH6TWH2oZkZakaNm+rz6xO/D2TIuxINKvw
vHQ8RNxP3KR6u/BX6Az0AUlgFsDUfWZ53FmEK1EM1vCW8N2IfLFuTYaAmuF2fdlJ
mfxbJk+hYCcmNvmCZmlQKixkSVMC9A==
=el/y
-----END PGP SIGNATURE-----

--xOKqYRXcOGkGrhMdkMIjDSqmFY7HsXdYI--
