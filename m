Received: from eggs.gnu.org ([2001:4830:134:3::10]:34480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gXPok-0003MG-2g
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gXPob-0005A8-VO
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:10:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gXPoZ-00058q-RE
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:10:05 -0500
Date: Thu, 13 Dec 2018 13:09:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181213130959.4c863705@redhat.com>
In-Reply-To: <ee5f36b2-e0a0-cdee-ad9a-dbeb36f1583c@linux.ibm.com>
References: <1544469254-11629-1-git-send-email-akrowiak@linux.ibm.com>
	<20181211162303.2e581899@redhat.com>
	<ee5f36b2-e0a0-cdee-ad9a-dbeb36f1583c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qdev/core: Can not replug device on bus
 that allows one device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: thuth@redhat.com, armbru@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, pbonzini@redhat.com

On Tue, 11 Dec 2018 14:41:00 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 12/11/18 10:23 AM, Igor Mammedov wrote:
> > On Mon, 10 Dec 2018 14:14:14 -0500
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >   
> >> If the maximum number of devices allowed on a bus is 1 and a device
> >> which is plugged into the bus is subsequently unplugged, attempting to replug
> >> the device fails with error "Bus 'xxx' does not support hotplugging".
> >> The "error" is detected in the qbus_is_full(BusState *bus) function
> >> (qdev_monitor.c) because bus->max_index >= bus_class->max_dev. The
> >> root of the problem is that the bus->max_index is not decremented when a device
> >> is unplugged from the bus. This patch fixes that problem.
> >>
> >> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> >> ---
> >>   hw/core/qdev.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> >> index 6b3cc55b27c2..b35b0bf27925 100644
> >> --- a/hw/core/qdev.c
> >> +++ b/hw/core/qdev.c
> >> @@ -59,6 +59,8 @@ static void bus_remove_child(BusState *bus, DeviceState *child)
> >>               snprintf(name, sizeof(name), "child[%d]", kid->index);
> >>               QTAILQ_REMOVE(&bus->children, kid, sibling);
> >>   
> >> +            bus->max_index--;  
> > that might cause problem when bus is allowed to has more than 1 device
> > and unplugged device is not the last one.
> > In that case bus_add_child() might create a child with duplicate name.  
> 
> I see what you are saying. The max_index is assigned to the child device
> index in the bus_add_child() function. The child device index is used to
> generate a unique name for the child device. The generated name is then
> used to link the child as a property to the bus. When the child is
> removed from the bus, the name is regenerated from the child device
> index and the named property is . It would therefore appear that the
> real purpose of the max_index is to generate indexes for children of
> the bus thus ensuring each child has a unique index. In other words,
> the max_index value is only tangentially connected to indexing the list
> of children.
> 
> This results in a disconnect between the usage of the max_index value
> when adding and removing a child from the bus, and the check in the
> qbus_is_full() function which compares the max_index to the maximum
> number of devices allowed on the bus. If a child has been removed from
> the bus, the max_index value does not indicate whether the bus is
> full, it only specifies the index to be assigned to the next child to be
> added to the bus.
> 
> To resolve this problem, I propose the following:
> 
> Add the following field to struct BusState (include/hw/qdev_core.h):
> 
> struct BusState {
>      Object obj;
>      DeviceState *parent;
>      char *name;
>      HotplugHandler *hotplug_handler;
>      int max_index;
>      bool realized;
> +    int num_children;
>      QTAILQ_HEAD(ChildrenHead, BusChild) children;
>      QLIST_ENTRY(BusState) sibling;
> };
> 
> Add the following lines of code to the add/remove child functions in
> hw/core/qdev.c:
> 
> static void bus_add_child(BusState *bus, DeviceState *child)
> {
>      char name[32];
>      BusChild *kid = g_malloc0(sizeof(*kid));
> 
>      kid->index = bus->max_index++;
>      kid->child = child;
>      object_ref(OBJECT(kid->child));
> 
>      QTAILQ_INSERT_HEAD(&bus->children, kid, sibling);
> 
>      /* This transfers ownership of kid->child to the property.  */
>      snprintf(name, sizeof(name), "child[%d]", kid->index);
>      object_property_add_link(OBJECT(bus), name,
>                               object_get_typename(OBJECT(child)),
>                               (Object **)&kid->child,
>                               NULL, /* read-only property */
>                               0, /* return ownership on prop deletion */
>                               NULL);
> 
> +    bus->num_children++;
> }
> 
> static void bus_remove_child(BusState *bus, DeviceState *child)
> {
>      BusChild *kid;
> 
>      QTAILQ_FOREACH(kid, &bus->children, sibling) {
>          if (kid->child == child) {
>              char name[32];
> 
>              snprintf(name, sizeof(name), "child[%d]", kid->index);
>              QTAILQ_REMOVE(&bus->children, kid, sibling);
> 
>              /* This gives back ownership of kid->child back to us.  */
>              object_property_del(OBJECT(bus), name, NULL);
>              object_unref(OBJECT(kid->child));
>              g_free(kid);
> 
> +           bus->num_children--;
> 
>              return;
>          }
>      }
> }
> 
> Change the line of code in the qbus_is_full() function in
> qdev_monitor.c:
> 
> 
> static inline bool qbus_is_full(BusState *bus)
> {
>      BusClass *bus_class = BUS_GET_CLASS(bus);
> -    return bus_class->max_dev &&
> -           bus->max_index >= bus_class->max_dev;
> +    return bus_class->max_dev &&
> +           bus->num_children >= bus_class->max_dev;
> }
> 

looks good to me
[...]
