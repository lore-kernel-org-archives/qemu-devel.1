Received: from eggs.gnu.org ([2001:4830:134:3::10]:39887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIDqw-0006LW-D7
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIDqs-00048D-7Q
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:21:42 -0400
Date: Thu, 1 Nov 2018 15:21:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181101152129.02821aae@redhat.com>
In-Reply-To: <20181024101930.20674-4-david@redhat.com>
References: <20181024101930.20674-1-david@redhat.com>
	<20181024101930.20674-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/7] pcihp: route unplug via the hotplug
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org

On Wed, 24 Oct 2018 12:19:26 +0200
David Hildenbrand <david@redhat.com> wrote:

> Preparation for multi-stage hotplug handlers.
Commit message should describe what and why the patch does
for the sake of unaware. (I know 'why' right now but will for
sure forget all the reasons later)

beside of rerouting it also makes likes of
acpi_pcihp_device_unplug_cb()
to be called from unplug chain vs current request chain which
I bet were confusing.

Otherwise patch looks good

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/acpi/pcihp.c         | 11 ++++++++++-
>  hw/acpi/piix4.c         |  7 +++++--
>  include/hw/acpi/pcihp.h |  3 +++
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 647b5e8d82..062f3c9091 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -154,6 +154,7 @@ static bool acpi_pcihp_pc_no_hotplug(AcpiPciHpState *s, PCIDevice *dev)
>  
>  static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slots)
>  {
> +    HotplugHandler *hotplug_ctrl;
>      BusChild *kid, *next;
>      int slot = ctz32(slots);
>      PCIBus *bus = acpi_pcihp_find_hotplug_bus(s, bsel);
> @@ -171,7 +172,8 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slo
>          PCIDevice *dev = PCI_DEVICE(qdev);
>          if (PCI_SLOT(dev->devfn) == slot) {
>              if (!acpi_pcihp_pc_no_hotplug(s, dev)) {
> -                object_unparent(OBJECT(qdev));
> +                hotplug_ctrl = qdev_get_hotplug_handler(qdev);
> +                hotplug_handler_unplug(hotplug_ctrl, qdev, &error_abort);
>              }
>          }
>      }
> @@ -261,6 +263,13 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
>  
>  void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
>                                   DeviceState *dev, Error **errp)
> +{
> +    object_unparent(OBJECT(dev));
> +}
> +
> +void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                         AcpiPciHpState *s, DeviceState *dev,
> +                                         Error **errp)
>  {
>      PCIDevice *pdev = PCI_DEVICE(dev);
>      int slot = PCI_SLOT(pdev->devfn);
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index e611778daf..ba5632becc 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -418,8 +418,8 @@ static void piix4_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>          acpi_memory_unplug_request_cb(hotplug_dev, &s->acpi_memory_hotplug,
>                                        dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> -        acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
> -                                    errp);
> +        acpi_pcihp_device_unplug_request_cb(hotplug_dev, &s->acpi_pci_hotplug,
> +                                            dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
>                 !s->cpu_hotplug_legacy) {
>          acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
> @@ -437,6 +437,9 @@ static void piix4_device_unplug_cb(HotplugHandler *hotplug_dev,
>      if (s->acpi_memory_hotplug.is_enabled &&
>          object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          acpi_memory_unplug_cb(&s->acpi_memory_hotplug, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
> +                                    errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
>                 !s->cpu_hotplug_legacy) {
>          acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index ce31625850..8bc4a4c01d 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -62,6 +62,9 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
>                                 DeviceState *dev, Error **errp);
>  void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
>                                   DeviceState *dev, Error **errp);
> +void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                         AcpiPciHpState *s, DeviceState *dev,
> +                                         Error **errp);
>  
>  /* Called on reset */
>  void acpi_pcihp_reset(AcpiPciHpState *s);
