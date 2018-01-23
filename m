Received: from eggs.gnu.org ([2001:4830:134:3::10]:51171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ee4pU-0003CO-Mv
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 15:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ee4pQ-0007W4-MJ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 15:06:00 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:33046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ee4pQ-0007Ue-Az
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 15:05:56 -0500
Received: by mail-wm0-x235.google.com with SMTP id x4so23507694wmc.0
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 12:05:56 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-12-alex.bennee@linaro.org>
	<CAFEAcA-3nkmeJMHFqMeiwZtQycmieXdPiaCvKZsFuKY3MqtdCQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-3nkmeJMHFqMeiwZtQycmieXdPiaCvKZsFuKY3MqtdCQ@mail.gmail.com>
Date: Tue, 23 Jan 2018 20:05:53 +0000
Message-ID: <87inbs7332.fsf@linaro.org>
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

<snip>
>
>> +                                        float_status *status)
>> +{
>> +    if (part.exp =3D=3D parm->exp_max) {
>> +        if (part.frac =3D=3D 0) {
>> +            part.cls =3D float_class_inf;
>> +        } else {
>> +#ifdef NO_SIGNALING_NANS
>
> The old code didn't seem to need to ifdef this; why's the new
> code different? (at some point we'll want to make this a runtime
> setting so we can support one binary handling CPUs with it both
> set and unset, but that is a far future thing we can ignore for now)

It does, but it's hidden behind propagateFloatXXNaN which in turn calls
floatXX_is_quiet/signalling_nan which are altered by the #ifdefs.

>
>> +            part.cls =3D float_class_qnan;
>> +#else
>> +            int64_t msb =3D part.frac << (parm->frac_shift + 2);
>> +            if ((msb < 0) =3D=3D status->snan_bit_is_one) {
>> +                part.cls =3D float_class_snan;
>> +            } else {
>> +                part.cls =3D float_class_qnan;
>> +            }
>> +#endif
>> +        }
>> +    } else if (part.exp =3D=3D 0) {
>> +        if (likely(part.frac =3D=3D 0)) {
>> +            part.cls =3D float_class_zero;
>> +        } else if (status->flush_inputs_to_zero) {
>> +            float_raise(float_flag_input_denormal, status);
>> +            part.cls =3D float_class_zero;
>> +            part.frac =3D 0;
>> +        } else {
>> +            int shift =3D clz64(part.frac) - 1;
>> +            part.cls =3D float_class_normal;
>
> This is really confusing. This is a *denormal*, but we're setting
> the classification to "normal" ? (It's particularly confusing in
> the code that uses the decomposed numbers, because it looks like
> "if (a.cls =3D=3D float_class_normal...)" is handling the normal-number
> case and denormals are going to be in a later if branch, but actually
> it's dealing with both.)

The code deals with canonicalized numbers - so unless we explicitly
flush denormals to zero they can be treated like any other for the rest
of the code.

What would you prefer? A comment in FloatClass?

<snip>
>> +
>> +static float16 float16_round_pack_canonical(decomposed_parts p, float_s=
tatus *s)
>> +{
>> +    switch (p.cls) {
>> +    case float_class_dnan:
>> +        return float16_default_nan(s);
>> +    case float_class_msnan:
>> +        return float16_maybe_silence_nan(float16_pack_raw(p), s);
>
> I think you will find that doing the silencing of the NaNs like this
> isn't quite the right approach. Specifically, for Arm targets we
> currently have a bug in float-to-float conversion from a wider
> format to a narrower one when the input is a signaling NaN that we
> want to silence, and its non-zero mantissa bits are all at the
> less-significant end of the mantissa such that they don't fit into
> the narrower format. If you pack the float into a float16 first and
> then call maybe_silence_nan() on it you've lost the info about those
> low bits which the silence function needs to know to return the
> right answer. What you want to do instead is pass the silence_nan
> function the decomposed value.

So this is an inherited bug from softfloat-specialize.h? I guess we need
a common specific decomposed specialisation we can use for all the sizes.

>
> (The effect of this bug is that we return a default NaN, with the
> sign bit clear, but the Arm FPConvertNaN pseudocode says that we
> should effectively get the default NaN but with the same sign bit
> as the input SNaN.)
>
> Given that this is a bug currently in the version we have, we don't
> necessarily need to fix it now, but I thought I'd mention it since
> the redesign has almost but not quite managed to deliver the right
> information to the silencing code to allow us to fix it soon :-)

So comment for now? Currently all the information for decomposed is kept
internal to softfloat.c - I'm not sure we want to expose the internals
to a wider audience? Especially as these inline helpers in specialize.h
are also used by helpers.

<snip>
>> +
>> +
>> +/*
>> + * Returns the result of adding the absolute values of the
>> + * floating-point values `a' and `b'. If `subtract' is set, the sum is
>> + * negated before being returned. `subtract' is ignored if the result
>> + * is a NaN. The addition is performed according to the IEC/IEEE
>> + * Standard for Binary Floating-Point Arithmetic.
>> + */
>
> This comment doesn't seem to match what the code is doing,
> because it says it adds the absolute values of 'a' and 'b',
> but the code looks at a_sign and b_sign to decide whether it's
> doing an addition or subtraction rather than ignoring the signs
> (as you would for absolute arithmetic).
>
> Put another way, this comment has been copied from the old addFloat64Sigs=
()
> and not updated to account for the way the new function includes handling
> of subFloat64Sigs().
>
>> +
>> +static decomposed_parts add_decomposed(decomposed_parts a, decomposed_p=
arts b,
>> +                                       bool subtract, float_status *s)
>> +{
>> +    bool a_sign =3D a.sign;
>> +    bool b_sign =3D b.sign ^ subtract;
>> +
>> +    if (a_sign !=3D b_sign) {
>> +        /* Subtraction */
>> +
>> +        if (a.cls =3D=3D float_class_normal && b.cls =3D=3D float_class=
_normal) {
>> +            int a_exp =3D a.exp;
>> +            int b_exp =3D b.exp;
>> +            uint64_t a_frac =3D a.frac;
>> +            uint64_t b_frac =3D b.frac;
>
> Do we really have to use locals here rather than just using a.frac,
> b.frac etc in place ? If we trust the compiler enough to throw
> structs in and out of functions and let everything inline, it
> ought to be able to handle a uint64_t in a struct local variable.

Fixed.

>> +        if (a.cls >=3D float_class_qnan
>> +            ||
>> +            b.cls >=3D float_class_qnan) {
>
> We should helper functions for "is some kind of NaN" rather than
> baking the assumption about order of the enum values directly
> into every function. (Also "float_is_any_nan(a)" is easier to read.)

if (is_nan(a.cls) || is_nan(b.cls))
>> +float64 float64_sub(float64 a, float64 b, float_status *status)
>> +{
>> +    decomposed_parts pa =3D float64_unpack_canonical(a, status);
>> +    decomposed_parts pb =3D float64_unpack_canonical(b, status);
>> +    decomposed_parts pr =3D add_decomposed(pa, pb, true, status);
>> +
>> +    return float64_round_pack_canonical(pr, status);
>> +}
>
> This part is a pretty good advert for the benefits of the refactoring...
>
> I'm not particularly worried about the performance of softfloat,
> but out of curiosity have you benchmarked the old vs new?

Not yet but I can run some with my vector kernel benchmark.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
