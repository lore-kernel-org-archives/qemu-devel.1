Received: from eggs.gnu.org ([2001:4830:134:3::10]:56061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7Ivo-0005YQ-9D
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7Ivk-000184-Rs
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:33:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7Ivk-00015U-Iw
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:33:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so1792431wru.8
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 04:33:30 -0700 (PDT)
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-16-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <35ffbd68-f783-b6f4-18a2-dd995819c046@redhat.com>
Date: Tue, 2 Oct 2018 13:33:26 +0200
MIME-Version: 1.0
In-Reply-To: <20181001115704.701-16-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/15] arm/xlnx-zynqmp: put APUs and
 RPUs in separate GDB groups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

Cc'ing more QOM involved people.

On 01/10/2018 13:57, Luc Michel wrote:
> Create two separate QOM containers for APUs and RPUs to indicate to the
> GDB stub that those CPUs should be put in different processes.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  hw/arm/xlnx-zynqmp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index c195040350..5e92adbc71 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -22,10 +22,11 @@
>  #include "hw/arm/xlnx-zynqmp.h"
>  #include "hw/intc/arm_gic_common.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/kvm.h"
>  #include "kvm_arm.h"
> +#include "exec/gdbstub.h"
>  
>  #define GIC_NUM_SPI_INTR 160
>  
>  #define ARM_PHYS_TIMER_PPI  30
>  #define ARM_VIRT_TIMER_PPI  27
> @@ -175,17 +176,18 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
>                                     Error **errp)
>  {
>      Error *err = NULL;
>      int i;
>      int num_rpus = MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQMP_NUM_RPU_CPUS);
> +    Object *rpu_group = gdb_cpu_group_container_get(OBJECT(s));

I'd rather keep this generic: not involve 'gdb' container name.

(qemu) info qom-tree
/machine (xlnx-zcu102-machine)
  /soc (xlnx,zynqmp)
    /gdb-group[0] (container)
      /apu-cpu[3] (cortex-a53-arm-cpu)
        /unnamed-gpio-in[0] (irq)
        /unnamed-gpio-in[2] (irq)
        /unnamed-gpio-in[1] (irq)
        /unnamed-gpio-in[3] (irq)
      ...
    /gdb-group[1] (container)


Maybe your create_processes() from patch [1] should enumerate all CPUs
with object_resolve_path_type("", TYPE_CPU, NULL) then sort by cpu?


[1] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00089.html

>  
>      for (i = 0; i < num_rpus; i++) {
>          char *name;
>  
>          object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
>                            "cortex-r5f-" TYPE_ARM_CPU);
> -        object_property_add_child(OBJECT(s), "rpu-cpu[*]",
> +        object_property_add_child(rpu_group, "rpu-cpu[*]",
>                                    OBJECT(&s->rpu_cpu[i]), &error_abort);
>  
>          name = object_get_canonical_path_component(OBJECT(&s->rpu_cpu[i]));
>          if (strcmp(name, boot_cpu)) {
>              /* Secondary CPUs start in PSCI powered-down state */
> @@ -210,13 +212,14 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
>  static void xlnx_zynqmp_init(Object *obj)
>  {
>      XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
>      int i;
>      int num_apus = MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
> +    Object *apu_group = gdb_cpu_group_container_get(obj);
>  
>      for (i = 0; i < num_apus; i++) {
> -        object_initialize_child(obj, "apu-cpu[*]", &s->apu_cpu[i],
> +        object_initialize_child(apu_group, "apu-cpu[*]", &s->apu_cpu[i],
>                                  sizeof(s->apu_cpu[i]),
>                                  "cortex-a53-" TYPE_ARM_CPU, &error_abort, NULL);
>      }
>  
>      sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
> 
