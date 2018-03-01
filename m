Received: from eggs.gnu.org ([2001:4830:134:3::10]:50302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1erNKp-000568-9V
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1erNKl-0003qL-V2
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:29:19 -0500
Date: Thu, 1 Mar 2018 12:28:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180301122854.GD2994@work-vm>
References: <20180228195320.165230-1-borntraeger@de.ibm.com>
	<79f7059b-f2d3-a758-6bb9-29433b31b313@redhat.com>
	<20180301092442.GA2994@work-vm>
	<aef0a651-4d04-13b1-76a6-0c1efb6c9e04@de.ibm.com>
	<20180301114543.GC2994@work-vm>
	<69654fb2-f5ba-c23b-f6f5-1b559692cf37@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69654fb2-f5ba-c23b-f6f5-1b559692cf37@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390/kvm: implement clearing part of
 IPL clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

* Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> 
> 
> On 03/01/2018 12:45 PM, Dr. David Alan Gilbert wrote:
> > * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> >>
> >>
> >> On 03/01/2018 10:24 AM, Dr. David Alan Gilbert wrote:
> >>> * Thomas Huth (thuth@redhat.com) wrote:
> >>>> On 28.02.2018 20:53, Christian Borntraeger wrote:
> >>>>> When a guests reboots with diagnose 308 subcode 3 it requests the memory
> >>>>> to be cleared. We did not do it so far. This does not only violate the
> >>>>> architecture, it also misses the chance to free up that memory on
> >>>>> reboot, which would help on host memory over commitment.  By using
> >>>>> ram_block_discard_range we can cover both cases.
> >>>>
> >>>> Sounds like a good idea. I wonder whether that release_all_ram()
> >>>> function should maybe rather reside in exec.c, so that other machines
> >>>> that want to clear all RAM at reset time can use it, too?
> >>>>
> >>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >>>>> ---
> >>>>>  target/s390x/kvm.c | 19 +++++++++++++++++++
> >>>>>  1 file changed, 19 insertions(+)
> >>>>>
> >>>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> >>>>> index 8f3a422288..2e145ad5c3 100644
> >>>>> --- a/target/s390x/kvm.c
> >>>>> +++ b/target/s390x/kvm.c
> >>>>> @@ -34,6 +34,8 @@
> >>>>>  #include "qapi/error.h"
> >>>>>  #include "qemu/error-report.h"
> >>>>>  #include "qemu/timer.h"
> >>>>> +#include "qemu/rcu_queue.h"
> >>>>> +#include "sysemu/cpus.h"
> >>>>>  #include "sysemu/sysemu.h"
> >>>>>  #include "sysemu/hw_accel.h"
> >>>>>  #include "hw/boards.h"
> >>>>> @@ -41,6 +43,7 @@
> >>>>>  #include "sysemu/device_tree.h"
> >>>>>  #include "exec/gdbstub.h"
> >>>>>  #include "exec/address-spaces.h"
> >>>>> +#include "exec/ram_addr.h"
> >>>>>  #include "trace.h"
> >>>>>  #include "qapi-event.h"
> >>>>>  #include "hw/s390x/s390-pci-inst.h"
> >>>>> @@ -1841,6 +1844,14 @@ static int kvm_arch_handle_debug_exit(S390CPU *cpu)
> >>>>>      return ret;
> >>>>>  }
> >>>>>  
> >>>>> +static void release_all_rams(void)
> >>>>
> >>>> s/rams/ram/ maybe?
> >>>>
> >>>>> +{
> >>>>> +    struct RAMBlock *rb;
> >>>>> +
> >>>>> +    QLIST_FOREACH_RCU(rb, &ram_list.blocks, next)
> >>>>> +        ram_block_discard_range(rb, 0, rb->used_length);
> >>>>
> >>>> From a coding style point of view, I think there should be curly braces
> >>>> around ram_block_discard_range() ?
> >>>
> >>> I think this might break if it happens during a postcopy migrate.
> >>> The destination CPU is running, so it can do a reboot at just the wrong
> >>> time; and then the pages (that are protected by userfaultfd) would get
> >>> deallocated and trigger userfaultfd requests if accessed.
> >>
> >> Yes, userfaultd/postcopy is really fragile and relies on things that are not
> >> necessarily true (e.g. virito-balloon can also invalidate pages).
> > 
> > That's why we use qemu_balloon_inhibit around postcopy to stop
> > ballooning; I'm not aware of anything else that does the same.
> 
> we also have at least the pte_unused thing in mm/rmap.c that clearly
> predates userfaultfd. We might need to look into this as well....

I've not come across that; what does that do?

> > 
> >> The right thing here would be to actually terminate the postcopy migrate but
> >> return it as "successful" (since we are going to clear that RAM anyway). Do 
> >> you see a good way to achieve that?
> > 
> > There's no current mechanism to do it; I think it would have to involve
> > some interaction with the source as well though to tell it that you
> > didn't need that area of RAM anyway.
> > 
> > However, there are more problems:
> >   a) Even forgetting the userfault problem, this is racy since during
> > postcopy you're still receiving blocks from the source at the same time;
> > so some of the area that you've discarded might get overwritten by data
> > from the source.
> 
> So how do you handle the case when the target system writes to memory
> that is still in flight? Can we build on that mechanism?

Once we've entered postcopy, a page is basically in one of two states:
   a) Not yet received - i.e. marked absent with MADV_DONTNEED;  if the
guest tries to write to it then it'll block with userfault and ask the
source for the page; so the write wont happen until the page arrives.
   b) Received - we've already got the page from the source; the source
never resends a page (once in postcopy) so now the destination can just
write to the page.

Once in postcopy, a page is received at most once (i.e. if it's not
been received during precopy).

I can imagine two ways of curing it:
   a) Simple but slow;  just read all the pages before doing the
discard,  this forces it to wait for the pages to be received.
   b) More complex but fast;  Add a message on the return path to the
source telling it that you're going to discard a range; the source then
marks it's notes as cleared for those pages and then sends some form of
ack, and at that point you drop it.

A 3rd; incomplete way; would be just to drop the userfaultfd on the
destination for the RAMBlocks that are being cleared;  but this does
leave the source state in a bit of a mess.


> >   b) Your release_all_rams seems to do all RAM Blocks - won't that nuke
> > any ROMs as well? Or maybe even flash?
> 
> ROMs loaded with load_elf (like our s390-ccw.img) are reloaded on every reset.
> See rom_reset in /hw/core/loader.c

Ah, so this is happening after your reset code you've added?

> Is this different with the x86 bios?

Not sure; I know x86 keeps some mirrored copies of ROMs across
reboots but I don't fully understand the mechanisms we use.
But the other case I was thinking of was stuff like pflash on x86 which
are the flash images holding variable data.
(Also watch out for the way ram_block_discard_range deals with file
backed memory; discarding is actually quite hard in some cases).

> >   c) In a normal precopy migration, I think you may also get old data;
> > Paolo said that an MADV_DONTNEED won't cause the dirty flags to be set,
> > so if the migrate has already sent the data for a page, and then this
> > happens, before the CPUs are stopped during the migration, when you
> > restart on the destination you'll have the old data.
> 
> Yes, looks like we might get non-cleared data. Could we maybe combine fixing
> and optimizing: we can stop tranmitting the memory and do a clean
> startup on the target side. In other words could we actually use the
> reset clear trigger to speed up migration?

They're separate problems because they happen on opposite sides; on
the source you've got a chance of doing that type of hack, but it would
be a bit invasive.

Dave

> 
> 
> 
> > 
> > Dave
> > 
> >>
> >>>
> >>> Dave
> >>>
> >>>>> +}
> >>>>> +
> >>>>>  int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> >>>>>  {
> >>>>>      S390CPU *cpu = S390_CPU(cs);
> >>>>> @@ -1853,6 +1864,14 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> >>>>>              ret = handle_intercept(cpu);
> >>>>>              break;
> >>>>>          case KVM_EXIT_S390_RESET:
> >>>>> +            if (run->s390_reset_flags & KVM_S390_RESET_CLEAR) {
> >>>>> +                /*
> >>>>> +                 * We will stop other CPUs anyway, avoid spurious crashes and
> >>>>> +                 * get all CPUs out. The reset will take care of the resume.
> >>>>> +                 */
> >>>>> +                pause_all_vcpus();
> >>>>> +                release_all_rams();
> >>>>> +            }
> >>>>>              s390_reipl_request();
> >>>>>              break;
> >>>>>          case KVM_EXIT_S390_TSCH:
> >>>>>
> >>>>
> >>>> Apart from the cosmetic nits, patch looks good to me.
> >>>>
> >>>>  Thomas
> >>> --
> >>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >>>
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
