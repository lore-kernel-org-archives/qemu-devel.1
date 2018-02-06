Received: from eggs.gnu.org ([2001:4830:134:3::10]:44947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ejB2I-0004KS-FB
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 16:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ejB2F-0006ky-9F
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 16:44:18 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43733
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ejB2F-0006kG-2n
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 16:44:15 -0500
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
	<20180203103727.26457-9-mark.cave-ayland@ilande.co.uk>
	<dd88d3c0-0ba9-b402-6cd8-7a2ead9016b8@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <29f65006-9c6e-e1cc-2c8e-185ddc5d6c37@ilande.co.uk>
Date: Tue, 6 Feb 2018 21:44:03 +0000
MIME-Version: 1.0
In-Reply-To: <dd88d3c0-0ba9-b402-6cd8-7a2ead9016b8@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/10] cuda: factor out timebase-derived
 counter value and load time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, lvivier@redhat.com

On 05/02/18 19:44, Philippe Mathieu-Daudé wrote:

> On 02/03/2018 07:37 AM, Mark Cave-Ayland wrote:
>> Commit b981289c49 "PPC: Cuda: Use cuda timer to expose tbfreq to guest" altered
>> the timer calculations from those based upon the hardware CUDA clock frequency
>> to those based upon the CPU timebase frequency.
>>
>> In fact we can isolate the differences to 2 simple changes: one to the counter
>> read value and another to the counter load time. Move these changes into
>> separate functions so the implementation can be swapped later.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/misc/macio/cuda.c | 25 ++++++++++++++++---------
>>   1 file changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
>> index 00e71fcd5e..184d151702 100644
>> --- a/hw/misc/macio/cuda.c
>> +++ b/hw/misc/macio/cuda.c
>> @@ -145,21 +145,29 @@ static void cuda_update_irq(CUDAState *s)
>>       }
>>   }
>>   
>> -static uint64_t get_tb(uint64_t time, uint64_t freq)
>> +static uint64_t get_counter_value(CUDAState *s, CUDATimer *ti)
>>   {
>> -    return muldiv64(time, freq, NANOSECONDS_PER_SECOND);
>> +    /* Reverse of the tb calculation algorithm that Mac OS X uses on bootup */
>> +    uint64_t tb_diff = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
>> +                                s->tb_frequency, NANOSECONDS_PER_SECOND) -
>> +                           ti->load_time;
> 
> Easier to read imho:
> 
>         uint64_t tb_diff = get_counter_load_time(s, ti) - ti->load_time;

Yes - I'm in two minds about this one, although I feel as if I should 
keep these functions completely separate since they form separate 
virtual methods in the device class (see patch 10). Does looking at that 
particular patch change your opinion at all?

> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
>> +
>> +    return (tb_diff * 0xBF401675E5DULL) / (s->tb_frequency << 24);
>> +}
>> +
>> +static uint64_t get_counter_load_time(CUDAState *s, CUDATimer *ti)
>> +{
>> +    uint64_t load_time = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
>> +                                  s->tb_frequency, NANOSECONDS_PER_SECOND);
>> +    return load_time;
>>   }
>>   
>>   static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
>>   {
>>       int64_t d;
>>       unsigned int counter;
>> -    uint64_t tb_diff;
>> -    uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>>   
>> -    /* Reverse of the tb calculation algorithm that Mac OS X uses on bootup. */
>> -    tb_diff = get_tb(current_time, s->tb_frequency) - ti->load_time;
>> -    d = (tb_diff * 0xBF401675E5DULL) / (s->tb_frequency << 24);
>> +    d = get_counter_value(s, ti);
>>   
>>       if (ti->index == 0) {
>>           /* the timer goes down from latch to -1 (period of latch + 2) */
>> @@ -178,8 +186,7 @@ static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
>>   static void set_counter(CUDAState *s, CUDATimer *ti, unsigned int val)
>>   {
>>       CUDA_DPRINTF("T%d.counter=%d\n", 1 + ti->index, val);
>> -    ti->load_time = get_tb(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
>> -                           s->tb_frequency);
>> +    ti->load_time = get_counter_load_time(s, ti);
>>       ti->counter_value = val;
>>       cuda_timer_update(s, ti, ti->load_time);
>>   }
>>


ATB,

Mark.
