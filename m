Received: from eggs.gnu.org ([209.51.188.92]:50506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghde8-0007ko-3u
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghde6-0003b0-E5
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:57:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ghde5-0003ZY-7Q
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:57:30 -0500
Date: Thu, 10 Jan 2019 17:57:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190110175722.4ee8d4d6.cohuck@redhat.com>
In-Reply-To: <04965ae7-da3d-a68a-ce0c-eb0b02e542ed@linux.ibm.com>
References: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
	<112a03e6-3d6c-1c14-10ab-c9cea09ad388@linux.ibm.com>
	<20190108173113.3c2d830c.cohuck@redhat.com>
	<20190108175021.003deab9@oc2783563651>
	<20190108180615.7e48cf13.cohuck@redhat.com>
	<4876194e-1a87-1491-a8b3-eed5b0a9afe6@linux.ibm.com>
	<20190109111419.426ec6d7.cohuck@redhat.com>
	<a59d5b64-0fb3-4b70-96ff-b1a0c037c6ac@linux.ibm.com>
	<20190109183538.05bab3c8@oc2783563651>
	<04965ae7-da3d-a68a-ce0c-eb0b02e542ed@linux.ibm.com>
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
Cc: Halil Pasic <pasic@linux.ibm.com>, imammedo@redhat.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 10 Jan 2019 10:50:30 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 1/9/19 12:35 PM, Halil Pasic wrote:
> > On Wed, 9 Jan 2019 10:36:11 -0500
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >   
> >> On 1/9/19 5:14 AM, Cornelia Huck wrote:  
> >>> On Tue, 8 Jan 2019 15:34:37 -0500
> >>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >>>  
> >>>> On 1/8/19 12:06 PM, Cornelia Huck wrote:  
> >>>>> On Tue, 8 Jan 2019 17:50:21 +0100
> >>>>> Halil Pasic <pasic@linux.ibm.com> wrote:
> >>>>>       
> >>>>>> On Tue, 8 Jan 2019 17:31:13 +0100
> >>>>>> Cornelia Huck <cohuck@redhat.com> wrote:
> >>>>>>      
> >>>>>>> On Tue, 8 Jan 2019 11:08:56 -0500
> >>>>>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >>>>>>>          
> >>>>>>>> On 12/17/18 10:57 AM, Tony Krowiak wrote:  

> >>>>>>>>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> >>>>>>>>> index 6b3cc55b27c2..956923f33520 100644
> >>>>>>>>> --- a/hw/core/qdev.c
> >>>>>>>>> +++ b/hw/core/qdev.c
> >>>>>>>>> @@ -59,6 +59,8 @@ static void bus_remove_child(BusState *bus, DeviceState *child)
> >>>>>>>>>                  snprintf(name, sizeof(name), "child[%d]", kid->index);
> >>>>>>>>>                  QTAILQ_REMOVE(&bus->children, kid, sibling);
> >>>>>>>>>      
> >>>>>>>>> +            bus->num_children--;
> >>>>>>>>> +
> >>>>>>>>>                  /* This gives back ownership of kid->child back to us.  */
> >>>>>>>>>                  object_property_del(OBJECT(bus), name, NULL);
> >>>>>>>>>                  object_unref(OBJECT(kid->child));
> >>>>>>>>> @@ -73,6 +75,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
> >>>>>>>>>          char name[32];
> >>>>>>>>>          BusChild *kid = g_malloc0(sizeof(*kid));
> >>>>>>>>>      
> >>>>>>>>> +    bus->num_children++;
> >>>>>>>>>          kid->index = bus->max_index++;  
> >>>>>>>
> >>>>>>> Hm... I'm wondering what happens for insane numbers of hotplugging
> >>>>>>> operations here?
> >>>>>>>
> >>>>>>> (Preexisting problem for busses without limit, but busses with a limit
> >>>>>>> could now run into that as well.)
> >>>>>>>          
> >>>>>>
> >>>>>> How does this patch change things? I mean bus->num_children gets
> >>>>>> decremented on unplug.  
> >>>>>
> >>>>> We don't stop anymore if max_index >= max_dev, which means that we can
> >>>>> now trigger that even if max_dev != 0.  
> >>>>
> >>>> I guess I am missing your point. If max_dev == 0, then there is nothing
> >>>> stopping an insane number of hot plug operations; either before this
> >>>> patch, or with this patch. With the patch, once the number of children
> >>>> hot plugged reaches max_dev, the qbus_is_full function will return false
> >>>> and no more children can be plugged. If a child device is unplugged,
> >>>> the num_children - which counts the number of children attached to the
> >>>> bus - will be decremented, so it always reflects the number of children
> >>>> added to the bus. Besides, checking max_index against max_dev
> >>>> is erroneous, because max_index is incremented every time a child device
> >>>> is plugged and is never decremented. It really operates as more of a
> >>>> uinique identifier than a counter and is also used to create a unique
> >>>> property name when the child device is linked to the bus as a property
> >>>> (see bus_add_child function in hw/core/qdev.c).  
> >>>
> >>> Checking num_children against max_dev is the right thing to do, no
> >>> argument here.
> >>>
> >>> However, max_index continues to be incremented even if devices have
> >>> been unplugged again. That means it can overflow, as it is never bound
> >>> by the max_dev constraint.
> >>>
> >>> This has been a problem before for busses with an unrestricted number of
> >>> devices before, but with your patch, the problem is now triggerable for
> >>> all busses.
> >>>
> >>> Not a problem with your patch, but we might want to look into making
> >>> max_index overflow/wraparound save.  
> >>
> >> I see your point. It does beg the question, what are the chances that
> >> max_index reaches INT_MAX? In the interest of making this code more
> >> bullet proof, I suppose it is something that should be dealt with.

Yes, there's a low chance of hitting this problem during normal
operation, but you could do scripted plug/unplug to reach the limit
(and test a possible fix).

> >>
> >> A search reveals that max_index is used in only two places: It is used
> >> to set the index for a child of the bus (i.e., bus_add_child function in
> >> hw/core/qdev.c); and prior to this patch, to determine if max_dev has
> >> been exceeded (i.e., qbus_is_full function in qdev_monitor.c). From
> >> what I can see, the bus child index is used only to generate a property
> >> name of the format "child[%d]" so the child can be linked as a property
> >> of the bus (see bus_add_child and bus_remove_child functions in
> >> hw/core/qdev.c). Wraparound of the max_index would most likely result in
> >> generating a duplicate property name for the child.
> >>
> >> I propose two possible solutions:
> >>
> >> 1. When max_index reaches INT_MAX, do not allow any additional children
> >>      to be added to the bus.
> >>
> >> 2. Set a max_dev value of INT_MAX for the BusClass instance if the value
> >>      is not set (in the bus_class_init function in hw/core/bus.c).
> >>
> >> 3. Instead of generating the property name from the BusChild index
> >>      value, generate a UUID string. Since the index field of the BusChild
> >>      appears to be used only to generate the child's name, maybe change
> >>      the index field to a UUID field or a name field.
> >>  
> > 
> > Separate problem, separate patch, or?  
> 
> Good question.

I'd say it's definitely something that can be fixed separately, no need
to hold up this patch.

> 
> > 
> > UUID instead of index solves the problem of unique names I guess, but I
> > can't tell if that would be acceptable (interface stability, etc.).  
> 
> I may have missed something, but as currently used, the BusChild index
> is accessed in only two places; when the child is added to the bus and
> when it is removed from the bus. In both cases, it is used to derive
> a unique property name for the child device.
> 
> Speaking of index, it implies ordering of the bus's children. IMHO, it
> only makes semantical sense if the index changes when a child device
> with a lower index value is removed from the bus. If a child device
> has an index of 5 - i.e., the fifth child on the bus - and the child
> device with index 4 is removed, then the child device with index 5 is
> no longer the fifth child on the bus. Maybe its just the fact that
> these fields are named 'index'. The fact that they are not really used
> as indexes caused a bit of confusion for me when analyzing this code and
> seems like a misnomer to me.

Maybe the index tries to imply the order when they were added to the
bus. But we probably should not read too much into the name; I would
mainly expect them to use unique identifiers.

> 
> > 
> > The max_dev won't help because we can get a collision while maintaining
> > the invariant 'not more than 2 devices on the bus'.  
> 
> I don't understand, can you better explain what you mean? When you
> say "we can get a collision", are you talking about the property
> name? What does max_dev have to do with that? Please explain. What do
> you mean by "maintaining the invariant 'not more than 2 devices on the
> bus'"?
> 
> > 
> > So if we don't want to limit the number of hotplug operations, and we do
> > want to keep the allocation scheme before wrapping, the only solution I
> > see is looking for the first free identifier after we wrap.  
> 
> Are you are saying to look for the first index value that is not
> assigned to a BusChild object?

This seems to be the most sane solution.

> 
> > 
> > BTW I wonder if making max_index and index unsigned make things bit less
> > ugly.  
> 
> I thought the same. They could also be made unsigned long or
> unsigned long long to increase the number of child devices that can be
> plugged in before having to deal with exceeding the index value.

Making them unsigned long long would push the problem out far enough to
be irrelevant in practice. Not sure if we care about fixing it
completely, though.
