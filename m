Received: from eggs.gnu.org ([2001:4830:134:3::10]:44779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecB9b-00048G-FX
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecB9Z-0003AS-W1
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:26:55 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:44655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecB9Z-0003A1-Oc
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:26:53 -0500
Received: by mail-io0-x242.google.com with SMTP id z6so7957485iob.11
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 06:26:53 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <87shb3nwkc.fsf@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-11-alex.bennee@linaro.org>
	<1393deaf-c207-6055-1f7c-f7ae814cf2db@amsat.org>
	<87shb3nwkc.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 11:26:51 -0300
Message-ID: <CAAdtpL48633TDoSnhv1-iZ0QjWWQsuD1DxJTsniJg+AHbeiT_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Francisco Iglesias <frasse.iglesias@gmail.com>, richard.henderson@linaro.org, laurent@vivier.eu, qemu-devel@nongnu.org, andrew@andrewdutcher.com, bharata@linux.vnet.ibm.com, Aurelien Jarno <aurelien@aurel32.net>

Le 18 janv. 2018 10:09 AM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> a =
=C3=A9crit :


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
>>  fpu/softfloat.c | 70 ++++++++++++++++++++++++++++++
++++++++++++++++++++++++++-
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
>> +/*---------------------------------------------------------
-------------------
>> +| Classify a floating point number.
>> +*----------------------------------------------------------
------------------*/
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
>> +/*---------------------------------------------------------
-------------------
>> +| Structure holding all of the decomposed parts of a float.
>> +| The exponent is unbiased and the fraction is normalized.
>> +*----------------------------------------------------------
------------------*/
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


Yep, my only worry here is the IL32P64 model, if we care.


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
>>  /*----------------------------------------------------------
------------------
>>  | Takes a 64-bit fixed-point value `absZ' with binary point between
bits 6
>>  | and 7, and returns the properly rounded 32-bit integer corresponding
to the
>>


--
Alex Benn=C3=A9e
