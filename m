Received: from eggs.gnu.org ([2001:4830:134:3::10]:35991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhwHF-0005Da-8Z
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhwHB-0006RE-Sh
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:18:53 -0400
Received: from 14.mo1.mail-out.ovh.net ([178.32.97.215]:57959)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fhwHB-0006Mg-Fv
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:18:49 -0400
Received: from player737.ha.ovh.net (unknown [10.109.160.93])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 9750A115934
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 14:18:39 +0200 (CEST)
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f6500bf1-792b-aba5-9deb-adc3303eeee7@kaod.org>
Date: Tue, 24 Jul 2018 14:18:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180718061230.GE2102@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hello,

>From the discussion on the XICS MSI object, I gather that exporting
icp_irq is fine.=20

Some more comments below, I have tried to answer the parts that were=20
not addressed yet.=20

[ ... ]

>> +/*
>> + * The CONFIG_DATA register expects little endian accesses, but as th=
e
>> + * region is big endian, we have to swap the value.
>> + */
>> +static void pnv_phb3_config_write(PnvPHB3 *phb, unsigned off,
>> +                                  unsigned size, uint64_t val)
>> +{
>> +    uint32_t cfg_addr, limit;
>> +    PCIDevice *pdev;
>> +
>> +    pdev =3D pnv_phb3_find_cfg_dev(phb);
>> +    if (!pdev) {
>> +        return;
>> +    }
>> +    cfg_addr =3D (phb->regs[PHB_CONFIG_ADDRESS >> 3] >> 32) & 0xfff;
>> +    cfg_addr |=3D off;
>=20
> This looks weird - there are callers of this that appear to have low
> bits in 'off', then you're ORing it with overlapping low bits.

Here is an extract of the specs of the PHB_CONFIG_ADDRESS register :

  20:29 Register Number(00:09) RW 0

  Register Number to use for the configuration cycle access.=20

  30:31 Register Number(10:11) RO 0

  Don=92t Cares. The value written will be dropped, and zeros are
  always returned for a read. =20

So, yes, we shoud be using 0xffc, just like in read.

>> +    limit =3D pci_config_size(pdev);
>> +    if (limit <=3D cfg_addr) {
>> +        /* conventional pci device can be behind pcie-to-pci bridge.
>> +           256 <=3D addr < 4K has no effects. */
>> +        return;
>> +    }
>> +    switch (size) {
>> +    case 1:
>> +        break;
>> +    case 2:
>> +        val =3D bswap16(val);
>> +        break;
>> +    case 4:
>> +        val =3D bswap32(val);
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +    pci_host_config_write_common(pdev, cfg_addr, limit, val, size);
>> +}
>> +
>> +static uint64_t pnv_phb3_config_read(PnvPHB3 *phb, unsigned off,
>> +                                     unsigned size)
>> +{
>> +    uint32_t cfg_addr, limit;
>> +    PCIDevice *pdev;
>> +    uint64_t val;
>> +
>> +    pdev =3D pnv_phb3_find_cfg_dev(phb);
>> +    if (!pdev) {
>> +        return ~0ull;
>> +    }
>> +    cfg_addr =3D (phb->regs[PHB_CONFIG_ADDRESS >> 3] >> 32) & 0xffc;
>> +    cfg_addr |=3D off;
>=20
> This looks better, should it be 0xffc in the write path as well?

yes.

>> +    limit =3D pci_config_size(pdev);
>> +    if (limit <=3D cfg_addr) {
>> +        /* conventional pci device can be behind pcie-to-pci bridge.
>> +           256 <=3D addr < 4K has no effects. */
>> +        return ~0ull;
>> +    }
>> +    val =3D pci_host_config_read_common(pdev, cfg_addr, limit, size);
>> +    switch (size) {
>> +    case 1:
>> +        return val;
>> +    case 2:
>> +        return bswap16(val);
>> +    case 4:
>> +        return bswap32(val);
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +static void pnv_phb3_check_m32(PnvPHB3 *phb)
>> +{
>> +    uint64_t base, start, size;
>> +    MemoryRegion *parent;
>> +    PnvPBCQState *pbcq =3D &phb->pbcq;
>> +
>> +    if (phb->m32_mapped) {
>> +        memory_region_del_subregion(phb->mr_m32.container, &phb->mr_m=
32);
>> +        phb->m32_mapped =3D false;
>=20
> Could you use memory_region_set_enabled() rather than having to add
> and delete the subregion and keep track of it in this separate
> variable?

pnv_phb3_check_m32/m64 remap the regions.=20

[ ... ]

>> +    case IODA2_TBL_PEEV:
>> +        tptr =3D phb->ioda_PEEV;
>> +        mask =3D 3;
>> +        break;
>> +    default:
>> +        return NULL;
>> +    }
>> +    index &=3D mask;
>=20
> Do we want to silently mask, rather than logging an error if there's
> an access out of bounds for a particular table?

I will add an error.

[ ... ]

>> +    /* Handle masking */
>> +    switch (off) {
>> +    case PHB_M64_UPPER_BITS:
>=20
> Couldn't you handle this in the switch below - it should be ok to
> momentarily have the invalid bits set in your reg case, as long as you
> mask them before applying the side-effects, yes?

yes.

> That said... shouldn't you filter our invalid or read-only regs before
> updating the cache?

hmm, the current model relies on the fact that some registers have
their value implicitly updated. But I guess, we can dump which are
accessed and implement a default behavior for these. I will take a
look.

[ ... ]

>> +static const MemoryRegionOps pnv_phb3_msi_ops =3D {
>> +    /* There is no .read as the read result is undefined by PCI spec =
*/
>=20
> What will qemu do if it hits a NULL read here?  The behaviour may be
> undefind, but we'd prefer it didn't crash qemu..

I will add one with a standard error message. It is better to have
some output anyway.

[ ... ]

>> +static void pnv_phb3_pci_create(PnvPHB3 *phb, Error **errp)
>> +{
>> +    PCIHostState *pcih =3D PCI_HOST_BRIDGE(phb);
>> +    PCIDevice *brdev;
>> +    PCIDevice *pdev;
>> +    PCIBus *parent;
>> +    uint8_t chassis =3D phb->chip_id * 4 + phb->phb_id;
>> +    uint8_t chassis_nr =3D 128;
>> +
>> +    /* Add root complex */
>> +    pdev =3D pci_create(pcih->bus, 0, TYPE_PNV_PHB3_RC);
>> +    object_property_add_child(OBJECT(phb), "phb3-rc", OBJECT(pdev), N=
ULL);
>> +    qdev_prop_set_uint8(DEVICE(pdev), "chassis", chassis);
>> +    qdev_prop_set_uint16(DEVICE(pdev), "slot", 1);
>> +    qdev_init_nofail(DEVICE(pdev));
>> +
>> +    /* Setup bus for that chip */
>> +    parent =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
>> +
>> +    brdev =3D pci_create(parent, 0, "pci-bridge");
>=20
> What is this pci bridge representing?  I know PCI-e PHBs typically
> have a pseudo P2P bridge right under them, but isn't that represnted
> by the root complex above?

This is the legacy pci bridge under the pcie bus.=20

Here is is the qdev hierarchy :

  dev: pnv-phb3, id ""
    index =3D 0 (0x0)
    chip-id =3D 0 (0x0)
    bus: phb3-root-bus
      type pnv-phb3-root-bus
      dev: pnv-phb3-rc, id ""
        power_controller_present =3D true
        chassis =3D 0 (0x0)
        slot =3D 1 (0x1)
        port =3D 0 (0x0)
        aer_log_max =3D 8 (0x8)
        addr =3D 00.0
        romfile =3D ""
        rombar =3D 1 (0x1)
        multifunction =3D false
        command_serr_enable =3D true
        x-pcie-lnksta-dllla =3D true
        x-pcie-extcap-init =3D true
        class PCI bridge, addr 00:00.0, pci id 1014:03dc (sub 0000:0000)
        bus: pcie.0
          type PCIE
          dev: pci-bridge, id ""
            chassis_nr =3D 128 (0x80)
            msi =3D "off"
            shpc =3D false
            addr =3D 00.0
            romfile =3D ""
            rombar =3D 1 (0x1)
            multifunction =3D false
            command_serr_enable =3D true
            x-pcie-lnksta-dllla =3D true
            x-pcie-extcap-init =3D true
            class PCI bridge, addr 00:00.0, pci id 1b36:0001 (sub 0000:00=
00)
            bus: pci.0
              type PCI

[ ... ]

>> +static const PropertyInfo pnv_phb3_phb_id_propinfo =3D {
>> +    .name =3D "irq",
>> +    .get =3D pnv_phb3_get_phb_id,
>> +    .set =3D pnv_phb3_set_phb_id,
>> +};
>=20
> Can't you use a static DeviceProps style property for this, which is a
> bit simpler?

OK. We will address user creatable PHBs in some other way. Most
certainly in the realize routine like you suggested.

Thanks,

C.=20
