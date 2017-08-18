Received: from eggs.gnu.org ([2001:4830:134:3::10]:40793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diWTf-0003kY-C7
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 21:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diWTc-0000c0-8G
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 21:53:35 -0400
Date: Fri, 18 Aug 2017 11:53:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170818015321.GN5509@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<0362ffdbfb08b46edef0e2180387078299a9b721.1502643878.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9Jdw4pA1x1k2W7MG"
Content-Disposition: inline
In-Reply-To: <0362ffdbfb08b46edef0e2180387078299a9b721.1502643878.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [RFC PATCH 09/12] ppc440: Add emulation of
 plb-pcix controller found in some 440 SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--9Jdw4pA1x1k2W7MG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:

You know I'm going to say it, right: needs a commit message.

What's a "plb-pcix", and what's an example of a 440 SoCs which has it.

This is basically a new device, so I'm pretty willing to merge for
2.11 with minimal review once rebased with the rest of the series.

Couple of comments below

[snip]
> +static void ppc440_pcix_reset(DeviceState *dev)
> +{
> +    struct PPC440PCIXState *s =3D PPC440_PCIX_HOST_BRIDGE(dev);
> +    int i;
> +
> +    memset(s->pom, 0, sizeof(s->pom));
> +    memset(s->pim, 0, sizeof(s->pim));

Is it safe to just memset() the memory region objects within the
pim/pom arrays without cleaning them up?  I'm guessing not..

> +    for (i =3D 0; i < PPC440_PCIX_NR_PIMS; i++) {
> +        s->pim[i].sa =3D 0xffffffff00000000ULL;
> +    }
> +    s->sts =3D 0;
> +}
> +
> +/* All pins from each slot are tied to a single board IRQ.
> + * This may need further refactoring for other boards. */
> +static int ppc440_pcix_map_irq(PCIDevice *pci_dev, int irq_num)
> +{
> +    int slot =3D pci_dev->devfn >> 3;
> +
> +    DPRINTF("%s: devfn %x irq %d -> %d\n", __func__,
> +            pci_dev->devfn, irq_num, slot);
> +
> +    return slot - 1;
> +}
> +
> +static void ppc440_pcix_set_irq(void *opaque, int irq_num, int level)
> +{
> +    qemu_irq *pci_irqs =3D opaque;
> +
> +    DPRINTF("%s: PCI irq %d\n", __func__, irq_num);
> +    if (irq_num < 0) {
> +        fprintf(stderr, "%s: PCI irq %d\n", __func__, irq_num);

Use report_error() please.

> +        return;
> +    }
> +    qemu_set_irq(pci_irqs[irq_num], level);
> +}
> +
> +static AddressSpace *ppc440_pcix_set_iommu(PCIBus *b, void *opaque, int =
devfn)
> +{
> +    PPC440PCIXState *s =3D opaque;
> +
> +    return &s->bm_as;
> +}
> +
> +static int ppc440_pcix_initfn(SysBusDevice *dev)
> +{
> +    PPC440PCIXState *s;
> +    PCIHostState *h;
> +    int i;
> +
> +    h =3D PCI_HOST_BRIDGE(dev);
> +    s =3D PPC440_PCIX_HOST_BRIDGE(dev);
> +
> +    for (i =3D 0; i < ARRAY_SIZE(s->irq); i++) {
> +        sysbus_init_irq(dev, &s->irq[i]);
> +    }
> +
> +    memory_region_init(&s->busmem, OBJECT(dev), "pci bus memory", UINT64=
_MAX);
> +    h->bus =3D pci_register_bus(DEVICE(dev), NULL, ppc440_pcix_set_irq,
> +                         ppc440_pcix_map_irq, s->irq, &s->busmem,
> +                         get_system_io(), PCI_DEVFN(0, 0), 4, TYPE_PCI_B=
US);
> +
> +    s->dev =3D pci_create_simple(h->bus, PCI_DEVFN(0, 0), "ppc4xx-host-b=
ridge");
> +
> +    memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", UINT64_MAX);
> +    memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
> +    address_space_init(&s->bm_as, &s->bm, "pci-bm");
> +    pci_setup_iommu(h->bus, ppc440_pcix_set_iommu, s);
> +
> +    memory_region_init(&s->container, OBJECT(s), "pci-container", PCI_AL=
L_SIZE);
> +    memory_region_init_io(&h->conf_mem, OBJECT(s), &pci_host_conf_le_ops=
, h,
> +                          "pci-conf-idx", 4);
> +    memory_region_init_io(&h->data_mem, OBJECT(s), &pci_host_data_le_ops=
, h,
> +                          "pci-conf-data", 4);
> +    memory_region_init_io(&s->iomem, OBJECT(s), &pci_reg_ops, s,
> +                          "pci.reg", PPC440_REG_SIZE);
> +    memory_region_add_subregion(&s->container, PCIC0_CFGADDR, &h->conf_m=
em);
> +    memory_region_add_subregion(&s->container, PCIC0_CFGDATA, &h->data_m=
em);
> +    memory_region_add_subregion(&s->container, PPC440_REG_BASE, &s->iome=
m);
> +    sysbus_init_mmio(dev, &s->container);
> +
> +    return 0;
> +}
> +
> +static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
> +{
> +    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    k->init =3D ppc440_pcix_initfn;
> +    dc->reset =3D ppc440_pcix_reset;
> +}
> +
> +static const TypeInfo ppc440_pcix_info =3D {
> +    .name          =3D TYPE_PPC440_PCIX_HOST_BRIDGE,
> +    .parent        =3D TYPE_PCI_HOST_BRIDGE,
> +    .instance_size =3D sizeof(PPC440PCIXState),
> +    .class_init    =3D ppc440_pcix_class_init,
> +};
> +
> +static void ppc440_pcix_register_types(void)
> +{
> +    type_register_static(&ppc440_pcix_info);
> +}
> +
> +type_init(ppc440_pcix_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9Jdw4pA1x1k2W7MG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmWSJEACgkQbDjKyiDZ
s5JIdhAAnNft3pfwrS8hGJ4MbZRvnvExjc4cInr4o9D0N/ooYobhDmcMiqOgkcts
kaj+EO/SutwlTMRgWl5VX3NXwKxatlE5sbM7xVK3T4r0tF5SFRSdZxeC8YkDuSPa
PXqw18tO4VnLV8q5zN67NkqT3wd19CjUF3+qW2rH+FZBPE3G4KzxUeORJEk8VVIs
gd1gI107C9z81DtyGryUBQloxjG1YfGFHkxjSoSwdxm/1d74kOgmpEJS2JnBzwuN
yselhF1aZ49IeV26shKgIcuv7luCM/E+hpTd3sKIDMO4wia3GMoCj82UBF1K1tDR
Qq3PmhSMQjAtqfpGXHXbh/CbVlnpbBpkUoa2u4ERTexAUqiYsyonLQUAcMbDwOpb
3mX74CVFBGtSuGb2IRd37VfRGM9o4lCcDtBohwqKEUBqRbhu1H6SolFBcaxxan7f
avsNh9JNAECvx+P6LCtDA128UGKJSmqhDyi4qydZHfFMsRx+2knsHAb4quqnNEkg
Fqfve8M2S5jT157bkCyKM819plorp1fsrk2MqDtSJidIoH9NvsNg4OM+BGrwA1nd
1JoFpScOAmExP4pijK6T1J27ttkrRQPiuvBYaa82+V8JzEM4a86g7gdgaY6zut9w
2pvwXBcRGad/xD3tJnuIuaIzG+Y4vX0C552r73AB6rhl9Ncrqak=
=RVx1
-----END PGP SIGNATURE-----

--9Jdw4pA1x1k2W7MG--
