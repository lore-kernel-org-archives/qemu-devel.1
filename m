Received: from eggs.gnu.org ([209.51.188.92]:52875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1goDjJ-0004oS-HF
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1goDck-0006rn-Om
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:35:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42770
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1goDck-0006rU-Ix
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:35:18 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0SKO3Qv056056
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 15:35:17 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qa817jghv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 15:35:17 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Mon, 28 Jan 2019 20:35:16 -0000
References: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 28 Jan 2019 15:35:09 -0500
MIME-Version: 1.0
In-Reply-To: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e2394dc4-1d95-2c23-5e11-cff441d57c78@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] qdev/core: fix qbus_is_full()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pasic@linux.ibm.com, imammedo@redhat.com, pmorel@linux.ibm.com

On 12/17/18 10:57 AM, Tony Krowiak wrote:
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
> ---
>   hw/core/qdev.c         | 3 +++
>   include/hw/qdev-core.h | 1 +
>   qdev-monitor.c         | 2 +-
>   3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 6b3cc55b27c2..956923f33520 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -59,6 +59,8 @@ static void bus_remove_child(BusState *bus, DeviceState *child)
>               snprintf(name, sizeof(name), "child[%d]", kid->index);
>               QTAILQ_REMOVE(&bus->children, kid, sibling);
>   
> +            bus->num_children--;
> +
>               /* This gives back ownership of kid->child back to us.  */
>               object_property_del(OBJECT(bus), name, NULL);
>               object_unref(OBJECT(kid->child));
> @@ -73,6 +75,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
>       char name[32];
>       BusChild *kid = g_malloc0(sizeof(*kid));
>   
> +    bus->num_children++;
>       kid->index = bus->max_index++;
>       kid->child = child;
>       object_ref(OBJECT(kid->child));
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index a24d0dd566e3..521f0a947ead 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -206,6 +206,7 @@ struct BusState {
>       HotplugHandler *hotplug_handler;
>       int max_index;
>       bool realized;
> +    int num_children;
>       QTAILQ_HEAD(ChildrenHead, BusChild) children;
>       QLIST_ENTRY(BusState) sibling;
>   };
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 07147c63bf8b..45a8ba49644c 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -414,7 +414,7 @@ static DeviceState *qbus_find_dev(BusState *bus, char *elem)
>   static inline bool qbus_is_full(BusState *bus)
>   {
>       BusClass *bus_class = BUS_GET_CLASS(bus);
> -    return bus_class->max_dev && bus->max_index >= bus_class->max_dev;
> +    return bus_class->max_dev && bus->num_children >= bus_class->max_dev;
>   }
>   
>   /*

Just checking back on this one. Do we want to merge this patch and deal
with the max_index issue in another patch, in this patch, or not at all?

> 
