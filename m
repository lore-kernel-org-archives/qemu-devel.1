Received: from eggs.gnu.org ([2001:4830:134:3::10]:43948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9sxB-0000gN-EY
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9sx4-0006oX-Ao
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:25:41 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:55837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1g9sx3-0006n4-QJ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:25:34 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181009135534.GF22838@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-6-berrange@redhat.com>
	<w51sh1f8bwq.fsf@maestria.local.igalia.com>
	<20181009135534.GF22838@redhat.com>
Date: Tue, 09 Oct 2018 16:25:31 +0200
Message-ID: <w51pnwj8aec.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue 09 Oct 2018 03:55:34 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Oct 09, 2018 at 03:52:53PM +0200, Alberto Garcia wrote:
>> On Tue 09 Oct 2018 02:55:40 PM CEST, Daniel P. Berrang=C3=A9 wrote:
>> > -static void xts_mult_x(uint8_t *I)
>> > +static void xts_mult_x(xts_uint128 *I)
>> >  {
>> > -    int x;
>> > -    uint8_t t, tt;
>> > +    uint64_t tt;
>> >=20=20
>> > -    for (x =3D t =3D 0; x < 16; x++) {
>> > -        tt =3D I[x] >> 7;
>> > -        I[x] =3D ((I[x] << 1) | t) & 0xFF;
>> > -        t =3D tt;
>> > -    }
>> > -    if (tt) {
>> > -        I[0] ^=3D 0x87;
>> > +    tt =3D I->a >> 63;
>> > +    I->a =3D I->a << 1;
>> > +
>> > +    if (I->b >> 63) {
>> > +        I->a ^=3D 0x87;
>> >      }
>> > +    I->b =3D (I->b << 1) | tt;
>> >  }
>>=20
>> Does this work fine in big-endian CPUs?
>
> Hmm, that's a good question. I'd expect tests/test-crypto-xts to crash
> and burn if it doesn't, so guess I'll need to find somewhere to validate
> that.

I just tried in s390x:

/crypto/xts/t-1-key-32-ptx-32: **
ERROR:/home/berto/qemu/tests/test-crypto-xts.c:386:test_xts: assertion fail=
ed: (memcmp(out, data->CTX, data->PTLEN) =3D=3D 0)
Aborted

Berto
