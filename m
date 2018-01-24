Received: from eggs.gnu.org ([2001:4830:134:3::10]:57086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eeJnD-0000kO-UJ
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eeJmO-0007Et-Ie
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:04:39 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:44486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eeJmO-00076x-62
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:03:48 -0500
Received: by mail-wm0-x243.google.com with SMTP id t74so8062955wme.3
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 04:03:47 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-19-alex.bennee@linaro.org>
	<CAFEAcA_ZE1wZRrNquGdN1kVimmB-+p=5eSrcXUnJbBw+aL36dw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_ZE1wZRrNquGdN1kVimmB-+p=5eSrcXUnJbBw+aL36dw@mail.gmail.com>
Date: Wed, 24 Jan 2018 12:03:45 +0000
Message-ID: <87h8rb79b2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 18/20] fpu/softfloat: re-factor scalbn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 9 January 2018 at 12:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>> This is one of the simpler manipulations you could make to a floating
>> point number.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  fpu/softfloat.c         | 104 +++++++++++++++--------------------------=
-------
>>  include/fpu/softfloat.h |   1 +
>>  2 files changed, 32 insertions(+), 73 deletions(-)
>>
>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>> index bb68d77f72..3647f6ca03 100644
>> --- a/fpu/softfloat.c
>> +++ b/fpu/softfloat.c
>> @@ -1663,6 +1663,37 @@ float64 uint16_to_float64(uint16_t a, float_statu=
s *status)
>>      return uint64_to_float64(a, status);
>>  }
>>
>> +/* Multiply A by 2 raised to the power N.  */
>> +static decomposed_parts scalbn_decomposed(decomposed_parts a, int n,
>> +                                          float_status *s)
>> +{
>> +    if (a.cls =3D=3D float_class_normal) {
>> +        a.exp +=3D n;
>> +    }
>> +    return a;
>> +}
>> +
>> +float16 float16_scalbn(float16 a, int n, float_status *status)
>> +{
>> +    decomposed_parts pa =3D float16_unpack_canonical(a, status);
>> +    decomposed_parts pr =3D scalbn_decomposed(pa, n, status);
>> +    return float16_round_pack_canonical(pr, status);
>> +}
>> +
>> +float32 float32_scalbn(float32 a, int n, float_status *status)
>> +{
>> +    decomposed_parts pa =3D float32_unpack_canonical(a, status);
>> +    decomposed_parts pr =3D scalbn_decomposed(pa, n, status);
>> +    return float32_round_pack_canonical(pr, status);
>> +}
>> +
>> +float64 float64_scalbn(float64 a, int n, float_status *status)
>> +{
>> +    decomposed_parts pa =3D float64_unpack_canonical(a, status);
>> +    decomposed_parts pr =3D scalbn_decomposed(pa, n, status);
>> +    return float64_round_pack_canonical(pr, status);
>> +}
>
> The old code used propagateFloat32NaN(a, a, status) if the
> input was a NaN, to cause us to raise the invalid flag,
> maybe return a default NaN, maybe silence the NaN. I can't
> see where the new code is doing this?

invalid and setting msnan are done during the unpack stage when the
input is canonicalized. NaN's may raise their signals when we round and
pack any results.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
