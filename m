Received: from eggs.gnu.org ([2001:4830:134:3::10]:45078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fCnZ1-0004fg-Tx
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 10:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fCnYy-0002we-RM
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 10:44:31 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:52335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fCnYy-0002wP-Lb
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 10:44:28 -0400
Received: by mail-it0-x244.google.com with SMTP id f6-v6so7243805ita.2
	for <qemu-devel@nongnu.org>; Sun, 29 Apr 2018 07:44:28 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<20180425012300.14698-2-richard.henderson@linaro.org>
	<87y3h8k53u.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <05b38654-ae3a-1f02-019f-b71917509097@linaro.org>
Date: Sun, 29 Apr 2018 09:44:24 -0500
MIME-Version: 1.0
In-Reply-To: <87y3h8k53u.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/9] target/arm: Implement vector shifted
 SCVF/UCVF for fp16
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

On 04/27/2018 11:04 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> While we have some of the scalar paths for *CVF for fp16,
>> we failed to decode the fp16 version of these instructions.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate-a64.c | 33 ++++++++++++++++++++-------------
>>  1 file changed, 20 insertions(+), 13 deletions(-)
>>
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>> index b47319d437..c92e052686 100644
>> --- a/target/arm/translate-a64.c
>> +++ b/target/arm/translate-a64.c
>> @@ -7077,13 +7077,26 @@ static void handle_simd_shift_intfp_conv(DisasContext *s, bool is_scalar,
>>                                           int immh, int immb, int opcode,
>>                                           int rn, int rd)
>>  {
>> -    bool is_double = extract32(immh, 3, 1);
>> -    int size = is_double ? MO_64 : MO_32;
>> -    int elements;
>> +    int size, elements, fracbits;
>>      int immhb = immh << 3 | immb;
>> -    int fracbits = (is_double ? 128 : 64) - immhb;
>>
>> -    if (!extract32(immh, 2, 2)) {
>> +    if (immh & 8) {
>> +        size = MO_64;
>> +        if (!is_scalar && !is_q) {
>> +            unallocated_encoding(s);
>> +            return;
>> +        }
>> +    } else if (immh & 4) {
>> +        size = MO_32;
>> +    } else if (immh & 2) {
>> +        size = MO_16;
>> +        if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
>> +            unallocated_encoding(s);
>> +            return;
>> +        }
>> +    } else {
>> +        /* immh == 0 would be a failure of the decode logic */
>> +        g_assert(immh == 1);
>>          unallocated_encoding(s);
>>          return;
>>      }
>> @@ -7091,20 +7104,14 @@ static void handle_simd_shift_intfp_conv(DisasContext *s, bool is_scalar,
>>      if (is_scalar) {
>>          elements = 1;
>>      } else {
>> -        elements = is_double ? 2 : is_q ? 4 : 2;
>> -        if (is_double && !is_q) {
>> -            unallocated_encoding(s);
>> -            return;
>> -        }
>> +        elements = 8 << is_q >> size;
> 
> That is a brain exercise for operator precedence. Would:
> 
>      elements = (is_q ? 16 : 8) >> size;
> 
> be clearer?

I don't think so myself.  I thought the double conditional harder to follow.

>> +    fracbits = (16 << size) - immhb;
> 
> The ship has already sailed on this but I'm wishing we had a
> mosize_to_bits() helper function to be explicit about this
> transformation.

Yeah, that might have been a good thing...


r~
