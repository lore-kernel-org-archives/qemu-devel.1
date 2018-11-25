Received: from eggs.gnu.org ([2001:4830:134:3::10]:49935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1fq-0001iR-NP
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 16:10:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1fm-0008GX-Lc
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 16:10:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gR1fm-0008GD-Fe
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 16:10:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so11241086wrr.0
	for <qemu-devel@nongnu.org>; Sun, 25 Nov 2018 13:10:34 -0800 (PST)
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-17-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6c666049-bb54-bf0a-1709-40f4c7903a26@redhat.com>
Date: Sun, 25 Nov 2018 22:10:30 +0100
MIME-Version: 1.0
In-Reply-To: <20181123091729.29921-17-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 16/16] arm/xlnx-zynqmp: put APUs and
 RPUs in separate CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

On 23/11/18 10:17, Luc Michel wrote:
> Create two separate CPU clusters for APUs and RPUs.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  include/hw/arm/xlnx-zynqmp.h |  3 +++
>  hw/arm/xlnx-zynqmp.c         | 21 +++++++++++++++++----
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index 98f925ab84..591515c760 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -29,10 +29,11 @@
>  #include "hw/dma/xlnx_dpdma.h"
>  #include "hw/dma/xlnx-zdma.h"
>  #include "hw/display/xlnx_dp.h"
>  #include "hw/intc/xlnx-zynqmp-ipi.h"
>  #include "hw/timer/xlnx-zynqmp-rtc.h"
> +#include "hw/cpu/cluster.h"
>  
>  #define TYPE_XLNX_ZYNQMP "xlnx,zynqmp"
>  #define XLNX_ZYNQMP(obj) OBJECT_CHECK(XlnxZynqMPState, (obj), \
>                                         TYPE_XLNX_ZYNQMP)
>  
> @@ -75,10 +76,12 @@
>  typedef struct XlnxZynqMPState {
>      /*< private >*/
>      DeviceState parent_obj;
>  
>      /*< public >*/
> +    CPUClusterState apu_cluster;
> +    CPUClusterState rpu_cluster;
>      ARMCPU apu_cpu[XLNX_ZYNQMP_NUM_APU_CPUS];
>      ARMCPU rpu_cpu[XLNX_ZYNQMP_NUM_RPU_CPUS];
>      GICState gic;
>      MemoryRegion gic_mr[XLNX_ZYNQMP_GIC_REGIONS][XLNX_ZYNQMP_GIC_ALIASES];
>  
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index c195040350..42a138074c 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -176,16 +176,22 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
>  {
>      Error *err = NULL;
>      int i;
>      int num_rpus = MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQMP_NUM_RPU_CPUS);
>  
> +    object_initialize_child(OBJECT(s), "rpu-cluster", &s->rpu_cluster,
> +                            sizeof(s->rpu_cluster), TYPE_CPU_CLUSTER,
> +                            &error_abort, NULL);
> +
> +    qdev_init_nofail(DEVICE(&s->rpu_cluster));
> +
>      for (i = 0; i < num_rpus; i++) {
>          char *name;
>  
>          object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
>                            "cortex-r5f-" TYPE_ARM_CPU);
> -        object_property_add_child(OBJECT(s), "rpu-cpu[*]",
> +        object_property_add_child(OBJECT(&s->rpu_cluster), "rpu-cpu[*]",
>                                    OBJECT(&s->rpu_cpu[i]), &error_abort);
>  
>          name = object_get_canonical_path_component(OBJECT(&s->rpu_cpu[i]));
>          if (strcmp(name, boot_cpu)) {
>              /* Secondary CPUs start in PSCI powered-down state */
> @@ -211,14 +217,19 @@ static void xlnx_zynqmp_init(Object *obj)
>  {
>      XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
>      int i;
>      int num_apus = MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
>  
> +    object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
> +                            sizeof(s->apu_cluster), TYPE_CPU_CLUSTER,
> +                            &error_abort, NULL);

This is now very clean :) Thanks for the various efforts/versions
improving this series.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>      for (i = 0; i < num_apus; i++) {
> -        object_initialize_child(obj, "apu-cpu[*]", &s->apu_cpu[i],
> -                                sizeof(s->apu_cpu[i]),
> -                                "cortex-a53-" TYPE_ARM_CPU, &error_abort, NULL);
> +        object_initialize_child(OBJECT(&s->apu_cluster), "apu-cpu[*]",
> +                                &s->apu_cpu[i], sizeof(s->apu_cpu[i]),
> +                                "cortex-a53-" TYPE_ARM_CPU, &error_abort,
> +                                NULL);
>      }
>  
>      sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
>                            gic_class_name());
>  
> @@ -331,10 +342,12 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>      qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", num_apus);
>      qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", s->secure);
>      qdev_prop_set_bit(DEVICE(&s->gic),
>                        "has-virtualization-extensions", s->virt);
>  
> +    qdev_init_nofail(DEVICE(&s->apu_cluster));
> +
>      /* Realize APUs before realizing the GIC. KVM requires this.  */
>      for (i = 0; i < num_apus; i++) {
>          char *name;
>  
>          object_property_set_int(OBJECT(&s->apu_cpu[i]), QEMU_PSCI_CONDUIT_SMC,
> 
