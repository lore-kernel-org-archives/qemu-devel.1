Received: from eggs.gnu.org ([2001:4830:134:3::10]:33573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <si-wei.liu@oracle.com>) id 1gWS4e-0005k6-Ap
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 15:22:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <si-wei.liu@oracle.com>) id 1gWS4b-0003Tb-1Y
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 15:22:40 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <si-wei.liu@oracle.com>)
	id 1gWS4a-0003SV-N6
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 15:22:36 -0500
References: <1544458548-5986-1-git-send-email-venu.busireddy@oracle.com>
	<1544458548-5986-3-git-send-email-venu.busireddy@oracle.com>
	<20181210123215-mutt-send-email-mst@kernel.org>
From: si-wei liu <si-wei.liu@oracle.com>
Message-ID: <2b7b3ddc-8857-e980-c4f1-99a4185e1c3f@oracle.com>
Date: Mon, 10 Dec 2018 12:22:37 -0800
MIME-Version: 1.0
In-Reply-To: <20181210123215-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] virtio_net: Add support for "Data Path
 Switching" during Live Migration.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Venu Busireddy <venu.busireddy@oracle.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, Liran Alon <liran.alon@oracle.com>



On 12/10/2018 9:41 AM, Michael S. Tsirkin wrote:
> On Mon, Dec 10, 2018 at 11:15:47AM -0500, Venu Busireddy wrote:
>> Added two new events, FAILOVER_PLUG_PRIMARY and FAILOVER_UNPLUG_PRIMAR=
Y.
>> The first is emitted when the guest negotiates the F_STANDBY feature
>> bit. The second is emitted when the virtio_net driver is removed, eith=
er
>> manually or as a result of guest reboot.
> So the names mean "should plug" and "should unplug" right?
Sounds about right, but management stack may ignore the message if not=20
going to plug in the primary device.

> It seems inelegant to tell upper layers what they should do.
> After all they are upper layers because presumably
> there is a policy question as opposed to a mechanism.
> Can we expose information without telling managmenent what to do?
Is it just the name itself that is offensive? The information exposed to=20
upper layer is just that time is ready to plug/unplug the paired device.=20
Would the names FAILOVER_STANDY_SET and FAILOVER_STANDY_CLEAR fit your=20
expectation?

> Alternatively, is there a real need to unplug the device completely?
> Would it work to just hide the device from guest instead?  QEMU can do
> it itself and this is the direction that Sameeh has been taking.
See below in the cover letter:

3. While the hidden device model (viz. coupled device model) is still
 =C2=A0=C2=A0 being explored for automatic hot plugging (QEMU) and automa=
tic datapath
 =C2=A0=C2=A0 switching (host-kernel), this series provides a supplementa=
l set
 =C2=A0=C2=A0 of interfaces if management software wants to drive the SR-=
IOV live
 =C2=A0=C2=A0 migration on its own. It should not conflict with the hidde=
n device
 =C2=A0=C2=A0 model but just offers simplicity of implementation.

As said this is a supplemental implementation that involves and=20
leverages management software before we can converge to the ideal=20
hidden/coupled device model.

As I understand it, we're still exploring the best way to handle the=20
datapath (MAC filter) switching problem for the hidden (coupled) device=20
model, right. Even if we can hide the device there's still need to=20
inform upper layer for datapath switching that is currently being=20
handled in userspace management stack. I think the best fit for the=20
hidden (coupled) model is that all datapath switching can be handled=20
automatically and transparently in the kernel without needing to notify=20
userspace and depend on userspace reaction.

>
>> Management stack can use these
>> events to determine when to plug/unplug the VF device to/from the gues=
t.
>>
>> Also, the Virtual Functions will be automatically removed from the gue=
st
>> if the guest is rebooted. To properly identify the VFIO devices that
>> must be removed, a new property named "x-failover-primary" is added to
>> the vfio-pci devices. Only the vfio-pci devices that have this propert=
y
>> enabled are removed from the guest upon reboot.
> If this property needs to be set by management then
> it must not start with "x-" - that prefix means
> "unstable do not use from external tools".

Sure, will remove "x-" (sorry, missed to correct it before sending out=20
publicly).

Thanks,
-Siwei

>
>> Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
>
>
>> ---
>>   hw/acpi/pcihp.c                | 27 ++++++++++++++++++++++++++
>>   hw/net/virtio-net.c            | 23 ++++++++++++++++++++++
>>   hw/vfio/pci.c                  |  3 +++
>>   hw/vfio/pci.h                  |  1 +
>>   include/hw/pci/pci.h           |  1 +
>>   include/hw/virtio/virtio-net.h |  4 ++++
>>   qapi/net.json                  | 44 ++++++++++++++++++++++++++++++++=
++++++++++
>>   7 files changed, 103 insertions(+)
>>
>> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>> index 80d42e1..2a3ffd3 100644
>> --- a/hw/acpi/pcihp.c
>> +++ b/hw/acpi/pcihp.c
>> @@ -176,6 +176,25 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState =
*s, unsigned bsel, unsigned slo
>>       }
>>   }
>>  =20
>> +static void acpi_pcihp_cleanup_failover_primary(AcpiPciHpState *s, in=
t bsel)
>> +{
>> +    BusChild *kid, *next;
>> +    PCIBus *bus =3D acpi_pcihp_find_hotplug_bus(s, bsel);
>> +
>> +    if (!bus) {
>> +        return;
>> +    }
>> +    QTAILQ_FOREACH_SAFE(kid, &bus->qbus.children, sibling, next) {
>> +        DeviceState *qdev =3D kid->child;
>> +        PCIDevice *pdev =3D PCI_DEVICE(qdev);
>> +        int slot =3D PCI_SLOT(pdev->devfn);
>> +
>> +        if (pdev->failover_primary) {
>> +            s->acpi_pcihp_pci_status[bsel].down |=3D (1U << slot);
>> +        }
>> +    }
>> +}
>> +
>>   static void acpi_pcihp_update_hotplug_bus(AcpiPciHpState *s, int bse=
l)
>>   {
>>       BusChild *kid, *next;
>> @@ -207,6 +226,14 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
>>       int i;
>>  =20
>>       for (i =3D 0; i < ACPI_PCIHP_MAX_HOTPLUG_BUS; ++i) {
>> +        /*
>> +         * Set the acpi_pcihp_pci_status[].down bits of all the
>> +         * failover_primary devices so that the devices are ejected
>> +         * from the guest. We can't use the qdev_unplug() as well as =
the
>> +         * hotplug_handler to unplug the devices, because the guest m=
ay
>> +         * not be in a state to cooperate.
>> +         */
>> +        acpi_pcihp_cleanup_failover_primary(s, i);
>>           acpi_pcihp_update_hotplug_bus(s, i);
>>       }
>>   }
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 411f8fb..d37f33c 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -248,6 +248,28 @@ static void virtio_net_drop_tx_queue_data(VirtIOD=
evice *vdev, VirtQueue *vq)
>>       }
>>   }
>>  =20
>> +static void virtio_net_failover_notify_event(VirtIONet *n, uint8_t st=
atus)
>> +{
>> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>> +
>> +    if (virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_STANDBY=
)) {
>> +        gchar *path =3D object_get_canonical_path(OBJECT(n->qdev));
>> +        /*
>> +         * Emit the FAILOVER_PLUG_PRIMARY event
>> +         *   when the status transitions from 0 to VIRTIO_CONFIG_S_DR=
IVER_OK
>> +         * Emit the FAILOVER_UNPLUG_PRIMARY event
>> +         *   when the status transitions from VIRTIO_CONFIG_S_DRIVER_=
OK to 0
>> +         */
>> +        if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
>> +                (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK))) {
>> +            FAILOVER_NOTIFY_EVENT(plug, n, path);
>> +        } else if ((!(status & VIRTIO_CONFIG_S_DRIVER_OK)) &&
>> +                (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
>> +            FAILOVER_NOTIFY_EVENT(unplug, n, path);
>> +        }
>> +    }
>> +}
>> +
>>   static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t=
 status)
>>   {
>>       VirtIONet *n =3D VIRTIO_NET(vdev);
>> @@ -256,6 +278,7 @@ static void virtio_net_set_status(struct VirtIODev=
ice *vdev, uint8_t status)
>>       uint8_t queue_status;
>>  =20
>>       virtio_net_vnet_endian_status(n, status);
>> +    virtio_net_failover_notify_event(n, status);
>>       virtio_net_vhost_status(n, status);
>>  =20
>>       for (i =3D 0; i < n->max_queues; i++) {
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 5c7bd96..ce1f33c 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3077,6 +3077,7 @@ static void vfio_realize(PCIDevice *pdev, Error =
**errp)
>>       vfio_register_err_notifier(vdev);
>>       vfio_register_req_notifier(vdev);
>>       vfio_setup_resetfn_quirk(vdev);
>> +    pdev->failover_primary =3D vdev->failover_primary;
>>  =20
>>       return;
>>  =20
>> @@ -3219,6 +3220,8 @@ static Property vfio_pci_dev_properties[] =3D {
>>                                      qdev_prop_nv_gpudirect_clique, ui=
nt8_t),
>>       DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, =
msix_relo,
>>                                   OFF_AUTOPCIBAR_OFF),
>> +    DEFINE_PROP_BOOL("x-failover-primary", VFIOPCIDevice,
>> +                     failover_primary, false),
>>       /*
>>        * TODO - support passed fds... is this necessary?
>>        * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index b1ae4c0..06ca661 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -167,6 +167,7 @@ typedef struct VFIOPCIDevice {
>>       bool no_vfio_ioeventfd;
>>       bool enable_ramfb;
>>       VFIODisplay *dpy;
>> +    bool failover_primary;
>>   } VFIOPCIDevice;
>>  =20
>>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int le=
n);
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index e6514bb..b0111d1 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -351,6 +351,7 @@ struct PCIDevice {
>>       MSIVectorUseNotifier msix_vector_use_notifier;
>>       MSIVectorReleaseNotifier msix_vector_release_notifier;
>>       MSIVectorPollNotifier msix_vector_poll_notifier;
>> +    bool failover_primary;
>>   };
>>  =20
>>   void pci_register_bar(PCIDevice *pci_dev, int region_num,
>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio=
-net.h
>> index 4d7f3c8..a697903 100644
>> --- a/include/hw/virtio/virtio-net.h
>> +++ b/include/hw/virtio/virtio-net.h
>> @@ -22,6 +22,10 @@
>>   #define VIRTIO_NET(obj) \
>>           OBJECT_CHECK(VirtIONet, (obj), TYPE_VIRTIO_NET)
>>  =20
>> +#define FAILOVER_NOTIFY_EVENT(type, n, path) \
>> +        qapi_event_send_failover_##type##_primary \
>> +                (!!n->netclient_name, n->netclient_name, path)
>> +
>>   #define TX_TIMER_INTERVAL 150000 /* 150 us */
>>  =20
>>   /* Limit the number of packets that can be sent via a single flush
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 8f99fd9..04a9de9 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -683,3 +683,47 @@
>>   ##
>>   { 'event': 'NIC_RX_FILTER_CHANGED',
>>     'data': { '*name': 'str', 'path': 'str' } }
>> +
>> +##
>> +# @FAILOVER_PLUG_PRIMARY:
>> +#
>> +# Emitted when the guest successfully loads the driver after the STAN=
DBY
>> +# feature bit is negotiated.
>> +#
>> +# @device: Indicates the virtio_net device.
>> +#
>> +# @path: Indicates the device path.
>> +#
>> +# Since: 3.0
>> +#
>> +# Example:
>> +#
>> +# <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
>> +#     "event": "FAILOVER_PLUG_PRIMARY",
>> +#     "data": {"device": "net0", "path": "/machine/peripheral/net0/vi=
rtio-backend"} }
>> +#
>> +##
>> +{ 'event': 'FAILOVER_PLUG_PRIMARY',
>> +  'data': {'*device': 'str', 'path': 'str'} }
>> +
>> +##
>> +# @FAILOVER_UNPLUG_PRIMARY:
>> +#
>> +# Emitted when the guest resets the virtio_net driver.
>> +# The reset can be the result of either unloading the driver or a reb=
oot.
>> +#
>> +# @device: Indicates the virtio_net device.
>> +#
>> +# @path: Indicates the device path.
>> +#
>> +# Since: 3.0
>> +#
>> +# Example:
>> +#
>> +# <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
>> +#     "event": "FAILOVER_UNPLUG_PRIMARY",
>> +#     "data": {"device": "net0", "path": "/machine/peripheral/net0/vi=
rtio-backend"} }
>> +#
>> +##
>> +{ 'event': 'FAILOVER_UNPLUG_PRIMARY',
>> +  'data': {'*device': 'str', 'path': 'str'} }
