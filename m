Received: from eggs.gnu.org ([2001:4830:134:3::10]:53940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdGsj-0005hI-LU
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdGsf-00067A-Lm
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:18:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fdGsf-00066f-Fi
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:18:13 -0400
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-3-e.emanuelegiuseppe@gmail.com>
	<20180711144920.GN31228@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <494e6b18-a5e9-0521-4ace-dca2160ea191@redhat.com>
Date: Wed, 11 Jul 2018 17:18:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180711144920.GN31228@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Stefan Hajnoczi <stefanha@gmail.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 11/07/2018 16:49, Stefan Hajnoczi wrote:
> On Mon, Jul 09, 2018 at 11:11:31AM +0200, Emanuele Giuseppe Esposito wr=
ote:
>> -QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
>> +static void *qpci_get_driver(void *obj, const char *interface)
>>  {
>> -    QPCIBusPC *ret =3D g_new0(QPCIBusPC, 1);
>> +    QPCIBusPC *qpci =3D obj;
>> +    if (!g_strcmp0(interface, "pci-bus")) {
>> +        return &qpci->bus;
>> +    }
>> +    printf("%s not present in pci-bus-pc", interface);
>> +    abort();
>> +}
>=20
> At this point I wonder if it makes sense to use the QEMU Object Model
> (QOM), which has interfaces and inheritance.  qgraph duplicates part of
> the object model.

Replying for Emanuele on this point since we didn't really go through
QOM yet; I'll let him answer the comments that are more related to the co=
de.

QOM is much heavier weight than qgraph, and adds a lot more boilerplate:

- QOM properties interact with QAPI and bring in a lot of baggage;
qgraph would only use "child" properties to implement containment.

- QOM objects are long-lived, qgraph objects only last for the duration
of a single test.  qgraph doesn't need reference counting or complex
two-phase initialization like "realize" or "user_complete"

- QOM's hierarchy is shallow, but qgraph doesn't really need _any_
hierarchy.  Because it focuses on interface rather than hierarchy,
everything can be expressed simply through structs contained into one
another.

Consider that qgraph is 1/4th the size of QOM, and a large part of it is
the graph data structure that (as you said) would not be provided by QOM.

There are two things where using QOM would save a little bit of
duplicated concepts, namely the get_driver (get interface, what you
quote above) and get_device (get contained object) callbacks.  However,
it wouldn't simplify the code at all, because it would require the
introduction of separate instance and class structs.  We didn't want to
add all too much boilerplate for people that want to write qtest, as you
pointed out in the review of patch 4.

>> +void qpci_set_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *al=
loc)
>=20
> It's not clear to me what the purpose of this function is - at least th=
e
> name is a bit cryptic since it seems more like an initialization
> function than 'setting pc' on QPCIBusPC.  How about inlining this in
> qpci_init_pc() instead of keeping a separate function?

I agree about the naming.  Perhaps we can rename the existing
qpci_init_pc to qpci_pc_new, and qpci_set_pc to qpci_pc_init.

Would you prefer if the split was done in the patch that introduces the
user for qpci_set_pc (patch 5)?  We did it here because this patch
prepares qpci-pc

Thanks,

Paolo

>> +{
>>      assert(qts);
>> =20
>>      ret->bus.pio_readb =3D qpci_pc_pio_readb;
>> @@ -147,11 +164,23 @@ QPCIBus *qpci_init_pc(QTestState *qts, QGuestAll=
ocator *alloc)
>>      ret->bus.mmio_alloc_ptr =3D 0xE0000000;
>>      ret->bus.mmio_limit =3D 0x100000000ULL;
>> =20
>> +    ret->obj.get_driver =3D qpci_get_driver;
>> +}
>> +
>> +QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
>> +{
>> +    QPCIBusPC *ret =3D g_new0(QPCIBusPC, 1);
>> +    qpci_set_pc(ret, qts, alloc);
>> +
>>      return &ret->bus;
>>  }
>> =20
>>  void qpci_free_pc(QPCIBus *bus)
>>  {
>> +    if (!bus) {
>> +        return;
>> +    }
>=20
> Why is this needed now?
>=20
>> +
>>      QPCIBusPC *s =3D container_of(bus, QPCIBusPC, bus);
>> =20
>>      g_free(s);
>> @@ -176,3 +205,11 @@ void qpci_unplug_acpi_device_test(const char *id,=
 uint8_t slot)
>> =20
>>      qmp_eventwait("DEVICE_DELETED");
>>  }
>> +
>> +static void qpci_pc(void)
>> +{
>> +    qos_node_create_driver("pci-bus-pc", NULL);
>> +    qos_node_produces("pci-bus-pc", "pci-bus");
>=20
> In QOM pci-bus-pc would be a class, pci-bus would be an interface.  Fro=
m
> a driver perspective it seems QOM can already do what is needed and the
> qgraph infrastructure isn't necessary.
>=20
> Obviously the depth-first search *is* unique and not in QOM, although
> QOM does offer a tree namespace which can be used for looking up object
> instances and I guess this could be used to configure tests at runtime.
>=20
> I'll think about this more as I read the rest of the patches.
>=20
>> +}
>> +
>> +libqos_init(qpci_pc);
>> diff --git a/tests/libqos/pci-pc.h b/tests/libqos/pci-pc.h
>> index 491eeac756..ee381c5667 100644
>> --- a/tests/libqos/pci-pc.h
>> +++ b/tests/libqos/pci-pc.h
>> @@ -15,7 +15,15 @@
>> =20
>>  #include "libqos/pci.h"
>>  #include "libqos/malloc.h"
>> +#include "qgraph.h"
>> =20
>> +typedef struct QPCIBusPC {
>> +    QOSGraphObject obj;
>> +    QPCIBus bus;
>> +} QPCIBusPC;
>=20
> Why does this need to be public?
>=20
>> +
>> +void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, int devfn);
>=20
> Why does this need to be public?
>=20
>> +void qpci_set_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *al=
loc);
>=20
> Why does this need to be public?
>=20
>>  QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc);
>>  void     qpci_free_pc(QPCIBus *bus);
>> =20
>> diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
>> index 0b73cb23d0..c51c186867 100644
>> --- a/tests/libqos/pci.c
>> +++ b/tests/libqos/pci.c
>> @@ -15,6 +15,7 @@
>> =20
>>  #include "hw/pci/pci_regs.h"
>>  #include "qemu/host-utils.h"
>> +#include "qgraph.h"
>> =20
>>  void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
>>                           void (*func)(QPCIDevice *dev, int devfn, voi=
d *data),
>> @@ -402,3 +403,10 @@ void qpci_plug_device_test(const char *driver, co=
nst char *id,
>>      qtest_qmp_device_add(driver, id, "'addr': '%d'%s%s", slot,
>>                           opts ? ", " : "", opts ? opts : "");
>>  }
>> +
>> +static void qpci(void)
>> +{
>> +    qos_node_create_interface("pci-bus");
>> +}
>> +
>> +libqos_init(qpci);
>=20
> Why does an interface need to be created?  The drivers declare which
> interfaces they support?
>=20
> I don't think this can be used to detect typoes in the driver's
> qos_node_produces() call since there is no explicit control over the
> order in which libqos_init() functions are called.  So the driver may
> call qos_node_produces() before the qos_node_create_interface() is
> called?
>=20
