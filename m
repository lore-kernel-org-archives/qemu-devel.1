Received: from eggs.gnu.org ([209.51.188.92]:60151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3K9H-00028w-CF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3Jqj-0003zn-JQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:16:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h3Jqj-0003zT-73
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:16:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB03D88306
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 12:07:23 +0000 (UTC)
References: <20190309004826.9027-1-lersek@redhat.com>
	<20190309004826.9027-2-lersek@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed04ad23-72c9-ce20-dc90-52b540044c13@redhat.com>
Date: Mon, 11 Mar 2019 07:07:14 -0500
MIME-Version: 1.0
In-Reply-To: <20190309004826.9027-2-lersek@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c56eNZkEdc4KHLGjjwQfpJGo1vuGmgrBL"
Subject: Re: [Qemu-devel] [PATCH 01/10] roms: lift "edk2-funcs.sh" from
 "tests/uefi-test-tools/build.sh"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c56eNZkEdc4KHLGjjwQfpJGo1vuGmgrBL
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com,
 imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <ed04ad23-72c9-ce20-dc90-52b540044c13@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/10] roms: lift "edk2-funcs.sh" from
 "tests/uefi-test-tools/build.sh"
References: <20190309004826.9027-1-lersek@redhat.com>
 <20190309004826.9027-2-lersek@redhat.com>
In-Reply-To: <20190309004826.9027-2-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/8/19 6:48 PM, Laszlo Ersek wrote:
> Extract the dense logic for architecture and toolchain massaging from
> "tests/uefi-test-tools/build.sh", to a set of small functions. We'll re=
use
> these functions for building full platform firmware images.
>=20
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  roms/edk2-funcs.sh             | 240 ++++++++++++++++++++
>  tests/uefi-test-tools/build.sh |  97 +-------
>  2 files changed, 246 insertions(+), 91 deletions(-)
>=20
> diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
> new file mode 100644
> index 000000000000..908c7665c6ed
> --- /dev/null
> +++ b/roms/edk2-funcs.sh
> @@ -0,0 +1,240 @@
> +# Shell script that defines functions for determining some environment=
al

No #! line, so this runs with /bin/sh, which might not be bash.  However,=
=2E..

> +# characteristics for the edk2 "build" utility.
> +#
> +# This script is meant to be sourced.
> +#
> +# Copyright (C) 2019, Red Hat, Inc.

I don't usually put a comma after the year.


> +# Parameters:
> +#   $1: QEMU system emulation target
> +qemu_edk2_verify_arch()
> +{
> +  local emulation_target=3D"$1"
> +  local program_name=3D$(basename -- "$0")

=2E..local is a bashism, not present in all /bin/sh implementations.  The=
n
again...

> +++ b/tests/uefi-test-tools/build.sh
> @@ -38,97 +38,12 @@ if [ $ret -ne 0 ]; then

build.sh is already marked as a bash script, and...

> +# Fetch some option arguments, and set the cross-compilation environme=
nt (if
> +# any), for the edk2 "build" utility.
> +source "$edk2_dir/../edk2-funcs.sh"

you are only ever sourcing the file, rather than directly executing it
as a standalone script. I'd update the comments to mention that the file
is meant to be sourced.  (By the way, 'source' is also a bashism, the
portable spelling is '.').

So nothing jumped out at me as a potential shell script trap, although I
did not closely review the logic.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--c56eNZkEdc4KHLGjjwQfpJGo1vuGmgrBL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyGT3IACgkQp6FrSiUn
Q2r0qQf/ecMZLcJUmLnnTcSwZP3ifCIzWPYRiARp1Wzgzr1inX1kKBlVF2euS5Tt
6zRobnNuTWi4RiEFrnpzpLVA4FDdanmPBiRz3j25BIyZdGEN3+w065JV8vb4d0Zt
rp0p4jPipsXjvAik0NQJjDHF0bkz23esiEuwcDXl7wYCWEmSr6/eMY3r8Kfnfwxr
G585pi/4A+m3vABQ2+4ZR7jdevFsqTPgAgNR4By9PnAuCP2H89joGfRnTf9mGqhO
dGmAjvL19ni835Czzznpc/n11e8fQvNwJ4QzXoPHL4ixdREtMu0nhLsx4fw6T/H2
lL9YpjKPUROJwTKxisG5ZhKMXa+Gpw==
=X8N4
-----END PGP SIGNATURE-----

--c56eNZkEdc4KHLGjjwQfpJGo1vuGmgrBL--
