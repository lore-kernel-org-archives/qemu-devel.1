Received: from eggs.gnu.org ([2001:4830:134:3::10]:46540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cE3uz-0003R5-6n
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 19:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cE3uv-0005rc-81
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 19:47:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cE3uu-0005rC-VH
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 19:47:33 -0500
Date: Mon, 5 Dec 2016 22:47:29 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161206004729.GK13060@thinpad.lan.raisama.net>
References: <20161128171201.GD14328@thinpad.lan.raisama.net>
	<20161129105600.GA12426@amt.cnet>
	<20161129123405.GF14328@thinpad.lan.raisama.net>
	<20161129235427.GA23961@amt.cnet>
	<20161130130928.GJ14328@thinpad.lan.raisama.net>
	<20161201143900.GA17402@amt.cnet>
	<20161202135609.GC13060@thinpad.lan.raisama.net>
	<20161202223033.GB31213@amt.cnet>
	<20161205151742.GD13060@thinpad.lan.raisama.net>
	<20161205172013.GA4700@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161205172013.GA4700@amt.cnet>
Subject: Re: [Qemu-devel] [qemu patch V3 2/2] kvmclock: reduce kvmclock
 difference on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Dr David Alan Gilbert <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>

On Mon, Dec 05, 2016 at 03:20:16PM -0200, Marcelo Tosatti wrote:
> On Mon, Dec 05, 2016 at 01:17:42PM -0200, Eduardo Habkost wrote:
[...]
> > > >  
> > > > +static void kvm_get_clock(KVMClockState *s)
> > > > +{
> > > > +    struct kvm_clock_data data;
> > > > +    int ret;
> > > > +
> > > > +    ret = kvm_vm_ioctl(kvm_state, KVM_GET_CLOCK, &data);
> > > > +    if (ret < 0) {
> > > > +        fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(ret));
> > > > +        abort();
> > > > +    }
> > > > +    s->clock = data.clock;
> > > > +    s->clock_is_reliable = kvm_has_adjust_clock_stable();
> > > > +}
> > > > +
> > > 
> > > s->clock_is_reliable has to updated at migration, after 
> > > the first time KVM_SET_CLOCK is called. There is no other
> > > place where it should be updated.
> > 
> > I don't see why you claim that. We can simply update
> > s->clock_is_reliable the next time s->clock is updated. The only
> > code that reads s->clock checks s->clock_is_reliable first.
> > s->clock_is_reliable is a flag _about_ the value in s->clock. I
> > don't see why you want to update them at different times, if it
> > means more complex logic.
> 
> Because the table of (wanted) behaviour dictates that.

My suggestion also follows the table strictly.

> 
> > > This is the behaviour 
> > > desired, according to this table:
> > > 
> > > index:
> > > mig->c means use s->clock value from migration
> > > mig->m means read pvclock value from memory 
> > > (both at migration, only the first time kvmclock_change_vmstate
> > > is called).
> > > 
> > > runt->c means use KVM_GET_CLOCK/KVM_SET_CLOCK at runtime
> > > runt->m means read pvclock value from memory
> > > (both at runtime, after the first time kvmclock_change_vmstate
> > > is called).
> > > 
> > > SOURCE                DESTINATION             BEHAVIOUR
> > > get_clock_reliable    get_clock_reliable      mig->c,runt->c  1
> > > get_clock_reliable    ~get_clock_reliable     mig->c,runt->m  2
> > > ~get_clock_reliable   get_clock_reliable      mig->m,runt->c  3
> > > ~get_clock_reliable   ~get_clock_reliable     mig->m,runt->m  4
> > > 
> > > So looking at your patch below, and thinking of 
> > > kvm_get_clock() updating s->clock_is_reliable from 
> > > !running case (that is RUNNING -> ~RUNNING transition)
> > > makes no sense at all. That should not happen.
> > 
> > Why not?
> 
> Because we want the behaviour of the table above as follows:
> 
> First execution of ~RUNNING -> RUNNING transition:
> 
> * If source host supports reliable KVM_GET_CLOCK, then 
> its not necessary to read from guest memory (because there
> is no danger of KVM_GET_CLOCK returning a value which will cause 
> the guest to crash).

Correct. And this can be generalized to:

"If the host that set s->clock support reliable KVM_GET_CLOCK,
then its not necessary to read from guest memory [...]".

> 
> * If source host does NOT support reliable KVM_GET_CLOCK, then 
> it is necessary to read from guest memory (because there
> is danger of KVM_GET_CLOCK returning a value which will cause 
> the guest to crash).

Correct. And this can be generalized to:

"If host that set s->clock do NOT support reliable KVM_GET_CLOCK,
then it is necessary to read from guest memory [...]"


> 
> Second and subsequent executions of ~RUNNING -> RUNNING transition:
> (say if you pause the guest and continue it):
> 
> * If host supports reliable KVM_GET_CLOCK, then 
> its not necessary to read from guest memory (because there
> is no danger of KVM_GET_CLOCK returning a value which will cause 
> the guest to crash).
> 

Correct. And this can be generalized to:

"If the host that set s->clock support reliable KVM_GET_CLOCK,
then its not necessary to [...]".

> * If  host does NOT support reliable KVM_GET_CLOCK, then 
> it is necessary to read from guest memory (because there
> is danger of KVM_GET_CLOCK returning a value which will cause 
> the guest to crash).
> 
Correct. And this can be generalized to:

"If host that set s->clock do NOT support reliable KVM_GET_CLOCK,
then it is necessary to read from guest memory [...]"

> Does that make sense?

Yes. And settting s->clock_is_reliable and s->clock at the same
time guarantees that.

> 
> > > s->clock_is_reliable should be updated after the first
> > > time ~RUNNING -> RUNNING migration is done, which 
> > > is my patch does.
> > 
> > I don't see why. All we need is that s->clock_is_reliable get
> > updated before any code try to read s->clock again.
> 
> > > I think your s->clock,s->clock_is_reliable should be in sync
> > > suggestion comes from a misunderstanding of how they are used.
> > > 
> > > s->clock is not read if s->clock_is_reliable is set.
> > 
> > Did you mean "s->clock is not read if s->clock_is_reliable is
> > false"? You are right (except when kvmclock_current_nsec()==0?).
> > But this also means that the only code that reads s->clock also
> > checks s->clock_is_reliable first.
> > 
> > > 
> > > Look at my attached patch below (still untested, will test and then
> > > resubmit) and check whether it matches the behaviour 
> > > described in the table above.
> > 
> > It seems to match. But I don't see why my patch doesn't match the
> > table above.
> 
> Its just fragile Eduardo: if anyone comes and changes the
> code as follows.
> 
> Source: Does not support reliable KVM_GET_CLOCK.
> Destination: Does support reliable KVM_GET_CLOCK.
> 
> * Migration from remote host that does not support
>   reliable KVM_GET_CLOCK, to a host that supports it.
> 
> * Some modification is done so that:
> 
>     1) Incoming migration sets s->clock_is_reliable=false from source.
>     2) _Before_ vm_start(), new code decides to issue kvm_get_clock().
> 
> Your code sets s->clock_reliable = true (because local host supports
> it), and failure. Do you see the problem?

The whole point of (my version of) kvm_get_clock() is to set
s->clock. If any code wants to change s->clock before vm_start(),
we are already screwed. I really don't think this is a realistic
scenario.

If you also want a function that returns KVM_GET_CLOCK but do not
change s->clock or s->clock_is_reliable, you can write one and I
won't complain.

> 
> (*)
> 
> > > >  static void kvmclock_vm_state_change(void *opaque, int running,
> > > >                                       RunState state)
> > > >  {
> > > > @@ -91,16 +112,18 @@ static void kvmclock_vm_state_change(void *opaque, int running,
> > > >  
> > > >      if (running) {
> > > >          struct kvm_clock_data data = {};
> > > > -        uint64_t time_at_migration = kvmclock_current_nsec(s);
> > > >  
> > > >          s->clock_valid = false;
> > > >  
> > > > -        /* We can't rely on the migrated clock value, just discard it */
> > > > -        if (time_at_migration) {
> > > > -            s->clock = time_at_migration;
> > > > +        /* if host that set s->clock did not support reliable KVM_GET_CLOCK,
> > > > +         * read kvmclock value from memory
> > > > +         */
> > > > +        if (!s->clock_is_reliable) {
> > > > +            data.clock = kvmclock_current_nsec(s);
> > > > +        } else {
> > > > +            data.clock = s->clock;
> > > >          }
> > > >  
> > > > -        data.clock = s->clock;
> > > >          ret = kvm_vm_ioctl(kvm_state, KVM_SET_CLOCK, &data);
> > > >          if (ret < 0) {
> > > >              fprintf(stderr, "KVM_SET_CLOCK failed: %s\n", strerror(ret));
> > > > @@ -120,22 +143,23 @@ static void kvmclock_vm_state_change(void *opaque, int running,
> > > 
> > > >              }
> > > >          }
> > > >      } else {
> > > > -        struct kvm_clock_data data;
> > > > -        int ret;
> > > >  
> > > > +        /*FIXME: is this really possible to happen?
> > > > +         * Can kvmclock_vm_state_change(s, 0) be called twice without
> > > > +         * a kvmclock_vm_state_change(s, 1) call in between?
> > > > +         */
> > > 
> > > It can't: check the code where notifiers are called.
> > 
> > Yet another reason to simplify the code: if we don't need
> > different code paths for local stop/resume vs migration, we can
> > remove s->clock_valid completely.
> 
> Yes it can be removed... But i'm just trying to fix a bug, not rewrite
> code while at it.

No need to remove it right now. But if the logic can make the
extra field unnecessary, that's another reason to simplify it. I
normally don't care about 2 or 3 extra lines of code, but in this
case I really think the complexity you are adding is unnecessary.

> 
> > > >          if (s->clock_valid) {
> > > >              return;
> > > >          }
> > > >  
> > > >          kvm_synchronize_all_tsc();
> > > >  
> > > > -        ret = kvm_vm_ioctl(kvm_state, KVM_GET_CLOCK, &data);
> > > > -        if (ret < 0) {
> > > > -            fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(ret));
> > > > -            abort();
> > > > -        }
> > > > -        s->clock = data.clock;
> > > > -
> > > > +        kvm_get_clock(s);
> > > > +        /* FIXME: the comment below doesn't match what is done at
> > > > +         * kvmclock_pre_save(). The comment must be updated, or
> > > > +         * kvmclock_pre_save() must be changed. I don't know what's
> > > > +         * the right thing to do.
> > > > +         */
> > 
> > We still need to address this comment. Your patch keeps the
> > comment that contradicts kvmclock_pre_save().
> 
> The comment refers to the fact that you should not do:
> 
>     Event stop_vm()
>        saved_clock1 = KVM_GET_CLOCK.
> 
>     Then again with the VM stopped, overwrite saved_clock:
>         saved_clock2 = KVM_GET_CLOCK.
> 
>     You should always use saved_clock1. Thats what its about.

I am not sure I follow. pre_save runs after stop_vm() and
overwrites saved_clock1 (s->clock) with a new value, doesn't it?
So is it incorrect?

> 
> Updated it.
> 
> > 
> > > 
> > > This fails for all cases (1,2,3,4) in the table above.
> > 
> > I can't see why it fails. The ordering of events from migration
> > followed by vm stop/resume should be:
> > 
> >     | Event                       | s->clock         | s->clock_is_reliable
> > src | kvmclock_vm_state_change(0) | -                | -
> > src |   kvm_get_clock()           | TIME-AT-VM-STOP  | CAP_ADJUST_CLOCK-on-SRC
> > src | kvmclock_pre_save()         | TIME-AT-VM-STOP  | CAP_ADJUST_CLOCK-on-SRC
> > src |   kvm_get_clock()           | TIME-AT-PRE-SAVE | CAP_ADJUST_CLOCK-on-SRC
> > --- | MIGRATION                   | TIME-AT-PRE-SAVE | CAP_ADJUST_CLOCK-on-SRC
> > dst | kvmclock_vm_state_change(1) | TIME-AT-PRE-SAVE | CAP_ADJUST_CLOCK-on-SRC
> > dst |   KVM_SET_CLOCK             | TIME-AT-PRE-SAVE | CAP_ADJUST_CLOCK-on-SRC
> > dst | kvmclock_vm_state_change(0) | TIME-AT-PRE-SAVE | CAP_ADJUST_CLOCK-on-SRC
> > dst |   kvm_get_clock()           | TIME-AT-VM-STOP  | CAP_ADJUST_CLOCK-on-DEST
> > dst | kvmclock_vm_state_change(1) | TIME-AT-VM-STOP  | CAP_ADJUST_CLOCK-on-DEST
> > dst |   KVM_SET_CLOCK             | TIME-AT-VM-STOP  | CAP_ADJUST_CLOCK-on-DEST
> > 
> > Specific cases from your table are below. See the KVM_SET_CLOCK
> > rows.
> > 
> > Case 1:
> > 
> >     | Event                       | s->clock         | s->clock_is_reliable
> > src | kvmclock_vm_state_change(0) | -                | -
> > src |   kvm_get_clock()           | TIME-AT-VM-STOP  | 1
> > src | kvmclock_pre_save()         | TIME-AT-VM-STOP  | 1
> > src |   kvm_get_clock()           | TIME-AT-PRE-SAVE | 1
> > --- | MIGRATION                   | TIME-AT-PRE-SAVE | 1
> > dst | kvmclock_vm_state_change(1) | TIME-AT-PRE-SAVE | 1
> > dst |   KVM_SET_CLOCK(s->clock)   | TIME-AT-PRE-SAVE | 1
> > dst | kvmclock_vm_state_change(0) | TIME-AT-PRE-SAVE | 1
> > dst |   kvm_get_clock()           | TIME-AT-VM-STOP  | 1
> > dst | kvmclock_vm_state_change(1) | TIME-AT-VM-STOP  | 1
> > dst |   KVM_SET_CLOCK(s->clock)   | TIME-AT-VM-STOP  | 1
> > 
> > Case 2:
> > 
> >     | Event                       | s->clock         | s->clock_is_reliable
> > src | kvmclock_vm_state_change(0) | -                | -
> > src |   kvm_get_clock()           | TIME-AT-VM-STOP  | 1
> > src | kvmclock_pre_save()         | TIME-AT-VM-STOP  | 1
> > src |   kvm_get_clock()           | TIME-AT-PRE-SAVE | 1
> > --- | MIGRATION                   | TIME-AT-PRE-SAVE | 1
> > dst | kvmclock_vm_state_change(1) | TIME-AT-PRE-SAVE | 1
> > dst |   KVM_SET_CLOCK(s->clock)   | TIME-AT-PRE-SAVE | 1
> > dst | kvmclock_vm_state_change(0) | TIME-AT-PRE-SAVE | 1
> > dst |   kvm_get_clock()           | TIME-AT-VM-STOP  | 0
> > dst | kvmclock_vm_state_change(1) | TIME-AT-VM-STOP  | 0
> > dst |   KVM_SET_CLOCK(from_mem)   | TIME-AT-VM-STOP  | 0
> > 
> > Case 3:
> > 
> >     | Event                       | s->clock         | s->clock_is_reliable
> > src | kvmclock_vm_state_change(0) | -                | -
> > src |   kvm_get_clock()           | TIME-AT-VM-STOP  | 0
> > src | kvmclock_pre_save()         | TIME-AT-VM-STOP  | 0
> > src |   kvm_get_clock()           | TIME-AT-PRE-SAVE | 0
> > --- | MIGRATION                   | TIME-AT-PRE-SAVE | 0
> > dst | kvmclock_vm_state_change(1) | TIME-AT-PRE-SAVE | 0
> > dst |   KVM_SET_CLOCK(from_mem)   | TIME-AT-PRE-SAVE | 0
> > dst | kvmclock_vm_state_change(0) | TIME-AT-PRE-SAVE | 0
> > dst |   kvm_get_clock()           | TIME-AT-VM-STOP  | 1
> > dst | kvmclock_vm_state_change(1) | TIME-AT-VM-STOP  | 1
> > dst |   KVM_SET_CLOCK(s->clock)   | TIME-AT-VM-STOP  | 1
> > 
> > Case 4:
> > 
> >     | Event                       | s->clock         | s->clock_is_reliable
> > src | kvmclock_vm_state_change(0) | -                | -
> > src |   kvm_get_clock()           | TIME-AT-VM-STOP  | 0
> > src | kvmclock_pre_save()         | TIME-AT-VM-STOP  | 0
> > src |   kvm_get_clock()           | TIME-AT-PRE-SAVE | 0
> > --- | MIGRATION                   | TIME-AT-PRE-SAVE | 0
> > dst | kvmclock_vm_state_change(1) | TIME-AT-PRE-SAVE | 0
> > dst |   KVM_SET_CLOCK(from_mem)   | TIME-AT-PRE-SAVE | 0
> > dst | kvmclock_vm_state_change(0) | TIME-AT-PRE-SAVE | 0
> > dst |   kvm_get_clock()           | TIME-AT-VM-STOP  | 0
> > dst | kvmclock_vm_state_change(1) | TIME-AT-VM-STOP  | 0
> > dst |   KVM_SET_CLOCK(from_mem)   | TIME-AT-VM-STOP  | 0
> > 
> > 
> > 
[...]
> > >  static void kvmclock_vm_state_change(void *opaque, int running,
> > >                                       RunState state)
> > >  {
> > > @@ -91,15 +111,31 @@
> > >  
> > >      if (running) {
> > >          struct kvm_clock_data data = {};
> > > -        uint64_t time_at_migration = kvmclock_current_nsec(s);
> > > +        uint64_t pvclock_via_mem = 0;
> > >  
> > > -        s->clock_valid = false;
> > > +        /*
> > > +         * If the host where s->clock was read did not support reliable
> > > +         * KVM_GET_CLOCK, read kvmclock value from memory.
> > > +         */
> > > +        if (!s->clock_is_reliable) {
> > > +            pvclock_via_mem = kvmclock_current_nsec(s);
> > > +        }
> > >  
> > > -        /* We can't rely on the migrated clock value, just discard it */
> > > -        if (time_at_migration) {
> > > -            s->clock = time_at_migration;
> > > +        /* migration/savevm/init restore
> > > +         * update clock_is_reliable to match local
> > > +         * host capabilities.
> > > +         */
> > > +        if (s->clock_valid == false) {
> > > +            s->clock_is_reliable = kvm_has_adjust_clock_stable();
> > >          }
> > >  
> > 
> > If we are reusing clock_valid for a different purpose, I suggest
> > we rename it to something clearer, like "clock_is_local" or
> > "clock_is_stopped".
> > 
> > But I still don't see the need for this convoluted logic, if we
> > can simply set s->clock_is_reliable and s->clock at the same
> > time. This even allow us to remove s->clock_valid completely.
> > 
> > > +        /* We can't rely on the saved clock value, just discard it */
> > > +        if (pvclock_via_mem) {
> > > +            s->clock = pvclock_via_mem;
> > > +        }
> > > +
> > > +        s->clock_valid = false;
> > > +
> > 
> > I suggest the following on top of your patch. It removes 27
> > unnecessary lines from the code.
> > 
> > But, really, I'm tired of this discussion. If you want to keep
> > the complex logic you suggest and others are happy with it, go
> > ahead. You just won't get my Reviewed-by.
> 
> I have been addressing all the comments you made so far Eduardo, 
> and have a point at (*) which seems valid to me.
> This is the reason the patch is the way it is now.
> 
> But sure, i will include your next patch in the series, test 
> it, and if someone does kvm_get_clock() in between those two
> points in the code, then it'll break. I'll add a
> comment to that effect to warn users.

kvm_get_clock() changes s->clock too. If you set s->clock at the
wrong moment you'll have bigger problems than clock_is_reliable
being incorrect. But if your worry is kvm_get_clock(), then we
can just do the following. Would that be OK?

Then I can send a patch to remove clock_is_valid later, as a
follow-up.

(I have one additional comment about pre_save(), below)

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---

 hw/i386/kvm/clock.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index e179862..e2256a6 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -121,14 +121,6 @@ static void kvmclock_vm_state_change(void *opaque, int running,
             pvclock_via_mem = kvmclock_current_nsec(s);
         }
 
-        /* migration/savevm/init restore
-         * update clock_is_reliable to match local
-         * host capabilities.
-         */
-        if (s->clock_valid == false) {
-            s->clock_is_reliable = kvm_has_adjust_clock_stable();
-        }
-
         /* We can't rely on the saved clock value, just discard it */
         if (pvclock_via_mem) {
             s->clock = pvclock_via_mem;
@@ -164,6 +156,10 @@ static void kvmclock_vm_state_change(void *opaque, int running,
         kvm_synchronize_all_tsc();
 
         s->clock = kvm_get_clock();
+        /* any code that sets s->clock needs to ensure clock_is_reliable
+         * is correctly set.
+         */
+        s->clock_is_reliable = kvm_has_adjust_clock_stable();
         /*
          * If the VM is stopped, declare the clock state valid to
          * avoid re-reading it on next vmsave (which would return
@@ -177,10 +173,6 @@ static void kvmclock_realize(DeviceState *dev, Error **errp)
 {
     KVMClockState *s = KVM_CLOCK(dev);
 
-    if (kvm_has_adjust_clock_stable()) {
-        s->clock_is_reliable = true;
-    }
-
     qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
 }
 
 
> 
[...]
> > > +
> > > +static void kvmclock_pre_save(void *opaque)
> > > +{
> > > +    KVMClockState *s = opaque;
> > > +
> > 
> > We still need a comment here explaining why we need to re-read
> > the clock on pre_save if s->clock was already set on
> > kvmclock_vm_state_change().
> 
> OK.
> 
> > Also, what if we are migrating a VM that was already paused 10
> > minutes ago? Should we migrate the s->clock value from
> > 10 minutes ago, or the one read at pre_save?
> 
> The one read at pre_save. I'll add a comment.

Is it really valid to make the clock move on an already-paused
VM, only because it was migrated?

> 
> > > +    s->clock = kvm_get_clock();
> > > +}
> > > +

-- 
Eduardo
