Received: from eggs.gnu.org ([2001:4830:134:3::10]:38803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fuFQ8-0005H8-2j
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fuFQ3-0002ID-Sr
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:10:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59306 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fuFQ3-0002HH-JN
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:10:51 -0400
References: <1535368030-214556-1-git-send-email-imammedo@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8f03d00a-e9ae-3ada-ef20-35cd2a000795@redhat.com>
Date: Mon, 27 Aug 2018 13:10:47 +0200
MIME-Version: 1.0
In-Reply-To: <1535368030-214556-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc: make sure that guest isn't able to
 unplug the first cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au, groug@kaod.org, cohuck@redhat.com

On 27.08.2018 13:07, Igor Mammedov wrote:
> The first cpu unplug wasn't ever supported and corresponding
> monitor/qmp commands refuse to unplug it. However guest is able
> to issue eject request either using following command:
>   # echo 1 >/sys/devices/system/cpu/cpu0/firmware_node/eject
> or directly writing to cpu hotplug registers, which makes
> qemu crash with SIGSEGV following back trace:
> 
>    kvm_flush_coalesced_mmio_buffer ()
>        while (ring->first != ring->last)
>    ...
>    qemu_flush_coalesced_mmio_buffer
>    prepare_mmio_access
>    flatview_read_continue
>    flatview_read
>    address_space_read_full
>    address_space_rw
>    kvm_cpu_exec(cpu!0)
>    qemu_kvm_cpu_thread_fn
> 
> the reason for which is that ring == KVMState::coalesced_mmio_ring
> happens to be a part of 1st CPU that was uplugged by guest.
> 
> Fix it by forbidding 1st cpu unplug from guest side and in addition
> remove CPU0._EJ0 ACPI method to make clear that unplug of the first
> CPU is not supported.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CCing spapr and s390x folks in case targets need to prevent 1st CPU unplug as well

No unplug on s390x, so we're fine.

> 
> CC: mst@redhat.com
> CC: pbonzini@redhat.com
> CC: david@gibson.dropbear.id.au
> CC: groug@kaod.org
> CC: david@redhat.com
> CC: cohuck@redhat.com
> ---
>  hw/acpi/cpu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 5ae595e..4bb8371 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -117,7 +117,7 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
>              DeviceState *dev = NULL;
>              HotplugHandler *hotplug_ctrl = NULL;
>  
> -            if (!cdev->cpu) {
> +            if (!cdev->cpu || cdev->cpu == first_cpu) {
>                  trace_cpuhp_acpi_ejecting_invalid_cpu(cpu_st->selector);
>                  break;
>              }
> @@ -541,9 +541,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>                  aml_buffer(madt_buf->len, (uint8_t *)madt_buf->data)));
>              g_array_free(madt_buf, true);
>  
> -            method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> -            aml_append(method, aml_call1(CPU_EJECT_METHOD, uid));
> -            aml_append(dev, method);
> +            if (CPU(arch_ids->cpus[i].cpu) != first_cpu) {
> +                method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> +                aml_append(method, aml_call1(CPU_EJECT_METHOD, uid));
> +                aml_append(dev, method);
> +            }
>  
>              method = aml_method("_OST", 3, AML_SERIALIZED);
>              aml_append(method,
> 


-- 

Thanks,

David / dhildenb
