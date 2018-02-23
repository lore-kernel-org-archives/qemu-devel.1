Received: from eggs.gnu.org ([2001:4830:134:3::10]:54026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ep9kk-0007zb-EK
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ep9kh-0006El-AE
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:34:54 -0500
Date: Fri, 23 Feb 2018 10:34:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180223103446.2a5b1255.cohuck@redhat.com>
In-Reply-To: <b156703a-b1b3-aa83-2c30-d07fec706ee0@linux.vnet.ibm.com>
References: <20180219174231.10874-1-david@redhat.com>
	<493dbfb3-086b-cc89-2d8d-4298345c6bb2@de.ibm.com>
	<ef55dc18-971f-b012-40cc-0c32f24664cf@redhat.com>
	<20180220155759.17dfd955.cohuck@redhat.com>
	<aeb36cb1-aadf-6146-9e59-549998538db1@redhat.com>
	<20180221183918.7cc4fad1.cohuck@redhat.com>
	<635dc4c5-8b54-9903-334c-d07cbc0d27f6@de.ibm.com>
	<b156703a-b1b3-aa83-2c30-d07fec706ee0@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFCv2] s390x/sclp: remove memory hotplug
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Thu, 22 Feb 2018 14:29:09 -0500
Matthew Rosato <mjrosato@linux.vnet.ibm.com> wrote:

> On 02/22/2018 06:13 AM, Christian Borntraeger wrote:
> > 
> > 
> > On 02/21/2018 06:39 PM, Cornelia Huck wrote:  
> >> On Tue, 20 Feb 2018 16:05:54 +0100
> >> David Hildenbrand <david@redhat.com> wrote:
> >>  
> >>> On 20.02.2018 15:57, Cornelia Huck wrote:  
> >>>> On Tue, 20 Feb 2018 13:16:37 +0100
> >>>> David Hildenbrand <david@redhat.com> wrote:
> >>>>     
> >>>>> On 20.02.2018 13:05, Christian Borntraeger wrote:    
> >>>>>>
> >>>>>>
> >>>>>> On 02/19/2018 06:42 PM, David Hildenbrand wrote:      
> >>>>>>> From an architecture point of view, nothing can be mapped into the address
> >>>>>>> space on s390x. All there is is memory. Therefore there is also not really
> >>>>>>> an interface to communicate such information to the guest. All we can do is
> >>>>>>> specify the maximum ram address and guests can probe in that range if
> >>>>>>> memory is available and usable (TPROT).      
> >>>>>>
> >>>>>> In fact there is an interface in SCLP that describes the memory sizes (maximum in 
> >>>>>> read scp info) and the details (read_storage_element0_info).  I am asking myself
> >>>>>> if we should re-introduce read_storage_element_info and use that to avoid tprot      
> >>>>>
> >>>>> Yes, we could do that (basically V1 of this patch) but have to glue it
> >>>>> to the a compatibility machine then.    
> >>>>
> >>>> Actually, this makes quite a bit of sense (introduce the interface for
> >>>> everyone in 2.12 and turn it off in compat machines).    
> >>>
> >>> Jup, either 2.12 or 2.13, no need to hurry.
> >>>  
> >>>>
> >>>> Does real hardware have configurations where you can get the memory
> >>>> sizes, but not the attach/deattach support? (Hardware with the feature,
> >>>> but no standby memory defined?)    
> > 
> > We have different sclp facilities for attach/detach and information, so
> > we can implement that. 
> > 
> >   
> >>>
> >>> I would guess that "0" for standby memory is valid but only people with
> >>> access to documentation can answer that :)  
> >>
> >> So, should we go with this patch now and re-introduce the read
> >> functions if the above is indeed true?  
> > 
> > Yes, go with this patch. Right now Linux guests will not make use of that, so
> > we can re-add that if it turns out to be useful for future guests.
> > 
> > 
> > 
> > Matt, last chance to complain with reasons why we want to keep the current standby memory
> > solution in its current form. (Or please ack the patch if you agree)  
> 
> Nope, this makes sense given its incompatibility w/ the common layer.  I
> also agree with the prior comment that, should we revisit this feature
> in the future, it should probably be via an s390-specific interface.
> 
> Acked-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>

Thanks, applied (with the discussed description tweak) to s390-next.

We should also mention this in the changelog once this hits master.
I'll try to remember to do that.
