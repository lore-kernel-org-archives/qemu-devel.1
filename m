Received: from eggs.gnu.org ([2001:4830:134:3::10]:47777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penberg@iki.fi>) id 1ema8E-0007oX-RN
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 02:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penberg@iki.fi>) id 1ema8D-0004uU-KK
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 02:08:30 -0500
References: <20180208055039.24666-1-penberg@iki.fi>
	<20180208055039.24666-4-penberg@iki.fi>
	<CAFEAcA_008TiXr0RYmPuhPcmSY9qx=Ju8CMAu_t-z+DBRruykA@mail.gmail.com>
From: Pekka Enberg <penberg@iki.fi>
Message-ID: <860616da-8c52-43d6-ccbe-1010f5419a38@iki.fi>
Date: Fri, 16 Feb 2018 09:08:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_008TiXr0RYmPuhPcmSY9qx=Ju8CMAu_t-z+DBRruykA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/3] raspi: Add "raspi3" machine type
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

Hi,

On 02/15/2018 02:39 PM, Peter Maydell wrote:
> On 8 February 2018 at 05:50, Pekka Enberg <penberg@iki.fi> wrote:
>> This patch adds a "raspi3" machine type, which can now be selected as
>> the machine to run on by users via the "-M" command line option to QEMU.
>>
>> The machine type does *not* ignore memory transaction failures so we
>> likely need to add some dummy devices later when people run something
>> more complicated than what I'm using for testing.
>>
>> Signed-off-by: Pekka Enberg <penberg@iki.fi>
>> ---
>>   hw/arm/raspi.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>> index 66fe10e376..048ff23a51 100644
>> --- a/hw/arm/raspi.c
>> +++ b/hw/arm/raspi.c
>> @@ -187,3 +187,24 @@ static void raspi2_machine_init(MachineClass *mc)
>>       mc->ignore_memory_transaction_failures = true;
>>   };
>>   DEFINE_MACHINE("raspi2", raspi2_machine_init)
>> +
>> +static void raspi3_init(MachineState *machine)
>> +{
>> +    raspi_init(machine, 3);
>> +}
>> +
>> +static void raspi3_machine_init(MachineClass *mc)
>> +{
>> +    mc->desc = "Raspberry Pi 3";
>> +    mc->init = raspi3_init;
>> +    mc->block_default_type = IF_SD;
>> +    mc->no_parallel = 1;
>> +    mc->no_floppy = 1;
>> +    mc->no_cdrom = 1;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
>> +    mc->max_cpus = BCM2836_NCPUS;
>> +    mc->min_cpus = BCM2836_NCPUS;
>> +    mc->default_cpus = BCM2836_NCPUS;
>> +    mc->default_ram_size = 1024 * 1024 * 1024;
>> +}
>> +DEFINE_MACHINE("raspi3", raspi3_machine_init)
> 
> Hi. This patch breaks "make check", because it adds the raspi3
> to the arm-softmmu (32-bit guest CPUs only) build, where the
> cortex-a53 CPU doesn't exist:
> 
> e104462:xenial:qemu$ ./build/x86/arm-softmmu/qemu-system-arm -M raspi3
> **
> ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:372:object_initialize_with_type:
> assertion failed: (type != NULL)
> Aborted (core dumped)
> 
> The usual way we avoid this is that 64-bit only boards are
> in their own source file, which is only compiled if the right
> CONFIG_FOO is set by default-configs/aarch64-softmmu.mak.
> In this case splitting the 64-bit board into its own source
> file would be weird and awkward, so the simple thing is to
> guard the raspi3 bits with #ifdef TARGET_AARCH64.
> 
> (You might think we could define a CONFIG_RASPI3 in
> aarch64-softmmu.mak and #ifdef on it, but for some reason
> we don't expose those CONFIG_* to C code, possibly just because
> we've never needed to in the past...)
> 
> Since this was the only code change needed, I'm just going to make
> it and apply the patchset to target-arm.next, rather than ask
> you to do a respin. (There was also a stray space-at-end-of-line
> in patch 2 which checkpatch grumbles about; I'll fix that up too.)

Oh, it would have helped if I had actually read the whole thread before 
sending out v2. If I understood correctly, you only applied the first 
two patches (sorry about that trailing whitespace!). You therefore can 
just pick patch 3 from the v2 as the first two patches are unchanged.

Regards,

- Pekka
