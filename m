Received: from eggs.gnu.org ([2001:4830:134:3::10]:52941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG5cx-0004qh-5S
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG5cv-0005DH-Tg
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:33:39 -0400
References: <20170509173342.29286-1-berrange@redhat.com>
	<20170509173342.29286-3-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f7fef0e4-7703-9b60-3bd9-bf1b12628cae@redhat.com>
Date: Wed, 31 May 2017 17:33:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170509173342.29286-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lh2Wm9Kuph0pnncB6d21X11aUQbkiP8kx"
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
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lh2Wm9Kuph0pnncB6d21X11aUQbkiP8kx
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <f7fef0e4-7703-9b60-3bd9-bf1b12628cae@redhat.com>
Subject: Re: [PATCH v5 2/5] iotests: fix remainining tests to work with LUKS
References: <20170509173342.29286-1-berrange@redhat.com>
 <20170509173342.29286-3-berrange@redhat.com>
In-Reply-To: <20170509173342.29286-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-09 19:33, Daniel P. Berrange wrote:
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
>  tests/qemu-iotests/033         | 12 ++++++++++--
>  tests/qemu-iotests/120         |  1 +
>  tests/qemu-iotests/140         | 11 ++++++++++-
>  tests/qemu-iotests/145         | 19 +++++++++++++++++--
>  tests/qemu-iotests/157         | 17 ++++++++++++++---
>  tests/qemu-iotests/157.out     | 16 ++++++++--------
>  tests/qemu-iotests/174         |  2 +-
>  tests/qemu-iotests/181         | 21 ++++++++++++++++-----
>  tests/qemu-iotests/common.qemu |  9 +++++++--
>  9 files changed, 84 insertions(+), 24 deletions(-)

[...]

> diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
> index 8c80a5a..0a2105c 100755
> --- a/tests/qemu-iotests/140
> +++ b/tests/qemu-iotests/140
> @@ -52,8 +52,17 @@ _make_test_img 64k
> =20
>  $QEMU_IO -c 'write -P 42 0 64k' "$TEST_IMG" | _filter_qemu_io
> =20
> +if test "$IMGOPTSSYNTAX" =3D "true"
> +then
> +    SYSEMU_DRIVE_ARG=3Dif=3Dnone,media=3Dcdrom,id=3Ddrv,$TEST_IMG

I would like to propose wrapping this (or at least $TEST_IMG) in quotes,
but I'm aware of the fact that the whole test environment breaks if you
have a TEST_DIR with whitespace in it, so I don't mind...

(But it is a bit weird to put $TEST_IMG into quotes below and then use
$SYSEMU_DRIVE_ARG unquoted.)

> +    SYSEMU_EXTRA_ARGS=3D""
> +else
> +    SYSEMU_DRIVE_ARG=3Dif=3Dnone,media=3Dcdrom,id=3Ddrv,file=3D"$TEST_=
IMG",driver=3D$IMGFMT
> +    SYSEMU_EXTRA_ARGS=3D""
> +fi
> +
>  keep_stderr=3Dy \
> -_launch_qemu -drive if=3Dnone,media=3Dcdrom,id=3Ddrv,file=3D"$TEST_IMG=
",format=3D$IMGFMT \
> +_launch_qemu $SYSEMU_EXTRA_ARGS -drive $SYSEMU_DRIVE_ARG \

But could you drop the $SYSEMU_EXTRA_ARGS? It doesn't seem to serve a
purpose (anymore, now that you added this to _launch_qemu itself).

>      2> >(_filter_nbd)
> =20
>  _send_qemu_cmd $QEMU_HANDLE \
> diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
> index e6c6bc4..9cfa940 100755
> --- a/tests/qemu-iotests/145
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

Please use spaces instead of tabs.

(I know there are a lot of tabs in the test files already, but according
to CODING_STYLE, that is just wrong.)

> +    fi
> +else
> +    SYSEMU_DRIVE_ARG=3Dif=3Dnone,file=3D"$TEST_IMG",driver=3D$IMGFMT
> +    SYSEMU_EXTRA_ARGS=3D""
> +fi
> +
> +echo quit | $QEMU -nographic $SYSEMU_EXTRA_ARGS  -drive $SYSEMU_DRIVE_=
ARG \
> +                  -incoming 'exec:true' -snapshot -serial none -monito=
r stdio \
> +          | _filter_qemu | _filter_hmp
> =20
>  # success, all done
>  echo "*** done"
> diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
> index 8d939cb..f5d22fa 100755
> --- a/tests/qemu-iotests/157
> +++ b/tests/qemu-iotests/157
> @@ -43,7 +43,6 @@ _supported_os Linux
> =20
>  function do_run_qemu()
>  {
> -    echo Testing: "$@"
>      (
>          if ! test -t 0; then
>              while read cmd; do
> @@ -63,7 +62,18 @@ function run_qemu()
> =20
> =20
>  size=3D128M
> -drive=3D"if=3Dnone,file=3D$TEST_IMG,driver=3D$IMGFMT"
> +if test "$IMGOPTSSYNTAX" =3D "true"
> +then
> +    SYSEMU_DRIVE_ARG=3Dif=3Dnone,$TEST_IMG
> +    SYSEMU_EXTRA_ARGS=3D""
> +    if [ -n "$IMGKEYSECRET" ]; then
> +	SECRET_ARG=3D"secret,id=3Dkeysec0,data=3D$IMGKEYSECRET"
> +	SYSEMU_EXTRA_ARGS=3D"-object $SECRET_ARG"

s/\t/    /g

> +    fi
> +else
> +    SYSEMU_DRIVE_ARG=3Dif=3Dnone,file=3D"$TEST_IMG",driver=3D$IMGFMT
> +    SYSEMU_EXTRA_ARGS=3D""
> +fi
> =20
>  _make_test_img $size
> =20
> @@ -76,8 +86,9 @@ echo
> =20
>  for cache in "writeback" "writethrough"; do
>      for wce in "" ",write-cache=3Dauto" ",write-cache=3Don" ",write-ca=
che=3Doff"; do
> +        echo "Testing: cache=3D'$cache' wce=3D'$wce'"
>          echo "info block" \
> -            | run_qemu -drive "$drive,cache=3D$cache" \
> +            | run_qemu $SYSEMU_EXTRA_ARGS -drive "$SYSEMU_DRIVE_ARG,ca=
che=3D$cache" \
>                         -device "virtio-blk,drive=3Dnone0$wce" \
>              | grep -e "Testing" -e "Cache mode"
>      done

[...]

> index e969a2a..71a3b21 100755
> --- a/tests/qemu-iotests/181
> +++ b/tests/qemu-iotests/181
> @@ -55,13 +55,24 @@ echo
> =20
>  qemu_comm_method=3D"monitor"
> =20
> -_launch_qemu \
> -    -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFMT,=
id=3Ddisk
> +if [ "$IMGOPTSSYNTAX" =3D "true" ]; the> +  _launch_qemu \

More coding style nit picks: This should be indented with four spaces.

With the style fixed (and maybe Eric's comment addressed) or an explicit
"CODING_STYLE has no power over me!" statement, and with
SYSEMU_EXTRA_ARGS dropped above:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +      -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk
> +else
> +  _launch_qemu \
> +      -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFM=
T,id=3Ddisk
> +fi
>  src=3D$QEMU_HANDLE
> =20
> -_launch_qemu \
> -    -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFMT,=
id=3Ddisk \
> -    -incoming "unix:${MIG_SOCKET}"
> +if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
> +  _launch_qemu \
> +      -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk \
> +      -incoming "unix:${MIG_SOCKET}"
> +else
> +  _launch_qemu \
> +      -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFM=
T,id=3Ddisk \
> +      -incoming "unix:${MIG_SOCKET}"
> +fi
>  dest=3D$QEMU_HANDLE
> =20
>  echo


--lh2Wm9Kuph0pnncB6d21X11aUQbkiP8kx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLuJGEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJbG
B/wJFV9oV7jKEtBHWy+fUqzLYCWHflMJBOtoQEyfrlj3Lik9d3F63UKTtL7X4HnV
igEMvsVeHPOLQ/ytzyoN4iTdPEkE+yMQY3+ucHos2wtQJfW2rUizxq/HxbXKkpp1
zdexhgZOJ0Qro5w4eyduCLdBx5zxeKuxz9l8c8Hee0LD8v3AppwzVZD1y4kCPaSu
LMCJCclOS13/6jnmJclQZygYxsW6vbYr42VdjmRcPbkOq4FX2E2IQUe8fb8dmemt
1lTN84OYuyYWhJCQxtAguUojErmKA/FUE4+L2zwQpIXn+35+tFY6+OBX1+Mi1rLh
CPdN/zFS5Dd/0Aoxj0l8J4iI
=LQZK
-----END PGP SIGNATURE-----

--lh2Wm9Kuph0pnncB6d21X11aUQbkiP8kx--
