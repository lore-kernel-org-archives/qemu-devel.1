Received: from eggs.gnu.org ([2001:4830:134:3::10]:59903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d65Cx-0002x2-Jr
	for qemu-devel@nongnu.org; Wed, 03 May 2017 21:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d65Cw-0003vI-IA
	for qemu-devel@nongnu.org; Wed, 03 May 2017 21:05:27 -0400
References: <20170503231120.23507-1-mreitz@redhat.com>
	<20170503231120.23507-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c7d49aa6-3009-577e-22ff-e13ed177710b@redhat.com>
Date: Wed, 3 May 2017 20:05:19 -0500
MIME-Version: 1.0
In-Reply-To: <20170503231120.23507-5-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D1g3LEXtVF6mF156ttapSI1iFMpRsGtJa"
Subject: Re: [Qemu-devel] [PATCH 4/4] iotests: Extend test 066
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
--D1g3LEXtVF6mF156ttapSI1iFMpRsGtJa
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <c7d49aa6-3009-577e-22ff-e13ed177710b@redhat.com>
Subject: Re: [PATCH 4/4] iotests: Extend test 066
References: <20170503231120.23507-1-mreitz@redhat.com>
 <20170503231120.23507-5-mreitz@redhat.com>
In-Reply-To: <20170503231120.23507-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/03/2017 06:11 PM, Max Reitz wrote:
> 066 was supposed to be a test "for discarding preallocated zero
> clusters", but it did so incompletely: While it did check the image
> file's integrity after the operation, it did not confirm that the
> clusters are indeed freed. This patch adds this test.
>=20
> In addition, new cases for writing to preallocated zero clusters are
> added.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/066     | 128 +++++++++++++++++++++++++++++++++++++=
+++++++-
>  tests/qemu-iotests/066.out |  46 ++++++++++++++++
>  2 files changed, 173 insertions(+), 1 deletion(-)
>=20
> @@ -55,8 +55,134 @@ _make_test_img $IMG_SIZE
>  $QEMU_IO -c "write 0 256k" -c "write -z 0 256k" -c "write 64M 512" \
>  	 -c "discard 0 $IMG_SIZE" -c "read -P 0 0 $IMG_SIZE" "$TEST_IMG" \
>           | _filter_qemu_io
> +
>  # Check the image (there shouldn't be any leaks)
>  _check_test_img
> +# Map the image (we want all clusters to be gone)
> +$QEMU_IMG map "$TEST_IMG"

The human-readable qemu-img map ignores allocated but reads-as-zeros
clusters.  Maybe it shouldn't, but only --output=3Djson does the right
thing (actually, even then it doesn't, without my pending patch that I
am rebasing on top of your series [1]).

But I think this is sufficient for test 66, since I'm adding more tests
in my pending series.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05224.html


> +# Create three normal clusters
> +$QEMU_IO -c 'write -P 42 0 192k' "$TEST_IMG" | _filter_qemu_io
> +orig_map=3D$($QEMU_IMG map --output=3Djson "$TEST_IMG")
> +
> +# Make the middle cluster a preallocated zero cluster
> +$QEMU_IO -c 'write -z 64k 64k' "$TEST_IMG" | _filter_qemu_io
> +
> +# Try to overwrite everything: This should reuse the whole range. To t=
est that
> +# this only issues a single continuous write request, use blkdebug.
> +$QEMU_IO -c 'write -P 42 0 192k' \
> +    "json:{
> +        'driver': '$IMGFMT',
> +        'file': {
> +            'driver': 'blkdebug',
> +            'image.filename': '$TEST_IMG',
> +            'set-state': [{
> +                'event': 'write_aio',
> +                'new_state': 2
> +            }],
> +            'inject-error': [{
> +                'event': 'write_aio',
> +                'state': 2
> +            }]
> +        }
> +    }" \
> +    | _filter_qemu_io

blkdebug is cool!

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--D1g3LEXtVF6mF156ttapSI1iFMpRsGtJa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCn5PAAoJEKeha0olJ0NqJnkH/iOKrMHxDsZV0hV5rNWVcNkg
5c/2DS0sf2mThwS0EGfLAMzelDiUBrm0zFCcijabdQ139FzevzVijZ2esS7tgIMZ
JGFnN9cf1hSKQN2DzLnVIAC5fnKG8mwNJ5R6JunsVWyY3PKzsm3cghHYoBLeKaS5
Axousri6dGLT1LPRxg1RJQnwr/x27JAfTUHaYIujcgsXyMR5QL8MUdJbcpplqWx8
HjE3wmowbM6T6Eio1aHX4Oyf1d1fnOSqoLRXYlbmw7uUA/GpCZRq5hK+naZ0uVOU
haTMrXA0M/ju+7ibb2flJF2uj4vUHNGRwoAY7MZaAt0JTmLPbKtXywkOe31axdM=
=HVqg
-----END PGP SIGNATURE-----

--D1g3LEXtVF6mF156ttapSI1iFMpRsGtJa--
