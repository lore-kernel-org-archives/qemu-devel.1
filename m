Received: from eggs.gnu.org ([2001:4830:134:3::10]:43876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fINOL-0000Ap-7Z
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fINOH-0002z6-Az
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:00:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35222
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fINOH-0002wI-4B
	for qemu-devel@nongnu.org; Mon, 14 May 2018 20:00:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4ENwnk6123753
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 20:00:28 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hyfnstbhd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 20:00:28 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Mon, 14 May 2018 20:00:26 -0400
Date: Mon, 14 May 2018 21:00:17 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20180514100023.12542-1-david@redhat.com>
	<20180514100023.12542-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514100023.12542-4-david@redhat.com>
Message-Id: <20180515000017.GB12837@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 03/18] qdev: let machine
 hotplug handler to override bus hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Mon, May 14, 2018 at 12:00:08PM +0200, David Hildenbrand wrote:
> From: Igor Mammedov <imammedo@redhat.com>
> 
> it will allow to return another hotplug handler than the default
> one for a specific bus based device type. Which is needed to handle
> non trivial plug/unplug sequences that need the access to resources
> configured outside of bus where device is attached.
> 
> That will allow for returned hotplug handler to orchestrate wiring
> in arbitrary order, by chaining other hotplug handlers when
> it's needed.
> 
> PS:
> It could be used for hybrid virtio-mem and virtio-pmem devices
> where it will return machine as hotplug handler which will do
> necessary wiring at machine level and then pass control down
> the chain to bus specific hotplug handler.
> 
> Example of top level hotplug handler override and custom plug sequence:
> 
>   some_machine_get_hotplug_handler(machine){
>       if (object_dynamic_cast(OBJECT(dev), TYPE_SOME_BUS_DEVICE)) {
>           return HOTPLUG_HANDLER(machine);
>       }
>       return NULL;
>   }
> 
>   some_machine_device_plug(hotplug_dev, dev) {
>       if (object_dynamic_cast(OBJECT(dev), TYPE_SOME_BUS_DEVICE)) {
>           /* do machine specific initialization */
>           some_machine_init_special_device(dev)
> 
>           /* pass control to bus specific handler */
>           hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev)
>       }
>   }

Hi, David.

I might be misreading, but isn't it more like the following?

    some_machine_device_plug(hotplug_dev, dev) {
        if (object_dynamic_cast(OBJECT(dev), TYPE_SOME_BUS_DEVICE)) {
            /* do machine specific initialization */
            some_machine_init_special_device(dev)
        } else {
            /* pass control to bus specific handler */
            hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev)
        }
    }

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/core/qdev.c         |  6 ++----
>  include/hw/qdev-core.h | 11 +++++++++++
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index f6f92473b8..885286f579 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -261,12 +261,10 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
>  
>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
>  {
> -    HotplugHandler *hotplug_ctrl;
> +    HotplugHandler *hotplug_ctrl = qdev_get_machine_hotplug_handler(dev);
>  
> -    if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +    if (hotplug_ctrl == NULL && dev->parent_bus) {
>          hotplug_ctrl = dev->parent_bus->hotplug_handler;
> -    } else {
> -        hotplug_ctrl = qdev_get_machine_hotplug_handler(dev);
>      }
>      return hotplug_ctrl;
>  }
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 9453588160..e6a8eca558 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -286,6 +286,17 @@ void qdev_init_nofail(DeviceState *dev);
>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>                                   int required_for_version);
>  HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
> +/**
> + * qdev_get_hotplug_handler: Get handler responsible for device wiring
> + *
> + * Find HOTPLUG_HANDLER for @dev that provides [pre|un]plug callbacks for it.
> + *
> + * Note: in case @dev has a parent bus, it will be returned as handler unless
> + * machine handler overrides it.
> + *
> + * Returns: pointer to object that implements TYPE_HOTPLUG_HANDLER interface
> + *          or NULL if there aren't any.
> + */
>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
>  void qdev_unplug(DeviceState *dev, Error **errp);
>  void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
> -- 
> 2.14.3
> 
> 

-- 
Murilo
