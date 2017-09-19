Received: from eggs.gnu.org ([2001:4830:134:3::10]:54066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duKAT-00061p-EW
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duKAP-0000l8-1K
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:10:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duKAO-0000kG-Oc
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:10:28 -0400
References: <20170919072719.11815-1-famz@redhat.com>
	<20170919072719.11815-4-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4ffe9274-996f-8e16-4b79-583e54b17f54@redhat.com>
Date: Tue, 19 Sep 2017 10:10:19 -0500
MIME-Version: 1.0
In-Reply-To: <20170919072719.11815-4-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BRaraGGsFrKUV3uHfItp1A11kDV4wA0IO"
Subject: Re: [Qemu-devel] [PATCH v9 03/13] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BRaraGGsFrKUV3uHfItp1A11kDV4wA0IO
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>,
 stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <4ffe9274-996f-8e16-4b79-583e54b17f54@redhat.com>
Subject: Re: [PATCH v9 03/13] scripts: Add archive-source.sh
References: <20170919072719.11815-1-famz@redhat.com>
 <20170919072719.11815-4-famz@redhat.com>
In-Reply-To: <20170919072719.11815-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 02:27 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  scripts/archive-source.sh | 46 +++++++++++++++++++++++++++++++++++++++=
+++++++
>  1 file changed, 46 insertions(+)
>  create mode 100755 scripts/archive-source.sh
>=20
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> new file mode 100755
> index 0000000000..e155d980ee
> --- /dev/null
> +++ b/scripts/archive-source.sh
> @@ -0,0 +1,46 @@
> +#!/bin/sh

Needs to be /bin/bash...

> +        git ls-files || error "git ls-files failed"
> +        for sm in $submodules; do
> +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> +            if test ${PIPESTATUS[0]} -ne 0 -o $? -ne 0; then
> +                error "git ls-files in submodule $sm failed"

=2E..because $PIPESTATUS is a useful bashism not present in dash, where
the alternative is MUCH more verbose and painful to write in portable she=
ll.

With just that fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

If desired, one other change (not mandatory, but if you want to do it,
I'll want to re-review):

> +
> +tar -cf "$1" -T "$1".list || error "failed to create tar file"

If we exit here, $1.list is not removed...

> +rm "$1".list

Should we make removal of the list be controlled by a cleanup trap, to
always happen even if something else fails in the interim?  Or is
leaving it around on failure useful for debugging?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BRaraGGsFrKUV3uHfItp1A11kDV4wA0IO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEyBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBM1sACgkQp6FrSiUn
Q2ryZgf43mgYaNGiIM1bA4ICtMprbB52VRGehxowjdhNL6JeRo/ea3D2mULWQOUh
7Pe9IiJT0HaywkeCWRw2K23NIFnMKuoBlyhkx+MqZkPQ4rgJd1ow0q5ieRHkLtdY
wPf9PSNfyGsjWIzrBLdUWmBXQaRKDhLTwINzbsura6HD+nqMpDrxlH2KFOXJUvL9
nlWXKCCiVJGskfOJOKOmZNR4x1a7ygyuhK0l04phuauo8TofTEX/oPiB4xSnP96r
6a0U6RHqJcR3xPf48pSV68UzdM168gsNq8PXh/Y+tHZtIl88Jc+PtX8dsyPHBq4a
JuLc9YSyyZW4VTmgb4wmFIX2rbqq
=pPJB
-----END PGP SIGNATURE-----

--BRaraGGsFrKUV3uHfItp1A11kDV4wA0IO--
