Received: from eggs.gnu.org ([2001:4830:134:3::10]:36105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9sU7-00045G-LO
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9sU6-0002ek-R0
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:55:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g9sU6-0002e8-JG
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:55:38 -0400
Date: Tue, 9 Oct 2018 14:55:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181009135534.GF22838@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-6-berrange@redhat.com>
	<w51sh1f8bwq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w51sh1f8bwq.fsf@maestria.local.igalia.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] crypto: convert xts_mult_x to use
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

On Tue, Oct 09, 2018 at 03:52:53PM +0200, Alberto Garcia wrote:
> On Tue 09 Oct 2018 02:55:40 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> > -static void xts_mult_x(uint8_t *I)
> > +static void xts_mult_x(xts_uint128 *I)
> >  {
> > -    int x;
> > -    uint8_t t, tt;
> > +    uint64_t tt;
> > =20
> > -    for (x =3D t =3D 0; x < 16; x++) {
> > -        tt =3D I[x] >> 7;
> > -        I[x] =3D ((I[x] << 1) | t) & 0xFF;
> > -        t =3D tt;
> > -    }
> > -    if (tt) {
> > -        I[0] ^=3D 0x87;
> > +    tt =3D I->a >> 63;
> > +    I->a =3D I->a << 1;
> > +
> > +    if (I->b >> 63) {
> > +        I->a ^=3D 0x87;
> >      }
> > +    I->b =3D (I->b << 1) | tt;
> >  }
>=20
> Does this work fine in big-endian CPUs?

Hmm, that's a good question. I'd expect tests/test-crypto-xts to crash
and burn if it doesn't, so guess I'll need to find somewhere to validate
that.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
