Received: from eggs.gnu.org ([2001:4830:134:3::10]:57995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fHCs2-0002DC-0V
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fHCry-0007Vz-Tt
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:34:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fHCry-0007Vf-LT
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:34:18 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4BISsP0026554
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 14:34:17 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hwfcfjsm0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 14:34:17 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Fri, 11 May 2018 14:34:15 -0400
Date: Fri, 11 May 2018 15:34:05 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20180511131953.12905-1-david@redhat.com>
	<20180511131953.12905-17-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511131953.12905-17-david@redhat.com>
Message-Id: <20180511183405.GA19020@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [PATCH v2 16/17] s390x: initialize memory region
 for memory devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Fri, May 11, 2018 at 03:19:52PM +0200, David Hildenbrand wrote:
> While s390x has no real interface for communicating devices mapped into
> the physical address space of the guest, paravirtualized devices can
> easily expose the applicable address range themselves.
> 
> So let's use the difference between maxram_size and ram_size as the size
> for our hotplug memory area (just as on other architectures).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index ee0a2b124f..09b755282b 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -157,9 +157,11 @@ static void virtio_ccw_register_hcalls(void)
>  #define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
>  #define SEG_MSK (~0xfffffULL)
>  #define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)
> -static void s390_memory_init(ram_addr_t mem_size)
> +static void s390_memory_init(MachineState *machine)
>  {
> +    S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
>      MemoryRegion *sysmem = get_system_memory();
> +    ram_addr_t mem_size = machine->ram_size;
>      ram_addr_t chunk, offset = 0;
>      unsigned int number = 0;
>      gchar *name;
> @@ -181,6 +183,28 @@ static void s390_memory_init(ram_addr_t mem_size)
>      }
>      g_free(name);
>  
> +    /* always allocate the device memory information */
> +    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));

Is there any QEMU guideline/preference/recommendation in using g_new0
vs. g_malloc0?

I recall Paolo suggesting g_new0 instead of g_malloc0 in another patch:

  http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg02372.html

> +
> +    /* initialize device memory address space */
> +    if (machine->ram_size < machine->maxram_size) {
> +        ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
> +
> +        if (QEMU_ALIGN_UP(machine->maxram_size, TARGET_PAGE_SIZE) !=
> +            machine->maxram_size) {
> +            error_report("maximum memory size must be aligned to multiple of "
> +                         "%d bytes", TARGET_PAGE_SIZE);
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        machine->device_memory->base = machine->ram_size;
> +        memory_region_init(&machine->device_memory->mr, OBJECT(ms),
> +                           "device-memory", device_mem_size);
> +        memory_region_add_subregion(sysmem, machine->device_memory->base,
> +                                    &machine->device_memory->mr);
> +
> +    }
> +
>      /* Initialize storage key device */
>      s390_skeys_init();
>      /* Initialize storage attributes device */
> @@ -304,7 +328,7 @@ static void ccw_init(MachineState *machine)
>      DeviceState *dev;
>  
>      s390_sclp_init();
> -    s390_memory_init(machine->ram_size);
> +    s390_memory_init(machine);
>  
>      /* init CPUs (incl. CPU model) early so s390_has_feature() works */
>      s390_init_cpus(machine);
> -- 
> 2.14.3
> 
> 

-- 
Murilo
