Received: from eggs.gnu.org ([2001:4830:134:3::10]:57336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9tTo-00076G-El
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9tTA-0005Ur-BJ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:59:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g9tT9-0005UD-Vq
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:58:44 -0400
Date: Tue, 9 Oct 2018 15:58:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181009145839.GJ22838@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-4-berrange@redhat.com>
	<w51k1mr8993.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w51k1mr8993.fsf@maestria.local.igalia.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] crypto: introduce a xts_uint128 data
 type
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

On Tue, Oct 09, 2018 at 04:50:16PM +0200, Alberto Garcia wrote:
> On Tue 09 Oct 2018 02:55:38 PM CEST, Daniel P. Berrang=C3=A9 wrote:
>=20
> > @@ -85,7 +90,7 @@ void xts_decrypt(const void *datactx,
> >                   uint8_t *dst,
> >                   const uint8_t *src)
> >  {
> > -    uint8_t PP[XTS_BLOCK_SIZE], CC[XTS_BLOCK_SIZE], T[XTS_BLOCK_SIZE=
];
> > +    xts_uint128 PP, CC, T;
> >      unsigned long i, m, mo, lim;
>=20
>    [...]
>=20
> >          /* Pm =3D first length % XTS_BLOCK_SIZE bytes of PP */
> >          for (i =3D 0; i < mo; i++) {
> > -            CC[i] =3D src[XTS_BLOCK_SIZE + i];
> > -            dst[XTS_BLOCK_SIZE + i] =3D PP[i];
> > +            ((uint8_t *)&CC)[i] =3D src[XTS_BLOCK_SIZE + i];
> > +            dst[XTS_BLOCK_SIZE + i] =3D ((uint8_t *)&PP)[i];
> >          }
>=20
> On second thoughts, these casts are a bit cumbersome. I wonder if it
> isn't better to keep the array a uint8_t[] and only treat it as
> xts_uint128 in the places where you actually do 64-bit operations
> (xts_uint128_xor, xts_mult_x).

I had done that originally, but it just shifts ugly casts from one
place to another place in the code. I preferred the idea of storing
it all as a 128bit data type since that's matching the operational
block size.

A further alternative is for xts_uint128 to be a union providing
both, and then have an extra level of access for respective fields,
which I had also tried at one time but ultimately i decided I didn't
mind the casts.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
