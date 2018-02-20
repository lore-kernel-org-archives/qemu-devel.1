Received: from eggs.gnu.org ([2001:4830:134:3::10]:53230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eo8ck-0000ll-Lz
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:10:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eo8ch-0000zG-Ev
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:10:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eo8ch-0000yr-7y
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:10:23 -0500
Date: Tue, 20 Feb 2018 15:10:04 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180220151004.6fb932fb@redhat.com>
In-Reply-To: <20180217063135.21550-1-haozhong.zhang@intel.com>
References: <20180217063135.21550-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/acpi-build: build SRAT memory affinity
 structures for NVDIMM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On Sat, 17 Feb 2018 14:31:35 +0800
Haozhong Zhang <haozhong.zhang@intel.com> wrote:

> ACPI 6.2A Table 5-129 "SPA Range Structure" requires the proximity
> domain of a NVDIMM SPA range must match with corresponding entry in
> SRAT table.
> 
> The address ranges of vNVDIMM in QEMU are allocated from the
> hot-pluggable address space, which is entirely covered by one SRAT
> memory affinity structure. However, users can set the vNVDIMM
> proximity domain in NFIT SPA range structure by the 'node' property of
> '-device nvdimm' to a value different than the one in the above SRAT
> memory affinity structure.
> 
> In order to solve such proximity domain mismatch, this patch build one
> SRAT memory affinity structure for each NVDIMM device with the
> proximity domain used in NFIT. The remaining hot-pluggable address
> space is covered by one or multiple SRAT memory affinity structures
> with the proximity domain of the last node as before.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
If we consider hotpluggable system, correctly implemented OS should
be able pull proximity from Device::_PXM and override any value from SRAT.
Do we really have a problem here (anything that breaks if we would use _PXM)?
Maybe we should add _PXM object to nvdimm device nodes instead of massaging SRAT?

Beside of above policy decision, patch looks good.
If we decide that it's a way to go (it shouldn't hurt,
patch just adds more code to maintain), I'd like to see
tests added to tests/numa-test.c along with it to ensure
that it works as expected.

> ---
>  hw/acpi/nvdimm.c        | 15 +++++++++++++--
>  hw/i386/acpi-build.c    | 47 +++++++++++++++++++++++++++++++++++++++++++----
>  include/hw/mem/nvdimm.h | 11 +++++++++++
>  3 files changed, 67 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 59d6e4254c..dff0818e77 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -33,12 +33,23 @@
>  #include "hw/nvram/fw_cfg.h"
>  #include "hw/mem/nvdimm.h"
>  
> +static gint nvdimm_addr_sort(gconstpointer a, gconstpointer b)
> +{
> +    uint64_t addr0 = object_property_get_uint(OBJECT(NVDIMM(a)),
> +                                              PC_DIMM_ADDR_PROP, NULL);
> +    uint64_t addr1 = object_property_get_uint(OBJECT(NVDIMM(b)),
> +                                              PC_DIMM_ADDR_PROP, NULL);
> +
> +    return addr0 < addr1 ? -1 :
> +           addr0 > addr1 ?  1 : 0;
> +}
> +
>  static int nvdimm_device_list(Object *obj, void *opaque)
>  {
>      GSList **list = opaque;
>  
>      if (object_dynamic_cast(obj, TYPE_NVDIMM)) {
> -        *list = g_slist_append(*list, DEVICE(obj));
> +        *list = g_slist_insert_sorted(*list, DEVICE(obj), nvdimm_addr_sort);
>      }
>  
>      object_child_foreach(obj, nvdimm_device_list, opaque);
> @@ -52,7 +63,7 @@ static int nvdimm_device_list(Object *obj, void *opaque)
>   * Note: it is the caller's responsibility to free the list to avoid
>   * memory leak.
>   */
> -static GSList *nvdimm_get_device_list(void)
> +GSList *nvdimm_get_device_list(void)
>  {
>      GSList *list = NULL;
>  
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index deb440f286..637ac3a8f0 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2323,6 +2323,46 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>  #define HOLE_640K_START  (640 * 1024)
>  #define HOLE_640K_END   (1024 * 1024)
>  
> +static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
> +                                           uint64_t len, int default_node)
> +{
> +    GSList *nvdimms = nvdimm_get_device_list();
> +    GSList *ent = nvdimms;
> +    NVDIMMDevice *dev;
> +    uint64_t end = base + len, addr, size;
> +    int node;
> +    AcpiSratMemoryAffinity *numamem;
> +
> +    while (base < end) {
> +        numamem = acpi_data_push(table_data, sizeof *numamem);
> +
> +        if (!ent) {
> +            build_srat_memory(numamem, base, end - base, default_node,
> +                              MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> +            break;
> +        }
> +
> +        dev = NVDIMM(ent->data);
> +        addr = object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR_PROP, NULL);
> +        size = object_property_get_uint(OBJECT(dev), PC_DIMM_SIZE_PROP, NULL);
> +        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP, NULL);
> +
> +        if (base < addr) {
> +            build_srat_memory(numamem, base, addr - base, default_node,
> +                              MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> +            numamem = acpi_data_push(table_data, sizeof *numamem);
> +        }
> +        build_srat_memory(numamem, addr, size, node,
> +                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED |
> +                          MEM_AFFINITY_NON_VOLATILE);
> +
> +        base = addr + size;
> +        ent = ent->next;
> +    }
> +
> +    g_slist_free(nvdimms);
> +}
> +
>  static void
>  build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>  {
> @@ -2434,10 +2474,9 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>       * providing _PXM method if necessary.
>       */
>      if (hotplugabble_address_space_size) {
> -        numamem = acpi_data_push(table_data, sizeof *numamem);
> -        build_srat_memory(numamem, pcms->hotplug_memory.base,
> -                          hotplugabble_address_space_size, pcms->numa_nodes - 1,
> -                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> +        build_srat_hotpluggable_memory(table_data, pcms->hotplug_memory.base,
> +                                       hotplugabble_address_space_size,
> +                                       pcms->numa_nodes - 1);
>      }
>  
>      build_header(linker, table_data,
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index 7fd87c4e1c..ca9d6aa714 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -144,4 +144,15 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
>                         uint32_t ram_slots);
>  void nvdimm_plug(AcpiNVDIMMState *state);
>  void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev);
> +
> +/*
> + * Inquire NVDIMM devices and link them into the list which is
> + * returned to the caller and sorted in the ascending order of the
> + * base address of NVDIMM devices.
> + *
> + * Note: it is the caller's responsibility to free the list to avoid
> + * memory leak.
> + */
> +GSList *nvdimm_get_device_list(void);
> +
>  #endif
