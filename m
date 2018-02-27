Received: from eggs.gnu.org ([2001:4830:134:3::10]:35721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqjQF-000199-Os
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqjQC-0003wS-Np
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:52:15 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:51151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eqjQC-0003w1-G6
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:52:12 -0500
Received: by mail-wm0-x22d.google.com with SMTP id w128so242169wmw.0
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:52:12 -0800 (PST)
References: <20180227143852.11175-1-alex.bennee@linaro.org>
	<20180227143852.11175-15-alex.bennee@linaro.org>
	<19852743-3c93-9d0f-5ef6-8bf351a98ce7@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <19852743-3c93-9d0f-5ef6-8bf351a98ce7@linaro.org>
Date: Tue, 27 Feb 2018 17:52:10 +0000
Message-ID: <87zi3uuxpx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 14/31] arm/translate-a64: add FP16
 FMULX/MLS/FMLA to simd_indexed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 02/27/2018 06:38 AM, Alex Benn=C3=A9e wrote:
>> @@ -11244,7 +11245,7 @@ static void disas_simd_indexed(DisasContext *s, =
uint32_t insn)
>>          }
>>          /* fall through */
>>      case 0x9: /* FMUL, FMULX */
>> -        if (!extract32(size, 1, 1)) {
>> +        if (size =3D=3D 1) {
>>              unallocated_encoding(s);
>>              return;
>>          }
>
> This is still redundant, since size =3D=3D 1 is handled...

doh!

will fix.

>
>> @@ -11256,18 +11257,34 @@ static void disas_simd_indexed(DisasContext *s=
, uint32_t insn)
>>      }
>>
>>      if (is_fp) {
>> -        /* low bit of size indicates single/double */
>> -        size =3D extract32(size, 0, 1) ? 3 : 2;
>> -        if (size =3D=3D 2) {
>> +        /* convert insn encoded size to TCGMemOp size */
>> +        switch (size) {
>> +        case 2: /* single precision */
>> +            size =3D MO_32;
>>              index =3D h << 1 | l;
>> -        } else {
>> +            rm |=3D (m << 4);
>> +            break;
>> +        case 3: /* double precision */
>> +            size =3D MO_64;
>>              if (l || !is_q) {
>>                  unallocated_encoding(s);
>>                  return;
>>              }
>>              index =3D h;
>> +            rm |=3D (m << 4);
>> +            break;
>> +        case 0: /* half precision */
>> +            size =3D MO_16;
>> +            index =3D h << 2 | l << 1 | m;
>> +            is_fp16 =3D true;
>> +            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
>> +                break;
>> +            }
>> +            /* fallthru */
>> +        default: /* unallocated */
>> +            unallocated_encoding(s);
>> +            return;
>>          }
>
> ... here.  But it's not wrong and I can clean this up along with the addi=
tional
> changes I need to make to this function for fcmla support.  So,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~


--
Alex Benn=C3=A9e
