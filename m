Received: from eggs.gnu.org ([2001:4830:134:3::10]:54482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fRDLl-0000BH-Mj
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fRDLh-0007iC-Jz
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:06:25 -0400
Date: Fri, 8 Jun 2018 11:06:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180608110612.18ac915c@redhat.com>
In-Reply-To: <673ffa52-1e24-5d6c-5d6a-927d3df79273@redhat.com>
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-3-david@redhat.com>
	<20180608093406.30c878ec@bahia.lan>
	<4f518685-fcdb-7c3a-35d3-5a26374e0604@redhat.com>
	<20180608094657.4043502f@bahia.lan>
	<431d4fe5-5bfe-1ab3-00b5-610038a7a9ea@redhat.com>
	<2b431d32-9172-0517-4717-7ce50355b8db@redhat.com>
	<20180608103943.1d7e72ee@redhat.com>
	<673ffa52-1e24-5d6c-5d6a-927d3df79273@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 2/8] spapr: no need to
 verify the node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Fri, 8 Jun 2018 10:41:36 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 08.06.2018 10:39, Igor Mammedov wrote:
> > On Fri, 8 Jun 2018 10:07:31 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> On 08.06.2018 09:48, David Hildenbrand wrote:  
> >>> On 08.06.2018 09:46, Greg Kurz wrote:    
> >>>> On Fri, 8 Jun 2018 09:42:48 +0200
> >>>> David Hildenbrand <david@redhat.com> wrote:
> >>>>    
> >>>>> On 08.06.2018 09:34, Greg Kurz wrote:    
> >>>>>> On Thu,  7 Jun 2018 18:52:12 +0200
> >>>>>> David Hildenbrand <david@redhat.com> wrote:
> >>>>>>       
> >>>>>>> The node property can always be queried and the value has already been
> >>>>>>> verified in pc_dimm_realize().
> >>>>>>>
> >>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>>>>> ---
> >>>>>>>  hw/ppc/spapr.c | 9 +--------
> >>>>>>>  1 file changed, 1 insertion(+), 8 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>>>>> index 2375cbee12..d038f3243e 100644
> >>>>>>> --- a/hw/ppc/spapr.c
> >>>>>>> +++ b/hw/ppc/spapr.c
> >>>>>>> @@ -3578,14 +3578,7 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
> >>>>>>>              error_setg(errp, "Memory hotplug not supported for this machine");
> >>>>>>>              return;
> >>>>>>>          }
> >>>>>>> -        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP, errp);
> >>>>>>> -        if (*errp) {      
> >>>>>>
> >>>>>> Good riddance :)
> >>>>>>       
> >>>>>>> -            return;
> >>>>>>> -        }
> >>>>>>> -        if (node < 0 || node >= MAX_NODES) {
> >>>>>>> -            error_setg(errp, "Invaild node %d", node);
> >>>>>>> -            return;
> >>>>>>> -        }    
> >>
> >> Maybe turn that into an assert() instead? ... just for the paranoids ;-)
> >>  
> >>>>>>> +        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP, NULL);      
> >>>>>>
> >>>>>> Maybe pass &error_abort ?      
> >>>>>
> >>>>> I'm using the same access scheme as in hw/acpi/memory_hotplug.c
> >>>>>
> >>>>> ("error ignored" vs. "error leads to an abort") - but this will actually
> >>>>> never fail. But I can use error_abort here, does not matter.
> >>>>>    
> >>>>
> >>>> Heh, /me paranoid but this is David's call and he acked that already
> >>>> so I guess it's okay.    
> >>>
> >>> NULL makes it fit into a single line :)    
> >>
> >> +1 for error_abort, even if it takes another line.  
> > +1 for error_abort
> > call shouldn't fail, but if does it won't be silently ignored
> > and introduce undefined behavior.  
> 
> Maybe we should fix the others that pass in NULL.
> 
> (no, not me :D - I'm already busy with your requested pre_plug handling)
Add it to wiki page for bite sized tasks?

> 
> >   
> >>
> >>  Thomas  
> >   
> 
> 
