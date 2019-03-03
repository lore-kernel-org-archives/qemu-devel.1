Received: from eggs.gnu.org ([209.51.188.92]:58123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1h0NKe-0007lD-9d
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 04:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1h0NBk-00056U-PT
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 04:13:42 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1h0NBh-0004za-HS
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 04:13:39 -0500
Received: by mail-wr1-x444.google.com with SMTP id t18so2212156wrx.2
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 01:13:34 -0800 (PST)
References: <20190227140629.1569-1-yuval.shaia@oracle.com>
	<20190227140629.1569-5-yuval.shaia@oracle.com>
	<152bf41f-8eea-d112-77d3-cd334c5bb4f7@gmail.com>
	<87fts7oyhd.fsf@dusky.pond.sub.org> <20190301122826.GA3863@lap1>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <2ba23858-6eba-5de8-b2a2-183358f75ac6@gmail.com>
Date: Sun, 3 Mar 2019 11:14:09 +0200
MIME-Version: 1.0
In-Reply-To: <20190301122826.GA3863@lap1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 4/9] {monitor,
 hw/pvrdma}: Expose device internals via monitor interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, Markus Armbruster <armbru@redhat.com>
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org



On 3/1/19 2:28 PM, Yuval Shaia wrote:
> On Fri, Mar 01, 2019 at 08:17:02AM +0100, Markus Armbruster wrote:
>> Marcel Apfelbaum <marcel.apfelbaum@gmail.com> writes:
>>
>>> Hi Yuval,
>>>
>>> On 2/27/19 4:06 PM, Yuval Shaia wrote:
>>>> Allow interrogating device internals through HMP interface.
>>>> The exposed indicators can be used for troubleshooting by developers or
>>>> sysadmin.
>>>> There is no need to expose these attributes to a management system (e.x.
>>>> libvirt) because (1) most of them are not "device-management' related
>>>> info and (2) there is no guarantee the interface is stable.
>>>>
>>>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>>>> ---
>>>>    hmp-commands-info.hx      | 16 ++++++++
>>>>    hw/rdma/rdma_backend.c    | 70 ++++++++++++++++++++++++++---------
>>>>    hw/rdma/rdma_rm.c         |  7 ++++
>>>>    hw/rdma/rdma_rm_defs.h    | 27 +++++++++++++-
>>>>    hw/rdma/vmw/pvrdma.h      |  5 +++
>>>>    hw/rdma/vmw/pvrdma_hmp.h  | 21 +++++++++++
>>>>    hw/rdma/vmw/pvrdma_main.c | 77 +++++++++++++++++++++++++++++++++++++++
>>>>    monitor.c                 | 10 +++++
>>>>    8 files changed, 215 insertions(+), 18 deletions(-)
>>>>    create mode 100644 hw/rdma/vmw/pvrdma_hmp.h
>>>>
>>>> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
>>>> index cbee8b944d..9153c33974 100644
>>>> --- a/hmp-commands-info.hx
>>>> +++ b/hmp-commands-info.hx
>>>> @@ -524,6 +524,22 @@ STEXI
>>>>    Show CPU statistics.
>>>>    ETEXI
>>>>    +#if defined(CONFIG_PVRDMA)
>>>> +    {
>>>> +        .name       = "pvrdmacounters",
>>>> +        .args_type  = "",
>>>> +        .params     = "",
>>>> +        .help       = "show pvrdma device counters",
>>>> +        .cmd        = hmp_info_pvrdmacounters,
>>>> +    },
>>>> +
>>>> +STEXI
>>>> +@item info pvrdmacounters
>>>> +@findex info pvrdmacounters
>>>> +Show pvrdma device counters.
>>>> +ETEXI
>>>> +#endif
>>>> +
>>>>    #if defined(CONFIG_SLIRP)
>>>>        {
>>>>            .name       = "usernet",
>> [...]
>>>> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
>>>> index b6061f4b6e..85101368c5 100644
>>>> --- a/hw/rdma/vmw/pvrdma_main.c
>>>> +++ b/hw/rdma/vmw/pvrdma_main.c
>>>> @@ -14,6 +14,7 @@
>>>>     */
>>>>      #include "qemu/osdep.h"
>>>> +#include "qemu/units.h"
>>>>    #include "qapi/error.h"
>>>>    #include "hw/hw.h"
>>>>    #include "hw/pci/pci.h"
>>>> @@ -25,6 +26,7 @@
>>>>    #include "cpu.h"
>>>>    #include "trace.h"
>>>>    #include "sysemu/sysemu.h"
>>>> +#include "monitor/monitor.h"
>>>>      #include "../rdma_rm.h"
>>>>    #include "../rdma_backend.h"
>>>> @@ -32,10 +34,13 @@
>>>>      #include <infiniband/verbs.h>
>>>>    #include "pvrdma.h"
>>>> +#include "pvrdma_hmp.h"
>>>>    #include "standard-headers/rdma/vmw_pvrdma-abi.h"
>>>>    #include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h"
>>>>    #include "pvrdma_qp_ops.h"
>>>>    +GSList *devices;
>> "devices" is far too generic for an external identifier.  Are you
>> missing a 'static' here?  Even if static, I'd recommend "rdma_devices".
> Yep, thanks.
>
>>>> +
>>>>    static Property pvrdma_dev_properties[] = {
>>>>        DEFINE_PROP_STRING("netdev", PVRDMADev, backend_eth_device_name),
>>>>        DEFINE_PROP_STRING("ibdev", PVRDMADev, backend_device_name),
>>>> @@ -55,6 +60,71 @@ static Property pvrdma_dev_properties[] = {
>> [...]
>>>> +}
>>>> +
>>>> +void pvrdma_dump_counters(Monitor *mon)
>>>> +{
>>>> +    g_slist_foreach(devices, pvrdma_dump_device_counters, mon);
>>>> +}
>> Note for later: does nothing when @devices is empty.
> But that is fine, isn't it?
>
>>>> +
>>>>    static void free_dev_ring(PCIDevice *pci_dev, PvrdmaRing *ring,
>>>>                              void *ring_state)
>>>>    {
>>>> @@ -304,6 +374,8 @@ static void pvrdma_fini(PCIDevice *pdev)
>>>>          rdma_info_report("Device %s %x.%x is down", pdev->name,
>>>>                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>>>> +
>>>> +    devices = g_slist_remove(devices, pdev);
>>>>    }
>>>>      static void pvrdma_stop(PVRDMADev *dev)
>>>> @@ -394,6 +466,7 @@ static void pvrdma_regs_write(void *opaque, hwaddr addr, uint64_t val,
>>>>            if (val == 0) {
>>>>                trace_pvrdma_regs_write(addr, val, "REQUEST", "");
>>>>                pvrdma_exec_cmd(dev);
>>>> +            dev->stats.commands++;
>>>>            }
>>>>            break;
>>>>        default:
>>>> @@ -612,9 +685,13 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>>>>            goto out;
>>>>        }
>>>>    +    memset(&dev->stats, 0, sizeof(dev->stats));
>>>> +
>>>>        dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
>>>>        qemu_register_shutdown_notifier(&dev->shutdown_notifier);
>>>>    +    devices = g_slist_append(devices, pdev);
>>>> +
>>>>    out:
>>>>        if (rc) {
>>>>            pvrdma_fini(pdev);
>> Note for later: @devices contains the realized "pvrdma" devices.
> This happens only when rc indicates an error and we jumped here before
> adding the device to the list.
>
>> You could find these devices with object_child_foreach_recursive()
>> instead of maintaining a separate list.
> Hmmm...interesting.
> I will check if it fits my needs and will change accordingly if yes.
>
>>>> diff --git a/monitor.c b/monitor.c
>>>> index defa129319..53ecb5bc70 100644
>>>> --- a/monitor.c
>>>> +++ b/monitor.c
>>>> @@ -85,6 +85,9 @@
>>>>    #include "sysemu/iothread.h"
>>>>    #include "qemu/cutils.h"
>>>>    #include "tcg/tcg.h"
>>>> +#ifdef CONFIG_PVRDMA
>>>> +#include "hw/rdma/vmw/pvrdma_hmp.h"
>>>> +#endif
>>>>      #if defined(TARGET_S390X)
>>>>    #include "hw/s390x/storage-keys.h"
>>>> @@ -1362,6 +1365,13 @@ static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
>>>>        cpu_dump_statistics(cs, (FILE *)mon, &monitor_fprintf, 0);
>>>>    }
>>>>    +#ifdef CONFIG_PVRDMA
>>>> +static void hmp_info_pvrdmacounters(Monitor *mon, const QDict *qdict)
>>>> +{
>>>> +    pvrdma_dump_counters(mon);
>>> Compilation fails on archs with no PCI support:
>>>
>>>      /usr/bin/ld: monitor.o: in function `hmp_info_pvrdmacounters':
>>>      /home/marcel/git/qemu/monitor.c:1371: undefined reference to
>>> `pvrdma_dump_counters'
>>>     collect2: error: ld returned 1 exit status
>>>     make[1]: *** [Makefile:210: qemu-system-m68k] Error 1
>>>
>>>
>>> The below patch solves it by adding a pci stub:
>>>
>>> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
>>> index b941a0e842..cab364f93d 100644
>>> --- a/hw/pci/pci-stub.c
>>> +++ b/hw/pci/pci-stub.c
>>> @@ -26,6 +26,7 @@
>>>   #include "qapi/qmp/qerror.h"
>>>   #include "hw/pci/pci.h"
>>>   #include "hw/pci/msi.h"
>>> +#include "hw/rdma/vmw/pvrdma_hmp.h"
>>>
>>>   bool msi_nonbroken;
>>>   bool pci_available;
>>> @@ -53,3 +54,9 @@ uint16_t pci_requester_id(PCIDevice *dev)
>>>       g_assert(false);
>>>       return 0;
>>>   }
>>> +
>>> +void pvrdma_dump_counters(Monitor *mon)
>>> +{
>>> +    monitor_printf(mon, "PVRDMA requires PCI support\n");
>>> +}
>>> +
>> When CONFIG_PCI is enabled, "info pvrdmacounters" does nothing when
>> there are no "pvrdma" devices.
>>
>> When CONFIG_PCI is disabled, there are no "pvrdma" devices.  Therefore,
>> "info pvrdmacounters" should also do nothing then, shouldn't it?
> Yeah, problem was in case that pvrdma was selected in ./configure phase but
> platform does not have PCI -> CONFIG_PCI is diabeled -> pvrdma code is not
> compiled -> pvrdma_dump_counters is missing in link phase.
>
> If you have a better alternative then i'm fine, meanwhile i'm taking
> Marcel's proposal.

I think that what Markus proposed is that the  global "@pvrdma_devices" list
should always  be present (and not compiled based on the CONFIG_PCI flag).

Then the 'pvrdma_dump_counters' can be independent from the mentioned flag
and just print nothing since the list will be empty.

Thanks,
Marcel

>>> However you should include a generic rdma header as hw/rdma/rdma_hmp.h
>>> and not a vmw specific one.
>>>
>>>
>>> Thanks,
>>> Marcel
>>>
>>>
>>>> +}
>>>> +#endif
>>>> +
>>>>    static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
>>>>    {
>>>>        const char *name = qdict_get_try_str(qdict, "name");
