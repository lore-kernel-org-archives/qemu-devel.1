Received: from eggs.gnu.org ([2001:4830:134:3::10]:51166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crU2U-0001RS-82
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crU2Q-00032q-Vr
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:34:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crU2Q-00032k-NH
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:34:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F3246AAC6
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 18:34:14 +0000 (UTC)
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
	<1490377482-13337-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aaca538c-40b7-4957-5118-76cf79f43978@redhat.com>
Date: Fri, 24 Mar 2017 13:34:11 -0500
MIME-Version: 1.0
In-Reply-To: <1490377482-13337-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sjOtPk3Hi5idL3HfJ3xGVsw2ui9WkQw4O"
Subject: Re: [Qemu-devel] [PATCH RFC v2 3/9] rbd: Don't limit length of
 parameter values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sjOtPk3Hi5idL3HfJ3xGVsw2ui9WkQw4O
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <aaca538c-40b7-4957-5118-76cf79f43978@redhat.com>
Subject: Re: [PATCH RFC v2 3/9] rbd: Don't limit length of parameter values
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
 <1490377482-13337-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1490377482-13337-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 12:44 PM, Markus Armbruster wrote:
> We laboriously enforce parameter values are between one and some
> arbitrary limit in length.  Only RBD_MAX_IMAGE_NAME_SIZE comes from
> librbd.h, and I'm not sure it applies.  Where the other limits come
> from is unclear.
>=20
> Drop the length checking.  The limits librbd actually imposes must be
> checked by librbd anyway.

And if librbd is NOT doing proper length checks, the bug lies there, not
in qemu.

>=20
> There's one minor complication: BDRVRBDState member name is a
> fixed-size array.  Depends on the length limit.  Make it a pointer to
> a dynamically allocated string.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c | 91 ++++++++++-------------------------------------------=
--------
>  1 file changed, 14 insertions(+), 77 deletions(-)

Wow - you weren't kidding about the checks being laborious.

> -static char *qemu_rbd_next_tok(int max_len,
> -                               char *src, char delim,
> -                               const char *name,
> -                               char **p, Error **errp)
> +static char *qemu_rbd_next_tok(char *src, char delim, char **p)

Getting rid of the forced length means we can't fail - nice.


> @@ -184,27 +161,15 @@ static void qemu_rbd_parse_filename(const char *f=
ilename, QDict *options,
>      qdict_put(options, "pool", qstring_from_str(found_str));
> =20
>      if (strchr(p, '@')) {
> -        found_str =3D qemu_rbd_next_tok(RBD_MAX_IMAGE_NAME_SIZE, p,
> -                                      '@', "object name", &p, &local_e=
rr);
> -        if (local_err) {
> -            goto done;
> -        }
> +        found_str =3D qemu_rbd_next_tok(p, '@', &p);
>          qemu_rbd_unescape(found_str);
>          qdict_put(options, "image", qstring_from_str(found_str));

Unrelated to your patch, and doesn't hold you up, but I'd love to
eventually get in my patch that shortens this pattern to:

qdict_put_str(options, "image", found_str);

(I still need to find time to write up a Coccinelle script to automate
the task; it's 2.10 material now)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--sjOtPk3Hi5idL3HfJ3xGVsw2ui9WkQw4O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1WajAAoJEKeha0olJ0NqHwsIAK4YgR2wo9nU82SOq5dJAKMF
NrqmbbE+bTwz4hH2yXwB+G3tkYPjrrcSpwZWhhzdlgUN1gb+HGKILjye6Y3H2ctG
AukrFk8ZlT2S8/RiuGDumIU2x8EKq71xgh0CAWWGjcjPgz1sPwnvGN2J6CL+/6J9
fAoEMPxG6xXqhz0ii5oR/uZxyN/KQtrWg2a0nmElWYZZPLK3VtY9CME1YryDLYSv
RLEcBVM/ewIJKTpx7/vMcixFuUm2BtKoqF7AS+fucmbTjb+iwUnUmdqmddW5pDQM
XUn163NZzIlqoujho5c6Fgt4kIpbXkMB7BtB8G0Bef1NFbu5AYAloNh877ymWJY=
=IXzg
-----END PGP SIGNATURE-----

--sjOtPk3Hi5idL3HfJ3xGVsw2ui9WkQw4O--
