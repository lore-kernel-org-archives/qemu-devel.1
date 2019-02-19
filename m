Received: from eggs.gnu.org ([209.51.188.92]:45855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gw0Up-0003Ao-6Q
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:11:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gw0Un-000201-55
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:11:19 -0500
Date: Tue, 19 Feb 2019 09:11:02 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190219091102.52fa630a@redhat.com>
In-Reply-To: <154943078167.27958.5009288263168039462.stgit@lep8c.aus.stglabs.ibm.com>
References: <154943058200.27958.11497653677605446596.stgit@lep8c.aus.stglabs.ibm.com>
	<154943078167.27958.5009288263168039462.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] spapr: Add NVDIMM device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, mst@redhat.com, bharata@linux.ibm.com, qemu-ppc@nongnu.org, vaibhav@linux.ibm.com, david@gibson.dropbear.id.au

On Tue, 05 Feb 2019 23:26:27 -0600
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> Add support for NVDIMM devices for sPAPR. Piggyback on existing nvdimm
> device interface in QEMU to support virtual NVDIMM devices for Power (May have
> to re-look at this later).  Create the required DT entries for the
> device (some entries have dummy values right now).
> 
> The patch creates the required DT node and sends a hotplug
> interrupt to the guest. Guest is expected to undertake the normal
> DR resource add path in response and start issuing PAPR SCM hcalls.
> 
> This is how it can be used ..
> Add nvdimm=on to the qemu machine argument.
> Ex : -machine pseries,nvdimm=on
> For coldplug, the device to be added in qemu command line as shown below
> -object memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0.img,share=yes,size=512m
> -device nvdimm,label-size=128k,memdev=memnvdimm0,id=nvdimm0,slot=0
> 
> For hotplug, the device to be added from monitor as below
> object_add memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0.img,share=yes,size=512m
> device_add nvdimm,label-size=128k,memdev=memnvdimm0,id=nvdimm0,slot=0
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
>                [Early implementation]
> ---
>  default-configs/ppc64-softmmu.mak |    1 
>  hw/ppc/spapr.c                    |  212 +++++++++++++++++++++++++++++++++++--
>  hw/ppc/spapr_drc.c                |   17 +++
>  hw/ppc/spapr_events.c             |    4 +
>  include/hw/ppc/spapr.h            |   10 ++
>  include/hw/ppc/spapr_drc.h        |    9 ++
>  6 files changed, 241 insertions(+), 12 deletions(-)
> 
> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
> index 7f34ad0528..b6e1aa5125 100644
> --- a/default-configs/ppc64-softmmu.mak
> +++ b/default-configs/ppc64-softmmu.mak
> @@ -20,4 +20,5 @@ CONFIG_XIVE=$(CONFIG_PSERIES)
>  CONFIG_XIVE_SPAPR=$(CONFIG_PSERIES)
>  CONFIG_MEM_DEVICE=y
>  CONFIG_DIMM=y
> +CONFIG_NVDIMM=y
>  CONFIG_SPAPR_RNG=y
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0fcdd35cbe..7e7a1a8041 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -73,6 +73,7 @@
>  #include "qemu/cutils.h"
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/mem/memory-device.h"
> +#include "hw/mem/nvdimm.h"
>  
>  #include <libfdt.h>
>  
> @@ -690,6 +691,7 @@ static int spapr_populate_drmem_v2(sPAPRMachineState *spapr, void *fdt,
>      uint8_t *int_buf, *cur_index, buf_len;
>      int ret;
>      uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
> +    uint64_t scm_block_size = SPAPR_MINIMUM_SCM_BLOCK_SIZE;
>      uint64_t addr, cur_addr, size;
>      uint32_t nr_boot_lmbs = (machine->device_memory->base / lmb_size);
>      uint64_t mem_end = machine->device_memory->base +
> @@ -726,15 +728,24 @@ static int spapr_populate_drmem_v2(sPAPRMachineState *spapr, void *fdt,
>              nr_entries++;
>          }
>  
> -        /* Entry for DIMM */
> -        drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
> -        g_assert(drc);
> -        elem = spapr_get_drconf_cell(size / lmb_size, addr,
> -                                     spapr_drc_index(drc), node,
> -                                     SPAPR_LMB_FLAGS_ASSIGNED);
> +        if (info->value->type == MEMORY_DEVICE_INFO_KIND_NVDIMM) {
> +            /* Entry for NVDIMM */
> +            drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, addr / scm_block_size);
> +            g_assert(drc);
> +            elem = spapr_get_drconf_cell(size / scm_block_size, addr,
> +                                         spapr_drc_index(drc), -1, 0);
> +            cur_addr = ROUND_UP(addr + size, scm_block_size);
> +        } else {
> +            /* Entry for DIMM */
> +            drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
> +            g_assert(drc);
> +            elem = spapr_get_drconf_cell(size / lmb_size, addr,
> +                                         spapr_drc_index(drc), node,
> +                                         SPAPR_LMB_FLAGS_ASSIGNED);
> +            cur_addr = addr + size;
> +        }
>          QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
>          nr_entries++;
> -        cur_addr = addr + size;
>      }
>  
>      /* Entry for remaining hotpluggable area */
> @@ -1225,6 +1236,42 @@ static void spapr_dt_hypervisor(sPAPRMachineState *spapr, void *fdt)
>      }
>  }
>  
> +static int spapr_populate_nvdimm_node(void *fdt, int fdt_offset,
> +                                      uint32_t node, uint64_t addr,
> +                                      uint64_t size, uint64_t label_size);
> +static void spapr_create_nvdimm(void *fdt)
> +{
> +    int offset = fdt_subnode_offset(fdt, 0, "persistent-memory");
> +    GSList *dimms = NULL;
> +
> +    if (offset < 0) {
> +        offset = fdt_add_subnode(fdt, 0, "persistent-memory");
> +        _FDT(offset);
> +        _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x2)));
> +        _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
> +        _FDT((fdt_setprop_string(fdt, offset, "name", "persistent-memory")));
> +        _FDT((fdt_setprop_string(fdt, offset, "device_type",
> +                                 "ibm,persistent-memory")));
> +    }
> +
> +    /*NB : Add drc-info array here */
> +
> +    /* Create DT entries for cold plugged NVDIMM devices */
> +    dimms = nvdimm_get_device_list();
> +    for (; dimms; dimms = dimms->next) {
> +        NVDIMMDevice *nvdimm = dimms->data;
> +        PCDIMMDevice *di = PC_DIMM(nvdimm);
> +        uint64_t lsize = nvdimm->label_size;
> +        int size = object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PROP,
> +                                           NULL);
> +
> +        spapr_populate_nvdimm_node(fdt, offset, di->node, di->addr,
> +                                   size, lsize);
> +    }
> +    g_slist_free(dimms);
> +    return;
> +}
> +
>  static void *spapr_build_fdt(sPAPRMachineState *spapr)
>  {
>      MachineState *machine = MACHINE(spapr);
> @@ -1348,6 +1395,11 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr)
>          exit(1);
>      }
>  
> +    /* NVDIMM devices */
> +    if (spapr->nvdimm_enabled) {
> +        spapr_create_nvdimm(fdt);
> +    }
> +
>      return fdt;
>  }
>  
> @@ -3143,6 +3195,20 @@ static void spapr_set_ic_mode(Object *obj, const char *value, Error **errp)
>      }
>  }
>  
> +static bool spapr_get_nvdimm(Object *obj, Error **errp)
> +{
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
> +
> +    return spapr->nvdimm_enabled;
> +}
> +
> +static void spapr_set_nvdimm(Object *obj, bool value, Error **errp)
> +{
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
> +
> +    spapr->nvdimm_enabled = value;
> +}
> +
>  static void spapr_instance_init(Object *obj)
>  {
>      sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
> @@ -3188,6 +3254,11 @@ static void spapr_instance_init(Object *obj)
>      object_property_set_description(obj, "ic-mode",
>                   "Specifies the interrupt controller mode (xics, xive, dual)",
>                   NULL);
> +    object_property_add_bool(obj, "nvdimm",
> +                            spapr_get_nvdimm, spapr_set_nvdimm, NULL);
> +    object_property_set_description(obj, "nvdimm",
> +                                    "Enable support for nvdimm devices",
> +                                    NULL);
>  }
>  
>  static void spapr_machine_finalizefn(Object *obj)
> @@ -3267,12 +3338,103 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>      }
>  }
>  
> +static int spapr_populate_nvdimm_node(void *fdt, int fdt_offset, uint32_t node,
> +                                      uint64_t addr, uint64_t size,
> +                                      uint64_t label_size)
> +{
> +    int offset;
> +    char buf[40];
> +    GString *lcode = g_string_sized_new(10);
> +    sPAPRDRConnector *drc;
> +    QemuUUID uuid;
> +    uint32_t drc_idx;
> +    uint32_t associativity[] = {
> +        cpu_to_be32(0x4), /* length */
> +        cpu_to_be32(0x0), cpu_to_be32(0x0),
> +        cpu_to_be32(0x0), cpu_to_be32(node)
> +    };
> +
> +    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM,
> +                          addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
> +    g_assert(drc);
> +
> +    drc_idx = spapr_drc_index(drc);
> +
> +    sprintf(buf, "pmem@%x", drc_idx);
> +    offset = fdt_add_subnode(fdt, fdt_offset, buf);
> +    _FDT(offset);
> +
> +    _FDT((fdt_setprop_cell(fdt, offset, "reg", drc_idx)));
> +    _FDT((fdt_setprop_string(fdt, offset, "compatible", "ibm,pmemory")));
> +    _FDT((fdt_setprop_string(fdt, offset, "name", "pmem")));
> +    _FDT((fdt_setprop_string(fdt, offset, "device_type", "ibm,pmemory")));
> +
> +    /*NB : Supposed to be random strings. Currently empty 10 strings! */
> +    _FDT((fdt_setprop(fdt, offset, "ibm,loc-code", lcode->str, lcode->len)));
> +    g_string_free(lcode, TRUE);
> +
> +    _FDT((fdt_setprop(fdt, offset, "ibm,associativity", associativity,
> +                      sizeof(associativity))));
> +    g_random_set_seed(drc_idx);
> +    qemu_uuid_generate(&uuid);
> +
> +    qemu_uuid_unparse(&uuid, buf);
> +    _FDT((fdt_setprop_string(fdt, offset, "ibm,unit-guid", buf)));
> +
> +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_idx)));
> +
> +    /*NB : What it should be? */
> +    _FDT(fdt_setprop_cell(fdt, offset, "ibm,latency-attribute", 828));
> +
> +    _FDT((fdt_setprop_u64(fdt, offset, "ibm,block-size",
> +                          SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
> +    _FDT((fdt_setprop_u64(fdt, offset, "ibm,number-of-blocks",
> +                          size / SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
> +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,metadata-size", label_size)));
> +
> +    return offset;
> +}
> +
> +static void spapr_add_nvdimm(DeviceState *dev, uint64_t addr,
> +                             uint64_t size, uint32_t node,
> +                             Error **errp)
> +{
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_hotplug_handler(dev));
> +    sPAPRDRConnector *drc;
> +    bool hotplugged = spapr_drc_hotplugged(dev);
> +    NVDIMMDevice *nvdimm = NVDIMM(OBJECT(dev));
> +    void *fdt;
> +    int fdt_offset, fdt_size;
> +    Error *local_err = NULL;
> +
> +    spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM,
> +                           addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
> +    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM,
> +                          addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
> +    g_assert(drc);
> +
> +    fdt = create_device_tree(&fdt_size);
> +    fdt_offset = spapr_populate_nvdimm_node(fdt, 0, node, addr,
> +                                            size, nvdimm->label_size);
> +
> +    spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    if (hotplugged) {
> +        spapr_hotplug_req_add_by_index(drc);
> +    }
> +}
> +
>  static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                Error **errp)
>  {
>      Error *local_err = NULL;
>      sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
>      PCDIMMDevice *dimm = PC_DIMM(dev);
> +    bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>      uint64_t size, addr;
>      uint32_t node;
>  
> @@ -3291,9 +3453,14 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  
>      node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP,
>                                      &error_abort);
> -    spapr_add_lmbs(dev, addr, size, node,
> -                   spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> -                   &local_err);
> +    if (!is_nvdimm) {
> +        spapr_add_lmbs(dev, addr, size, node,
> +                       spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> +                       &local_err);
> +    } else {
> +        spapr_add_nvdimm(dev, addr, size, node, &local_err);
> +    }
> +
>      if (local_err) {
>          goto out_unplug;
>      }
> @@ -3311,6 +3478,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  {
>      const sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(hotplug_dev);
>      sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
> +    bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>      PCDIMMDevice *dimm = PC_DIMM(dev);
>      Error *local_err = NULL;
>      uint64_t size;
> @@ -3328,10 +3496,30 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          return;
>      }
>  
> -    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
> +    if (!is_nvdimm && size % SPAPR_MEMORY_BLOCK_SIZE) {
>          error_setg(errp, "Hotplugged memory size must be a multiple of "
> -                      "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
> +                          "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
>          return;
> +    } else if (is_nvdimm) {
> +        NVDIMMDevice *nvdimm = NVDIMM(OBJECT(dev));
> +        if ((nvdimm->label_size + size) % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
> +            error_setg(errp, "NVDIMM memory size must be a multiple of "
> +                       "%" PRIu64 "MB", SPAPR_MINIMUM_SCM_BLOCK_SIZE / MiB);
> +            return;
> +        }
> +        if (((nvdimm->label_size + size) / SPAPR_MINIMUM_SCM_BLOCK_SIZE) == 1) {
> +            error_setg(errp, "NVDIMM size must be atleast "
> +                       "%" PRIu64 "MB", 2 * SPAPR_MINIMUM_SCM_BLOCK_SIZE / MiB);
> +            return;
> +        }
> +
> +        /* Align to scm block size, exclude the label */
> +        memory_device_set_region_size(MEMORY_DEVICE(nvdimm),
> +               QEMU_ALIGN_DOWN(size, SPAPR_MINIMUM_SCM_BLOCK_SIZE), &local_err);
I'm not sure that arbitrarily fixing up region size is the right thing to do
and also what you are trying to achieve here isn't clear, could you explain it some more?

> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
>      }
>  
>      memdev = object_property_get_link(OBJECT(dimm), PC_DIMM_MEMDEV_PROP,
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 2edb7d1e9c..94ddd102cc 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -696,6 +696,16 @@ static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
>      drck->release = spapr_lmb_release;
>  }
>  
> +static void spapr_drc_pmem_class_init(ObjectClass *k, void *data)
> +{
> +    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
> +
> +    drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM;
> +    drck->typename = "MEM";
> +    drck->drc_name_prefix = "PMEM ";
> +    drck->release = NULL;
> +}
> +
>  static const TypeInfo spapr_dr_connector_info = {
>      .name          = TYPE_SPAPR_DR_CONNECTOR,
>      .parent        = TYPE_DEVICE,
> @@ -739,6 +749,12 @@ static const TypeInfo spapr_drc_lmb_info = {
>      .class_init    = spapr_drc_lmb_class_init,
>  };
>  
> +static const TypeInfo spapr_drc_pmem_info = {
> +    .name          = TYPE_SPAPR_DRC_PMEM,
> +    .parent        = TYPE_SPAPR_DRC_LOGICAL,
> +    .class_init    = spapr_drc_pmem_class_init,
> +};
> +
>  /* helper functions for external users */
>  
>  sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
> @@ -1189,6 +1205,7 @@ static void spapr_drc_register_types(void)
>      type_register_static(&spapr_drc_cpu_info);
>      type_register_static(&spapr_drc_pci_info);
>      type_register_static(&spapr_drc_lmb_info);
> +    type_register_static(&spapr_drc_pmem_info);
>  
>      spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
>                          rtas_set_indicator);
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 32719a1b72..a4fed84346 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -193,6 +193,7 @@ struct rtas_event_log_v6_hp {
>  #define RTAS_LOG_V6_HP_TYPE_SLOT                         3
>  #define RTAS_LOG_V6_HP_TYPE_PHB                          4
>  #define RTAS_LOG_V6_HP_TYPE_PCI                          5
> +#define RTAS_LOG_V6_HP_TYPE_PMEM                         6
>      uint8_t hotplug_action;
>  #define RTAS_LOG_V6_HP_ACTION_ADD                        1
>  #define RTAS_LOG_V6_HP_ACTION_REMOVE                     2
> @@ -526,6 +527,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
>      case SPAPR_DR_CONNECTOR_TYPE_CPU:
>          hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_CPU;
>          break;
> +    case SPAPR_DR_CONNECTOR_TYPE_PMEM:
> +        hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_PMEM;
> +        break;
>      default:
>          /* we shouldn't be signaling hotplug events for resources
>           * that don't support them
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a947a0a0dc..21a9709afe 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -187,6 +187,7 @@ struct sPAPRMachineState {
>  
>      bool cmd_line_caps[SPAPR_CAP_NUM];
>      sPAPRCapabilities def, eff, mig;
> +    bool nvdimm_enabled;
>  };
>  
>  #define H_SUCCESS         0
> @@ -798,6 +799,15 @@ int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
>  #define SPAPR_LMB_FLAGS_DRC_INVALID 0x00000020
>  #define SPAPR_LMB_FLAGS_RESERVED 0x00000080
>  
> +/*
> + * The nvdimm size should be aligned to SCM block size.
> + * The SCM block size should be aligned to SPAPR_MEMORY_BLOCK_SIZE
> + * inorder to have SCM regions not to overlap with dimm memory regions.
> + * The SCM devices can have variable block sizes. For now, fixing the
> + * block size to the minimum value.
> + */
> +#define SPAPR_MINIMUM_SCM_BLOCK_SIZE SPAPR_MEMORY_BLOCK_SIZE
> +
>  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
>  
>  #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index f6ff32e7e2..65925d00b1 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -70,6 +70,13 @@
>  #define SPAPR_DRC_LMB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
>                                          TYPE_SPAPR_DRC_LMB)
>  
> +#define TYPE_SPAPR_DRC_PMEM "spapr-drc-pmem"
> +#define SPAPR_DRC_PMEM_GET_CLASS(obj) \
> +        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_PMEM)
> +#define SPAPR_DRC_PMEM_CLASS(klass) \
> +        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_DRC_PMEM)
> +#define SPAPR_DRC_PMEM(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
> +                                        TYPE_SPAPR_DRC_PMEM)
>  /*
>   * Various hotplug types managed by sPAPRDRConnector
>   *
> @@ -87,6 +94,7 @@ typedef enum {
>      SPAPR_DR_CONNECTOR_TYPE_SHIFT_VIO = 3,
>      SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI = 4,
>      SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB = 8,
> +    SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM = 9,
>  } sPAPRDRConnectorTypeShift;
>  
>  typedef enum {
> @@ -96,6 +104,7 @@ typedef enum {
>      SPAPR_DR_CONNECTOR_TYPE_VIO = 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_VIO,
>      SPAPR_DR_CONNECTOR_TYPE_PCI = 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI,
>      SPAPR_DR_CONNECTOR_TYPE_LMB = 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB,
> +    SPAPR_DR_CONNECTOR_TYPE_PMEM = 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM,
>  } sPAPRDRConnectorType;
>  
>  /*
> 
> 
