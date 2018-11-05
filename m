Received: from eggs.gnu.org ([2001:4830:134:3::10]:45514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJhi2-0004R6-PB
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJhhk-0008QN-Qi
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:26:32 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJhhg-0008LU-SN
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:26:19 -0500
Received: by mail-oi1-x242.google.com with SMTP id i138-v6so4978108oib.1
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 08:26:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87tvkvebmd.fsf@linaro.org>
References: <20181016093703.10637-1-peter.maydell@linaro.org>
	<20181016093703.10637-2-peter.maydell@linaro.org>
	<87tvkvebmd.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 16:25:53 +0000
Message-ID: <CAFEAcA8tPHFHFHeB5ty2x6GGgTs6aQG3ckD6NkzOR7OgAX-f9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/2] target/arm: Set S and PTW
 in 64-bit PAR format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 5 November 2018 at 16:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> In do_ats_write() we construct a PAR value based on the result
>> of the translation.  A comment says "S2WLK and FSTAGE are always
>> zero, because we don't implement virtualization".
>> Since we do in fact now implement virtualization, add the missing
>> code that sets these bits based on the reported ARMMMUFaultInfo.
>>
>> (These bits are named PTW and S in ARMv8, so we follow that
>> convention in the new comments in this patch.)
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/helper.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 43afdd082e1..dc849b09893 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -2344,10 +2344,12 @@ static uint64_t do_ats_write(CPUARMState *env, u=
int64_t value,
>>
>>              par64 |=3D 1; /* F */
>
> To aid readability, mainly for those not familiar like me, maybe:
>
>   par64 |=3D 1; /* PAR_EL1.F =3D=3D 1, failed translation */

That's in the existing code...

>>              par64 |=3D (fsr & 0x3f) << 1; /* FS */
>> -            /* Note that S2WLK and FSTAGE are always zero, because we d=
on't
>> -             * implement virtualization and therefore there can't be a =
stage 2
>> -             * fault.
>> -             */
>> +            if (fi.stage2) {
>> +                par64 |=3D (1 << 9); /* S */
>> +            }
>> +            if (fi.s1ptw) {
>> +                par64 |=3D (1 << 8); /* PTW */
>> +            }
>>          }
>>      } else {
>>          /* fsr is a DFSR/IFSR value for the short descriptor
>
> Anyway:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

thanks
-- PMM
