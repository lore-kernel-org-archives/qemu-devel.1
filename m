Received: from eggs.gnu.org ([209.51.188.92]:40121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1E1p-0007V5-Ur
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1E1l-0003aI-JQ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:38:55 -0500
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-5-mark.cave-ayland@ilande.co.uk>
	<a6832b4d-f6ae-e783-f3df-68d702eb18ef@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <df436d44-56a7-8796-36a0-266b0a8091a0@ilande.co.uk>
Date: Tue, 5 Mar 2019 17:38:44 +0000
MIME-Version: 1.0
In-Reply-To: <a6832b4d-f6ae-e783-f3df-68d702eb18ef@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/8] target/ppc: introduce avrh_offset()
 and avrl_offset() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 03/03/2019 23:31, Richard Henderson wrote:

> On 3/3/19 9:23 AM, Mark Cave-Ayland wrote:
>> These will become more useful later, but initially use this as an aid to
>> simplify the offset calculation by replacing the HOST_TARGET_BIGENDIAN
>> sections with the VsrD macro.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  target/ppc/cpu.h       | 10 ++++++++++
>>  target/ppc/translate.c | 24 ++++++++++--------------
>>  2 files changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index d0580c6b6d..326593e0e7 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -2603,6 +2603,16 @@ static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
>>      return (uint64_t *)((uintptr_t)env + vsrl_offset(i));
>>  }
>>  
>> +static inline int avrh_offset(int i)
>> +{
>> +    return offsetof(CPUPPCState, vsr[32 + i].VsrD(0));
>> +}
>> +
>> +static inline int avrl_offset(int i)
>> +{
>> +    return offsetof(CPUPPCState, vsr[32 + i].VsrD(1));
>> +}
> 
> I really don't see the point of these...
> 
>>  static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
>>  {
>> -#ifdef HOST_WORDS_BIGENDIAN
>> -    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
>> -                                          vsr[32 + regno].u64[(high ? 0 : 1)]));
>> -#else
>> -    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
>> -                                          vsr[32 + regno].u64[(high ? 1 : 0)]));
>> -#endif
>> +    if (high) {
>> +        tcg_gen_ld_i64(dst, cpu_env, avrh_offset(regno));
>> +    } else {
>> +        tcg_gen_ld_i64(dst, cpu_env, avrl_offset(regno));
>> +    }
> 
> When you could just as well write this as
> 
>   tcg_gen_ld_i64(dst, cpu_env,
>     offsetof(CPUPPCState, vsr[32+regno].VsrD(high)));

It's really that this is a stepping stone to patch 7 where you end up with this:

static inline int vsrh_offset(int i)
{
    return offsetof(CPUPPCState, vsr[i].VsrD(0));
}

static inline int vsrl_offset(int i)
{
    return offsetof(CPUPPCState, vsr[i].VsrD(1));
}

...

static inline int avrh_offset(int i)
{
    return vsrh_offset(i + 32);
}

static inline int avrl_offset(int i)
{
    return vsrl_offset(i + 32);
}

i.e. the logic that describes the AVR registers as being the last set of 32 VSX
registers is captured more succinctly in the avr[l,h] wrapper functions. How about
rewriting the above like this:

    tcg_gen_ld_i64(dst, cpu_env, high ? avrh_offset(regno) : avrl_offset(regno));

which looks a bit easier on the eye? I'm less keen on pushing the "high" bool all the
way down into offset functions as I find the separate vsrh/vsrl functions much easier
to read in the helpers than the get_avr64() version.


ATB,

Mark.
