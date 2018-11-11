Received: from eggs.gnu.org ([2001:4830:134:3::10]:33220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLvJh-0004Vp-1W
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 14:22:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLvJg-00089k-9u
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 14:22:41 -0500
References: <1541453919-25973-1-git-send-email-Liam.Merwick@oracle.com>
	<1541453919-25973-5-git-send-email-Liam.Merwick@oracle.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <15edc864-d708-7323-aafa-c51cc7234bdf@redhat.com>
Date: Sun, 11 Nov 2018 20:22:14 +0100
MIME-Version: 1.0
In-Reply-To: <1541453919-25973-5-git-send-email-Liam.Merwick@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q7HS7ZSDpTctkBopheunShJridxateR7M"
Subject: Re: [Qemu-devel] [PATCH v5 4/5] block: Fix potential Null pointer
 dereferences in vvfat.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q7HS7ZSDpTctkBopheunShJridxateR7M
From: Max Reitz <mreitz@redhat.com>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 berrange@redhat.com
Message-ID: <15edc864-d708-7323-aafa-c51cc7234bdf@redhat.com>
Subject: Re: [PATCH v5 4/5] block: Fix potential Null pointer dereferences in
 vvfat.c
References: <1541453919-25973-1-git-send-email-Liam.Merwick@oracle.com>
 <1541453919-25973-5-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1541453919-25973-5-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.11.18 22:38, Liam Merwick wrote:
> The calls to find_mapping_for_cluster() may return NULL but it
> isn't always checked for before dereferencing the value returned.
> Additionally, add some asserts to cover cases where NULL can't
> be returned but which might not be obvious at first glance.
>=20
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> ---
>  block/vvfat.c | 50 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 16 deletions(-)
>=20
> diff --git a/block/vvfat.c b/block/vvfat.c
> index fc41841a5c3c..263274d9739a 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c

[...]
> @@ -2428,16 +2424,13 @@ static int commit_direntries(BDRVVVFATState* s,=

>      direntry_t* direntry =3D array_get(&(s->directory), dir_index);
>      uint32_t first_cluster =3D dir_index =3D=3D 0 ? 0 : begin_of_diren=
try(direntry);
>      mapping_t* mapping =3D find_mapping_for_cluster(s, first_cluster);=

> -
>      int factor =3D 0x10 * s->sectors_per_cluster;
>      int old_cluster_count, new_cluster_count;
> -    int current_dir_index =3D mapping->info.dir.first_dir_index;
> -    int first_dir_index =3D current_dir_index;
> +    int current_dir_index;
> +    int first_dir_index;
>      int ret, i;
>      uint32_t c;
> =20
> -DLOG(fprintf(stderr, "commit_direntries for %s, parent_mapping_index %=
d\n", mapping->path, parent_mapping_index));
> -
>      assert(direntry);
>      assert(mapping);

Oh, having moved the condition below the declarations brings an
interesting point to light, which is that there is an assertion for it
here already.  So...

>      assert(mapping->begin =3D=3D first_cluster);
> @@ -2445,6 +2438,15 @@ DLOG(fprintf(stderr, "commit_direntries for %s, =
parent_mapping_index %d\n", mapp
>      assert(mapping->mode & MODE_DIRECTORY);
>      assert(dir_index =3D=3D 0 || is_directory(direntry));
> =20
> +    if (mapping =3D=3D NULL) {
> +        return -1;
> +    }
> +

=2E..this should just not be added altogether.

> +DLOG(fprintf(stderr, "commit_direntries for %s, parent_mapping_index %=
d\n",
> +        mapping->path, parent_mapping_index));

Moving this and the following dereferencing statements below that
assertion is reasonable, though.  I think you should indent the DLOG()
while you're at it, though, because there is no reason not to, and the
way it is here just violates the coding style.  (Disregarding that
vvfat.c effectively is a complete violation of the qemu coding style.
*cough*)

> +
> +    current_dir_index =3D mapping->info.dir.first_dir_index;
> +    first_dir_index =3D current_dir_index;
>      mapping->info.dir.parent_mapping_index =3D parent_mapping_index;
> =20
>      if (first_cluster =3D=3D 0) {


So with the "if (mapping =3D=3D NULL) {}" block above (hunk @@2445) dropp=
ed
and the DLOG() indented:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--q7HS7ZSDpTctkBopheunShJridxateR7M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvogWYACgkQ9AfbAGHV
z0B/Lgf+MWIGKr9D+t6BMPhz5WRJGR5ApTZHddm+sm97BRLovp8S0vr6RnX0IS1F
mZbu48bif2HCZm+HAJwD7klJSHdyuPxcjUt+IzNG5Wleyi742i07Otdj9XdAij9Z
N63OG+Gf38j6ux3x0PdLg2i3ZXXy9r4lHuf/XvfPV3iDutGk2LmeoJ9ou+VgEGw8
wgiUUTmsZyD2zKsmbzOMzD2M6/swsSllPkH620+/m2IRYNca1OkoKPJJHOjTHW8x
ZAkIx/zRXObhRlbx6kL0l1UACWRDx5irOwkqlAo0/iV670UX9fsma/e3TAn8/thY
4G/eolTC/l/GbufXtr4SY9vQcv55Mg==
=O7xL
-----END PGP SIGNATURE-----

--q7HS7ZSDpTctkBopheunShJridxateR7M--
