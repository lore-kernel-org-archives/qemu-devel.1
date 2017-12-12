Received: from eggs.gnu.org ([2001:4830:134:3::10]:58499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eOhwI-0007iZ-Kp
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:37:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eOhwE-0004Fq-NU
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:37:30 -0500
Date: Tue, 12 Dec 2017 11:37:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171212113715.7d724302.cohuck@redhat.com>
In-Reply-To: <2cad6e92-7370-d72c-ab59-909e5d15017a@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-5-david@redhat.com>
	<20171211181754.4a3b847d.cohuck@redhat.com>
	<08154f0d-d526-d735-a952-853fcabe946b@redhat.com>
	<20171212101545.3bbd19dc.cohuck@redhat.com>
	<2cad6e92-7370-d72c-ab59-909e5d15017a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2-12 04/15] s390x/flic: simplify
 flic initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>

On Tue, 12 Dec 2017 10:58:12 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 12.12.2017 10:15, Cornelia Huck wrote:
> > On Mon, 11 Dec 2017 21:34:20 +0100
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 11.12.2017 18:17, Cornelia Huck wrote:  
> >>> On Mon, 11 Dec 2017 14:47:29 +0100
> >>> David Hildenbrand <david@redhat.com> wrote:
> >>>     
> >>>> This makes it clearer, which device is used for which accelerator.
> >>>>
> >>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>> ---
> >>>>  hw/intc/s390_flic.c          |  9 +++++++--
> >>>>  hw/intc/s390_flic_kvm.c      | 12 ------------
> >>>>  include/hw/s390x/s390_flic.h |  9 ---------
> >>>>  3 files changed, 7 insertions(+), 23 deletions(-)
> >>>>
> >>>> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> >>>> index 6eaf178d79..a78bdf1d90 100644
> >>>> --- a/hw/intc/s390_flic.c
> >>>> +++ b/hw/intc/s390_flic.c
> >>>> @@ -40,11 +40,16 @@ void s390_flic_init(void)
> >>>>  {
> >>>>      DeviceState *dev;
> >>>>  
> >>>> -    dev = s390_flic_kvm_create();
> >>>> -    if (!dev) {
> >>>> +    if (kvm_enabled()) {
> >>>> +        dev = qdev_create(NULL, TYPE_KVM_S390_FLIC);
> >>>> +        object_property_add_child(qdev_get_machine(), TYPE_KVM_S390_FLIC,
> >>>> +                                  OBJECT(dev), NULL);
> >>>> +    } else if (tcg_enabled()) {
> >>>>          dev = qdev_create(NULL, TYPE_QEMU_S390_FLIC);
> >>>>          object_property_add_child(qdev_get_machine(), TYPE_QEMU_S390_FLIC,
> >>>>                                    OBJECT(dev), NULL);    
> >>>
> >>> Can you use TYPE_S390_FLIC_COMMON for attaching the flic to the machine?    
> >>
> >> I suggest doing that in a separate patch. (I remember that changing the
> >> name should not harm migration).  
> > 
> > I don't think it harms migration, as we hook up the same device as
> > before (just via the common flic device).
> > 
> > Probably does not make sense as a separate patch, though, as you touch
> > this code anyway.  
> 
> Please be aware that for object_property_add_child(), TYPE... is for our
> example the name of the child
> 
> /machine/s390-flic-qemu/
> /machine/s390x-flic-kvm/
> 
> Not a type. And that would mean a change.
> 
> 

Ugh. Ok, let's keep it. The skeys device (for example) used the common
name from the start.
