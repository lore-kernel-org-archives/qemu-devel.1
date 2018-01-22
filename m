Received: from eggs.gnu.org ([2001:4830:134:3::10]:43385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ededD-0002kw-7G
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eded9-0007US-Gz
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:07:35 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eded9-0007Tv-Bi
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:07:31 -0500
Received: by mail-pg0-x243.google.com with SMTP id u1so7429395pgr.0
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 08:07:31 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-10-richard.henderson@linaro.org>
	<87vafuje0q.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <502ebfa1-7fd9-b953-2681-f73304b1b4ce@linaro.org>
Date: Mon, 22 Jan 2018 08:07:27 -0800
MIME-Version: 1.0
In-Reply-To: <87vafuje0q.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/16] target/arm: Add predicate
 registers for SVE
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

On 01/22/2018 04:04 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/cpu.h | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 57d805b5d8..132da359b5 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -186,6 +186,15 @@ typedef struct ARMVectorReg {
>>      uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
>>  } ARMVectorReg;
>>
>> +/* In AArch32 mode, predicate registers do not exist at all.  */
>> +typedef struct ARMPredicateReg {
>> +#ifdef TARGET_AARCH64
>> +    uint64_t p[2 * ARM_MAX_VQ / 8] QEMU_ALIGNED(16);
>> +#else
>> +    uint64_t p[0];
>> +#endif
>> +} ARMPredicateReg;
>> +
>>
>>  typedef struct CPUARMState {
>>      /* Regs for current mode.  */
>> @@ -513,6 +522,9 @@ typedef struct CPUARMState {
>>      struct {
>>          ARMVectorReg zregs[32];
>>
>> +        /* Store FFR as pregs[16] to make it easier to treat as any other.  */
>> +        ARMPredicateReg pregs[17];
>> +
> 
> What happens if code tries to accidentally access this on the 32 bit build?

*shrug* About what you'd expect.  What do you suggest?  Ifdeffery?


r~
