Received: from eggs.gnu.org ([2001:4830:134:3::10]:34918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eYwrD-0003y3-DJ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eYwr8-0006yC-GL
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:34:35 -0500
Date: Tue, 9 Jan 2018 17:34:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180109173423.40bf859d.cohuck@redhat.com>
In-Reply-To: <627be0b5-d2f8-e151-5498-7cd512ce0500@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-7-david@redhat.com>
	<20171212144944.09860296.cohuck@redhat.com>
	<0aa794ee-c781-0cc4-3c0a-5f49ae495c63@de.ibm.com>
	<20171212152959.1ff2b7d5.cohuck@redhat.com>
	<835bc109-bc80-5405-2c5c-2eb9142550ac@redhat.com>
	<20171212162839.64ab2207.cohuck@redhat.com>
	<370f9234-81d0-e02d-da41-fc7fefef9736@de.ibm.com>
	<627be0b5-d2f8-e151-5498-7cd512ce0500@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2-12 06/15] s390x/flic: factor out
 injection of floating interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>

On Wed, 13 Dec 2017 10:31:58 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 13.12.2017 10:16, Christian Borntraeger wrote:
> > 
> > 
> > On 12/12/2017 04:28 PM, Cornelia Huck wrote:  
> >> On Tue, 12 Dec 2017 16:17:17 +0100
> >> David Hildenbrand <david@redhat.com> wrote:
> >>  
> >>> On 12.12.2017 15:29, Cornelia Huck wrote:  
> >>>> On Tue, 12 Dec 2017 15:13:46 +0100
> >>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >>>>     
> >>>>> On 12/12/2017 02:49 PM, Cornelia Huck wrote:    
> >>>>     
> >>>>>> One thing I noticed: You removed the caching of the flic (in the old
> >>>>>> kvm inject routine), and you generally do more qom invocations (first,
> >>>>>> to find the common flic; then, to translate to the qemu or kvm flic).
> >>>>>> Not sure if this might be a problem (probably not).      
> >>>>>
> >>>>> Is any of these calls on a potential fast path (e.g. guest without adapter
> >>>>> interrupts)? If yes, then QOM is a no-go since it is really slow.    
> >>>>
> >>>> At least the new airq interface was using QOM without caching before.
> >>>>
> >>>> It's basically about any interrupt; but otoh we are (for kvm) in
> >>>> userspace already. Caching the flic and just keeping the casting to the
> >>>> specialized flic might be ok (I'd guess that the lookup is the slowest
> >>>> path.)
> >>>>     
> >>>
> >>> Please note that the lookup is already cached in s390_get_flic(); That
> >>> should be sufficient, as it does the expensive lookup. One cache should
> >>> be enough, no?  
> >>
> >> Ah, missed that. So the old code actually did double caching...
> >>  
> >>>
> >>> The other conversions should be cheap (and already were in place in a
> >>> couple of places before).  
> >>
> >> Yes, object_resolve_path() is probably the most expensive one.
> >>
> >> Did anyone ever check if the (existing) conversions are actually
> >> measurable?  
> > 
> > Did some quick measurement.
> > the initial object resolve takes about 20000ns, the cached ones then is 2-5ns.
> > (measuring s390_get_flic function).
> > 
> > 
> > The other conversions (S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);)
> > takes about 15-25ns (up to 100 cycles). 
> > For irqfd users this does not matter, but things like plan9fs might benefit
> > if we speedup this lookup as well?  
> 
> Did you also measure the state conversion like QEMU_S390_FLIC() or
> KVM_S390_FLIC() ?
> 
> As we call e.g. QEMU_S390_FLIC() on a regular basis in TCG, it might
> then also make sense to speed that up.
> 
> a) cache the (converted) state and class in every function. Somewhat
> uglifies the code.
> 
> b) introduce new functions that return the cached value
> 
> Not sure what's better. I prefer to do this as a separate addon patch
> and can prepare something.

If you want to do it as addon, I vote for option b).

> 
> > 
> > 
> > PS: We can improve the initial object_resolve_path by doing the resolve not for
> > TYPE_KVM_S390_FLIC
> > but 
> > "/machine/" TYPE_KVM_S390_FLIC
> > (2500ns instead of 20000)
> > but its still way too slow.
> >   
> 
> Specifying the absolute path would be even faster I guess.
> 
> /machine/s390-flic-qemu/ ...

I don't think we really need to speed up the initial lookup.
