Received: from eggs.gnu.org ([2001:4830:134:3::10]:50223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dMaiL-0004Sg-Fz
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 09:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dMaiG-0000Bm-Ko
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 09:58:05 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:35605)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dMaiG-00007S-8i
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 09:58:00 -0400
Date: Sun, 18 Jun 2017 16:57:50 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170618135750.2sxnenwtmcwyhls3@postretch>
References: <20170618082813.8091-1-tobleminer@gmail.com>
	<20170618082813.8091-2-tobleminer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wzz6koalg3deyjow"
Content-Disposition: inline
In-Reply-To: <20170618082813.8091-2-tobleminer@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] Add support for custom fmasks/dmasks
 in 9ps mapped mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tobias Schramm <tobleminer@gmail.com>
Cc: qemu-devel@nongnu.org


--wzz6koalg3deyjow
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 18, 2017 at 10:28:13AM +0200, Tobias Schramm wrote:
>@@ -1469,6 +1472,28 @@ static int local_parse_opts(QemuOpts *opts, struct =
FsDriverEntry *fse)
>
>     fse->path =3D g_strdup(path);
>
>+    fse->fmask =3D SM_LOCAL_MODE_BITS;
>+    if (fmask) {
>+        mask =3D strtol(fmask, NULL, 0);

(Use qemu_strtol(), or maybe parse_uint() since it has to be positive)

If a mode without the '0' prefix is supplied (as required by strtol to=20
parse an octal), the input will be parsed as a decimal and will result=20
in a wrong value. Also, maybe you should check for mask > 0777 and for=20
negative input as well instead of &ing.


>+        if((!mask || mask =3D=3D LONG_MIN || mask =3D=3D LONG_MAX) && err=
no)
>+        {
>+            error_report("Invalid fmask %s specified", fmask);
>+            return -1;
>+	}
>+        fse->fmask =3D ((mode_t)mask) & 0777;
>+    }
>+
>+    fse->dmask =3D SM_LOCAL_DIR_MODE_BITS;
>+    if (dmask) {
>+        mask =3D strtol(dmask, NULL, 0);
>+        if((!mask || mask =3D=3D LONG_MIN || mask =3D=3D LONG_MAX) && err=
no)
>+        {
>+            error_report("Invalid dmask %s specified", dmask);
>+            return -1;
>+	}
>+        fse->dmask =3D ((mode_t)mask) & 0777;

Same here.

>+    }
>+
>     return 0;
> }
>
>diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
>index 96d2683348..40290dbade 100644
>--- a/hw/9pfs/9p.c
>+++ b/hw/9pfs/9p.c
>@@ -3533,6 +3533,9 @@ int v9fs_device_realize_common(V9fsState *s, Error *=
*errp)
>
>     s->ops =3D fse->ops;
>
>+    s->ctx.fmask =3D fse->fmask;
>+    s->ctx.dmask =3D fse->dmask;
>+
>     s->fid_list =3D NULL;
>     qemu_co_rwlock_init(&s->rename_lock);
>
>--=20
>2.13.1
>
>
>

--wzz6koalg3deyjow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllGht4ACgkQc2J8L2kN
9xBLsg//fLGrseKcDkULBBgDFYc/3Heer3mx8TgULpxa70eHPpR0i6Mo716RI6sz
P6IMcs9pqjqwO2yGB4v88IiijxsGnw4HQP9tqTudVpqAyzmRNx2ZiZct8YtLyEgw
mpWvCSc9UCjEKxyTQetY+BiLWEO+Gn7HHf+JyAM4e/hnftj1+mLx9aFBYrTw98Gr
ObBqrAQWBN6JkpHXBTe2F5CInE51pFZLJ46UaC/ZMvh1HbzgQHZHBrYDuDeAZCpK
X9X30IRmj6FIZPn3RjXJkyHvuIhRXJ/y4QBTniiEzygvX3aYwNnbxWcYSK7cnp/d
hjusZrP1oF3beEg7wPk9ZWtq0GtAj801xlNXizvcOTuvdXGoRvMD6vv2Dw6cZ7FO
yt25zLyrUEEiN7eRcHH39jV7UirlJn8bj1tEQbIyY4n6VpQV5JVhTMljN6jjjkhl
FZQ9JehWGON02Jf8+zi1QCEvixSCVW9V9W9+yUORdAi83oXy0zdWyekQLML5DRAi
YsORoNth6XLRThgByU9DNzB9nXNaVUONLVz8Iv+PgBVnCN34f5fIXGSzMUk3xeZF
Q7H93wIE62+3Pbx+KFOHXqOWZBOmz85c58G1CyUl0q0BUHep2/cg2crmuK07cR/v
6ishwPxLRgfcDhh9DPkTYohZHW9ySS6Gyu1pbQGQraAOmj3khfM=
=lUKN
-----END PGP SIGNATURE-----

--wzz6koalg3deyjow--
