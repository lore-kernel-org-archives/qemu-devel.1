Received: from eggs.gnu.org ([2001:4830:134:3::10]:46375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct5JJ-0001rf-Fq
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct5JH-0003b2-QJ
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:34:17 -0400
Date: Wed, 29 Mar 2017 15:07:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170329040713.GU21068@umbus.fritz.box>
References: <20170328021651.19350-1-david@gibson.dropbear.id.au>
	<20170328021651.19350-4-david@gibson.dropbear.id.au>
	<72226418-5022-1ccc-9af4-6fce295db7d4@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iBHcHRCIarfY7C0j"
Content-Disposition: inline
In-Reply-To: <72226418-5022-1ccc-9af4-6fce295db7d4@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC for-2.10 3/3] pseries: Allow PCIe virtio and
 XHCI on pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: ehabkost@redhat.com, marcel@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lersek@redhat.com


--iBHcHRCIarfY7C0j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 01:20:50PM +1100, Alexey Kardashevskiy wrote:
> On 28/03/17 13:16, David Gibson wrote:
> > pseries now allows PCIe devices (both emulated and VFIO), although its
> > PCI bus is in most respects a plain PCI bus - this uses paravirtualized
> > access methods to PCIe extended config space defined in the PAPR spec.
> >=20
> > However, because the bus is not PCIe, it means that virtio-pci and XHCI
> > devices will present themselves as plain PCI rather than PCIe, which wo=
uld
> > be preferable.
> >=20
> > This patch uses the new hook to override the behaviour for such PCI/PCIe
> > "hybrid" devices to allow PCIe virtio-pci and XHCI on pseries.
>=20
>=20
> Not clear what all these tests/virtio-*.c changes are for and why here -
> does "make check" break if you do not enforce disable-legacy=3Doff?

Yes it does.  There's an explanation in the 0/3 message.

> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_pci.c       | 9 +++++++++
> >  tests/virtio-9p-test.c   | 2 +-
> >  tests/virtio-blk-test.c  | 4 ++--
> >  tests/virtio-net-test.c  | 2 +-
> >  tests/virtio-scsi-test.c | 2 +-
> >  5 files changed, 14 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 98c52e4..7686f7f 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1979,6 +1979,14 @@ static const char *spapr_phb_root_bus_path(PCIHo=
stState *host_bridge,
> >      return sphb->dtbusname;
> >  }
> > =20
> > +static bool spapr_phb_allow_hybrid_pcie(PCIHostState *host_bridge,
> > +                                        PCIDevice *pci_dev)
> > +{
> > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(host_bridge);
> > +
> > +    return sphb->pcie_ecs;
> > +}
> > +
> >  static void spapr_phb_class_init(ObjectClass *klass, void *data)
> >  {
> >      PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);
> > @@ -1986,6 +1994,7 @@ static void spapr_phb_class_init(ObjectClass *kla=
ss, void *data)
> >      HotplugHandlerClass *hp =3D HOTPLUG_HANDLER_CLASS(klass);
> > =20
> >      hc->root_bus_path =3D spapr_phb_root_bus_path;
> > +    hc->allow_hybrid_pcie =3D spapr_phb_allow_hybrid_pcie;
> >      dc->realize =3D spapr_phb_realize;
> >      dc->props =3D spapr_phb_properties;
> >      dc->reset =3D spapr_phb_reset;
> > diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
> > index 43a1ad8..ae0d51e 100644
> > --- a/tests/virtio-9p-test.c
> > +++ b/tests/virtio-9p-test.c
> > @@ -32,7 +32,7 @@ static QVirtIO9P *qvirtio_9p_start(const char *driver)
> >  {
> >      const char *arch =3D qtest_get_arch();
> >      const char *cmd =3D "-fsdev local,id=3Dfsdev0,security_model=3Dnon=
e,path=3D%s "
> > -                      "-device %s,fsdev=3Dfsdev0,mount_tag=3D%s";
> > +                      "-device %s,fsdev=3Dfsdev0,mount_tag=3D%s,disabl=
e-legacy=3Doff";
> >      QVirtIO9P *v9p =3D g_new0(QVirtIO9P, 1);
> > =20
> >      v9p->test_share =3D g_strdup("/tmp/qtest.XXXXXX");
> > diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
> > index 1eee95d..5fb7882 100644
> > --- a/tests/virtio-blk-test.c
> > +++ b/tests/virtio-blk-test.c
> > @@ -65,7 +65,7 @@ static QOSState *pci_test_start(void)
> >      const char *cmd =3D "-drive if=3Dnone,id=3Ddrive0,file=3D%s,format=
=3Draw "
> >                        "-drive if=3Dnone,id=3Ddrive1,file=3D/dev/null,f=
ormat=3Draw "
> >                        "-device virtio-blk-pci,id=3Ddrv0,drive=3Ddrive0=
,"
> > -                      "addr=3D%x.%x";
> > +                      "addr=3D%x.%x,disable-legacy=3Doff";
> > =20
> >      tmp_path =3D drive_create();
> > =20
> > @@ -656,7 +656,7 @@ static void pci_hotplug(void)
> > =20
> >      /* plug secondary disk */
> >      qpci_plug_device_test("virtio-blk-pci", "drv1", PCI_SLOT_HP,
> > -                          "'drive': 'drive1'");
> > +                          "'drive': 'drive1', 'disable-legacy': 'off'"=
);
> > =20
> >      dev =3D virtio_blk_pci_init(qs->pcibus, PCI_SLOT_HP);
> >      g_assert(dev);
> > diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
> > index 8f94360..a35d87b 100644
> > --- a/tests/virtio-net-test.c
> > +++ b/tests/virtio-net-test.c
> > @@ -55,7 +55,7 @@ static QOSState *pci_test_start(int socket)
> >  {
> >      const char *arch =3D qtest_get_arch();
> >      const char *cmd =3D "-netdev socket,fd=3D%d,id=3Dhs0 -device "
> > -                      "virtio-net-pci,netdev=3Dhs0";
> > +                      "virtio-net-pci,netdev=3Dhs0,disable-legacy=3Dof=
f";
> > =20
> >      if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D=
 0) {
> >          return qtest_pc_boot(cmd, socket);
> > diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
> > index 0eabd56..5a802d9 100644
> > --- a/tests/virtio-scsi-test.c
> > +++ b/tests/virtio-scsi-test.c
> > @@ -36,7 +36,7 @@ static QOSState *qvirtio_scsi_start(const char *extra=
_opts)
> >  {
> >      const char *arch =3D qtest_get_arch();
> >      const char *cmd =3D "-drive id=3Ddrv0,if=3Dnone,file=3D/dev/null,f=
ormat=3Draw "
> > -                      "-device virtio-scsi-pci,id=3Dvs0 "
> > +                      "-device virtio-scsi-pci,id=3Dvs0,disable-legacy=
=3Doff "
> >                        "-device scsi-hd,bus=3Dvs0.0,drive=3Ddrv0 %s";
> > =20
> >      if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D=
 0) {
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iBHcHRCIarfY7C0j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2zLvAAoJEGw4ysog2bOSC1YQAJEt6Hy5zUUD4NI9SV5pg3Is
3xUs0zaqhTbThPiEQxBF29uce2QeikEfi9i+U/EQjFHJBONkU2XwQ8vWAEeg8dPG
2tZpbGo05A0MfBhnekc8R45zKe4uQK+q/zdmtqRqdmJAlwlaWGbbSKdhPYBL6G8j
sklQDFEQJ8rGsuVjXEAljmwgsX2FAXjwmerST+38QtAhP3ypWfbvOly4sYpSVO4H
twc0EDEKXNU4avp8fZi0W1QDfP3ta21/dVzqiOLZZO6fjAGWa1MGzSMYU3N+hKmf
xUM4kbjzp2lRBq9y6OhKOeXs7HajyVBj76SNziJqnWM0DW6B0H3TSEVpfoCDUi4G
ptdCvwkPKxgSjW5/A3SK4jDHC8Qo5vZBYbs/ZIMVyLSRvzz4p2N43HiBcoLe3kay
dLqzNzl3hXz9R18WgQ77/ZDv08QtOJM0IkPHXPOz04x0YZn3SDlbtE4o33sYJNwJ
3yff8sJHkRFp7oUafps0a7QeKxAPyDwroht5xnmnKH7eLejL+3w+j4t99sDXasFw
fICJF6zLWRHPk0b44e1zSSpNRkPvtL+i5qfUYrm+H7LfP6TPWHbGAd8VX3kAzfSF
RrsD44S7hnsJTXidTHFB1pyXtQ5uJPXDdLw0VlRm5m6P1Eb6GOSk0V39D4YEAKv6
snFum9icbvoEQ3I0ds6Y
=jbA/
-----END PGP SIGNATURE-----

--iBHcHRCIarfY7C0j--
