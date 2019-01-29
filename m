Received: from eggs.gnu.org ([209.51.188.92]:49437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goQLh-0005F5-Dq
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goQLg-0007W7-6G
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:10:33 -0500
Date: Tue, 29 Jan 2019 11:10:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190129111022.538bea51.cohuck@redhat.com>
In-Reply-To: <20190128201548.1ecfb84f@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<20190125135835.2d59b511.cohuck@redhat.com>
	<20190125150101.3b61f0a1@oc2783563651>
	<20190128180948.506a9695.cohuck@redhat.com>
	<20190128201548.1ecfb84f@oc2783563651>
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
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Mon, 28 Jan 2019 20:15:48 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 28 Jan 2019 18:09:48 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Fri, 25 Jan 2019 15:01:01 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> > > On Fri, 25 Jan 2019 13:58:35 +0100
> > > Cornelia Huck <cohuck@redhat.com> wrote:  
> >   
> > > > - The code should not be interrupted while we process the channel
> > > >   program, do the ssch etc. We want the caller to try again later (i.e.
> > > >   return -EAGAIN)    
> > 
> > (...)
> >   
> > > > - With the async interface, we want user space to be able to submit a
> > > >   halt/clear while a start request is still in flight, but not while
> > > >   we're processing a start request with translation etc. We probably
> > > >   want to do -EAGAIN in that case.    
> > > 
> > > This reads very similar to your first point.  
> > 
> > Not quite. ssch() means that we have a cp around; for hsch()/csch() we
> > don't have such a thing. So we want to protect the process of
> > translating the cp etc., but we don't need such protection for the
> > halt/clear processing.
> >   
> 
> What does this don't 'need such protection' mean in terms of code,
> moving the unlock of the io_mutex upward (in
> vfio_ccw_async_region_write())?

We don't have a cp that we need to process, so we don't need protection
for that.

> > 
> > IDLE --- IO_REQ --> BUSY ---> CP_PENDING --- IRQ ---> IDLE (if final  
> 
> There ain't no trigger/action list  between BUSY and CP_PENDING.
> I'm also in the  dark about where the issuing of the ssch() happen
> here (is it an internal transition within CP_PENDING?). I guess if
> the ssch() returns with non cc == 0 the CP_PENDING ---IRQ---> IDLE
> transition
> won't take place. And I guess the IRQ is a final one.

Please refer to the original ideas. This is obviously not supposed to
be a complete description of every case we might encounter.

> > state for I/O)
> > (normal ssch)
> > 
> > BUSY --- IO_REQ ---> return -EAGAIN, stay in BUSY
> > (user space is supposed to retry, as we'll eventually progress from
> > BUSY)
> > 
> > CP_PENDING --- IO_REQ ---> return -EBUSY, stay in CP_PENDING
> > (user space is supposed to map this to the appropriate cc for the guest)  
> 
> From this it seems you don't intend to issue the second  requested ssch()
> any more (and don't want to do any translation). Is that right? (If it
> is, that what I was asking for for a while, but then it's a pity for the
> retries.)

Which "second requested ssch"? In the first case, user space is
supposed to retry; in the second case, it should map it to a cc (and
the guest does whatever it does on busy conditions). We can't issue a
ssch if we're not able to handle multiple cps.

> 
> > 
> > IDLE --- ASYNC_REQ ---> IDLE
> > (user space is welcome to do anything else right away)  
> 
> Your idea is to not issue a requested hsch() if we think we are IDLE
> it seems. Do I understand this right? We would end up with a different
> semantic for hsch()/and csch() (compared to PoP) in the guest with this
> (AFAICT).

Nope, we're doing hsch/csch. We're just not moving out of IDLE, as we
(a) don't have any cp processing we need to protect and (b) no need to
fence of multiple attempts of hsch/csch.

> 
> > 
> > BUSY --- ASYNC_REQ ---> return -EAGAIN, stay in BUSY
> > (user space is supposed to retry, as above)
> > 
> > CP_PENDING --- ASYNC_REQ ---> return success, stay in CP_PENDING
> > (the interrupt will get us out of CP_PENDING eventually)  
> 
> Issue (c|h)sch() is an action that is done on this internal 
> transition (within CP_PENDING).

Yes. hsch/csch do not trigger a state change (other than possibly
dropping into NOT_OPER for cc 3).
