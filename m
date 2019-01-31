Received: from eggs.gnu.org ([209.51.188.92]:60289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gp8hG-0006Bv-9e
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gp8hE-0004tW-05
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:31:46 -0500
References: <20190121134249.16615-1-david@redhat.com>
	<20190121134249.16615-2-david@redhat.com>
	<9454fd3a-eb80-2600-7c37-215285b6d5d0@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <97c3d60c-4a4d-7d99-d619-be31e67152aa@redhat.com>
Date: Thu, 31 Jan 2019 10:31:38 +0100
MIME-Version: 1.0
In-Reply-To: <9454fd3a-eb80-2600-7c37-215285b6d5d0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 1/2] s390x/pci: Introduce
 unplug requests and split unplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 30.01.19 20:52, Collin Walling wrote:
> On 1/21/19 8:42 AM, David Hildenbrand wrote:
>> PCI on s390x is really weird and how it was modeled in QEMU might not =
have
>> been the right choice. Anyhow, right now it is the case that:
>> - Hotplugging a PCI device will silently create a zPCI device
>>   (if none is provided)
>> - Hotunplugging a zPCI device will unplug the PCI device (if any)
>> - Hotunplugging a PCI device will unplug also the zPCI device
>> As far as I can see, we can no longer change this behavior. But we
>> should fix it.
>>
>> Both device types are handled via a single hotplug handler call. This
>> is problematic for various reasons:
>> 1. Unplugging via the zPCI device allows to unplug PCI bridges as
>>    checks are not performed - bad.
>=20
> Very bad...
>=20
> Solving this issue is outside the scope of this patchset, correct? Or
> am I missing something (nothing stood out to me as I reviewed the code)

As Conny mentioned, 1. does not hold (it resulted from a lack of
understanding on my side). So 1. is not possible.

>=20
>> 2. Unplugging via the zPCI device allows to unplug devices that are no=
t
>>    hot removable. (check performed in qdev_unplug()) - bad.
>=20
> VERY bad.

This one however holds.

>=20
>> 3. Hotplug handler chains are not possible for the unplug case. In the
>>    future, the machine might want to override hotplug handlers, to
>>    process device specific stuff and to then branch off to the actual
>>    hotplug handler. We need separate hotplug handler calls for both th=
e
>>    PCI and zPCI device to make this work reliably. All other PCI
>>    implementations are already prepared to handle this correctly, only
>>    s390x is missing.
>>
>> Therefore, introduce the unplug_request handler and properly perform
>> unplug checks by redirecting to the separate unplug_request handlers.
>> When finally unplugging, perform two separate hotplug_handler_unplug()
>> calls, first for the PCI device, followed by the zPCI device. This now
>> nicely splits unplugging paths for both devices.
>>
>> The redirect part is a little hairy, as the user is allowed to trigger
>> unplug either via the PCI or the zPCI device. So redirect always to th=
e
>> PCI unplug request handler first and remember if that check has been
>> performed in the zPCI device. Redirect then to the zPCI device unplug
>> request handler to perform the magic. Remembering that we already
>> checked the PCI device breaks the redirect loop.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/s390-pci-bus.c | 166 +++++++++++++++++++++++++++------------=
-
>>  hw/s390x/s390-pci-bus.h |   1 +
>>  2 files changed, 113 insertions(+), 54 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index f017c1ded0..bc17a8cf65 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -148,6 +148,22 @@ out:
>>      psccb->header.response_code =3D cpu_to_be16(rc);
>>  }
>> =20
>> +static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
>> +{
>> +    HotplugHandler *hotplug_ctrl;
>> +
>> +    /* Unplug the PCI device */
>> +    if (pbdev->pdev) {
>> +        hotplug_ctrl =3D qdev_get_hotplug_handler(DEVICE(pbdev->pdev)=
);
>> +        hotplug_handler_unplug(hotplug_ctrl, DEVICE(pbdev->pdev),
>> +                               &error_abort);
>> +    }
>> +
>> +    /* Unplug the zPCI device */
>> +    hotplug_ctrl =3D qdev_get_hotplug_handler(DEVICE(pbdev));
>> +    hotplug_handler_unplug(hotplug_ctrl, DEVICE(pbdev), &error_abort)=
;
>> +}
>=20
> Please help me understand this just a little bit better. Most of my=20
> understanding of the s390 PCI architecture stems from the lower-level=20
> instruction / DMA stuff and some of the pass-through stuff. I'm just a=20
> little shaky on the PCI topology with respect to how it is portrayed in=
=20
> the QEMU code.
>=20
> My confusion: when we unplug a zPCI device, we are unplugging a *bus*=20
> device? Won't that cause an issue if other PCI devices are sharing that
> bus? Or am I misunderstanding the QEMU code here and a PCIBusDevice is=20
> more-or-less a path from the bridge to the PCI device (and not the=20
> entire bus itself)? Or...?

Both zPCI as well as PCI devices are actually bus devices ("devices
attached to a bus" - TYPE_DEVICE with dc->bus_type configured). (And the
registered bus hotplug handler handles hotplug/unplug on that bus).

There should not be any problem as long as we are not unplugging a
bridge, which has it's own bus with potentially other devices
registered. But we already shield unplugging bridges, so that is not an
issue.

S390PCIBusDevice (a.k.a. zPCI devices) are just a mean to attach further
architecture information to a PCI devices. These devices are all
attached to the TYPE_S390_PCI_BUS (and there is only one for the whole
system, part of the PCI host bridge)!

In contrast, PCI devices are attached to whatever bus is defined (it
could be the bus of the host bridge or the bus of a created bridge).

So unplugging an ordinary PCI device / S390PCIBusDevice does not affect
other devices, as long as we don't unplug bridges with devices attached.
But we already disallow that.

(I *think* we could even allow unplugging of PCI bridges if there are no
other devices attached, but that is future work)


>=20
> Sorry for the technical question here that I should probably already=20
> know the answer to. Hopefully someone can help accelerate my
> understanding.
>=20
>> +
>>  void s390_pci_sclp_deconfigure(SCCB *sccb)
>>  {
>>      IoaCfgSccb *psccb =3D (IoaCfgSccb *)sccb;
>> @@ -179,7 +195,7 @@ void s390_pci_sclp_deconfigure(SCCB *sccb)
>>          rc =3D SCLP_RC_NORMAL_COMPLETION;
>> =20
>>          if (pbdev->release_timer) {
>> -            qdev_unplug(DEVICE(pbdev->pdev), NULL);
>> +            s390_pci_perform_unplug(pbdev);
>>          }
>>      }
>>  out:
>> @@ -217,6 +233,24 @@ S390PCIBusDevice *s390_pci_find_dev_by_target(S39=
0pciState *s,
>>      return NULL;
>>  }
>> =20
>> +static S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s,
>> +                                                  PCIDevice *pci_dev)
>> +{
>> +    S390PCIBusDevice *pbdev;
>> +
>> +    if (!pci_dev) {
>> +        return NULL;
>> +    }
>> +
>> +    QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
>> +        if (pbdev->pdev =3D=3D pci_dev) {
>> +            return pbdev;
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>=20
> Maybe call this "s390_pci_find_*bus*_dev_by_pci" to make it a little=20
> more clear that this finds and returns a bus device? Better yet, maybe
> "s390_pci_find_bus" to be similar to the generic "pci_get_bus" function=
.
>=20

I chose this naming because it matches the other functions that already
exist

s390_pci_find_next_avail_dev()
s390_pci_find_dev_by_fid()
s390_pci_find_dev_by_uid()
...

>> +
>>  S390PCIBusDevice *s390_pci_find_dev_by_idx(S390pciState *s, uint32_t =
idx)
>>  {
>>      return g_hash_table_lookup(s->zpci_table, &idx);
>> @@ -939,77 +973,100 @@ static void s390_pcihost_timer_cb(void *opaque)
>>      pbdev->state =3D ZPCI_FS_STANDBY;
>>      s390_pci_generate_plug_event(HP_EVENT_CONFIGURED_TO_STBRES,
>>                                   pbdev->fh, pbdev->fid);
>> -    qdev_unplug(DEVICE(pbdev), NULL);
>> +    s390_pci_perform_unplug(pbdev);
>>  }
>> =20
>>  static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceSt=
ate *dev,
>>                                  Error **errp)
>>  {
>>      S390pciState *s =3D S390_PCI_HOST_BRIDGE(hotplug_dev);
>> -    PCIDevice *pci_dev =3D NULL;
>> -    PCIBus *bus;
>> -    int32_t devfn;
>>      S390PCIBusDevice *pbdev =3D NULL;
>> =20
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> +        PCIDevice *pci_dev =3D PCI_DEVICE(dev);
>> +        PCIBus *bus;
>> +        int32_t devfn;
>> +
>> +        pbdev =3D s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
>> +        g_assert(pbdev);
>> +
>> +        s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
>> +                                     pbdev->fh, pbdev->fid);
>> +        bus =3D pci_get_bus(pci_dev);
>> +        devfn =3D pci_dev->devfn;
>> +        object_unparent(OBJECT(pci_dev));
>> +
>> +        s390_pci_msix_free(pbdev);
>> +        s390_pci_iommu_free(s, bus, devfn);
>> +        pbdev->pdev =3D NULL;
>> +        pbdev->state =3D ZPCI_FS_RESERVED;
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)=
) {
>=20
> "S390_PCI_DEVICE" is synonymous with "zPCI device", right? Just making=20
> sure...

Yes, exactly.

>=20
>> +        pbdev =3D S390_PCI_DEVICE(dev);
>> +
>> +        if (pbdev->release_timer) {
>> +            timer_del(pbdev->release_timer);
>> +            timer_free(pbdev->release_timer);
>> +            pbdev->release_timer =3D NULL;
>> +        }
>> +        pbdev->fid =3D 0;
>> +        QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
>> +        g_hash_table_remove(s->zpci_table, &pbdev->idx);
>> +        object_unparent(OBJECT(pbdev));
>> +    }
>> +}
>> +
>> +static void s390_pcihost_unplug_request(HotplugHandler *hotplug_dev,
>> +                                        DeviceState *dev,
>> +                                        Error **errp)
>> +{
>> +    S390pciState *s =3D S390_PCI_HOST_BRIDGE(hotplug_dev);
>> +    S390PCIBusDevice *pbdev;
>> +
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>>          error_setg(errp, "PCI bridge hot unplug currently not support=
ed");
>> -        return;
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> -        pci_dev =3D PCI_DEVICE(dev);
>> -
>> -        QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
>> -            if (pbdev->pdev =3D=3D pci_dev) {
>> -                break;
>> -            }
>> -        }
>> -        assert(pbdev !=3D NULL);
>> +        /*
>> +         * Redirect the unplug request to the zPCI device and remembe=
r that
>> +         * we've checked the PCI device already (to prevent endless r=
ecursion).
>> +         */
>> +        pbdev =3D s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
>> +        g_assert(pbdev);
>> +        pbdev->pci_unplug_request_processed =3D true;
>> +        qdev_unplug(DEVICE(pbdev), errp);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)=
) {
>>          pbdev =3D S390_PCI_DEVICE(dev);
>> -        pci_dev =3D pbdev->pdev;
>> -    } else {
>> -        g_assert_not_reached();
>> -    }
>> =20
>> -    switch (pbdev->state) {
>> -    case ZPCI_FS_RESERVED:
>> -        goto out;
>> -    case ZPCI_FS_STANDBY:
>> -        break;
>> -    default:
>> -        if (pbdev->release_timer) {
>> +        /*
>> +         * If unplug was initially requested for the zPCI device, we
>> +         * first have to redirect to the PCI device, which will in re=
turn
>> +         * redirect back to us after performing its checks (if the re=
quest
>> +         * is not blocked, e.g. because it's a PCI bridge).
>> +         */
>> +        if (pbdev->pdev && !pbdev->pci_unplug_request_processed) {
>> +            qdev_unplug(DEVICE(pbdev->pdev), errp);
>>              return;
>>          }
>> -        s390_pci_generate_plug_event(HP_EVENT_DECONFIGURE_REQUEST,
>> -                                     pbdev->fh, pbdev->fid);
>> -        pbdev->release_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>> -                                            s390_pcihost_timer_cb,
>> -                                            pbdev);
>> -        timer_mod(pbdev->release_timer,
>> -                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + HOT_UNPLUG_=
TIMEOUT);
>> -        return;
>> -    }
>> +        pbdev->pci_unplug_request_processed =3D false;
>> =20
>> -    if (pbdev->release_timer) {
>> -        timer_del(pbdev->release_timer);
>> -        timer_free(pbdev->release_timer);
>> -        pbdev->release_timer =3D NULL;
>> +        switch (pbdev->state) {
>> +        case ZPCI_FS_STANDBY:
>> +        case ZPCI_FS_RESERVED:
>> +            s390_pci_perform_unplug(pbdev);
>> +            break;
>> +        default:
>> +            if (pbdev->release_timer) {
>> +                return;
>> +            }
>> +            s390_pci_generate_plug_event(HP_EVENT_DECONFIGURE_REQUEST=
,
>> +                                         pbdev->fh, pbdev->fid);
>> +            pbdev->release_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>> +                                                s390_pcihost_timer_cb=
, pbdev);
>> +            timer_mod(pbdev->release_timer,
>> +                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + HOT_UNPLU=
G_TIMEOUT);
>> +        }
>> +    } else {
>> +        g_assert_not_reached();
>>      }
>> -
>> -    s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
>> -                                 pbdev->fh, pbdev->fid);
>> -    bus =3D pci_get_bus(pci_dev);
>> -    devfn =3D pci_dev->devfn;
>> -    object_unparent(OBJECT(pci_dev));
>> -    fmb_timer_free(pbdev);
>> -    s390_pci_msix_free(pbdev);
>> -    s390_pci_iommu_free(s, bus, devfn);
>> -    pbdev->pdev =3D NULL;
>> -    pbdev->state =3D ZPCI_FS_RESERVED;
>> -out:
>> -    pbdev->fid =3D 0;
>> -    QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
>> -    g_hash_table_remove(s->zpci_table, &pbdev->idx);
>> -    object_unparent(OBJECT(pbdev));
>>  }
>=20
> So from what I understand: _unplug_request will deconfigure the device=20
> (if !standby and !reserved) and _unplug will remove the device from the=
=20
> guest?

You can think of unplug_request() as something like

"If the guest does not use this device, perform the unplug. Otherwise,
ask the guest ("request") to release the device so we can unplug it".

>=20
> Looks good.
>=20
>> =20
>>  static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
>> @@ -1059,6 +1116,7 @@ static void s390_pcihost_class_init(ObjectClass =
*klass, void *data)
>>      dc->realize =3D s390_pcihost_realize;
>>      hc->pre_plug =3D s390_pcihost_pre_plug;
>>      hc->plug =3D s390_pcihost_plug;
>> +    hc->unplug_request =3D s390_pcihost_unplug_request;
>>      hc->unplug =3D s390_pcihost_unplug;
>>      msi_nonbroken =3D true;
>>  }
>> diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
>> index dadad1f758..b1a6bb8296 100644
>> --- a/hw/s390x/s390-pci-bus.h
>> +++ b/hw/s390x/s390-pci-bus.h
>> @@ -336,6 +336,7 @@ struct S390PCIBusDevice {
>>      IndAddr *summary_ind;
>>      IndAddr *indicator;
>>      QEMUTimer *release_timer;
>> +    bool pci_unplug_request_processed;
>>      QTAILQ_ENTRY(S390PCIBusDevice) link;
>>  };
>> =20
>>
>=20
> Patch looks good so far. I only have a few questions above.
>=20

Sure, thanks for having a look! BTW, I resend all s390x/pci patches as a
single series yesterday to give a better overview of what I am changing.

Thanks!


--=20

Thanks,

David / dhildenb
