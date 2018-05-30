Received: from eggs.gnu.org ([2001:4830:134:3::10]:33145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fO3oH-00071K-RB
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fO3oG-0008I1-Na
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:18:49 -0400
References: <1527690380-9782-1-git-send-email-eric.auger@redhat.com>
	<1527690380-9782-3-git-send-email-eric.auger@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <273bb69a-a463-7fbe-edb0-a87622556afb@redhat.com>
Date: Wed, 30 May 2018 18:18:34 +0200
MIME-Version: 1.0
In-Reply-To: <1527690380-9782-3-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/virt: Add virt-3.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, zhaoshenglong@huawei.com, ard.biesheuvel@linaro.org

On 05/30/18 16:26, Eric Auger wrote:
> Add virt-3.0 machine type.
> 
> This machine type supports highmem 256MB ECAM by default.
> This feature is disabled for earlier machine types and
> if highmem is off.
> 
> The high 256MB ECAM region is chosen instead of the legacy
> 16MB one if the machine type allows it, if highmem is set
> (LPAE supported by the guest) and (!firmware_loaded || aarch64).
> Indeed aarch32 mode FW may not support this high ECAM region.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> RFC -> v1
> - check firmware_loaded and aarch64 value
> - do all the computation in machvirt_init
> ---
>  hw/arm/virt.c         | 31 ++++++++++++++++++++++++++++---
>  include/hw/arm/virt.h |  1 +
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index d4247d0..83c2b5a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1275,6 +1275,7 @@ static void machvirt_init(MachineState *machine)
>      int n, virt_max_cpus;
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>      bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
> +    bool aarch64 = true;
>  
>      /* We can probe only here because during property set
>       * KVM is not available yet
> @@ -1389,6 +1390,8 @@ static void machvirt_init(MachineState *machine)
>          numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
>                            &error_fatal);
>  
> +        aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
> +
>          if (!vms->secure) {
>              object_property_set_bool(cpuobj, false, "has_el3", NULL);
>          }
> @@ -1447,6 +1450,8 @@ static void machvirt_init(MachineState *machine)
>          create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
>      }
>  
> +    vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
> +
>      create_rtc(vms, pic);
>  
>      create_pcie(vms, pic);
> @@ -1697,7 +1702,7 @@ static void machvirt_machine_init(void)
>  }
>  type_init(machvirt_machine_init);
>  
> -static void virt_2_12_instance_init(Object *obj)
> +static void virt_3_0_instance_init(Object *obj)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(obj);
>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> @@ -1740,6 +1745,8 @@ static void virt_2_12_instance_init(Object *obj)
>                                      "Set GIC version. "
>                                      "Valid values are 2, 3 and host", NULL);
>  
> +    vms->highmem_ecam = vmc->no_highmem_ecam ? false : true;
> +

I think this should be written as:

    vms->highmem_ecam = !vmc->no_highmem_ecam;

With that change:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Obviously the series has to be reviewed by others as well.

Thanks!
Laszlo


>      if (vmc->no_its) {
>          vms->its = false;
>      } else {
> @@ -1765,10 +1772,28 @@ static void virt_2_12_instance_init(Object *obj)
>      vms->irqmap = a15irqmap;
>  }
>  
> -static void virt_machine_2_12_options(MachineClass *mc)
> +static void virt_machine_3_0_options(MachineClass *mc)
>  {
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(2, 12)
> +DEFINE_VIRT_MACHINE_AS_LATEST(3, 0)
> +
> +#define VIRT_COMPAT_2_12 \
> +    HW_COMPAT_2_12
> +
> +static void virt_2_12_instance_init(Object *obj)
> +{
> +    virt_3_0_instance_init(obj);
> +}
> +
> +static void virt_machine_2_12_options(MachineClass *mc)
> +{
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
> +    virt_machine_3_0_options(mc);
> +    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_12);
> +    vmc->no_highmem_ecam = true;
> +}
> +DEFINE_VIRT_MACHINE(2, 12)
>  
>  #define VIRT_COMPAT_2_11 \
>      HW_COMPAT_2_11
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index e9423a7..10a5c71 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -95,6 +95,7 @@ typedef struct {
>      bool no_pmu;
>      bool claim_edge_triggered_timers;
>      bool smbios_old_sys_ver;
> +    bool no_highmem_ecam;
>  } VirtMachineClass;
>  
>  typedef struct {
> 
