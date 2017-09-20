Received: from eggs.gnu.org ([2001:4830:134:3::10]:42740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dufC7-0003Mw-MH
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duevI-0005Ef-Rs
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:21:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duevH-00058V-33
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:20:15 -0400
References: <20170920032555.18911-1-famz@redhat.com>
	<20170920032555.18911-4-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <91d27127-b1ba-0922-7d08-44782d277501@redhat.com>
Date: Wed, 20 Sep 2017 08:20:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170920032555.18911-4-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VuEX8d3qJhkND9EAFbfX5q344u3FL0Slv"
Subject: Re: [Qemu-devel] [PATCH v10 03/13] scripts: Add archive-source.sh
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
--VuEX8d3qJhkND9EAFbfX5q344u3FL0Slv
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>,
 stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <91d27127-b1ba-0922-7d08-44782d277501@redhat.com>
Subject: Re: [PATCH v10 03/13] scripts: Add archive-source.sh
References: <20170920032555.18911-1-famz@redhat.com>
 <20170920032555.18911-4-famz@redhat.com>
In-Reply-To: <20170920032555.18911-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 10:25 PM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  scripts/archive-source.sh | 51 +++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100755 scripts/archive-source.sh
>=20

> +
> +if test -n "$submodules"; then
> +    {
> +        git ls-files || error "git ls-files failed"
> +        for sm in $submodules; do
> +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> +            if test ${PIPESTATUS[0]} -ne 0 -o $? -ne 0; then

This relies on 'test ... -o ...' which is non-portable.  It "works"
because there is no possible ambiguity in the contents of $PIPESTATUS
that could cause a different parse of the test arguments, but I tend to
discourage any use of -a/-o inside test on principle.  Sadly, writing:

if test ${PIPESTATUS[0]} -ne 0 || test $? -ne 0

has a flaw that $? is no longer what you want, at which point you would
have to introduce a temporary variable.  But we're using bash, so you
can instead write this as:

if test "${PIPESTATUS[@]}" !=3D "0 0"; then

> +                error "git ls-files in submodule $sm failed"
> +            fi
> +        done
> +    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > =
"$1".list
> +else
> +    git ls-files > "$1".list
> +fi

At this point, $1.list has been created, even if commands failed...

> +
> +if test $? -ne 0; then
> +    error "failed to generate list file"
> +fi

=2E..but this exits without cleanup.  If we really want it cleaned no
matter what, it's probably better to do:

trap "status=3D$?; rm -f "$1".list; exit \$status" 0 1 2 3 15

earlier than anything that can create the file.

> +
> +tar -cf "$1" -T "$1".list
> +status=3D$?
> +rm "$1".list
> +if test $statue -ne 0; then

Umm, $statue is not the same as $status.

> +    error "failed to create tar file"
> +fi
> +exit 0
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VuEX8d3qJhkND9EAFbfX5q344u3FL0Slv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCawMACgkQp6FrSiUn
Q2qcSAf+OPf41cl66dGLIMxjtWiXKST2p2CcfNhj6dsnCEjjmKw7pLLhkHX5jta2
OuKH02+b4sh9ZSRlUkVrRPqVjaoAWotZla35vo92xoQ4XSkgVxfEPHXEpbaW6ZEy
OALseScG0hH5yKMYQSk/IVqxrlMnpQLcVm5WE6gFw0e6NlS99or57N8Qox6iwjJy
PG3r6XRdqDg4XQRM7YZBvjpQEUO3GYNH66Ed7T8Ov0EiChiJ7ZKCfbfNrUgpcdOq
TbSqmxMAxcHMgV40k8fp9tI99vRpUzBjiUN96NlHHKgQoVtJaWKv8vHLsopeuYqH
039Hs48tTErUngbJvQSp2Lq+6EUu7Q==
=8umn
-----END PGP SIGNATURE-----

--VuEX8d3qJhkND9EAFbfX5q344u3FL0Slv--
