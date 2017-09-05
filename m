Received: from eggs.gnu.org ([2001:4830:134:3::10]:45855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpKmc-0000xx-Sz
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 16:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpKmX-0006oh-Tu
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 16:49:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpKmX-0006oH-K1
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 16:49:13 -0400
References: <20170904090310.22530-1-marcandre.lureau@redhat.com>
	<1931f0be-40ce-49b8-02e4-0d98801091ae@redhat.com>
	<CAJ+F1CLaz9KsPWG+_h1H=dwmY0EgAfcq6r2dAJvfvJz8JB5cBA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <49cae611-f2fc-e6ef-d122-b498f20c05d8@redhat.com>
Date: Tue, 5 Sep 2017 15:49:08 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLaz9KsPWG+_h1H=dwmY0EgAfcq6r2dAJvfvJz8JB5cBA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AlujHFJkDGRgXud5HuA831vu5QghP8ib1"
Subject: Re: [Qemu-devel] [PATCH] build-sys: generate tests/.gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AlujHFJkDGRgXud5HuA831vu5QghP8ib1
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com
Message-ID: <49cae611-f2fc-e6ef-d122-b498f20c05d8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] build-sys: generate tests/.gitignore
References: <20170904090310.22530-1-marcandre.lureau@redhat.com>
 <1931f0be-40ce-49b8-02e4-0d98801091ae@redhat.com>
 <CAJ+F1CLaz9KsPWG+_h1H=dwmY0EgAfcq6r2dAJvfvJz8JB5cBA@mail.gmail.com>
In-Reply-To: <CAJ+F1CLaz9KsPWG+_h1H=dwmY0EgAfcq6r2dAJvfvJz8JB5cBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 05:42 AM, Marc-Andr=C3=A9 Lureau wrote:
>=20
> I understand the feeling, I do also mostly out of tree build. However, =
I
> don't think it makes much sense to generate .gitignore in the build dir=
=2E
> It's git related, and in the git source dir, you have .git that is writ=
able
> already: it'd be odd that the git wortree/srcdir is read-only, and the
> point is to generate .gitignore. Not so true with tarballs though.
>=20
> I wrote this patch inspired by how the
> https://github.com/behdad/git.mk/blob/master/git.mk rules does it (it i=
s
> uses by many GNOME projects and others with autoconf). The way it gets =
away
> with not touching the srcdir in non-git tree, is that the git.mk file i=
s
> not shipped in distributed tarball. We could have a similar approach if=

> necessary.

Shipping .gitignore in the tarball is not necessary; it's main benefit
is for in-tree development.

>=20
> Another alternative, which I find much less appealing, is that qemu tre=
e
> keeps shipping .gitignore, and we just add a manual rule to maintain it=
=2E

Keeping .gitignore in git, if it is generated, is a pain, because then
we have to manually resync it every time it gets out of date (and we're
already demonstrating that we forget to update .gitignore with new
tests).  This patch is only worthwhile if it reduces maintainer
overhead, but not if it trades one task for another.

>=20
> You suggested using more test* *test etc wildcards. I think this is bad=
, I
> would rather have a precise .gitignore, and not ignore extra files that=
 are
> not part of the build-system. I couldn't find a simple way to generate
> precise rules for intermediary files (like .o etc), but for end targets=
,
> this patch demonstrates it can be done quite easily.
>=20
> Finally, there is this trend these days with meson to not even allow
> in-tree build, and thus no need for .gitignore..

Please don't go the direction of forbidding in-tree builds.  While I am
a BIG fan of VPATH builds, I'm also a big fan of in-tree builds (it's
slightly faster to do a one-off in-tree build of a fresh git checkout
than it is to set up yet another VPATH build directory).  Projects that
force one way or the other are annoying.  I see no reason why we should
not keep both approaches working, particularly if we have patchew or
other automation that covers both styles.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AlujHFJkDGRgXud5HuA831vu5QghP8ib1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmvDcQACgkQp6FrSiUn
Q2qOJQf/dWADwJIpD6kzZc7Bt1dkfFn6yKyTLwIzA9o5oAGJUTL+3Hug/kV7qIR5
AKT9bMCajU1rfetDO4a6SbMux/2Jpq9pLK8sKjUJR6oWzZLDov9JBc3jYhLNK5o8
t9RryaKsUIcpUWovvKmG2doKVD55rz3+Xj5CJ3KkPtfPgP+0F7Pmb6864P8E+UqU
OsDHn2gE09oBUn37nw3ec1aVn3CpVLAk9abn6A8zgW8BEdJOq4wlE9WQ9Xm2dBCf
CmCJ73HSMvUNOMoYoj8m87pA2NfFa1f4UPguE8mBHbiO1xyn7fb5Uka2wCxilHGr
jtEUUqNTJVStjmNJQqZernl9P2A7Lg==
=5Ndl
-----END PGP SIGNATURE-----

--AlujHFJkDGRgXud5HuA831vu5QghP8ib1--
