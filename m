Received: from eggs.gnu.org ([2001:4830:134:3::10]:57677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cHX5Q-0001Uk-4w
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cHX5P-0000Kz-3W
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:32:44 -0500
Date: Thu, 15 Dec 2016 15:32:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161215153233.301e713a@nial.brq.redhat.com>
In-Reply-To: <20161213214522.25548-7-drjones@redhat.com>
References: <20161213214522.25548-1-drjones@redhat.com>
	<20161213214522.25548-7-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/11] hw/arm/virt: move
 VirtMachineState/Class to virt.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, zhaoshenglong@huawei.com, mst@redhat.com, ehabkost@redhat.com

On Tue, 13 Dec 2016 22:45:17 +0100
Andrew Jones <drjones@redhat.com> wrote:

> In preparation to share more Virt machine state than just guest-info
> with other mach-virt source files, move the State and Class structures
> to virt.h
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
[...]
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index c2c1f6837442..77d25dbddb62 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -33,6 +33,8 @@
>  #include "qemu-common.h"
>  #include "exec/hwaddr.h"
>  #include "qemu/notify.h"
> +#include "hw/boards.h"
nit:
one won't need this header be included directly in virt.c anymore

> +#include "hw/arm/arm.h"
>  
>  #define NUM_GICV2M_SPIS       64
>  #define NUM_VIRTIO_TRANSPORTS 32
> @@ -89,6 +91,43 @@ typedef struct VirtGuestInfo {
>      bool no_its;
>  } VirtGuestInfo;
>  
> +typedef struct {
> +    MachineClass parent;
> +    bool disallow_affinity_adjustment;
> +    bool no_its;
> +    bool no_pmu;
> +    bool claim_edge_triggered_timers;
> +} VirtMachineClass;
> +
> +typedef struct {
> +    MachineState parent;
> +    VirtGuestInfo acpi_guest_info;
> +    Notifier machine_done;
> +    bool secure;
> +    bool highmem;
> +    bool virt;
> +    int32_t gic_version;
> +    struct arm_boot_info bootinfo;
> +    const MemMapEntry *memmap;
> +    const int *irqmap;
> +    int smp_cpus;
> +    void *fdt;
> +    int fdt_size;
> +    uint32_t clock_phandle;
> +    uint32_t gic_phandle;
> +    uint32_t msi_phandle;
> +    int psci_conduit;
> +} VirtMachineState;
> +
> +#define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
> +#define VIRT_MACHINE(obj) \
> +    OBJECT_CHECK(VirtMachineState, (obj), TYPE_VIRT_MACHINE)
> +#define VIRT_MACHINE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(VirtMachineClass, obj, TYPE_VIRT_MACHINE)
> +#define VIRT_MACHINE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(VirtMachineClass, klass, TYPE_VIRT_MACHINE)
> +
> +
>  void virt_acpi_setup(VirtGuestInfo *guest_info);
>  
>  #endif /* QEMU_ARM_VIRT_H */
