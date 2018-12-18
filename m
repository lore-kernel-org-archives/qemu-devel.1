Received: from eggs.gnu.org ([2001:4830:134:3::10]:60132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gZGD9-0001LX-SD
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gZGD7-0005P1-Jg
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:19:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gZGD7-0005O5-AC
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:19:01 -0500
Date: Tue, 18 Dec 2018 15:18:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181218151853.5f908f20@Igors-MacBook-Pro.local>
In-Reply-To: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
References: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] qdev/core: fix qbus_is_full()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: qemu-devel@nongnu.org, pasic@linux.ibm.com, pmorel@linux.ibm.com

On Mon, 17 Dec 2018 10:57:30 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The qbus_is_full(BusState *bus) function (qdev_monitor.c) compares the max_index
> value of the BusState structure with the max_dev value of the BusClass structure
> to determine whether the maximum number of children has been reached for the
> bus. The problem is, the max_index field of the BusState structure does not
> necessarily reflect the number of devices that have been plugged into
> the bus.
> 
> Whenever a child device is plugged into the bus, the bus's max_index value is
> assigned to the child device and then incremented. If the child is subsequently
> unplugged, the value of the max_index does not change and no longer reflects the
> number of children.
> 
> When the bus's max_index value reaches the maximum number of devices
> allowed for the bus (i.e., the max_dev field in the BusClass structure),
> attempts to plug another device will be rejected claiming that the bus is
> full -- even if the bus is actually empty.
> 
> To resolve the problem, a new 'num_children' field is being added to the
> BusState structure to keep track of the number of children plugged into the
> bus. It will be incremented when a child is plugged, and decremented when a
> child is unplugged.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/core/qdev.c         | 3 +++
>  include/hw/qdev-core.h | 1 +
>  qdev-monitor.c         | 2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 6b3cc55b27c2..956923f33520 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -59,6 +59,8 @@ static void bus_remove_child(BusState *bus, DeviceState *child)
>              snprintf(name, sizeof(name), "child[%d]", kid->index);
>              QTAILQ_REMOVE(&bus->children, kid, sibling);
>  
> +            bus->num_children--;
> +
>              /* This gives back ownership of kid->child back to us.  */
>              object_property_del(OBJECT(bus), name, NULL);
>              object_unref(OBJECT(kid->child));
> @@ -73,6 +75,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
>      char name[32];
>      BusChild *kid = g_malloc0(sizeof(*kid));
>  
> +    bus->num_children++;
>      kid->index = bus->max_index++;
>      kid->child = child;
>      object_ref(OBJECT(kid->child));
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index a24d0dd566e3..521f0a947ead 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -206,6 +206,7 @@ struct BusState {
>      HotplugHandler *hotplug_handler;
>      int max_index;
>      bool realized;
> +    int num_children;
>      QTAILQ_HEAD(ChildrenHead, BusChild) children;
>      QLIST_ENTRY(BusState) sibling;
>  };
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 07147c63bf8b..45a8ba49644c 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -414,7 +414,7 @@ static DeviceState *qbus_find_dev(BusState *bus, char *elem)
>  static inline bool qbus_is_full(BusState *bus)
>  {
>      BusClass *bus_class = BUS_GET_CLASS(bus);
> -    return bus_class->max_dev && bus->max_index >= bus_class->max_dev;
> +    return bus_class->max_dev && bus->num_children >= bus_class->max_dev;
>  }
>  
>  /*
