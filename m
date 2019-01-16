Received: from eggs.gnu.org ([209.51.188.92]:37396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gjqIO-0008Eq-V2
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gjq8U-0006ok-ML
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:42:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1gjq8U-0006X1-1m
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:41:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0GIceVQ023294
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 13:41:38 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q2a12080n-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 13:41:38 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Wed, 16 Jan 2019 18:41:36 -0000
Date: Wed, 16 Jan 2019 16:41:22 -0200
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20190116113523.9213-1-david@redhat.com>
	<20190116113523.9213-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116113523.9213-4-david@redhat.com>
Message-Id: <20190116184122.GA27437@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC 03/10] qdev: Provide
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
Cc: qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi, David.

On Wed, Jan 16, 2019 at 12:35:16PM +0100, David Hildenbrand wrote:
> Let's use a wrapper instead of looking it up manually. This function can
> than be reused when we explicitly want to have the bus hotplug handler
> (e.g. when the bus hotplug handler was overwritten by the machine
> hotplug handler).
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
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

Perhaps we don't need to check dev->parent_bus here since
qdev_get_bus_hotplug_handler() is already checking it.

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
> --
> 2.17.2
>
>

--
Murilo
