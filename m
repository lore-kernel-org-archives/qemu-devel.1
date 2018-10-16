Received: from eggs.gnu.org ([2001:4830:134:3::10]:42067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCPsn-0004QP-3A
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCPsj-0004gQ-0M
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:59:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gCPsi-0004dl-Pa
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:59:32 -0400
Date: Tue, 16 Oct 2018 14:59:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181016135927.GH7995@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181016100918.21030-1-berrange@redhat.com>
	<20181016100918.21030-6-berrange@redhat.com>
	<w51bm7uypyy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w51bm7uypyy.fsf@maestria.local.igalia.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/8] crypto: convert xts_mult_x to use
 xts_uint128 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org

On Tue, Oct 16, 2018 at 03:35:01PM +0200, Alberto Garcia wrote:
> On Tue 16 Oct 2018 12:09:15 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> > Using 64-bit arithmetic increases the performance for xts-aes-128
> > when built with gcrypt:
> >
> >   Encrypt: 355 MB/s -> 545 MB/s
> >   Decrypt: 362 MB/s -> 568 MB/s
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> This patch is also fine, but I have a couple of minor comments:
>=20
> > +static void xts_mult_x(xts_uint128 *I)
> > +{
> > +    uint64_t tt;
> > +
> > +    xts_uint128_cpu_to_les(I);
> > +
> > +    tt =3D I->u[0] >> 63;
> > +    I->u[0] =3D I->u[0] << 1;
>=20
> Perhaps I->u[0] <<=3D 1 , for clarity and consistency with the followin=
g
> line (I->u[0] ^=3D 0x87) ? But I don't mind if you prefer to keep it as=
 is
> now.

In fact I could do the following:

@@ -59,12 +59,13 @@ static void xts_mult_x(xts_uint128 *I)
     xts_uint128_cpu_to_les(I);
=20
     tt =3D I->u[0] >> 63;
-    I->u[0] =3D I->u[0] << 1;
+    I->u[0] <<=3D 1;
=20
     if (I->u[1] >> 63) {
         I->u[0] ^=3D 0x87;
     }
-    I->u[1] =3D (I->u[1] << 1) | tt;
+    I->u[1] <<=3D 1;
+    I->u[1] |=3D tt;
=20
     xts_uint128_le_to_cpus(I);
 }

either way it generates the exact same asm code

>=20
> > +    if (I->u[1] >> 63) {
> > +        I->u[0] ^=3D 0x87;
> >      }
> > +    I->u[1] =3D (I->u[1] << 1) | tt;
> > +
> > +    xts_uint128_le_to_cpus(I);
>=20
> I think both endianness conversion calls should be flipped. First you
> convert from the buffer byte order (LE) to the CPU byte order so you ca=
n
> do the bit shifts, then back to the original byte order (LE).
>=20
> Changing this doesn't have any practical effect because both calls
> perform the exact same operation, but it documents better what's going
> on.

Yep, ok

> With this changed,
>=20
> Reviewed-by: Alberto Garcia <berto@igalia.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
