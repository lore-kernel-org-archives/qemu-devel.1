Received: from eggs.gnu.org ([2001:4830:134:3::10]:34927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTaXt-0001Gn-CM
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTaXs-0004lx-09
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:12:13 -0400
References: <20170707143028.692-1-pbutsykin@virtuozzo.com>
	<20170707143028.692-2-pbutsykin@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02872724-780e-cfbf-4e19-eb772764c645@redhat.com>
Date: Fri, 7 Jul 2017 16:12:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170707143028.692-2-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I9GwtxlJI29XiQUd856LauihSWuVbl0kG"
Subject: Re: [Qemu-devel] [PATCH v3 1/4] qemu-img: add --shrink flag for
 resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@openvz.org, Alistair Francis <alistair.francis@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I9GwtxlJI29XiQUd856LauihSWuVbl0kG
From: Eric Blake <eblake@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@openvz.org,
 Alistair Francis <alistair.francis@xilinx.com>
Message-ID: <02872724-780e-cfbf-4e19-eb772764c645@redhat.com>
Subject: Re: [PATCH v3 1/4] qemu-img: add --shrink flag for resize
References: <20170707143028.692-1-pbutsykin@virtuozzo.com>
 <20170707143028.692-2-pbutsykin@virtuozzo.com>
In-Reply-To: <20170707143028.692-2-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 09:30 AM, Pavel Butsykin wrote:
> The flag as additional precaution of data loss. Perhaps in the future t=
he

s/as/is/ s/of/against/

> operation shrink without this flag will be blocked for all formats, but=
 while

s/while/for now/

> we need to maintain compatibility with raw.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  qemu-img-cmds.hx       |  4 ++--
>  qemu-img.c             | 23 +++++++++++++++++++++++
>  qemu-img.texi          |  7 ++++++-
>  tests/qemu-iotests/102 |  4 ++--
>  4 files changed, 33 insertions(+), 5 deletions(-)
>=20

> @@ -3568,6 +3574,23 @@ static int img_resize(int argc, char **argv)
>          goto out;
>      }
> =20
> +    if (total_size < blk_getlength(blk) && !shrink) {
> +        error_report("Warning: Shrinking an image will delete all data=
 beyond"

Alistair has a pending thread to create a unified warning function; if
that lands first, you'll have to tweak this (if yours lands first, it's
one more place for that series to clean up).

> +                     "the shrunken image's end. Before performing such=
 an"
> +                     "operation, make sure there is no important data =
there.");
> +
> +        if (g_strcmp0(bdrv_get_format_name(blk_bs(blk)), "raw") !=3D 0=
) {
> +            error_report(
> +              "Use the --shrink option to perform a shrink operation."=
);
> +            ret =3D -1;
> +            goto out;
> +        } else {
> +            error_report("Using the --shrink option will suppress this=
 message."
> +                         "Note that future versions of qemu-img may re=
fuse to "
> +                         "shrink images without this option!");

No need to shout at the user ('.' is better than '!')

> +        }
> +    }
> +
>      ret =3D blk_truncate(blk, total_size, &err);
>      if (!ret) {
>          qprintf(quiet, "Image resized.\n");
> diff --git a/qemu-img.texi b/qemu-img.texi
> index 5b925ecf41..6324abef48 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -499,7 +499,7 @@ qemu-img rebase -b base.img diff.qcow2
>  At this point, @code{modified.img} can be discarded, since
>  @code{base.img + diff.qcow2} contains the same information.
> =20
> -@item resize @var{filename} [+ | -]@var{size}
> +@item resize [--shrink] @var{filename} [+ | -]@var{size}
> =20
>  Change the disk image as if it had been created with @var{size}.
> =20
> @@ -507,6 +507,11 @@ Before using this command to shrink a disk image, =
you MUST use file system and
>  partitioning tools inside the VM to reduce allocated file systems and =
partition
>  sizes accordingly.  Failure to do so will result in data loss!
> =20
> +@code{--shrink} informs qemu-img that the user is certain about wantin=
g
> +to shrink an image and is aware that any data beyond the truncated
> +image's end will be lost. Trying to shrink an image without this optio=
n
> +results in a warning; future versions may make it an error.

You made it an error for all but raw already, but I'm not sure how wordy
we want this to be.

> +
>  After using this command to grow a disk image, you must use file syste=
m and
>  partitioning tools inside the VM to actually begin using the new space=
 on the
>  device.
> diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
> index 87db1bb1bf..d7ad8d9840 100755
> --- a/tests/qemu-iotests/102
> +++ b/tests/qemu-iotests/102
> @@ -54,7 +54,7 @@ _make_test_img $IMG_SIZE
>  $QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_io
>  # Remove data cluster from image (first cluster: image header, second:=
 reftable,
>  # third: refblock, fourth: L1 table, fifth: L2 table)
> -$QEMU_IMG resize -f raw "$TEST_IMG" $((5 * 64 * 1024))
> +$QEMU_IMG resize -f raw --shrink "$TEST_IMG" $((5 * 64 * 1024))
> =20
>  $QEMU_IO -c map "$TEST_IMG"
>  $QEMU_IMG map "$TEST_IMG"
> @@ -69,7 +69,7 @@ $QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_=
io
> =20
>  qemu_comm_method=3Dmonitor _launch_qemu -drive if=3Dnone,file=3D"$TEST=
_IMG",id=3Ddrv0
> =20
> -$QEMU_IMG resize -f raw "$TEST_IMG" $((5 * 64 * 1024))
> +$QEMU_IMG resize -f raw --shrink "$TEST_IMG" $((5 * 64 * 1024))

This tests a successful shrink. Please also test the error message when
attempting to shrink but --shrink was not supplied.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--I9GwtxlJI29XiQUd856LauihSWuVbl0kG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX/kiAAoJEKeha0olJ0Nqk+kH+QHB2XfyVNsjnLMEX6Xw9uR8
UeC1VgV0UJZr41vUSXi+hwClXiT369irlRhiqydC6Q2TjFW9v29aoYjaxYr4sHfR
3V0Km6n0oWeYC+WZ4kUnAVBOffPV3nqWvzRaC7vols9SC9NGpsBe/FxFmtgmZWXo
3vEfEzqo5DP5BhgTZBAR0Xf/QMW9XiNstamUlD0vn1KhFiXH10ZUTlLUwiIu+JOi
YyEsJ4U0ohhk/FEpeXoWJmsAZNSY5gmC2JCEye/ZDA67k6jGchGpyfTCPlmV3FyR
yCyPbnQ01mTZnVzY18UpJ7KKwbUPPTTxMGnctwV3r9qpInjfs3gs4orjZ9mBppU=
=L6/f
-----END PGP SIGNATURE-----

--I9GwtxlJI29XiQUd856LauihSWuVbl0kG--
