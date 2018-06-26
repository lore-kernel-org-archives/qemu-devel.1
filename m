Received: from eggs.gnu.org ([2001:4830:134:3::10]:46098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXn6Y-0007zo-JI
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXn6V-0002Wm-Fj
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:29:54 -0400
Date: Tue, 26 Jun 2018 14:29:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180626142946.40d212be.cohuck@redhat.com>
In-Reply-To: <437da9a4-6f38-b51e-a26a-b183609ba081@redhat.com>
References: <20180625115352.6889-1-david@redhat.com>
	<20180625115352.6889-6-david@redhat.com>
	<70637e9f-6fd6-a92e-0d2e-878f23460ac3@redhat.com>
	<384da416-9ce3-30aa-7bff-0ff0652cb8f4@redhat.com>
	<20180626142702.444a3457.cohuck@redhat.com>
	<437da9a4-6f38-b51e-a26a-b183609ba081@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 5/9] s390x/tcg: properly
 implement the TOD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On Tue, 26 Jun 2018 14:28:18 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 26.06.2018 14:27, Cornelia Huck wrote:
> > On Tue, 26 Jun 2018 14:06:00 +0200
> > David Hildenbrand <david@redhat.com> wrote:

> >>>>  /* Set Clock Comparator */
> >>>>  void HELPER(sckc)(CPUS390XState *env, uint64_t time)
> >>>>  {
> >>>> +    S390TODState *td = s390_get_todstate();
> >>>> +    S390TODClass *tdc = S390_TOD_GET_CLASS(td);
> >>>> +    S390TOD tod_base;
> >>>> +
> >>>>      if (time == -1ULL) {
> >>>>          return;
> >>>>      }
> >>>>  
> >>>>      env->ckc = time;
> >>>>  
> >>>> +    tdc->get(td, &tod_base, &error_abort);
> >>>> +    tod_base.low -= time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));    
> >>>
> >>> So the tdc->get first adds the time2tod, and then you subtract it here
> >>> again? Can't you simply use td->base.low directly instead?    
> >>
> >> That might be a good idea, previously I had tdc->get_base(), but dropped
> >> it because it cannot be implemented for KVM.
> >>
> >> Simply accessing the member here should be fine. Thanks!  
> > 
> > So, we're guaranteed to have td->base.low at the correct value? (Sorry,
> > having a bit of a hard time following around here.)
> >   
> 
> Yes, just verified, changed and tested. We will have the value at that
> place.
> 
> I'll give some more time to review the other parts, then I can resend.

Ok, thx.
