Received: from eggs.gnu.org ([2001:4830:134:3::10]:53838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eihB2-0005Xr-Ti
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eihAz-0002wZ-2K
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:51:20 -0500
Date: Mon, 5 Feb 2018 14:51:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180205145109.45cc28f2.cohuck@redhat.com>
In-Reply-To: <9ec94463-8ce0-65de-ad58-597be5f15605@de.ibm.com>
References: <20180202143746.204851-1-borntraeger@de.ibm.com>
	<20180202143746.204851-2-borntraeger@de.ibm.com>
	<20180205130427.4b6612d4.cohuck@redhat.com>
	<9ec94463-8ce0-65de-ad58-597be5f15605@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>

On Mon, 5 Feb 2018 14:44:36 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02/05/2018 01:04 PM, Cornelia Huck wrote:
> 
> > You're doing the crash_reason -> reason mapping here and also below.
> > Maybe introduce a helper for it?
> >   
> [....]
> >> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> >> index 8736001156..c6a23262a8 100644
> >> --- a/target/s390x/kvm.c
> >> +++ b/target/s390x/kvm.c
> >> @@ -1568,15 +1568,32 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
> >>      return r;
> >>  }
> >>  
> >> -static void unmanageable_intercept(S390CPU *cpu, const char *str, int pswoffset)
> >> +static void unmanageable_intercept(S390CPU *cpu, enum crash_reasons reason,
> >> +                                   int pswoffset)
> >>  {
> >>      CPUState *cs = CPU(cpu);
> >> +    const char *str;
> >>  
> >> +    switch (reason) {
> >> +    case CRASH_REASON_PGM:
> >> +        str = "program interrupt loop";
> >> +        break;
> >> +    case CRASH_REASON_EXT:
> >> +        str = "external interrupt loop";
> >> +        break;
> >> +    case CRASH_REASON_OPEREXC:
> >> +        str = "operation exception loop";
> >> +        break;
> >> +    default:
> >> +        str = "unknown crash reason";
> >> +        break;
> >> +    }
> >>      error_report("Unmanageable %s! CPU%i new PSW: 0x%016lx:%016lx",  
> > 
> > "Unmanageable unknown crash reason!" looks a bit odd. In this case,
> > "Unmanageable intercept!" would actually look a bit saner (but you
> > would not be able to use a common converter in that case). We can also
> > just simply keep it :)  
> 
> We could maybe just drop this print in kvm.c. qemu_system_guest_panicked below will
> trigger some logging as well (if enabled) and it will also notify libvirt about
> that. a future libvirt code will print something like
> panic s390: psw-mask='0x0000000000000000', psw-addr='0x0000000000000002', crash reason: operation exception loop
> anyway in the log file.
> 
> That would also address your concern from above.
> 

Yes, that would also work if we do some program check loop detection in
tcg in the future.
