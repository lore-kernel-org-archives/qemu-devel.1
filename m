Received: from eggs.gnu.org ([209.51.188.92]:59211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <si-wei.liu@oracle.com>) id 1ggfxy-0007xM-6F
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <si-wei.liu@oracle.com>) id 1ggfxw-000503-Es
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:14:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <si-wei.liu@oracle.com>)
	id 1ggfxw-0004yU-4Y
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:14:00 -0500
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
	<1546900184-27403-5-git-send-email-venu.busireddy@oracle.com>
	<20190107161717.4648aba2@x1.home>
	<20190107182115-mutt-send-email-mst@kernel.org>
	<20190107164115.6daffe19@x1.home>
From: si-wei liu <si-wei.liu@oracle.com>
Message-ID: <6155b136-fa44-445b-4a08-b9bdbc5cd372@oracle.com>
Date: Mon, 7 Jan 2019 17:13:53 -0800
MIME-Version: 1.0
In-Reply-To: <20190107164115.6daffe19@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/5] vfio-pci: Add
 FAILOVER_PRIMARY_CHANGED event to shorten downtime during failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Venu Busireddy <venu.busireddy@oracle.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org



On 01/07/2019 03:41 PM, Alex Williamson wrote:
> On Mon, 7 Jan 2019 18:22:20 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>> On Mon, Jan 07, 2019 at 04:17:17PM -0700, Alex Williamson wrote:
>>> On Mon,  7 Jan 2019 17:29:43 -0500
>>> Venu Busireddy <venu.busireddy@oracle.com> wrote:
>>>   =20
>>>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>
>>>> When a VF is hotplugged into the guest, datapath switching will be
>>>> performed immediately, which is sub-optimal in terms of timing, and
>>>> could end up with substantial network downtime. One of ways to short=
en
>>>> this downtime is to switch the datapath only after the VF is seen to=
 get
>>>> enabled by guest, indicated by the bus master bit in VF's PCI config
>>>> space getting enabled. The FAILOVER_PRIMARY_CHANGED event is emitted
>>>> at that time to indicate this condition. Then management stack can k=
ick
>>>> off datapath switching upon receiving the event.
>>>>
>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>> Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
>>>> ---
>>>>   hw/vfio/pci.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>>>   qapi/net.json | 26 ++++++++++++++++++++++++++
>>>>   2 files changed, 83 insertions(+)
>>> Why is this done at the vfio driver layer rather than the PCI core
>>> layer?  We write everything through using pci_default_write_config(),=
 I
>>> don't see that anything here is particularly vfio specific.  Please c=
opy
>>> me on any changes in hw/vfio.  Thanks,
>>>
>>> Alex
>> Hmm so you are saying let's send events for each device?
>> I don't have a problem with this but in this case
>> I think I would like to see a per-device option "send events".
>> We don't want a ton of events in the simple default config.
> In the below we're only sending events for PCIDevice.failover_primary,
> seems like that would filter out the rest of the non-NIC PCI devices as
> well as it does for non-NIC VFIO PCI devices.  The only thing remotely
> vfio specific below is that it might notify based on the vfio device
> name, but it's a fallback to PCIDevice.qdev.id.
Not exactly. It will first try to use the qdev ID to notify. If qdev id=20
is missing (vfio-pci device could live without it),=C2=A0 then sysfsdev n=
ame=20
will be used instead (in the form of host device=20
"<bus>:<device>.<function>" location rather than ID). The intent was=20
indeed to make this notification applicable to every possible vfio-pci=20
device, even those without a qdev ID.

>   A real ID could just
> be a requirement to make use of this.
I'm fine to make qdev-id required for failover_primary PCI device. But=20
please be noted, this is a shrinkage rather than generalization that has=20
to apply to all other non-VFIO PCI devices that don't have to specify a=20
qdev ID today.=C2=A0 I'm not sure if it's a good idea to make it restrict=
ed=20
this early.

Thanks,
-Siwei

>   Thanks,
>
> Alex
>
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index bd83b58..adcc95a 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -34,6 +34,7 @@
>>>>   #include "pci.h"
>>>>   #include "trace.h"
>>>>   #include "qapi/error.h"
>>>> +#include "qapi/qapi-events-net.h"
>>>>  =20
>>>>   #define MSIX_CAP_LENGTH 12
>>>>  =20
>>>> @@ -42,6 +43,7 @@
>>>>  =20
>>>>   static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>>>>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enable=
d);
>>>> +static void vfio_failover_notify(VFIOPCIDevice *vdev, bool status);
>>>>  =20
>>>>   /*
>>>>    * Disabling BAR mmaping can be slow, but toggling it around INTx =
can
>>>> @@ -1170,6 +1172,8 @@ void vfio_pci_write_config(PCIDevice *pdev,
>>>>   {
>>>>       VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
>>>>       uint32_t val_le =3D cpu_to_le32(val);
>>>> +    bool may_notify =3D false;
>>>> +    bool master_was =3D false;
>>>>  =20
>>>>       trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, le=
n);
>>>>  =20
>>>> @@ -1180,6 +1184,14 @@ void vfio_pci_write_config(PCIDevice *pdev,
>>>>                        __func__, vdev->vbasedev.name, addr, val, len=
);
>>>>       }
>>>>  =20
>>>> +    /* Bus Master Enabling/Disabling */
>>>> +    if (pdev->failover_primary && current_cpu &&
>>>> +        range_covers_byte(addr, len, PCI_COMMAND)) {
>>>> +        master_was =3D !!(pci_get_word(pdev->config + PCI_COMMAND) =
&
>>>> +                        PCI_COMMAND_MASTER);
>>>> +        may_notify =3D true;
>>>> +    }
>>>> +
>>>>       /* MSI/MSI-X Enabling/Disabling */
>>>>       if (pdev->cap_present & QEMU_PCI_CAP_MSI &&
>>>>           ranges_overlap(addr, len, pdev->msi_cap, vdev->msi_cap_siz=
e)) {
>>>> @@ -1235,6 +1247,14 @@ void vfio_pci_write_config(PCIDevice *pdev,
>>>>           /* Write everything to QEMU to keep emulated bits correct =
*/
>>>>           pci_default_write_config(pdev, addr, val, len);
>>>>       }
>>>> +
>>>> +    if (may_notify) {
>>>> +        bool master_now =3D !!(pci_get_word(pdev->config + PCI_COMM=
AND) &
>>>> +                             PCI_COMMAND_MASTER);
>>>> +        if (master_was !=3D master_now) {
>>>> +            vfio_failover_notify(vdev, master_now);
>>>> +        }
>>>> +    }
>>>>   }
>>>>  =20
>>>>   /*
>>>> @@ -2801,6 +2821,17 @@ static void vfio_unregister_req_notifier(VFIO=
PCIDevice *vdev)
>>>>       vdev->req_enabled =3D false;
>>>>   }
>>>>  =20
>>>> +static void vfio_failover_notify(VFIOPCIDevice *vdev, bool status)
>>>> +{
>>>> +    PCIDevice *pdev =3D &vdev->pdev;
>>>> +    const char *n;
>>>> +    gchar *path;
>>>> +
>>>> +    n =3D pdev->qdev.id ? pdev->qdev.id : vdev->vbasedev.name;
>>>> +    path =3D object_get_canonical_path(OBJECT(vdev));
>>>> +    qapi_event_send_failover_primary_changed(!!n, n, path, status);
>>>> +}
>>>> +
>>>>   static void vfio_realize(PCIDevice *pdev, Error **errp)
>>>>   {
>>>>       VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
>>>> @@ -3109,10 +3140,36 @@ static void vfio_instance_finalize(Object *o=
bj)
>>>>       vfio_put_group(group);
>>>>   }
>>>>  =20
>>>> +static void vfio_exit_failover_notify(VFIOPCIDevice *vdev)
>>>> +{
>>>> +    PCIDevice *pdev =3D &vdev->pdev;
>>>> +
>>>> +    /*
>>>> +     * Guest driver may not get the chance to disable bus mastering
>>>> +     * before the device object gets to be unrealized. In that even=
t,
>>>> +     * send out a "disabled" notification on behalf of guest driver.
>>>> +     */
>>>> +    if (pdev->failover_primary &&
>>>> +        pdev->bus_master_enable_region.enabled) {
>>>> +        vfio_failover_notify(vdev, false);
>>>> +    }
>>>> +}
>>>> +
>>>>   static void vfio_exitfn(PCIDevice *pdev)
>>>>   {
>>>>       VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
>>>>  =20
>>>> +    /*
>>>> +     * During the guest reboot sequence, it is sometimes possible t=
hat
>>>> +     * the guest may not get sufficient time to complete the entire=
 driver
>>>> +     * removal sequence, near the end of which a PCI config space w=
rite to
>>>> +     * disable bus mastering can be intercepted by device. In such =
cases,
>>>> +     * the FAILOVER_PRIMARY_CHANGED "disable" event will not be emi=
tted. It
>>>> +     * is imperative to generate the event on the guest's behalf if=
 the
>>>> +     * guest fails to make it.
>>>> +     */
>>>> +    vfio_exit_failover_notify(vdev);
>>>> +
>>>>       vfio_unregister_req_notifier(vdev);
>>>>       vfio_unregister_err_notifier(vdev);
>>>>       pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
>>>> diff --git a/qapi/net.json b/qapi/net.json
>>>> index 633ac87..a5b8d70 100644
>>>> --- a/qapi/net.json
>>>> +++ b/qapi/net.json
>>>> @@ -757,3 +757,29 @@
>>>>   ##
>>>>   { 'command': 'query-standby-status', 'data': { '*device': 'str' },
>>>>     'returns': ['StandbyStatusInfo'] }
>>>> +
>>>> +##
>>>> +# @FAILOVER_PRIMARY_CHANGED:
>>>> +#
>>>> +# Emitted whenever the driver of failover primary is loaded or unlo=
aded
>>>> +# by the guest.
>>>> +#
>>>> +# @device: device name
>>>> +#
>>>> +# @path: device path
>>>> +#
>>>> +# @enabled: true if driver is loaded thus device is enabled in gues=
t
>>>> +#
>>>> +# Since: 3.0
>>>> +#
>>>> +# Example:
>>>> +#
>>>> +# <- { "event": "FAILOVER_PRIMARY_CHANGED",
>>>> +#      "data": { "device": "vfio-0",
>>>> +#                "path": "/machine/peripheral/vfio-0" },
>>>> +#                "enabled": "true" },
>>>> +#      "timestamp": { "seconds": 1539935213, "microseconds": 753529=
 } }
>>>> +#
>>>> +##
>>>> +{ 'event': 'FAILOVER_PRIMARY_CHANGED',
>>>> +  'data': { '*device': 'str', 'path': 'str', 'enabled': 'bool' } }
>>>>   =20
>
