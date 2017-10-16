Received: from eggs.gnu.org ([2001:4830:134:3::10]:36020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e40e3-0005P1-LO
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e40dy-0003yW-Ne
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:21:07 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:56208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e40dy-0003xL-Ex
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:21:02 -0400
Received: by mail-wm0-x22c.google.com with SMTP id u138so502507wmu.4
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 01:21:01 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-15-alex.bennee@linaro.org>
	<b7afef46-1d05-6701-dce5-39f3070e4129@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <b7afef46-1d05-6701-dce5-39f3070e4129@linaro.org>
Date: Mon, 16 Oct 2017 09:20:58 +0100
Message-ID: <87k1zvcxlh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 14/30] softfloat: 16 bit helpers for
 shr, clz and rounding and packing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/13/2017 09:24 AM, Alex Benn=C3=A9e wrote:
>> Half-precision helpers for float16 maths. I didn't bother hand-coding
>> the count leading zeros as we could always fall-back to host-utils if
>> we needed to.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  fpu/softfloat-macros.h | 39 +++++++++++++++++++++++++++++++++++++++
>>  fpu/softfloat.c        | 21 +++++++++++++++++++++
>>  2 files changed, 60 insertions(+)
>>
>> diff --git a/fpu/softfloat-macros.h b/fpu/softfloat-macros.h
>> index 9cc6158cb4..73091a88a8 100644
>> --- a/fpu/softfloat-macros.h
>> +++ b/fpu/softfloat-macros.h
>> @@ -89,6 +89,31 @@ this code that are retained.
>>  # define SOFTFLOAT_GNUC_PREREQ(maj, min) 0
>>  #endif
>>
>> +/*---------------------------------------------------------------------=
-------
>> +| Shifts `a' right by the number of bits given in `count'.  If any nonz=
ero
>> +| bits are shifted off, they are ``jammed'' into the least significant =
bit of
>> +| the result by setting the least significant bit to 1.  The value of `=
count'
>> +| can be arbitrarily large; in particular, if `count' is greater than 1=
6, the
>> +| result will be either 0 or 1, depending on whether `a' is zero or non=
zero.
>> +| The result is stored in the location pointed to by `zPtr'.
>> +*----------------------------------------------------------------------=
------*/
>> +
>> +static inline void shift16RightJamming(uint16_t a, int count, uint16_t =
*zPtr)
>> +{
>> +    uint16_t z;
>> +
>> +    if ( count =3D=3D 0 ) {
>> +        z =3D a;
>> +    }
>> +    else if ( count < 16 ) {
>> +        z =3D ( a>>count ) | ( ( a<<( ( - count ) & 16 ) ) !=3D 0 );
>> +    }
>> +    else {
>> +        z =3D ( a !=3D 0 );
>> +    }
>> +    *zPtr =3D z;
>> +
>> +}
>
> When are you going to use a SRJ of a uint16_t?  Isn't most of your actual
> arithmetic actually done on uint32_t?

The add/sub stuff currently uses it. Arguably it could do what it needs
with 32 bit as well but the spare exponent bits are enough for operating
on the significand. That said I'm fairly sure it all ends up 32 bit in
the generated code.

>
>> +/*---------------------------------------------------------------------=
-------
>> +| Returns the number of leading 0 bits before the most-significant 1 bi=
t of
>> +| `a'.  If `a' is zero, 16 is returned.
>> +*----------------------------------------------------------------------=
------*/
>> +
>> +static int8_t countLeadingZeros16( uint16_t a )
>> +{
>> +    if (a) {
>> +        return __builtin_clz(a);
>> +    } else {
>> +        return 16;
>> +    }
>> +}
>
> __builtin_clz works on "int".  You need to use clz32(a) - 16.

Ahh my mistake - I'd assumed it had the same smarts as the gcc atomics.
Maybe I should just use our utils functions afterall.

>
>> +/*---------------------------------------------------------------------=
-------
>> +| Takes an abstract floating-point value having sign `zSign', exponent =
`zExp',
>> +| and significand `zSig', and returns the proper single-precision float=
ing-
>
> s/single/half/
>
>> +| point value corresponding to the abstract input.  This routine is jus=
t like
>> +| `roundAndPackFloat32' except that `zSig' does not have to be normaliz=
ed.
>> +| Bit 15 of `zSig' must be zero, and `zExp' must be 1 less than the ``t=
rue''
>> +| floating-point exponent.
>> +*----------------------------------------------------------------------=
------*/
>> +
>> +static float16
>> + normalizeRoundAndPackFloat16(flag zSign, int zExp, uint16_t zSig,
>> +                              float_status *status)
>> +{
>> +    int8_t shiftCount;
>> +
>> +    shiftCount =3D countLeadingZeros16( zSig ) - 1;
>> +    return roundAndPackFloat16(zSign, zExp - shiftCount, zSig<<shiftCou=
nt,
>> +                               true, status);
>
> Do I recall correctly that your lsb is between bits 7:6, like
> roundAndPackFloat32?  You've got 11 bits of sig.  Plus 7 bits of extra eq=
uals
> 18 bits.  Which doesn't fit in uint16_t.

No it takes a 32 bit sig in and deals with it internally.

>
> So, the reason that roundAndPackFloat32 uses 7 bits is that 7 + 24 =3D=3D=
 31.
>
> We can either use a split at (15 - 11 =3D) 4 bits, and still fit in a uin=
t16_t,
> or we can drop uint16_t and admit that the compiler is going to promote t=
o int,
> or uint32_t, anyway.  If we do that, we have options of a split between 4=
 and
> (31 - 11 =3D) 20 bits.
>
> We talked this week re fp->int conversion, it did seem Really Useful when=
 we
> noted that sig << exp is representable in a uint32_t.  Which does suggest=
 a
> choice at or below (32 - 11 - 14 =3D) 7.
>
>
> r~


--
Alex Benn=C3=A9e
