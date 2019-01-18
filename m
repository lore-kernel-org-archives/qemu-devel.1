Received: from eggs.gnu.org ([209.51.188.92]:42435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gkQut-0002sL-8c
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gkQur-0004gd-7Z
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:58:23 -0500
Date: Fri, 18 Jan 2019 10:58:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190118105806.5c00605e@redhat.com>
In-Reply-To: <20190116113523.9213-2-david@redhat.com>
References: <20190116113523.9213-1-david@redhat.com>
	<20190116113523.9213-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 01/10] qdev: Let the
 hotplug_handler_unplug() caller delete the device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On Wed, 16 Jan 2019 12:35:14 +0100
David Hildenbrand <david@redhat.com> wrote:

> When unplugging a device, at one point the device will be destroyed
> via object_unparent(). This will, one the one hand, unrealize the
> removed device hierarchy, and on the other hand, destroy/free the
> device hierarchy.
> 
> When chaining interrupt handlers, we want to overwrite a bus hotplug
s/interrupt/hotplug/

> handler by the machine hotplug handler, to be able to perform
> some part of the plug/unplug and to forward the calls to the bus hotplug
> handler.
> 
> For now, the bus hotplug handler would trigger an object_unparent(), not
> allowing us to perform some unplug action on a device after we forwarded
> the call to the bus hotplug handler. The device would be gone at that
> point.
> 
> machine_unplug_handler(dev)
>     /* eventually do unplug stuff */
>     bus_unplug_handler(dev)
>     /* dev is gone, we can't do more unplug stuff */
> 
> So move the object_unparent() to the original caller of the unplug. For
> now, keep the unrealize() at the original places of the
> object_unparent(). For implicitly chained hotplug handlers (e.g. pc
> code calling acpi hotplug handlers), the object_unparent() has to be
> done by the outermost caller. So when calling hotplug_handler_unplug()
> from inside an unplug handler, nothing is to be done.
> 
> hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
>     machine_unplug_handler(dev) {
>         /* eventually do unplug stuff */
>         bus_unplug_handler(dev) -> calls unrealize(dev)
>         /* we can do more unplug stuff but device already unrealized */
>     }
> object_unparent(dev)
> 
> In the long run, every unplug action should be factored out of the
> unrealize() function into the unplug handler (especially for PCI). Then
> we can get rid of the additonal unrealize() calls and object_unparent()
> will properly unrealize the device hierarchy after the device has been
> unplugged.
> 
> hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
>     machine_unplug_handler(dev) {
>         /* eventually do unplug stuff */
>         bus_unplug_handler(dev) -> only unplugs, does not unrealize
>         /* we can do more unplug stuff */
>     }
> object_unparent(dev) -> will unrealize
> 
> The original approach was suggested by Igor Mammedov for the PCI
> part, but I extended it to all hotplug handlers. I consider this one
> step into the right direction.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Have you tested all affect use-cases after this patch?

> ---
>  hw/acpi/cpu.c            |  1 +
>  hw/acpi/memory_hotplug.c |  1 +
>  hw/acpi/pcihp.c          |  3 ++-
>  hw/core/qdev.c           |  3 +--
>  hw/i386/pc.c             |  5 ++---
>  hw/pci/pcie.c            |  3 ++-
>  hw/pci/shpc.c            |  3 ++-
>  hw/ppc/spapr.c           |  4 ++--
>  hw/ppc/spapr_pci.c       |  3 ++-
>  hw/s390x/css-bridge.c    |  2 +-
>  hw/s390x/s390-pci-bus.c  | 13 ++++++++-----
>  qdev-monitor.c           |  9 +++++++--
>  12 files changed, 31 insertions(+), 19 deletions(-)
> 
[...]
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index d59071b8ed..278cc094ec 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -286,8 +286,7 @@ void qbus_reset_all_fn(void *opaque)
>  void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
>                                    DeviceState *dev, Error **errp)
>  {
> -    /* just zap it */
> -    object_unparent(OBJECT(dev));
> +    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
>  }
>  
>  /*
[...]
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 07147c63bf..7705acd6c7 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -862,6 +862,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>      DeviceClass *dc = DEVICE_GET_CLASS(dev);
>      HotplugHandler *hotplug_ctrl;
>      HotplugHandlerClass *hdc;
> +    Error *local_err = NULL;
>  
>      if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
>          error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
> @@ -890,10 +891,14 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>       * otherwise just remove it synchronously */
>      hdc = HOTPLUG_HANDLER_GET_CLASS(hotplug_ctrl);
>      if (hdc->unplug_request) {
> -        hotplug_handler_unplug_request(hotplug_ctrl, dev, errp);
> +        hotplug_handler_unplug_request(hotplug_ctrl, dev, &local_err);
>      } else {
> -        hotplug_handler_unplug(hotplug_ctrl, dev, errp);
> +        hotplug_handler_unplug(hotplug_ctrl, dev, &local_err);
> +        if (!local_err) {
> +            object_unparent(OBJECT(dev));
Is this object_unparent() that you moved from qdev_simple_device_unplug_cb()
in the hunk above?

IS it possible to split patch per subsystem for easier review?
> +        }
>      }
> +    error_propagate(errp, local_err);
>  }
>  
>  void qmp_device_del(const char *id, Error **errp)
