Received: from eggs.gnu.org ([2001:4830:134:3::10]:36998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHBCA-0007xR-SC
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHBC6-0000UW-WC
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:47:02 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHBC6-0000Ti-Pl
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:46:58 -0400
Received: by mail-pg0-x244.google.com with SMTP id n9-v6so2663319pgq.5
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 09:46:58 -0700 (PDT)
References: <20180511004345.26708-1-richard.henderson@linaro.org>
	<20180511004345.26708-5-richard.henderson@linaro.org>
	<87bmdmupil.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <841b76c0-0684-c7e4-ddce-38a29bc110c5@linaro.org>
Date: Fri, 11 May 2018 09:46:53 -0700
MIME-Version: 1.0
In-Reply-To: <87bmdmupil.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/19] fpu/softfloat: Canonicalize NaN
 fraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 05/11/2018 09:26 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Shift the NaN fraction to a canonical position, much like we do
>> for the fraction of normal numbers.  Immediately, this simplifies
>> the float-to-float conversion.  Later, this will facilitate
>> manipulation of NaNs within the shared code paths.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  fpu/softfloat.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>> index 5e4982b035..df377b6314 100644
>> --- a/fpu/softfloat.c
>> +++ b/fpu/softfloat.c
>> @@ -329,10 +329,11 @@ static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
>>          if (part.frac == 0) {
>>              part.cls = float_class_inf;
>>          } else {
>> +            part.frac <<= parm->frac_shift;
>>  #ifdef NO_SIGNALING_NANS
>>              part.cls = float_class_qnan;
>>  #else
>> -            int64_t msb = part.frac << (parm->frac_shift + 2);
>> +            int64_t msb = part.frac << 2;
>>              if ((msb < 0) == status->snan_bit_is_one) {
>>                  part.cls = float_class_snan;
>>              } else {
>> @@ -498,6 +499,7 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
>>      case float_class_qnan:
>>      case float_class_snan:
>>          exp = exp_max;
>> +        frac >>= parm->frac_shift;
> 
> Unfortunately we now miss this step when we handle:
> 
>     case float_class_msnan:
>         return float64_maybe_silence_nan(float64_pack_raw(p), s);
> 
> This seems to fix that:
> 
> recanonicalise frac before packing and sending

Good catch.  Merged for bisection.


r~
