Received: from eggs.gnu.org ([2001:4830:134:3::10]:39391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCPlW-0008DC-Og
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCPlV-00056F-34
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gCPlS-0004pN-Ca
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:52:02 -0400
Date: Tue, 16 Oct 2018 14:51:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181016135147.GG7995@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181016100918.21030-1-berrange@redhat.com>
	<20181016100918.21030-5-berrange@redhat.com>
	<w51efcqyr5v.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w51efcqyr5v.fsf@maestria.local.igalia.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/8] crypto: convert xts_tweak_encdec to
 use xts_uint128 type
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

On Tue, Oct 16, 2018 at 03:09:16PM +0200, Alberto Garcia wrote:
> On Tue 16 Oct 2018 12:09:14 PM CEST, Daniel P. Berrang=C3=A9 wrote:
>=20
> > @@ -110,20 +111,34 @@ void xts_decrypt(const void *datactx,
> >      /* encrypt the iv */
> >      encfunc(tweakctx, XTS_BLOCK_SIZE, T.b, iv);
> > =20
> > -    for (i =3D 0; i < lim; i++) {
> > -        xts_tweak_encdec(datactx, decfunc, src, dst, T.b);
> > -
> > -        src +=3D XTS_BLOCK_SIZE;
> > -        dst +=3D XTS_BLOCK_SIZE;
> > +    if (QEMU_PTR_IS_ALIGNED(src, sizeof(uint64_t)) &&
> > +        QEMU_PTR_IS_ALIGNED(dst, sizeof(uint64_t))) {
> > +        xts_uint128 *S =3D (xts_uint128 *)src;
> > +        xts_uint128 *D =3D (xts_uint128 *)dst;
> > +        for (i =3D 0; i < lim; i++, S++, D++) {
> > +            xts_tweak_encdec(datactx, decfunc, S, D, &T);
> > +        }
> > +    } else {
> > +        xts_uint128 S, D;
> > +
> > +        for (i =3D 0; i < lim; i++) {
> > +            memcpy(&S, src, XTS_BLOCK_SIZE);
> > +            xts_tweak_encdec(datactx, decfunc, &S, &D, &T);
> > +            memcpy(dst, &D, XTS_BLOCK_SIZE);
> > +            src +=3D XTS_BLOCK_SIZE;
> > +            dst +=3D XTS_BLOCK_SIZE;
> > +        }
>=20
> The patch looks good to me, but a couple of comments:
>=20
> - As far as I can see xts_tweak_encdec() works the same regardless of
>   whether src and dst point to the same address or not. As a matter of
>   fact both qcrypto_block_decrypt() and qcrypto_block_encrypt() do the
>   decryption and encryption in place, and as you can see the
>   qcrypto_cipher_*crypt() calls in crypto/block.c pass the same buffer
>   as input and output.
>=20
>   So instead of having S and D you should be fine with just one of them=
.

Yes, I could do that in the 2nd loop.

>=20
> - I think this is just a matter of style preference, but in the first
>   for loop you can remove the comma operator (i++, S++, D++) and use
>   S[i] and D[I] instead in the line after that. I'm fine if you prefer
>   the current style, though.

The syntax I used results in slightly more efficient asm code.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
