Received: from eggs.gnu.org ([2001:4830:134:3::10]:60616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fH9EI-0004rr-FM
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fH9EH-000714-8S
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:41:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fH9EG-00070q-W8
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:41:05 -0400
Date: Fri, 11 May 2018 11:40:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180511144059.GN25013@localhost.localdomain>
References: <1525854869-13975-1-git-send-email-jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525854869-13975-1-git-send-email-jingqi.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/7] hmat acpi: Build Memory Subsystem
 Address Range Structre(s) in ACPI HMAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liu Jingqi <jingqi.liu@intel.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, imammedo@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

On Wed, May 09, 2018 at 04:34:29PM +0800, Liu Jingqi wrote:
> HMAT is defined in ACPI 6.2: 5.2.27 Heterogeneous Memory Attribute Table (HMAT).
> The specification references below link:
> http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
> 
> It describes the memory attributes, such as memory side cache
> attributes and bandwidth and latency details, related to the
> System Physical Address (SPA) Memory Ranges. The software is
> expected to use this information as hint for optimization.
> 
> This structure describes the System Physical Address(SPA) range
> occupied by memory subsystem and its associativity with processor
> proximity domain as well as hint for memory usage.
> 
[...]
> +/*
> + * The Proximity Domain of System Physical Address ranges defined
> + * in the HMAT, NFIT and SRAT tables shall match each other.
> + */
> +static void hmat_build_spa(GArray *table_data, PCMachineState *pcms)
> +{
> +    GSList *device_list = NULL;
> +    AcpiHmatSpaRange *hmat_spa;
> +    uint64_t mem_base, next_base, mem_len;
> +    int node;
> +
> +    next_base = 0;
> +    for (node = 0; node < nb_numa_nodes; node++) {
> +        mem_len = numa_info[node].node_mem;
> +        if (!mem_len) {
> +            continue;
> +        }
> +
> +        mem_base = next_base;
> +        next_base = mem_base + mem_len;
> +
> +        /* Cut out the 640K hole */
> +        if (mem_base <= HOLE_640K_START &&
> +            next_base > HOLE_640K_START) {
> +            mem_len -= next_base - HOLE_640K_START;
> +            if (mem_len > 0) {
> +                hmat_spa = acpi_data_push(table_data, sizeof(*hmat_spa));
> +                hmat_build_spa_info(hmat_spa, mem_base, mem_len, node);
> +            }
> +
> +            /* Check for the rare case: 640K < RAM < 1M */
> +            if (next_base <= HOLE_640K_END) {
> +                next_base = HOLE_640K_END;
> +                continue;
> +            }
> +            mem_base = HOLE_640K_END;
> +            mem_len = next_base - HOLE_640K_END;
> +        }
> +
> +        /* Cut out the ACPI_PCI hole */
> +        if (mem_base <= pcms->below_4g_mem_size &&
> +            next_base > pcms->below_4g_mem_size) {
> +            mem_len -= next_base - pcms->below_4g_mem_size;
> +            if (mem_len > 0) {
> +                hmat_spa = acpi_data_push(table_data, sizeof(*hmat_spa));
> +                hmat_build_spa_info(hmat_spa, mem_base, mem_len, node);
> +            }
> +            mem_base = 1ULL << 32;
> +            mem_len = next_base - pcms->below_4g_mem_size;
> +            next_base = mem_base + mem_len;
> +        }

This duplicates very complex logic that already exists in
build_srat().  We need to make the existing logic reusable.


> +        hmat_spa = acpi_data_push(table_data, sizeof(*hmat_spa));
> +        hmat_build_spa_info(hmat_spa, mem_base, mem_len, node);
> +    }
> +
> +    /* Build HMAT SPA structures for PC-DIMM devices. */
> +    object_child_foreach(qdev_get_machine(), pc_dimm_device_list, &device_list);
> +
> +    for (; device_list; device_list = device_list->next) {
> +        PCDIMMDevice *dimm = device_list->data;
> +        mem_base = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
> +                                            NULL);
> +        mem_len = object_property_get_uint(OBJECT(dimm), PC_DIMM_SIZE_PROP,
> +                                           NULL);
> +        node = object_property_get_uint(OBJECT(dimm), PC_DIMM_NODE_PROP, NULL);
> +
> +        hmat_spa = acpi_data_push(table_data, sizeof(*hmat_spa));
> +        hmat_build_spa_info(hmat_spa, mem_base, mem_len, node);
> +    }
> +}

-- 
Eduardo
