Received: from eggs.gnu.org ([2001:4830:134:3::10]:50748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f8p3y-00076l-0m
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f8p3x-0008E1-98
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:32:02 -0400
Date: Wed, 18 Apr 2018 17:31:47 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180418173147.07667af9.olaf@aepfle.de>
In-Reply-To: <7df49e91-aa65-d775-78eb-ddf53676dd7f@redhat.com>
References: <20180418145443.6332-1-olaf@aepfle.de>
	<7df49e91-aa65-d775-78eb-ddf53676dd7f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/L+9nLjUvlY6X99WXlriIkU8";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2] configure: require glib-2.24 on Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

--Sig_/L+9nLjUvlY6X99WXlriIkU8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Wed, 18 Apr 2018 10:04:03 -0500
schrieb Eric Blake <eblake@redhat.com>:

> Rather than hacking configure, why not fix util/vfio-helpers.c to avoid
> g_realloc_n()?  We've done it before; see commit 071d405

I can not really test it, this variant may work:

--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -522,8 +522,7 @@ static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOState=
 *s,
=20
     assert(index >=3D 0);
     s->nr_mappings++;
-    s->mappings =3D g_realloc_n(s->mappings, sizeof(s->mappings[0]),
-                              s->nr_mappings);
+    s->mappings =3D g_renew(IOVAMapping *, s->mappings, s->nr_mappings);
     insert =3D &s->mappings[index];
     shift =3D s->nr_mappings - index - 1;
     if (shift) {
@@ -577,8 +576,7 @@ static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IO=
VAMapping *mapping,
     memmove(mapping, &s->mappings[index + 1],
             sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
     s->nr_mappings--;
-    s->mappings =3D g_realloc_n(s->mappings, sizeof(s->mappings[0]),
-                              s->nr_mappings);
+    s->mappings =3D g_renew(IOVAMapping *, s->mappings, s->nr_mappings);
 }
=20
 /* Check if the mapping list is (ascending) ordered. */

Olaf

--Sig_/L+9nLjUvlY6X99WXlriIkU8
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWtdk4wAKCRBdQqD6ppg2
fu8wAJ0ZBInqugyq1jo6DcMEMqwmuHFdDACgn0trvyOVOYzsCHN/fsFeLvrT5pA=
=vguH
-----END PGP SIGNATURE-----

--Sig_/L+9nLjUvlY6X99WXlriIkU8--
