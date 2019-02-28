Received: from eggs.gnu.org ([209.51.188.92]:37717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1gzHTR-0000qy-Rj
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1gzHTO-0004bM-2L
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:55:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1gzHTL-0004Ei-9W
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:55:19 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1S8nnv9023290
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:54:17 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qxcb2gk0r-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:54:17 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
	Thu, 28 Feb 2019 08:54:14 -0000
References: <154943058200.27958.11497653677605446596.stgit@lep8c.aus.stglabs.ibm.com>
	<154943078167.27958.5009288263168039462.stgit@lep8c.aus.stglabs.ibm.com>
	<20190219091102.52fa630a@redhat.com>
	<4c8d6511-dc77-24f3-71a7-cafc54a80b44@linux.ibm.com>
	<20190221151240.68a96192@redhat.com>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Thu, 28 Feb 2019 14:24:07 +0530
MIME-Version: 1.0
In-Reply-To: <20190221151240.68a96192@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <493bad73-70e0-f352-b5aa-6cb2120677f7@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] spapr: Add NVDIMM device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, mst@redhat.com, bharata@linux.ibm.com, qemu-ppc@nongnu.org, vaibhav@linux.ibm.com, david@gibson.dropbear.id.au

Hi Igor,

Thanks for the elaboration. Please find my response inline.


On 02/21/2019 07:42 PM, Igor Mammedov wrote:
> On Tue, 19 Feb 2019 14:59:25 +0530
> Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
>
>> On 02/19/2019 01:41 PM, Igor Mammedov wrote:
>>> On Tue, 05 Feb 2019 23:26:27 -0600
>>> Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
>>>  =20
>>>> Add support for NVDIMM devices for sPAPR. Piggyback on existing nvdi=
mm
>>>> device interface in QEMU to support virtual NVDIMM devices for Power=
 (May have
>>>> to re-look at this later).  Create the required DT entries for the
>>>> device (some entries have dummy values right now).
>>>>
>>>> The patch creates the required DT node and sends a hotplug
>>>> interrupt to the guest. Guest is expected to undertake the normal
>>>> DR resource add path in response and start issuing PAPR SCM hcalls.
>>>>
>>>> This is how it can be used ..
>>>> Add nvdimm=3Don to the qemu machine argument.
>>>> Ex : -machine pseries,nvdimm=3Don
>>>> For coldplug, the device to be added in qemu command line as shown b=
elow
>>>> -object memory-backend-file,id=3Dmemnvdimm0,prealloc=3Dyes,mem-path=3D=
/tmp/nvdimm0.img,share=3Dyes,size=3D512m
>>>> -device nvdimm,label-size=3D128k,memdev=3Dmemnvdimm0,id=3Dnvdimm0,sl=
ot=3D0
>>>>
>>>> For hotplug, the device to be added from monitor as below
>>>> object_add memory-backend-file,id=3Dmemnvdimm0,prealloc=3Dyes,mem-pa=
th=3D/tmp/nvdimm0.img,share=3Dyes,size=3D512m
>>>> device_add nvdimm,label-size=3D128k,memdev=3Dmemnvdimm0,id=3Dnvdimm0=
,slot=3D0
>>>>
>>>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>>>> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
>>>>                  [Early implementation]
>>>> ---
>>>>    default-configs/ppc64-softmmu.mak |    1
>>>>    hw/ppc/spapr.c                    |  212 ++++++++++++++++++++++++=
+++++++++++--
>>>>    hw/ppc/spapr_drc.c                |   17 +++
>>>>    hw/ppc/spapr_events.c             |    4 +
>>>>    include/hw/ppc/spapr.h            |   10 ++
>>>>    include/hw/ppc/spapr_drc.h        |    9 ++
>>>>    6 files changed, 241 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc=
64-softmmu.mak
>>>> index 7f34ad0528..b6e1aa5125 100644
>>>> --- a/default-configs/ppc64-softmmu.mak
>>>> +++ b/default-configs/ppc64-softmmu.mak
>>>> @@ -20,4 +20,5 @@ CONFIG_XIVE=3D$(CONFIG_PSERIES)
>>>>    CONFIG_XIVE_SPAPR=3D$(CONFIG_PSERIES)
>>>>    CONFIG_MEM_DEVICE=3Dy
>>>>    CONFIG_DIMM=3Dy
>>>> +CONFIG_NVDIMM=3Dy
>>>>    CONFIG_SPAPR_RNG=3Dy
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 0fcdd35cbe..7e7a1a8041 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -73,6 +73,7 @@
>>>>    #include "qemu/cutils.h"
>>>>    #include "hw/ppc/spapr_cpu_core.h"
>>>>    #include "hw/mem/memory-device.h"
>>>> +#include "hw/mem/nvdimm.h"
>>>>   =20
>>>>    #include <libfdt.h>
>>>>   =20
>>>> @@ -690,6 +691,7 @@ static int spapr_populate_drmem_v2(sPAPRMachineS=
tate *spapr, void *fdt,
>>>>        uint8_t *int_buf, *cur_index, buf_len;
>>>>        int ret;
>>>>        uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
>>>> +    uint64_t scm_block_size =3D SPAPR_MINIMUM_SCM_BLOCK_SIZE;
>>>>        uint64_t addr, cur_addr, size;
>>>>        uint32_t nr_boot_lmbs =3D (machine->device_memory->base / lmb=
_size);
>>>>        uint64_t mem_end =3D machine->device_memory->base +
>>>> @@ -726,15 +728,24 @@ static int spapr_populate_drmem_v2(sPAPRMachin=
eState *spapr, void *fdt,
>>>>                nr_entries++;
>>>>            }
>>>>   =20
>>>> -        /* Entry for DIMM */
>>>> -        drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size=
);
>>>> -        g_assert(drc);
>>>> -        elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
>>>> -                                     spapr_drc_index(drc), node,
>>>> -                                     SPAPR_LMB_FLAGS_ASSIGNED);
>>>> +        if (info->value->type =3D=3D MEMORY_DEVICE_INFO_KIND_NVDIMM=
) {
>>>> +            /* Entry for NVDIMM */
>>>> +            drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, addr / scm=
_block_size);
>>>> +            g_assert(drc);
>>>> +            elem =3D spapr_get_drconf_cell(size / scm_block_size, a=
ddr,
>>>> +                                         spapr_drc_index(drc), -1, =
0);
>>>> +            cur_addr =3D ROUND_UP(addr + size, scm_block_size);
>>>> +        } else {
>>>> +            /* Entry for DIMM */
>>>> +            drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_=
size);
>>>> +            g_assert(drc);
>>>> +            elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
>>>> +                                         spapr_drc_index(drc), node=
,
>>>> +                                         SPAPR_LMB_FLAGS_ASSIGNED);
>>>> +            cur_addr =3D addr + size;
>>>> +        }
>>>>            QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
>>>>            nr_entries++;
>>>> -        cur_addr =3D addr + size;
>>>>        }
>>>>   =20
>>>>        /* Entry for remaining hotpluggable area */
>>>> @@ -1225,6 +1236,42 @@ static void spapr_dt_hypervisor(sPAPRMachineS=
tate *spapr, void *fdt)
>>>>        }
>>>>    }
>>>>   =20
>>>> +static int spapr_populate_nvdimm_node(void *fdt, int fdt_offset,
>>>> +                                      uint32_t node, uint64_t addr,
>>>> +                                      uint64_t size, uint64_t label=
_size);
>>>> +static void spapr_create_nvdimm(void *fdt)
>>>> +{
>>>> +    int offset =3D fdt_subnode_offset(fdt, 0, "persistent-memory");
>>>> +    GSList *dimms =3D NULL;
>>>> +
>>>> +    if (offset < 0) {
>>>> +        offset =3D fdt_add_subnode(fdt, 0, "persistent-memory");
>>>> +        _FDT(offset);
>>>> +        _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x2))=
);
>>>> +        _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
>>>> +        _FDT((fdt_setprop_string(fdt, offset, "name", "persistent-m=
emory")));
>>>> +        _FDT((fdt_setprop_string(fdt, offset, "device_type",
>>>> +                                 "ibm,persistent-memory")));
>>>> +    }
>>>> +
>>>> +    /*NB : Add drc-info array here */
>>>> +
>>>> +    /* Create DT entries for cold plugged NVDIMM devices */
>>>> +    dimms =3D nvdimm_get_device_list();
>>>> +    for (; dimms; dimms =3D dimms->next) {
>>>> +        NVDIMMDevice *nvdimm =3D dimms->data;
>>>> +        PCDIMMDevice *di =3D PC_DIMM(nvdimm);
>>>> +        uint64_t lsize =3D nvdimm->label_size;
>>>> +        int size =3D object_property_get_int(OBJECT(nvdimm), PC_DIM=
M_SIZE_PROP,
>>>> +                                           NULL);
>>>> +
>>>> +        spapr_populate_nvdimm_node(fdt, offset, di->node, di->addr,
>>>> +                                   size, lsize);
>>>> +    }
>>>> +    g_slist_free(dimms);
>>>> +    return;
>>>> +}
>>>> +
>>>>    static void *spapr_build_fdt(sPAPRMachineState *spapr)
>>>>    {
>>>>        MachineState *machine =3D MACHINE(spapr);
>>>> @@ -1348,6 +1395,11 @@ static void *spapr_build_fdt(sPAPRMachineStat=
e *spapr)
>>>>            exit(1);
>>>>        }
>>>>   =20
>>>> +    /* NVDIMM devices */
>>>> +    if (spapr->nvdimm_enabled) {
>>>> +        spapr_create_nvdimm(fdt);
>>>> +    }
>>>> +
>>>>        return fdt;
>>>>    }
>>>>   =20
>>>> @@ -3143,6 +3195,20 @@ static void spapr_set_ic_mode(Object *obj, co=
nst char *value, Error **errp)
>>>>        }
>>>>    }
>>>>   =20
>>>> +static bool spapr_get_nvdimm(Object *obj, Error **errp)
>>>> +{
>>>> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
>>>> +
>>>> +    return spapr->nvdimm_enabled;
>>>> +}
>>>> +
>>>> +static void spapr_set_nvdimm(Object *obj, bool value, Error **errp)
>>>> +{
>>>> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
>>>> +
>>>> +    spapr->nvdimm_enabled =3D value;
>>>> +}
>>>> +
>>>>    static void spapr_instance_init(Object *obj)
>>>>    {
>>>>        sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
>>>> @@ -3188,6 +3254,11 @@ static void spapr_instance_init(Object *obj)
>>>>        object_property_set_description(obj, "ic-mode",
>>>>                     "Specifies the interrupt controller mode (xics, =
xive, dual)",
>>>>                     NULL);
>>>> +    object_property_add_bool(obj, "nvdimm",
>>>> +                            spapr_get_nvdimm, spapr_set_nvdimm, NUL=
L);
>>>> +    object_property_set_description(obj, "nvdimm",
>>>> +                                    "Enable support for nvdimm devi=
ces",
>>>> +                                    NULL);
>>>>    }
>>>>   =20
>>>>    static void spapr_machine_finalizefn(Object *obj)
>>>> @@ -3267,12 +3338,103 @@ static void spapr_add_lmbs(DeviceState *dev=
, uint64_t addr_start, uint64_t size,
>>>>        }
>>>>    }
>>>>   =20
>>>> +static int spapr_populate_nvdimm_node(void *fdt, int fdt_offset, ui=
nt32_t node,
>>>> +                                      uint64_t addr, uint64_t size,
>>>> +                                      uint64_t label_size)
>>>> +{
>>>> +    int offset;
>>>> +    char buf[40];
>>>> +    GString *lcode =3D g_string_sized_new(10);
>>>> +    sPAPRDRConnector *drc;
>>>> +    QemuUUID uuid;
>>>> +    uint32_t drc_idx;
>>>> +    uint32_t associativity[] =3D {
>>>> +        cpu_to_be32(0x4), /* length */
>>>> +        cpu_to_be32(0x0), cpu_to_be32(0x0),
>>>> +        cpu_to_be32(0x0), cpu_to_be32(node)
>>>> +    };
>>>> +
>>>> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM,
>>>> +                          addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
>>>> +    g_assert(drc);
>>>> +
>>>> +    drc_idx =3D spapr_drc_index(drc);
>>>> +
>>>> +    sprintf(buf, "pmem@%x", drc_idx);
>>>> +    offset =3D fdt_add_subnode(fdt, fdt_offset, buf);
>>>> +    _FDT(offset);
>>>> +
>>>> +    _FDT((fdt_setprop_cell(fdt, offset, "reg", drc_idx)));
>>>> +    _FDT((fdt_setprop_string(fdt, offset, "compatible", "ibm,pmemor=
y")));
>>>> +    _FDT((fdt_setprop_string(fdt, offset, "name", "pmem")));
>>>> +    _FDT((fdt_setprop_string(fdt, offset, "device_type", "ibm,pmemo=
ry")));
>>>> +
>>>> +    /*NB : Supposed to be random strings. Currently empty 10 string=
s! */
>>>> +    _FDT((fdt_setprop(fdt, offset, "ibm,loc-code", lcode->str, lcod=
e->len)));
>>>> +    g_string_free(lcode, TRUE);
>>>> +
>>>> +    _FDT((fdt_setprop(fdt, offset, "ibm,associativity", associativi=
ty,
>>>> +                      sizeof(associativity))));
>>>> +    g_random_set_seed(drc_idx);
>>>> +    qemu_uuid_generate(&uuid);
>>>> +
>>>> +    qemu_uuid_unparse(&uuid, buf);
>>>> +    _FDT((fdt_setprop_string(fdt, offset, "ibm,unit-guid", buf)));
>>>> +
>>>> +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_idx=
)));
>>>> +
>>>> +    /*NB : What it should be? */
>>>> +    _FDT(fdt_setprop_cell(fdt, offset, "ibm,latency-attribute", 828=
));
>>>> +
>>>> +    _FDT((fdt_setprop_u64(fdt, offset, "ibm,block-size",
>>>> +                          SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
>>>> +    _FDT((fdt_setprop_u64(fdt, offset, "ibm,number-of-blocks",
>>>> +                          size / SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
>>>> +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,metadata-size", label_=
size)));
>>>> +
>>>> +    return offset;
>>>> +}
>>>> +
>>>> +static void spapr_add_nvdimm(DeviceState *dev, uint64_t addr,
>>>> +                             uint64_t size, uint32_t node,
>>>> +                             Error **errp)
>>>> +{
>>>> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_hotplug_han=
dler(dev));
>>>> +    sPAPRDRConnector *drc;
>>>> +    bool hotplugged =3D spapr_drc_hotplugged(dev);
>>>> +    NVDIMMDevice *nvdimm =3D NVDIMM(OBJECT(dev));
>>>> +    void *fdt;
>>>> +    int fdt_offset, fdt_size;
>>>> +    Error *local_err =3D NULL;
>>>> +
>>>> +    spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM,
>>>> +                           addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
>>>> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM,
>>>> +                          addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
>>>> +    g_assert(drc);
>>>> +
>>>> +    fdt =3D create_device_tree(&fdt_size);
>>>> +    fdt_offset =3D spapr_populate_nvdimm_node(fdt, 0, node, addr,
>>>> +                                            size, nvdimm->label_siz=
e);
>>>> +
>>>> +    spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
>>>> +    if (local_err) {
>>>> +        error_propagate(errp, local_err);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (hotplugged) {
>>>> +        spapr_hotplug_req_add_by_index(drc);
>>>> +    }
>>>> +}
>>>> +
>>>>    static void spapr_memory_plug(HotplugHandler *hotplug_dev, Device=
State *dev,
>>>>                                  Error **errp)
>>>>    {
>>>>        Error *local_err =3D NULL;
>>>>        sPAPRMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
>>>>        PCDIMMDevice *dimm =3D PC_DIMM(dev);
>>>> +    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM=
);
>>>>        uint64_t size, addr;
>>>>        uint32_t node;
>>>>   =20
>>>> @@ -3291,9 +3453,14 @@ static void spapr_memory_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
>>>>   =20
>>>>        node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_P=
ROP,
>>>>                                        &error_abort);
>>>> -    spapr_add_lmbs(dev, addr, size, node,
>>>> -                   spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
>>>> -                   &local_err);
>>>> +    if (!is_nvdimm) {
>>>> +        spapr_add_lmbs(dev, addr, size, node,
>>>> +                       spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
>>>> +                       &local_err);
>>>> +    } else {
>>>> +        spapr_add_nvdimm(dev, addr, size, node, &local_err);
>>>> +    }
>>>> +
>>>>        if (local_err) {
>>>>            goto out_unplug;
>>>>        }
>>>> @@ -3311,6 +3478,7 @@ static void spapr_memory_pre_plug(HotplugHandl=
er *hotplug_dev, DeviceState *dev,
>>>>    {
>>>>        const sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(hotp=
lug_dev);
>>>>        sPAPRMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
>>>> +    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM=
);
>>>>        PCDIMMDevice *dimm =3D PC_DIMM(dev);
>>>>        Error *local_err =3D NULL;
>>>>        uint64_t size;
>>>> @@ -3328,10 +3496,30 @@ static void spapr_memory_pre_plug(HotplugHan=
dler *hotplug_dev, DeviceState *dev,
>>>>            return;
>>>>        }
>>>>   =20
>>>> -    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
>>>> +    if (!is_nvdimm && size % SPAPR_MEMORY_BLOCK_SIZE) {
>>>>            error_setg(errp, "Hotplugged memory size must be a multip=
le of "
>>>> -                      "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / M=
iB);
>>>> +                          "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE=
 / MiB);
>>>>            return;
>>>> +    } else if (is_nvdimm) {
>>>> +        NVDIMMDevice *nvdimm =3D NVDIMM(OBJECT(dev));
>>>> +        if ((nvdimm->label_size + size) % SPAPR_MINIMUM_SCM_BLOCK_S=
IZE) {
>>>> +            error_setg(errp, "NVDIMM memory size must be a multiple=
 of "
>>>> +                       "%" PRIu64 "MB", SPAPR_MINIMUM_SCM_BLOCK_SIZ=
E / MiB);
>>>> +            return;
>>>> +        }
>>>> +        if (((nvdimm->label_size + size) / SPAPR_MINIMUM_SCM_BLOCK_=
SIZE) =3D=3D 1) {
>>>> +            error_setg(errp, "NVDIMM size must be atleast "
>>>> +                       "%" PRIu64 "MB", 2 * SPAPR_MINIMUM_SCM_BLOCK=
_SIZE / MiB);
>>>> +            return;
>>>> +        }
> on the second glance 2 things looks weird here:
>    1. we shouldn't poke inside of nvdimm object directly, there is NVDI=
MM_LABEL_SIZE_PROP
>       if you really need to get label size

Ok. Will use the property.

>    2. why do we need to care about label_size here at all?

On PPC, there is no explicit way to specify the size of the NVDIMM=20
device for the guest.
It is inferred by the (number of SCM blocks) * (SCM block-size) as=20
specified in the
device tree. The label area is part of the nvdimm but not exposed to the=20
guest
as you mentioned. So, if user specified size=3D1GB, and label_size=3D3MB,=
=20
the qemu
will say (1GB-3MB)/256MB(block size) =3D 3 number of blocks and block siz=
e=20
as 256MB.
The user gets 768MB of the device. Since the minimum required size is 256=
MB,
and label_area being outside, and we want it to be aligned to 256MB, I=20
am forcing the minimum
device size to be 512MB. Actually it can be anything above 256MB +=20
label_size. I see
your point, I can just not care about label_size but care only about the=20
nvdimm size(-label_size)
is aligned to 256MB or not.

>>>> +        /* Align to scm block size, exclude the label */
>>>> +        memory_device_set_region_size(MEMORY_DEVICE(nvdimm),
>>>> +               QEMU_ALIGN_DOWN(size, SPAPR_MINIMUM_SCM_BLOCK_SIZE),=
 &local_err);
>>> I'm not sure that arbitrarily fixing up region size is the right thin=
g to do
>>> and also what you are trying to achieve here isn't clear, could you e=
xplain it some more?
>> The resize is required to allow the subsequent memory hotplugs to work=
. The
>> base address(if not specified) for the next dimm hotplug, starts at th=
e
>> end of
>> this region. If the region is not aligned to LMB size, guest refuses t=
o
>> claim the
>> newly hotplugged memory.=C2=A0 The label area can be small and need no=
t be
>> aligned to (LMB/SCM block) size. The region size is actually the size
>> minus the
>> label_size which can be unaligned to LMB size. So, align down to SCM b=
lock
>> size is necessary here.
> Well fixing up object(MemoryRegion) which belongs to the backend from
> machine level to satisfy machine specific alignment requirements looks
> like a wrong thing to do.

For a 1GB device with say 3MB label_size, the qemu exposes 3 SCM blocks=20
of 256MB each
and guest actually accesses 768MB of the region, even though the memory=20
region size
is (1GB-3MB). But on x86, the guest actually sees (1GB-3MB), not any less.
The memory region size is larger than 768 and is unaligned to 256MB, the
subsequent dimm hotplug would fail as the next free address got from
memory_device_get_free_addr is not aligned to 256MB.

[=C2=A0=C2=A0 35.617767] pseries-hotplug-mem: dlpar_memory: Memory add LM=
Bs
[=C2=A0=C2=A0 35.619598] pseries-hotplug-mem: Attempting to hot-add 1 LMB=
(s) at=20
index 80000040
[=C2=A0=C2=A0 35.619966] pseries-hotplug-mem: Attempting to hot-add in ra=
nge=20
40fe00000 - 40fe00000
[=C2=A0=C2=A0 35.620416] pseries-hotplug-mem: Attempting to hot-add in ra=
nge=20
40fe00000 - 40fe00000
[=C2=A0=C2=A0 35.621330] Block size [0x10000000 or 268435456] unaligned h=
otplug=20
range: start 0x40fe00000, size 0x10000000
[=C2=A0=C2=A0 35.621432] pseries-hotplug-mem: Memory indexed-count-add fa=
iled,=20
removing any added LMBs

This alignment problem is not unique to Power, I see the same happening=20
on x86_64 too as the
memory block size is required to be aligned to 128MB there.

[=C2=A0=C2=A0 26.558423] Block size [0x8000000] unaligned hotplug range: =
start=20
0x11ffe0000, size 0x8000000
[=C2=A0=C2=A0 26.558427] acpi PNP0C80:00: add_memory failed
[=C2=A0=C2=A0 26.558431] acpi PNP0C80:00: acpi_memory_enable_device() err=
or
[=C2=A0=C2=A0 26.558433] acpi PNP0C80:00: Enumeration failure

The user has to circumvent this alignment issue by explicitly giving the=20
256MB and 128MB as the align size on the
memory-backend-file object option on PPC and X86_64 respectively.

> So we need to come up with another approach.
> I'm sill not sure what problem is there but nvdimm already
> has a notion of data region (without label size) look for
> nvdimm->nvdimm_mr and mdc->get_memory_region and that's what you have i=
n
> local var 'size'.
>   =20
>
> So what you are doing here look incorrect even more,
> i.e. beside we shouldn't do it at all and the second thing is that you =
are
> sizing down data area which already excludes label size.

To get the things(nvdimm & dimm) working together, the user has to give=20
align=3D256m on
memory-backend-file device option for nvdimm device backend object.
With the align option, the nvdimm_prepare_memory_region() does the=20
QEMU_ALIGN_DOWN of the
memory region which I am doing here by default. Doing it by default=20
still makes sense as the
actual size the guest gets to use is only 768MB in this case. However, I=20
should probably do align down
only if the user has not specified the value by himself, and let=20
nvdimm_prepare_memory_region() do
it in such a case.

Since this is PPC specific alignment requirement, I think this is the=20
right place to enforce it & size down
by default here. There are checks for PPC specific DIMM size alignment=20
requirement same way here.
If this is not the right place, could you suggest me a better place as th=
e
nvdimm_prepare_memory_region() is generic and I cant set machine=20
specific device properties there?


> What I'd suggest is to align up GPA of being added memory on
>     MAX(LMB size, backend_page_size, max supported huge page size)
> so hotplugged dimm or whatever else would be properly aligned,
> see pc_dimm_pre_plug(,legacy_align,) and how PC uses it.

This approach though assures to give an address aligned to the=20
legacy_align mentioned from
memory_device_get_free_addr(), requires the size of the device also to=20
be aligned to
the legacy_align specified. If I am not sizing down the region size, the=20
size-label_size will not
be aligned to this size.=C2=A0 That is another reason why sizing down the=
=20
region size is still needed.

>>>> +        if (local_err) {
>>>> +            error_propagate(errp, local_err);
>>>> +            return;
>>>> +        }
>>>>        }
>>>>   =20
>>>>        memdev =3D object_property_get_link(OBJECT(dimm), PC_DIMM_MEM=
DEV_PROP,
>>>> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
>>>> index 2edb7d1e9c..94ddd102cc 100644
>>>> --- a/hw/ppc/spapr_drc.c
>>>> +++ b/hw/ppc/spapr_drc.c
>>>> @@ -696,6 +696,16 @@ static void spapr_drc_lmb_class_init(ObjectClas=
s *k, void *data)
>>>>        drck->release =3D spapr_lmb_release;
>>>>    }
>>>>   =20
>>>> +static void spapr_drc_pmem_class_init(ObjectClass *k, void *data)
>>>> +{
>>>> +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
>>>> +
>>>> +    drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM;
>>>> +    drck->typename =3D "MEM";
>>>> +    drck->drc_name_prefix =3D "PMEM ";
>>>> +    drck->release =3D NULL;
>>>> +}
>>>> +
>>>>    static const TypeInfo spapr_dr_connector_info =3D {
>>>>        .name          =3D TYPE_SPAPR_DR_CONNECTOR,
>>>>        .parent        =3D TYPE_DEVICE,
>>>> @@ -739,6 +749,12 @@ static const TypeInfo spapr_drc_lmb_info =3D {
>>>>        .class_init    =3D spapr_drc_lmb_class_init,
>>>>    };
>>>>   =20
>>>> +static const TypeInfo spapr_drc_pmem_info =3D {
>>>> +    .name          =3D TYPE_SPAPR_DRC_PMEM,
>>>> +    .parent        =3D TYPE_SPAPR_DRC_LOGICAL,
>>>> +    .class_init    =3D spapr_drc_pmem_class_init,
>>>> +};
>>>> +
>>>>    /* helper functions for external users */
>>>>   =20
>>>>    sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
>>>> @@ -1189,6 +1205,7 @@ static void spapr_drc_register_types(void)
>>>>        type_register_static(&spapr_drc_cpu_info);
>>>>        type_register_static(&spapr_drc_pci_info);
>>>>        type_register_static(&spapr_drc_lmb_info);
>>>> +    type_register_static(&spapr_drc_pmem_info);
>>>>   =20
>>>>        spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
>>>>                            rtas_set_indicator);
>>>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>>>> index 32719a1b72..a4fed84346 100644
>>>> --- a/hw/ppc/spapr_events.c
>>>> +++ b/hw/ppc/spapr_events.c
>>>> @@ -193,6 +193,7 @@ struct rtas_event_log_v6_hp {
>>>>    #define RTAS_LOG_V6_HP_TYPE_SLOT                         3
>>>>    #define RTAS_LOG_V6_HP_TYPE_PHB                          4
>>>>    #define RTAS_LOG_V6_HP_TYPE_PCI                          5
>>>> +#define RTAS_LOG_V6_HP_TYPE_PMEM                         6
>>>>        uint8_t hotplug_action;
>>>>    #define RTAS_LOG_V6_HP_ACTION_ADD                        1
>>>>    #define RTAS_LOG_V6_HP_ACTION_REMOVE                     2
>>>> @@ -526,6 +527,9 @@ static void spapr_hotplug_req_event(uint8_t hp_i=
d, uint8_t hp_action,
>>>>        case SPAPR_DR_CONNECTOR_TYPE_CPU:
>>>>            hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_CPU;
>>>>            break;
>>>> +    case SPAPR_DR_CONNECTOR_TYPE_PMEM:
>>>> +        hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_PMEM;
>>>> +        break;
>>>>        default:
>>>>            /* we shouldn't be signaling hotplug events for resources
>>>>             * that don't support them
>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>>> index a947a0a0dc..21a9709afe 100644
>>>> --- a/include/hw/ppc/spapr.h
>>>> +++ b/include/hw/ppc/spapr.h
>>>> @@ -187,6 +187,7 @@ struct sPAPRMachineState {
>>>>   =20
>>>>        bool cmd_line_caps[SPAPR_CAP_NUM];
>>>>        sPAPRCapabilities def, eff, mig;
>>>> +    bool nvdimm_enabled;
>>>>    };
>>>>   =20
>>>>    #define H_SUCCESS         0
>>>> @@ -798,6 +799,15 @@ int spapr_rtc_import_offset(sPAPRRTCState *rtc,=
 int64_t legacy_offset);
>>>>    #define SPAPR_LMB_FLAGS_DRC_INVALID 0x00000020
>>>>    #define SPAPR_LMB_FLAGS_RESERVED 0x00000080
>>>>   =20
>>>> +/*
>>>> + * The nvdimm size should be aligned to SCM block size.
>>>> + * The SCM block size should be aligned to SPAPR_MEMORY_BLOCK_SIZE
>>>> + * inorder to have SCM regions not to overlap with dimm memory regi=
ons.
>>>> + * The SCM devices can have variable block sizes. For now, fixing t=
he
>>>> + * block size to the minimum value.
>>>> + */
>>>> +#define SPAPR_MINIMUM_SCM_BLOCK_SIZE SPAPR_MEMORY_BLOCK_SIZE
>>>> +
>>>>    void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data a=
rg);
>>>>   =20
>>>>    #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
>>>> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
>>>> index f6ff32e7e2..65925d00b1 100644
>>>> --- a/include/hw/ppc/spapr_drc.h
>>>> +++ b/include/hw/ppc/spapr_drc.h
>>>> @@ -70,6 +70,13 @@
>>>>    #define SPAPR_DRC_LMB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), =
\
>>>>                                            TYPE_SPAPR_DRC_LMB)
>>>>   =20
>>>> +#define TYPE_SPAPR_DRC_PMEM "spapr-drc-pmem"
>>>> +#define SPAPR_DRC_PMEM_GET_CLASS(obj) \
>>>> +        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC=
_PMEM)
>>>> +#define SPAPR_DRC_PMEM_CLASS(klass) \
>>>> +        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR=
_DRC_PMEM)
>>>> +#define SPAPR_DRC_PMEM(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
>>>> +                                        TYPE_SPAPR_DRC_PMEM)
>>>>    /*
>>>>     * Various hotplug types managed by sPAPRDRConnector
>>>>     *
>>>> @@ -87,6 +94,7 @@ typedef enum {
>>>>        SPAPR_DR_CONNECTOR_TYPE_SHIFT_VIO =3D 3,
>>>>        SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI =3D 4,
>>>>        SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB =3D 8,
>>>> +    SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM =3D 9,
>>>>    } sPAPRDRConnectorTypeShift;
>>>>   =20
>>>>    typedef enum {
>>>> @@ -96,6 +104,7 @@ typedef enum {
>>>>        SPAPR_DR_CONNECTOR_TYPE_VIO =3D 1 << SPAPR_DR_CONNECTOR_TYPE_=
SHIFT_VIO,
>>>>        SPAPR_DR_CONNECTOR_TYPE_PCI =3D 1 << SPAPR_DR_CONNECTOR_TYPE_=
SHIFT_PCI,
>>>>        SPAPR_DR_CONNECTOR_TYPE_LMB =3D 1 << SPAPR_DR_CONNECTOR_TYPE_=
SHIFT_LMB,
>>>> +    SPAPR_DR_CONNECTOR_TYPE_PMEM =3D 1 << SPAPR_DR_CONNECTOR_TYPE_S=
HIFT_PMEM,
>>>>    } sPAPRDRConnectorType;
>>>>   =20
>>>>    /*
>>>>
>>>>  =20
