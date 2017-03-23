Received: from eggs.gnu.org ([2001:4830:134:3::10]:53873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr3nQ-0003Z8-Qk
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr3nM-0006aR-FR
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:33:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr3nM-0006Yf-6g
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:32:56 -0400
References: <1490271635-19049-1-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63a3057f-59a2-ec92-2df8-af33ec152394@redhat.com>
Date: Thu, 23 Mar 2017 09:32:46 -0500
MIME-Version: 1.0
In-Reply-To: <1490271635-19049-1-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J8d5glU1sFAAedmPdPIKcoUfPet20gQd9"
Subject: Re: [Qemu-devel] [PATCH 1/2 v1] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>, "Daniel P.Berrange" <berrange@redhat.com>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Alberto Garcia <berto@igalia.com>, Jani Kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J8d5glU1sFAAedmPdPIKcoUfPet20gQd9
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz
 <groug@kaod.org>, "Daniel P.Berrange" <berrange@redhat.com>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Alberto Garcia <berto@igalia.com>, Jani Kokkonen <jani.kokkonen@huawei.com>,
 qemu-devel@nongnu.org
Message-ID: <63a3057f-59a2-ec92-2df8-af33ec152394@redhat.com>
Subject: Re: [PATCH 1/2 v1] fsdev: QMP interface for throttling
References: <1490271635-19049-1-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1490271635-19049-1-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 07:20 AM, Pradeep Jagadeesh wrote:
> This patchset enables qmp interfaces for the 9pfs=20
> devices (fsdev). This provides two interfaces one=20

s/interfaces/interfaces,/

Also, I just noticed you are using trailing spaces in your commit
message (not fatal, but unusual).

> for querying all the 9pfs devices info. The second one
> to set the IO limits for the required 9pfs device.

When sending a multi-patch series, please remember to include the 0/2
cover letter ('git config format.coverletter auto' can help here).

>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---
>  Makefile                    |  5 ++-
>  fsdev/qemu-fsdev-throttle.c | 96 +++++++++++++++++++++++++++++++++++++=
++++++++
>  fsdev/qemu-fsdev-throttle.h | 11 ++++++
>  fsdev/qemu-fsdev.c          | 38 +++++++++++++++++-
>  fsdev/qemu-fsdev.h          |  2 +-
>  hmp-commands-info.hx        | 18 +++++++++
>  hmp-commands.hx             | 18 +++++++++
>  hmp.c                       | 74 ++++++++++++++++++++++++++++++++++
>  hmp.h                       |  5 +++
>  qapi-schema.json            |  6 +++
>  qapi/fsdev.json             | 87 +++++++++++++++++++++++++++++++++++++=
+++
>  qapi/iothrottle.json        | 93 +++++++++++++++++++++++++++++++++++++=
++++++
>  qmp.c                       | 14 +++++++
>  13 files changed, 464 insertions(+), 3 deletions(-)

That's a big patch to review in one go. Does it make sense to break it
down into smaller chunks?

>  create mode 100644 qapi/fsdev.json
>  create mode 100644 qapi/iothrottle.json
>=20
> v0 -> v1:
>=20
>    Addressed the comments by Erik Blake, Greg Kurz and Daniel P.Berrang=
e

It's Eric, but you're not the first (and probably not the last) to get
it wrong.

>    Mainly renaming the functions and removing the redundant code
>=20
> diff --git a/Makefile b/Makefile
> index 73e0c12..c33b46d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -413,7 +413,10 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SR=
C_PATH)/qapi/common.json \
>                 $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core=
=2Ejson \
>                 $(SRC_PATH)/qapi/event.json $(SRC_PATH)/qapi/introspect=
=2Ejson \
>                 $(SRC_PATH)/qapi/crypto.json $(SRC_PATH)/qapi/rocker.js=
on \
> -               $(SRC_PATH)/qapi/trace.json
> +               $(SRC_PATH)/qapi/trace.json  $(SRC_PATH)/qapi/iothrottl=
e.json

Why two spaces?


> +++ b/qapi-schema.json
> @@ -78,9 +78,15 @@
>  # QAPI crypto definitions
>  { 'include': 'qapi/crypto.json' }
> =20
> +# QAPI IOThrottle definitions
> +{ 'include': 'qapi/iothrottle.json' }
> +
>  # QAPI block definitions
>  { 'include': 'qapi/block.json' }
> =20
> +# QAPI fsdev definitions
> +{ 'include': 'qapi/fsdev.json' }
> +

Adding two new files definitely feels like something that could be
split. Also, is it possible that existing code could take advantage of
qapi/iothrottle.json, rather than it just being additional code?

>  # QAPI event definitions
>  { 'include': 'qapi/event.json' }
> =20
> diff --git a/qapi/fsdev.json b/qapi/fsdev.json
> new file mode 100644
> index 0000000..7fb3c25
> --- /dev/null
> +++ b/qapi/fsdev.json
> @@ -0,0 +1,87 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# =3D=3D QAPI fsdev definitions
> +##
> +
> +# QAPI common definitions
> +{ 'include': 'common.json' }
> +{ 'include': 'iothrottle.json' }

Is this really necessary? Given that the top level already included
these, I think it serves more as a documentation purpose than something
you actually need.

> +
> +##
> +# @fsdev_set_io_throttle:
> +#
> +# Change I/O limits for a 9p/fsdev device.
> +#
> +# I/O limits can be enabled by setting throttle vaue to non-zero numbe=
rs.

s/vaue/value/

> +#
> +# I/O limits can be disabled by setting all of them to 0.
> +#
> +# Returns: Nothing on success
> +#          If @device is not a valid fsdev device, DeviceNotFound
> +#
> +# Since: 2.10
> +#
> +# Example:
> +#
> +# -> { "execute": "fsdev_set_io_throttle",

Please name this fsdev-set-io-throttle.  New commands should favor the
use of '-' rather than '_'.


> +##
> +# @query-fsdev-io-throttle:
> +#
> +# Return a list of information about fsdev device
> +#
> +# Returns: @FsdevIOIOThrottle

Typo in the type name, should be merely IOThrottle

> +#
> +# Since: 2.10
> +#
> +# Example:
> +#
> +# -> { "Execute": "query-fsdev-io-throttle" }

> +#
> +##
> +{ 'command': 'query-fsdev-io-throttle', 'returns': [ 'IOThrottle' ] }
> +
> diff --git a/qapi/iothrottle.json b/qapi/iothrottle.json
> new file mode 100644
> index 0000000..f7b615d
> --- /dev/null
> +++ b/qapi/iothrottle.json
> @@ -0,0 +1,93 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# =3D=3D QAPI IOThrottle definitions
> +##
> +
> +# QAPI common definitions
> +{ 'include': 'common.json' }

Again, is this necessary?


> +# @iops_size: an I/O size in bytes (Since 1.7)
> +#
> +#
> +# Since: 2.10

It's weird to state that this struct is since 2.10, but its members are
since 1.7.  Either you should list a 'since' for when the members of the
struct were first useful (0.14.0), or eliminate all the (since ...) tags
on the members and keep the overall struct at 2.10.  I'd lean towards
the former, at least if BlockDeviceInfo is properly refactored to
inherit from this type.

> +##
> +{ 'struct': 'IOThrottle',
> +  'data': { '*device': 'str', 'bps': 'int', 'bps_rd': 'int',
> +            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr=
': 'int',
> +            '*bps_max': 'int', '*bps_rd_max': 'int',
> +            '*bps_wr_max': 'int', '*iops_max': 'int',
> +            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> +            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> +            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> +            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int'=
,
> +            '*iops_size': 'int' } }

So yeah, you definitely need to split this patch.  Your FIRST patch
should be the creation of IOThrottle, and fixing BlockDeviceInfo to
inherit from it; then a later patch would be the introduction of the
fsdev throttle commands that are additional clients of the new
IOThrottle type.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--J8d5glU1sFAAedmPdPIKcoUfPet20gQd9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY09yOAAoJEKeha0olJ0NquP8H+wexhcDpDbRrSYMiehs9qO0n
u8470M6BC7ZXct+X1MnEKoERFotzicne5eCWj/aFSKGmCDRge4dMJVi/iTfMGaYr
1oeUEv96ias5Md6PMr2KUSfjC8vKzQ9M8xN7FkUknz176G5XshHs9gF7NxKhiMtG
znP569dKYLjvekSwXHH5HZ3kRrrdC221f0DHJs88mriEHiLJCwbBvUERQKdHjyex
l/YR0cpiK5+X7e17lYkoQ/hboQZWi2dz5V2wGLv4AIPO84UEWyeSn5izjufa0ynU
Sao7CMO2MNvUJfuWTa9OVTC2rGsPNI8XqkPeJu2iFESyC+N5Sj7CE8ZzbatosgY=
=Dbvk
-----END PGP SIGNATURE-----

--J8d5glU1sFAAedmPdPIKcoUfPet20gQd9--
