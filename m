Received: from eggs.gnu.org ([2001:4830:134:3::10]:36728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciTee-0004kZ-Ny
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciTeb-00072z-Is
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:20:28 -0500
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:37903)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciTeb-00072U-9M
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:20:25 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id AB423B3614
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 23:20:23 +0100 (CET)
Date: Mon, 27 Feb 2017 23:20:16 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170227232016.6eb9cf51@bahia.lan>
In-Reply-To: <148776029578.5865.5785337570950575739.stgit@bahia>
References: <148776029578.5865.5785337570950575739.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/X_=Uc.sKtE2qYVH+sFUifoK";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr/pci: populate PCI DT in
 reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org

--Sig_/X_=Uc.sKtE2qYVH+sFUifoK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

David,

Any chances to have this in 2.9 ?

On Wed, 22 Feb 2017 11:56:53 +0100
Greg Kurz <groug@kaod.org> wrote:

> From: Greg Kurz <gkurz@linux.vnet.ibm.com>
>=20
> Since commit 1d2d974244c6 "spapr_pci: enumerate and add PCI device tree",=
 QEMU
> populates the PCI device tree in the opposite order compared to SLOF.
>=20
> Before 1d2d974244c6:
>=20
> Populating /pci@800000020000000
>                      00 0000 (D) : 1af4 1000    virtio [ net ]
>                      00 0800 (D) : 1af4 1001    virtio [ block ]
>                      00 1000 (D) : 1af4 1009    virtio [ network ]
> Populating /pci@800000020000000/unknown-legacy-device@2
>=20
> 7e5294b8 :  /pci@800000020000000
> 7e52b998 :  |-- ethernet@0
> 7e52c0c8 :  |-- scsi@1
> 7e52c7e8 :  +-- unknown-legacy-device@2 ok
>=20
> Since 1d2d974244c6:
>=20
> Populating /pci@800000020000000
>                      00 1000 (D) : 1af4 1009    virtio [ network ]
> Populating /pci@800000020000000/unknown-legacy-device@2
>                      00 0800 (D) : 1af4 1001    virtio [ block ]
>                      00 0000 (D) : 1af4 1000    virtio [ net ]
>=20
> 7e5e8118 :  /pci@800000020000000
> 7e5ea6a0 :  |-- unknown-legacy-device@2
> 7e5eadb8 :  |-- scsi@1
> 7e5eb4d8 :  +-- ethernet@0 ok
>=20
> This behaviour change is not actually a bug since no assumptions should be
> made on DT ordering. But it has no real justification either, other than
> being the consequence of the way fdt_add_subnode() inserts new elements
> to the front of the FDT rather than adding them to the tail.
>=20
> This patch reverts to the historical SLOF ordering by walking PCI devices
> in reverse order. This reconciles pseries with x86 machine types behavior.
> It is expected to make things easier when porting existing applications to
> power.
>=20
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> (slight update to the changelog)
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/pci/pci.c         |   28 ++++++++++++++++++++++++++++
>  hw/ppc/spapr_pci.c   |   12 ++++++------
>  include/hw/pci/pci.h |    4 ++++
>  3 files changed, 38 insertions(+), 6 deletions(-)
>=20
> David,
>=20
> This patch was posted and already discussed during 2.5 development:
>=20
> http://patchwork.ozlabs.org/patch/549925/
>=20
> The "consensus" at the time was that guests should not rely on device
> ordering (i.e. use persistent naming instead).
>=20
> I got recently contacted by OpenStack people who had several complaints
> about the reverse ordering of PCI devices in pseries: different behavior
> between ppc64 and x86, lots of time spent in debugging when porting
> applications from x86 to ppc64 before realizing that it is caused by the
> reverse ordering, necessity to carry hacky workarounds...
>=20
> One strong argument against handling this properly with persistent naming
> is that it requires systemd/udev. This option is considered as painful
> with CirrOS, which aims at remaining as minimal as possible and is widely
> used in the OpenStack ecosystem.
>=20
> Would you re-consider your position and apply this patch ?
>=20
> Cheers.
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index a563555e7da7..273f1e46025a 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1530,6 +1530,34 @@ static const pci_class_desc pci_class_descriptions=
[] =3D
>      { 0, NULL}
>  };
> =20
> +static void pci_for_each_device_under_bus_reverse(PCIBus *bus,
> +                                                  void (*fn)(PCIBus *b,
> +                                                             PCIDevice *=
d,
> +                                                             void *opaqu=
e),
> +                                                  void *opaque)
> +{
> +    PCIDevice *d;
> +    int devfn;
> +
> +    for (devfn =3D 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
> +        d =3D bus->devices[ARRAY_SIZE(bus->devices) - 1 - devfn];
> +        if (d) {
> +            fn(bus, d, opaque);
> +        }
> +    }
> +}
> +
> +void pci_for_each_device_reverse(PCIBus *bus, int bus_num,
> +                         void (*fn)(PCIBus *b, PCIDevice *d, void *opaqu=
e),
> +                         void *opaque)
> +{
> +    bus =3D pci_find_bus_nr(bus, bus_num);
> +
> +    if (bus) {
> +        pci_for_each_device_under_bus_reverse(bus, fn, opaque);
> +    }
> +}
> +
>  static void pci_for_each_device_under_bus(PCIBus *bus,
>                                            void (*fn)(PCIBus *b, PCIDevic=
e *d,
>                                                       void *opaque),
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index fd6fc1d95344..2a20c2a140fc 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1782,9 +1782,9 @@ static void spapr_populate_pci_devices_dt(PCIBus *b=
us, PCIDevice *pdev,
>      s_fdt.fdt =3D p->fdt;
>      s_fdt.node_off =3D offset;
>      s_fdt.sphb =3D p->sphb;
> -    pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
> -                        spapr_populate_pci_devices_dt,
> -                        &s_fdt);
> +    pci_for_each_device_reverse(sec_bus, pci_bus_num(sec_bus),
> +                                spapr_populate_pci_devices_dt,
> +                                &s_fdt);
>  }
> =20
>  static void spapr_phb_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
> @@ -1953,9 +1953,9 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>      s_fdt.fdt =3D fdt;
>      s_fdt.node_off =3D bus_off;
>      s_fdt.sphb =3D phb;
> -    pci_for_each_device(bus, pci_bus_num(bus),
> -                        spapr_populate_pci_devices_dt,
> -                        &s_fdt);
> +    pci_for_each_device_reverse(bus, pci_bus_num(bus),
> +                                spapr_populate_pci_devices_dt,
> +                                &s_fdt);
> =20
>      ret =3D spapr_drc_populate_dt(fdt, bus_off, OBJECT(phb),
>                                  SPAPR_DR_CONNECTOR_TYPE_PCI);
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 6983f13745a5..9349acbfb278 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -429,6 +429,10 @@ int pci_bus_numa_node(PCIBus *bus);
>  void pci_for_each_device(PCIBus *bus, int bus_num,
>                           void (*fn)(PCIBus *bus, PCIDevice *d, void *opa=
que),
>                           void *opaque);
> +void pci_for_each_device_reverse(PCIBus *bus, int bus_num,
> +                                 void (*fn)(PCIBus *bus, PCIDevice *d,
> +                                            void *opaque),
> +                                 void *opaque);
>  void pci_for_each_bus_depth_first(PCIBus *bus,
>                                    void *(*begin)(PCIBus *bus, void *pare=
nt_state),
>                                    void (*end)(PCIBus *bus, void *state),
>=20
>=20


--Sig_/X_=Uc.sKtE2qYVH+sFUifoK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli0piAACgkQAvw66wEB28IWbACggdlsV41ogchGnOf2ndeqcv4Z
H18Ani8JjxAguURbBHl7adE2ON3yUMl6
=QmI+
-----END PGP SIGNATURE-----

--Sig_/X_=Uc.sKtE2qYVH+sFUifoK--
