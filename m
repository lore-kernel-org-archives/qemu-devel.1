Received: from eggs.gnu.org ([2001:4830:134:3::10]:52299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAGcO-0003s2-6R
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAGcN-0002Wk-5B
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:05:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dAGcM-0002WH-SZ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:04:59 -0400
References: <20170512233843.27713-1-f4bug@amsat.org>
	<20170512233843.27713-2-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b5660d99-c854-1930-8806-5989c69f90d1@redhat.com>
Date: Mon, 15 May 2017 09:04:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170512233843.27713-2-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rijcuKPmNJDOiNnBUJvkOj7rwWxhM8Sso"
Subject: Re: [Qemu-devel] [RFC PATCH v4 1/6] coccinelle: add a script to
 optimize tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Elfring <elfring@users.sourceforge.net>, Julia Lawall <julia.lawall@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rijcuKPmNJDOiNnBUJvkOj7rwWxhM8Sso
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Elfring <elfring@users.sourceforge.net>,
 Julia Lawall <julia.lawall@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <b5660d99-c854-1930-8806-5989c69f90d1@redhat.com>
Subject: Re: [RFC PATCH v4 1/6] coccinelle: add a script to optimize tcg op
 using tcg_gen_extract()
References: <20170512233843.27713-1-f4bug@amsat.org>
 <20170512233843.27713-2-f4bug@amsat.org>
In-Reply-To: <20170512233843.27713-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/12/2017 06:38 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> If you have coccinelle installed you can apply this script using:
>=20
>     $ spatch \
>         --macro-file scripts/cocci-macro-file.h \
>         --dir target --in-place
>=20
> You can also use directly Peter Senna Tschudin docker image (easier):
>=20
>     $ docker run -v `pwd`:`pwd` -w `pwd` petersenna/coccinelle \
>         --sp-file scripts/coccinelle/tcg_gen_extract.cocci \
>         --macro-file scripts/cocci-macro-file.h \
>         --dir target --in-place
>=20
> Then verified that no manual touchups are required.
>=20
> The following thread was helpful while writing this script:
>=20
>     https://github.com/coccinelle/coccinelle/issues/86
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/coccinelle/tcg_gen_extract.cocci | 103 +++++++++++++++++++++++=
++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci

It's still not obvious to me whether we want this script in the tree (as
something we plan to rerun regularly to check for regressions), or just
in the commit message (useful for the one-time location of spots to
optimize, but something we don't anticipate repeating).


> +@@
> +import sys
> +fd =3D sys.stderr
> +def debug(msg=3D"", trailer=3D"\n"):
> +    fd.write("[DBG] " + msg + trailer)
> +def low_bits_count(value):
> +    bits_count =3D 0
> +    while (value & (1 << bits_count)):
> +        bits_count +=3D 1

Surely python has a faster method than this (after all, we have ctz and
friends in C code)?  But my python is limited enough that I don't know
of one off-hand.

> +    return bits_count
> +def Mn(order): # Mersenne number
> +    return (1 << order) - 1

Correct name...


> +else:
> +    debug("candidate at %s:%s" % (shr_p[0].file, shr_p[0].line))
> +    try: # only eval integer, no #define like 'SR_M' (cpp did this, el=
se some headers are missing).
> +        msk_v =3D long(msk_s.strip("UL"), 0)
> +        msk_b =3D low_bits_count(msk_v)
> +        if msk_b =3D=3D 0:
> +            debug("  value: 0x%x low_bits: %d" % (msk_v, msk_b))
> +        else:
> +            debug("  value: 0x%x low_bits: %d [Mersenne prime: 0x%x]" =
% (msk_v, msk_b, Mn(msk_b)))

=2E..but this name is still wrong.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rijcuKPmNJDOiNnBUJvkOj7rwWxhM8Sso
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGbWFAAoJEKeha0olJ0NqjkMH/AhS5UqicQ8Rm98KUT9XXG6j
wEwe8PJ5Yp+mU0zA5FOK42uKilaaTMbpiTbn9vxmpYslyK/Luj/Hn4KmaaMRAu7g
0u+Xo8men5vH1TDzLme5AJwOUg1SsQwCXKGCB+tGNRzbPzPdGh0ColQAfcEnNQGr
uSj2RRFudf6UeJeqoo0nApgCJY8t5wylNO7DzhQ5eUB26ileX7VFryY5YaTl2+uy
XaJPq4klGooqG5gSLJuMKbT2z6YULt3rAlUxE9u0BYgZGPwtqB4t/b5+qhb4Kwri
Jjnu0MncszZS5pf3h7tNDvqWFMQQSUTI2wEdlg//kHELu17jwoLfvAJ613HGQJ4=
=+ybQ
-----END PGP SIGNATURE-----

--rijcuKPmNJDOiNnBUJvkOj7rwWxhM8Sso--
