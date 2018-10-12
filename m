Received: from eggs.gnu.org ([2001:4830:134:3::10]:34744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAz91-00043k-Eu
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 11:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAz8x-0000eI-Ki
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 11:14:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gAz8v-0000ZZ-57
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 11:14:21 -0400
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
	<1535739372-24454-6-git-send-email-Liam.Merwick@oracle.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <371bf85d-8205-69a2-b67b-a41b5fda3a27@redhat.com>
Date: Fri, 12 Oct 2018 17:14:17 +0200
MIME-Version: 1.0
In-Reply-To: <1535739372-24454-6-git-send-email-Liam.Merwick@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DBcj41BjMqdmDzFLXMbIc55ANvarRdFeY"
Subject: Re: [Qemu-devel] [PATCH v3 5/8] block: Fix potential Null pointer
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DBcj41BjMqdmDzFLXMbIc55ANvarRdFeY
From: Max Reitz <mreitz@redhat.com>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Message-ID: <371bf85d-8205-69a2-b67b-a41b5fda3a27@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/8] block: Fix potential Null pointer
 dereferences in vvfat.c
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
 <1535739372-24454-6-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535739372-24454-6-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.08.18 20:16, Liam Merwick wrote:
> The calls to bdrv_new_open_driver(), find_mapping_for_cluster(),
> and array_get_next() may return NULL but it isn't always checked for
> before dereferencing the value returned.
>=20
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
> ---
>  block/vvfat.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>  1 file changed, 56 insertions(+)
>=20
> diff --git a/block/vvfat.c b/block/vvfat.c
> index fc41841a5c3c..0f1f10a2f94b 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -448,6 +448,9 @@ static direntry_t *create_long_filename(BDRVVVFATSt=
ate *s, const char *filename)
> =20
>      for(i=3D0;i<number_of_entries;i++) {
>          entry=3Darray_get_next(&(s->directory));
> +        if (entry =3D=3D NULL) {
> +            continue;
> +        }

This is a bug in array_ensure_allocated().  It uses g_realloc() with a
non-zero size, so that function will never return NULL.  It will rather
abort().

Therefore, array_ensure_allocated() cannot fail.  Consequentially,
array_get_next() cannot fail.

>          entry->attributes=3D0xf;
>          entry->reserved[0]=3D0;
>          entry->begin=3D0;
> @@ -665,6 +668,9 @@ static inline void fat_set(BDRVVVFATState* s,unsign=
ed int cluster,uint32_t value
>      } else {
>          int offset =3D (cluster*3/2);
>          unsigned char* p =3D array_get(&(s->fat), offset);
> +        if (p =3D=3D NULL) {
> +            return;
> +        }

This is only reached if array_get_next() was called before.  Therefore,
this cannot return NULL.

However, an assert(array->pointer); in array_get() can't hurt.

>          switch (cluster&1) {
>          case 0:
>                  p[0] =3D value&0xff;
> @@ -730,6 +736,9 @@ static inline direntry_t* create_short_and_long_nam=
e(BDRVVVFATState* s,
> =20
>      if(is_dot) {
>          entry=3Darray_get_next(&(s->directory));
> +        if (entry =3D=3D NULL) {
> +            return NULL;
> +        }

As above.

>          memset(entry->name, 0x20, sizeof(entry->name));
>          memcpy(entry->name,filename,strlen(filename));
>          return entry;
> @@ -844,6 +853,12 @@ static int read_directory(BDRVVVFATState* s, int m=
apping_index)
>          /* create mapping for this file */
>          if(!is_dot && !is_dotdot && (S_ISDIR(st.st_mode) || st.st_size=
)) {
>              s->current_mapping =3D array_get_next(&(s->mapping));
> +            if (s->current_mapping =3D=3D NULL) {
> +                fprintf(stderr, "Failed to create mapping for file\n")=
;
> +                g_free(buffer);
> +                closedir(dir);
> +                return -2;
> +            }

As above.

>              s->current_mapping->begin=3D0;
>              s->current_mapping->end=3Dst.st_size;
>              /*
> @@ -941,6 +956,9 @@ static int init_directories(BDRVVVFATState* s,
>      /* add volume label */
>      {
>          direntry_t* entry=3Darray_get_next(&(s->directory));
> +        if (entry =3D=3D NULL) {
> +            return -1;
> +        }

As above.

>          entry->attributes=3D0x28; /* archive | volume label */
>          memcpy(entry->name, s->volume_label, sizeof(entry->name));
>      }
> @@ -953,6 +971,9 @@ static int init_directories(BDRVVVFATState* s,
>      s->cluster_count=3Dsector2cluster(s, s->sector_count);
> =20
>      mapping =3D array_get_next(&(s->mapping));
> +    if (mapping =3D=3D NULL) {
> +        return -1;
> +    }

As above.

>      mapping->begin =3D 0;
>      mapping->dir_index =3D 0;
>      mapping->info.dir.parent_mapping_index =3D -1;
> @@ -1630,6 +1651,9 @@ static void schedule_rename(BDRVVVFATState* s,
>          uint32_t cluster, char* new_path)
>  {
>      commit_t* commit =3D array_get_next(&(s->commits));
> +    if (commit =3D=3D NULL) {
> +        return;
> +    }

As above.

>      commit->path =3D new_path;
>      commit->param.rename.cluster =3D cluster;
>      commit->action =3D ACTION_RENAME;
> @@ -1639,6 +1663,9 @@ static void schedule_writeout(BDRVVVFATState* s,
>          int dir_index, uint32_t modified_offset)
>  {
>      commit_t* commit =3D array_get_next(&(s->commits));
> +    if (commit =3D=3D NULL) {
> +        return;
> +    }

As above.

>      commit->path =3D NULL;
>      commit->param.writeout.dir_index =3D dir_index;
>      commit->param.writeout.modified_offset =3D modified_offset;
> @@ -1649,6 +1676,9 @@ static void schedule_new_file(BDRVVVFATState* s,
>          char* path, uint32_t first_cluster)
>  {
>      commit_t* commit =3D array_get_next(&(s->commits));
> +    if (commit =3D=3D NULL) {
> +        return;
> +    }

As above.

>      commit->path =3D path;
>      commit->param.new_file.first_cluster =3D first_cluster;
>      commit->action =3D ACTION_NEW_FILE;
> @@ -1657,6 +1687,9 @@ static void schedule_new_file(BDRVVVFATState* s,
>  static void schedule_mkdir(BDRVVVFATState* s, uint32_t cluster, char* =
path)
>  {
>      commit_t* commit =3D array_get_next(&(s->commits));
> +    if (commit =3D=3D NULL) {
> +        return;
> +    }


As above.

>      commit->path =3D path;
>      commit->param.mkdir.cluster =3D cluster;
>      commit->action =3D ACTION_MKDIR;
> @@ -2261,6 +2294,9 @@ static mapping_t* insert_mapping(BDRVVVFATState* =
s,
>      }
>      if (index >=3D s->mapping.next || mapping->begin > begin) {
>          mapping =3D array_insert(&(s->mapping), index, 1);
> +        if (mapping =3D=3D NULL) {
> +            return NULL;
> +        }

I haven't checked array_insert()'s code for buffer overflows, but just
like the other functions above, it cannot ever return NULL (unless
array->item_size were 0, which it never is), because g_realloc() never
returns NULL.

>          mapping->path =3D NULL;
>          adjust_mapping_indices(s, index, +1);
>      }
> @@ -2428,6 +2464,9 @@ static int commit_direntries(BDRVVVFATState* s,
>      direntry_t* direntry =3D array_get(&(s->directory), dir_index);
>      uint32_t first_cluster =3D dir_index =3D=3D 0 ? 0 : begin_of_diren=
try(direntry);
>      mapping_t* mapping =3D find_mapping_for_cluster(s, first_cluster);=

> +    if (mapping =3D=3D NULL) {
> +        return -1;
> +    }

This looks like a real issue.  I'm not sufficiently proficient in vvfat
to know whether this would warrant an assertion (it looks after the root
directory, which probably just should be there), so I'm OK with just
returning an error here.

However, qemu's codestyle forbids mixing statements with declarations,
so this needs to be moved below all of the declarations that follow still=
=2E

>      int factor =3D 0x10 * s->sectors_per_cluster;
>      int old_cluster_count, new_cluster_count;
> @@ -2494,6 +2533,9 @@ DLOG(fprintf(stderr, "commit_direntries for %s, p=
arent_mapping_index %d\n", mapp
>          direntry =3D array_get(&(s->directory), first_dir_index + i);
>          if (is_directory(direntry) && !is_dot(direntry)) {
>              mapping =3D find_mapping_for_cluster(s, first_cluster);
> +            if (mapping =3D=3D NULL) {
> +                return -1;
> +            }

Looks OK.

>              assert(mapping->mode & MODE_DIRECTORY);
>              ret =3D commit_direntries(s, first_dir_index + i,
>                  array_index(&(s->mapping), mapping));
> @@ -2522,6 +2564,10 @@ static int commit_one_file(BDRVVVFATState* s,
>      assert(offset < size);
>      assert((offset % s->cluster_size) =3D=3D 0);
> =20
> +    if (mapping =3D=3D NULL) {
> +        return -1;
> +    }
> +

Agreed.

(What's going on with the return values in this function?)

>      for (i =3D s->cluster_size; i < offset; i +=3D s->cluster_size)
>          c =3D modified_fat_get(s, c);
> =20
> @@ -2668,6 +2714,9 @@ static int handle_renames_and_mkdirs(BDRVVVFATSta=
te* s)
>          if (commit->action =3D=3D ACTION_RENAME) {
>              mapping_t* mapping =3D find_mapping_for_cluster(s,
>                      commit->param.rename.cluster);
> +            if (mapping =3D=3D NULL) {
> +                return -1;
> +            }
>              char* old_path =3D mapping->path;

Agreed, but needs to be moved below this declaration.

> =20
>              assert(commit->path);
> @@ -2692,6 +2741,9 @@ static int handle_renames_and_mkdirs(BDRVVVFATSta=
te* s)
>                          if (is_file(d) || (is_directory(d) && !is_dot(=
d))) {
>                              mapping_t* m =3D find_mapping_for_cluster(=
s,
>                                      begin_of_direntry(d));
> +                            if (m =3D=3D NULL) {
> +                                return -3;
> +                            }

I wouldn't try to follow the weird style (unless you understand the
reasoning behind it, which I don't). :-)

Just return either -1 or -EIO.

>                              int l =3D strlen(m->path);
>                              char* new_path =3D g_malloc(l + diff + 1);=


And again, needs to be moved below the declarations, although we don't
want to do the g_malloc() before, of course.

> =20
> @@ -3193,6 +3245,10 @@ static int enable_write_target(BlockDriverState =
*bs, Error **errp)
> =20
>      backing =3D bdrv_new_open_driver(&vvfat_write_target, NULL, BDRV_O=
_ALLOW_RDWR,
>                                     &error_abort);
> +    if (!backing) {
> +        ret =3D -EINVAL;
> +        goto err;
> +    }

This cannot return NULL because we pass &error_abort.  Therefore, qemu
will abort before this function returns NULL.

Max

>      *(void**) backing->opaque =3D s;
> =20
>      bdrv_set_backing_hd(s->bs, backing, &error_abort);
>=20



--DBcj41BjMqdmDzFLXMbIc55ANvarRdFeY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvAukkACgkQ9AfbAGHV
z0B7BAf+KUdDe1RlZvq6LHGYDxSsyrd9xhhzJqKd1uSPPAPX6DoNR1+GHGiU9jLT
acCpcPYjPbIeqHzFW5E7EsYzy5NJJvVLZxeUb1OiRT9AFgajRLAzKojfNJzuU4pZ
u4hVL0X5KcfaWpozMj4cJNTBPvDq0uXw5dWafWQTFXg39UkudnSHpEcrSS5Z4h1g
OhTpQzUxJXzwUMedxX6PXEypYY7sa7SW8jtfZOM/iKVg+3T7w6OtR9kL+1vgmLlA
HBZMmsSuAiwUlpB4vhCaahOgNxistsJ/CPx8pdTDo+flfSy9StnZ+2QW9JoKvtAY
+a5lPCroJriDxSISU2yynMGPKjZ1vw==
=8NTl
-----END PGP SIGNATURE-----

--DBcj41BjMqdmDzFLXMbIc55ANvarRdFeY--
