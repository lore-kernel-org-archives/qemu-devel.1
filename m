Received: from eggs.gnu.org ([209.51.188.92]:52566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi9-0008BP-Sv
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi6-0005au-Hc
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:05 -0500
Date: Mon, 18 Feb 2019 10:02:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190217230211.GA2765@umbus.fritz.box>
References: <154943058200.27958.11497653677605446596.stgit@lep8c.aus.stglabs.ibm.com>
	<154943078167.27958.5009288263168039462.stgit@lep8c.aus.stglabs.ibm.com>
	<20190212014953.GI1884@umbus.fritz.box>
	<fbc178dd-ee93-1675-b8e5-ccfec72ab66a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <fbc178dd-ee93-1675-b8e5-ccfec72ab66a@linux.ibm.com>
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
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, mst@redhat.com, bharata@linux.ibm.com, qemu-ppc@nongnu.org, vaibhav@linux.ibm.com, imammedo@redhat.com


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 04:41:09PM +0530, Shivaprasad G Bhat wrote:
> Thanks for the comments David. Please find my replies inline..
>=20
>=20
> On 02/12/2019 07:19 AM, David Gibson wrote:
> > On Tue, Feb 05, 2019 at 11:26:27PM -0600, Shivaprasad G Bhat wrote:
> > > Add support for NVDIMM devices for sPAPR. Piggyback on existing nvdimm
> > > device interface in QEMU to support virtual NVDIMM devices for Power =
(May have
> > > to re-look at this later).  Create the required DT entries for the
> > > device (some entries have dummy values right now).
> > >=20
> > > The patch creates the required DT node and sends a hotplug
> > > interrupt to the guest. Guest is expected to undertake the normal
> > > DR resource add path in response and start issuing PAPR SCM hcalls.
> > >=20
> > > This is how it can be used ..
> > > Add nvdimm=3Don to the qemu machine argument.
> > > Ex : -machine pseries,nvdimm=3Don
> > > For coldplug, the device to be added in qemu command line as shown be=
low
> > > -object memory-backend-file,id=3Dmemnvdimm0,prealloc=3Dyes,mem-path=
=3D/tmp/nvdimm0.img,share=3Dyes,size=3D512m
> > > -device nvdimm,label-size=3D128k,memdev=3Dmemnvdimm0,id=3Dnvdimm0,slo=
t=3D0
> > >=20
> > > For hotplug, the device to be added from monitor as below
> > > object_add memory-backend-file,id=3Dmemnvdimm0,prealloc=3Dyes,mem-pat=
h=3D/tmp/nvdimm0.img,share=3Dyes,size=3D512m
> > > device_add nvdimm,label-size=3D128k,memdev=3Dmemnvdimm0,id=3Dnvdimm0,=
slot=3D0
> > >=20
> > > Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> > > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > >                 [Early implementation]
> > > ---
> > >   default-configs/ppc64-softmmu.mak |    1
> > >   hw/ppc/spapr.c                    |  212 ++++++++++++++++++++++++++=
+++++++++--
> > >   hw/ppc/spapr_drc.c                |   17 +++
> > >   hw/ppc/spapr_events.c             |    4 +
> > >   include/hw/ppc/spapr.h            |   10 ++
> > >   include/hw/ppc/spapr_drc.h        |    9 ++
> > >   6 files changed, 241 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc6=
4-softmmu.mak
> > > index 7f34ad0528..b6e1aa5125 100644
> > > --- a/default-configs/ppc64-softmmu.mak
> > > +++ b/default-configs/ppc64-softmmu.mak
> > > @@ -20,4 +20,5 @@ CONFIG_XIVE=3D$(CONFIG_PSERIES)
> > >   CONFIG_XIVE_SPAPR=3D$(CONFIG_PSERIES)
> > >   CONFIG_MEM_DEVICE=3Dy
> > >   CONFIG_DIMM=3Dy
> > > +CONFIG_NVDIMM=3Dy
> > >   CONFIG_SPAPR_RNG=3Dy
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 0fcdd35cbe..7e7a1a8041 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -73,6 +73,7 @@
> > >   #include "qemu/cutils.h"
> > >   #include "hw/ppc/spapr_cpu_core.h"
> > >   #include "hw/mem/memory-device.h"
> > > +#include "hw/mem/nvdimm.h"
> > >   #include <libfdt.h>
> > > @@ -690,6 +691,7 @@ static int spapr_populate_drmem_v2(sPAPRMachineSt=
ate *spapr, void *fdt,
> > >       uint8_t *int_buf, *cur_index, buf_len;
> > >       int ret;
> > >       uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
> > > +    uint64_t scm_block_size =3D SPAPR_MINIMUM_SCM_BLOCK_SIZE;
> > >       uint64_t addr, cur_addr, size;
> > >       uint32_t nr_boot_lmbs =3D (machine->device_memory->base / lmb_s=
ize);
> > >       uint64_t mem_end =3D machine->device_memory->base +
> > > @@ -726,15 +728,24 @@ static int spapr_populate_drmem_v2(sPAPRMachine=
State *spapr, void *fdt,
> > >               nr_entries++;
> > >           }
> > > -        /* Entry for DIMM */
> > > -        drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
> > > -        g_assert(drc);
> > > -        elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
> > > -                                     spapr_drc_index(drc), node,
> > > -                                     SPAPR_LMB_FLAGS_ASSIGNED);
> > > +        if (info->value->type =3D=3D MEMORY_DEVICE_INFO_KIND_NVDIMM)=
 {
> > > +            /* Entry for NVDIMM */
> > > +            drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, addr / scm_=
block_size);
> > > +            g_assert(drc);
> > > +            elem =3D spapr_get_drconf_cell(size / scm_block_size, ad=
dr,
> > > +                                         spapr_drc_index(drc), -1, 0=
);
> > > +            cur_addr =3D ROUND_UP(addr + size, scm_block_size);
> > > +        } else {
> > > +            /* Entry for DIMM */
> > > +            drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_s=
ize);
> > > +            g_assert(drc);
> > > +            elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
> > > +                                         spapr_drc_index(drc), node,
> > > +                                         SPAPR_LMB_FLAGS_ASSIGNED);
> > > +            cur_addr =3D addr + size;
> > > +        }
> > >           QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
> > >           nr_entries++;
> > > -        cur_addr =3D addr + size;
> > >       }
> > >       /* Entry for remaining hotpluggable area */
> > > @@ -1225,6 +1236,42 @@ static void spapr_dt_hypervisor(sPAPRMachineSt=
ate *spapr, void *fdt)
> > >       }
> > >   }
> > > +static int spapr_populate_nvdimm_node(void *fdt, int fdt_offset,
> > > +                                      uint32_t node, uint64_t addr,
> > > +                                      uint64_t size, uint64_t label_=
size);
> > Re-ordering the code is generally preferred to static forward declarati=
ons.
> Ok
> > > +static void spapr_create_nvdimm(void *fdt)
> > I'm trying to standardize on spapr_dt_*() for functions which generate
> > bits of the device tree.
> Ok. Will rename to spapr_dt_create_nvdimm

Just spapr_dt_nvdimm() would be preferred.

> > > +{
> > > +    int offset =3D fdt_subnode_offset(fdt, 0, "persistent-memory");
> > > +    GSList *dimms =3D NULL;
> > > +
> > > +    if (offset < 0) {
> > > +        offset =3D fdt_add_subnode(fdt, 0, "persistent-memory");
> > > +        _FDT(offset);
> > > +        _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x2)));
> > > +        _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
> > > +        _FDT((fdt_setprop_string(fdt, offset, "name", "persistent-me=
mory")));
> > No need to explicitly set the "name" property, that's implicit in the
> > node name.
> Ok
> > > +        _FDT((fdt_setprop_string(fdt, offset, "device_type",
> > > +                                 "ibm,persistent-memory")));
> > > +    }
> > > +
> > > +    /*NB : Add drc-info array here */
> > > +
> > > +    /* Create DT entries for cold plugged NVDIMM devices */
> > > +    dimms =3D nvdimm_get_device_list();
> > > +    for (; dimms; dimms =3D dimms->next) {
> > > +        NVDIMMDevice *nvdimm =3D dimms->data;
> > > +        PCDIMMDevice *di =3D PC_DIMM(nvdimm);
> > > +        uint64_t lsize =3D nvdimm->label_size;
> > > +        int size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM=
_SIZE_PROP,
> > > +                                           NULL);
> > > +
> > > +        spapr_populate_nvdimm_node(fdt, offset, di->node, di->addr,
> > > +                                   size, lsize);
> > It might be cleaner to just pass the NVDIMMDevice * rather than
> > umpteen parameters.
> Ok.
> > > +    }
> > > +    g_slist_free(dimms);
> > > +    return;
> > > +}
> > > +
> > >   static void *spapr_build_fdt(sPAPRMachineState *spapr)
> > >   {
> > >       MachineState *machine =3D MACHINE(spapr);
> > > @@ -1348,6 +1395,11 @@ static void *spapr_build_fdt(sPAPRMachineState=
 *spapr)
> > >           exit(1);
> > >       }
> > > +    /* NVDIMM devices */
> > > +    if (spapr->nvdimm_enabled) {
> > > +        spapr_create_nvdimm(fdt);
> > > +    }
> > > +
> > >       return fdt;
> > >   }
> > > @@ -3143,6 +3195,20 @@ static void spapr_set_ic_mode(Object *obj, con=
st char *value, Error **errp)
> > >       }
> > >   }
> > > +static bool spapr_get_nvdimm(Object *obj, Error **errp)
> > > +{
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > +
> > > +    return spapr->nvdimm_enabled;
> > > +}
> > > +
> > > +static void spapr_set_nvdimm(Object *obj, bool value, Error **errp)
> > > +{
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > +
> > > +    spapr->nvdimm_enabled =3D value;
> > > +}
> > > +
> > >   static void spapr_instance_init(Object *obj)
> > >   {
> > >       sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > @@ -3188,6 +3254,11 @@ static void spapr_instance_init(Object *obj)
> > >       object_property_set_description(obj, "ic-mode",
> > >                    "Specifies the interrupt controller mode (xics, xi=
ve, dual)",
> > >                    NULL);
> > > +    object_property_add_bool(obj, "nvdimm",
> > > +                            spapr_get_nvdimm, spapr_set_nvdimm, NULL=
);
> > > +    object_property_set_description(obj, "nvdimm",
> > > +                                    "Enable support for nvdimm devic=
es",
> > > +                                    NULL);
> > I'm not seeing a lot of point to this machine parameter.
> Just followed what the x86 is doing here.

Hmm.  I wonder what the rationale for the property is there.

> > >   }
> > >   static void spapr_machine_finalizefn(Object *obj)
> > > @@ -3267,12 +3338,103 @@ static void spapr_add_lmbs(DeviceState *dev,=
 uint64_t addr_start, uint64_t size,
> > >       }
> > >   }
> > > +static int spapr_populate_nvdimm_node(void *fdt, int fdt_offset, uin=
t32_t node,
> > > +                                      uint64_t addr, uint64_t size,
> > > +                                      uint64_t label_size)
> > > +{
> > > +    int offset;
> > > +    char buf[40];
> > > +    GString *lcode =3D g_string_sized_new(10);
> > > +    sPAPRDRConnector *drc;
> > > +    QemuUUID uuid;
> > > +    uint32_t drc_idx;
> > > +    uint32_t associativity[] =3D {
> > > +        cpu_to_be32(0x4), /* length */
> > > +        cpu_to_be32(0x0), cpu_to_be32(0x0),
> > > +        cpu_to_be32(0x0), cpu_to_be32(node)
> > > +    };
> > > +
> > > +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM,
> > > +                          addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
> > > +    g_assert(drc);
> > > +
> > > +    drc_idx =3D spapr_drc_index(drc);
> > > +
> > > +    sprintf(buf, "pmem@%x", drc_idx);
> > > +    offset =3D fdt_add_subnode(fdt, fdt_offset, buf);
> > "fdt_offset" vs. "offset" isn't very obvious.  Maybe parent_offset /
> > child_offset or something?
> Ok
> > > +    _FDT(offset);
> > > +
> > > +    _FDT((fdt_setprop_cell(fdt, offset, "reg", drc_idx)));
> > > +    _FDT((fdt_setprop_string(fdt, offset, "compatible", "ibm,pmemory=
")));
> > > +    _FDT((fdt_setprop_string(fdt, offset, "name", "pmem")));
> > Again, no need to set "name".
> Ok
> > > +    _FDT((fdt_setprop_string(fdt, offset, "device_type", "ibm,pmemor=
y")));
> > > +
> > > +    /*NB : Supposed to be random strings. Currently empty 10 strings=
! */
> > > +    _FDT((fdt_setprop(fdt, offset, "ibm,loc-code", lcode->str, lcode=
->len)));
> > > +    g_string_free(lcode, TRUE);
> > I think leaving this property out would be preferable to including it
> > but putting nothing useful there.
> Ok.
> > > +
> > > +    _FDT((fdt_setprop(fdt, offset, "ibm,associativity", associativit=
y,
> > > +                      sizeof(associativity))));
> > > +    g_random_set_seed(drc_idx);
> > > +    qemu_uuid_generate(&uuid);
> > This looks bogus.  I'm guessing the set seed is so that you generate
> > consistent UUIDs for the same NVDIMM in a guest.  First, that's making
> > a lot of assumptions about how qemu_uuid_generate() works that aren't
> > really warranted.  Second, it poisons the RNG for anything running
> > after this which actually wants (pseudo) random numbers.
> >=20
> > I think you need to make the UUID a property of the device instead.
> Ok.
> > > +
> > > +    qemu_uuid_unparse(&uuid, buf);
> > > +    _FDT((fdt_setprop_string(fdt, offset, "ibm,unit-guid", buf)));
> > > +
> > > +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_idx)=
));
> > > +
> > > +    /*NB : What it should be? */
> > > +    _FDT(fdt_setprop_cell(fdt, offset, "ibm,latency-attribute", 828)=
);
> > > +
> > > +    _FDT((fdt_setprop_u64(fdt, offset, "ibm,block-size",
> > > +                          SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
> > > +    _FDT((fdt_setprop_u64(fdt, offset, "ibm,number-of-blocks",
> > > +                          size / SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
> > > +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,metadata-size", label_s=
ize)));
> > > +
> > > +    return offset;
> > > +}
> > > +
> > > +static void spapr_add_nvdimm(DeviceState *dev, uint64_t addr,
> > > +                             uint64_t size, uint32_t node,
> > > +                             Error **errp)
> > > +{
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_hotplug_hand=
ler(dev));
> > > +    sPAPRDRConnector *drc;
> > > +    bool hotplugged =3D spapr_drc_hotplugged(dev);
> > > +    NVDIMMDevice *nvdimm =3D NVDIMM(OBJECT(dev));
> > > +    void *fdt;
> > > +    int fdt_offset, fdt_size;
> > > +    Error *local_err =3D NULL;
> > > +
> > > +    spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM,
> > > +                           addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
> > > +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM,
> > > +                          addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
> > > +    g_assert(drc);
> > Creating the DRC in the hotplug path looks bogus.  Generally the DRC
> > has to exist before you can even attempt to plug the device.
>=20
> We dont really know how many DRC to create. Unlike memory hotplug
> where we know how many LMBs are required to fit till the maxmem, in this
> case we dont know how many NVDIMM devices=A0 guest can have. That is the
> reason I am creating the DRC on demand. I'll see if it is possible to
> address this
> by putting a cap on maximum number of NVDIMM devices a guest can have.

Urgh, PAPR.  First it specifies a crappy hotplug model that requires
zillions of fixed attachment points to be instantiated, then it breaks
its own model.

But.. I still don't really understand how this works.

a) How does the guest know the DRC index to use for the new NVDIMM?
   Generally that comes from the device tree, but the guest doesn't
   get new device tree information until it calls configure-connector
   for which it needs the DRC index.

b) AFAICT, NVDIMMs would also require HPT space, much like regular
   memory would.  PowerVM doesn't have HPT resizing, so surely it must
   already have some sort of cap on the amount of NVDIMM space in
   order to size the HPT correctly.


> > > +    fdt =3D create_device_tree(&fdt_size);
> > > +    fdt_offset =3D spapr_populate_nvdimm_node(fdt, 0, node, addr,
> > > +                                            size, nvdimm->label_size=
);
> > > +
> > > +    spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> > > +    if (local_err) {
> > > +        error_propagate(errp, local_err);
> > > +        return;
> > > +    }
> > > +
> > > +    if (hotplugged) {
> > > +        spapr_hotplug_req_add_by_index(drc);
> > > +    }
> > > +}
> > > +
> > >   static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceSt=
ate *dev,
> > >                                 Error **errp)
> > >   {
> > >       Error *local_err =3D NULL;
> > >       sPAPRMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
> > >       PCDIMMDevice *dimm =3D PC_DIMM(dev);
> > > +    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> > >       uint64_t size, addr;
> > >       uint32_t node;
> > > @@ -3291,9 +3453,14 @@ static void spapr_memory_plug(HotplugHandler *=
hotplug_dev, DeviceState *dev,
> > >       node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PRO=
P,
> > >                                       &error_abort);
> > > -    spapr_add_lmbs(dev, addr, size, node,
> > > -                   spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> > > -                   &local_err);
> > > +    if (!is_nvdimm) {
> > > +        spapr_add_lmbs(dev, addr, size, node,
> > > +                       spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> > > +                       &local_err);
> > > +    } else {
> > > +        spapr_add_nvdimm(dev, addr, size, node, &local_err);
> > > +    }
> > > +
> > >       if (local_err) {
> > >           goto out_unplug;
> > >       }
> > > @@ -3311,6 +3478,7 @@ static void spapr_memory_pre_plug(HotplugHandle=
r *hotplug_dev, DeviceState *dev,
> > >   {
> > >       const sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(hotplu=
g_dev);
> > >       sPAPRMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
> > > +    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> > >       PCDIMMDevice *dimm =3D PC_DIMM(dev);
> > >       Error *local_err =3D NULL;
> > >       uint64_t size;
> > > @@ -3328,10 +3496,30 @@ static void spapr_memory_pre_plug(HotplugHand=
ler *hotplug_dev, DeviceState *dev,
> > >           return;
> > >       }
> > > -    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
> > > +    if (!is_nvdimm && size % SPAPR_MEMORY_BLOCK_SIZE) {
> > >           error_setg(errp, "Hotplugged memory size must be a multiple=
 of "
> > > -                      "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / Mi=
B);
> > > +                          "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE =
/ MiB);
> > >           return;
> > > +    } else if (is_nvdimm) {
> > > +        NVDIMMDevice *nvdimm =3D NVDIMM(OBJECT(dev));
> > > +        if ((nvdimm->label_size + size) % SPAPR_MINIMUM_SCM_BLOCK_SI=
ZE) {
> > > +            error_setg(errp, "NVDIMM memory size must be a multiple =
of "
> > > +                       "%" PRIu64 "MB", SPAPR_MINIMUM_SCM_BLOCK_SIZE=
 / MiB);
> > > +            return;
> > > +        }
> > > +        if (((nvdimm->label_size + size) / SPAPR_MINIMUM_SCM_BLOCK_S=
IZE) =3D=3D 1) {
> > > +            error_setg(errp, "NVDIMM size must be atleast "
> > > +                       "%" PRIu64 "MB", 2 * SPAPR_MINIMUM_SCM_BLOCK_=
SIZE / MiB);
> > > +            return;
> > > +        }
> > > +
> > > +        /* Align to scm block size, exclude the label */
> > > +        memory_device_set_region_size(MEMORY_DEVICE(nvdimm),
> > > +               QEMU_ALIGN_DOWN(size, SPAPR_MINIMUM_SCM_BLOCK_SIZE), =
&local_err);
> > > +        if (local_err) {
> > > +            error_propagate(errp, local_err);
> > > +            return;
> > > +        }
> > >       }
> > >       memdev =3D object_property_get_link(OBJECT(dimm), PC_DIMM_MEMDE=
V_PROP,
> > > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > > index 2edb7d1e9c..94ddd102cc 100644
> > > --- a/hw/ppc/spapr_drc.c
> > > +++ b/hw/ppc/spapr_drc.c
> > > @@ -696,6 +696,16 @@ static void spapr_drc_lmb_class_init(ObjectClass=
 *k, void *data)
> > >       drck->release =3D spapr_lmb_release;
> > >   }
> > > +static void spapr_drc_pmem_class_init(ObjectClass *k, void *data)
> > > +{
> > > +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> > > +
> > > +    drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM;
> > > +    drck->typename =3D "MEM";
> > > +    drck->drc_name_prefix =3D "PMEM ";
> > > +    drck->release =3D NULL;
> > > +}
> > > +
> > >   static const TypeInfo spapr_dr_connector_info =3D {
> > >       .name          =3D TYPE_SPAPR_DR_CONNECTOR,
> > >       .parent        =3D TYPE_DEVICE,
> > > @@ -739,6 +749,12 @@ static const TypeInfo spapr_drc_lmb_info =3D {
> > >       .class_init    =3D spapr_drc_lmb_class_init,
> > >   };
> > > +static const TypeInfo spapr_drc_pmem_info =3D {
> > > +    .name          =3D TYPE_SPAPR_DRC_PMEM,
> > > +    .parent        =3D TYPE_SPAPR_DRC_LOGICAL,
> > > +    .class_init    =3D spapr_drc_pmem_class_init,
> > > +};
> > > +
> > >   /* helper functions for external users */
> > >   sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
> > > @@ -1189,6 +1205,7 @@ static void spapr_drc_register_types(void)
> > >       type_register_static(&spapr_drc_cpu_info);
> > >       type_register_static(&spapr_drc_pci_info);
> > >       type_register_static(&spapr_drc_lmb_info);
> > > +    type_register_static(&spapr_drc_pmem_info);
> > >       spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
> > >                           rtas_set_indicator);
> > > diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> > > index 32719a1b72..a4fed84346 100644
> > > --- a/hw/ppc/spapr_events.c
> > > +++ b/hw/ppc/spapr_events.c
> > > @@ -193,6 +193,7 @@ struct rtas_event_log_v6_hp {
> > >   #define RTAS_LOG_V6_HP_TYPE_SLOT                         3
> > >   #define RTAS_LOG_V6_HP_TYPE_PHB                          4
> > >   #define RTAS_LOG_V6_HP_TYPE_PCI                          5
> > > +#define RTAS_LOG_V6_HP_TYPE_PMEM                         6
> > >       uint8_t hotplug_action;
> > >   #define RTAS_LOG_V6_HP_ACTION_ADD                        1
> > >   #define RTAS_LOG_V6_HP_ACTION_REMOVE                     2
> > > @@ -526,6 +527,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id=
, uint8_t hp_action,
> > >       case SPAPR_DR_CONNECTOR_TYPE_CPU:
> > >           hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_CPU;
> > >           break;
> > > +    case SPAPR_DR_CONNECTOR_TYPE_PMEM:
> > > +        hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_PMEM;
> > > +        break;
> > >       default:
> > >           /* we shouldn't be signaling hotplug events for resources
> > >            * that don't support them
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index a947a0a0dc..21a9709afe 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -187,6 +187,7 @@ struct sPAPRMachineState {
> > >       bool cmd_line_caps[SPAPR_CAP_NUM];
> > >       sPAPRCapabilities def, eff, mig;
> > > +    bool nvdimm_enabled;
> > >   };
> > >   #define H_SUCCESS         0
> > > @@ -798,6 +799,15 @@ int spapr_rtc_import_offset(sPAPRRTCState *rtc, =
int64_t legacy_offset);
> > >   #define SPAPR_LMB_FLAGS_DRC_INVALID 0x00000020
> > >   #define SPAPR_LMB_FLAGS_RESERVED 0x00000080
> > > +/*
> > > + * The nvdimm size should be aligned to SCM block size.
> > > + * The SCM block size should be aligned to SPAPR_MEMORY_BLOCK_SIZE
> > > + * inorder to have SCM regions not to overlap with dimm memory regio=
ns.
> > > + * The SCM devices can have variable block sizes. For now, fixing the
> > > + * block size to the minimum value.
> > > + */
> > > +#define SPAPR_MINIMUM_SCM_BLOCK_SIZE SPAPR_MEMORY_BLOCK_SIZE
> > > +
> > >   void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg=
);
> > >   #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> > > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> > > index f6ff32e7e2..65925d00b1 100644
> > > --- a/include/hw/ppc/spapr_drc.h
> > > +++ b/include/hw/ppc/spapr_drc.h
> > > @@ -70,6 +70,13 @@
> > >   #define SPAPR_DRC_LMB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
> > >                                           TYPE_SPAPR_DRC_LMB)
> > > +#define TYPE_SPAPR_DRC_PMEM "spapr-drc-pmem"
> > > +#define SPAPR_DRC_PMEM_GET_CLASS(obj) \
> > > +        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_=
PMEM)
> > > +#define SPAPR_DRC_PMEM_CLASS(klass) \
> > > +        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_=
DRC_PMEM)
> > > +#define SPAPR_DRC_PMEM(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
> > > +                                        TYPE_SPAPR_DRC_PMEM)
> > >   /*
> > >    * Various hotplug types managed by sPAPRDRConnector
> > >    *
> > > @@ -87,6 +94,7 @@ typedef enum {
> > >       SPAPR_DR_CONNECTOR_TYPE_SHIFT_VIO =3D 3,
> > >       SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI =3D 4,
> > >       SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB =3D 8,
> > > +    SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM =3D 9,
> > >   } sPAPRDRConnectorTypeShift;
> > >   typedef enum {
> > > @@ -96,6 +104,7 @@ typedef enum {
> > >       SPAPR_DR_CONNECTOR_TYPE_VIO =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SH=
IFT_VIO,
> > >       SPAPR_DR_CONNECTOR_TYPE_PCI =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SH=
IFT_PCI,
> > >       SPAPR_DR_CONNECTOR_TYPE_LMB =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SH=
IFT_LMB,
> > > +    SPAPR_DR_CONNECTOR_TYPE_PMEM =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SH=
IFT_PMEM,
> > >   } sPAPRDRConnectorType;
> > >   /*
> > >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxp5/AACgkQbDjKyiDZ
s5LqdA//T41xZSLeuXsGNQhhBa0LiJv0DREufe7GZXYl7VFUpmZwx7wyJYlvQD6+
CYm6j/VdqZjyeEButejnHngUTGqXoyo8Jg17oYTGvLm3VRlZ/CKvMxL1PNBOmpit
zYd18RQJGi9cIe/XUSTzQ2SDxsr6KGtqTNWX8vKunLpqP4XJ+0xiR9PKEv0Gg0RE
yfdwc0KLfIur07JOQNbR6hLV7yWmj85vy3VYdsoIVA9ANmr9ADAwyu7vj0ihrGPJ
wSEk9CKUxMlFO80+p65c32uuNgkj+x8zr/X2636hoAtXmYAzaVqT6ILQa1wL9ZCp
qilW+oBA6LvUxwu1yv1kIBvzaWw3UzkiysZlkxq0WFZqOdSwxKeM/hw+W/RQ2cEz
zpnzKbM53Gi2xI8R3PPbEJsG8LuCBX/Sb3GeyhyiEZKJKHKgcykF3mf8koWnLY/8
IXwt5o9jYHTDZG/xj+fuiUMQwVF+5fuX4vG0csWLri4RN1IuJAU8XzOHw0nT3btQ
vedztux/iNplnYoAivSZgahLSX6BizbmZ/3TBnOSPZNLrIdUuRCApY1DOSGrKBAQ
+oqpRW5SLUWkgoUK1gVtQ9zN34j+NoVuURgT4NkpDU4Kevaq3bogDOK+aUPntAbB
0FbJfZ8h1nl5sAEzJywI83ZRIVGy02/Ri0Sc9/mca/CYP+K1kOY=
=5YsT
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
