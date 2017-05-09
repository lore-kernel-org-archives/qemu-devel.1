Received: from eggs.gnu.org ([2001:4830:134:3::10]:49228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d89Gz-00020f-WC
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d89Gy-0000lI-WD
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:50:10 -0400
References: <20170509173342.29286-1-berrange@redhat.com>
	<20170509173342.29286-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2fb7fbe5-519a-232c-a1fd-03f690e41572@redhat.com>
Date: Tue, 9 May 2017 12:49:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170509173342.29286-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hq2Geq9SxdtKNaqiMQw6S6CPMr1eduDVD"
Subject: Re: [Qemu-devel] [PATCH v5 2/5] iotests: fix remainining tests to
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
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hq2Geq9SxdtKNaqiMQw6S6CPMr1eduDVD
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <2fb7fbe5-519a-232c-a1fd-03f690e41572@redhat.com>
Subject: Re: [PATCH v5 2/5] iotests: fix remainining tests to work with LUKS
References: <20170509173342.29286-1-berrange@redhat.com>
 <20170509173342.29286-3-berrange@redhat.com>
In-Reply-To: <20170509173342.29286-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 12:33 PM, Daniel P. Berrange wrote:
> The tests 033, 140, 145 and 157 were all broken
> when run with LUKS, since they did not correctly use
> the required image opts args syntax to specify the
> decryption secret. Further, the 120 test simply does
> not make sense to run with luks, as the scenario
> exercised is not relevant.
>=20
> The test 181 was broken when run with LUKS because
> it didn't take account of fact that $TEST_IMG was
> already in image opts syntax. The launch_qemu
> helper also didn't register the secret object
> providing the LUKS password.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

> +++ b/tests/qemu-iotests/145
> @@ -43,8 +43,23 @@ _supported_proto generic
>  _supported_os Linux
> =20
>  _make_test_img 1M
> -echo quit | $QEMU -nographic -hda "$TEST_IMG" -incoming 'exec:true' -s=
napshot -serial none -monitor stdio |
> -    _filter_qemu | _filter_hmp
> +
> +if test "$IMGOPTSSYNTAX" =3D "true"
> +then
> +    SYSEMU_DRIVE_ARG=3Dif=3Dnone,$TEST_IMG
> +    SYSEMU_EXTRA_ARGS=3D""
> +    if [ -n "$IMGKEYSECRET" ]; then
> +	SECRET_ARG=3D"secret,id=3Dkeysec0,data=3D$IMGKEYSECRET"
> +	SYSEMU_EXTRA_ARGS=3D"-object $SECRET_ARG"
> +    fi
> +else
> +    SYSEMU_DRIVE_ARG=3Dif=3Dnone,file=3D"$TEST_IMG",driver=3D$IMGFMT
> +    SYSEMU_EXTRA_ARGS=3D""
> +fi
> +
> +echo quit | $QEMU -nographic $SYSEMU_EXTRA_ARGS  -drive $SYSEMU_DRIVE_=
ARG \

2 spaces before -drive looks a bit odd, but not a showstopper.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Hq2Geq9SxdtKNaqiMQw6S6CPMr1eduDVD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEgFGAAoJEKeha0olJ0Nqz44H/3p/VczZap4SEd2VLLWK+Psb
EmaH7PYldj8YzrJmtEMkUnRJm0DYBqjlBdjIE4QqYBwCPy5B4fpi9fSp6LMH9v5x
w3ntauqEd0nA2Bw9Uun4Alek4UL3hSK8t+0U+rOwY4jiZkkm01cfzUHDJO/c6D8V
JMCdMsq9Ntp51vmEfooC6AeiFVqPjcPbGJgZOQJBEaE307nz31oCO8vD5o6rzF/C
37pl7JIkKGNeIuJ5ielu/9NjTroKufp39Q9pTs8uiNjJ04sAlBIul+I19uX48BhO
mU3aw/eL8DnLJtte3gCjGKmbp1ABxiVWUkjxtdH5UyjNKCYuwy0tM9b5ET58OT8=
=xp5r
-----END PGP SIGNATURE-----

--Hq2Geq9SxdtKNaqiMQw6S6CPMr1eduDVD--
