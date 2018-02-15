Received: from eggs.gnu.org ([2001:4830:134:3::10]:59599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emO2u-0007qq-8f
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emO2q-0000ct-V8
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:14:12 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215175707.15491-1-peter.maydell@linaro.org>
	<20180215175707.15491-3-peter.maydell@linaro.org>
	<CAFEAcA_UWVgwEsTq2Tebn+yL5Ckd_7_S_wUvsKMDZfEHxr9stQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <04e252ac-0f7f-d045-2484-8793399333cb@amsat.org>
Date: Thu, 15 Feb 2018 15:14:04 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_UWVgwEsTq2Tebn+yL5Ckd_7_S_wUvsKMDZfEHxr9stQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/3] hw/arm/boot: Honour CPU's
 address space for image loads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 02/15/2018 03:06 PM, Peter Maydell wrote:
> On 15 February 2018 at 17:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Instead of loading kernels, device trees, and the like to
>> the system address space, use the CPU's address space. This
>> is important if we're trying to load the file to memory or
>> via an alias memory region that is provided by an SoC
>> object and thus not mapped into the system address space.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/arm/boot.c | 119 +++++++++++++++++++++++++++++++++++++---------------------
>>  1 file changed, 76 insertions(+), 43 deletions(-)
>>
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index 9b174b982c..0eac655c98 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -35,6 +35,25 @@
>>  #define ARM64_TEXT_OFFSET_OFFSET    8
>>  #define ARM64_MAGIC_OFFSET          56
>>
>> +static AddressSpace *arm_boot_addressspace(ARMCPU *cpu,
>> +                                           const struct arm_boot_info *info)
>> +{
>> +    /* Return the address space to use for bootloader reads and writes.
>> +     * We prefer the secure address space if the CPU has it and we're
>> +     * going to boot the guest into it.
>> +     */
>> +    int asidx;
>> +    CPUState *cs = CPU(cpu);
>> +
>> +    if (arm_feature(&cpu->env, ARM_FEATURE_EL3) && info->secure_boot) {
>> +        asidx = ARMASIdx_S;
>> +    } else {
>> +        asidx = ARMASIdx_NS;
>> +    }
>> +
>> +    return cpu_get_address_space(cs, asidx);
>> +}
>> +
>>  typedef enum {
>>      FIXUP_NONE = 0,     /* do nothing */
>>      FIXUP_TERMINATOR,   /* end of insns */
>> @@ -124,7 +143,8 @@ static const ARMInsnFixup smpboot[] = {
>>  };
>>
>>  static void write_bootloader(const char *name, hwaddr addr,
>> -                             const ARMInsnFixup *insns, uint32_t *fixupcontext)
>> +                             const ARMInsnFixup *insns, uint32_t *fixupcontext,
>> +                             AddressSpace *as)
>>  {
>>      /* Fix up the specified bootloader fragment and write it into
>>       * guest memory using rom_add_blob_fixed(). fixupcontext is
>> @@ -163,7 +183,7 @@ static void write_bootloader(const char *name, hwaddr addr,
>>          code[i] = tswap32(insn);
>>      }
>>
>> -    rom_add_blob_fixed(name, code, len * sizeof(uint32_t), addr);
>> +    rom_add_blob_fixed_as(name, code, len * sizeof(uint32_t), addr, as);
>>
>>      g_free(code);
>>  }
>> @@ -172,6 +192,7 @@ static void default_write_secondary(ARMCPU *cpu,
>>                                      const struct arm_boot_info *info)
>>  {
>>      uint32_t fixupcontext[FIXUP_MAX];
>> +    AddressSpace *as = CPU(cpu)->as;
> 
> Oops. This should be
>     AddressSpace *as = arm_boot_addressspace(cpu, info);

I was stuck there wondering why this one were using the CPU AS :)

> 
>>      fixupcontext[FIXUP_GIC_CPU_IF] = info->gic_cpu_if_addr;
>>      fixupcontext[FIXUP_BOOTREG] = info->smp_bootreg_addr;
>> @@ -182,13 +203,14 @@ static void default_write_secondary(ARMCPU *cpu,
>>      }
>>
>>      write_bootloader("smpboot", info->smp_loader_start,
>> -                     smpboot, fixupcontext);
>> +                     smpboot, fixupcontext, as);
>>  }
>>
>>  void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
>>                                              const struct arm_boot_info *info,
>>                                              hwaddr mvbar_addr)
>>  {
>> +    AddressSpace *as = CPU(cpu)->as;
> 
> ...and so should this.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> thanks
> -- PMM
> 
