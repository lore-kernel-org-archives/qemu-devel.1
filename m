Received: from eggs.gnu.org ([2001:4830:134:3::10]:35289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cciN4-0000uT-7I
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 19:50:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cciN1-0000fp-0y
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 19:50:30 -0500
References: <20170124115748.21473-1-berrange@redhat.com>
	<20170124115748.21473-3-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4934e07a-152d-ed82-53fa-08644f087d9c@redhat.com>
Date: Sun, 12 Feb 2017 01:50:09 +0100
MIME-Version: 1.0
In-Reply-To: <20170124115748.21473-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Iwa3dWiVDF6KevCC6n0Ou1hd1cl7kAK7t"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] iotests: fix remainining tests to
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Iwa3dWiVDF6KevCC6n0Ou1hd1cl7kAK7t
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <4934e07a-152d-ed82-53fa-08644f087d9c@redhat.com>
Subject: Re: [PATCH v3 2/5] iotests: fix remainining tests to work with LUKS
References: <20170124115748.21473-1-berrange@redhat.com>
 <20170124115748.21473-3-berrange@redhat.com>
In-Reply-To: <20170124115748.21473-3-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 24.01.2017 12:57, Daniel P. Berrange wrote:
> The tests 033, 120, 140, 145 and 157 were all broken
> when run with LUKS, since they did not correctly use
> the required image opts args syntax to specify the
> decryption secret.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/033     | 16 ++++++++++++----
>  tests/qemu-iotests/120     | 25 ++++++++++++++++++++++---
>  tests/qemu-iotests/140     | 15 ++++++++++++++-
>  tests/qemu-iotests/145     | 18 +++++++++++++++++-
>  tests/qemu-iotests/157     | 17 ++++++++++++++---
>  tests/qemu-iotests/157.out | 16 ++++++++--------
>  6 files changed, 87 insertions(+), 20 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
> index 16edcf2..b690b0e 100755
> --- a/tests/qemu-iotests/033
> +++ b/tests/qemu-iotests/033
> @@ -50,14 +50,22 @@ do_test()
>  	local align=3D$1
>  	local iocmd=3D$2
>  	local img=3D$3
> +	if test "$IMGOPTSSYNTAX" =3D "true"

Explicitly using "test" is a bit weird, but OK.

> +	then
> +	    IO_OPEN_ARG=3D"$img"
> +	    IO_EXTRA_ARGS=3D"--image-opts"
> +	else
> +	    IO_OPEN_ARG=3D"-o driver=3D$IMGFMT,file.align=3D$align blkdebug::=
$img"
> +	    IO_EXTRA_ARGS=3D""
> +	fi
>  	{
> -		echo "open -o driver=3D$IMGFMT,file.align=3D$align blkdebug::$img"
> +		echo "open $IO_OPEN_ARG"
>  		echo $iocmd
> -	} | $QEMU_IO
> +	} | $QEMU_IO $IO_EXTRA_ARGS
>  }
> =20
>  for write_zero_cmd in "write -z" "aio_write -z"; do
> -for align in 512 4k; do
> +    for align in 512 4k; do
>  	echo
>  	echo "=3D=3D preparing image =3D=3D"
>  	do_test $align "write -P 0xa 0x200 0x400" "$TEST_IMG" | _filter_qemu_=
io
> @@ -91,7 +99,7 @@ for align in 512 4k; do
>  	do_test $align "read -P 0xb 0x400 0xc00" "$TEST_IMG" | _filter_qemu_i=
o
> =20
>  	echo
> -done
> +    done

These alignment changes don't hurt, but I don't really see how they
improve the layout or how they are related to this patch.

>  done
> =20
>  # success, all done
> diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
> index 4f88a67..5f80517 100755
> --- a/tests/qemu-iotests/120
> +++ b/tests/qemu-iotests/120
> @@ -44,17 +44,36 @@ _supported_os Linux
> =20
>  _make_test_img 64M
> =20
> +if test "$IMGOPTSSYNTAX" =3D "true"
> +then
> +    SYSEMU_DRIVE_ARG=3Did=3Ddrv,if=3Dnone,$TEST_IMG

This basically makes this test moot. The point is to get the following
configuration:

raw format driver
       |
       v
 $IMGFMT driver
       |
       v
protocol driver

This is why the test explicitly specifies
driver=3Draw,file.driver=3D$IMGFMT. With this configuration, you just get=

the standard configuration without the raw driver on top.

That renders the test irrelevant, meaning you can just as well disable
it for LUKS.

> +    SYSEMU_EXTRA_ARGS=3D""
> +    IO_DRIVE_ARG=3D"$TEST_IMG"
> +    IO_EXTRA_ARGS=3D"--image-opts"
> +    if [ -n "$IMGKEYSECRET" ]; then
> +	SECRET_ARG=3D"secret,id=3Dkeysec0,data=3D$IMGKEYSECRET"
> +	SYSEMU_EXTRA_ARGS=3D"$SYSEMU_EXTRA_ARGS -object $SECRET_ARG"
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
>  # success, all done
> diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
> index 49f9df4..afaa418 100755
> --- a/tests/qemu-iotests/140
> +++ b/tests/qemu-iotests/140
> @@ -51,8 +51,21 @@ _make_test_img 64k
> =20
>  $QEMU_IO -c 'write -P 42 0 64k' "$TEST_IMG" | _filter_qemu_io
> =20
> +if test "$IMGOPTSSYNTAX" =3D "true"
> +then
> +    SYSEMU_DRIVE_ARG=3Dif=3Dnone,media=3Dcdrom,id=3Ddrv,$TEST_IMG
> +    SYSEMU_EXTRA_ARGS=3D""
> +    if [ -n "$IMGKEYSECRET" ]; then

Sometimes using "test" and sometimes "[" is even weirder.

> +	SECRET_ARG=3D"secret,id=3Dkeysec0,data=3D$IMGKEYSECRET"
> +	SYSEMU_EXTRA_ARGS=3D"-object $SECRET_ARG"

Spaces would probably be better than tabs.

> +    fi
> +else
> +    SYSEMU_DRIVE_ARG=3Dif=3Dnone,media=3Dcdrom,id=3Ddrv,file=3D"$TEST_=
IMG",driver=3Draw,file.driver=3D$IMGFMT

Not sure where you get the driver=3Draw,file.driver=3D$IMGFMT configurati=
on
from. The original just has format=3D$IMGFMT (equivalent to driver=3D$IMF=
GMT).

> +    SYSEMU_EXTRA_ARGS=3D""
> +fi
> +
>  keep_stderr=3Dy \
> -_launch_qemu -drive if=3Dnone,media=3Dcdrom,id=3Ddrv,file=3D"$TEST_IMG=
",format=3D$IMGFMT \
> +_launch_qemu $SYSEMU_EXTRA_ARGS -drive $SYSEMU_DRIVE_ARG \
>      2> >(_filter_nbd)
> =20
>  _send_qemu_cmd $QEMU_HANDLE \
> diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
> index 1eca0e8..ab54972 100755
> --- a/tests/qemu-iotests/145
> +++ b/tests/qemu-iotests/145
> @@ -43,7 +43,23 @@ _supported_proto generic
>  _supported_os Linux
> =20
>  _make_test_img 1M
> -echo quit | $QEMU -nographic -hda "$TEST_IMG" -incoming 'exec:true' -s=
napshot -serial none -monitor stdio | _filter_qemu
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
> +    SYSEMU_DRIVE_ARG=3Dif=3Dnone,file=3D"$TEST_IMG",driver=3Draw,file.=
driver=3D$IMGFMT

Again, should be just driver=3D$IMGFMT.

> +    SYSEMU_EXTRA_ARGS=3D""
> +fi
> +
> +echo quit | $QEMU -nographic $SYSEMU_EXTRA_ARGS  -drive $SYSEMU_DRIVE_=
ARG \
> +                  -incoming 'exec:true' -snapshot -serial none -monito=
r stdio \
> +          | _filter_qemu
> =20
>  # success, all done
>  echo "*** done"
> diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
> index 8d939cb..9ba1720 100755
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
> +    fi
> +else
> +    SYSEMU_DRIVE_ARG=3Dif=3Dnone,file=3D"$TEST_IMG",driver=3Draw,file.=
driver=3D$IMGFMT

And once more.

Max

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


--Iwa3dWiVDF6KevCC6n0Ou1hd1cl7kAK7t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlifsUESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A2qwIAIFOadsqsALLFcWMQaw5dREV6ZLwjgS7
lQfeZ7gXcJLfMEq36mYNCn1UrXTZjkdqe9WtxZ8Vrlbwg647YeaVs36U/gUkI34P
2/+fj8l6TZiOuvi2WQV1rsViRhaFNrTlDPtpH5XkYiUw6E8sJki8Jgvl4NgTDcoK
qA127WREAG+ik2Etd80aWOaVlNFGoaNSSKqqCHlGymeKDrNjTfGwR2AREPKvO+7S
y30qrBLRStDTqomT5JKHPqZkatlO8iP6PHLIbB0bb53ZpXqZhb9V9omujIgjEuxQ
ZESGJq7412a7w7RHpC/nOHY80VG4iZIE/2xzE6qb1o1aOEsR9YnDk3E=
=QdQq
-----END PGP SIGNATURE-----

--Iwa3dWiVDF6KevCC6n0Ou1hd1cl7kAK7t--
