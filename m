Received: from eggs.gnu.org ([2001:4830:134:3::10]:45608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXkjU-0001IH-Kc
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXkjQ-0000aZ-OE
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:57:56 -0400
Date: Tue, 26 Jun 2018 11:57:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180626115747.41d1568c.cohuck@redhat.com>
In-Reply-To: <314001d8-64ea-f78e-e462-11bd5a18c730@redhat.com>
References: <20180625115352.6889-1-david@redhat.com>
	<20180625115352.6889-3-david@redhat.com>
	<20180625175029.69643252.cohuck@redhat.com>
	<1dd2ef76-311a-64f0-4c2c-2f80738ff8a7@redhat.com>
	<20180625180341.5a5b9fb7.cohuck@redhat.com>
	<314001d8-64ea-f78e-e462-11bd5a18c730@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 2/9] s390x/kvm: pass values
 instead of pointers to kvm_s390_set_clock_*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On Tue, 26 Jun 2018 11:54:32 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 25.06.2018 18:03, Cornelia Huck wrote:
> > On Mon, 25 Jun 2018 17:54:42 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 25.06.2018 17:50, Cornelia Huck wrote:  
> >>> On Mon, 25 Jun 2018 13:53:45 +0200
> >>> David Hildenbrand <david@redhat.com> wrote:
> >>>     
> >>>> We are going to factor out the TOD into a separate device and use const
> >>>> pointers for device class functions where possible. We are passing right
> >>>> now ordinary pointers that should never be touched when setting the TOD.
> >>>> Let's just pass the values directly.
> >>>>
> >>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>> ---
> >>>>  target/s390x/cpu.c       |  4 ++--
> >>>>  target/s390x/kvm-stub.c  |  4 ++--
> >>>>  target/s390x/kvm.c       | 12 ++++++------
> >>>>  target/s390x/kvm_s390x.h |  4 ++--
> >>>>  4 files changed, 12 insertions(+), 12 deletions(-)
> >>>>
> >>>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> >>>> index c268065887..68512e3e54 100644
> >>>> --- a/target/s390x/cpu.c
> >>>> +++ b/target/s390x/cpu.c
> >>>> @@ -413,9 +413,9 @@ int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)    
> >>>
> >>> Any reason why you keep the pointers here?
> >>>     
> >>>>      int r = 0;
> >>>>  
> >>>>      if (kvm_enabled()) {
> >>>> -        r = kvm_s390_set_clock_ext(tod_high, tod_low);
> >>>> +        r = kvm_s390_set_clock_ext(*tod_high, *tod_low);
> >>>>          if (r == -ENXIO) {
> >>>> -            return kvm_s390_set_clock(tod_high, tod_low);
> >>>> +            return kvm_s390_set_clock(*tod_high, *tod_low);    
> >>>
> >>> Especially as it would be more clean to check for !NULL before
> >>> dereferencing...    
> >>
> >> See the next patch :)
> >>
> >> (I assume that refactoring code in order to rip it out does not make sense)  
> > 
> > Add a comment in the commit message?
> > 
> > "Note that s390_set_clock() will be removed in a follow-on patch and
> > therefore its calling convention is not changed."
> >   
> 
> Sure I can do that. Thanks!
> 

Well, no need to respin if nothing else comes up, I can add that myself.
