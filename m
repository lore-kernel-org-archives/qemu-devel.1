Received: from eggs.gnu.org ([2001:4830:134:3::10]:32826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJScb-0002ph-Az
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 19:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJSca-0000Qf-DR
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 19:20:01 -0500
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
	<1539981546-10596-6-git-send-email-Liam.Merwick@oracle.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dbd5f2e1-677a-e1d7-f494-c8f7f5d34f75@redhat.com>
Date: Mon, 5 Nov 2018 01:19:48 +0100
MIME-Version: 1.0
In-Reply-To: <1539981546-10596-6-git-send-email-Liam.Merwick@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BOG9h3YWN0aM1HT1J5fImGo4yq1lxd2IM"
Subject: Re: [Qemu-devel] [PATCH v4 5/8] block: Fix potential Null pointer
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
--BOG9h3YWN0aM1HT1J5fImGo4yq1lxd2IM
From: Max Reitz <mreitz@redhat.com>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 berrange@redhat.com
Message-ID: <dbd5f2e1-677a-e1d7-f494-c8f7f5d34f75@redhat.com>
Subject: Re: [PATCH v4 5/8] block: Fix potential Null pointer dereferences in
 vvfat.c
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
 <1539981546-10596-6-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1539981546-10596-6-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.10.18 22:39, Liam Merwick wrote:
> The calls to find_mapping_for_cluster() may return NULL but it
> isn't always checked for before dereferencing the value returned.
> Additionally, add some asserts to cover cases where NULL can't
> be returned but which might not be obvious at first glance.
>=20
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> ---
>  block/vvfat.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/vvfat.c b/block/vvfat.c
> index fc41841a5c3c..19f6725054a0 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -100,6 +100,7 @@ static inline void array_free(array_t* array)
>  /* does not automatically grow */
>  static inline void* array_get(array_t* array,unsigned int index) {
>      assert(index < array->next);
> +    assert(array->pointer);
>      return array->pointer + index * array->item_size;
>  }
> =20
> @@ -108,8 +109,7 @@ static inline int array_ensure_allocated(array_t* a=
rray, int index)
>      if((index + 1) * array->item_size > array->size) {
>          int new_size =3D (index + 32) * array->item_size;
>          array->pointer =3D g_realloc(array->pointer, new_size);
> -        if (!array->pointer)
> -            return -1;
> +        assert(array->pointer);

It would make sense to make this function not return any value (because
it just always returns 0 now), but I fully understand if you don't want
to mess around with vvfat more than you have to.  (Neither do I.)

>          memset(array->pointer + array->size, 0, new_size - array->size=
);
>          array->size =3D new_size;
>          array->next =3D index + 1;
> @@ -2261,6 +2261,9 @@ static mapping_t* insert_mapping(BDRVVVFATState* =
s,
>      }
>      if (index >=3D s->mapping.next || mapping->begin > begin) {
>          mapping =3D array_insert(&(s->mapping), index, 1);
> +        if (mapping =3D=3D NULL) {
> +            return NULL;
> +        }

array_insert() will never return NULL.

>          mapping->path =3D NULL;
>          adjust_mapping_indices(s, index, +1);
>      }
> @@ -2428,6 +2431,9 @@ static int commit_direntries(BDRVVVFATState* s,
>      direntry_t* direntry =3D array_get(&(s->directory), dir_index);
>      uint32_t first_cluster =3D dir_index =3D=3D 0 ? 0 : begin_of_diren=
try(direntry);
>      mapping_t* mapping =3D find_mapping_for_cluster(s, first_cluster);=

> +    if (mapping =3D=3D NULL) {
> +        return -1;
> +    }

This should be moved below the declarations that still follow here.

> =20
>      int factor =3D 0x10 * s->sectors_per_cluster;
>      int old_cluster_count, new_cluster_count;

[...]

> @@ -3193,6 +3215,7 @@ static int enable_write_target(BlockDriverState *=
bs, Error **errp)
> =20
>      backing =3D bdrv_new_open_driver(&vvfat_write_target, NULL, BDRV_O=
_ALLOW_RDWR,
>                                     &error_abort);
> +    assert(backing);
>      *(void**) backing->opaque =3D s;

I personally wouldn't use an assert() here because it's clear that the
value is dereferenced immediately, so that is the assertion that it is
non-NULL, but I won't give too much of a fight.

The thing is, I believe we should write code for humans, not machines.
Fixing machines to understand what we produce is possible -- fixing
humans is more difficult.

On top of that, it would be a bug if NULL is returned and it would be
good if a static analyzer could catch that case.  Just fully silencing
it with assert() is not ideal.  Ideal would be if it would know that
setting &error_abort to any value crashes the program, and could thus
infer whether this function will actually ever get to return NULL when
&error_abort has been passed to it.

Max

> =20
>      bdrv_set_backing_hd(s->bs, backing, &error_abort);
>=20



--BOG9h3YWN0aM1HT1J5fImGo4yq1lxd2IM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvfjKQACgkQ9AfbAGHV
z0A9sggAhnkClXOirC33XsmF4smXNgXuBAcuLUTmRJikFD5bpphMcRawwKPyrqQ+
elNkYaO/vA6tU6guh2EQ3v0Ay0tcdfPak8kcqlRygBhvh+S7ofpGqOiOHffUri5K
QISj6hM2bZUxc4taszzVVlkJOLQ5bsvpg02bWprXYEDk4fwfg/6YxOMiHxUVbOs1
/ojGyZpLf8TuzSQgsUwNl/kNz5LhR+XVPcfvJE9ZxBLNTd+xWZZywVNWqu8R6566
UDSHWNDVi4MCy8O0vBJwhOpO+gayalKiyYetP00vXU8t4K+Su0GenLL97KmNjINK
SI/xBjZrVMglD8O0Swc8IJaJRhCpcg==
=FJ3E
-----END PGP SIGNATURE-----

--BOG9h3YWN0aM1HT1J5fImGo4yq1lxd2IM--
