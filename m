Received: from eggs.gnu.org ([2001:4830:134:3::10]:43410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdGQp-0004qW-Ck
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdGQm-0000eO-94
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:49:27 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fdGQl-0000eC-Su
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:49:24 -0400
Received: by mail-wm0-x244.google.com with SMTP id i139-v6so2683943wmf.4
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 07:49:23 -0700 (PDT)
Date: Wed, 11 Jul 2018 15:49:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711144920.GN31228@stefanha-x1.localdomain>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-3-e.emanuelegiuseppe@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JLiXfqD9/Kt1b+Pq"
Content-Disposition: inline
In-Reply-To: <20180709091136.28849-3-e.emanuelegiuseppe@gmail.com>
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
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


--JLiXfqD9/Kt1b+Pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 11:11:31AM +0200, Emanuele Giuseppe Esposito wrote:
> -QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
> +static void *qpci_get_driver(void *obj, const char *interface)
>  {
> -    QPCIBusPC *ret =3D g_new0(QPCIBusPC, 1);
> +    QPCIBusPC *qpci =3D obj;
> +    if (!g_strcmp0(interface, "pci-bus")) {
> +        return &qpci->bus;
> +    }
> +    printf("%s not present in pci-bus-pc", interface);
> +    abort();
> +}

At this point I wonder if it makes sense to use the QEMU Object Model
(QOM), which has interfaces and inheritance.  qgraph duplicates part of
the object model.

> +void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, int devfn)
> +{
> +    if (!bus) {
> +        return;
> +    }

When does this happen and why?

> +    dev->bus =3D bus;
> +    dev->devfn =3D devfn;
> +
> +    if (qpci_config_readw(dev, PCI_VENDOR_ID) =3D=3D 0xFFFF) {
> +        printf("PCI Device not found\n");
> +        abort();
> +    }
> +    qpci_device_enable(dev);
> +}
> +
> +void qpci_set_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *alloc)

It's not clear to me what the purpose of this function is - at least the
name is a bit cryptic since it seems more like an initialization
function than 'setting pc' on QPCIBusPC.  How about inlining this in
qpci_init_pc() instead of keeping a separate function?

> +{
>      assert(qts);
> =20
>      ret->bus.pio_readb =3D qpci_pc_pio_readb;
> @@ -147,11 +164,23 @@ QPCIBus *qpci_init_pc(QTestState *qts, QGuestAlloca=
tor *alloc)
>      ret->bus.mmio_alloc_ptr =3D 0xE0000000;
>      ret->bus.mmio_limit =3D 0x100000000ULL;
> =20
> +    ret->obj.get_driver =3D qpci_get_driver;
> +}
> +
> +QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
> +{
> +    QPCIBusPC *ret =3D g_new0(QPCIBusPC, 1);
> +    qpci_set_pc(ret, qts, alloc);
> +
>      return &ret->bus;
>  }
> =20
>  void qpci_free_pc(QPCIBus *bus)
>  {
> +    if (!bus) {
> +        return;
> +    }

Why is this needed now?

> +
>      QPCIBusPC *s =3D container_of(bus, QPCIBusPC, bus);
> =20
>      g_free(s);
> @@ -176,3 +205,11 @@ void qpci_unplug_acpi_device_test(const char *id, ui=
nt8_t slot)
> =20
>      qmp_eventwait("DEVICE_DELETED");
>  }
> +
> +static void qpci_pc(void)
> +{
> +    qos_node_create_driver("pci-bus-pc", NULL);
> +    qos_node_produces("pci-bus-pc", "pci-bus");

In QOM pci-bus-pc would be a class, pci-bus would be an interface.  From
a driver perspective it seems QOM can already do what is needed and the
qgraph infrastructure isn't necessary.

Obviously the depth-first search *is* unique and not in QOM, although
QOM does offer a tree namespace which can be used for looking up object
instances and I guess this could be used to configure tests at runtime.

I'll think about this more as I read the rest of the patches.

> +}
> +
> +libqos_init(qpci_pc);
> diff --git a/tests/libqos/pci-pc.h b/tests/libqos/pci-pc.h
> index 491eeac756..ee381c5667 100644
> --- a/tests/libqos/pci-pc.h
> +++ b/tests/libqos/pci-pc.h
> @@ -15,7 +15,15 @@
> =20
>  #include "libqos/pci.h"
>  #include "libqos/malloc.h"
> +#include "qgraph.h"
> =20
> +typedef struct QPCIBusPC {
> +    QOSGraphObject obj;
> +    QPCIBus bus;
> +} QPCIBusPC;

Why does this need to be public?

> +
> +void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, int devfn);

Why does this need to be public?

> +void qpci_set_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *alloc=
);

Why does this need to be public?

>  QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc);
>  void     qpci_free_pc(QPCIBus *bus);
> =20
> diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
> index 0b73cb23d0..c51c186867 100644
> --- a/tests/libqos/pci.c
> +++ b/tests/libqos/pci.c
> @@ -15,6 +15,7 @@
> =20
>  #include "hw/pci/pci_regs.h"
>  #include "qemu/host-utils.h"
> +#include "qgraph.h"
> =20
>  void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
>                           void (*func)(QPCIDevice *dev, int devfn, void *=
data),
> @@ -402,3 +403,10 @@ void qpci_plug_device_test(const char *driver, const=
 char *id,
>      qtest_qmp_device_add(driver, id, "'addr': '%d'%s%s", slot,
>                           opts ? ", " : "", opts ? opts : "");
>  }
> +
> +static void qpci(void)
> +{
> +    qos_node_create_interface("pci-bus");
> +}
> +
> +libqos_init(qpci);

Why does an interface need to be created?  The drivers declare which
interfaces they support?

I don't think this can be used to detect typoes in the driver's
qos_node_produces() call since there is no explicit control over the
order in which libqos_init() functions are called.  So the driver may
call qos_node_produces() before the qos_node_create_interface() is
called?

--JLiXfqD9/Kt1b+Pq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRhjwAAoJEJykq7OBq3PICjgH/ReI48NF84j1rksyHmmh8lNZ
vhBjZQ0pOsrn3j8nNpOSy858XvHSASUAVmmvZ0Uj4jc70W99/T+WbQkCPpJCsuPL
SN+m5rccmwrgOhsKF2DewzfWzHuaj2Zh3b2zsab1CATeoMvRHSJpQFtP/+zHcKX8
0jJ1n/mACctZ4h7k11Dn0WmkS7by5Z8Xa/McWpsi8HgKSjyMAdCDsVjfrKcacJT7
v1/0pEwd/T0nttIWwcWApqFImbSdtGa0tLm03S1Rrci2HCytNlDkYPGs1jk5k+iF
VrCIFW9N+dQPbt7pv3eEcfT3AkOG4uXi2hk1zctfSHY9j7wWhvoM7tQ1oKiiv9Y=
=RzCr
-----END PGP SIGNATURE-----

--JLiXfqD9/Kt1b+Pq--
