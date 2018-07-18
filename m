Received: from eggs.gnu.org ([2001:4830:134:3::10]:51400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffoTu-00069e-1x
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffoTr-000571-SO
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:10 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ffoTr-00054x-Ey
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id c13-v6so5147562wrt.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 08:35:07 -0700 (PDT)
Date: Wed, 18 Jul 2018 16:02:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180718150252.GO21825@stefanha-x1.localdomain>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-3-e.emanuelegiuseppe@gmail.com>
	<20180711144920.GN31228@stefanha-x1.localdomain>
	<887b55ee-4312-1fd8-a8cb-2152da33b981@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+nG9yj4eE4W6Oba0"
Content-Disposition: inline
In-Reply-To: <887b55ee-4312-1fd8-a8cb-2152da33b981@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/7] tests/qgraph: pci-pc driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele <e.emanuelegiuseppe@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


--+nG9yj4eE4W6Oba0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 07:46:09PM +0200, Emanuele wrote:
> On 07/11/2018 04:49 PM, Stefan Hajnoczi wrote:
> > On Mon, Jul 09, 2018 at 11:11:31AM +0200, Emanuele Giuseppe Esposito wr=
ote:
> > > +void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, int devfn)
> > > +{
> > > +    if (!bus) {
> > > +        return;
> > > +    }
> > When does this happen and why?
> Ok maybe this is unneeded, I added it because I was creating a test with a
> NULL bus, but we ended up putting it aside. So you're right, this should =
be
> eliminated.

Thanks!

> > > +    dev->bus =3D bus;
> > > +    dev->devfn =3D devfn;
> > > +
> > > +    if (qpci_config_readw(dev, PCI_VENDOR_ID) =3D=3D 0xFFFF) {
> > > +        printf("PCI Device not found\n");
> > > +        abort();
> > > +    }
> > > +    qpci_device_enable(dev);
> > > +}
> > > +
> > > +void qpci_set_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *a=
lloc)
> > It's not clear to me what the purpose of this function is - at least the
> > name is a bit cryptic since it seems more like an initialization
> > function than 'setting pc' on QPCIBusPC.  How about inlining this in
> > qpci_init_pc() instead of keeping a separate function?
> The idea is that, following the graph that Paolo wrote in the GSoC project
> wiki (https://wiki.qemu.org/Features/qtest_driver_framework), QPCIBusPC is
> "contained" in i440FX-pcihost. This means that the i440FX-pcihost struct =
has
> a QPCIBusPC field.
>=20
> Therefore I had to put QPCIBusPC as public (in order to have it as field),
> even though qpci_init_pc() was not what I needed to initialize it, because
> that function is allocating a new QPCIBusPC, while I just needed to "set"
> its values.
> From here, qpci_set_pc().

I see.  Renaming qpci_set_pc() to qpci_pc_init() and including a doc
comment explaining that this is the in-place initialization function
would make things clear.

> > > +{
> > >       assert(qts);
> > >       ret->bus.pio_readb =3D qpci_pc_pio_readb;
> > > @@ -147,11 +164,23 @@ QPCIBus *qpci_init_pc(QTestState *qts, QGuestAl=
locator *alloc)
> > >       ret->bus.mmio_alloc_ptr =3D 0xE0000000;
> > >       ret->bus.mmio_limit =3D 0x100000000ULL;
> > > +    ret->obj.get_driver =3D qpci_get_driver;
> > > +}
> > > +
> > > +QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
> > > +{
> > > +    QPCIBusPC *ret =3D g_new0(QPCIBusPC, 1);
> > > +    qpci_set_pc(ret, qts, alloc);
> > > +
> > >       return &ret->bus;
> > >   }
> > >   void qpci_free_pc(QPCIBus *bus)
> > >   {
> > > +    if (!bus) {
> > > +        return;
> > > +    }
> > Why is this needed now?
> Not having this would mean failure of tests like vrtio-user-test, because
> now QPCIBusPC has two fields, and QPCIBus bus; is not the first one eithe=
r.
> Therefore, if I remember correctly doing something like
> container_of(NULL, QPCIBusPC, bus)
> where bus is not the first field of QPCIBusPC would result in a negative
> number, and freeing that would make the test crash.
>=20
> I discovered this issue while doing some checks, and already proposed a
> patch for it, even though we ended up agreeing that this fix was only nee=
ded
> in my patch and not in the current QEMU implementation.

I see now:

  void free_ahci_device(QPCIDevice *dev)
  {
      QPCIBus *pcibus =3D dev ? dev->bus : NULL;

      /* libqos doesn't have a function for this, so free it manually */
      g_free(dev);
      qpci_free_pc(pcibus);
  }

The caller is assuming it's okay to pass NULL.

This is a good candidate for a separate patch so that you can explain
the rationale ("Although containerof(NULL, QPCIBusPC, bus) happens to
evaluate to NULL today thanks to the QPCIBusPC struct layout, it's
generally bad practice to rely on that.  Normally containerof() is used
precisely because an offset into the struct is required and a
straightforward cast would not work.  We got lucky, but don't depend on
it anymore.").

> > > +
> > >       QPCIBusPC *s =3D container_of(bus, QPCIBusPC, bus);
> > >       g_free(s);
> > > @@ -176,3 +205,11 @@ void qpci_unplug_acpi_device_test(const char *id=
, uint8_t slot)
> > >       qmp_eventwait("DEVICE_DELETED");
> > >   }
> > > +
> > > +static void qpci_pc(void)
> > > +{
> > > +    qos_node_create_driver("pci-bus-pc", NULL);
> > > +    qos_node_produces("pci-bus-pc", "pci-bus");
> > In QOM pci-bus-pc would be a class, pci-bus would be an interface.  From
> > a driver perspective it seems QOM can already do what is needed and the
> > qgraph infrastructure isn't necessary.
> >=20
> > Obviously the depth-first search *is* unique and not in QOM, although
> > QOM does offer a tree namespace which can be used for looking up object
> > instances and I guess this could be used to configure tests at runtime.
> >=20
> > I'll think about this more as I read the rest of the patches.
> >=20
> > > +}
> > > +
> > > +libqos_init(qpci_pc);
> > > diff --git a/tests/libqos/pci-pc.h b/tests/libqos/pci-pc.h
> > > index 491eeac756..ee381c5667 100644
> > > --- a/tests/libqos/pci-pc.h
> > > +++ b/tests/libqos/pci-pc.h
> > > @@ -15,7 +15,15 @@
> > >   #include "libqos/pci.h"
> > >   #include "libqos/malloc.h"
> > > +#include "qgraph.h"
> > > +typedef struct QPCIBusPC {
> > > +    QOSGraphObject obj;
> > > +    QPCIBus bus;
> > > +} QPCIBusPC;
> > Why does this need to be public?
> See previous answer
> >=20
> > > +
> > > +void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, int devfn);
> > Why does this need to be public?
> I'll use that in the next patches. I also realized this function should go
> in pci.h, and not pci-pc.h
> >=20
> > > +void qpci_set_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *a=
lloc);
> > Why does this need to be public?
> Because I use it in the next patch to set the QPCIBusPC in the x86_64/pc
> machine.

These changes aren't self-contained, making it hard to review the patch
series.  I review patch series in order, so anything that anticipates
future changes without an explanation in the comments or commit
description causes me to ask questions.

Patches are easiest to review when there are no forward references.
This can be achieved by only introducing things when they are needed.

> >=20
> > >   QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc);
> > >   void     qpci_free_pc(QPCIBus *bus);
> > > diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
> > > index 0b73cb23d0..c51c186867 100644
> > > --- a/tests/libqos/pci.c
> > > +++ b/tests/libqos/pci.c
> > > @@ -15,6 +15,7 @@
> > >   #include "hw/pci/pci_regs.h"
> > >   #include "qemu/host-utils.h"
> > > +#include "qgraph.h"
> > >   void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
> > >                            void (*func)(QPCIDevice *dev, int devfn, v=
oid *data),
> > > @@ -402,3 +403,10 @@ void qpci_plug_device_test(const char *driver, c=
onst char *id,
> > >       qtest_qmp_device_add(driver, id, "'addr': '%d'%s%s", slot,
> > >                            opts ? ", " : "", opts ? opts : "");
> > >   }
> > > +
> > > +static void qpci(void)
> > > +{
> > > +    qos_node_create_interface("pci-bus");
> > > +}
> > > +
> > > +libqos_init(qpci);
> > Why does an interface need to be created?  The drivers declare which
> > interfaces they support?
> >=20
> > I don't think this can be used to detect typoes in the driver's
> > qos_node_produces() call since there is no explicit control over the
> > order in which libqos_init() functions are called.  So the driver may
> > call qos_node_produces() before the qos_node_create_interface() is
> > called?
> The interface is what is actually given to the test, so from there it can
> test the functions and fields regardless of which driver is actually
> implementing them.
> For example, sdhci-test uses the QSDHCI functions, and depending on the p=
ath
> the generic-sdhci or sdhci-pci functions will be used.
>=20
> It is possible to call produce() before create(), since an edge just keep=
s a
> reference on the name of the node, and not the actual node. If a produce
> relationship includes the name of a node that does not exist, the
> application will detect it only during the graph walk, triggering an
> abort(). If both nodes of the edge will refer to non-existent nodes, the
> edge won't be detected during the graph walk.

Drivers declare which interface they implement.  Tests request an
interface.  That should be enough information to connect the two
together.  Why is qos_node_create_interface() necessary?

--+nG9yj4eE4W6Oba0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbT1acAAoJEJykq7OBq3PI/8QIALVJ+FKPe2wOkqHtynk4J6Yb
mQhQGumay5DrR/uj4V50wuPaOn3SAhNjoo14pq/SaX5pbXDiIxqz/3tPYx5DVaO8
hQ08Hbzq1gK+ACCk9KJAvbIZfnZ8Ks94crYZG3M5NyJkIBJN1Mgu6XXkoQctRxsT
nnvcWTWQdQ6+/Mrl112+pGpAabrea5BmzVTYRx5i40VJCeTAym3F3Tn228Jr9fYY
lMBE9HZMfhzRy/+pwQ4IkbgumLkVfkw3/lcYg0PDQ6Kxu4lqVpIAFHSFnYYu5+PK
cGFKcDf0zV4TkwMTJJbkXcLjtdBx5xlt0ac9MAfS6Ohk2AMkgIUwXoDsCrfWK7o=
=vBN9
-----END PGP SIGNATURE-----

--+nG9yj4eE4W6Oba0--
