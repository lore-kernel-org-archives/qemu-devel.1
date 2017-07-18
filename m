Received: from eggs.gnu.org ([2001:4830:134:3::10]:51394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXUH6-0002WR-KL
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXUH3-00059o-GU
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:19:00 -0400
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-2-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0c9eec4e-729c-424b-36a8-d9d8df153cff@redhat.com>
Date: Tue, 18 Jul 2017 10:18:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-2-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1eOTEChltT9n8VamSbFEjjDQgVCDoqXkW"
Subject: Re: [Qemu-devel] [PATCH 01/29] coccinelle: add a script to enforce
 qemu/osdep.h macros usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1eOTEChltT9n8VamSbFEjjDQgVCDoqXkW
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <0c9eec4e-729c-424b-36a8-d9d8df153cff@redhat.com>
Subject: Re: [PATCH 01/29] coccinelle: add a script to enforce qemu/osdep.h
 macros usage
References: <20170718061005.29518-1-f4bug@amsat.org>
 <20170718061005.29518-2-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 01:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Might be worth mentioning which macros in the commit message body, so
that a grep of 'git log' spots this commit easier.

> ---
>  scripts/coccinelle/use_osdep.cocci | 60 ++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 scripts/coccinelle/use_osdep.cocci
>=20
> +// docker run --rm -v `pwd`:`pwd` -w `pwd` philmd/coccinelle \
> +//     --macro-file scripts/cocci-macro-file.h \
> +//     --sp-file scripts/coccinelle/add_osdep.cocci \
> +//     --keep-comments --in-place \
> +//     --use-gitgrep --dir .

Is '--use-gitgrep' a relatively new option to spatch (not present in my
F26 coccinelle-1.0.6-7), or is it a directive specific to the docker
coccinelle package you are using?  It's somewhat nice if there is a
clean separation between which arguments are for spatch and which are
for docker.

> +
> +// Use QEMU_IS_ALIGNED()
> +@@
> +typedef uintptr_t;
> +uintptr_t ptr;
> +expression n, m;
> +@@
> +(
> +-ptr % m =3D=3D 0
> ++QEMU_PTR_IS_ALIGNED(ptr, m)
> +|
> +-n % m =3D=3D 0
> ++QEMU_IS_ALIGNED(n, m)
> +)

Is it worth also trying to flag '(n & (m - 1)) =3D=3D 0' (for when m is a=

power of 2)?

> +
> +// Use QEMU_ALIGN_DOWN()
> +@@
> +expression n, m;
> +@@
> +-n / m * m
> ++QEMU_ALIGN_DOWN(n, m)

Is it worth also trying to catch (n >> m) << m?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1eOTEChltT9n8VamSbFEjjDQgVCDoqXkW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluJtoACgkQp6FrSiUn
Q2qiegf+JthkdEoOAXOLB2+CyG4FS36og8AlZBb3A4v+vZtb9rkffICQQmVEoosf
4cG5PgJ6H815PN4fT2oe5PY5CFwiFeDVJ5O2P4EQeqBAkj6NZE8AmcuIlSbgXTH0
OCmiOwNAi33leStC/zMKns1XpJVLY4UWSttTshjorSRrWMCmtydyMVvjSE2lXmjC
OIv7TWnuWYRygcaxaUSDW34Y9pvE6em139A2HJ15n5W1kPemOim6RomwF/UGab83
PUdpCZH6nZmszeherde4vNaPzxETdHSmzK53MkhZEW8Ca5nlp7qA7EstHy7qQgqS
uzP+7u4U6S6QD5/lPYRfnF8rU1n1Cg==
=k2pg
-----END PGP SIGNATURE-----

--1eOTEChltT9n8VamSbFEjjDQgVCDoqXkW--
