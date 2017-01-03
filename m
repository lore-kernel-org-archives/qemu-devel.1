Received: from eggs.gnu.org ([2001:4830:134:3::10]:57814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOUPW-0002QY-7m
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOUPV-0002SE-7N
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:06:14 -0500
References: <20170103170459.27662-1-berrange@redhat.com>
	<20170103170459.27662-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <830c4bc8-74ca-32fb-2fa7-2a295124c9d5@redhat.com>
Date: Tue, 3 Jan 2017 13:06:05 -0600
MIME-Version: 1.0
In-Reply-To: <20170103170459.27662-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bw2NIkq3rFTIi87E0VhSAvpaLml6cAhXC"
Subject: Re: [Qemu-devel] [PATCH v2 2/5] iotests: fix remainining tests to
 work with LUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bw2NIkq3rFTIi87E0VhSAvpaLml6cAhXC
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <830c4bc8-74ca-32fb-2fa7-2a295124c9d5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] iotests: fix remainining tests to
 work with LUKS
References: <20170103170459.27662-1-berrange@redhat.com>
 <20170103170459.27662-3-berrange@redhat.com>
In-Reply-To: <20170103170459.27662-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2017 11:04 AM, Daniel P. Berrange wrote:
> The tests 033, 120, 140, 145 and 157 were all broken
> when run with LUKS, since they did not correctly use
> the required image opts args syntax to specify the
> decryption secret.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

> +++ b/tests/qemu-iotests/120
> @@ -44,17 +44,36 @@ _supported_os Linux
> =20
>  _make_test_img 64M
> =20
> +if test "$IMGOPTSSYNTAX" =3D "true"
> +then
> +    SYSEMU_DRIVE_ARG=3Did=3Ddrv,if=3Dnone,$TEST_IMG
> +    SYSEMU_EXTRA_ARGS=3D""
> +    IO_DRIVE_ARG=3D"$TEST_IMG"
> +    IO_EXTRA_ARGS=3D"--image-opts"
> +    if [ -n "$IMGKEYSECRET" ]; then
> +	SECRET_ARG=3D"secret,id=3Dkeysec0,data=3D$IMGKEYSECRET"
> +	SYSEMU_EXTRA_ARGS=3D"$SYSEMU_EXTRA_ARGS -object $SECRET_ARG"

Should we favor the '--object' spelling rather than '-object'?  But both
work (thanks to getopt_long_only()), so I'm not going to demand a respin.=


> +	IO_EXTRA_ARGS=3D"$IO_EXTRA_ARGS --object $SECRET_ARG"
> +    fi
> +else
> +    SYSEMU_DRIVE_ARG=3Did=3Ddrv,if=3Dnone,file=3D"$TEST_IMG",driver=3D=
raw,file.driver=3D$IMGFMT
> +    SYSEMU_EXTRA_ARGS=3D""
> +    IO_DRIVE_ARG=3D"json:{'driver': 'raw', 'file': {'driver': '$IMGFMT=
', 'file': {'filename': '$TEST_IMG'}}}"
> +    IO_EXTRA_ARGS=3D""
> +fi
> +
> +
>  echo "{'execute': 'qmp_capabilities'}
>        {'execute': 'human-monitor-command',
>         'arguments': {'command-line': 'qemu-io drv \"write -P 42 0 64k\=
"'}}
>        {'execute': 'quit'}" \
> -    | $QEMU -qmp stdio -nographic -nodefaults \
> -            -drive id=3Ddrv,if=3Dnone,file=3D"$TEST_IMG",driver=3Draw,=
file.driver=3D$IMGFMT \
> +    | $QEMU -qmp stdio -nographic -nodefaults $SYSEMU_EXTRA_ARGS \
> +            -drive $SYSEMU_DRIVE_ARG \
>      | _filter_qmp | _filter_qemu_io
>  $QEMU_IO -c 'read -P 42 0 64k' "$TEST_IMG" | _filter_qemu_io
> =20
>  $QEMU_IO_PROG -c 'read -P 42 0 64k' \
> -    "json:{'driver': 'raw', 'file': {'driver': '$IMGFMT', 'file': {'fi=
lename': '$TEST_IMG'}}}" \
> +    $IO_EXTRA_ARGS "$IO_DRIVE_ARG" \
>      | _filter_qemu_io
> =20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--bw2NIkq3rFTIi87E0VhSAvpaLml6cAhXC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa/YdAAoJEKeha0olJ0NqYSoIAJ03JGcZGL1o8skRjaRANQ0P
nOaBKW359rrDQJQZuy1coZlJlWtX/dZ9mF1+VaRtADpLH6KvnWaH6t6FfS3Vy7yT
Oq+bdn0oXW5NNhT8UhL8906MxuNPqiH/s7EBnxNJUbBKlGGxszjn8AAT5Y+8vDTZ
DVQkX13r+Jrvp/d+x7pp9lBlJfLoCWfFL1o//vyR9V4YbgnqBVtGqLphFiKigZ+b
chPb/KBUocj5rfyu9ZzGYeEuSlFbTPWGJGAzvG8euVEBK2uc/8ISNDgF9feW0JZV
WAWVyE7eWJyff5LdBF81c2nZVgQfkBidh5YkwL6Ap11bOU987OBrc1OiIzUR4/0=
=VGFV
-----END PGP SIGNATURE-----

--bw2NIkq3rFTIi87E0VhSAvpaLml6cAhXC--
