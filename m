Received: from eggs.gnu.org ([209.51.188.92]:51998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gguI5-0003sZ-2x
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gguI2-0006tR-BD
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:31:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gguI0-00061P-6X
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:31:42 -0500
Date: Tue, 8 Jan 2019 17:31:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190108173113.3c2d830c.cohuck@redhat.com>
In-Reply-To: <112a03e6-3d6c-1c14-10ab-c9cea09ad388@linux.ibm.com>
References: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
	<112a03e6-3d6c-1c14-10ab-c9cea09ad388@linux.ibm.com>
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
Cc: qemu-devel@nongnu.org, pasic@linux.ibm.com, imammedo@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>

On Tue, 8 Jan 2019 11:08:56 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 12/17/18 10:57 AM, Tony Krowiak wrote:
> > The qbus_is_full(BusState *bus) function (qdev_monitor.c) compares the max_index
> > value of the BusState structure with the max_dev value of the BusClass structure
> > to determine whether the maximum number of children has been reached for the
> > bus. The problem is, the max_index field of the BusState structure does not
> > necessarily reflect the number of devices that have been plugged into
> > the bus.
> > 
> > Whenever a child device is plugged into the bus, the bus's max_index value is
> > assigned to the child device and then incremented. If the child is subsequently
> > unplugged, the value of the max_index does not change and no longer reflects the
> > number of children.
> > 
> > When the bus's max_index value reaches the maximum number of devices
> > allowed for the bus (i.e., the max_dev field in the BusClass structure),
> > attempts to plug another device will be rejected claiming that the bus is
> > full -- even if the bus is actually empty.
> > 
> > To resolve the problem, a new 'num_children' field is being added to the
> > BusState structure to keep track of the number of children plugged into the
> > bus. It will be incremented when a child is plugged, and decremented when a
> > child is unplugged.
> > 
> > Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> > Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
> > Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> > ---
> >   hw/core/qdev.c         | 3 +++
> >   include/hw/qdev-core.h | 1 +
> >   qdev-monitor.c         | 2 +-
> >   3 files changed, 5 insertions(+), 1 deletion(-)  
> 
> Ping ...
> I could not determine who the maintainer is for the three files
> listed above. I checked the MAINTAINERS file and the prologue of each
> individual file. Can someone please tell me who is responsible
> for merging these changes? Any additional review comments?
> 
> > 
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index 6b3cc55b27c2..956923f33520 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -59,6 +59,8 @@ static void bus_remove_child(BusState *bus, DeviceState *child)
> >               snprintf(name, sizeof(name), "child[%d]", kid->index);
> >               QTAILQ_REMOVE(&bus->children, kid, sibling);
> >   
> > +            bus->num_children--;
> > +
> >               /* This gives back ownership of kid->child back to us.  */
> >               object_property_del(OBJECT(bus), name, NULL);
> >               object_unref(OBJECT(kid->child));
> > @@ -73,6 +75,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
> >       char name[32];
> >       BusChild *kid = g_malloc0(sizeof(*kid));
> >   
> > +    bus->num_children++;
> >       kid->index = bus->max_index++;

Hm... I'm wondering what happens for insane numbers of hotplugging
operations here?

(Preexisting problem for busses without limit, but busses with a limit
could now run into that as well.)

> >       kid->child = child;
> >       object_ref(OBJECT(kid->child));
> > diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> > index a24d0dd566e3..521f0a947ead 100644
> > --- a/include/hw/qdev-core.h
> > +++ b/include/hw/qdev-core.h
> > @@ -206,6 +206,7 @@ struct BusState {
> >       HotplugHandler *hotplug_handler;
> >       int max_index;
> >       bool realized;
> > +    int num_children;
> >       QTAILQ_HEAD(ChildrenHead, BusChild) children;
> >       QLIST_ENTRY(BusState) sibling;
> >   };
> > diff --git a/qdev-monitor.c b/qdev-monitor.c
> > index 07147c63bf8b..45a8ba49644c 100644
> > --- a/qdev-monitor.c
> > +++ b/qdev-monitor.c
> > @@ -414,7 +414,7 @@ static DeviceState *qbus_find_dev(BusState *bus, char *elem)
> >   static inline bool qbus_is_full(BusState *bus)
> >   {
> >       BusClass *bus_class = BUS_GET_CLASS(bus);
> > -    return bus_class->max_dev && bus->max_index >= bus_class->max_dev;
> > +    return bus_class->max_dev && bus->num_children >= bus_class->max_dev;
> >   }
> >   
> >   /*
> >   

The approach the patch takes looks sane to me.
