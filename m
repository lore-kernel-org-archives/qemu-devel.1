Received: from eggs.gnu.org ([209.51.188.92]:51456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goQVP-00005c-Lj
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goQVO-0003hV-TO
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:20:35 -0500
Date: Tue, 29 Jan 2019 11:20:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190129112024.401b8184.cohuck@redhat.com>
In-Reply-To: <d43e273d-ef90-9a1e-c87a-1365718d8978@linux.ibm.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<20190125135835.2d59b511.cohuck@redhat.com>
	<20190125150101.3b61f0a1@oc2783563651>
	<20190128180948.506a9695.cohuck@redhat.com>
	<20190128201548.1ecfb84f@oc2783563651>
	<d43e273d-ef90-9a1e-c87a-1365718d8978@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Mon, 28 Jan 2019 16:48:10 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 01/28/2019 02:15 PM, Halil Pasic wrote:
> > On Mon, 28 Jan 2019 18:09:48 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:

> I guess if
> > the ssch() returns with non cc == 0 the CP_PENDING ---IRQ---> IDLE
> > transition
> > won't take place. And I guess the IRQ is a final one.  
> 
> Yes this is the one point I hadn't seen explicitly stated.  We shouldn't 
> remain in state=BUSY if the ssch got cc!=0, and probably return to IDLE 
> when processing the failure.  In Connie's response (Mon, 28 Jan 2019 
> 18:24:24 +0100) to my note, she expressed some agreement to that.

Yes, I think that's what should happen.


> >> state for I/O)
> >> (normal ssch)
> >>
> >> BUSY --- IO_REQ ---> return -EAGAIN, stay in BUSY
> >> (user space is supposed to retry, as we'll eventually progress from
> >> BUSY)
> >>
> >> CP_PENDING --- IO_REQ ---> return -EBUSY, stay in CP_PENDING
> >> (user space is supposed to map this to the appropriate cc for the guest)  
> > 
> >  From this it seems you don't intend to issue the second  requested ssch()
> > any more (and don't want to do any translation). Is that right? (If it
> > is, that what I was asking for for a while, but then it's a pity for the
> > retries.)
> >   
> >>
> >> IDLE --- ASYNC_REQ ---> IDLE
> >> (user space is welcome to do anything else right away)  
> > 
> > Your idea is to not issue a requested hsch() if we think we are IDLE
> > it seems. Do I understand this right? We would end up with a different
> > semantic for hsch()/and csch() (compared to PoP) in the guest with this
> > (AFAICT).
> >   
> >>
> >> BUSY --- ASYNC_REQ ---> return -EAGAIN, stay in BUSY
> >> (user space is supposed to retry, as above)
> >>
> >> CP_PENDING --- ASYNC_REQ ---> return success, stay in CP_PENDING
> >> (the interrupt will get us out of CP_PENDING eventually)  
> > 
> > Issue (c|h)sch() is an action that is done on this internal
> > transition (within CP_PENDING).  
> 
> These three do read like CSCH/HSCH are subject to the same rules as 
> SSCH, when in fact they would be (among other reasons) issued to clean 
> up a lost interrupt from a previous SSCH.  So maybe return -EAGAIN on 
> state=BUSY (don't race ourselves with the start), but issue to hardware 
> if CP_PENDING.

I think there are some devices which require a certain hsch/csch
sequence during device bringup, so it's not just cleaning up after a
ssch. Therefore, we should always try to do the requested hsch/csch,
unless things like "we're in the process of translating a cp, and can't
deal with another request right now" prevent it.

> 
> If we get an async request when state=IDLE, then maybe just issue it for 
> fun, as if it were an SSCH?

For fun, but mainly because the guest wants it :)
