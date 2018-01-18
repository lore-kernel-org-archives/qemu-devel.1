Received: from eggs.gnu.org ([2001:4830:134:3::10]:49593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ec9wA-0002Dp-0I
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ec9w6-0007rm-NM
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:08:57 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ec9w6-0007rD-DG
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:08:54 -0500
Received: by mail-wm0-x243.google.com with SMTP id v123so22809027wmd.5
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 05:08:54 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-11-alex.bennee@linaro.org>
	<1393deaf-c207-6055-1f7c-f7ae814cf2db@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1393deaf-c207-6055-1f7c-f7ae814cf2db@amsat.org>
Date: Thu, 18 Jan 2018 13:08:51 +0000
Message-ID: <87shb3nwkc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/20] fpu/softfloat: define decompose
 structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, Francisco Iglesias <frasse.iglesias@gmail.com>, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Alex, Richard,
>
> On 01/09/2018 09:22 AM, Alex Benn=C3=A9e wrote:
>> These structures pave the way for generic softfloat helper routines
>> that will operate on fully decomposed numbers.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  fpu/softfloat.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++-
>>  1 file changed, 69 insertions(+), 1 deletion(-)
>>
>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>> index 59afe81d06..fcba28d3f8 100644
>> --- a/fpu/softfloat.c
>> +++ b/fpu/softfloat.c
>> @@ -83,7 +83,7 @@ this code that are retained.
>>   * target-dependent and needs the TARGET_* macros.
>>   */
>>  #include "qemu/osdep.h"
>> -
>> +#include "qemu/bitops.h"
>>  #include "fpu/softfloat.h"
>>
>>  /* We only need stdlib for abort() */
>> @@ -186,6 +186,74 @@ static inline flag extractFloat64Sign(float64 a)
>>      return float64_val(a) >> 63;
>>  }
>>
>> +/*---------------------------------------------------------------------=
-------
>> +| Classify a floating point number.
>> +*----------------------------------------------------------------------=
------*/
>> +
>> +typedef enum {
>> +    float_class_unclassified,
>> +    float_class_zero,
>> +    float_class_normal,
>> +    float_class_inf,
>> +    float_class_qnan,
>> +    float_class_snan,
>> +    float_class_dnan,
>> +    float_class_msnan, /* maybe silenced */
>> +} float_class;
>> +
>> +/*---------------------------------------------------------------------=
-------
>> +| Structure holding all of the decomposed parts of a float.
>> +| The exponent is unbiased and the fraction is normalized.
>> +*----------------------------------------------------------------------=
------*/
>> +
>> +typedef struct {
>> +    uint64_t frac   : 64;
>
> I think this does not work on LLP64/IL32P64 model.
>
> Should we add a check in ./configure and refuse to build on IL32P64
> model? This would be safer IMHO.
>
>> +    int exp         : 32;
>> +    float_class cls : 8;
>> +    int             : 23;
>> +    bool sign       : 1;
>
> checking on "ISO/IEC 14882:1998" 9.6 Bit-fields:
>
> Alignment of bit-fields is implementation-defined. Bit-fields are packed
> into some addressable allocation unit. [Note: bit-fields straddle
> allocation units on some machines and not on others. Bit-fields are
> assigned right-to-left on some machines, left-to-right on others. ]
>
> I'd still write it:
>
>       int             :23, sign :1;
>
>> +} decomposed_parts;

I think rather than stuff it into bit fields we can just leave it up to
the compiler?

>> +
>> +#define DECOMPOSED_BINARY_POINT    (64 - 2)
>> +#define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
>> +#define DECOMPOSED_OVERFLOW_BIT    (DECOMPOSED_IMPLICIT_BIT << 1)
>> +
>> +/* Structure holding all of the relevant parameters for a format.  */
>> +typedef struct {
>> +    int exp_bias;
>> +    int exp_max;
>> +    int frac_shift;
>> +    uint64_t frac_lsb;
>> +    uint64_t frac_lsbm1;
>> +    uint64_t round_mask;
>> +    uint64_t roundeven_mask;
>> +} decomposed_params;
>> +
>> +#define FRAC_PARAMS(F)                     \
>> +    .frac_shift     =3D F,                   \
>> +    .frac_lsb       =3D 1ull << (F),         \
>> +    .frac_lsbm1     =3D 1ull << ((F) - 1),   \
>> +    .round_mask     =3D (1ull << (F)) - 1,   \
>> +    .roundeven_mask =3D (2ull << (F)) - 1
>> +
>> +static const decomposed_params float16_params =3D {
>> +    .exp_bias       =3D 0x0f,
>> +    .exp_max        =3D 0x1f,
>> +    FRAC_PARAMS(DECOMPOSED_BINARY_POINT - 10)
>> +};
>> +
>> +static const decomposed_params float32_params =3D {
>> +    .exp_bias       =3D 0x7f,
>> +    .exp_max        =3D 0xff,
>> +    FRAC_PARAMS(DECOMPOSED_BINARY_POINT - 23)
>> +};
>> +
>> +static const decomposed_params float64_params =3D {
>> +    .exp_bias       =3D 0x3ff,
>> +    .exp_max        =3D 0x7ff,
>> +    FRAC_PARAMS(DECOMPOSED_BINARY_POINT - 52)
>> +};
>> +
>>  /*---------------------------------------------------------------------=
-------
>>  | Takes a 64-bit fixed-point value `absZ' with binary point between bit=
s 6
>>  | and 7, and returns the properly rounded 32-bit integer corresponding =
to the
>>


--
Alex Benn=C3=A9e
