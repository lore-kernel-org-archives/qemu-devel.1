Received: from eggs.gnu.org ([2001:4830:134:3::10]:39107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gAZtx-0000or-H2
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gAZtr-0006Jy-6s
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:17:13 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:37131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gAZtq-0005nX-R3
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:17:07 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181009153132.GL22838@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-5-berrange@redhat.com>
	<w51h8hv88og.fsf@maestria.local.igalia.com>
	<20181009150629.GK22838@redhat.com>
	<w51bm8387e6.fsf@maestria.local.igalia.com>
	<20181009153132.GL22838@redhat.com>
Date: Thu, 11 Oct 2018 14:16:24 +0200
Message-ID: <w51efcwn0fb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue 09 Oct 2018 05:31:32 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Oct 09, 2018 at 05:30:25PM +0200, Alberto Garcia wrote:
>> >> >      for (i =3D 0; i < lim; i++) {
>> >> > -        xts_tweak_encdec(datactx, decfunc, src, dst, (uint8_t *)&T=
);
>> >> > +        xts_uint128 S, D;
>> >> > +
>> >> > +        memcpy(&S, src, XTS_BLOCK_SIZE);
>> >> > +        xts_tweak_encdec(datactx, decfunc, &S, &D, &T);
>> >> > +        memcpy(dst, &D, XTS_BLOCK_SIZE);
>> >>=20
>> >> Why do you need S and D?
>> >
>> > I think src & dst pointers can't be guaranteed to be aligned
>> > sufficiently for int64 operations, if we just cast from uint8t*.
>>=20
>> I see. I did a quick test without the memcpy() calls and it doesn't
>> seem to have a visible effect on performance, but if it turns out
>> that it does then maybe this is worth investigating further. I
>> suspect all buffers received by this code are allocated with
>> qemu_try_blockalign() anyway, so it should be safe.
>
> The extra memcpy() calls certainly had a perf impact when I added
> them, so if we can determine that we can safely do without, that would
> be desirable.

So I was having a look at this. From the block layer everything comes
properly aligned. Then there's VirtioCrypto, which seems to allow XTS
mode but I couldn't quite tell from virtio_crypto_sym_op_helper() if all
buffers are guaranteed to be aligned.

What you could do is a runtime check (with QEMU_PTR_IS_ALIGNED()) and
decide what implementation to use.

A couple of additional thoughts:

- x86_64 (and others) allow unaligned memory accesses, and that might be
  faster than copying the buffer using memcpy(). I haven't measured it
  however.

- qcrypto_block_{encrypt,decrypt}_helper() (used for encrypted block
  I/O) use the same buffer for input and output, so maybe it's worth
  exploring if this fact allows for additional optimization if you still
  need to use memcpy().

Berto
