Received: from eggs.gnu.org ([2001:4830:134:3::10]:51544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfsfu-0007CT-8d
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfsfr-0006gE-LW
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:59:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfsfr-0006fr-BL
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:59:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02D6C7ACB6
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 18:59:14 +0000 (UTC)
References: <20170810155522.31099-1-berrange@redhat.com>
	<20170810155522.31099-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5e2768ee-17e6-b33d-2787-ab9fb940615f@redhat.com>
Date: Thu, 10 Aug 2017 13:59:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170810155522.31099-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Fg4Bn60KilTWBvddOn3fAWIo9bMeb8v0d"
Subject: Re: [Qemu-devel] [PATCH 02/15] ui: convert common input code to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fg4Bn60KilTWBvddOn3fAWIo9bMeb8v0d
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <5e2768ee-17e6-b33d-2787-ab9fb940615f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/15] ui: convert common input code to
 keycodemapdb
References: <20170810155522.31099-1-berrange@redhat.com>
 <20170810155522.31099-3-berrange@redhat.com>
In-Reply-To: <20170810155522.31099-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 10:55 AM, Daniel P. Berrange wrote:
> Replace the number_to_qcode, qcode_to_number and linux_to_qcode
> tables with automatically generated tables.
>=20
> Missing entries in linux_to_qcode now fixed:

> In additionsome fixes:

s/additionsome/addition, some/

>=20
>  - KEY_PLAYPAUSE now maps to Q_KEY_CODE_AUDIOPLAY, instead of
>    KEY_PLAYCD. KEY_PLAYPAUSE is defined across almost all scancodes
>    sets, while KEY_PLAYCD only appears in AT set1, so the former is
>    a more useful mapping.
>=20
> Missing entries in qcode_to_number now fixed:
>=20
>   Q_KEY_CODE_AGAIN -> 0x85

I didn't research that these mappings are correct in relation to an
official documentation, but trust that you have done due diligence.

> In addition some fixes:
>=20
>  - Q_KEY_CODE_MENU was incorrectly mapped to the compose
>    scancode (0xdd) and is now mapped to 0x9e
>  - Q_KEY_CODE_FIND was mapped to 0xe065 (Search) instead
>    of to 0xe041 (Find)
>  - Q_KEY_CODE_HIRAGANA was mapped to 0x70 (Katakanahiragana)
>    instead of of 0x77 (Hirigana)
>  - Q_KEY_CODE_PRINT was mapped to 0xb7 which is not a defined
>    scan code in AT set 1, it is now mapped to 0x54 (sysrq)
>=20

Are any of these fixes something we need in 2.10 (more likely, as manual
fixes rather than via the git submodule)?  At this point, though, I'm
inclined to say we're deep enough in freeze that if it is not a
regression over 2.9 behavior, it's not worth rushing in the fix to 2.10.

> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/ui/input.h |  11 +-
>  ui/Makefile.objs   |   3 +
>  ui/input-keymap.c  | 326 +++------------------------------------------=
--------
>  3 files changed, 28 insertions(+), 312 deletions(-)
>=20
> +++ b/ui/Makefile.objs
> @@ -54,6 +54,9 @@ KEYCODEMAP_GEN =3D ui/keycodemapdb/tools/keymap-gen
>  KEYCODEMAP_CSV =3D ui/keycodemapdb/data/keymaps.csv
> =20
>  KEYCODEMAP_FILES =3D \
> +		 ui/input-keymap-linux2qcode.c \
> +		 ui/input-keymap-qcode2qnum.c \
> +		 ui/input-keymap-qnum2qcode.c \

My comment on patch 1 complained about regex of [a-zA-Z0-9] - do any of
the keycode names have digits, or can you shorten the regex to [a-zA-Z]?

> -
> -static int number_to_qcode[0x100];
> +#include "ui/input-keymap-linux2qcode.c"
> +#include "ui/input-keymap-qcode2qnum.c"
> +#include "ui/input-keymap-qnum2qcode.c"
> =20
>  int qemu_input_linux_to_qcode(unsigned int lnx)
>  {
> -    assert(lnx < KEY_CNT);
> -    return linux_to_qcode[lnx];

The old code asserted on an out-of-range input,

> +    if (lnx >=3D qemu_input_map_linux2qcode_len) {
> +        return 0;
> +    }
> +    return qemu_input_map_linux2qcode[lnx];

the new code returns 0.  I guess that's okay, though, since the
generated table uses 0 for invalid entries, and there's no implicit
reason why out-of-range input has to assert.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Fg4Bn60KilTWBvddOn3fAWIo9bMeb8v0d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMrP0ACgkQp6FrSiUn
Q2o1uQgAp6GPKFlEK2D0pd7CTejV5KgxquHt1aYBITGWmViDwI3sn4OdPUH3GUX7
2KtAiwMHl184DVxsVa67pO425Ffp8H+iSa0cTWRNC8omBa3akck+P61lp0vTKPyi
3upJdkvRtHsKj90EsvzQ7k8QptAN0UIY5G+nyjGsyk8AtsvNoEEFAh28cS7rZdH4
bg+0kCcgu1wvygXuduQYSxOrvhz2gwgdUt3UrKoAltVv3GReGVWXadVoHYHs9mdH
lX9yrzkYZapXIvIy7dd92aVmLQ24Hvj6LVaVsYllhm+lrK1SJGMdXXXZ4XRDrMUX
G8lk6SVQMtv4r10UKef43/2DxbqQdA==
=5cuj
-----END PGP SIGNATURE-----

--Fg4Bn60KilTWBvddOn3fAWIo9bMeb8v0d--
