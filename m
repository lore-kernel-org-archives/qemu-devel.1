Received: from eggs.gnu.org ([2001:4830:134:3::10]:50764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eCA79-0000vK-LC
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 15:04:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eCA78-0001sm-5D
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 15:04:51 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171107200026.GF3111@localhost.localdomain>
References: <cover.1510080103.git.alistair.francis@xilinx.com>
	<949865c4381080ce685097390f69115d7f6ef111.1510080103.git.alistair.francis@xilinx.com>
	<20171107200026.GF3111@localhost.localdomain>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 7 Nov 2017 12:04:18 -0800
Message-ID: <CAKmqyKPtzhQk+=vW=fmOxWrWiDhBZJ9FCPcKroeW7756Fd-R4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/2] xlnx-zynqmp: Properly support the
 smp command line option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Edgar Iglesias <edgar.iglesias@gmail.com>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, Nov 7, 2017 at 12:00 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Tue, Nov 07, 2017 at 10:59:39AM -0800, Alistair Francis wrote:
>> Allow the -smp command line option to control the number of CPUs we
>> create.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>  hw/arm/xlnx-zcu102.c |  3 ++-
>>  hw/arm/xlnx-zynqmp.c | 26 ++++++++++++++++----------
>>  2 files changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
>> index e2d15a1c9d..7ec03dad42 100644
>> --- a/hw/arm/xlnx-zcu102.c
>> +++ b/hw/arm/xlnx-zcu102.c
>> @@ -235,7 +235,8 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
>>  {
>>      MachineClass *mc = MACHINE_CLASS(oc);
>>
>> -    mc->desc = "Xilinx ZynqMP ZCU102 board";
>> +    mc->desc = "Xilinx ZynqMP ZCU102 board with 4xA53s and 2xR5s based on " \
>> +               "the value of smp";
>>      mc->init = xlnx_zcu102_init;
>>      mc->block_default_type = IF_IDE;
>>      mc->units_per_default_bus = 1;
>> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
>> index d4b6560194..c707c66322 100644
>> --- a/hw/arm/xlnx-zynqmp.c
>> +++ b/hw/arm/xlnx-zynqmp.c
>> @@ -98,8 +98,9 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
>>  {
>>      Error *err = NULL;
>>      int i;
>> +    int num_rpus = MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQMP_NUM_RPU_CPUS);
>>
>> -    for (i = 0; i < XLNX_ZYNQMP_NUM_RPU_CPUS; i++) {
>> +    for (i = 0; i < num_rpus; i++) {
>>          char *name;
>>
>>          object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
>> @@ -132,8 +133,9 @@ static void xlnx_zynqmp_init(Object *obj)
>>  {
>>      XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
>>      int i;
>> +    int num_apus = MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
>>
>> -    for (i = 0; i < XLNX_ZYNQMP_NUM_APU_CPUS; i++) {
>> +    for (i = 0; i < num_apus; i++) {
>>          object_initialize(&s->apu_cpu[i], sizeof(s->apu_cpu[i]),
>>                            "cortex-a53-" TYPE_ARM_CPU);
>>          object_property_add_child(obj, "apu-cpu[*]", OBJECT(&s->apu_cpu[i]),
>> @@ -182,6 +184,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>>      MemoryRegion *system_memory = get_system_memory();
>>      uint8_t i;
>>      uint64_t ram_size;
>> +    int num_apus = MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
>>      const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
>>      ram_addr_t ddr_low_size, ddr_high_size;
>>      qemu_irq gic_spi[GIC_NUM_SPI_INTR];
>> @@ -233,10 +236,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>>
>>      qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", GIC_NUM_SPI_INTR + 32);
>>      qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
>> -    qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", XLNX_ZYNQMP_NUM_APU_CPUS);
>> +    qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", num_apus);
>>
>>      /* Realize APUs before realizing the GIC. KVM requires this.  */
>> -    for (i = 0; i < XLNX_ZYNQMP_NUM_APU_CPUS; i++) {
>> +    for (i = 0; i < num_apus; i++) {
>>          char *name;
>>
>>          object_property_set_int(OBJECT(&s->apu_cpu[i]), QEMU_PSCI_CONDUIT_SMC,
>> @@ -292,7 +295,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>>          }
>>      }
>>
>> -    for (i = 0; i < XLNX_ZYNQMP_NUM_APU_CPUS; i++) {
>> +    for (i = 0; i < num_apus; i++) {
>>          qemu_irq irq;
>>
>>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i,
>> @@ -307,11 +310,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>>      }
>>
>>      if (s->has_rpu) {
>> -        xlnx_zynqmp_create_rpu(s, boot_cpu, &err);
>> -        if (err) {
>> -            error_propagate(errp, err);
>> -            return;
>> -        }
>> +        info_report("The 'has_rpu' property is no longer required, to use the "
>> +                    "RPUs just use -smp 6.");
>> +    }
>
> Is "-global driver=xlnx,,zynqmp,property=has_rpu,value=on"
> without an explicit -smp option supposed to be a supported
> configuration?
>
> 0) On current master, we have this:
>
>   $ ./aarch64-softmmu/qemu-system-aarch64 -machine xlnx-zcu102 -global driver=xlnx,,zynqmp,property=has_rpu,value=on
>   **
>   ERROR:/home/ehabkost/rh/proj/virt/qemu/tcg/tcg.c:538:tcg_register_thread: assertion failed: (n < max_cpus)
>   Aborted (core dumped)
>
> 1) With your patch we have this:
>
>   $ ./aarch64-softmmu/qemu-system-aarch64 -machine xlnx-zcu102 -global driver=xlnx,,zynqmp,property=has_rpu,value=on -monitor stdio
>   QEMU 2.10.50 monitor - type 'help' for more information
>   (qemu) qemu-system-aarch64: info: The 'has_rpu' property is no longer required, to use the RPUs just use -smp 6.
>   (qemu) info cpus
>   * CPU #0: thread_id=1662
>   (qemu)
>
> 2) With your patch plus Emilio's original min_cpus/default_cpus
> proposal[1], we have this:
>
>   $ ./aarch64-softmmu/qemu-system-aarch64 -machine xlnx-zcu102 -global driver=xlnx,,zynqmp,property=has_rpu,value=on -monitor stdio
>   QEMU 2.10.50 monitor - type 'help' for more information
>   (qemu) qemu-system-aarch64: info: The 'has_rpu' property is no longer required, to use the RPUs just use -smp 6.
>   (qemu) info cpus
>   * CPU #0: thread_id=7112
>     CPU #1: (halted) thread_id=7113
>     CPU #2: (halted) thread_id=7114
>     CPU #3: (halted) thread_id=7115
>   (qemu)
>
> 3) With Emilio's max_additional_cpus proposal[2], we have this:
>
>   $ ./aarch64-softmmu/qemu-system-aarch64 -machine xlnx-zcu102 -global driver=xlnx,,zynqmp,property=has_rpu,value=on -monitor stdio
>   QEMU 2.10.50 monitor - type 'help' for more information
>   (qemu) info cpus
>   * CPU #0: thread_id=4045
>     CPU #1: (halted) thread_id=4046
>     CPU #2: (halted) thread_id=4047
>     CPU #3: (halted) thread_id=4048
>     CPU #4: (halted) thread_id=4049
>     CPU #5: (halted) thread_id=4050
>   (qemu)
>
>
> Which option is preferred?  I like option #2 because it's
> simpler, but I would like to confirm this is really the intended
> behavior.

After this patch (and the fix to TCG otherwise it seg faults) no one
should use the has_rpu property. It is ignored and will print a
message saying that it is ignored.

Users should only use the -smp option now. So option 2 is the way to go.

Thanks,
Alistair

>
>
> [1] https://mid.mail-archive.com/1509734853-3014-1-git-send-email-cota@braap.org
> [2] https://mid.mail-archive.com/20171106215454.GB2152@flamenco
>
>
>> +
>> +    xlnx_zynqmp_create_rpu(s, boot_cpu, &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>>      }
>>
>>      if (!s->boot_cpu_ptr) {
>> --
>> 2.11.0
>>
>
> --
> Eduardo
