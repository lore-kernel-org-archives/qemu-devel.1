Received: from eggs.gnu.org ([2001:4830:134:3::10]:52178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctb3n-0003G6-Tb
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctb3m-00078A-77
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:28:23 -0400
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eb0d0ff3-7a5a-b052-54d7-f101f8eb53d8@redhat.com>
Date: Thu, 30 Mar 2017 09:28:11 -0500
MIME-Version: 1.0
In-Reply-To: <1490879707-6060-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kM389qJf5lqmodSRImdCDrJnG2f6rQavl"
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 04/10] block: Document -drive
 problematic code and bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kM389qJf5lqmodSRImdCDrJnG2f6rQavl
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com
Message-ID: <eb0d0ff3-7a5a-b052-54d7-f101f8eb53d8@redhat.com>
Subject: Re: [RFC v2 for-2.9 04/10] block: Document -drive problematic code
 and bugs
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
 <1490879707-6060-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1490879707-6060-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 08:15 AM, Markus Armbruster wrote:

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

Did we get the latest round of comment tweaking in here?  I was
expecting to see something along the lines of:

"Caution: accessing 'filename' from @options here is safe, but direct
use of any non-string @options members would be problematic.  When they
come..."

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

Again, wordsmithing might be nice to call out that 'driver' is safe, but
future additions of other accesses must be careful.

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

Again, wordsmithing to mention that bdref_key is safe.

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

Ditto.

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
>      if (g_strcmp0(qdict_get_try_str(options, BDRV_OPT_READ_ONLY), "on"=
) &&
>          !qdict_get_try_bool(options, BDRV_OPT_READ_ONLY, false)) {
>          flags |=3D (BDRV_O_RDWR | BDRV_O_ALLOW_RDWR);

Maybe here, the wordsmithing would mention that the extra hoops we jump
through to cover both types is what makes access safe.

> +++ b/block/nbd.c
> @@ -278,6 +278,14 @@ static SocketAddress *nbd_config(BDRVNBDState *s, =
QDict *options, Error **errp)
>          goto done;
>      }
> =20
> +    /*
> +     * FIXME .numeric, .to, .ipv4 or .ipv6 don't work with -drive
> +     * server.type=3Dinet.  .to doesn't matter, it's ignored anyway.
> +     * That's because when @options come from -blockdev or
> +     * blockdev_add, members are typed according to the QAPI schema,
> +     * but when they come from -drive, they're all QString.  The
> +     * visitor expects the former.
> +     */

This one is fine.

>      iv =3D qobject_input_visitor_new(crumpled_addr);
>      visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
>      if (local_err) {
> diff --git a/block/nfs.c b/block/nfs.c
> index 3f43f6e..42407de 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -474,6 +474,13 @@ static NFSServer *nfs_config(QDict *options, Error=
 **errp)
>          goto out;
>      }
> =20
> +    /*
> +     * Caution: this works only because all scalar members of
> +     * NFSServer are QString in @crumpled_addr.  The visitor expects
> +     * @crumpled_addr to be typed according to the QAPI scherma.  It
> +     * is when @options come from -blockdev or blockdev_add.  But when=

> +     * they come from -drive, they're all QString.
> +     */
>      iv =3D qobject_input_visitor_new(crumpled_addr);

This one is also fine.

>      visit_type_NFSServer(iv, NULL, &server, &local_error);
>      if (local_error) {
> diff --git a/block/rbd.c b/block/rbd.c
> index 498322b..b9a9526 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -384,6 +384,12 @@ static int qemu_rbd_create(const char *filename, Q=
emuOpts *opts, Error **errp)
>          goto exit;
>      }
> =20
> +    /*
> +     * Caution: direct use of non-string @options members is
> +     * problematic.  When they come from -blockdev or blockdev_add,
> +     * members are typed according to the QAPI schema, but when they
> +     * come from -drive, they're all QString.

Here, wordsmithing may be worth mentioning that we are safe because
these are all strings.

> +     */
>      pool       =3D qdict_get_try_str(options, "pool");
>      conf       =3D qdict_get_try_str(options, "conf");
>      clientname =3D qdict_get_try_str(options, "user");
> diff --git a/block/ssh.c b/block/ssh.c
> index 278e66f..471ba8a 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -601,6 +601,14 @@ static InetSocketAddress *ssh_config(QDict *option=
s, Error **errp)
>          goto out;
>      }
> =20
> +    /*
> +     * FIXME .numeric, .to, .ipv4 or .ipv6 don't work with -drive.
> +     * .to doesn't matter, it's ignored anyway.
> +     * That's because when @options come from -blockdev or
> +     * blockdev_add, members are typed according to the QAPI schema,
> +     * but when they come from -drive, they're all QString.  The
> +     * visitor expects the former.
> +     */
>      iv =3D qobject_input_visitor_new(crumpled_addr);

This one's fine.

The overall idea makes sense, but since this is still RFC, and there may
still be wordsmithing to do, I'll wait to give R-b until v3.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--kM389qJf5lqmodSRImdCDrJnG2f6rQavl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3RX7AAoJEKeha0olJ0NqFkAH/iPf5BDBq/EO7T00YT/ctKzI
ef3f0o/gGM0CTx6FDdU2ulKf3DKEUV0Kqtp5Bdq65b11ajOgkEN8smZg6KncFNI6
pv6fyNJBzKxFoHk1pctQcq+W+HB+vRokZtDb9aRHZ1bkO16K7a/jZKftGOdcFpr/
CcK7FlMOw0eRA91jmO234RMIVgyuCDWFe0C1fwWiAIR8hDFxFWOynVmUADXUDR/Y
l5461JEWI1vjPmUsO2blmtzucbekx7XxtYRYuhOq6VXn3mek+sPso8Tm+j40GsRJ
shJH5AMKJDdW15nWyBx+NXTNk3U2BZXGLImVDQ9PWRWCSI3Zjh5vaMSmZEYZk2U=
=/EK5
-----END PGP SIGNATURE-----

--kM389qJf5lqmodSRImdCDrJnG2f6rQavl--
