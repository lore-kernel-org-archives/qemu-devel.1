Received: from eggs.gnu.org ([2001:4830:134:3::10]:48499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evVJu-00077j-76
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evVJt-0000X9-DO
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:49:26 -0400
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-8-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <11f93eeb-19f3-9f3e-edb9-00c1bfb86b37@redhat.com>
Date: Mon, 12 Mar 2018 22:49:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180309214611.19122-8-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Yxxgep1B7lcw73fmLXkeOXnG1gRiTPiCY"
Subject: Re: [Qemu-devel] [PATCH 7/7] vpc: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yxxgep1B7lcw73fmLXkeOXnG1gRiTPiCY
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <11f93eeb-19f3-9f3e-edb9-00c1bfb86b37@redhat.com>
Subject: Re: [PATCH 7/7] vpc: Support .bdrv_co_create
References: <20180309214611.19122-1-kwolf@redhat.com>
 <20180309214611.19122-8-kwolf@redhat.com>
In-Reply-To: <20180309214611.19122-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-09 22:46, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to vpc, which
> enables image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  33 ++++++++++-
>  block/vpc.c          | 152 ++++++++++++++++++++++++++++++++++++++-----=
--------
>  2 files changed, 147 insertions(+), 38 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 3a65909c47..ca645a0067 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3734,6 +3734,37 @@
>              '*block-state-zero':    'bool' } }
> =20
>  ##
> +# @BlockdevVpcSubformat:
> +#
> +# @dynamic: Growing image file
> +# @fixed:   Preallocated fixed-size imge file

s/imge/image/

> +#
> +# Since: 2.12
> +##
> +{ 'enum': 'BlockdevVpcSubformat',
> +  'data': [ 'dynamic', 'fixed' ] }
> +
> +##
> +# @BlockdevCreateOptionsVpc:
> +#
> +# Driver specific image creation options for vpc (VHD).
> +#
> +# @file             Node to create the image format on
> +# @size             Size of the virtual disk in bytes
> +# @subformat        vhdx subformat (default: dynamic)
> +# @force-size       Force use of the exact byte size instead of roundi=
ng to the
> +#                   next size that can be represented in CHS geometry
> +#                   (default: false)

Now that's weird, again considering your previous approach of only
rounding things in the legacy path and instead throwing errors from
blockdev-create.  If you think this is OK to have here, than that's OK
with me, but I'm not sure this is the ideal way.

Alternatives:

1. Swap the default, not sure this is such a good idea either.

2. Maybe add an enum instead.  Default: If the given size doesn't fit
CHS, generate an error.  Second choice: Use the given size, even if it
doesn't fit.  Third choice: Round to CHS.

I don't want to be stuck up, but once it's a public interface...

So if you think the bool is OK like it is...

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'BlockdevCreateOptionsVpc',
> +  'data': { 'file':                 'BlockdevRef',
> +            'size':                 'size',
> +            '*subformat':           'BlockdevVpcSubformat',
> +            '*force-size':          'bool' } }
> +
> +##
>  # @BlockdevCreateNotSupported:
>  #
>  # This is used for all drivers that don't support creating images.


--Yxxgep1B7lcw73fmLXkeOXnG1gRiTPiCY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqm9c4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Av28IAKUEfIxft/Hz6WfSVdYtkF5s/InZpEqA
oJ/nUy5XWd+aQx90JL2KdMTg+NSVe/eclcdw4vB/0laByeKk7oqldsoOFSNHr2Hm
kAncKKhMa9z7TEPy9mhJlNxas3At5R8OFofTRYYY2Hhzx/UmgpYbjWMEh/DYg2Yh
XmD0xTyYu2uqWXCxxBqE1iJp9SCnf50NPCp7hgoGTi9DKztuKTqa5NlTC7RJwv0I
OFMYF2I7OFXyyxxTn+jN2jasiuSdEQab1lDC26BHrGI4BHbuy8xwqNlHj45svFEY
JhgyRz4kSD/i67+mD4l4ug+Srn48nXGK850XO0bW1trhIuWRgiO9Q1Q=
=9PZC
-----END PGP SIGNATURE-----

--Yxxgep1B7lcw73fmLXkeOXnG1gRiTPiCY--
