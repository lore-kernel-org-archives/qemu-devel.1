Received: from eggs.gnu.org ([2001:4830:134:3::10]:35488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dR1rV-0001bE-Te
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dR1rV-0005QO-3R
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:45:53 -0400
References: <20170621133023.27627-1-mreitz@redhat.com>
	<20170621133023.27627-2-mreitz@redhat.com>
	<748b90f3-8f89-59ea-4a65-69e938747c0b@redhat.com>
	<6179c9e2-5486-0ff6-927d-da144c178e93@redhat.com>
	<7fa30bfe-d1b4-0aeb-b90e-ae91f9467749@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f1395eb6-46a4-9982-d625-626faac61ae3@redhat.com>
Date: Fri, 30 Jun 2017 14:45:46 -0500
MIME-Version: 1.0
In-Reply-To: <7fa30bfe-d1b4-0aeb-b90e-ae91f9467749@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KraNQb3b8VOeqq00D9kvHs1fHwDOAh1uA"
Subject: Re: [Qemu-devel] [PATCH v4 1/2] iotests: Use absolute paths for
 executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KraNQb3b8VOeqq00D9kvHs1fHwDOAh1uA
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <f1395eb6-46a4-9982-d625-626faac61ae3@redhat.com>
Subject: Re: [PATCH v4 1/2] iotests: Use absolute paths for executables
References: <20170621133023.27627-1-mreitz@redhat.com>
 <20170621133023.27627-2-mreitz@redhat.com>
 <748b90f3-8f89-59ea-4a65-69e938747c0b@redhat.com>
 <6179c9e2-5486-0ff6-927d-da144c178e93@redhat.com>
 <7fa30bfe-d1b4-0aeb-b90e-ae91f9467749@redhat.com>
In-Reply-To: <7fa30bfe-d1b4-0aeb-b90e-ae91f9467749@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/30/2017 02:41 PM, Eric Blake wrote:

> +++ 068.out.bad	2017-06-30 14:35:28.720241398 -0500
> @@ -1,4 +1,5 @@
>  QA output created by 068
> +realpath: '': No such file or directory
>=20
> The culprit? $QEMU_VXHS_PROG is empty for me, which means `set_prog_pat=
h
> qnio_server` found nothing to use.  You'll have to add in a safety valv=
e
> that only calls 'type' if operating on a non-empty path in the first pl=
ace.

I'm using this locally, in the meantime:

diff --git i/tests/qemu-iotests/common.config
w/tests/qemu-iotests/common.config
index c1dc425..6f97331 100644
--- i/tests/qemu-iotests/common.config
+++ w/tests/qemu-iotests/common.config
@@ -107,7 +107,9 @@ export QEMU_PROG=3D$(realpath -- "$(type -p
"$QEMU_PROG")")
 export QEMU_IMG_PROG=3D$(realpath -- "$(type -p "$QEMU_IMG_PROG")")
 export QEMU_IO_PROG=3D$(realpath -- "$(type -p "$QEMU_IO_PROG")")
 export QEMU_NBD_PROG=3D$(realpath -- "$(type -p "$QEMU_NBD_PROG")")
-export QEMU_VXHS_PROG=3D$(realpath -- "$(type -p "$QEMU_VXHS_PROG")")
+if [ -n "$QEMU_VXHS_PROG" ]; then
+    export QEMU_VXHS_PROG=3D$(realpath -- "$(type -p "$QEMU_VXHS_PROG")"=
)
+fi

 _qemu_wrapper()
 {


Is qnio_server easily available for Fedora?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KraNQb3b8VOeqq00D9kvHs1fHwDOAh1uA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVqpqAAoJEKeha0olJ0NqIA0IAIYo129mFw/3ttwh8YZxmc05
IqZXHmldWKLN6KZxPsWrdfpYwfXuvRb1jq/BapGYVzIxuxVWSfMEMW4ECt7qOltc
DRAtdJ8ez5hOqOBL839mJUizwdCugxJ2ug9Is+Qps2l9dFGOAzAIhuhWCw2hBedK
cDDe/jq5O1ZyXdb6XImbb7iGS7u6sVxqyBPdzMsHvCEJJZ5b4hlsCH2ldSk6Eqi0
cbHW5A4YosP7glb2lPUkd7CiXqGtW6Q9GQqVA1QxX0fvqAN+44vOaAkHnlqG5pDn
11Icp+nxknh7IxCufoiyUIAiErQ7sa1GyTU62vxwJrwe+/SiNIPbjSnL/Qjfd8A=
=DEnb
-----END PGP SIGNATURE-----

--KraNQb3b8VOeqq00D9kvHs1fHwDOAh1uA--
