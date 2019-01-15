Received: from eggs.gnu.org ([209.51.188.92]:34014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjKyY-0001Pp-8W
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 04:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjKyX-0001Qg-Bj
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 04:25:38 -0500
Date: Tue, 15 Jan 2019 10:25:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190115102526.07db06ac.cohuck@redhat.com>
In-Reply-To: <8db3c201-e92f-4d1d-ff7b-bd6de4d37ebb@redhat.com>
References: <20190110210358.24035-1-david@redhat.com>
	<4988f58e-4bc5-c622-53b7-cfda758304e1@redhat.com>
	<20190111103828.058ccc6c.cohuck@redhat.com>
	<c30709c1-9348-e4c9-22bb-95d6183163f3@linux.ibm.com>
	<20190114184431.56795d44.cohuck@redhat.com>
	<beff9759-d95f-4ba6-d049-aada148e162d@linux.ibm.com>
	<8db3c201-e92f-4d1d-ff7b-bd6de4d37ebb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] s390x/pci: Send correct
 event on hotplug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, 14 Jan 2019 21:59:58 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 14.01.19 21:00, Collin Walling wrote:
> > On 1/14/19 12:44 PM, Cornelia Huck wrote:  
> >> [restored cc:s]
> >>
> >> On Mon, 14 Jan 2019 11:06:19 +0100
> >> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>  
> >>> On 11/01/2019 10:38, Cornelia Huck wrote:  
> >>>> On Fri, 11 Jan 2019 08:16:41 +0100
> >>>> David Hildenbrand <david@redhat.com> wrote:
> >>>>     
> >>>>> On 10.01.19 22:03, David Hildenbrand wrote:    
> >>>>>> Comit 2c28c490571f ("s390x/pci: let pci devices start in configured mode")
> >>>>>> changed the initial state of zPCI devices from ZPCI_FS_STANDBY to
> >>>>>> ZPCI_FS_DISABLED (a.k.a. configured). However we still only send a
> >>>>>> HP_EVENT_RESERVED_TO_STANDBY event to the guest, indicating a wrong
> >>>>>> state.
> >>>>>>
> >>>>>> Let's send a HP_EVENT_TO_CONFIGURED event instead, to match the actual
> >>>>>> state the device is in.
> >>>>>>
> >>>>>> This fixes hotplugged devices having to be enabled explicitly in the
> >>>>>> guest e.g. via echo 1 > /sys/bus/pci/slots/00000000/power.
> >>>>>>
> >>>>>> Fixes: 2c28c490571f ("s390x/pci: let pci devices start in configured mode")
> >>>>>> Report-by: Cornelia Huck <cohuck@redhat.com>    
> >>>>
> >>>> Cool, works for me as well.
> >>>>
> >>>> Tested-by: Cornelia Huck <cohuck@redhat.com>
> >>>>
> >>>> Do we want to cc:stable? Probably not, as it's more annoying than
> >>>> critical, and pci hotplug does not seem to be much used on s390x.
> >>>>     
> >>>>>
> >>>>> If this patch is the right thing to do, then
> >>>>>
> >>>>> 1. s/Report-by/Reported-by/
> >>>>> 2. Dropping the "." from the subject
> >>>>>
> >>>>> (yes, it was late)    
> >>>>
> >>>> :) Can do while applying.
> >>>>     
> >>>>>
> >>>>> I wonder if we should do both events sequentially, but as I don't have
> >>>>> access to the architecture I have to rely on that this works :)    
> >>>>
> >>>> Yep, let's wait for feedback from folks with architecture access.
> >>>>     
> >>>
> >>> Works fine on the architecture too.
> >>>
> >>> Seems the logical thing to do for me.
> >>>
> >>> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>  
> >>
> >> Thanks for checking.
> >>
> >> I'd like to queue this, but I'd like an ack from Collin as well.
> >>  
> > 
> > Would you mind adding a comment somewhere that states something like
> > "we can safely bypass the standby state when PCI hotplugging for a guest" 
> > just to be clear that QEMU is a bit different from how we handle it on the LPAR
> > level?
> > 
> > That comment would more-or-less clarify why we set the ZPCI_FS_<STATE> directly
> > to disabled instead of to standby when hotplugging (which, AFAIU, is the order 
> > how things occur at the LPAR level)  
> 
> This patch relies on Christians patch, where the general concept was
> explained. As we changed the initial state, we have to send a
> corresponding hotplug event. But still we can add a comment to shine
> some light on the general concept.
> 
> @Conny, can you add after the first paragraph: (or let me know if you
> want a respin)
> 
> "On real HW, a PCI device always pops up in the STANDBY state. In QEMU,
> we decided to let it show up directly in the configured state (as
> configuring it is otherwise just an extra burden for the admin). We can
> safely bypass the STANDBY state when hotplugging PCI devices to a guest."

I'll just add that text.

> 
> > 
> > Otherwise,
> > 
> > Reviewed-by: Collin Walling <walling@linux.ibm.com>  
> 
> Thanks!
> 

Thanks!
