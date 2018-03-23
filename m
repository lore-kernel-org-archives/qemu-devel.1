Received: from eggs.gnu.org ([2001:4830:134:3::10]:48401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ezHRD-00005L-2L
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 03:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ezHRC-00035j-0W
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 03:48:35 -0400
Date: Fri, 23 Mar 2018 08:48:08 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180323074808.eyxeqaqyuz5sm743@hawk.localdomain>
References: <20180322212318.7182-1-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322212318.7182-1-wei@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2 1/1] mach-virt: Set VM's SMBIOS system
 version to mc->name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org

On Thu, Mar 22, 2018 at 04:23:18PM -0500, Wei Huang wrote:
> Instead of using "1.0" as the system version of SMBIOS, we should use
> mc->name for mach-virt machine type to be consistent other architectures.
> With this patch, "dmidecode -t 1" (e.g., "-M virt-2.12,accel=kvm") will
> show:
> 
>     Handle 0x0100, DMI type 1, 27 bytes
>     System Information
>             Manufacturer: QEMU
>             Product Name: KVM Virtual Machine
>             Version: virt-2.12
>             Serial Number: Not Specified
>             ...
> 
> instead of:
> 
>     Handle 0x0100, DMI type 1, 27 bytes
>     System Information
>             Manufacturer: QEMU
>             Product Name: KVM Virtual Machine
>             Version: 1.0
>             Serial Number: Not Specified
>             ...
> 
> For backward compatibility, we allow older machine types to keep "1.0"
> as the default system version.
> 
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  hw/arm/virt.c         | 8 +++++++-
>  include/hw/arm/virt.h | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 2c07245047..94dcb125d3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1132,6 +1132,8 @@ static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
>  
>  static void virt_build_smbios(VirtMachineState *vms)
>  {
> +    MachineClass *mc = MACHINE_GET_CLASS(vms);
> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>      uint8_t *smbios_tables, *smbios_anchor;
>      size_t smbios_tables_len, smbios_anchor_len;
>      const char *product = "QEMU Virtual Machine";
> @@ -1145,7 +1147,8 @@ static void virt_build_smbios(VirtMachineState *vms)
>      }
>  
>      smbios_set_defaults("QEMU", product,
> -                        "1.0", false, true, SMBIOS_ENTRY_POINT_30);
> +                        vmc->smbios_old_sys_ver ? "1.0" : mc->name, false,
> +                        true, SMBIOS_ENTRY_POINT_30);
>  
>      smbios_get_tables(NULL, 0, &smbios_tables, &smbios_tables_len,
>                        &smbios_anchor, &smbios_anchor_len);
> @@ -1646,8 +1649,11 @@ static void virt_2_11_instance_init(Object *obj)
>  
>  static void virt_machine_2_11_options(MachineClass *mc)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>      virt_machine_2_12_options(mc);
>      SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_11);
> +    vmc->smbios_old_sys_ver = true;
>  }
>  DEFINE_VIRT_MACHINE(2, 11)
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 33b0ff3892..ba0c1a4faa 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -85,6 +85,7 @@ typedef struct {
>      bool no_its;
>      bool no_pmu;
>      bool claim_edge_triggered_timers;
> +    bool smbios_old_sys_ver;
>  } VirtMachineClass;
>  
>  typedef struct {
> -- 
> 2.14.3
> 
>

I don't think we need the compat code in this case. I used to pedantically
recommend compat code for all guest visible changes, but after speaking
with Igor about the policy for introducing compat code for ACPI table
updates, I learned that we can relax a bit on a case by case basis. In
this case I would recommend relaxing, but I won't insist, as the compat
code is indeed the safest way to go.

Reviewed-by: Andrew Jones <drjones@redhat.com>
