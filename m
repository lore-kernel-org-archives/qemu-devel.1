Received: from eggs.gnu.org ([2001:4830:134:3::10]:59313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cDx4O-0004TL-0r
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cDx4J-00071G-LC
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:28:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cDx4J-00070n-8V
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:28:47 -0500
Date: Mon, 5 Dec 2016 15:20:16 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Message-ID: <20161205172013.GA4700@amt.cnet>
References: <20161128164522.GB4028@amt.cnet>
	<20161128171201.GD14328@thinpad.lan.raisama.net>
	<20161129105600.GA12426@amt.cnet>
	<20161129123405.GF14328@thinpad.lan.raisama.net>
	<20161129235427.GA23961@amt.cnet>
	<20161130130928.GJ14328@thinpad.lan.raisama.net>
	<20161201143900.GA17402@amt.cnet>
	<20161202135609.GC13060@thinpad.lan.raisama.net>
	<20161202223033.GB31213@amt.cnet>
	<20161205151742.GD13060@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161205151742.GD13060@thinpad.lan.raisama.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Dr David Alan Gilbert <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>

On Mon, Dec 05, 2016 at 01:17:42PM -0200, Eduardo Habkost wrote:
> On Fri, Dec 02, 2016 at 08:30:35PM -0200, Marcelo Tosatti wrote:
> > On Fri, Dec 02, 2016 at 11:56:09AM -0200, Eduardo Habkost wrote:
> > > On Thu, Dec 01, 2016 at 12:39:03PM -0200, Marcelo Tosatti wrote:
> > > > On Wed, Nov 30, 2016 at 11:09:28AM -0200, Eduardo Habkost wrote:
> > > > > On Tue, Nov 29, 2016 at 09:54:29PM -0200, Marcelo Tosatti wrote:
> > > > > > On Tue, Nov 29, 2016 at 10:34:05AM -0200, Eduardo Habkost wrote:
> > > > > > > On Tue, Nov 29, 2016 at 08:56:00AM -0200, Marcelo Tosatti wrote:
> > > > > > > > On Mon, Nov 28, 2016 at 03:12:01PM -0200, Eduardo Habkost wrote:
> > > > > > > > > On Mon, Nov 28, 2016 at 02:45:24PM -0200, Marcelo Tosatti wrote:
> > > > > > > > > > On Mon, Nov 28, 2016 at 12:13:22PM -0200, Eduardo Habkost wrote:
> > > > > > > > > > > Sorry for not noticing the following issues on the previous
> > > > > > > > > > > reviews. I was only paying attention to the vmstate and machine
> > > > > > > > > > > code:
> > > > > > > > > > > 
> > > > > > > > > > > On Mon, Nov 21, 2016 at 08:50:04AM -0200, Marcelo Tosatti wrote:
> > > > > > > > > > > > Check for KVM_CAP_ADJUST_CLOCK capability KVM_CLOCK_TSC_STABLE, which
> > > > > > > > > > > > indicates that KVM_GET_CLOCK returns a value as seen by the guest at
> > > > > > > > > > > > that moment.
> > > > > > > > > > > > 
> > > > > > > > > > > > For new machine types, use this value rather than reading 
> > > > > > > > > > > > from guest memory.
> > > > > > > > > > > > 
> > > > > > > > > > > > This reduces kvmclock difference on migration from 5s to 0.1s
> > > > > > > > > > > > (when max_downtime == 5s).
> > > > > > > > > > > > 
> > > > > > > > > > > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > > > > > > > > > > > 
> > > > > > > > > > > > ---
> > > > > > > > > > > >  hw/i386/kvm/clock.c    |  107 ++++++++++++++++++++++++++++++++++++++++++-------
> > > > > > > > > > > >  include/hw/i386/pc.h   |    5 ++
> > > > > > > > > > > >  target-i386/kvm.c      |    7 +++
> > > > > > > > > > > >  target-i386/kvm_i386.h |    1 
> > > > > > > > > > > >  4 files changed, 106 insertions(+), 14 deletions(-)
> > > > > > > > > > > > 
> > > > > > > > > > > > v2: 
> > > > > > > > > > > > - improve variable names (Juan)
> > > > > > > > > > > > - consolidate code on kvm_get_clock function (Paolo)
> > > > > > > > > > > > - return mach_use_reliable_get_clock from needed function (Paolo)
> > > > > > > > > > > > v3: 
> > > > > > > > > > > > - simplify check for src_use_reliable_get_clock (Eduardo)
> > > > > > > > > > > > - move src_use_reliable_get_clock initialization to realize (Eduardo)
> > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > Index: qemu-mig-advance-clock/hw/i386/kvm/clock.c
> > > > > > > > > > > > ===================================================================
> > > > > > > > > > > > --- qemu-mig-advance-clock.orig/hw/i386/kvm/clock.c	2016-11-17 15:07:11.220632761 -0200
> > > > > > > > > > > > +++ qemu-mig-advance-clock/hw/i386/kvm/clock.c	2016-11-17 15:11:51.372048640 -0200
> > > > > > > > > > > > @@ -36,6 +36,12 @@
> > > > > > > > > > > >  
> > > > > > > > > > > >      uint64_t clock;
> > > > > > > > > > > >      bool clock_valid;
> > > > > > > > > > > > +
> > > > > > > > > > > > +    /* whether machine supports reliable KVM_GET_CLOCK */
> > > > > > > > > > > > +    bool mach_use_reliable_get_clock;
> > > > > > > > > > > > +
> > > > > > > > > > > > +    /* whether source host supported reliable KVM_GET_CLOCK */
> > > > > > > > > > > > +    bool src_use_reliable_get_clock;
> > > > > > > > > > > >  } KVMClockState;
> > > > > > > > > > > >  
> > > > > > > > > > > >  struct pvclock_vcpu_time_info {
> > > > > > > > > > > > @@ -81,6 +87,19 @@
> > > > > > > > > > > >      return nsec + time.system_time;
> > > > > > > > > > > >  }
> > > > > > > > > > > >  
> > > > > > > > > > > > +static uint64_t kvm_get_clock(void)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +    struct kvm_clock_data data;
> > > > > > > > > > > > +    int ret;
> > > > > > > > > > > > +
> > > > > > > > > > > > +    ret = kvm_vm_ioctl(kvm_state, KVM_GET_CLOCK, &data);
> > > > > > > > > > > > +    if (ret < 0) {
> > > > > > > > > > > > +        fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(ret));
> > > > > > > > > > > > +                abort();
> > > > > > > > > > > > +    }
> > > > > > > > > > > > +    return data.clock;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >  static void kvmclock_vm_state_change(void *opaque, int running,
> > > > > > > > > > > >                                       RunState state)
> > > > > > > > > > > >  {
> > > > > > > > > > > > @@ -91,15 +110,36 @@
> > > > > > > > > > > 
> > > > > > > > > > > Can you please use "diff -p" on your patches?
> > > > > > > > > > > 
> > > > > > > > > > > >  
> > > > > > > > > > > >      if (running) {
> > > > > > > > > > > >          struct kvm_clock_data data = {};
> > > > > > > > > > > > -        uint64_t time_at_migration = kvmclock_current_nsec(s);
> > > > > > > > > > > > +        uint64_t pvclock_via_mem = 0;
> > > > > > > > > > > >  
> > > > > > > > > > > > -        s->clock_valid = false;
> > > > > > > > > > > > +        /* local (running VM) restore */
> > > > > > > > > > > > +        if (s->clock_valid) {
> > > > > > > > > > > > +            /*
> > > > > > > > > > > > +             * if host does not support reliable KVM_GET_CLOCK,
> > > > > > > > > > > > +             * read kvmclock value from memory
> > > > > > > > > > > > +             */
> > > > > > > > > > > > +            if (!kvm_has_adjust_clock_stable()) {
> > > > > > > > > > > 
> > > > > > > > > > > Why not use src_use_reliable_get_clock here, too? (Maybe rename
> > > > > > > > > > > it to simply clock_is_reliable?)
> > > > > > > > > > 
> > > > > > > > > > Because you end up mixing two mental ideas (one: whether the source
> > > > > > > > > > has KVM_GET_CLOCK, second: whether the destination has KVM_GET_CLOCK 
> > > > > > > > > > into one variable). I find it more confusing than not.
> > > > > > > > > > Maybe its just my limited brain but i find it
> > > > > > > > > > confusing.
> > > > > > > > > 
> > > > > > > > > I find it simpler and easier to reason about.
> > > > > > > > 
> > > > > > > > I disagree, but i don't mind. Is this what you refer to:
> > > > > > > > 
> > > > > > > > Index: qemu-mig-advance-clock/hw/i386/kvm/clock.c
> > > > > > > > ===================================================================
> > > > > > > > --- qemu-mig-advance-clock.orig/hw/i386/kvm/clock.c	2016-11-17 15:11:51.372048640 -0200
> > > > > > > > +++ qemu-mig-advance-clock/hw/i386/kvm/clock.c	2016-11-29 08:53:20.609817026 -0200
> > > > > > > > @@ -37,11 +37,11 @@
> > > > > > > >      uint64_t clock;
> > > > > > > >      bool clock_valid;
> > > > > > > >  
> > > > > > > > -    /* whether machine supports reliable KVM_GET_CLOCK */
> > > > > > > > +    /* whether machine type supports reliable get clock */
> > > > > > > >      bool mach_use_reliable_get_clock;
> > > > > > > >  
> > > > > > > > -    /* whether source host supported reliable KVM_GET_CLOCK */
> > > > > > > > -    bool src_use_reliable_get_clock;
> > > > > > > > +    /* whether clock is reliable */
> > > > > > > 
> > > > > > > I would make the comment more explicit about its meaning:
> > > > > > >   /* whether the 'clock' value was obtained in a host with
> > > > > > >    * reliable KVM_GET_CLOCK */
> > > > > > 
> > > > > > Done.
> > > > > > 
> > > > > > > > +    bool clock_is_reliable;
> > > > > > >
> > > > > > >  } KVMClockState;
> > > > > > > >  
> > > > > > > >  struct pvclock_vcpu_time_info {
> > > > > > > > @@ -112,25 +112,17 @@
> > > > > > > >          struct kvm_clock_data data = {};
> > > > > > > >          uint64_t pvclock_via_mem = 0;
> > > > > > > >  
> > > > > > > > -        /* local (running VM) restore */
> > > > > > > > -        if (s->clock_valid) {
> > > > > > > > -            /*
> > > > > > > > -             * if host does not support reliable KVM_GET_CLOCK,
> > > > > > > > -             * read kvmclock value from memory
> > > > > > > > -             */
> > > > > > > > -            if (!kvm_has_adjust_clock_stable()) {
> > > > > > > > -                pvclock_via_mem = kvmclock_current_nsec(s);
> > > > > > > > -            }
> > > > > > > > -        /* migration/savevm/init restore */
> > > > > > > > -        } else {
> > > > > > > > -            /*
> > > > > > > > -             * use s->clock in case machine uses reliable
> > > > > > > > -             * get clock and source host supported
> > > > > > > > -             * reliable get clock
> > > > > > > > -             */
> > > > > > > > -            if (!s->src_use_reliable_get_clock) {
> > > > > > > > -                pvclock_via_mem = kvmclock_current_nsec(s);
> > > > > > > > -            }
> > > > > > > > +
> > > > > > > 
> > > > > > > A comment here would be welcome. Something like: "If the host
> > > > > > > where s->clock was read did not support reliable KVM_GET_CLOCK,
> > > > > > > read kvmclock value from memory".
> > > > > > 
> > > > > > Done.
> > > > > > 
> > > > > > > > +        if (!s->clock_is_reliable) {
> > > > > > > > +            pvclock_via_mem = kvmclock_current_nsec(s);
> > > > > > > > +        }
> > > > > > > > +
> > > > > > > > +        /* migration/savevm/init restore
> > > > > > > > +         * update clock_is_reliable to match local
> > > > > > > > +         * host capabilities.
> > > > > > > > +         */
> > > > > > > > +        if (s->clock_valid == false) {
> > > > > > > 
> > > > > > > Why the s->clock_valid check? It seems unnecessary.
> > > > > > 
> > > > > > Because if s->clock_valid == false (from migration),
> > > > > > kvm_has_adjust_clock_stable() from the local host is irrelevant.
> > > > > 
> > > > > That's true, and that's why updating it on kvm_get_clock() looks
> > > > > like a more logical place.
> > > > 
> > > > But the current patch updates
> > > > s->clock_is_reliable at the "if (running)"
> > > > case of kvmclock_vm_state_change().
> > > > 
> > > > There, both s->clock_is_reliable and s->clock are
> > > > updated in sync:
> > > > 
> > > >         if (s->clock_valid == false) {
> > > >             s->clock_is_reliable = kvm_has_adjust_clock_stable();
> > > >         }
> > > > 
> > > >         /* We can't rely on the saved clock value, just discard it */
> > > >         if (pvclock_via_mem) {
> > > >             s->clock = pvclock_via_mem;
> > > >         }
> > > > 
> > > 
> > > Here s->clock is updated only to be used to set data.clock in the
> > > next line (and never used again). I'm talking about every other
> > > s->clock assignment in the code.
> > > 
> > > > However, there is no need to call kvm_get_clock() there.
> > > 
> > > I'm talking about the existing kvm_get_clock() calls.
> > > 
> > > > 
> > > > kvm_get_clock() is called at the "} else {" case.
> > > > 
> > > > Are you suggesting to
> > > > 
> > > > * move s->clock_is_reliable assignment to kvm_get_clock()
> > > > * move s->clock assignment to kvm_get_clock()
> > > > * call kvm_get_clock() from the "if (running)" because
> > > > the assignments are in that function now.
> > > 
> > > No.
> > > 
> > > > 
> > > > But you don't need KVM_GET_CLOCK to be called there.
> > > 
> > > This is what I'm suggesting:
> > > 
> > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > > [ehabkost: simplified migration logic]
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >  hw/i386/kvm/clock.c    | 95 ++++++++++++++++++++++++++++++++++++++++++--------
> > >  include/hw/i386/pc.h   |  5 +++
> > >  target-i386/kvm.c      |  7 ++++
> > >  target-i386/kvm_i386.h |  1 +
> > >  4 files changed, 94 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> > > index 0f75dd3..df07ec7 100644
> > > --- a/hw/i386/kvm/clock.c
> > > +++ b/hw/i386/kvm/clock.c
> > > @@ -35,6 +35,13 @@ typedef struct KVMClockState {
> > >      /*< public >*/
> > >  
> > >      uint64_t clock;
> > > +    /* whether the value in 'clock' is reliable (i.e. was set by a host
> > > +     * with reliable KVM_GET_CLOCK) */
> > > +    bool clock_is_reliable;
> > > +    /* Enable migration of clock_is_reliable. Some machine-types
> > > +     * will disable it for compatibility with older QEMU versions.
> > > +     */
> > > +    bool migrate_reliable_flag;
> > >      bool clock_valid;
> > >  } KVMClockState;
> > >  
> > > @@ -81,6 +88,20 @@ static uint64_t kvmclock_current_nsec(KVMClockState *s)
> > >      return nsec + time.system_time;
> > >  }
> > >  
> > > +static void kvm_get_clock(KVMClockState *s)
> > > +{
> > > +    struct kvm_clock_data data;
> > > +    int ret;
> > > +
> > > +    ret = kvm_vm_ioctl(kvm_state, KVM_GET_CLOCK, &data);
> > > +    if (ret < 0) {
> > > +        fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(ret));
> > > +        abort();
> > > +    }
> > > +    s->clock = data.clock;
> > > +    s->clock_is_reliable = kvm_has_adjust_clock_stable();
> > > +}
> > > +
> > 
> > s->clock_is_reliable has to updated at migration, after 
> > the first time KVM_SET_CLOCK is called. There is no other
> > place where it should be updated.
> 
> I don't see why you claim that. We can simply update
> s->clock_is_reliable the next time s->clock is updated. The only
> code that reads s->clock checks s->clock_is_reliable first.
> s->clock_is_reliable is a flag _about_ the value in s->clock. I
> don't see why you want to update them at different times, if it
> means more complex logic.

Because the table of (wanted) behaviour dictates that.

> > This is the behaviour 
> > desired, according to this table:
> > 
> > index:
> > mig->c means use s->clock value from migration
> > mig->m means read pvclock value from memory 
> > (both at migration, only the first time kvmclock_change_vmstate
> > is called).
> > 
> > runt->c means use KVM_GET_CLOCK/KVM_SET_CLOCK at runtime
> > runt->m means read pvclock value from memory
> > (both at runtime, after the first time kvmclock_change_vmstate
> > is called).
> > 
> > SOURCE                DESTINATION             BEHAVIOUR
> > get_clock_reliable    get_clock_reliable      mig->c,runt->c  1
> > get_clock_reliable    ~get_clock_reliable     mig->c,runt->m  2
> > ~get_clock_reliable   get_clock_reliable      mig->m,runt->c  3
> > ~get_clock_reliable   ~get_clock_reliable     mig->m,runt->m  4
> > 
> > So looking at your patch below, and thinking of 
> > kvm_get_clock() updating s->clock_is_reliable from 
> > !running case (that is RUNNING -> ~RUNNING transition)
> > makes no sense at all. That should not happen.
> 
> Why not?

Because we want the behaviour of the table above as follows:

First execution of ~RUNNING -> RUNNING transition:

* If source host supports reliable KVM_GET_CLOCK, then 
its not necessary to read from guest memory (because there
is no danger of KVM_GET_CLOCK returning a value which will cause 
the guest to crash).

* If source host does NOT support reliable KVM_GET_CLOCK, then 
it is necessary to read from guest memory (because there
is danger of KVM_GET_CLOCK returning a value which will cause 
the guest to crash).

Second and subsequent executions of ~RUNNING -> RUNNING transition:
(say if you pause the guest and continue it):

* If host supports reliable KVM_GET_CLOCK, then 
its not necessary to read from guest memory (because there
is no danger of KVM_GET_CLOCK returning a value which will cause 
the guest to crash).

* If  host does NOT support reliable KVM_GET_CLOCK, then 
it is necessary to read from guest memory (because there
is danger of KVM_GET_CLOCK returning a value which will cause 
the guest to crash).

Does that make sense?

> > s->clock_is_reliable should be updated after the first
> > time ~RUNNING -> RUNNING migration is done, which 
> > is my patch does.
> 
> I don't see why. All we need is that s->clock_is_reliable get
> updated before any code try to read s->clock again.

> > I think your s->clock,s->clock_is_reliable should be in sync
> > suggestion comes from a misunderstanding of how they are used.
> > 
> > s->clock is not read if s->clock_is_reliable is set.
> 
> Did you mean "s->clock is not read if s->clock_is_reliable is
> false"? You are right (except when kvmclock_current_nsec()==0?).
> But this also means that the only code that reads s->clock also
> checks s->clock_is_reliable first.
> 
> > 
> > Look at my attached patch below (still untested, will test and then
> > resubmit) and check whether it matches the behaviour 
> > described in the table above.
> 
> It seems to match. But I don't see why my patch doesn't match the
> table above.

Its just fragile Eduardo: if anyone comes and changes the
code as follows.

Source: Does not support reliable KVM_GET_CLOCK.
Destination: Does support reliable KVM_GET_CLOCK.

* Migration from remote host that does not support
  reliable KVM_GET_CLOCK, to a host that supports it.

* Some modification is done so that:

    1) Incoming migration sets s->clock_is_reliable=false from source.
    2) _Before_ vm_start(), new code decides to issue kvm_get_clock().

Your code sets s->clock_reliable = true (because local host supports
it), and failure. Do you see the problem?

(*)

> > >  static void kvmclock_vm_state_change(void *opaque, int running,
> > >                                       RunState state)
> > >  {
> > > @@ -91,16 +112,18 @@ static void kvmclock_vm_state_change(void *opaque, int running,
> > >  
> > >      if (running) {
> > >          struct kvm_clock_data data = {};
> > > -        uint64_t time_at_migration = kvmclock_current_nsec(s);
> > >  
> > >          s->clock_valid = false;
> > >  
> > > -        /* We can't rely on the migrated clock value, just discard it */
> > > -        if (time_at_migration) {
> > > -            s->clock = time_at_migration;
> > > +        /* if host that set s->clock did not support reliable KVM_GET_CLOCK,
> > > +         * read kvmclock value from memory
> > > +         */
> > > +        if (!s->clock_is_reliable) {
> > > +            data.clock = kvmclock_current_nsec(s);
> > > +        } else {
> > > +            data.clock = s->clock;
> > >          }
> > >  
> > > -        data.clock = s->clock;
> > >          ret = kvm_vm_ioctl(kvm_state, KVM_SET_CLOCK, &data);
> > >          if (ret < 0) {
> > >              fprintf(stderr, "KVM_SET_CLOCK failed: %s\n", strerror(ret));
> > > @@ -120,22 +143,23 @@ static void kvmclock_vm_state_change(void *opaque, int running,
> > 
> > >              }
> > >          }
> > >      } else {
> > > -        struct kvm_clock_data data;
> > > -        int ret;
> > >  
> > > +        /*FIXME: is this really possible to happen?
> > > +         * Can kvmclock_vm_state_change(s, 0) be called twice without
> > > +         * a kvmclock_vm_state_change(s, 1) call in between?
> > > +         */
> > 
> > It can't: check the code where notifiers are called.
> 
> Yet another reason to simplify the code: if we don't need
> different code paths for local stop/resume vs migration, we can
> remove s->clock_valid completely.

Yes it can be removed... But i'm just trying to fix a bug, not rewrite
code while at it.

> > >          if (s->clock_valid) {
> > >              return;
> > >          }
> > >  
> > >          kvm_synchronize_all_tsc();
> > >  
> > > -        ret = kvm_vm_ioctl(kvm_state, KVM_GET_CLOCK, &data);
> > > -        if (ret < 0) {
> > > -            fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(ret));
> > > -            abort();
> > > -        }
> > > -        s->clock = data.clock;
> > > -
> > > +        kvm_get_clock(s);
> > > +        /* FIXME: the comment below doesn't match what is done at
> > > +         * kvmclock_pre_save(). The comment must be updated, or
> > > +         * kvmclock_pre_save() must be changed. I don't know what's
> > > +         * the right thing to do.
> > > +         */
> 
> We still need to address this comment. Your patch keeps the
> comment that contradicts kvmclock_pre_save().

The comment refers to the fact that you should not do:

    Event stop_vm()
       saved_clock1 = KVM_GET_CLOCK.

    Then again with the VM stopped, overwrite saved_clock:
        saved_clock2 = KVM_GET_CLOCK.

    You should always use saved_clock1. Thats what its about.

Updated it.

> 
> > 
> > This fails for all cases (1,2,3,4) in the table above.
> 
> I can't see why it fails. The ordering of events from migration
> followed by vm stop/resume should be:
> 
>     | Event                       | s->clock         | s->clock_is_reliable
> src | kvmclock_vm_state_change(0) | -                | -
> src |   kvm_get_clock()           | TIME-AT-VM-STOP  | CAP_ADJUST_CLOCK-on-SRC
> src | kvmclock_pre_save()         | TIME-AT-VM-STOP  | CAP_ADJUST_CLOCK-on-SRC
> src |   kvm_get_clock()           | TIME-AT-PRE-SAVE | CAP_ADJUST_CLOCK-on-SRC
> --- | MIGRATION                   | TIME-AT-PRE-SAVE | CAP_ADJUST_CLOCK-on-SRC
> dst | kvmclock_vm_state_change(1) | TIME-AT-PRE-SAVE | CAP_ADJUST_CLOCK-on-SRC
> dst |   KVM_SET_CLOCK             | TIME-AT-PRE-SAVE | CAP_ADJUST_CLOCK-on-SRC
> dst | kvmclock_vm_state_change(0) | TIME-AT-PRE-SAVE | CAP_ADJUST_CLOCK-on-SRC
> dst |   kvm_get_clock()           | TIME-AT-VM-STOP  | CAP_ADJUST_CLOCK-on-DEST
> dst | kvmclock_vm_state_change(1) | TIME-AT-VM-STOP  | CAP_ADJUST_CLOCK-on-DEST
> dst |   KVM_SET_CLOCK             | TIME-AT-VM-STOP  | CAP_ADJUST_CLOCK-on-DEST
> 
> Specific cases from your table are below. See the KVM_SET_CLOCK
> rows.
> 
> Case 1:
> 
>     | Event                       | s->clock         | s->clock_is_reliable
> src | kvmclock_vm_state_change(0) | -                | -
> src |   kvm_get_clock()           | TIME-AT-VM-STOP  | 1
> src | kvmclock_pre_save()         | TIME-AT-VM-STOP  | 1
> src |   kvm_get_clock()           | TIME-AT-PRE-SAVE | 1
> --- | MIGRATION                   | TIME-AT-PRE-SAVE | 1
> dst | kvmclock_vm_state_change(1) | TIME-AT-PRE-SAVE | 1
> dst |   KVM_SET_CLOCK(s->clock)   | TIME-AT-PRE-SAVE | 1
> dst | kvmclock_vm_state_change(0) | TIME-AT-PRE-SAVE | 1
> dst |   kvm_get_clock()           | TIME-AT-VM-STOP  | 1
> dst | kvmclock_vm_state_change(1) | TIME-AT-VM-STOP  | 1
> dst |   KVM_SET_CLOCK(s->clock)   | TIME-AT-VM-STOP  | 1
> 
> Case 2:
> 
>     | Event                       | s->clock         | s->clock_is_reliable
> src | kvmclock_vm_state_change(0) | -                | -
> src |   kvm_get_clock()           | TIME-AT-VM-STOP  | 1
> src | kvmclock_pre_save()         | TIME-AT-VM-STOP  | 1
> src |   kvm_get_clock()           | TIME-AT-PRE-SAVE | 1
> --- | MIGRATION                   | TIME-AT-PRE-SAVE | 1
> dst | kvmclock_vm_state_change(1) | TIME-AT-PRE-SAVE | 1
> dst |   KVM_SET_CLOCK(s->clock)   | TIME-AT-PRE-SAVE | 1
> dst | kvmclock_vm_state_change(0) | TIME-AT-PRE-SAVE | 1
> dst |   kvm_get_clock()           | TIME-AT-VM-STOP  | 0
> dst | kvmclock_vm_state_change(1) | TIME-AT-VM-STOP  | 0
> dst |   KVM_SET_CLOCK(from_mem)   | TIME-AT-VM-STOP  | 0
> 
> Case 3:
> 
>     | Event                       | s->clock         | s->clock_is_reliable
> src | kvmclock_vm_state_change(0) | -                | -
> src |   kvm_get_clock()           | TIME-AT-VM-STOP  | 0
> src | kvmclock_pre_save()         | TIME-AT-VM-STOP  | 0
> src |   kvm_get_clock()           | TIME-AT-PRE-SAVE | 0
> --- | MIGRATION                   | TIME-AT-PRE-SAVE | 0
> dst | kvmclock_vm_state_change(1) | TIME-AT-PRE-SAVE | 0
> dst |   KVM_SET_CLOCK(from_mem)   | TIME-AT-PRE-SAVE | 0
> dst | kvmclock_vm_state_change(0) | TIME-AT-PRE-SAVE | 0
> dst |   kvm_get_clock()           | TIME-AT-VM-STOP  | 1
> dst | kvmclock_vm_state_change(1) | TIME-AT-VM-STOP  | 1
> dst |   KVM_SET_CLOCK(s->clock)   | TIME-AT-VM-STOP  | 1
> 
> Case 4:
> 
>     | Event                       | s->clock         | s->clock_is_reliable
> src | kvmclock_vm_state_change(0) | -                | -
> src |   kvm_get_clock()           | TIME-AT-VM-STOP  | 0
> src | kvmclock_pre_save()         | TIME-AT-VM-STOP  | 0
> src |   kvm_get_clock()           | TIME-AT-PRE-SAVE | 0
> --- | MIGRATION                   | TIME-AT-PRE-SAVE | 0
> dst | kvmclock_vm_state_change(1) | TIME-AT-PRE-SAVE | 0
> dst |   KVM_SET_CLOCK(from_mem)   | TIME-AT-PRE-SAVE | 0
> dst | kvmclock_vm_state_change(0) | TIME-AT-PRE-SAVE | 0
> dst |   kvm_get_clock()           | TIME-AT-VM-STOP  | 0
> dst | kvmclock_vm_state_change(1) | TIME-AT-VM-STOP  | 0
> dst |   KVM_SET_CLOCK(from_mem)   | TIME-AT-VM-STOP  | 0
> 
> 
> 
> > 
> > >          /*
> > >           * If the VM is stopped, declare the clock state valid to
> > >           * avoid re-reading it on next vmsave (which would return
> > > @@ -152,22 +176,65 @@ static void kvmclock_realize(DeviceState *dev, Error **errp)
> > >      qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
> > >  }
> > >  
> > > +static bool kvmclock_src_use_reliable_get_clock(void *opaque)
> > > +{
> > > +    KVMClockState *s = opaque;
> > > +
> > > +    return s->migrate_reliable_flag;
> > > +}
> > > +
> > > +static const VMStateDescription kvmclock_reliable_get_clock = {
> > > +    .name = "kvmclock/clock_is_reliable",
> > > +    .version_id = 1,
> > > +    .minimum_version_id = 1,
> > > +    .needed = kvmclock_src_use_reliable_get_clock,
> > > +    .fields = (VMStateField[]) {
> > > +        VMSTATE_BOOL(clock_is_reliable, KVMClockState),
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > > +static void kvmclock_pre_save(void *opaque)
> > > +{
> > > +    KVMClockState *s = opaque;
> > > +    /*TODO: add comment explaining why this is here:
> > > +     * "re-read clock value here because [...]"" */
> > > +
> > > +    /*XXX: is it correct to call kvm_get_clock() here
> > > +     * if s->clock_is_valid is true? (meaning the kvmclock was
> > > +     * already stopped)
> > > +     */
> > > +    kvm_get_clock(s);
> > > +}
> > > +
> > >  static const VMStateDescription kvmclock_vmsd = {
> > >      .name = "kvmclock",
> > >      .version_id = 1,
> > >      .minimum_version_id = 1,
> > > +    .pre_save = kvmclock_pre_save,
> > >      .fields = (VMStateField[]) {
> > >          VMSTATE_UINT64(clock, KVMClockState),
> > >          VMSTATE_END_OF_LIST()
> > > +    },
> > > +    .subsections = (const VMStateDescription * []) {
> > > +        &kvmclock_reliable_get_clock,
> > > +        NULL
> > >      }
> > >  };
> > >  
> > > +static Property kvmclock_properties[] = {
> > > +    DEFINE_PROP_BOOL("x-migrate-reliable-flag", KVMClockState,
> > > +                      migrate_reliable_flag, true),
> > > +    DEFINE_PROP_END_OF_LIST(),
> > > +};
> > > +
> > >  static void kvmclock_class_init(ObjectClass *klass, void *data)
> > >  {
> > >      DeviceClass *dc = DEVICE_CLASS(klass);
> > >  
> > >      dc->realize = kvmclock_realize;
> > >      dc->vmsd = &kvmclock_vmsd;
> > > +    dc->props = kvmclock_properties;
> > >  }
> > >  
> > >  static const TypeInfo kvmclock_info = {
> > > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > > index 4b74130..fb80d69 100644
> > > --- a/include/hw/i386/pc.h
> > > +++ b/include/hw/i386/pc.h
> > > @@ -372,6 +372,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
> > >  #define PC_COMPAT_2_7 \
> > >      HW_COMPAT_2_7 \
> > >      {\
> > > +        .driver   = "kvmclock",\
> > > +        .property = "x-migrate-reliable-flag",\
> > > +        .value    = "off",\
> > > +    },\
> > > +    {\
> > >          .driver   = TYPE_X86_CPU,\
> > >          .property = "l3-cache",\
> > >          .value    = "off",\
> > > diff --git a/target-i386/kvm.c b/target-i386/kvm.c
> > > index f62264a..10a9cd8 100644
> > > --- a/target-i386/kvm.c
> > > +++ b/target-i386/kvm.c
> > > @@ -117,6 +117,13 @@ bool kvm_has_smm(void)
> > >      return kvm_check_extension(kvm_state, KVM_CAP_X86_SMM);
> > >  }
> > >  
> > > +bool kvm_has_adjust_clock_stable(void)
> > > +{
> > > +    int ret = kvm_check_extension(kvm_state, KVM_CAP_ADJUST_CLOCK);
> > > +
> > > +    return (ret == KVM_CLOCK_TSC_STABLE);
> > > +}
> > > +
> > >  bool kvm_allows_irq0_override(void)
> > >  {
> > >      return !kvm_irqchip_in_kernel() || kvm_has_gsi_routing();
> > > diff --git a/target-i386/kvm_i386.h b/target-i386/kvm_i386.h
> > > index 7607929..bfce427 100644
> > > --- a/target-i386/kvm_i386.h
> > > +++ b/target-i386/kvm_i386.h
> > > @@ -17,6 +17,7 @@
> > >  
> > >  bool kvm_allows_irq0_override(void);
> > >  bool kvm_has_smm(void);
> > > +bool kvm_has_adjust_clock_stable(void);
> > >  void kvm_synchronize_all_tsc(void);
> > >  void kvm_arch_reset_vcpu(X86CPU *cs);
> > >  void kvm_arch_do_init_vcpu(X86CPU *cs);
> > > -- 
> > > 2.7.4
> > > 
> > > 
> > > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > If s->clock_valid == true, kvm_has_adjust_clock_stable() is
> > > > > > what decides whether to use KVM_GET_CLOCK or not.
> > > > > > 
> > > > > > > (If this is an optimization to avoid extra ioctl() calls, you can
> > > > > > > cache it inside kvm_has_adjust_clock_stable()).
> > > > > > 
> > > > > > Its not.
> > > > > > 
> > > > > > > > +            s->clock_is_reliable = kvm_has_adjust_clock_stable();
> > > > > > > >          }
> > > > > > > 
> > > > > > > This should go to kvm_get_clock(), so s->clock and
> > > > > > > s->clock_is_reliable are guaranteed to be always in sync.
> > > > > > 
> > > > > > No: the point to change clock_is_reliable is the following: whether 
> > > > > > its the first read of the clock (migration), or subsequent 
> > > > > > reads (normal machine operation).
> > > > > > 
> > > > > > Now kvm_get_clock() just reads the clock, so i don't see it as
> > > > > > the right place to change the variable.
> > > > > > 
> > > > > > Agreed?
> > > > > 
> > > > > I don't agree. clock_is_reliable is information about the current
> > > > > value in s->clock, I don't see why we need to change s->clock and
> > > > > s->clock_is_reliable at different places in the code.
> > > > > 
> > > > > Your code might work too, but I can't tell without reviewing very
> > > > > carefully the state transitions KVMClockState could go through. I
> > > > > don't see the point of making the state transitions in this code
> > > > > even more complex, if we can simply stick to a simple "s->clock
> > > > > and s->clock_is_reliable are always in sync" rule.
> > > > 
> > > > It is updating from the same place:
> > > > 
> > > >         /* migration/savevm/init restore
> > > >          * update clock_is_reliable to match local
> > > >          * host capabilities.
> > > >          */
> > > >         if (s->clock_valid == false) {
> > > >             s->clock_is_reliable = kvm_has_adjust_clock_stable();
> > > >         }
> > > > 
> > > >         /* We can't rely on the saved clock value, just discard it */
> > > >         if (pvclock_via_mem) {
> > > >             s->clock = pvclock_via_mem;
> > > >         }
> > > 
> > > I'm talking about the other s->clock assignments. This one
> > > doesn't even seem to be necessary.
> > 
> > It is necessary: this is how you read pvclock from memory.
> 
> It is not necessary if you set data.clock directly.
> 
> But this doesn't matter for this discussion. My new patch below
> keeps that line, just to make the diff smaller.
> 
> > 
> > > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > > >          /* We can't rely on the saved clock value, just discard it */
> > > > > > > > @@ -181,20 +173,14 @@
> > > > > > > >  {
> > > > > > > >      KVMClockState *s = KVM_CLOCK(dev);
> > > > > > > >  
> > > > > > > > -    /*
> > > > > > > > -     * On machine types that support reliable KVM_GET_CLOCK,
> > > > > > > > -     * if host kernel does provide reliable KVM_GET_CLOCK,
> > > > > > > > -     * set src_use_reliable_get_clock=true so that destination
> > > > > > > > -     * avoids reading kvmclock from memory.
> > > > > > > > -     */
> > > > > > > > -    if (s->mach_use_reliable_get_clock && kvm_has_adjust_clock_stable()) {
> > > > > > > > -        s->src_use_reliable_get_clock = true;
> > > > > > > > +    if (kvm_has_adjust_clock_stable()) {
> > > > > > > > +        s->clock_is_reliable = true;
> > > > > > > >      }
> > > > > > > >  
> > > > > > > >      qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
> > > > > > > >  }
> > > > > > > >  
> > > > > > > > -static bool kvmclock_src_use_reliable_get_clock(void *opaque)
> > > > > > > > +static bool kvmclock_clock_is_reliable_needed(void *opaque)
> > > > > > > >  {
> > > > > > > >      KVMClockState *s = opaque;
> > > > > > > >  
> > > > > > > > @@ -202,12 +188,12 @@
> > > > > > > >  }
> > > > > > > >  
> > > > > > > >  static const VMStateDescription kvmclock_reliable_get_clock = {
> > > > > > > > -    .name = "kvmclock/src_use_reliable_get_clock",
> > > > > > > > +    .name = "kvmclock/clock_is_reliable",
> > > > > > > >      .version_id = 1,
> > > > > > > >      .minimum_version_id = 1,
> > > > > > > > -    .needed = kvmclock_src_use_reliable_get_clock,
> > > > > > > > +    .needed = kvmclock_clock_is_reliable_needed,
> > > > > > > >      .fields = (VMStateField[]) {
> > > > > > > > -        VMSTATE_BOOL(src_use_reliable_get_clock, KVMClockState),
> > > > > > > > +        VMSTATE_BOOL(clock_is_reliable, KVMClockState),
> > > > > > > >          VMSTATE_END_OF_LIST()
> > > > > > > >      }
> > > > > > > >  };
> > > > > > > 
> > > > > > > -- 
> > > > > > > Eduardo
> > > > > 
> > > > > -- 
> > > > > Eduardo
> > > 
> > > -- 
> > > Eduardo
> > 
> > 
> > kvmclock: reduce kvmclock difference on migration
> > 
> > Check for KVM_CAP_ADJUST_CLOCK capability KVM_CLOCK_TSC_STABLE, which
> > indicates that KVM_GET_CLOCK returns a value as seen by the guest at
> > that moment.
> > 
> > For new machine types, use this value rather than reading 
> > from guest memory.
> > 
> > This reduces kvmclock difference on migration from 5s to 0.1s
> > (when max_downtime == 5s).
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> >  hw/i386/kvm/clock.c    |   97 +++++++++++++++++++++++++++++++++++++++++--------
> >  include/hw/i386/pc.h   |    5 ++
> >  target-i386/kvm.c      |    7 +++
> >  target-i386/kvm_i386.h |    1 
> >  4 files changed, 96 insertions(+), 14 deletions(-)
> > 
> > v2: 
> > - improve variable names (Juan)
> > - consolidate code on kvm_get_clock function (Paolo)
> > - return mach_use_reliable_get_clock from needed function (Paolo)
> > v3: 
> > - simplify check for src_use_reliable_get_clock (Eduardo)
> > - move src_use_reliable_get_clock initialization to realize (Eduardo)
> > 
> > 
> > Index: qemu-mig-advance-clock/hw/i386/kvm/clock.c
> > ===================================================================
> > --- qemu-mig-advance-clock.orig/hw/i386/kvm/clock.c	2016-11-17 15:07:11.220632761 -0200
> > +++ qemu-mig-advance-clock/hw/i386/kvm/clock.c	2016-12-01 12:43:18.606294830 -0200
> > @@ -36,6 +36,13 @@
> >  
> >      uint64_t clock;
> >      bool clock_valid;
> > +
> > +    /* whether machine type supports reliable get clock */
> > +    bool mach_use_reliable_get_clock;
> > +
> > +    /* whether the 'clock' value was obtained in a host with
> > +     * reliable KVM_GET_CLOCK */
> > +    bool clock_is_reliable;
> >  } KVMClockState;
> >  
> >  struct pvclock_vcpu_time_info {
> > @@ -81,6 +88,19 @@
> >      return nsec + time.system_time;
> >  }
> >  
> > +static uint64_t kvm_get_clock(void)
> > +{
> > +    struct kvm_clock_data data;
> > +    int ret;
> > +
> > +    ret = kvm_vm_ioctl(kvm_state, KVM_GET_CLOCK, &data);
> > +    if (ret < 0) {
> > +        fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(ret));
> > +                abort();
> > +    }
> > +    return data.clock;
> > +}
> > +
> >  static void kvmclock_vm_state_change(void *opaque, int running,
> >                                       RunState state)
> >  {
> > @@ -91,15 +111,31 @@
> >  
> >      if (running) {
> >          struct kvm_clock_data data = {};
> > -        uint64_t time_at_migration = kvmclock_current_nsec(s);
> > +        uint64_t pvclock_via_mem = 0;
> >  
> > -        s->clock_valid = false;
> > +        /*
> > +         * If the host where s->clock was read did not support reliable
> > +         * KVM_GET_CLOCK, read kvmclock value from memory.
> > +         */
> > +        if (!s->clock_is_reliable) {
> > +            pvclock_via_mem = kvmclock_current_nsec(s);
> > +        }
> >  
> > -        /* We can't rely on the migrated clock value, just discard it */
> > -        if (time_at_migration) {
> > -            s->clock = time_at_migration;
> > +        /* migration/savevm/init restore
> > +         * update clock_is_reliable to match local
> > +         * host capabilities.
> > +         */
> > +        if (s->clock_valid == false) {
> > +            s->clock_is_reliable = kvm_has_adjust_clock_stable();
> >          }
> >  
> 
> If we are reusing clock_valid for a different purpose, I suggest
> we rename it to something clearer, like "clock_is_local" or
> "clock_is_stopped".
> 
> But I still don't see the need for this convoluted logic, if we
> can simply set s->clock_is_reliable and s->clock at the same
> time. This even allow us to remove s->clock_valid completely.
> 
> > +        /* We can't rely on the saved clock value, just discard it */
> > +        if (pvclock_via_mem) {
> > +            s->clock = pvclock_via_mem;
> > +        }
> > +
> > +        s->clock_valid = false;
> > +
> 
> I suggest the following on top of your patch. It removes 27
> unnecessary lines from the code.
> 
> But, really, I'm tired of this discussion. If you want to keep
> the complex logic you suggest and others are happy with it, go
> ahead. You just won't get my Reviewed-by.

I have been addressing all the comments you made so far Eduardo, 
and have a point at (*) which seems valid to me.
This is the reason the patch is the way it is now.

But sure, i will include your next patch in the series, test 
it, and if someone does kvm_get_clock() in between those two
points in the code, then it'll break. I'll add a
comment to that effect to warn users.

> But in addition to this discussion about migration_is_safe, I
> have a question below about kvmclock_pre_save(), which seems to
> be a real problem. See below.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/i386/kvm/clock.c | 37 +++++--------------------------------
>  1 file changed, 5 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index e179862..359abce 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -35,8 +35,6 @@ typedef struct KVMClockState {
>      /*< public >*/
>  
>      uint64_t clock;
> -    bool clock_valid;
> -
>      /* whether machine type supports reliable get clock */
>      bool mach_use_reliable_get_clock;
>  
> @@ -88,7 +86,7 @@ static uint64_t kvmclock_current_nsec(KVMClockState *s)
>      return nsec + time.system_time;
>  }
>  
> -static uint64_t kvm_get_clock(void)
> +static void kvm_get_clock(KVMClockState *s)
>  {
>      struct kvm_clock_data data;
>      int ret;
> @@ -98,7 +96,8 @@ static uint64_t kvm_get_clock(void)
>          fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(ret));
>                  abort();
>      }
> -    return data.clock;
> +    s->clock = data.clock;
> +    s->clock_is_reliable = kvm_has_adjust_clock_stable();
>  }
>  
>  static void kvmclock_vm_state_change(void *opaque, int running,
> @@ -121,21 +120,11 @@ static void kvmclock_vm_state_change(void *opaque, int running,
>              pvclock_via_mem = kvmclock_current_nsec(s);
>          }
>  
> -        /* migration/savevm/init restore
> -         * update clock_is_reliable to match local
> -         * host capabilities.
> -         */
> -        if (s->clock_valid == false) {
> -            s->clock_is_reliable = kvm_has_adjust_clock_stable();
> -        }
>          /* We can't rely on the saved clock value, just discard it */
>          if (pvclock_via_mem) {
>              s->clock = pvclock_via_mem;
>          }
>  
> -        s->clock_valid = false;
> -
>          data.clock = s->clock;
>          ret = kvm_vm_ioctl(kvm_state, KVM_SET_CLOCK, &data);
>          if (ret < 0) {
> @@ -156,20 +145,8 @@ static void kvmclock_vm_state_change(void *opaque, int running,
>              }
>          }
>      } else {
> -
> -        if (s->clock_valid) {
> -            return;
> -        }
> -
>          kvm_synchronize_all_tsc();
> -
> -        s->clock = kvm_get_clock();
> -        /*
> -         * If the VM is stopped, declare the clock state valid to
> -         * avoid re-reading it on next vmsave (which would return
> -         * a different value). Will be reset when the VM is continued.
> -         */
> -        s->clock_valid = true;
> +        kvm_get_clock(s);
>      }
>  }
>  
> @@ -177,10 +154,6 @@ static void kvmclock_realize(DeviceState *dev, Error **errp)
>  {
>      KVMClockState *s = KVM_CLOCK(dev);
>  
> -    if (kvm_has_adjust_clock_stable()) {
> -        s->clock_is_reliable = true;
> -    }
> -
>      qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
>  }
>  
> @@ -206,7 +179,7 @@ static void kvmclock_pre_save(void *opaque)
>  {
>      KVMClockState *s = opaque;
>  
> -    s->clock = kvm_get_clock();
> +    kvm_get_clock(s);
>  }
>  
>  static const VMStateDescription kvmclock_vmsd = {
> 
> 
> > +
> >          data.clock = s->clock;
> >          ret = kvm_vm_ioctl(kvm_state, KVM_SET_CLOCK, &data);
> >          if (ret < 0) {
> > @@ -120,8 +156,6 @@
> >              }
> >          }
> >      } else {
> > -        struct kvm_clock_data data;
> > -        int ret;
> >  
> >          if (s->clock_valid) {
> >              return;
> > @@ -129,13 +163,7 @@
> >  
> >          kvm_synchronize_all_tsc();
> >  
> > -        ret = kvm_vm_ioctl(kvm_state, KVM_GET_CLOCK, &data);
> > -        if (ret < 0) {
> > -            fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(ret));
> > -            abort();
> > -        }
> > -        s->clock = data.clock;
> > -
> > +        s->clock = kvm_get_clock();
> >          /*
> >           * If the VM is stopped, declare the clock state valid to
> >           * avoid re-reading it on next vmsave (which would return
> > @@ -149,25 +177,66 @@
> >  {
> >      KVMClockState *s = KVM_CLOCK(dev);
> >  
> > +    if (kvm_has_adjust_clock_stable()) {
> > +        s->clock_is_reliable = true;
> > +    }
> > +
> >      qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
> >  }
> >  
> > +static bool kvmclock_clock_is_reliable_needed(void *opaque)
> > +{
> > +    KVMClockState *s = opaque;
> > +
> > +    return s->mach_use_reliable_get_clock;
> > +}
> > +
> > +static const VMStateDescription kvmclock_reliable_get_clock = {
> > +    .name = "kvmclock/clock_is_reliable",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .needed = kvmclock_clock_is_reliable_needed,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_BOOL(clock_is_reliable, KVMClockState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void kvmclock_pre_save(void *opaque)
> > +{
> > +    KVMClockState *s = opaque;
> > +
> 
> We still need a comment here explaining why we need to re-read
> the clock on pre_save if s->clock was already set on
> kvmclock_vm_state_change().

OK.

> Also, what if we are migrating a VM that was already paused 10
> minutes ago? Should we migrate the s->clock value from
> 10 minutes ago, or the one read at pre_save?

The one read at pre_save. I'll add a comment.

> > +    s->clock = kvm_get_clock();
> > +}
> > +
> >  static const VMStateDescription kvmclock_vmsd = {
> >      .name = "kvmclock",
> >      .version_id = 1,
> >      .minimum_version_id = 1,
> > +    .pre_save = kvmclock_pre_save,
> >      .fields = (VMStateField[]) {
> >          VMSTATE_UINT64(clock, KVMClockState),
> >          VMSTATE_END_OF_LIST()
> > +    },
> > +    .subsections = (const VMStateDescription * []) {
> > +        &kvmclock_reliable_get_clock,
> > +        NULL
> >      }
> >  };
> >  
> > +static Property kvmclock_properties[] = {
> > +    DEFINE_PROP_BOOL("x-mach-use-reliable-get-clock", KVMClockState,
> > +                      mach_use_reliable_get_clock, true),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> >  static void kvmclock_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc = DEVICE_CLASS(klass);
> >  
> >      dc->realize = kvmclock_realize;
> >      dc->vmsd = &kvmclock_vmsd;
> > +    dc->props = kvmclock_properties;
> >  }
> >  
> >  static const TypeInfo kvmclock_info = {
> > Index: qemu-mig-advance-clock/include/hw/i386/pc.h
> > ===================================================================
> > --- qemu-mig-advance-clock.orig/include/hw/i386/pc.h	2016-11-17 15:07:11.220632761 -0200
> > +++ qemu-mig-advance-clock/include/hw/i386/pc.h	2016-11-17 15:08:58.096791416 -0200
> > @@ -370,6 +370,11 @@
> >  #define PC_COMPAT_2_7 \
> >      HW_COMPAT_2_7 \
> >      {\
> > +        .driver   = "kvmclock",\
> > +        .property = "x-mach-use-reliable-get-clock",\
> > +        .value    = "off",\
> > +    },\
> > +    {\
> >          .driver   = TYPE_X86_CPU,\
> >          .property = "l3-cache",\
> >          .value    = "off",\
> > Index: qemu-mig-advance-clock/target-i386/kvm.c
> > ===================================================================
> > --- qemu-mig-advance-clock.orig/target-i386/kvm.c	2016-11-17 15:07:11.221632762 -0200
> > +++ qemu-mig-advance-clock/target-i386/kvm.c	2016-11-17 15:07:15.867639659 -0200
> > @@ -117,6 +117,13 @@
> >      return kvm_check_extension(kvm_state, KVM_CAP_X86_SMM);
> >  }
> >  
> > +bool kvm_has_adjust_clock_stable(void)
> > +{
> > +    int ret = kvm_check_extension(kvm_state, KVM_CAP_ADJUST_CLOCK);
> > +
> > +    return (ret == KVM_CLOCK_TSC_STABLE);
> > +}
> > +
> >  bool kvm_allows_irq0_override(void)
> >  {
> >      return !kvm_irqchip_in_kernel() || kvm_has_gsi_routing();
> > Index: qemu-mig-advance-clock/target-i386/kvm_i386.h
> > ===================================================================
> > --- qemu-mig-advance-clock.orig/target-i386/kvm_i386.h	2016-11-17 15:07:11.222632764 -0200
> > +++ qemu-mig-advance-clock/target-i386/kvm_i386.h	2016-11-17 15:07:15.867639659 -0200
> > @@ -17,6 +17,7 @@
> >  
> >  bool kvm_allows_irq0_override(void);
> >  bool kvm_has_smm(void);
> > +bool kvm_has_adjust_clock_stable(void);
> >  void kvm_synchronize_all_tsc(void);
> >  void kvm_arch_reset_vcpu(X86CPU *cs);
> >  void kvm_arch_do_init_vcpu(X86CPU *cs);
> 
> -- 
> Eduardo
