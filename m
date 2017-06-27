Received: from eggs.gnu.org ([2001:4830:134:3::10]:51064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPwXR-0000Un-GU
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPwXQ-0000xK-Gl
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:52:41 -0400
References: <20170616135847.17726-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0bed1851-9298-0ba5-0604-9686ca5cf569@redhat.com>
Date: Tue, 27 Jun 2017 14:52:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170616135847.17726-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jxTvrSM7dwF2v7bg3s4a1TAcEOBh56RCr"
Subject: Re: [Qemu-devel] [PATCH] iotests: Add test for failing qemu-img
 commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jxTvrSM7dwF2v7bg3s4a1TAcEOBh56RCr
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <0bed1851-9298-0ba5-0604-9686ca5cf569@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Add test for failing qemu-img
 commit
References: <20170616135847.17726-1-mreitz@redhat.com>
In-Reply-To: <20170616135847.17726-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/16/2017 08:58 AM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> In order to pass, this depends on "fix: avoid an infinite loop or a
> dangling pointer problem in img_commit"
> (http://lists.nongnu.org/archive/html/qemu-block/2017-06/msg00443.html)=


Looks like that is now 4172a003

> and on the "block: Don't compare strings in bdrv_reopen_prepare()"
> series
> (http://lists.nongnu.org/archive/html/qemu-block/2017-06/msg00424.html)=
=2E

Still pending.

> ---
>  tests/qemu-iotests/020     | 27 +++++++++++++++++++++++++++
>  tests/qemu-iotests/020.out | 17 +++++++++++++++++
>  2 files changed, 44 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
> index 7a11110..83d5ef0 100755
> --- a/tests/qemu-iotests/020
> +++ b/tests/qemu-iotests/020
> @@ -110,6 +110,33 @@ for offset in $TEST_OFFSETS; do
>      io_zero readv $(( offset + 64 * 1024 + 65536 * 4 )) 65536 65536 1
>  done
>  _check_test_img
> +_cleanup
> +TEST_IMG=3D$TEST_IMG_SAVE
> +
> +echo
> +echo 'Testing failing commit'
> +echo
> +
> +# Create an image with a null backing file to which committing will fa=
il (with
> +# ENOSPC so we can distinguish the result from some generic EIO which =
may be
> +# generated anywhere in the block layer)
> +_make_test_img -b "json:{'driver': 'raw',
> +                         'file': {
> +                             'driver': 'blkdebug',
> +                             'inject-error': [{
> +                                 'event': 'write_aio',
> +                                 'errno': 28,

Still nasty that we encoded an errno value rather than using a
stringified enum, but that's not your problem.

> +                                 'once': true
> +                             }],
> +                             'image': {
> +                                 'driver': 'null-co'
> +                             }}}"

The comment does wonders for explaining how it all works!

> +
> +# Just write anything so comitting will not be a no-op

s/comitting/committing/

With the typo fix,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jxTvrSM7dwF2v7bg3s4a1TAcEOBh56RCr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUreAAAoJEKeha0olJ0NqmiAH/j5Re/CvDeQHdoUQvQhiA0RU
CWU+QcWt0cwDMpehNBiISSm6UDEeS4PR1dOYrYDksbg11Ne5/xDmGFXPUhc7+HIF
Mv9Ucc0A+TVh02lZArcHDD52Y8p8yiclYaE/B48cGXWDVpFsGitZK2ydbU5jUmdB
YY78a/pUKRFp1PwxEmLIWStAzNgv2mvPkFFvwqwhLZvFTxnX1WtRfoxrC0Zk7YEL
ygY+01Agy4ybDgmnpGspuWpr65nOKsXmnbCULUEkebFnrAtGd8p77tCInuVv/Kiq
DxXDBJtrahf3gEt/nluWhSXOx9YIJlGlqj842Lf3BPY139qckGNkGPPMQJassjo=
=LjJx
-----END PGP SIGNATURE-----

--jxTvrSM7dwF2v7bg3s4a1TAcEOBh56RCr--
