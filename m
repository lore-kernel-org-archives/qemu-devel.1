Received: from eggs.gnu.org ([209.51.188.92]:44358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzcQ7-0007D7-SA
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzcQ5-0005vq-Pz
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:17:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gzcQ5-0005ji-8L
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:17:21 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190227140629.1569-1-yuval.shaia@oracle.com>
	<20190227140629.1569-5-yuval.shaia@oracle.com>
	<152bf41f-8eea-d112-77d3-cd334c5bb4f7@gmail.com>
Date: Fri, 01 Mar 2019 08:17:02 +0100
In-Reply-To: <152bf41f-8eea-d112-77d3-cd334c5bb4f7@gmail.com> (Marcel
	Apfelbaum's message of "Thu, 28 Feb 2019 10:35:38 +0200")
Message-ID: <87fts7oyhd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Yuval Shaia <yuval.shaia@oracle.com>, dgilbert@redhat.com, qemu-devel@nongnu.org

Marcel Apfelbaum <marcel.apfelbaum@gmail.com> writes:

> Hi Yuval,
>
> On 2/27/19 4:06 PM, Yuval Shaia wrote:
>> Allow interrogating device internals through HMP interface.
>> The exposed indicators can be used for troubleshooting by developers or
>> sysadmin.
>> There is no need to expose these attributes to a management system (e.x.
>> libvirt) because (1) most of them are not "device-management' related
>> info and (2) there is no guarantee the interface is stable.
>>
>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>> ---
>>   hmp-commands-info.hx      | 16 ++++++++
>>   hw/rdma/rdma_backend.c    | 70 ++++++++++++++++++++++++++---------
>>   hw/rdma/rdma_rm.c         |  7 ++++
>>   hw/rdma/rdma_rm_defs.h    | 27 +++++++++++++-
>>   hw/rdma/vmw/pvrdma.h      |  5 +++
>>   hw/rdma/vmw/pvrdma_hmp.h  | 21 +++++++++++
>>   hw/rdma/vmw/pvrdma_main.c | 77 +++++++++++++++++++++++++++++++++++++++
>>   monitor.c                 | 10 +++++
>>   8 files changed, 215 insertions(+), 18 deletions(-)
>>   create mode 100644 hw/rdma/vmw/pvrdma_hmp.h
>>
>> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
>> index cbee8b944d..9153c33974 100644
>> --- a/hmp-commands-info.hx
>> +++ b/hmp-commands-info.hx
>> @@ -524,6 +524,22 @@ STEXI
>>   Show CPU statistics.
>>   ETEXI
>>   +#if defined(CONFIG_PVRDMA)
>> +    {
>> +        .name       =3D "pvrdmacounters",
>> +        .args_type  =3D "",
>> +        .params     =3D "",
>> +        .help       =3D "show pvrdma device counters",
>> +        .cmd        =3D hmp_info_pvrdmacounters,
>> +    },
>> +
>> +STEXI
>> +@item info pvrdmacounters
>> +@findex info pvrdmacounters
>> +Show pvrdma device counters.
>> +ETEXI
>> +#endif
>> +
>>   #if defined(CONFIG_SLIRP)
>>       {
>>           .name       =3D "usernet",
[...]
>> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
>> index b6061f4b6e..85101368c5 100644
>> --- a/hw/rdma/vmw/pvrdma_main.c
>> +++ b/hw/rdma/vmw/pvrdma_main.c
>> @@ -14,6 +14,7 @@
>>    */
>>     #include "qemu/osdep.h"
>> +#include "qemu/units.h"
>>   #include "qapi/error.h"
>>   #include "hw/hw.h"
>>   #include "hw/pci/pci.h"
>> @@ -25,6 +26,7 @@
>>   #include "cpu.h"
>>   #include "trace.h"
>>   #include "sysemu/sysemu.h"
>> +#include "monitor/monitor.h"
>>     #include "../rdma_rm.h"
>>   #include "../rdma_backend.h"
>> @@ -32,10 +34,13 @@
>>     #include <infiniband/verbs.h>
>>   #include "pvrdma.h"
>> +#include "pvrdma_hmp.h"
>>   #include "standard-headers/rdma/vmw_pvrdma-abi.h"
>>   #include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev=
_api.h"
>>   #include "pvrdma_qp_ops.h"
>>   +GSList *devices;

"devices" is far too generic for an external identifier.  Are you
missing a 'static' here?  Even if static, I'd recommend "rdma_devices".

>> +
>>   static Property pvrdma_dev_properties[] =3D {
>>       DEFINE_PROP_STRING("netdev", PVRDMADev, backend_eth_device_name),
>>       DEFINE_PROP_STRING("ibdev", PVRDMADev, backend_device_name),
>> @@ -55,6 +60,71 @@ static Property pvrdma_dev_properties[] =3D {
[...]
>> +}
>> +
>> +void pvrdma_dump_counters(Monitor *mon)
>> +{
>> +    g_slist_foreach(devices, pvrdma_dump_device_counters, mon);
>> +}

Note for later: does nothing when @devices is empty.

>> +
>>   static void free_dev_ring(PCIDevice *pci_dev, PvrdmaRing *ring,
>>                             void *ring_state)
>>   {
>> @@ -304,6 +374,8 @@ static void pvrdma_fini(PCIDevice *pdev)
>>         rdma_info_report("Device %s %x.%x is down", pdev->name,
>>                        PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>> +
>> +    devices =3D g_slist_remove(devices, pdev);
>>   }
>>     static void pvrdma_stop(PVRDMADev *dev)
>> @@ -394,6 +466,7 @@ static void pvrdma_regs_write(void *opaque, hwaddr a=
ddr, uint64_t val,
>>           if (val =3D=3D 0) {
>>               trace_pvrdma_regs_write(addr, val, "REQUEST", "");
>>               pvrdma_exec_cmd(dev);
>> +            dev->stats.commands++;
>>           }
>>           break;
>>       default:
>> @@ -612,9 +685,13 @@ static void pvrdma_realize(PCIDevice *pdev, Error *=
*errp)
>>           goto out;
>>       }
>>   +    memset(&dev->stats, 0, sizeof(dev->stats));
>> +
>>       dev->shutdown_notifier.notify =3D pvrdma_shutdown_notifier;
>>       qemu_register_shutdown_notifier(&dev->shutdown_notifier);
>>   +    devices =3D g_slist_append(devices, pdev);
>> +
>>   out:
>>       if (rc) {
>>           pvrdma_fini(pdev);

Note for later: @devices contains the realized "pvrdma" devices.

You could find these devices with object_child_foreach_recursive()
instead of maintaining a separate list.

>> diff --git a/monitor.c b/monitor.c
>> index defa129319..53ecb5bc70 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -85,6 +85,9 @@
>>   #include "sysemu/iothread.h"
>>   #include "qemu/cutils.h"
>>   #include "tcg/tcg.h"
>> +#ifdef CONFIG_PVRDMA
>> +#include "hw/rdma/vmw/pvrdma_hmp.h"
>> +#endif
>>     #if defined(TARGET_S390X)
>>   #include "hw/s390x/storage-keys.h"
>> @@ -1362,6 +1365,13 @@ static void hmp_info_cpustats(Monitor *mon, const=
 QDict *qdict)
>>       cpu_dump_statistics(cs, (FILE *)mon, &monitor_fprintf, 0);
>>   }
>>   +#ifdef CONFIG_PVRDMA
>> +static void hmp_info_pvrdmacounters(Monitor *mon, const QDict *qdict)
>> +{
>> +    pvrdma_dump_counters(mon);
>
> Compilation fails on archs with no PCI support:
>
> =C2=A0=C2=A0=C2=A0 /usr/bin/ld: monitor.o: in function `hmp_info_pvrdmaco=
unters':
> =C2=A0=C2=A0=C2=A0 /home/marcel/git/qemu/monitor.c:1371: undefined refere=
nce to
> `pvrdma_dump_counters'
> =C2=A0=C2=A0 collect2: error: ld returned 1 exit status
> =C2=A0=C2=A0 make[1]: *** [Makefile:210: qemu-system-m68k] Error 1
>
>
> The below patch solves it by adding a pci stub:
>
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index b941a0e842..cab364f93d 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -26,6 +26,7 @@
> =C2=A0#include "qapi/qmp/qerror.h"
> =C2=A0#include "hw/pci/pci.h"
> =C2=A0#include "hw/pci/msi.h"
> +#include "hw/rdma/vmw/pvrdma_hmp.h"
>
> =C2=A0bool msi_nonbroken;
> =C2=A0bool pci_available;
> @@ -53,3 +54,9 @@ uint16_t pci_requester_id(PCIDevice *dev)
> =C2=A0=C2=A0=C2=A0=C2=A0 g_assert(false);
> =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> =C2=A0}
> +
> +void pvrdma_dump_counters(Monitor *mon)
> +{
> +=C2=A0=C2=A0=C2=A0 monitor_printf(mon, "PVRDMA requires PCI support\n");
> +}
> +

When CONFIG_PCI is enabled, "info pvrdmacounters" does nothing when
there are no "pvrdma" devices.

When CONFIG_PCI is disabled, there are no "pvrdma" devices.  Therefore,
"info pvrdmacounters" should also do nothing then, shouldn't it?

> However you should include a generic rdma header as hw/rdma/rdma_hmp.h
> and not a vmw specific one.
>
>
> Thanks,
> Marcel
>
>
>> +}
>> +#endif
>> +
>>   static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *name =3D qdict_get_try_str(qdict, "name");
