Received: from eggs.gnu.org ([209.51.188.92]:41816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpJli-0000dm-Ug
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpJlh-0003uY-UV
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:21:06 -0500
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-6-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9ab3f62f-9011-b4af-2221-075d36d47327@redhat.com>
Date: Thu, 31 Jan 2019 22:21:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190130155733.32742-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/6] s390x/pci: Drop release timer and
 replace it with a flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Pierre Morel <pmorel@linux.ibm.com>

On 30.01.19 16:57, David Hildenbrand wrote:
> Let's handle it similar to x86 ACPI PCI code and don't use a timer.
> Instead, remember if an unplug request is pending and keep it pending
> for eternity. (a follow up patch will process the request on
> reboot).
>=20
> We expect that a guest that is up and running, will process the unplug
> request and trigger the unplug. This is normal operation, no timer need=
ed.
>=20
> If the guest does not react, this usually means something in the guest
> is going wrong. Simply removing the device after 30 seconds does not
> really sound like a good idea. It might sometimes be wanted, but I
> consider this rather an "opt-in" decision as it might harm a guest not
> prepared for it.
>=20
> If we ever actually want a "forced/surprise removal", we will have to
> implement something on top of the existing "device_del" framework. E.g.
> also x86 might want to do a forced/surprise removal of PCI devices unde=
r
> some conditions. "device_del X, forced=3Dtrue" could be an option and w=
ill
> require changes to the hotplug handler infrastructure.
>=20
> This will then move the responsibility on when to do a forced removal
> to a higher level. Doing a forced removal right now overcomplicates
> things and doesn't really.
>=20
> Let's allow to send multiple requests.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c | 38 +++++++-------------------------------
>  hw/s390x/s390-pci-bus.h |  3 +--
>  2 files changed, 8 insertions(+), 33 deletions(-)
>=20
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index e84e00d20c..867801ccf9 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -194,7 +194,7 @@ void s390_pci_sclp_deconfigure(SCCB *sccb)
>          pbdev->state =3D ZPCI_FS_STANDBY;
>          rc =3D SCLP_RC_NORMAL_COMPLETION;
> =20
> -        if (pbdev->release_timer) {
> +        if (pbdev->unplug_requested) {
>              s390_pci_perform_unplug(pbdev);
>          }
>      }
> @@ -975,23 +975,6 @@ static void s390_pcihost_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>      }
>  }
> =20
> -static void s390_pcihost_timer_cb(void *opaque)
> -{
> -    S390PCIBusDevice *pbdev =3D opaque;
> -
> -    if (pbdev->summary_ind) {
> -        pci_dereg_irqs(pbdev);
> -    }
> -    if (pbdev->iommu->enabled) {
> -        pci_dereg_ioat(pbdev->iommu);
> -    }
> -
> -    pbdev->state =3D ZPCI_FS_STANDBY;
> -    s390_pci_generate_plug_event(HP_EVENT_CONFIGURED_TO_STBRES,
> -                                 pbdev->fh, pbdev->fid);
> -    s390_pci_perform_unplug(pbdev);
> -}
> -
>  static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceSta=
te *dev,
>                                  Error **errp)
>  {
> @@ -1018,12 +1001,6 @@ static void s390_pcihost_unplug(HotplugHandler *=
hotplug_dev, DeviceState *dev,
>          pbdev->state =3D ZPCI_FS_RESERVED;
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE))=
 {
>          pbdev =3D S390_PCI_DEVICE(dev);
> -
> -        if (pbdev->release_timer) {
> -            timer_del(pbdev->release_timer);
> -            timer_free(pbdev->release_timer);
> -            pbdev->release_timer =3D NULL;
> -        }
>          pbdev->fid =3D 0;
>          QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
>          g_hash_table_remove(s->zpci_table, &pbdev->idx);
> @@ -1070,15 +1047,14 @@ static void s390_pcihost_unplug_request(Hotplug=
Handler *hotplug_dev,
>              s390_pci_perform_unplug(pbdev);
>              break;
>          default:
> -            if (pbdev->release_timer) {
> -                return;
> -            }
> +            /*
> +             * Allow to send multiple requests, e.g. if the guest cras=
hed
> +             * before releasing the device, we would not be able to se=
nd
> +             * another request to the same VM (e.g. fresh OS).
> +             */
> +            pbdev->unplug_requested =3D true;
>              s390_pci_generate_plug_event(HP_EVENT_DECONFIGURE_REQUEST,
>                                           pbdev->fh, pbdev->fid);
> -            pbdev->release_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                                s390_pcihost_timer_cb,=
 pbdev);
> -            timer_mod(pbdev->release_timer,
> -                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + HOT_UNPLUG=
_TIMEOUT);
>          }
>      } else {
>          g_assert_not_reached();
> diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
> index b1a6bb8296..550f3cc5e9 100644
> --- a/hw/s390x/s390-pci-bus.h
> +++ b/hw/s390x/s390-pci-bus.h
> @@ -35,7 +35,6 @@
>  #define ZPCI_MAX_UID 0xffff
>  #define UID_UNDEFINED 0
>  #define UID_CHECKING_ENABLED 0x01
> -#define HOT_UNPLUG_TIMEOUT (NANOSECONDS_PER_SECOND * 60 * 5)
> =20
>  #define S390_PCI_HOST_BRIDGE(obj) \
>      OBJECT_CHECK(S390pciState, (obj), TYPE_S390_PCI_HOST_BRIDGE)
> @@ -335,8 +334,8 @@ struct S390PCIBusDevice {
>      MemoryRegion msix_notify_mr;
>      IndAddr *summary_ind;
>      IndAddr *indicator;
> -    QEMUTimer *release_timer;
>      bool pci_unplug_request_processed;
> +    bool unplug_requested;
>      QTAILQ_ENTRY(S390PCIBusDevice) link;
>  };
> =20
>=20

Thinking out loud:

We should migrate the flag in the future. This is already a problem
right now, as the timer is also not migrated.

If the unplug request is sent and we migrate before the guest can react,
the unplug would not happen.

However, looks like migration of zpci devices is not implemented _at all_=
.

This does not matter for pci passthrough (main use case). But when
wanting to use e.g. virtio-pci-net, things are shaky after migration.

So this is future work.

--=20

Thanks,

David / dhildenb
