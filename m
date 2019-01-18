Received: from eggs.gnu.org ([209.51.188.92]:44662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gkR3s-0000iP-FB
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gkR3k-00047F-LN
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:07:35 -0500
Date: Fri, 18 Jan 2019 11:07:09 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190118110709.07c08ec5@redhat.com>
In-Reply-To: <20190116113523.9213-4-david@redhat.com>
References: <20190116113523.9213-1-david@redhat.com>
	<20190116113523.9213-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 03/10] qdev: Provide
 qdev_get_bus_hotplug_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Wed, 16 Jan 2019 12:35:16 +0100
David Hildenbrand <david@redhat.com> wrote:

> Let's use a wrapper instead of looking it up manually. This function can
> than be reused when we explicitly want to have the bus hotplug handler
> (e.g. when the bus hotplug handler was overwritten by the machine
> hotplug handler).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/core/qdev.c         | 10 +++++++++-
>  include/hw/qdev-core.h |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 7ad45c0bd6..e2207d77a4 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -233,12 +233,20 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
>      return NULL;
>  }
>  
> +HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
> +{
> +    if (dev->parent_bus) {
> +        return dev->parent_bus->hotplug_handler;
> +    }
> +    return NULL;
> +}
> +
>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
>  {
>      HotplugHandler *hotplug_ctrl = qdev_get_machine_hotplug_handler(dev);
>  
>      if (hotplug_ctrl == NULL && dev->parent_bus) {
> -        hotplug_ctrl = dev->parent_bus->hotplug_handler;
> +        hotplug_ctrl = qdev_get_bus_hotplug_handler(dev);
>      }
>      return hotplug_ctrl;
>  }
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 0632057fd6..893acc19b9 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -277,6 +277,7 @@ DeviceState *qdev_try_create(BusState *bus, const char *name);
>  void qdev_init_nofail(DeviceState *dev);
>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>                                   int required_for_version);
> +HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
>  HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
>  /**
>   * qdev_get_hotplug_handler: Get handler responsible for device wiring
