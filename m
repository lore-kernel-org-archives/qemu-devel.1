Received: from eggs.gnu.org ([209.51.188.92]:47692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzOQI-0007Sp-SE
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzOQ8-0003kY-UB
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:20:32 -0500
Date: Thu, 28 Feb 2019 17:19:42 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190228171942.28f2f953@redhat.com>
In-Reply-To: <20190228150324.25973-9-eric.auger@redhat.com>
References: <20190228150324.25973-1-eric.auger@redhat.com>
	<20190228150324.25973-9-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 08/10] hw/arm/virt: Implement kvm_type
 function for 4.0 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com, pbonzini@redhat.com

On Thu, 28 Feb 2019 16:03:22 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> This patch implements the machine class kvm_type() callback.
> It returns the number of bits requested to implement the whole GPA
> range including the RAM and IO regions located beyond.
> The returned value in passed though the KVM_CREATE_VM ioctl and
> this allows KVM to set the stage2 tables dynamically.
> 
> To compute the highest GPA used in the memory map, kvm_type()
> must freeze the memory map by calling virt_set_memmap().
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v7 -> v8:
> - remove vmc->no_extended_memmap and vms->extended_memmap
> 
> v6 -> v7:
> - Introduce RAMBASE and rename add LEGACY_ prefix in that patch
> - use local variables with explicit names in virt_set_memmap:
>   device_memory_base, device_memory_size
> - add an extended_memmap field in the class
> 
> v5 -> v6:
> - add some comments
> - high IO region cannot start before 256GiB
> ---
>  hw/arm/virt.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index d7aa7d3f9d..7a158571b7 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1439,7 +1439,13 @@ static void machvirt_init(MachineState *machine)
>      bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
>      bool aarch64 = true;
>  
> -    virt_set_memmap(vms);
> +    /*
> +     * In accelerated mode, the memory map is computed in kvm_type()
s/in/earlier in/

> +     * to create a VM with the right number of IPA bits.
> +     */
> +    if (!kvm_enabled()) {
maybe check not for KVM but for vms->memmap == NULL
so it would match with comment and be clear that we initializing memmap
because nobody else did it yet.

> +        virt_set_memmap(vms);
> +    }
>  
>      /* We can probe only here because during property set
>       * KVM is not available yet
> @@ -1828,6 +1834,36 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>      return NULL;
>  }
>  
> +/*
> + * for arm64 kvm_type [7-0] encodes the requested number of bits
> + * in the IPA address space
> + */
> +static int virt_kvm_type(MachineState *ms, const char *type_str)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(ms);
> +    int max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms);
> +    int requested_pa_size;
> +
> +    /* we freeze the memory map to compute the highest gpa */
> +    virt_set_memmap(vms);
> +

> +    requested_pa_size = 64 - clz64(vms->highest_gpa);
> +
> +    if (requested_pa_size > max_vm_pa_size) {
> +        error_report("-m and ,maxmem option values "
> +                     "require an IPA range (%d bits) larger than "
> +                     "the one supported by the host (%d bits)",
> +                     requested_pa_size, max_vm_pa_size);
> +       exit(1);
> +    }
this part is recurring pattern, is it worth using a helper function?

> +    /*
> +     * By default we return 0 which corresponds to an implicit legacy
> +     * 40b IPA setting. Otherwise we return the actual requested PA
> +     * logsize
> +     */
> +    return requested_pa_size > 40 ? requested_pa_size : 0;
> +}
> +
>  static void virt_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1852,6 +1888,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
>      mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
>      mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
> +    mc->kvm_type = virt_kvm_type;
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>      hc->plug = virt_machine_device_plug_cb;
