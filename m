Received: from eggs.gnu.org ([2001:4830:134:3::10]:36812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9tiu-0001om-LH
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9tio-00012Q-3c
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:15:00 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:36284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1g9tin-00010i-HW
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:14:53 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181009145839.GJ22838@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-4-berrange@redhat.com>
	<w51k1mr8993.fsf@maestria.local.igalia.com>
	<20181009145839.GJ22838@redhat.com>
Date: Tue, 09 Oct 2018 17:14:51 +0200
Message-ID: <w51efcz8844.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue 09 Oct 2018 04:58:39 PM CEST, Daniel P. Berrang=C3=A9 wrote:
>> > @@ -85,7 +90,7 @@ void xts_decrypt(const void *datactx,
>> >                   uint8_t *dst,
>> >                   const uint8_t *src)
>> >  {
>> > -    uint8_t PP[XTS_BLOCK_SIZE], CC[XTS_BLOCK_SIZE], T[XTS_BLOCK_SIZE];
>> > +    xts_uint128 PP, CC, T;
>> >      unsigned long i, m, mo, lim;
>>=20
>>    [...]
>>=20
>> >          /* Pm =3D first length % XTS_BLOCK_SIZE bytes of PP */
>> >          for (i =3D 0; i < mo; i++) {
>> > -            CC[i] =3D src[XTS_BLOCK_SIZE + i];
>> > -            dst[XTS_BLOCK_SIZE + i] =3D PP[i];
>> > +            ((uint8_t *)&CC)[i] =3D src[XTS_BLOCK_SIZE + i];
>> > +            dst[XTS_BLOCK_SIZE + i] =3D ((uint8_t *)&PP)[i];
>> >          }
>>=20
>> On second thoughts, these casts are a bit cumbersome. I wonder if it
>> isn't better to keep the array a uint8_t[] and only treat it as
>> xts_uint128 in the places where you actually do 64-bit operations
>> (xts_uint128_xor, xts_mult_x).
>
> I had done that originally, but it just shifts ugly casts from one
> place to another place in the code.

Does it really? There's a dozen casts to uint8_t * in different
places. If you use uint_8[] you would only need something like this:

static void xts_mult_x(uint8_t *I8)
{
    xts_uint128 *I =3D (xts_uint128 *) I8;
    /* ... the rest of the function remains the same ... */
}

And something similar in xts_uint128_xor(), which could be an inline
function instead of a macro.

Berto
