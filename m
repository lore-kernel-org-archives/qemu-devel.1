Received: from eggs.gnu.org ([2001:4830:134:3::10]:56016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXUXm-0001yZ-Tz
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXUXl-0002SH-52
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:08:30 -0500
References: <20180105065538.13375-1-famz@redhat.com>
	<20180105065538.13375-3-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <75051aa2-5544-449d-0659-4460a9de5554@redhat.com>
Date: Fri, 5 Jan 2018 10:08:18 -0600
MIME-Version: 1.0
In-Reply-To: <20180105065538.13375-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8j2XanxkHpBsFpmxEmdVjRAhB3tAWpD6z"
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: info: try -U automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8j2XanxkHpBsFpmxEmdVjRAhB3tAWpD6z
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <75051aa2-5544-449d-0659-4460a9de5554@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: info: try -U automatically
References: <20180105065538.13375-1-famz@redhat.com>
 <20180105065538.13375-3-famz@redhat.com>
In-Reply-To: <20180105065538.13375-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2018 12:55 AM, Fam Zheng wrote:
> The error message we had didn't have a hint about "-U" when locking the=

> image failed, which is not friendly. Also it is imaginable that the
> reaction to that error by the user would be a retry with '-U'.
>=20
> So the reason we require "-U" for "qemu-img info" if the image is used
> is to raise the awareness about what could be wrong. A warning would do=

> just fine, especially since it is a little more informative.
>=20
> The test case reference output is updated accordingly.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.c                 | 14 ++++++++++++++
>  tests/qemu-iotests/153.out |  3 +--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 7d3171c20c..9684937425 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -2605,6 +2605,20 @@ static int img_info(int argc, char **argv)
> =20
>      list =3D collect_image_info_list(image_opts, filename, fmt, chain,=

>                                     force_share, &local_err);
> +    if (!list && !force_share) {
> +        Error *local_err2 =3D NULL;
> +        list =3D collect_image_info_list(image_opts, filename, fmt, ch=
ain,
> +                                       true, &local_err2);
> +        if (list) {
> +            error_report("WARNING: --force-share (-U) is not used but =
it "

We have warn_report() for use in this situation (in which case, you do
not want the leading "WARNING:" in your message).

> +                         "seems the image is attached to a running gue=
st; "
> +                         "the information may be inaccurate if it is b=
eing "
> +                         "updated.");

For consistency, I'd prefer no trailing dot.

> +            error_free(local_err);
> +        } else {
> +            error_free(local_err2);
> +        }
> +    }
>      if (!list) {
>          error_reportf_err(local_err, "Could not open '%s': ", filename=
);
>          return 1;
> diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
> index 5b917b177c..4de35184ba 100644
> --- a/tests/qemu-iotests/153.out
> +++ b/tests/qemu-iotests/153.out
> @@ -41,8 +41,7 @@ Is another process using the image?
>  no file open, try 'help open'
> =20
>  _qemu_img_wrapper info TEST_DIR/t.qcow2
> -qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "wri=
te" lock
> -Is another process using the image?
> +qemu-img: WARNING: --force-share (-U) is not used but it seems the ima=
ge is attached to a running guest; the information may be inaccurate if i=
t is being updated.

and those changes tweak this line.

But the idea makes sense, so with the changes,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8j2XanxkHpBsFpmxEmdVjRAhB3tAWpD6z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpPovIACgkQp6FrSiUn
Q2qS9Af9F1zhCbxBr0d3ZJixDKCzAmXRA3mPquhhyFxbT06bNTsWaUL9QqBmoZ/4
fc/Yam2KfZI5eO3mjvEsZI27Jq2n3XD939dw4zvrWhqOeCeqbXG7vHPjMcRhVI0P
zmrcSS+fJU/M3GIm4mRuM4/4Jiq3VkIsJVZxG25qRLcsTecJb3HRGLXCQtVmmeUo
GPM4xERAMIYcYIlp+Qut/Nkqz9gqHJBCJsSkfNTim45IntOVksCvKM4sST6ljmvI
bcThJXiNE8+0G4kY9K4FTTxIoQNCPiov3vhVSqGZc0EfXH6sJ3ySo4L4lbaIUlS4
hw2AZbqlNFSw7n3psn5TxJhhP0AinQ==
=Q52X
-----END PGP SIGNATURE-----

--8j2XanxkHpBsFpmxEmdVjRAhB3tAWpD6z--
