Received: from eggs.gnu.org ([2001:4830:134:3::10]:41901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctJLp-0007kV-Bt
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctJLn-0003lF-EQ
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:33:49 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-5-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5e1790e7-5e12-adc6-a049-ca004682025d@redhat.com>
Date: Wed, 29 Mar 2017 21:33:35 +0200
MIME-Version: 1.0
In-Reply-To: <1490805920-17029-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="paiFLnBxPCHmnMweGcc7HkUfW11oRMd8j"
Subject: Re: [Qemu-devel] [for-2.9 4/8] block: Document -drive problematic
 code and bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--paiFLnBxPCHmnMweGcc7HkUfW11oRMd8j
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com
Message-ID: <5e1790e7-5e12-adc6-a049-ca004682025d@redhat.com>
Subject: Re: [for-2.9 4/8] block: Document -drive problematic code and bugs
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1490805920-17029-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 29.03.2017 18:45, Markus Armbruster wrote:
> -blockdev and blockdev_add convert their arguments via QObject to
> BlockdevOptions for qmp_blockdev_add(), which converts them back to
> QObject, then to a flattened QDict.  The QDict's members are typed
> according to the QAPI schema.
>=20
> -drive converts its argument via QemuOpts to a (flat) QDict.  This
> QDict's members are all QString.
>=20
> Thus, the QType of a flat QDict member depends on whether it comes
> from -drive or -blockdev/blockdev_add, except when the QAPI type maps
> to QString, which is the case for 'str' and enumeration types.
>=20
> The block layer core extracts generic configuration from the flat
> QDict, and the block driver extracts driver-specific configuration.
>=20
> Both commonly do so by converting (parts of) the flat QDict to
> QemuOpts, which turns all values into strings.  Not exactly elegant,
> but correct.
>=20
> However, A few places access the flat QDict directly:
>=20
> * Most of them access members that are always QString.  Correct.
>=20
> * bdrv_open_inherit() accesses a boolean, carefully.  Correct.
>=20
> * nfs_config() uses a QObject input visitor.  Correct only because the
>   visited type contains nothing but QStrings.
>=20
> * nbd_config() and ssh_config() use a QObject input visitor, and the
>   visited types contain non-QStrings: InetSocketAddress members
>   @numeric, @to, @ipv4, @ipv6.  -drive works as long as you don't try
>   to use them (they're all optional).  @to is ignored anyway.
>=20
>   Reproducer:
>   -drive driver=3Dssh,server.host=3Dh,server.port=3D22,server.ipv4,path=
=3Dp
>   -drive driver=3Dnbd,server.type=3Dinet,server.data.host=3Dh,server.da=
ta.port=3D22,server.data.ipv4
>   both fail with "Invalid parameter type for 'data.ipv4', expected: boo=
lean"
>=20
> Add suitable comments to all these places.  Mark the buggy ones FIXME.
>=20
> "Fortunately", -drive's driver-specific options are entirely
> undocumented.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block.c            | 41 +++++++++++++++++++++++++++++++++++++++--
>  block/file-posix.c |  6 ++++++
>  block/nbd.c        |  8 ++++++++
>  block/nfs.c        |  7 +++++++
>  block/rbd.c        |  6 ++++++
>  block/ssh.c        |  8 ++++++++
>  6 files changed, 74 insertions(+), 2 deletions(-)

I have to say I don't like how the comments in block.c are completely
generic.

> diff --git a/block.c b/block.c
> index 6e906ec..b3ce23f 100644
> --- a/block.c
> +++ b/block.c
> @@ -1157,6 +1157,12 @@ static int bdrv_open_common(BlockDriverState *bs=
, BlockBackend *file,
>      if (file !=3D NULL) {
>          filename =3D blk_bs(file)->filename;
>      } else {
> +       /*
> +        * Caution: direct use of non-string @options members is
> +        * problematic.  When they come from -blockdev or blockdev_add,=

> +        * members are typed according to the QAPI schema, but when
> +        * they come from -drive, they're all QString.
> +        */
>          filename =3D qdict_get_try_str(options, "filename");

For instance this one: Well, yes, for -drive, this will always be a
QString. Which is OK, because that's what we're trying to get.

The comment makes this confusing, IMO. If you really want a comment here
it should at least contain a mention that it's totally fine in practice
here. Calling the code "problematic" sounds like this could blow up when
it reality it can't; and I would think it actually is the most sane
solution given the current state of the whole infrastructure (i.e. how
-drive and -blockdev work).

Same for all the other plain qdict_get_try_str() calls (in block.c, at
least).

>      }
> =20
> @@ -1324,6 +1330,12 @@ static int bdrv_fill_options(QDict **options, co=
nst char *filename,
>      BlockDriver *drv =3D NULL;
>      Error *local_err =3D NULL;
> =20
> +    /*
> +     * Caution: direct use of non-string @options members is
> +     * problematic.  When they come from -blockdev or blockdev_add,
> +     * members are typed according to the QAPI schema, but when they
> +     * come from -drive, they're all QString.
> +     */
>      drvname =3D qdict_get_try_str(*options, "driver");
>      if (drvname) {
>          drv =3D bdrv_find_format(drvname);
> @@ -1358,6 +1370,7 @@ static int bdrv_fill_options(QDict **options, con=
st char *filename,
>      }
> =20
>      /* Find the right block driver */
> +    /* Direct use of @options members is problematic, see note above *=
/
>      filename =3D qdict_get_try_str(*options, "filename");
> =20
>      if (!drvname && protocol) {
> @@ -1987,6 +2000,12 @@ int bdrv_open_backing_file(BlockDriverState *bs,=
 QDict *parent_options,
>      qdict_extract_subqdict(parent_options, &options, bdref_key_dot);
>      g_free(bdref_key_dot);
> =20
> +    /*
> +     * Caution: direct use of non-string @parent_options members is
> +     * problematic.  When they come from -blockdev or blockdev_add,
> +     * members are typed according to the QAPI schema, but when they
> +     * come from -drive, they're all QString.
> +     */
>      reference =3D qdict_get_try_str(parent_options, bdref_key);
>      if (reference || qdict_haskey(options, "file.filename")) {
>          backing_filename[0] =3D '\0';
> @@ -2059,6 +2078,12 @@ bdrv_open_child_bs(const char *filename, QDict *=
options, const char *bdref_key,
>      qdict_extract_subqdict(options, &image_options, bdref_key_dot);
>      g_free(bdref_key_dot);
> =20
> +    /*
> +     * Caution: direct use of non-string @options members is
> +     * problematic.  When they come from -blockdev or blockdev_add,
> +     * members are typed according to the QAPI schema, but when they
> +     * come from -drive, they're all QString.
> +     */
>      reference =3D qdict_get_try_str(options, bdref_key);
>      if (!filename && !reference && !qdict_size(image_options)) {
>          if (!allow_none) {
> @@ -2275,8 +2300,11 @@ static BlockDriverState *bdrv_open_inherit(const=
 char *filename,
>      }
> =20
>      /* Set the BDRV_O_RDWR and BDRV_O_ALLOW_RDWR flags.
> -     * FIXME: we're parsing the QDict to avoid having to create a
> -     * QemuOpts just for this, but neither option is optimal. */
> +     * Caution: direct use of non-string @options members is
> +     * problematic.  When they come from -blockdev or blockdev_add,
> +     * members are typed according to the QAPI schema, but when they
> +     * come from -drive, they're all QString.
> +     */

Now this one should mention that this is the very reason why we are
attempting parsing the QDict string before getting a boolean value direct=
ly.

>      if (g_strcmp0(qdict_get_try_str(options, BDRV_OPT_READ_ONLY), "on"=
) &&
>          !qdict_get_try_bool(options, BDRV_OPT_READ_ONLY, false)) {
>          flags |=3D (BDRV_O_RDWR | BDRV_O_ALLOW_RDWR);
> @@ -2298,6 +2326,7 @@ static BlockDriverState *bdrv_open_inherit(const =
char *filename,
>      options =3D qdict_clone_shallow(options);
> =20
>      /* Find the right image format driver */
> +    /* Direct use of @options members is problematic, see note above *=
/
>      drvname =3D qdict_get_try_str(options, "driver");
>      if (drvname) {
>          drv =3D bdrv_find_format(drvname);
> @@ -2309,6 +2338,7 @@ static BlockDriverState *bdrv_open_inherit(const =
char *filename,
> =20
>      assert(drvname || !(flags & BDRV_O_PROTOCOL));
> =20
> +    /* Direct use of @options members is problematic, see note above *=
/
>      backing =3D qdict_get_try_str(options, "backing");
>      if (backing && *backing =3D=3D '\0') {
>          flags |=3D BDRV_O_NO_BACKING;
> @@ -2787,6 +2817,13 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_=
state, BlockReopenQueue *queue,
>          do {
>              QString *new_obj =3D qobject_to_qstring(entry->value);
>              const char *new =3D qstring_get_str(new_obj);
> +           /*
> +            * Caution: direct use of non-string bs->options members is=

> +            * problematic.  When they come from -blockdev or
> +            * blockdev_add, members are typed according to the QAPI
> +            * schema, but when they come from -drive, they're all
> +            * QString.
> +            */
>              const char *old =3D qdict_get_try_str(reopen_state->bs->op=
tions,
>                                                  entry->key);
> =20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 0841a08..738541e 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2193,6 +2193,12 @@ static int hdev_open(BlockDriverState *bs, QDict=
 *options, int flags,
>      int ret;
> =20
>  #if defined(__APPLE__) && defined(__MACH__)
> +    /*
> +     * Caution: direct use of non-string @options members is
> +     * problematic.  When they come from -blockdev or blockdev_add,
> +     * members are typed according to the QAPI schema, but when they
> +     * come from -drive, they're all QString.
> +     */
>      const char *filename =3D qdict_get_str(options, "filename");

This comment I'm very much OK with, though, because we should not
retrieve runtime options directly from the QDict.

(Same for the comments in the other block drivers.)

Max

>      char bsd_path[MAXPATHLEN] =3D "";
>      bool error_occurred =3D false;



--paiFLnBxPCHmnMweGcc7HkUfW11oRMd8j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljcDA8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AbyQH/0Ocju3EJ+sNChRuZUOD8xiqh5FEAjMB
CEl8pjJY7kPHLBjJK85EF/plCzsaWMQFrWRe0du3u51+Q8A6/Zabh2Z64WLW0qIH
Pc30Mx9eA+390D7QU62Ox9XucKq4nj6g3xCVlWqDd3ym9QdPkthN1o4czbDRrb0X
THLqwf0W+yeJ5LPX/cQfXB1jM4W1mDvFQoA/tRZ+g3XYmxVV5C4UW/1EnKuWKPj8
y02HiCdLc6t5Mn4ub+3G0er8hpJQeeM6IFB2Ne7GJahuvCOO5JkI+xbK/H8mr+o8
8/7nP5KXupn9su+9KFhynuAp4ZAqkdwA/oGyBbA1jIIzMnje5DU5lE8=
=sMUR
-----END PGP SIGNATURE-----

--paiFLnBxPCHmnMweGcc7HkUfW11oRMd8j--
