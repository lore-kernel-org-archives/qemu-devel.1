Received: from eggs.gnu.org ([2001:4830:134:3::10]:40320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fH9dM-0008Dr-G2
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fH9dI-0001u1-Gn
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:07:00 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fH9dI-0001ta-9q
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:06:56 -0400
Received: by mail-wr0-x243.google.com with SMTP id p4-v6so5693343wrh.3
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 08:06:56 -0700 (PDT)
References: <20180511004345.26708-1-richard.henderson@linaro.org>
	<20180511004345.26708-3-richard.henderson@linaro.org>
	<87fu2yvdl4.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87fu2yvdl4.fsf@linaro.org>
Date: Fri, 11 May 2018 16:06:54 +0100
Message-ID: <87d0y2ut81.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/19] fpu/softfloat: Split
 floatXX_silence_nan from floatXX_maybe_silence_nan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> The new function assumes that the input is an SNaN and
>> does not double-check.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

but...but...
>> -float16 float16_maybe_silence_nan(float16 a_, float_status *status)
>> +
>> +float16 float16_maybe_silence_nan(float16 a, float_status *status)
>>  {
>> -    if (float16_is_signaling_nan(a_, status)) {
>> -        if (status->snan_bit_is_one) {
>> -            return float16_default_nan(status);
>> -        } else {
>> -            uint16_t a =3D float16_val(a_);
>> -            a |=3D (1 << 9);
>> -            return make_float16(a);
>> -        }
>> +    if (float16_is_signaling_nan(a, status)) {
>> +        float16_silence_nan(a, status);

You need a return here.
>>
>> -float32 float32_maybe_silence_nan(float32 a_, float_status *status)
>> +float32 float32_maybe_silence_nan(float32 a, float_status *status)
>>  {
>> -    if (float32_is_signaling_nan(a_, status)) {
>> -        if (status->snan_bit_is_one) {
>> -#ifdef TARGET_HPPA
>> -            uint32_t a =3D float32_val(a_);
>> -            a &=3D ~0x00400000;
>> -            a |=3D  0x00200000;
>> -            return make_float32(a);
>> -#else
>> -            return float32_default_nan(status);
>> -#endif
>> -        } else {
>> -            uint32_t a =3D float32_val(a_);
>> -            a |=3D (1 << 22);
>> -            return make_float32(a);
>> -        }
>> +    if (float32_is_signaling_nan(a, status)) {
>> +        float32_silence_nan(a, status);

And here.

Amazing what tests pass with those in, but RISU picked them up.

--
Alex Benn=C3=A9e
