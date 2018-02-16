Received: from eggs.gnu.org ([2001:4830:134:3::10]:47194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penberg@iki.fi>) id 1ema4W-0005PR-DM
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 02:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penberg@iki.fi>) id 1ema4V-0002Ye-Dp
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 02:04:40 -0500
References: <20180208055039.24666-1-penberg@iki.fi>
	<20180208055039.24666-2-penberg@iki.fi>
	<CAFEAcA8EWmaf5JWEmgBsNknTHuKDaHCnEAQgatn7Ppq-Gy8Fzg@mail.gmail.com>
From: Pekka Enberg <penberg@iki.fi>
Message-ID: <d7b4ff0d-d05f-0128-f403-d525a6e4176d@iki.fi>
Date: Fri, 16 Feb 2018 09:04:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8EWmaf5JWEmgBsNknTHuKDaHCnEAQgatn7Ppq-Gy8Fzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/3] bcm2836: Make CPU type configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>



On 02/15/2018 01:48 PM, Peter Maydell wrote:
> On 8 February 2018 at 05:50, Pekka Enberg <penberg@iki.fi> wrote:
>> This patch adds a "cpu-type" property to BCM2836 SoC in preparation for
>> reusing the code for the Raspberry Pi 3, which has a different processor
>> model.
>>
>> Signed-off-by: Pekka Enberg <penberg@iki.fi>
> 
>> --- a/hw/arm/raspi.c
>> +++ b/hw/arm/raspi.c
>> @@ -135,6 +135,8 @@ static void raspi2_init(MachineState *machine)
>>       /* Setup the SOC */
>>       object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
>>                                      &error_abort);
>> +    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
>> +                            &error_abort);
>>       object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
>>                               &error_abort);
>>       object_property_set_int(OBJECT(&s->soc), 0xa21041, "board-rev",
>> @@ -166,6 +168,7 @@ static void raspi2_machine_init(MachineClass *mc)
>>       mc->no_parallel = 1;
>>       mc->no_floppy = 1;
>>       mc->no_cdrom = 1;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
>>       mc->max_cpus = BCM2836_NCPUS;
>>       mc->min_cpus = BCM2836_NCPUS;
>>       mc->default_cpus = BCM2836_NCPUS;
> 
> This change means that instead of ignoring the user's -cpu argument
> we'll now unconditionally accept it even if it's nonsense for this
> board. Neither behaviour is great. However, the patchset to allow
> boards to easily specify the valid set of CPU types is still in
> code review:
> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00308.html
> 
> so I'm happy to take this as-is, and we'll add the validity check
> when that patchset goes in.

I wondered about that too, but I applied the "monkey see, monkey do" 
approach to your review comments of the previous attempt. :-) But 
indeed, I also think we can fix this later in the tree.

- Pekka
