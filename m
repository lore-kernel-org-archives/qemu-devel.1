Received: from eggs.gnu.org ([2001:4830:134:3::10]:37686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cgoUY-0004To-3d
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cgoUT-00031m-0v
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:11:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cgoUS-00031L-PI
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:11:04 -0500
References: <1487742565-2513-1-git-send-email-peterx@redhat.com>
	<20170222103047.2c1b63f2@t450s.home>
	<20170223030647.GB4015@pxdev.xzpeter.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <7cd743a2-b4c2-1d96-892e-c3a7db07da16@redhat.com>
Date: Thu, 23 Feb 2017 10:10:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170223030647.GB4015@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: make sure its init before PCI
 dev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, yi.l.liu@intel.com, "\\ Michael S . Tsirkin \\ " <mst@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, Paolo Bonzini <pbonzini@redhat.com>

On 02/23/2017 05:06 AM, Peter Xu wrote:
> On Wed, Feb 22, 2017 at 10:30:47AM -0700, Alex Williamson wrote:
>> On Wed, 22 Feb 2017 13:49:25 +0800
>> Peter Xu <peterx@redhat.com> wrote:
>>
>>> Intel vIOMMU devices are created with "-device" parameter, while here
>>> actually we need to make sure this device will be created before some
>>> other PCI devices (like vfio-pci devices) so that we know iommu_fn will
>>> be setup correctly before realizations of those PCI devices.
>>>
>>> Here we do explicit check to make sure intel-iommu device will be inited
>>> before all the rest of the PCI devices. This is done by checking against
>>> the devices dangled under current root PCIe bus and we should see
>>> nothing there besides integrated ICH9 ones.

Hi,

Commit b86eacb8 (hw/pci: delay bus_master_enable_region initialization)
creates the IOMMU memory region at machine_done time so the
devices creation order wouldn't matter.

I don't think we use the iommu_fn before machine_done.
What have I missed?

Thanks,
Marcel

>>>
>>> If the user violated this rule, we abort the program.
>>>
>>> Maybe one day we will be able to manage the ordering of device
>>> initialization, and then we can grant VT-d devices a higher init
>>> priority. But before that, let's have this explicit check to make sure
>>> of it.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>  hw/i386/intel_iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 40 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 22d8226..db74124 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -31,6 +31,7 @@
>>>  #include "hw/i386/apic-msidef.h"
>>>  #include "hw/boards.h"
>>>  #include "hw/i386/x86-iommu.h"
>>> +#include "hw/i386/ich9.h"
>>>  #include "hw/pci-host/q35.h"
>>>  #include "sysemu/kvm.h"
>>>  #include "hw/i386/apic_internal.h"
>>> @@ -2560,6 +2561,41 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>>>      return true;
>>>  }
>>>
>>> +static bool vtd_has_inited_pci_devices(PCIBus *bus, Error **errp)
>>> +{
>>> +    int i;
>>> +    uint8_t func;
>>> +
>>> +    /* We check against root bus */
>>> +    assert(bus && pci_bus_is_root(bus));
>>> +
>>> +    /*
>>> +     * We need to make sure vIOMMU device is created before other PCI
>>> +     * devices other than the integrated ICH9 ones, so that they can
>>> +     * get correct iommu_fn setup even during its realize(). Some
>>> +     * devices (e.g., vfio-pci) will need a correct iommu_fn to work.
>>> +     */
>>> +    for (i = 1; i < PCI_FUNC_MAX * PCI_SLOT_MAX; i++) {
>>> +        /* Skip the checking against ICH9 integrated devices */
>>> +        if (PCI_SLOT(i) == ICH9_LPC_DEV) {
>>> +            func = PCI_FUNC(i);
>>> +            if (func == ICH9_LPC_FUNC ||
>>> +                func == ICH9_SATA1_FUNC ||
>>> +                func == ICH9_SMB_FUNC) {
>>> +                continue;
>>> +            }
>>> +        }
>>
>>
>> Whitelisting specific devfns seems pretty sketchy and fragile.  Can we
>> even assume we're on a Q35 chipset?  I don't see that vtd_realize()
>> takes any particular precautions not to allow initialization on 440fx,
>> or whatever generic chipset we come up with next that may not have
>> these specific devices.
>
> Yes. IIUC VT-d now can only work with Q35, right? Cc Marcel and Paolo
> in case I misunderstood it.
>
> If so, maybe here we should check against q35 in vtd realization. How
> about something like:
>
>     if (!object_property_find((Object *)pcms, "q35", NULL)) {
>         error_setg(errp, "Currently Intel vIOMMU only support Q35 platform. "
>                    "Please specify \"-M q35\" to enable it.");
>         return;
>     }
>
> ?
>
>> It would probably be a better idea to use
>> object_dynamic_cast() if you want to whitelist specific devices.
>> Perhaps this could even be used to validate the chipset as well.
>
> Now Jintack reported another issue, that we may have two default
> devices there if not specifying "-nodefaults", and that two devices
> will always be the first ones to be inited.
>
> How about here we just explicitly check against vfio-pci devices, so
> we just make sure vfio-pci devices will be put after intel-iommu?
> Since actually vfio-pci devices are the only ones that we know we need
> to be inited explicitly after the VT-d device.
>
> Thanks,
>
>> Thanks,
>>
>> Alex
>>
>>> +
>>> +        if (bus->devices[i]) {
>>> +            error_setg(errp, "Please init intel-iommu before "
>>> +                       "other PCI devices");
>>> +            return true;
>>> +        }
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>> +
>>>  static void vtd_realize(DeviceState *dev, Error **errp)
>>>  {
>>>      PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
>>> @@ -2567,6 +2603,10 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>>>      IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
>>>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
>>>
>>> +    if (vtd_has_inited_pci_devices(bus, errp)) {
>>> +        return;
>>> +    }
>>> +
>>>      VTD_DPRINTF(GENERAL, "");
>>>      x86_iommu->type = TYPE_INTEL;
>>>
>>
>
> -- peterx
>
