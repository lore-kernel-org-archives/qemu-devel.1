Received: from eggs.gnu.org ([2001:4830:134:3::10]:38038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edj8U-0000qb-5b
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:56:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edj8T-0004Sb-3Z
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:56:10 -0500
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-9-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0066a7f-0197-73c9-4012-67b5e48e178a@redhat.com>
Date: Mon, 22 Jan 2018 14:55:56 -0600
MIME-Version: 1.0
In-Reply-To: <1516366207-109842-9-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QGfgsdBs0a1OLVuixyLXRMx8MUzdVJu3f"
Subject: Re: [Qemu-devel] [PATCH v2 8/8] qapi: query-blockstat: add driver
 specific file-posix stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QGfgsdBs0a1OLVuixyLXRMx8MUzdVJu3f
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, den@virtuozzo.com
Message-ID: <b0066a7f-0197-73c9-4012-67b5e48e178a@redhat.com>
Subject: Re: [PATCH v2 8/8] qapi: query-blockstat: add driver specific
 file-posix stats
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516366207-109842-9-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516366207-109842-9-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2018 06:50 AM, Anton Nefedov wrote:
> A block driver can provide a callback to report driver-specific
> statistics.
>=20
> file-posix driver now reports discard statistics
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> +++ b/qapi/block-core.json
> @@ -774,6 +774,40 @@
>             'timed_stats': ['BlockDeviceTimedStats'] } }
> =20
>  ##
> +# @BlockDriverStatsFile:
> +#
> +# File driver statistics
> +#
> +# @discard_nb_ok: The number of succeeded discard operations performed=
 by
> +#                 the driver.
> +#
> +# @discard_nb_failed: The number of failed discard operations performe=
d by
> +#                     the driver.
> +#
> +# @discard_bytes_ok: The number of bytes discarded by the driver.
> +#
> +# Since 2.12
> +##
> +{ 'struct': 'BlockDriverStatsFile',
> +  'data': {
> +      'discard_nb_ok': 'int',
> +      'discard_nb_failed': 'int',
> +      'discard_bytes_ok': 'int'
> +  } }

New interfaces should prefer '-' over '_', where possible (a reason for
using '_' is if the fields are alongside pre-existing fields that
already used '_').  Let's see how this gets used...[1]

> +
> +##
> +# @BlockDriverStats:
> +#
> +# Statistics of a block driver (driver-specific)
> +#
> +# Since: 2.12
> +##
> +{ 'union': 'BlockDriverStats',
> +  'data': {
> +      'file': 'BlockDriverStatsFile'
> +  } }

Markus has been adamant that we add no new "simple unions" (unions with
a 'discriminator' field) - because they are anything but simple in the
long run.

> +
> +##
>  # @BlockStats:
>  #
>  # Statistics of a virtual block device or a block backing device.
> @@ -785,6 +819,8 @@
>  #
>  # @stats:  A @BlockDeviceStats for the device.
>  #
> +# @driver-stats: Optional driver-specific statistics. (Since 2.12)
> +#
>  # @parent: This describes the file block device if it has one.
>  #          Contains recursively the statistics of the underlying
>  #          protocol (e.g. the host file for a qcow2 image). If there i=
s
> @@ -798,6 +834,7 @@
>  { 'struct': 'BlockStats',
>    'data': {'*device': 'str', '*node-name': 'str',
>             'stats': 'BlockDeviceStats',
> +           '*driver-stats': 'BlockDriverStats',

=2E..[1] You are using it alongside a struct that already uses '-'
(node-name), so you should use dashes.

So, the difference between your proposal (a simple union) and using a
"flat union", on the wire, is yours:

"return": { ..., "driver-stats": { "type": "file", "data": {
"discard_nb_ok: ... } } }

vs. a flat union:

"return": { ..., "driver-stats": { "driver": "file", "discard-nb-ok":
=2E.. } }

where you can benefit from less nesting and a saner discriminator name.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QGfgsdBs0a1OLVuixyLXRMx8MUzdVJu3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpmT9wACgkQp6FrSiUn
Q2rf/ggAlZZNZfHVfBwHKcwma1nA1cFjbnOa0KwDyqebqydCwV4PGKb12FRgiwHC
sf7Fr2dIr/I0cxO+Tk/ESWR32xLyIAi1hCWXlinN5VorPqYoURqmV2VZRXdOANV5
DzQnXvZkOhM7thsa7FcUDygrVISp1YDi9GBE/r2qlvHwzvM/KcF9Ml5z//YYt4dY
NvGYm3BXqKBrtmMzdeZcBZ5UC5F53f3z/Ulej+h2bnthyhXNc9lE4WCfJ4pbzOBM
Mn/J+TLsNJIKfQw+S3uQfGcCHcr/JtOQfQZf+Bvwot5dpY4hPD8EiMWai5GKSwBu
ppqSyFgpG9U7JIblRMSHRYdBPHWS+A==
=d7TF
-----END PGP SIGNATURE-----

--QGfgsdBs0a1OLVuixyLXRMx8MUzdVJu3f--
