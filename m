Received: from eggs.gnu.org ([2001:4830:134:3::10]:47246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eXUHv-0008Jm-CU
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eXUHr-0001Ek-BE
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:52:07 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eXUHq-0001Bh-PG
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:52:03 -0500
Received: by mail-wm0-x22c.google.com with SMTP id 64so3230812wme.3
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 07:52:02 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-17-alex.bennee@linaro.org>
	<04791c4d-cc8a-c279-d1a8-8a86c9d470ac@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <04791c4d-cc8a-c279-d1a8-8a86c9d470ac@linaro.org>
Date: Fri, 05 Jan 2018 15:51:59 +0000
Message-ID: <87incgcnhc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 16/19] fpu/softfloat: re-factor int/uint
 to float
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 12/11/2017 04:57 AM, Alex Benn=C3=A9e wrote:
>> These are considerably simpler as the lower order integers can just
>> use the higher order conversion function. As the decomposed fractional
>> part is a full 64 bit rounding and inexact handling comes from the
>> pack functions.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>
>>
>>  static uint32_t uint32_pack_decomposed(decomposed_parts p, float_status=
 *s)
>>  {
>>      uint64_t r =3D uint64_pack_decomposed(p, s);
>> -    return r > UINT32_MAX ? UINT32_MAX : r;
>> +    if (r > UINT32_MAX) {
>> +        s->float_exception_flags |=3D float_flag_invalid;
>> +        r =3D UINT32_MAX;
>> +    }
>> +    return r;
>>  }
>>
>>  #define F
>
> Ah, the fix for the bug in patch 15 got squashed into the wrong patch.
> ;-)

Hmm slip of the re-base... the fix has been moved.

>
>> +float16 int16_to_float16(int16_t a, float_status *status)
>> +{
>> +    return int64_to_float16((int64_t) a, status);
>> +}
>
> Kill all of the redundant casts?

Ack.

>
> Otherwise, as amended in your followup,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~


--
Alex Benn=C3=A9e
