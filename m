Received: from eggs.gnu.org ([2001:4830:134:3::10]:33256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYve6-0000Up-Uc
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYve3-0003Tv-P4
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:16:58 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYve3-0003T3-Ic
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:16:55 -0500
Received: by mail-wm0-x241.google.com with SMTP id a79so21274872wma.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 07:16:55 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-7-alex.bennee@linaro.org>
	<10f81db9-683c-acb9-049f-eb3579909b18@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <10f81db9-683c-acb9-049f-eb3579909b18@amsat.org>
Date: Tue, 09 Jan 2018 15:16:52 +0000
Message-ID: <87a7xnnjtn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/20] include/fpu/softfloat: add some
 float16 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Alex,
>
> On 01/09/2018 09:22 AM, Alex Benn=C3=A9e wrote:
>> This defines the same set of common constants for float 16 as defined
>> for 32 and 64 bit floats. These are often used by target helper
>> functions. I've also removed constants that are not used by anybody.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> ---
>> v2
>>   - fixup constants, remove unused onces
>> ---
>>  include/fpu/softfloat.h | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
>> index 8ab5d0df47..e64bf62f3d 100644
>> --- a/include/fpu/softfloat.h
>> +++ b/include/fpu/softfloat.h
>> @@ -368,6 +368,11 @@ static inline float16 float16_set_sign(float16 a, i=
nt sign)
>>      return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
>>  }
>>
>> +#define float16_zero make_float16(0)
>> +#define float16_one make_float16(0x3a00)
>
> I still disagree with this one, it seems your bits 9/10 are inverted
> (mantissa msb with biased exponent lsb).
>
>          S EEEEE TTTTTTTTTT
> 0x3a00 =3D 0 01110 1000000000
>
> having:
> S=3D0
> E=3D0b01110=3D14
> T=3D0b1000000000=3D512
>
> I get:
> (-1)^0 * 2^(14-15) * (1 + (2^-10) * 512) =3D 1 * 0.5 * (1 + 0.5) =3D 0.75
>
> With 0x3c00 I get:
>
>          S EEEEE TTTTTTTTTT
> 0x3c00 =3D 0 01111 0000000000
> S=3D0
> E=3D0b01111=3D15
> T=3D0b0000000000=3D0
>
> (-1)^0 * 2^(15-15) * (1 + (2^-10) * 0) =3D 1 * 2^0 * (1 + 0) =3D 1
>
> The rest is OK.
>
> Changing by "#define float16_one make_float16(0x3c00)":
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Dam it, I thought I'd fixed them all.

Thanks for the catch.

>
>> +#define float16_half make_float16(0x3800)
>> +#define float16_infinity make_float16(0x7c00)
>> +
>>  /*---------------------------------------------------------------------=
-------
>>  | The pattern for a default generated half-precision NaN.
>>  *----------------------------------------------------------------------=
------*/
>> @@ -474,8 +479,6 @@ static inline float32 float32_set_sign(float32 a, in=
t sign)
>>
>>  #define float32_zero make_float32(0)
>>  #define float32_one make_float32(0x3f800000)
>> -#define float32_ln2 make_float32(0x3f317218)
>> -#define float32_pi make_float32(0x40490fdb)
>>  #define float32_half make_float32(0x3f000000)
>>  #define float32_infinity make_float32(0x7f800000)
>>
>> @@ -588,7 +591,6 @@ static inline float64 float64_set_sign(float64 a, in=
t sign)
>>  #define float64_zero make_float64(0)
>>  #define float64_one make_float64(0x3ff0000000000000LL)
>>  #define float64_ln2 make_float64(0x3fe62e42fefa39efLL)
>> -#define float64_pi make_float64(0x400921fb54442d18LL)
>>  #define float64_half make_float64(0x3fe0000000000000LL)
>>  #define float64_infinity make_float64(0x7ff0000000000000LL)
>>
>>


--
Alex Benn=C3=A9e
