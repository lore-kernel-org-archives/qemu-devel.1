Received: from eggs.gnu.org ([2001:4830:134:3::10]:40302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciTts-0003CV-CA
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciTtq-0004lq-Vs
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:36:12 -0500
References: <cover.1488220970.git.jcody@redhat.com>
	<fa6a26e1642ad7e593f3a0776a4a021997493f24.1488220970.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b9a328b-5537-d06d-3510-d2d4038347a3@redhat.com>
Date: Mon, 27 Feb 2017 16:35:58 -0600
MIME-Version: 1.0
In-Reply-To: <fa6a26e1642ad7e593f3a0776a4a021997493f24.1488220970.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fQQihQk6GbmhnSx2QlpX5sSTFxM6vtte7"
Subject: Re: [Qemu-devel] [PATCH v2 3/5] block/rbd: parse all options via
 bdrv_parse_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fQQihQk6GbmhnSx2QlpX5sSTFxM6vtte7
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com
Message-ID: <4b9a328b-5537-d06d-3510-d2d4038347a3@redhat.com>
Subject: Re: [PATCH v2 3/5] block/rbd: parse all options via
 bdrv_parse_filename
References: <cover.1488220970.git.jcody@redhat.com>
 <fa6a26e1642ad7e593f3a0776a4a021997493f24.1488220970.git.jcody@redhat.com>
In-Reply-To: <fa6a26e1642ad7e593f3a0776a4a021997493f24.1488220970.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 12:58 PM, Jeff Cody wrote:
> Get rid of qemu_rbd_parsename in favor of bdrv_parse_filename.
> This simplifies a lot of the parsing as well, as we can treat everythin=
g
> a bit simpler since nonexistent options are simply NULL pointers instea=
d
> of empy strings.

s/empy/empty/

>=20
> An important item to note:
>=20
> Ceph has many extra option values that can be specified as key/value
> pairs.  This was handled previously in the driver by extracting the
> values that the QEMU driver cared about, and then blindly passing all
> extra options to rbd after splitting them into key/value pairs, and
> cleaning up any special character escaping.
>=20
> The practice is continued in this patch; there is an option
> "keyvalue-pairs" that is populated with all the key/value pairs that th=
e
> QEMU driver does not care about.  These key/value pairs will override
> any settings in the 'conf' configuration file, just as they did before.=

>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/rbd.c | 298 ++++++++++++++++++++++++++++++----------------------=
--------
>  1 file changed, 148 insertions(+), 150 deletions(-)
>=20

> +
> +    /* The following are essentially all key/value pairs, and we treat=

> +     * 'id' and 'conf' a bit special.  Key/value pairs may be in any o=
rder. */
> +    while (p) {

> +        if (!strcmp(name, "conf")) {
> +            qdict_put(options, "conf", qstring_from_str(value));
> +        } else if (!strcmp(name, "id")) {
> +            qdict_put(options, "user" , qstring_from_str(value));
> +        } else {
> +            char *tmp =3D g_malloc0(max_keypair_size);
> +            /* only use a delimiter if it is not the first keypair fou=
nd */
> +            /* These are sets of unknown key/value pairs we'll pass al=
ong
> +             * to ceph */
> +            if (keypairs[0]) {
> +                snprintf(tmp, max_keypair_size, ":%s=3D%s", name, valu=
e);
> +                pstrcat(keypairs, max_keypair_size, tmp);
> +            } else {
> +                snprintf(keypairs, max_keypair_size, "%s=3D%s", name, =
value);
> +            }
> +            g_free(tmp);
> +        }
> +    }
> +
> +    if (keypairs[0]) {
> +        qdict_put(options, "keyvalue-pairs", qstring_from_str(keypairs=
));

Uggh.  Why are we compressing this into a single string, instead of
using a GList?  True, we aren't exposing it through QAPI, but I still
wonder if a smarter representation than a flat string is warranted.

> @@ -434,35 +421,55 @@ static int qemu_rbd_create(const char *filename, =
QemuOpts *opts, Error **errp)
>      if (objsize) {
>          if ((objsize - 1) & objsize) {    /* not a power of 2? */

Drive-by comment (if you fix it, do it as a separate followup patch): we
have is_power_of_2() to make code like this more legible.

> =20
>  static BlockDriver bdrv_rbd =3D {
> -    .format_name        =3D "rbd",
> -    .instance_size      =3D sizeof(BDRVRBDState),
> -    .bdrv_needs_filename =3D true,
> -    .bdrv_file_open     =3D qemu_rbd_open,
> -    .bdrv_close         =3D qemu_rbd_close,
> -    .bdrv_create        =3D qemu_rbd_create,
> -    .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
> -    .bdrv_get_info      =3D qemu_rbd_getinfo,
> -    .create_opts        =3D &qemu_rbd_create_opts,
> -    .bdrv_getlength     =3D qemu_rbd_getlength,
> -    .bdrv_truncate      =3D qemu_rbd_truncate,
> -    .protocol_name      =3D "rbd",
> +    .format_name            =3D "rbd",
> +    .instance_size          =3D sizeof(BDRVRBDState),
> +    .bdrv_parse_filename    =3D qemu_rbd_parse_filename,
> +    .bdrv_file_open         =3D qemu_rbd_open,
> +    .bdrv_close             =3D qemu_rbd_close,
> +    .bdrv_create            =3D qemu_rbd_create,
> +    .bdrv_has_zero_init     =3D bdrv_has_zero_init_1,
> +    .bdrv_get_info          =3D qemu_rbd_getinfo,
> +    .create_opts            =3D &qemu_rbd_create_opts,

Pointless &; might as well remove it for consistency while touching it.

> +    .bdrv_getlength         =3D qemu_rbd_getlength,
> +    .bdrv_truncate          =3D qemu_rbd_truncate,
> +    .protocol_name          =3D "rbd",
> =20

I don't know if it is worth respinning to change keyvalue-pairs into a
more appropriate data type; given our desire to make blockdev-add stable
for 2.9 and the fact that keyvalue-pairs is not exposed to QAPI, I can
live with passing around a flat string.  You may want to add FIXME
comments to call attention to the fact that we know it is gross but why
we do it anyways.

But since adding comments, and fixing minor things like &, doesn't
change the real meat of this patch, I can live with:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fQQihQk6GbmhnSx2QlpX5sSTFxM6vtte7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtKnOAAoJEKeha0olJ0Nq/LoH/2ajneC9L6DoY6eDnSvci/Fq
2SNsKKrqIK/7TJZqN1V/BEGW7CFHAXOWbBIDAIpM4ia+gLxSF9n+6DpC64vX3z8z
0qDogfsHmkFFohmZAusZuFEgrnt0qbkeYidXPDacCJiR7HY/2oKn27fBE42iiPhi
Ge9WJah79z31YXiieaLmKhOCDYZyeLzu58ZHGRcVks9YtYq/Y22+GbwSzQShm6V9
0qw5mfAiYBUEtSHCGVXKy+rbeXuxJ+w3Jrf2WzBhz5JBfyQh0CiEngDr8KsAyZt3
e9rYSGxrU97AK67O2OMkz3BFvNnel7vIt77ijaI98LYpoXWjkBmFeeqi5DmY0AA=
=yiOK
-----END PGP SIGNATURE-----

--fQQihQk6GbmhnSx2QlpX5sSTFxM6vtte7--
