Received: from eggs.gnu.org ([209.51.188.92]:52036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpETM-0006UF-67
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpETL-0000ji-4Q
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:41:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gpETK-0000jR-QR
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:41:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FAA6DC909
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 15:41:46 +0000 (UTC)
References: <20190131130016.17337-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b7995d51-0486-728e-05d9-7606064824c1@redhat.com>
Date: Thu, 31 Jan 2019 09:41:35 -0600
MIME-Version: 1.0
In-Reply-To: <20190131130016.17337-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jP9CNSsNN0J6zxyl1sVUZRkFcNOE6PjEQ"
Subject: Re: [Qemu-devel] [PATCH v3] scripts: use git archive in
 archive-source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jP9CNSsNN0J6zxyl1sVUZRkFcNOE6PjEQ
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com
Message-ID: <b7995d51-0486-728e-05d9-7606064824c1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] scripts: use git archive in
 archive-source
References: <20190131130016.17337-1-kraxel@redhat.com>
In-Reply-To: <20190131130016.17337-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/31/19 7:00 AM, Gerd Hoffmann wrote:
> Use git archive to create tarballs of qemu and submodules instead of
> cloning the repository and the submodules.  This is a order of magnitud=
e
> faster because it doesn't fetch the submodules from the internet each
> time the script runs.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  scripts/archive-source.sh | 63 ++++++++++++++++++++-------------------=
--------
>  1 file changed, 27 insertions(+), 36 deletions(-)
>=20
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> index 6eed2a29bd..38d53986d7 100755
> --- a/scripts/archive-source.sh
> +++ b/scripts/archive-source.sh
> @@ -19,8 +19,8 @@ if test $# -lt 1; then
>  fi
> =20
>  tar_file=3D$(realpath "$1")
> -list_file=3D"${tar_file}.list"
> -vroot_dir=3D"${tar_file}.vroot"
> +sub_file=3D$(mktemp "${tar_file%.tar}.sub.XXXXXXXX.tar")
> +sub_tdir=3D$(mktemp -d "${tar_file%.tar}.sub.XXXXXXXX")

mktemp is not specified by POSIX; and FreeBSD man pages for mktemp
suggest that if you don't use XXXXXX as the suffix that you are not
guaranteed correct behavior.  Are you sure this is portable enough?  Do
you need both a temp file and dir, or can you create the file name of
your choice inside a temp dir, where only the dir has to have a
randomized name?

> =20
>  # We want a predictable list of submodules for builds, that is
>  # independent of what the developer currently has initialized
> @@ -28,7 +28,7 @@ vroot_dir=3D"${tar_file}.vroot"
>  # different to the host OS.
>  submodules=3D"dtc ui/keycodemapdb tests/fp/berkeley-softfloat-3 tests/=
fp/berkeley-testfloat-3"
> =20
> -trap "status=3D$?; rm -rf \"$list_file\" \"$vroot_dir\"; exit \$status=
" 0 1 2 3 15
> +trap "status=3D$?; rm -rf \"$sub_file\" \"$sub_tdir\" ; exit \$status"=
 0 1 2 3 15
> =20
>  if git diff-index --quiet HEAD -- &>/dev/null
>  then
> @@ -36,38 +36,29 @@ then
>  else
>      HEAD=3D$(git stash create)
>  fi
> -git clone --shared . "$vroot_dir"
> -test $? -ne 0 && error "failed to clone into '$vroot_dir'"
> -
> -cd "$vroot_dir"
> -test $? -ne 0 && error "failed to change into '$vroot_dir'"
> -
> -git checkout $HEAD
> -test $? -ne 0 && error "failed to checkout $HEAD revision"
> -
> +git archive --format tar $HEAD > "$tar_file"
> +test $? -ne 0 && error "failed to archive qemu"
>  for sm in $submodules; do
> -    git submodule update --init $sm
> -    test $? -ne 0 && error "failed to init submodule $sm"
> +	status=3D"$(git submodule status "$sm")"
> +	smhash=3D"${status# }"
> +	smhash=3D"${smhash#+}"
> +	smhash=3D"${smhash#-}"

These three lines can be consolidated into one:
smhash=3D${status#[ +-]}

> +	smhash=3D"${smhash%% *}"
> +	smdir=3D"$sm"
> +	case "$status" in
> +	    -*)
> +		smdir=3D"$sub_tdir/$sm"
> +		smurl=3D"$(git config -f .gitmodules submodule.${sm}.url)"
> +		echo "NOTICE: using temporary clone for submodule $sm"
> +		git clone "$smurl" "$smdir"
> +		test $? -ne 0 && error "failed to clone submodule $sm"

I know we don't want to affect the developer's normal checkout, but is
it worth storing the temporary clone in a specifically-named
subdirectory of their checkout instead of in a randomly-generated mktemp
transient location, so that we can reuse results from a previous
archive-source run?

> +		;;
> +	    +*)
> +		echo "WARNING: submodule $sm is out of sync"
> +		;;
> +	esac
> +	(cd $smdir; git archive --format tar --prefix "$sm/" $smhash) > "$sub=
_file"
> +	test $? -ne 0 && error "failed to archive submodule $sm ($smhash)"
> +	tar --concatenate --file "$tar_file" "$sub_file"
> +	test $? -ne 0 && error "failed append submodule $sm to $tar_file"
>  done

Overall, though, the idea seems reasonable.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--jP9CNSsNN0J6zxyl1sVUZRkFcNOE6PjEQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxTFy8ACgkQp6FrSiUn
Q2pQzgf9Ht4xbfRtnwbS1Mf5XAMpInK55pGF7FWc+8O8I3Th7XQTIlyFeVi4JRYR
y/VIICdjUbXinZwH6f8jlTwDWkpPAKoWpW9vx0A0e5xVU3CKFOmzgUMlMK8nprcD
fy1AOmrR5XS3Rk6UuEbq/NcArNdY31UvCXHGq8q6h4rAQmB8tDGiKEe0ZTO8naIG
++JtZGwtQ1cCtnhWzN/xBPL8KACocp9pQOQRBgsxpSzVrZnNa6sCuxA3z3Pp8xHM
9WQQqU1SKioB+xRfr1lKsZB44UCYrBULWwLFg9ISQCmsBkxhVhUwl9H07alonv4Q
J0+eFxJ3VfIVAwg1KZEU7kXE6W9l5Q==
=5jLC
-----END PGP SIGNATURE-----

--jP9CNSsNN0J6zxyl1sVUZRkFcNOE6PjEQ--
