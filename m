Received: from eggs.gnu.org ([2001:4830:134:3::10]:57254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ecDIH-00032A-69
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ecDIE-0007P2-3b
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:44:01 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ecDID-0007Nl-Pc
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:43:58 -0500
Received: by mail-wr0-x244.google.com with SMTP id f11so12750695wre.4
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 08:43:57 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-12-alex.bennee@linaro.org>
	<CAFEAcA-3nkmeJMHFqMeiwZtQycmieXdPiaCvKZsFuKY3MqtdCQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-3nkmeJMHFqMeiwZtQycmieXdPiaCvKZsFuKY3MqtdCQ@mail.gmail.com>
Date: Thu, 18 Jan 2018 16:43:54 +0000
Message-ID: <87r2qnnmlx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/20] fpu/softfloat: re-factor add/sub
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
>> We can now add float16_add/sub and use the common decompose and
>> canonicalize functions to have a single implementation for
>> float16/32/64 add and sub functions.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  fpu/softfloat.c         | 904 +++++++++++++++++++++++++----------------=
-------
>>  include/fpu/softfloat.h |   4 +
>>  2 files changed, 481 insertions(+), 427 deletions(-)
>>
>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>> index fcba28d3f8..f89e47e3ef 100644
>> --- a/fpu/softfloat.c
>> +++ b/fpu/softfloat.c
>> @@ -195,7 +195,7 @@ typedef enum {
>>      float_class_zero,
>>      float_class_normal,
>>      float_class_inf,
>> -    float_class_qnan,
>> +    float_class_qnan,  /* all NaNs from here */
>
> This comment change should be squashed into the previous patch.
>
>>      float_class_snan,
>>      float_class_dnan,
>>      float_class_msnan, /* maybe silenced */
>> @@ -254,6 +254,482 @@ static const decomposed_params float64_params =3D {
>>      FRAC_PARAMS(DECOMPOSED_BINARY_POINT - 52)
>>  };
>>
>> +/* Unpack a float16 to parts, but do not canonicalize.  */
>> +static inline decomposed_parts float16_unpack_raw(float16 f)
>> +{
>> +    return (decomposed_parts){
>> +        .cls =3D float_class_unclassified,
>> +        .sign =3D extract32(f, 15, 1),
>> +        .exp =3D extract32(f, 10, 5),
>> +        .frac =3D extract32(f, 0, 10)
>
> In the previous patch we defined a bunch of structs that
> give information about each float format, so it seems a bit
> odd to be hardcoding bit numbers here.

So something like this:

  /* Structure holding all of the relevant parameters for a format.
   *   exp_bias: the offset applied to the exponent field
   *   exp_max: the maximum normalised exponent
   * The following are computed based the size of fraction
   *   frac_shift: shift to normalise the fraction with DECOMPOSED_BINARY_P=
OINT
   *   frac_lsb: least significant bit of fraction
   *   fram_lsbm1: the bit bellow the least significant bit (for rounding)
   *   round_mask/roundeven_mask: masks used for rounding
   */
  typedef struct {
      int exp_bias;
      int exp_max;
      int exp_size;
      int frac_size;
      int frac_shift;
      uint64_t frac_lsb;
      uint64_t frac_lsbm1;
      uint64_t round_mask;
      uint64_t roundeven_mask;
  } FloatFmt;

  /* Expand fields based on the size of exponent and fraction */
  #define FRAC_PARAMS(E, F)                                            \
      .exp_size       =3D E,                                             \
      .frac_size      =3D F,                                             \
      .frac_shift     =3D DECOMPOSED_BINARY_POINT - F,                   \
      .frac_lsb       =3D 1ull << (DECOMPOSED_BINARY_POINT - F),         \
      .frac_lsbm1     =3D 1ull << ((DECOMPOSED_BINARY_POINT - F) - 1),   \
      .round_mask     =3D (1ull << (DECOMPOSED_BINARY_POINT - F)) - 1,   \
      .roundeven_mask =3D (2ull << (DECOMPOSED_BINARY_POINT - F)) - 1

  static const FloatFmt float16_params =3D {
      .exp_bias       =3D 0x0f,
      .exp_max        =3D 0x1f,
      FRAC_PARAMS(5, 10)
  };

  static const FloatFmt float32_params =3D {
      .exp_bias       =3D 0x7f,
      .exp_max        =3D 0xff,
      FRAC_PARAMS(8, 23)
  };

  static const FloatFmt float64_params =3D {
      .exp_bias       =3D 0x3ff,
      .exp_max        =3D 0x7ff,
      FRAC_PARAMS(11, 52)
  };

  /* Unpack a float to parts, but do not canonicalize.  */
  static inline FloatParts unpack_raw(FloatFmt fmt, uint64_t raw)
  {
      return (FloatParts){
          .cls =3D float_class_unclassified,
          .sign =3D extract64(raw, fmt.frac_size + fmt.exp_size, 1),
          .exp =3D extract64(raw, fmt.frac_size, fmt.exp_size),
          .frac =3D extract64(raw, 0, fmt.frac_size),
      };
  }

  static inline FloatParts float16_unpack_raw(float16 f)
  {
      return unpack_raw(float16_params, f);
  }

  static inline FloatParts float32_unpack_raw(float32 f)
  {
      return unpack_raw(float32_params, f);
  }

  static inline FloatParts float64_unpack_raw(float64 f)
  {
      return unpack_raw(float64_params, f);
  }

  /* Pack a float from parts, but do not canonicalize.  */
  static inline uint64_t pack_raw(FloatFmt fmt, FloatParts p)
  {
      uint64_t ret =3D p.frac;
      ret =3D deposit64(ret, fmt.frac_size, fmt.exp_size, p.exp);
      ret =3D deposit32(ret, fmt.frac_size + fmt.exp_size, 1, p.sign);
      return make_float16(ret);
  }

  static inline float16 float16_pack_raw(FloatParts p)
  {
      return make_float16(pack_raw(float16_params, p));
  }

  static inline float32 float32_pack_raw(FloatParts p)
  {
      return make_float32(pack_raw(float32_params, p));
  }

  static inline float64 float64_pack_raw(FloatParts p)
  {
      return make_float64(pack_raw(float64_params, p));
  }


>
>> +    };
>> +}
>> +
>> +/* Unpack a float32 to parts, but do not canonicalize.  */
>> +static inline decomposed_parts float32_unpack_raw(float32 f)
>> +{
>> +    return (decomposed_parts){
>> +        .cls =3D float_class_unclassified,
>> +        .sign =3D extract32(f, 31, 1),
>> +        .exp =3D extract32(f, 23, 8),
>> +        .frac =3D extract32(f, 0, 23)
>> +    };
>> +}
>> +
>> +/* Unpack a float64 to parts, but do not canonicalize.  */
>> +static inline decomposed_parts float64_unpack_raw(float64 f)
>> +{
>> +    return (decomposed_parts){
>> +        .cls =3D float_class_unclassified,
>> +        .sign =3D extract64(f, 63, 1),
>> +        .exp =3D extract64(f, 52, 11),
>> +        .frac =3D extract64(f, 0, 52),
>> +    };
>> +}
>> +
>> +/* Pack a float32 from parts, but do not canonicalize.  */
>> +static inline float16 float16_pack_raw(decomposed_parts p)
>> +{
>> +    uint32_t ret =3D p.frac;
>> +    ret =3D deposit32(ret, 10, 5, p.exp);
>> +    ret =3D deposit32(ret, 15, 1, p.sign);
>> +    return make_float16(ret);
>> +}
>> +
>> +/* Pack a float32 from parts, but do not canonicalize.  */
>> +static inline float32 float32_pack_raw(decomposed_parts p)
>> +{
>> +    uint32_t ret =3D p.frac;
>> +    ret =3D deposit32(ret, 23, 8, p.exp);
>> +    ret =3D deposit32(ret, 31, 1, p.sign);
>> +    return make_float32(ret);
>> +}
>> +
>> +/* Pack a float64 from parts, but do not canonicalize.  */
>> +static inline float64 float64_pack_raw(decomposed_parts p)
>> +{
>> +    uint64_t ret =3D p.frac;
>> +    ret =3D deposit64(ret, 52, 11, p.exp);
>> +    ret =3D deposit64(ret, 63, 1, p.sign);
>> +    return make_float64(ret);
>> +}
>> +
>> +/* Canonicalize EXP and FRAC, setting CLS.  */
>> +static decomposed_parts decomposed_canonicalize(decomposed_parts part,
>> +                                        const decomposed_params *parm,
>
> If you pick more compact names for your decomposed_params and
> decomposed_parts structs, you won't have such awkwardness trying
> to format function prototypes. (checkpatch complains that you have
> an overlong line somewhere in this patch for this reason.)
>
> In particular "decomposed_params" I think should change -- it's
> confusingly similar to decomposed_parts, and it isn't really
> a decomposed anything. It's just a collection of useful information
> describing the float format. Try 'fmtinfo', maybe?

I've gone for FloatParts and FloatParams

>
> I see we're passing and returning decomposed_parts structs everywhere
> rather than pointers to them. How well does that compile? (I guess
> everything ends up inlining...)

Yes - if you use the bitfield struct. Without it you end up with quite a
messy preamble.


--
Alex Benn=C3=A9e
