Received: from eggs.gnu.org ([2001:4830:134:3::10]:37012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1evAwl-00059X-EM
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 20:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1evAwi-0000yI-K2
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 20:04:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1evAwi-0000y1-F3
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 20:04:08 -0400
Date: Mon, 12 Mar 2018 02:04:05 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180312020346-mutt-send-email-mst@kernel.org>
References: <20171217204912.12420-1-f4bug@amsat.org>
	<20171217204912.12420-5-f4bug@amsat.org>
	<42aa5fe6-1cf0-4912-a773-72cc8950afb5@amsat.org>
	<20180312020236-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180312020236-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/pci: remove obsolete
 PCIDevice->init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org

On Mon, Mar 12, 2018 at 02:03:17AM +0200, Michael S. Tsirkin wrote:
> On Sun, Mar 11, 2018 at 04:46:52PM +0100, Philippe Mathieu-Daud=E9 wrot=
e:
> > Hi Michael, Paolo.
> >=20
> > Now than all other PCI QOM'ification patches got applied, can you tak=
e
> > this patch for 2.12?
> >=20
> > Thanks,
> >=20
> > Phil.
> >=20
> > On 12/17/2017 09:49 PM, Philippe Mathieu-Daud=E9 wrote:
> > > All PCI devices are now QOM'ified.
> > >=20
> > > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > > ---
> > >  include/hw/pci/pci.h |  1 -
> > >  hw/pci/pci.c         | 14 --------------
> > >  2 files changed, 15 deletions(-)
> > >=20
> > > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > index 8d02a0a383..0f1ed64c2f 100644
> > > --- a/include/hw/pci/pci.h
> > > +++ b/include/hw/pci/pci.h
> > > @@ -217,7 +217,6 @@ typedef struct PCIDeviceClass {
> > >      DeviceClass parent_class;
> > > =20
> > >      void (*realize)(PCIDevice *dev, Error **errp);
> > > -    int (*init)(PCIDevice *dev);/* TODO convert to realize() and r=
emove */
> > >      PCIUnregisterFunc *exit;
> > >      PCIConfigReadFunc *config_read;
> > >      PCIConfigWriteFunc *config_write;
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index b2d139bd9a..cd25ab6f6b 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -2054,18 +2054,6 @@ static void pci_qdev_realize(DeviceState *qd=
ev, Error **errp)
> > >      }
> > >  }
> > > =20
> > > -static void pci_default_realize(PCIDevice *dev, Error **errp)
> > > -{
> > > -    PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(dev);
> > > -
> > > -    if (pc->init) {
> > > -        if (pc->init(dev) < 0) {
> > > -            error_setg(errp, "Device initialization failed");
> > > -            return;
> > > -        }
> > > -    }
> > > -}
> > > -
> > >  PCIDevice *pci_create_multifunction(PCIBus *bus, int devfn, bool m=
ultifunction,
> > >                                      const char *name)
> > >  {
> > > @@ -2538,13 +2526,11 @@ MemoryRegion *pci_address_space_io(PCIDevic=
e *dev)
> > >  static void pci_device_class_init(ObjectClass *klass, void *data)
> > >  {
> > >      DeviceClass *k =3D DEVICE_CLASS(klass);
> > > -    PCIDeviceClass *pc =3D PCI_DEVICE_CLASS(klass);
> > > =20
> > >      k->realize =3D pci_qdev_realize;
> > >      k->unrealize =3D pci_qdev_unrealize;
> > >      k->bus_type =3D TYPE_PCI_BUS;
> > >      k->props =3D pci_props;
> > > -    pc->realize =3D pci_default_realize;
>=20
> How about we assert !init here?
>=20
> +	assert(!pc->init);

Oh sorry I missed the chunk that drops it completely.
Will apply.

> > >  }
> > > =20
> > >  static void pci_device_class_base_init(ObjectClass *klass, void *d=
ata)
> > >=20
>=20
>=20
