Received: from eggs.gnu.org ([209.51.188.92]:34076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1DgN-0006q6-Nv
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1DgM-0008VN-SM
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:16:47 -0500
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-6-mark.cave-ayland@ilande.co.uk>
	<dac4fce0-f063-5d41-1fc5-66e1eeac3c2c@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a1ffd292-ffd6-0458-7f25-daf064273186@ilande.co.uk>
Date: Tue, 5 Mar 2019 17:16:33 +0000
MIME-Version: 1.0
In-Reply-To: <dac4fce0-f063-5d41-1fc5-66e1eeac3c2c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/8] target/ppc: introduce avr_offset()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 03/03/2019 23:29, Richard Henderson wrote:

> On 3/3/19 9:23 AM, Mark Cave-Ayland wrote:
>> All TCG vector operations require pointers to the base address of the vector
>> rather than separate access to the top and bottom 64-bits. Convert
>> the VMX TCG instructions to use a new avr_offset() function instead of
>> avr64_offset(), which can itself be written as a simple wrapper onto
>> vsr_full_offset().
>>
>> After the conversion is complete then avr64_offset() can be removed since its
>> functionality is now completely within get_avr64()/set_avr64().
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  target/ppc/cpu.h                    | 12 +++++++++++-
>>  target/ppc/translate/vmx-impl.inc.c | 27 +++++++++++----------------
>>  target/ppc/translate/vsx-impl.inc.c |  5 -----
>>  3 files changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index 326593e0e7..89651988ab 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -2598,6 +2598,11 @@ static inline int vsrl_offset(int i)
>>      return offsetof(CPUPPCState, vsr[i].u64[1]);
>>  }
>>  
>> +static inline int vsr_full_offset(int i)
>> +{
>> +    return offsetof(CPUPPCState, vsr[i].u64[0]);
>> +}
>> +
>>  static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
>>  {
>>      return (uint64_t *)((uintptr_t)env + vsrl_offset(i));
>> @@ -2613,9 +2618,14 @@ static inline int avrl_offset(int i)
>>      return offsetof(CPUPPCState, vsr[32 + i].VsrD(1));
>>  }
>>  
>> +static inline int avr_offset(int i)
>> +{
>> +    return vsr_full_offset(i + 32);
>> +}
> 
> avr_full_offset?

I chose avr_offset() because once you get to the end of the patchset, everything uses
offsets to the first byte of the register regardless of endian except for the avr64
functions (i.e. full becomes the new normal which seems like a fairly standard
expectation for offset).

Really though I don't feel too strongly about this, so would you like me to rename it
avr_full_offset() to match the existing vsr_full_offset()?



ATB,

Mark.
