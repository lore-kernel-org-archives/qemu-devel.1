Received: from eggs.gnu.org ([2001:4830:134:3::10]:33034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9tb3-0004JP-3F
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9tal-0002dd-Hj
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:06:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g9tak-0002an-Qt
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:06:35 -0400
Date: Tue, 9 Oct 2018 16:06:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181009150629.GK22838@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-5-berrange@redhat.com>
	<w51h8hv88og.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w51h8hv88og.fsf@maestria.local.igalia.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] crypto: convert xts_tweak_encdec to
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

On Tue, Oct 09, 2018 at 05:02:39PM +0200, Alberto Garcia wrote:
> On Tue 09 Oct 2018 02:55:39 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> > Using 64-bit arithmetic increases the performance for xts-aes-128
> > when built with gcrypt:
> >
> >   Encrypt: 235 MB/s -> 320 MB/s
> >   Decrypt: 245 MB/s -> 325 MB/s
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  crypto/xts.c | 52 +++++++++++++++++++++++++++++++++-----------------=
--
> >  1 file changed, 33 insertions(+), 19 deletions(-)
> >
> > diff --git a/crypto/xts.c b/crypto/xts.c
> > index ded4365191..f109c8a3ee 100644
> > --- a/crypto/xts.c
> > +++ b/crypto/xts.c
> > @@ -31,6 +31,12 @@ typedef struct {
> >      uint64_t b;
> >  } xts_uint128;
> > =20
> > +#define xts_uint128_xor(D, S1, S2)              \
> > +    do {                                        \
> > +        (D)->a =3D (S1)->a ^ (S2)->a;             \
> > +        (D)->b =3D (S1)->b ^ (S2)->b;             \
> > +    } while (0)
> > +
> >  static void xts_mult_x(uint8_t *I)
> >  {
> >      int x;
> > @@ -59,25 +65,19 @@ static void xts_mult_x(uint8_t *I)
> >   */
> >  static void xts_tweak_encdec(const void *ctx,
> >                               xts_cipher_func *func,
> > -                             const uint8_t *src,
> > -                             uint8_t *dst,
> > -                             uint8_t *iv)
> > +                             const xts_uint128 *src,
> > +                             xts_uint128 *dst,
> > +                             xts_uint128 *iv)
> >  {
> > -    unsigned long x;
> > -
> >      /* tweak encrypt block i */
> > -    for (x =3D 0; x < XTS_BLOCK_SIZE; x++) {
> > -        dst[x] =3D src[x] ^ iv[x];
> > -    }
> > +    xts_uint128_xor(dst, src, iv);
> > =20
> > -    func(ctx, XTS_BLOCK_SIZE, dst, dst);
> > +    func(ctx, XTS_BLOCK_SIZE, (uint8_t *)dst, (uint8_t *)dst);
>=20
> In the line of what I said earlier, perhaps it's clearer if you leave
> everything as uint8_t * and simply make xts_uint128_xor() treat the
> array as xts_uint128 internally.
>=20
> >      for (i =3D 0; i < lim; i++) {
> > -        xts_tweak_encdec(datactx, decfunc, src, dst, (uint8_t *)&T);
> > +        xts_uint128 S, D;
> > +
> > +        memcpy(&S, src, XTS_BLOCK_SIZE);
> > +        xts_tweak_encdec(datactx, decfunc, &S, &D, &T);
> > +        memcpy(dst, &D, XTS_BLOCK_SIZE);
>=20
> Why do you need S and D?

I think src & dst pointers can't be guaranteed to be aligned sufficiently
for int64 operations, if we just cast from uint8t*.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
