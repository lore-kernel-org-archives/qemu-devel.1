Received: from eggs.gnu.org ([2001:4830:134:3::10]:37696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHrI-0005nQ-0R
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHrD-0001MA-VL
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:44:04 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cdHrD-0001Lh-Op
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:43:59 -0500
Received: by mail-wr0-x241.google.com with SMTP id i10so24509601wrb.0
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 06:43:59 -0800 (PST)
Date: Mon, 13 Feb 2017 14:43:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213144356.GM10361@stefanha-x1.localdomain>
References: <1486527494-3387-1-git-send-email-Ashish.Mittal@veritas.com>
	<1486527494-3387-2-git-send-email-Ashish.Mittal@veritas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FxlYARId5dseejUu"
Content-Disposition: inline
In-Reply-To: <1486527494-3387-2-git-send-email-Ashish.Mittal@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v7 2/2] block/vxhs.c: Add qemu-iotests for
 new block device type "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Mittal <ashmit602@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, Ketan.Nilangekar@veritas.com, Abhijit.Dey@veritas.com


--FxlYARId5dseejUu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 08:18:14PM -0800, Ashish Mittal wrote:
> diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common=
=2Econfig
> index f6384fb..c7a80c0 100644
> --- a/tests/qemu-iotests/common.config
> +++ b/tests/qemu-iotests/common.config
> @@ -105,6 +105,10 @@ if [ -z "$QEMU_NBD_PROG" ]; then
>      export QEMU_NBD_PROG=3D"`set_prog_path qemu-nbd`"
>  fi
> =20
> +if [ -z "$QEMU_VXHS_PROG" ]; then
> +    export QEMU_VXHS_PROG=3D"`set_prog_path qnio_server /usr/local/bin`"

Did you test this with /usr/local/bin/qnio_server?

I think it will evaluate to QEMU_VXHS_PROG=3D/usr/local/bin when qnio_server
isn't found in PATH.  You probably wanted /usr/local/bin/qnio_server instea=
d.

I suggest dropping the second argument completely and letting the user set =
PATH
themselves.  No existing set_prog_path caller uses the second argument.

# $1 =3D prog to look for, $2* =3D default pathnames if not found in $PATH
set_prog_path()
{
    p=3D`command -v $1 2> /dev/null`
    if [ -n "$p" -a -x "$p" ]; then
        echo $p
        return 0
    fi
    p=3D$1

    shift
    for f; do
        if [ -x $f ]; then
            echo $f
            return 0
        fi
    done

    echo ""
    return 1
}

> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 3213765..06a3164 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -89,6 +89,9 @@ else
>          TEST_IMG=3D$TEST_DIR/t.$IMGFMT
>      elif [ "$IMGPROTO" =3D "archipelago" ]; then
>          TEST_IMG=3D"archipelago:at.$IMGFMT"
> +    elif [ "$IMGPROTO" =3D "vxhs" ]; then
> +        TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
> +        TEST_IMG=3D"vxhs://127.0.0.1:9999/t.$IMGFMT"
>      else
>          TEST_IMG=3D$IMGPROTO:$TEST_DIR/t.$IMGFMT
>      fi
> @@ -175,6 +178,12 @@ _make_test_img()
>          eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT  $TEST_IM=
G_FILE &"
>          sleep 1 # FIXME: qemu-nbd needs to be listening before we contin=
ue
>      fi
> +
> +    # Start QNIO server on image directory for vxhs protocol
> +    if [ $IMGPROTO =3D "vxhs" ]; then
> +        eval "$QEMU_VXHS -d  $TEST_DIR &"
> +        sleep 1 # Wait for server to come up.

This is a pre-existing problem and you don't need to fix it now:

We should replace sleep 1 with a function that probes the TCP port until the
connection can be established or a timeout is reached.  The netcat (nc) uti=
lity
is often used for this.

sleep 1 is not reliable and may fail on a heavily loaded machine like the
Travis-CI build machines that are used.

--FxlYARId5dseejUu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYocYsAAoJEJykq7OBq3PIrpMH/0ypBNZ2I1IIiFj3mCcGQT4r
Fli9mtCKu6DMSHW3bpiM+boTusFPHK/mrMhSlEgvTkz0cHKnXTaDmwkZYvg1PE77
/y7XfB77ESuBEy75QdM0TzWUdq3CMNwkJim1ZveJgqM9GX9sowWp935Zj/MnOJTW
eibNWgeOaE47sjfMFrrA6L0802tJWu+J5do8DIRIx1Rnak00CVul40maMftT3Rz8
0PrFcdREBMt0xjVPZyeyV3KJhcUwrxCGPEqd8UvvgWfA8IUSiauKjXk5JXzL0NuM
q4K+F/+9bdpH223NJS5sVG598A/K4Gly2H0m0GC3DuO9aBkmmf5d9LN+HwogJIE=
=Uw56
-----END PGP SIGNATURE-----

--FxlYARId5dseejUu--
