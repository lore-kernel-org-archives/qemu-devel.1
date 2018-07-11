Received: from eggs.gnu.org ([2001:4830:134:3::10]:58657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fdJBy-0004vd-8m
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 13:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fdJBt-00028x-BH
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 13:46:18 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fdJBt-00028e-0l
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 13:46:13 -0400
Received: by mail-ed1-x543.google.com with SMTP id s24-v6so3602892edr.8
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 10:46:12 -0700 (PDT)
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-3-e.emanuelegiuseppe@gmail.com>
	<20180711144920.GN31228@stefanha-x1.localdomain>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <887b55ee-4312-1fd8-a8cb-2152da33b981@gmail.com>
Date: Wed, 11 Jul 2018 19:46:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180711144920.GN31228@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 07/11/2018 04:49 PM, Stefan Hajnoczi wrote:

> On Mon, Jul 09, 2018 at 11:11:31AM +0200, Emanuele Giuseppe Esposito wrote:
>> -QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
>> +static void *qpci_get_driver(void *obj, const char *interface)
>>   {
>> -    QPCIBusPC *ret = g_new0(QPCIBusPC, 1);
>> +    QPCIBusPC *qpci = obj;
>> +    if (!g_strcmp0(interface, "pci-bus")) {
>> +        return &qpci->bus;
>> +    }
>> +    printf("%s not present in pci-bus-pc", interface);
>> +    abort();
>> +}
> At this point I wonder if it makes sense to use the QEMU Object Model
> (QOM), which has interfaces and inheritance.  qgraph duplicates part of
> the object model.
>
>> +void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, int devfn)
>> +{
>> +    if (!bus) {
>> +        return;
>> +    }
> When does this happen and why?
Ok maybe this is unneeded, I added it because I was creating a test with 
a NULL bus, but we ended up putting it aside. So you're right, this 
should be eliminated.
>> +    dev->bus = bus;
>> +    dev->devfn = devfn;
>> +
>> +    if (qpci_config_readw(dev, PCI_VENDOR_ID) == 0xFFFF) {
>> +        printf("PCI Device not found\n");
>> +        abort();
>> +    }
>> +    qpci_device_enable(dev);
>> +}
>> +
>> +void qpci_set_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *alloc)
> It's not clear to me what the purpose of this function is - at least the
> name is a bit cryptic since it seems more like an initialization
> function than 'setting pc' on QPCIBusPC.  How about inlining this in
> qpci_init_pc() instead of keeping a separate function?
The idea is that, following the graph that Paolo wrote in the GSoC 
project wiki (https://wiki.qemu.org/Features/qtest_driver_framework), 
QPCIBusPC is "contained" in i440FX-pcihost. This means that the 
i440FX-pcihost struct has a QPCIBusPC field.

Therefore I had to put QPCIBusPC as public (in order to have it as 
field), even though qpci_init_pc() was not what I needed to initialize 
it, because that function is allocating a new QPCIBusPC, while I just 
needed to "set" its values.
 From here, qpci_set_pc().
>> +{
>>       assert(qts);
>>   
>>       ret->bus.pio_readb = qpci_pc_pio_readb;
>> @@ -147,11 +164,23 @@ QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
>>       ret->bus.mmio_alloc_ptr = 0xE0000000;
>>       ret->bus.mmio_limit = 0x100000000ULL;
>>   
>> +    ret->obj.get_driver = qpci_get_driver;
>> +}
>> +
>> +QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
>> +{
>> +    QPCIBusPC *ret = g_new0(QPCIBusPC, 1);
>> +    qpci_set_pc(ret, qts, alloc);
>> +
>>       return &ret->bus;
>>   }
>>   
>>   void qpci_free_pc(QPCIBus *bus)
>>   {
>> +    if (!bus) {
>> +        return;
>> +    }
> Why is this needed now?
Not having this would mean failure of tests like vrtio-user-test, 
because now QPCIBusPC has two fields, and QPCIBus bus; is not the first 
one either.
Therefore, if I remember correctly doing something like
container_of(NULL, QPCIBusPC, bus)
where bus is not the first field of QPCIBusPC would result in a negative 
number, and freeing that would make the test crash.

I discovered this issue while doing some checks, and already proposed a 
patch for it, even though we ended up agreeing that this fix was only 
needed in my patch and not in the current QEMU implementation.
>> +
>>       QPCIBusPC *s = container_of(bus, QPCIBusPC, bus);
>>   
>>       g_free(s);
>> @@ -176,3 +205,11 @@ void qpci_unplug_acpi_device_test(const char *id, uint8_t slot)
>>   
>>       qmp_eventwait("DEVICE_DELETED");
>>   }
>> +
>> +static void qpci_pc(void)
>> +{
>> +    qos_node_create_driver("pci-bus-pc", NULL);
>> +    qos_node_produces("pci-bus-pc", "pci-bus");
> In QOM pci-bus-pc would be a class, pci-bus would be an interface.  From
> a driver perspective it seems QOM can already do what is needed and the
> qgraph infrastructure isn't necessary.
>
> Obviously the depth-first search *is* unique and not in QOM, although
> QOM does offer a tree namespace which can be used for looking up object
> instances and I guess this could be used to configure tests at runtime.
>
> I'll think about this more as I read the rest of the patches.
>
>> +}
>> +
>> +libqos_init(qpci_pc);
>> diff --git a/tests/libqos/pci-pc.h b/tests/libqos/pci-pc.h
>> index 491eeac756..ee381c5667 100644
>> --- a/tests/libqos/pci-pc.h
>> +++ b/tests/libqos/pci-pc.h
>> @@ -15,7 +15,15 @@
>>   
>>   #include "libqos/pci.h"
>>   #include "libqos/malloc.h"
>> +#include "qgraph.h"
>>   
>> +typedef struct QPCIBusPC {
>> +    QOSGraphObject obj;
>> +    QPCIBus bus;
>> +} QPCIBusPC;
> Why does this need to be public?
See previous answer
>
>> +
>> +void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, int devfn);
> Why does this need to be public?
I'll use that in the next patches. I also realized this function should 
go in pci.h, and not pci-pc.h
>
>> +void qpci_set_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *alloc);
> Why does this need to be public?
Because I use it in the next patch to set the QPCIBusPC in the x86_64/pc 
machine.
>
>>   QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc);
>>   void     qpci_free_pc(QPCIBus *bus);
>>   
>> diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
>> index 0b73cb23d0..c51c186867 100644
>> --- a/tests/libqos/pci.c
>> +++ b/tests/libqos/pci.c
>> @@ -15,6 +15,7 @@
>>   
>>   #include "hw/pci/pci_regs.h"
>>   #include "qemu/host-utils.h"
>> +#include "qgraph.h"
>>   
>>   void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
>>                            void (*func)(QPCIDevice *dev, int devfn, void *data),
>> @@ -402,3 +403,10 @@ void qpci_plug_device_test(const char *driver, const char *id,
>>       qtest_qmp_device_add(driver, id, "'addr': '%d'%s%s", slot,
>>                            opts ? ", " : "", opts ? opts : "");
>>   }
>> +
>> +static void qpci(void)
>> +{
>> +    qos_node_create_interface("pci-bus");
>> +}
>> +
>> +libqos_init(qpci);
> Why does an interface need to be created?  The drivers declare which
> interfaces they support?
>
> I don't think this can be used to detect typoes in the driver's
> qos_node_produces() call since there is no explicit control over the
> order in which libqos_init() functions are called.  So the driver may
> call qos_node_produces() before the qos_node_create_interface() is
> called?
The interface is what is actually given to the test, so from there it 
can test the functions and fields regardless of which driver is actually 
implementing them.
For example, sdhci-test uses the QSDHCI functions, and depending on the 
path the generic-sdhci or sdhci-pci functions will be used.

It is possible to call produce() before create(), since an edge just 
keeps a reference on the name of the node, and not the actual node. If a 
produce relationship includes the name of a node that does not exist, 
the application will detect it only during the graph walk, triggering an 
abort(). If both nodes of the edge will refer to non-existent nodes, the 
edge won't be detected during the graph walk.
