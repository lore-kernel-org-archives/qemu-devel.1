Received: from eggs.gnu.org ([2001:4830:134:3::10]:59666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1ffhRQ-0001I8-BP
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1ffhRI-0000ex-Or
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:04:08 -0400
Message-ID: <bc6c5befa0a24b35f439419d6dea493dc19035b9.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 18 Jul 2018 18:03:29 +1000
In-Reply-To: <20180718061230.GE2102@umbus.fritz.box>
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 2018-07-18 at 16:12 +1000, David Gibson wrote:
> On Thu, Jun 28, 2018 at 10:36:32AM +0200, C=C3=A9dric Le Goater wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Can you trim your replies ? It's really hard to find your comments in
such a long patch...

> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index 6ac8a9392da6..966a996c2eac 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -194,6 +194,7 @@ void icp_set_mfrr(ICPState *icp, uint8_t mfrr);
> >  uint32_t icp_accept(ICPState *ss);
> >  uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr);
> >  void icp_eoi(ICPState *icp, uint32_t xirr);
> > +void icp_irq(ICSState *ics, int server, int nr, uint8_t priority);
>=20
> Hrm... are you sure you need to expose this?

See further down...

> > +/*
> > + * The CONFIG_DATA register expects little endian accesses, but as t=
he
> > + * region is big endian, we have to swap the value.
> > + */
> > +static void pnv_phb3_config_write(PnvPHB3 *phb, unsigned off,
> > +                                  unsigned size, uint64_t val)
> > +{
> > +    uint32_t cfg_addr, limit;
> > +    PCIDevice *pdev;
> > +
> > +    pdev =3D pnv_phb3_find_cfg_dev(phb);
> > +    if (!pdev) {
> > +        return;
> > +    }
> > +    cfg_addr =3D (phb->regs[PHB_CONFIG_ADDRESS >> 3] >> 32) & 0xfff;
> > +    cfg_addr |=3D off;
>=20
> This looks weird - there are callers of this that appear to have low
> bits in 'off', then you're ORing it with overlapping low bits.

Should be ffc like the read case.

>=20
> > +    limit =3D pci_config_size(pdev);
> > +    if (limit <=3D cfg_addr) {
> > +        /* conventional pci device can be behind pcie-to-pci bridge.
> > +           256 <=3D addr < 4K has no effects. */
> > +        return;
> > +    }
> > +    switch (size) {
> > +    case 1:
> > +        break;
> > +    case 2:
> > +        val =3D bswap16(val);
> > +        break;
> > +    case 4:
> > +        val =3D bswap32(val);
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +    pci_host_config_write_common(pdev, cfg_addr, limit, val, size);
> > +}
> > +
> > +static uint64_t pnv_phb3_config_read(PnvPHB3 *phb, unsigned off,
> > +                                     unsigned size)
> > +{
> > +    uint32_t cfg_addr, limit;
> > +    PCIDevice *pdev;
> > +    uint64_t val;
> > +
> > +    pdev =3D pnv_phb3_find_cfg_dev(phb);
> > +    if (!pdev) {
> > +        return ~0ull;
> > +    }
> > +    cfg_addr =3D (phb->regs[PHB_CONFIG_ADDRESS >> 3] >> 32) & 0xffc;
> > +    cfg_addr |=3D off;
>=20
> This looks better, should it be 0xffc in the write path as well?
>=20
> > +    limit =3D pci_config_size(pdev);
> > +    if (limit <=3D cfg_addr) {
> > +        /* conventional pci device can be behind pcie-to-pci bridge.
> > +           256 <=3D addr < 4K has no effects. */
> > +        return ~0ull;
> > +    }
> > +    val =3D pci_host_config_read_common(pdev, cfg_addr, limit, size)=
;
> > +    switch (size) {
> > +    case 1:
> > +        return val;
> > +    case 2:
> > +        return bswap16(val);
> > +    case 4:
> > +        return bswap32(val);
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +}
> > +
> > +static void pnv_phb3_check_m32(PnvPHB3 *phb)
> > +{
> > +    uint64_t base, start, size;
> > +    MemoryRegion *parent;
> > +    PnvPBCQState *pbcq =3D &phb->pbcq;
> > +
> > +    if (phb->m32_mapped) {
> > +        memory_region_del_subregion(phb->mr_m32.container, &phb->mr_=
m32);
> > +        phb->m32_mapped =3D false;
>=20
> Could you use memory_region_set_enabled() rather than having to add
> and delete the subregion and keep track of it in this separate
> variable?

There was a reason for that but it's years old and I forgot... I think
when re-enabled it moves around, among other things. So it's not more
efficient.

> > +    }
> > +
> > +    /* Disabled ? move on with life ... */
>=20
> Trivial: "nothing to do" seems to be the standard way to express this.
> Even trivialler: usual English rules don't put a space before '?' or
> '!' punctuation.

No, that's the tasteless English rule :-) It shall be overridden by
anybody interested in making things actually readable :-)

> > +
> > +static void pnv_phb3_lxivt_write(PnvPHB3 *phb, unsigned idx, uint64_=
t val)
> > +{
> > +    ICSState *ics =3D &phb->lsis;
> > +    uint8_t server, prio;
> > +
> > +    phb->ioda_LXIVT[idx] =3D val & (IODA2_LXIVT_SERVER |
> > +                                  IODA2_LXIVT_PRIORITY |
> > +                                  IODA2_LXIVT_NODE_ID);
> > +    server =3D GETFIELD(IODA2_LXIVT_SERVER, val);
> > +    prio =3D GETFIELD(IODA2_LXIVT_PRIORITY, val);
> > +
> > +    /*
> > +     * The low order 2 bits are the link pointer (Type II interrupts=
).
>=20
> I don't think we've currently implemented link pointers in our xics
> code.  Do we need to do that?

Not until somebody uses them (other than pHyp).

> > +     * Shift back to get a valid IRQ server.
> > +     */
> > +    server >>=3D 2;
> > +
> > +    ics_simple_write_xive(ics, idx, server, prio, prio);
> > +}
> > +
> > +static uint64_t *pnv_phb3_ioda_access(PnvPHB3 *phb,
> > +                                      unsigned *out_table, unsigned =
*out_idx)
> > +{
> > +    uint64_t adreg =3D phb->regs[PHB_IODA_ADDR >> 3];
> > +    unsigned int index =3D GETFIELD(PHB_IODA_AD_TADR, adreg);
> > +    unsigned int table =3D GETFIELD(PHB_IODA_AD_TSEL, adreg);
> > +    unsigned int mask;
> > +    uint64_t *tptr =3D NULL;
> > +
> > +    switch (table) {
> > +    case IODA2_TBL_LIST:
> > +        tptr =3D phb->ioda_LIST;
> > +        mask =3D 7;
>=20
> I'd suggest hex for the masks.

This is more readable when matched with the documentation but not a big
deal.

> > +        break;
> > +    case IODA2_TBL_LXIVT:
> > +        tptr =3D phb->ioda_LXIVT;
> > +        mask =3D 7;
> > +        break;
> > +    case IODA2_TBL_IVC_CAM:
> > +    case IODA2_TBL_RBA:
> > +        mask =3D 31;
> > +        break;
> > +    case IODA2_TBL_RCAM:
> > +        mask =3D 63;
> > +        break;
> > +    case IODA2_TBL_MRT:
> > +        mask =3D 7;
> > +        break;
> > +    case IODA2_TBL_PESTA:
> > +    case IODA2_TBL_PESTB:
> > +        mask =3D 255;
> > +        break;
> > +    case IODA2_TBL_TVT:
> > +        tptr =3D phb->ioda_TVT;
> > +        mask =3D 511;
> > +        break;
> > +    case IODA2_TBL_TCAM:
> > +    case IODA2_TBL_TDR:
> > +        mask =3D 63;
> > +        break;
> > +    case IODA2_TBL_M64BT:
> > +        tptr =3D phb->ioda_M64BT;
> > +        mask =3D 15;
> > +        break;
> > +    case IODA2_TBL_M32DT:
> > +        tptr =3D phb->ioda_MDT;
> > +        mask =3D 255;
> > +        break;
> > +    case IODA2_TBL_PEEV:
> > +        tptr =3D phb->ioda_PEEV;
> > +        mask =3D 3;
> > +        break;
> > +    default:
> > +        return NULL;
> > +    }
> > +    index &=3D mask;
>=20
> Do we want to silently mask, rather than logging an error if there's
> an access out of bounds for a particular table?

We could do both, as to behave like the HW but also flag an error. But
you have to be careful with the auto-increment below.

> > +    if (out_idx) {
> > +        *out_idx =3D index;
> > +    }
> > +    if (out_table) {
> > +        *out_table =3D table;
> > +    }
> > +    if (adreg & PHB_IODA_AD_AUTOINC) {
> > +        index =3D (index + 1) & mask;
> > +        adreg =3D SETFIELD(PHB_IODA_AD_TADR, adreg, index);
> > +    }
> > +    if (tptr) {
> > +        tptr +=3D index;
> > +    }
> > +    phb->regs[PHB_IODA_ADDR >> 3] =3D adreg;
> > +    return tptr;
> > +}

 ../..

> > +    if ((comp & mask) !=3D comp) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "IRQ compare bits not in mask: comp=3D0x%x mas=
k=3D0x%x",
> > +                      comp, mask);
> > +        comp &=3D mask;
> > +    }
> > +    /* Setup LSI offset */
> > +    ics->offset =3D comp + global;
>=20
> Oh.. changing ICS offset at runtime.  I hadn't considered that case..

As above, see further down.

> > +    /* Special case configuration data */
> > +    if ((off & 0xfffc) =3D=3D PHB_CONFIG_DATA) {
> > +        pnv_phb3_config_write(phb, off & 0x3, size, val);
> > +        return;
> > +    }
> > +
> > +    /* Other registers are 64-bit only */
> > +    if (size !=3D 8 || off & 0x7) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Invalid register access, offset: 0x%"PRIx64" =
size: %d",
> > +                      off, size);
> > +        return;
> > +    }
> > +
> > +    /* Handle masking */
> > +    switch (off) {
> > +    case PHB_M64_UPPER_BITS:
>=20
> Couldn't you handle this in the switch below - it should be ok to
> momentarily have the invalid bits set in your reg case, as long as you
> mask them before applying the side-effects, yes?

That felt easier that way ...

> That said... shouldn't you filter our invalid or read-only regs before
> updating the cache?

Well, I had a reason for doing it that way, I do have a vague memory of
that but I can't remember it now :-)

> > +/*
> > + * MSI/MSIX memory region implementation.
> > + * The handler handles both MSI and MSIX.
> > + */
> > +static void pnv_phb3_msi_write(void *opaque, hwaddr addr,
> > +                               uint64_t data, unsigned size)
> > +{
> > +    PnvPhb3DMASpace *ds =3D opaque;
> > +
> > +    /* Resolve PE# */
> > +    if (!pnv_phb3_resolve_pe(ds)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Failed to resolve PE# for bus @%p (%d) devfn =
0x%x",
> > +                      ds->bus, pci_bus_num(ds->bus), ds->devfn);
> > +        return;
> > +    }
> > +
> > +    pnv_phb3_msi_send(&ds->phb->msis, addr, data, ds->pe_num);
> > +}
> > +
> > +static const MemoryRegionOps pnv_phb3_msi_ops =3D {
> > +    /* There is no .read as the read result is undefined by PCI spec=
 */
>=20
> What will qemu do if it hits a NULL read here?  The behaviour may be
> undefind, but we'd prefer it didn't crash qemu..

Yeah.

> > +    .read =3D NULL,
> > +    .write =3D pnv_phb3_msi_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN
> > +};
> > +
> > +static AddressSpace *pnv_phb3_dma_iommu(PCIBus *bus, void *opaque, i=
nt devfn)
> > +{
> > +    PnvPHB3 *phb =3D opaque;
> > +    PnvPhb3DMASpace *ds;
> > +
> > +    QLIST_FOREACH(ds, &phb->dma_spaces, list) {
> > +        if (ds->bus =3D=3D bus && ds->devfn =3D=3D devfn) {
> > +            break;
> > +        }
> > +    }
> > +
> > +    if (ds =3D=3D NULL) {
> > +        ds =3D g_malloc0(sizeof(PnvPhb3DMASpace));
> > +        ds->bus =3D bus;
> > +        ds->devfn =3D devfn;
> > +        ds->pe_num =3D PHB_INVALID_PE;
> > +        ds->phb =3D phb;
> > +        memory_region_init_iommu(&ds->dma_mr, sizeof(ds->dma_mr),
> > +                                 TYPE_PNV_PHB3_IOMMU_MEMORY_REGION,
> > +                                 OBJECT(phb), "phb3_iommu", UINT64_M=
AX);
> > +        address_space_init(&ds->dma_as, MEMORY_REGION(&ds->dma_mr),
> > +                           "phb3_iommu");
> > +        memory_region_init_io(&ds->msi32_mr, OBJECT(phb), &pnv_phb3_=
msi_ops,
> > +                              ds, "msi32", 0x10000);
> > +        memory_region_init_io(&ds->msi64_mr, OBJECT(phb), &pnv_phb3_=
msi_ops,
> > +                              ds, "msi64", 0x100000);
> > +        pnv_phb3_update_msi_regions(ds);
> > +
> > +        QLIST_INSERT_HEAD(&phb->dma_spaces, ds, list);
> > +    }
> > +    return &ds->dma_as;
> > +}
> > +
> > +static void pnv_phb3_instance_init(Object *obj)
> > +{
> > +    PnvPHB3 *phb =3D PNV_PHB3(obj);
> > +
> > +    /* Create LSI source */
> > +    object_initialize(&phb->lsis, sizeof(phb->lsis), TYPE_ICS_SIMPLE=
);
> > +    object_property_add_child(obj, "ics-phb-lsi", OBJECT(&phb->lsis)=
, NULL);
> > +
> > +    /* Default init ... will be fixed by HW inits */
> > +    phb->lsis.offset =3D 0;
> > +
> > +    /* Create MSI source */
> > +    object_initialize(&phb->msis, sizeof(phb->msis), TYPE_PHB3_MSI);
> > +    object_property_add_const_link(OBJECT(&phb->msis), "phb", obj,
> > +                                   &error_abort);
> > +    object_property_add_child(obj, "ics-phb-msi", OBJECT(&phb->msis)=
, NULL);
> > +
> > +    /* Create PBCQ */
> > +    object_initialize(&phb->pbcq, sizeof(phb->pbcq), TYPE_PNV_PBCQ);
> > +    object_property_add_const_link(OBJECT(&phb->pbcq), "phb", obj,
> > +                                   &error_abort);
> > +    object_property_add_child(obj, "pbcq", OBJECT(&phb->pbcq), NULL)=
;
> > +
> > +    QLIST_INIT(&phb->dma_spaces);
> > +}
> > +
> > +/*
> > + * This could be done under pnv_pbcq_realize
> > + */
> > +static void pnv_phb3_pci_create(PnvPHB3 *phb, Error **errp)
> > +{
> > +    PCIHostState *pcih =3D PCI_HOST_BRIDGE(phb);
> > +    PCIDevice *brdev;
> > +    PCIDevice *pdev;
> > +    PCIBus *parent;
> > +    uint8_t chassis =3D phb->chip_id * 4 + phb->phb_id;
> > +    uint8_t chassis_nr =3D 128;
> > +
> > +    /* Add root complex */
> > +    pdev =3D pci_create(pcih->bus, 0, TYPE_PNV_PHB3_RC);
> > +    object_property_add_child(OBJECT(phb), "phb3-rc", OBJECT(pdev), =
NULL);
> > +    qdev_prop_set_uint8(DEVICE(pdev), "chassis", chassis);
> > +    qdev_prop_set_uint16(DEVICE(pdev), "slot", 1);
> > +    qdev_init_nofail(DEVICE(pdev));
> > +
> > +    /* Setup bus for that chip */
> > +    parent =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
> > +
> > +    brdev =3D pci_create(parent, 0, "pci-bridge");
>=20
> What is this pci bridge representing?  I know PCI-e PHBs typically
> have a pseudo P2P bridge right under them, but isn't that represnted
> by the root complex above?
>=20
> > +    object_property_add_child(OBJECT(parent), "pci-bridge", OBJECT(b=
rdev),
> > +                              NULL);
> > +    qdev_prop_set_uint8(DEVICE(brdev), PCI_BRIDGE_DEV_PROP_CHASSIS_N=
R,
> > +                        chassis_nr);
> > +    qdev_init_nofail(DEVICE(brdev));
> > +}
> > +
> > +static void pnv_phb3_realize(DeviceState *dev, Error **errp)
> > +{
> > +    PnvPHB3 *phb =3D PNV_PHB3(dev);
> > +    PCIHostState *pci =3D PCI_HOST_BRIDGE(dev);
> > +    Object *xics =3D OBJECT(qdev_get_machine());
> > +    Error *local_err =3D NULL;
> > +    int i;
> > +
> > +    memory_region_init(&phb->pci_mmio, OBJECT(phb), "pci-mmio",
> > +                       PCI_MMIO_TOTAL_SIZE);
> > +
> > +    /* PHB3 doesn't support IO space. However, qemu gets very upset =
if
> > +     * we don't have an IO region to anchor IO BARs onto so we just
> > +     * initialize one which we never hook up to anything
> > +     */
> > +    memory_region_init(&phb->pci_io, OBJECT(phb), "pci-io", 0x10000)=
;
> > +
> > +    memory_region_init_io(&phb->mr_regs, OBJECT(phb), &pnv_phb3_reg_=
ops, phb,
> > +                          "phb3-regs", 0x1000);
> > +
> > +    object_property_set_int(OBJECT(&phb->lsis), PNV_PHB3_NUM_LSI, "n=
r-irqs",
> > +                            &error_abort);
> > +    object_property_add_const_link(OBJECT(&phb->lsis), "xics", xics,
> > +                                   &error_abort);
> > +    object_property_set_bool(OBJECT(&phb->lsis), true, "realized", &=
local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    for (i =3D 0; i < PNV_PHB3_NUM_LSI; i++) {
> > +        ics_set_irq_type(&phb->lsis, i, true);
> > +    }
> > +
> > +    object_property_add_const_link(OBJECT(&phb->msis), "xics", xics,
> > +                                   &error_abort);
> > +    object_property_set_int(OBJECT(&phb->msis), PHB3_MAX_MSI, "nr-ir=
qs",
> > +                            &error_abort);
> > +    object_property_set_bool(OBJECT(&phb->msis), true, "realized", &=
local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    object_property_set_bool(OBJECT(&phb->pbcq), true, "realized", &=
local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    pci->bus =3D pci_register_root_bus(dev, "phb3-root-bus",
> > +                                pnv_phb3_set_irq, pnv_phb3_map_irq, =
phb,
> > +                                &phb->pci_mmio, &phb->pci_io,
> > +                                0, 4, TYPE_PNV_PHB3_ROOT_BUS);
> > +    pci_setup_iommu(pci->bus, pnv_phb3_dma_iommu, phb);
> > +
> > +    /* Setup the PCI busses */
> > +    pnv_phb3_pci_create(phb, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +}
> > +
> > +void pnv_phb3_update_regions(PnvPHB3 *phb)
> > +{
> > +    PnvPBCQState *pbcq =3D &phb->pbcq;
> > +
> > +    /* Unmap first always */
> > +    if (phb->regs_mapped) {
> > +        memory_region_del_subregion(&pbcq->phbbar, &phb->mr_regs);
> > +        phb->regs_mapped =3D false;
> > +    }
> > +
> > +    /* Map registers if enabled */
> > +    if (pbcq->phb_mapped) {
> > +        /* XXX We should use the PHB BAR 2 register but we don't ...=
 */
> > +        memory_region_add_subregion(&pbcq->phbbar, 0, &phb->mr_regs)=
;
> > +        phb->regs_mapped =3D true;
> > +    }
> > +
> > +    /* Check/update m32 */
> > +    if (phb->m32_mapped) {
> > +        pnv_phb3_check_m32(phb);
> > +    }
> > +}
> > +
> > +static const char *pnv_phb3_root_bus_path(PCIHostState *host_bridge,
> > +                                          PCIBus *rootbus)
> > +{
> > +    PnvPHB3 *phb =3D PNV_PHB3(host_bridge);
> > +
> > +    snprintf(phb->bus_path, sizeof(phb->bus_path), "00%02x:%02x",
> > +             phb->chip_id, phb->phb_id);
> > +    return phb->bus_path;
> > +}
> > +
> > +static void pnv_phb3_get_phb_id(Object *obj, Visitor *v, const char =
*name,
> > +                              void *opaque, Error **errp)
> > +{
> > +    Property *prop =3D opaque;
> > +    uint32_t *ptr =3D qdev_get_prop_ptr(DEVICE(obj), prop);
> > +
> > +    visit_type_uint32(v, name, ptr, errp);
> > +}
> > +
> > +static void pnv_phb3_set_phb_id(Object *obj, Visitor *v, const char =
*name,
> > +                              void *opaque, Error **errp)
> > +{
> > +    PnvPHB3 *phb =3D PNV_PHB3(obj);
> > +    uint32_t phb_id;
> > +    Error *local_err =3D NULL;
> > +
> > +    visit_type_uint32(v, name, &phb_id, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Limit to a maximum of 6 PHBs per chip
> > +     */
> > +    if (phb_id >=3D PNV8_CHIP_PHB3_MAX) {
> > +        error_setg(errp, "invalid PHB index: '%d'", phb_id);
> > +        return;
> > +    }
> > +
> > +    phb->phb_id =3D phb_id;
> > +}
> > +
> > +static const PropertyInfo pnv_phb3_phb_id_propinfo =3D {
> > +    .name =3D "irq",
> > +    .get =3D pnv_phb3_get_phb_id,
> > +    .set =3D pnv_phb3_set_phb_id,
> > +};
>=20
> Can't you use a static DeviceProps style property for this, which is a
> bit simpler?
>=20
> > +    /*
> > +     * The low order 2 bits are the link pointer (Type II interrupts=
).
> > +     * Shift back to get a valid IRQ server.
> > +     */
> > +    server >>=3D 2;
> > +
> > +    switch (pq) {
> > +    case 0: /* 00 */
> > +        if (prio =3D=3D 0xff) {
> > +            /* Masked, set Q */
> > +            phb3_msi_set_q(msi, srcno);
> > +        } else {
> > +            /* Enabled, set P and send */
> > +            phb3_msi_set_p(msi, srcno, gen);
> > +            icp_irq(ics, server, srcno + ics->offset, prio);
>=20
> Can't you just pulse the right qirq here, which will use the core ICS
> logic to propagate to the ICP?

Ok, interrupts ... sooooo...

This code predates a pile of XICS work you guys did to start with.

Now, this is an ICS subclass, so why shouldn't it directly poke at the
target ICP ? It's an alternate to the normal ICS since it behaves a bit
differently (PQ bits & all).

Cheers,
Ben.
