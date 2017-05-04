Received: from eggs.gnu.org ([2001:4830:134:3::10]:40588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6Mu5-0003Zt-6t
	for qemu-devel@nongnu.org; Thu, 04 May 2017 15:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6Mu4-0006rN-0M
	for qemu-devel@nongnu.org; Thu, 04 May 2017 15:59:09 -0400
References: <20170504193044.16303-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d4850849-597b-ed09-ea43-b09621c0f5f0@redhat.com>
Date: Thu, 4 May 2017 14:58:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170504193044.16303-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8CRxqXxM3CSFEO97q5wEvq6oqi73xKspV"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Check for backing image if
 specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8CRxqXxM3CSFEO97q5wEvq6oqi73xKspV
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <d4850849-597b-ed09-ea43-b09621c0f5f0@redhat.com>
Subject: Re: [PATCH] qemu-img: Check for backing image if specified during
 create
References: <20170504193044.16303-1-jsnow@redhat.com>
In-Reply-To: <20170504193044.16303-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 02:30 PM, John Snow wrote:
> Or, rather, force the open of a backing image if one was specified
> for creation. Using a similar -unsafe option as rebase, allow qemu-img
> to ignore the backing file validation if possible.
>=20
> It may not always be possible, as in the existing case of if a filesize=


s/of if/when/

> for the new image was not specified.
>=20
> This is accomplished by shifting around the conditionals in
> bdrv_img_create, such that a backing file is always opened unless we
> provide BDRV_O_NO_BACKING. qemu-img is adjusted to pass this new flag
> when -u is provided to create.
>=20
> Sorry for the heinous looking diffstat, but it's mostly whitespace.
>=20

Indeed, reviewing under 'git diff -b' proved fruitful.

> Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=3D1213786
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block.c                    | 75 +++++++++++++++++++++++---------------=
--------
>  qemu-img-cmds.hx           |  4 +--

Conflicts with the documentation patch for [-b backing_file] (already on
PULL request:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05816.html

so you'll have to rebase, but it shouldn't be too difficult.

>  qemu-img.c                 | 15 ++++++----
>  tests/qemu-iotests/082     |  4 +--
>  tests/qemu-iotests/082.out |  4 +--
>  5 files changed, 54 insertions(+), 48 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 5db266b..da28052 100644
> --- a/block.c
> +++ b/block.c
> @@ -4280,38 +4280,38 @@ void bdrv_img_create(const char *filename, cons=
t char *fmt,
>      // The size for the image must always be specified, with one excep=
tion:
>      // If we are using a backing file, we can obtain the size from the=
re
>      size =3D qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
> -    if (size =3D=3D -1) {

Wait. How does this even work?  qemu_opt_get_size() returns an unsigned
value, either what was specified by the option, or else the default
parameter (which  we passed as 0), so how can size ever be -1?  It might
make sense if we had called:

size =3D qemu_opt_get_size(opts, BLOCK_OPT_SIZE, -1);

with the intent of allowing an explicit size of 0.  But I'm lost as to
how this code ever worked pre-patch...


> +
> +        if (size =3D=3D -1) {

=2E..which therefore carries over to the state of things post-patch.

/me goes and reads code

What?
if (desc && desc->def_value_str) {
  parse_option_size(name, desc->def_value_str, &ret, &error_abort);
  return ret;

Oh - so THAT's how: qemu_opt_get_size_helper() ignores the 'defval'
input and instead returns a DIFFERENT default associated with the
QemuOpts. UGLY.  But not your fault.

> +++ b/qemu-img.c
> @@ -145,9 +145,10 @@ static void QEMU_NORETURN help(void)
>             "  'snapshot_id_or_name' is deprecated, use 'snapshot_param=
'\n"
>             "    instead\n"
>             "  '-c' indicates that target image must be compressed (qco=
w format only)\n"
> -           "  '-u' enables unsafe rebasing. It is assumed that old and=
 new backing file\n"
> -           "       match exactly. The image doesn't need a working bac=
king file before\n"
> -           "       rebasing in this case (useful for renaming the back=
ing file)\n"
> +           "  '-u' allows unsafe backing chains. For rebasing, it is a=
ssumed that old and new \n"
> +           "       backing file match exactly. The image doesn't need =
a working backing file \n"
> +           "       before rebasing in this case (useful for renaming t=
he backing file)\n"
> +           "       For image creation, allow creating without attempti=
ng to open the file.\n"

maybe s/to open the file/to open the backing file/

> +++ b/tests/qemu-iotests/082
> @@ -85,8 +85,8 @@ run_qemu_img create -f $IMGFMT -o cluster_size=3D4k -=
o help "$TEST_IMG" $size
>  run_qemu_img create -f $IMGFMT -o cluster_size=3D4k -o \? "$TEST_IMG" =
$size
> =20
>  # Looks like a help option, but is part of the backing file name
> -run_qemu_img create -f $IMGFMT -o backing_file=3D"$TEST_IMG",,help "$T=
EST_IMG" $size
> -run_qemu_img create -f $IMGFMT -o backing_file=3D"$TEST_IMG",,\? "$TES=
T_IMG" $size
> +run_qemu_img create -f $IMGFMT -u -o backing_file=3D"$TEST_IMG",,help =
"$TEST_IMG" $size
> +run_qemu_img create -f $IMGFMT -u -o backing_file=3D"$TEST_IMG",,\? "$=
TEST_IMG" $size

Nice test of the new usage.

I like where it's headed.  It will need a v2 to rebase and fix the
things I pointed out, but I'm looking forward to it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8CRxqXxM3CSFEO97q5wEvq6oqi73xKspV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZC4gCAAoJEKeha0olJ0NqtC4H/j5BCe5gRn8Q86f/tTA2KoO0
oN0q5wkPWh2IZLL7JdEDri0btdZssyik3GcOYZLO3MeyABGQlsm6ptsNxCXCqwt+
CvqlrKRnts/XA9yg+LKfYCK6SOG82JjLmbh/9nK8v6kObdEiWCyV7BzsOlvZE5Zx
p0ALUT0m6AriFaR5DyzlQOaactAakY3+a2V0mLejA52x4ESAoSeBXFpxMbuIukXq
4irm80mTX+BgrBMDUqRZ2mDWEJv9QbkDhSflmaIitoErykRfm09nUP8sZS56P6ww
G1o0Kf7yiS/fzRzu/b5Yw9D20FZaWv7YJPDOumilxVhEe8c3hSbSGN9+nkEcsi4=
=y6ew
-----END PGP SIGNATURE-----

--8CRxqXxM3CSFEO97q5wEvq6oqi73xKspV--
