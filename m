Received: from eggs.gnu.org ([2001:4830:134:3::10]:56073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1cgX70-0006wY-Px
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1cgX6u-000054-CY
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:37:42 -0500
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:34199)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1cgX6u-00004t-3z
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:37:36 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	v1MDa7iM024844
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 08:37:34 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id B66546D
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 08:37:34 -0500 (EST)
Received: from sendprodmail02.cc.columbia.edu (sendprodmail02.cc.columbia.edu
	[128.59.72.14]) by hazelnut (Postfix) with ESMTP id A029E83
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 08:37:34 -0500 (EST)
Received: from mail-ua0-f199.google.com (mail-ua0-f199.google.com
	[209.85.217.199])
	by sendprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	v1MDbYdx028299
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 08:37:34 -0500
Received: by mail-ua0-f199.google.com with SMTP id 40so1845202uau.1
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 05:37:34 -0800 (PST)
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com.
	[209.85.213.44])
	by smtp.gmail.com with ESMTPSA id k21sm276291vkd.38.2017.02.22.05.37.32
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 Feb 2017 05:37:33 -0800 (PST)
Received: by mail-vk0-f44.google.com with SMTP id k127so1610339vke.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 05:37:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHyh4xjJ+U8XGAHP4TqzZJqmrZBeeHGA3_Kmg5YrMdy3VbCLJQ@mail.gmail.com>
References: <1487742565-2513-1-git-send-email-peterx@redhat.com>
	<CAHyh4xjJ+U8XGAHP4TqzZJqmrZBeeHGA3_Kmg5YrMdy3VbCLJQ@mail.gmail.com>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Wed, 22 Feb 2017 08:37:32 -0500
Message-ID: <CAHyh4xjELha5V5n+dLwmQsoJ=kfahiZsamo7WEEfMtRgXvRsbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, yi.l.liu@intel.com, "\\ Michael S . Tsirkin \\" <mst@redhat.com>

On Wed, Feb 22, 2017 at 6:42 AM, Jintack Lim <jintack@cs.columbia.edu>
wrote:

>
>
> On Wed, Feb 22, 2017 at 12:49 AM, Peter Xu <peterx@redhat.com> wrote:
>
>> Intel vIOMMU devices are created with "-device" parameter, while here
>> actually we need to make sure this device will be created before some
>> other PCI devices (like vfio-pci devices) so that we know iommu_fn will
>> be setup correctly before realizations of those PCI devices.
>>
>> Here we do explicit check to make sure intel-iommu device will be inited
>> before all the rest of the PCI devices. This is done by checking against
>> the devices dangled under current root PCIe bus and we should see
>> nothing there besides integrated ICH9 ones.
>>
>> If the user violated this rule, we abort the program.
>>
>
> Hi Peter,
>
> After applying this patch, qemu gave the following error and was
> terminated, but I believe I passed parameters in a right order?
>

FYI, I've applied this patch to your vtd-vfio-enablement-v7 branch.


>
> [kvm-node ~]$sudo qemu-system-x86_64 \
> > -device intel-iommu,intremap=on,eim=off,caching-mode=on \
> > -M q35,accel=kvm,kernel-irqchip=split \
> > -m 12G \
> > -drive file=/mydata/guest0.img,format=raw --nographic -cpu host \
> > -smp 4,sockets=4,cores=1,threads=1 \
> > -device vfio-pci,host=08:00.0
> qemu-system-x86_64: -device intel-iommu,intremap=on,eim=off,caching-mode=on:
> Please init intel-iommu before other PCI devices
>
>  Thanks,
> Jintack
>
>
>> Maybe one day we will be able to manage the ordering of device
>> initialization, and then we can grant VT-d devices a higher init
>> priority. But before that, let's have this explicit check to make sure
>> of it.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  hw/i386/intel_iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 22d8226..db74124 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -31,6 +31,7 @@
>>  #include "hw/i386/apic-msidef.h"
>>  #include "hw/boards.h"
>>  #include "hw/i386/x86-iommu.h"
>> +#include "hw/i386/ich9.h"
>>  #include "hw/pci-host/q35.h"
>>  #include "sysemu/kvm.h"
>>  #include "hw/i386/apic_internal.h"
>> @@ -2560,6 +2561,41 @@ static bool vtd_decide_config(IntelIOMMUState *s,
>> Error **errp)
>>      return true;
>>  }
>>
>> +static bool vtd_has_inited_pci_devices(PCIBus *bus, Error **errp)
>> +{
>> +    int i;
>> +    uint8_t func;
>> +
>> +    /* We check against root bus */
>> +    assert(bus && pci_bus_is_root(bus));
>> +
>> +    /*
>> +     * We need to make sure vIOMMU device is created before other PCI
>> +     * devices other than the integrated ICH9 ones, so that they can
>> +     * get correct iommu_fn setup even during its realize(). Some
>> +     * devices (e.g., vfio-pci) will need a correct iommu_fn to work.
>> +     */
>> +    for (i = 1; i < PCI_FUNC_MAX * PCI_SLOT_MAX; i++) {
>> +        /* Skip the checking against ICH9 integrated devices */
>> +        if (PCI_SLOT(i) == ICH9_LPC_DEV) {
>> +            func = PCI_FUNC(i);
>> +            if (func == ICH9_LPC_FUNC ||
>> +                func == ICH9_SATA1_FUNC ||
>> +                func == ICH9_SMB_FUNC) {
>> +                continue;
>> +            }
>> +        }
>> +
>> +        if (bus->devices[i]) {
>> +            error_setg(errp, "Please init intel-iommu before "
>> +                       "other PCI devices");
>> +            return true;
>> +        }
>> +    }
>> +
>> +    return false;
>> +}
>> +
>>  static void vtd_realize(DeviceState *dev, Error **errp)
>>  {
>>      PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
>> @@ -2567,6 +2603,10 @@ static void vtd_realize(DeviceState *dev, Error
>> **errp)
>>      IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
>>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
>>
>> +    if (vtd_has_inited_pci_devices(bus, errp)) {
>> +        return;
>> +    }
>> +
>>      VTD_DPRINTF(GENERAL, "");
>>      x86_iommu->type = TYPE_INTEL;
>>
>> --
>> 2.7.4
>>
>>
>>
>
