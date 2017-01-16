Received: from eggs.gnu.org ([2001:4830:134:3::10]:33961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cTDKY-0001dW-M0
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:52:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cTDKV-0007bL-Cs
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:52:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cTDKV-0007Zy-3q
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:52:35 -0500
References: <1484376662-32063-1-git-send-email-thuth@redhat.com>
	<20170116172503.GA3491@thinpad.lan.raisama.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fc0f7df0-f1b3-1e03-6d64-8c234d8b33d9@redhat.com>
Date: Mon, 16 Jan 2017 20:52:28 +0100
MIME-Version: 1.0
In-Reply-To: <20170116172503.GA3491@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/core/null-machine: Add the possibility
 to instantiate a CPU, RAM and kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>

On 16.01.2017 18:25, Eduardo Habkost wrote:
> On Sat, Jan 14, 2017 at 07:51:02AM +0100, Thomas Huth wrote:
>> Sometimes it is useful to have just a machine with CPU and RAM, withou=
t
>> any further hardware in it, e.g. if you just want to do some instructi=
on
>> debugging for TCG with a remote GDB attached to QEMU, or run some embe=
dded
>> code with the "-semihosting" QEMU parameter. qemu-system-m68k already
>> features a "dummy" machine, and xtensa a "sim" machine for exactly thi=
s
>> purpose.
>> All target architectures have nowadays also a "none" machine, which wo=
uld
>> be a perfect match for this, too - but it currently does not allow to =
add
>> CPU, RAM or a kernel yet. Thus let's add these possibilities in a gene=
ric
>> way to the "none" machine, too, so that we hopefully do not need addit=
ional
>> "dummy" machines in the future anymore (and maybe can also get rid of =
the
>> already existing "dummy"/"sim" machines one day).
>> Note that the default behaviour of the "none" machine is not changed, =
i.e.
>> no CPU and no RAM is instantiated by default. You've explicitely got t=
o
>> specify the CPU model with "-cpu" and the amount of RAM with "-m" to g=
et
>> these new features.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> This sounds nice, but I would like initialization code used by
> "-machine none" to be generic code usable by other machines,
> whenever possible.
>=20
> The CPU and RAM creation probably is simple enough to not deserve
> a generic wrapper by now. But the kernel loader probably could be
> made reusable in the first version, so existing machines that
> already have similar logic could reuse it.
>=20
> I would love to make all machines automatically use new generic
> code to create CPUs, allocate RAM, and load a kernel. But
> probably this would be hard to do in a single step due to subtle
> initialization ordering requirements in each machine init
> function.
>=20
> More specific comments below:
>=20
>> ---
>>  hw/core/Makefile.objs  |  2 +-
>>  hw/core/null-machine.c | 81 +++++++++++++++++++++++++++++++++++++++++=
++++++++-
>>  2 files changed, 81 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
>> index a4c94e5..0b6c0f1 100644
>> --- a/hw/core/Makefile.objs
>> +++ b/hw/core/Makefile.objs
>> @@ -12,7 +12,6 @@ common-obj-$(CONFIG_XILINX_AXI) +=3D stream.o
>>  common-obj-$(CONFIG_PTIMER) +=3D ptimer.o
>>  common-obj-$(CONFIG_SOFTMMU) +=3D sysbus.o
>>  common-obj-$(CONFIG_SOFTMMU) +=3D machine.o
>> -common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
>>  common-obj-$(CONFIG_SOFTMMU) +=3D loader.o
>>  common-obj-$(CONFIG_SOFTMMU) +=3D qdev-properties-system.o
>>  common-obj-$(CONFIG_SOFTMMU) +=3D register.o
>> @@ -20,3 +19,4 @@ common-obj-$(CONFIG_SOFTMMU) +=3D or-irq.o
>>  common-obj-$(CONFIG_PLATFORM_BUS) +=3D platform-bus.o
>> =20
>>  obj-$(CONFIG_SOFTMMU) +=3D generic-loader.o
>> +obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
>=20
> I'd like to keep null-machine.o in common-obj-y, if possible. We
> already have an arch_type variable provided by arch_init.c, maybe
> it could also provide arch_endianness?

Yes, that sounds like an idea. Or maybe it's feasible to tweak
load_elf(), so it can also be called with the endianess parameter set to
"-1", meaning the caller does not care whether the endianess is big or
little?

>> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
>> index 0351ba7..b2468ed 100644
>> --- a/hw/core/null-machine.c
>> +++ b/hw/core/null-machine.c
>> @@ -13,18 +13,97 @@
>> =20
>>  #include "qemu/osdep.h"
>>  #include "qemu-common.h"
>> +#include "qemu/error-report.h"
>>  #include "hw/hw.h"
>>  #include "hw/boards.h"
>> +#include "hw/loader.h"
>> +#include "sysemu/sysemu.h"
>> +#include "exec/address-spaces.h"
>> +#include "cpu.h"
>> +#include "elf.h"
>> +
>> +#ifdef TARGET_WORDS_BIGENDIAN
>> +#define LOAD_ELF_ENDIAN_FLAG 1
>> +#else
>> +#define LOAD_ELF_ENDIAN_FLAG 0
>> +#endif
>> +
>> +static hwaddr cpu_initial_pc;
>=20
> Other architectures and machines probably have something similar
> to cpu_initial_pc, so this could be probably be moved to an
> existing generic struct. But I am not sure if this would be a
> MachineState field or CPUState field.

I'm also not sure whether this makes sense right from the start ... the
intial PC handling seems to be slightly different for each board, so
trying to generalize this variable sounds quite complicated ... so
that's maybe rather something for a later clean-up patch instead.

>> +static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
>> +{
>> +    return cpu_get_phys_page_debug(CPU(opaque), addr);
>> +}
>> +
>> +static void machine_none_load_kernel(CPUState *cpu, const char *kerne=
l_fname,
>> +                                     ram_addr_t ram_size)
>> +{
>> +    uint64_t elf_entry;
>> +    int kernel_size;
>> +
>> +    if (!ram_size) {
>> +        error_report("You need RAM for loading a kernel");
>> +        return;
>> +    }
>> +
>> +    kernel_size =3D load_elf(kernel_fname, translate_phys_addr, cpu, =
&elf_entry,
>> +                           NULL, NULL, LOAD_ELF_ENDIAN_FLAG, EM_NONqE=
, 0, 0);
>> +    cpu_initial_pc =3D elf_entry;
>> +    if (kernel_size < 0) {
>> +        kernel_size =3D load_uimage(kernel_fname, &cpu_initial_pc, NU=
LL, NULL,
>> +                                  NULL, NULL);
>> +    }
>> +    if (kernel_size < 0) {
>> +        kernel_size =3D load_image_targphys(kernel_fname, 0, ram_size=
);
>> +    }
>> +    if (kernel_size < 0) {
>> +        error_report("Could not load kernel '%s'", kernel_fname);
>> +        return;
>> +    }
>> +}
>=20
> Do you know how many different architectures will be able to use
> this generic ELF loading logic as-is?

I've only tried m68k and xtensa so far, and it worked there. OpenRISC
"or32-sim" machine looks very similar, too. Most other board look
slightly different, either lacking the "load_uimage" or
"load_image_targphys" (but the generic code might still work there), or
having some other magic code inbetween...

> Probably other machines already have very similar logic, so it
> would be nice if we could make this reusable so other machines
> don't need to duplicate it.

I can have a try...

>> +static void machine_none_cpu_reset(void *opaque)
>> +{
>> +    CPUState *cpu =3D CPU(opaque);
>> +
>> +    cpu_reset(cpu);
>> +    cpu_set_pc(cpu, cpu_initial_pc);
>> +}
>> =20
>>  static void machine_none_init(MachineState *machine)
>>  {
>> +    ram_addr_t ram_size =3D machine->ram_size;
>> +    MemoryRegion *ram;
>> +    CPUState *cpu =3D NULL;
>> +
>> +    /* Initialize CPU (if a model has been specified) */
>> +    if (machine->cpu_model) {
>> +        cpu =3D cpu_init(machine->cpu_model);
>> +        if (!cpu) {
>> +            error_report("Unable to initialize CPU");
>> +            exit(1);
>> +        }
>> +        qemu_register_reset(machine_none_cpu_reset, cpu);
>> +        cpu_reset(cpu);
>> +    }
>=20
> This looks like a sign that we need a generic wrapper to create
> CPUs. Probably lots of other machines do something very similar.
> But I think this is something for later.

I don't think that this sequence can be generalized in a wrapper
function so easily: Most other machines apparently do some additional
magic between cpu_init() and qemu_register_reset() ... so if we really
want to generalize this, this is certainly a task for a separate clean
up patch later.

>>  static void machine_none_machine_init(MachineClass *mc)
>>  {
>>      mc->desc =3D "empty machine";
>>      mc->init =3D machine_none_init;
>> -    mc->max_cpus =3D 0;
>=20
> Does this line removal has any visible effect? vl.c already
> interprets max_cpus=3D=3D0 as the same as max_cpus=3D=3D1.
>=20
> Maybe we should set max_cpus=3D1 explicitly to make it clear that
> this new code doesn't work if smp_cpus > 1.

You're right, max_cpus =3D 1 would make more sense here ... I'll change m=
y
patch accordingly.

 Thomas
