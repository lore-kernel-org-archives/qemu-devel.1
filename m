Received: from eggs.gnu.org ([2001:4830:134:3::10]:41724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cGOhl-0006UD-At
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cGOhh-0002LY-C2
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:23:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cGOhh-0002KH-35
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:23:33 -0500
Date: Mon, 12 Dec 2016 09:22:57 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Message-ID: <20161212112255.GA21270@amt.cnet>
References: <20161210172148.361793326@redhat.com>
	<20161210172324.482367805@redhat.com>
	<836450782.4168420.1481528215255.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <836450782.4168420.1481528215255.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [qemu patch V4 2/2] kvmclock: reduce kvmclock
 difference on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>, qemu-devel@nongnu.org, Dr David Alan Gilbert <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Dec 12, 2016 at 02:36:55AM -0500, Pankaj Gupta wrote:
> 
> Hello Marcelo,

Hi Pankaj,

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
> > Note: pre_save contradicts the following comment
> >         /*
> >          * If the VM is stopped, declare the clock state valid to
> >          * avoid re-reading it on next vmsave (which would return
> >          * a different value). Will be reset when the VM is continued.
> >          */
> > But the comment is bogus: vm_state_change is never called twice in a row
> > with running=0 or running=1.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> >  hw/i386/kvm/clock.c    |  107
> >  ++++++++++++++++++++++++++++++++++++++++++-------
> >  include/hw/i386/pc.h   |    5 ++
> >  target-i386/kvm.c      |    7 +++
> >  target-i386/kvm_i386.h |    1
> >  4 files changed, 106 insertions(+), 14 deletions(-)
> > 
> > v2:
> > - improve variable names (Juan)
> > - consolidate code on kvm_get_clock function (Paolo)
> > - return mach_use_reliable_get_clock from needed function (Paolo)
> > v3:
> > - simplify check for src_use_reliable_get_clock (Eduardo)
> > - move src_use_reliable_get_clock initialization to realize (Eduardo)
> > 
> > v4:
> > - have kvm_get_clock and clock_is_reliable assignments synchronized (Eduardo)
> > - add comment to the reasoning of kvmclock_pre_save (Eduardo)
> > 
> > 
> > Index: qemu-mig-advance-clock/hw/i386/kvm/clock.c
> > ===================================================================
> > --- qemu-mig-advance-clock.orig/hw/i386/kvm/clock.c	2016-11-17
> > 15:07:11.220632761 -0200
> > +++ qemu-mig-advance-clock/hw/i386/kvm/clock.c	2016-12-10 13:57:58.115983966
> > -0200
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
> > @@ -91,15 +111,23 @@
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
> > +        /* We can't rely on the saved clock value, just discard it */
> > +        if (pvclock_via_mem) {
> > +            s->clock = pvclock_via_mem;
> >          }
> >  
> > +        s->clock_valid = false;
> > +
> >          data.clock = s->clock;
> >          ret = kvm_vm_ioctl(kvm_state, KVM_SET_CLOCK, &data);
> >          if (ret < 0) {
> > @@ -120,8 +148,6 @@
> >              }
> >          }
> >      } else {
> > -        struct kvm_clock_data data;
> > -        int ret;
> >  
> >          if (s->clock_valid) {
> >              return;
> > @@ -129,13 +155,11 @@
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
> > +        /* any code that sets s->clock needs to ensure clock_is_reliable
> > +         * is correctly set.
> > +         */
> > +        s->clock_is_reliable = kvm_has_adjust_clock_stable();
>           
> Is it required to call  'kvm_has_adjust_clock_stable' here. Is there any chance
> of getting different value then in 'realize'? 

Yes it can happen: migration overwrites s->clock_is_reliable value (but
you can't see that from grepping).

> >           * If the VM is stopped, declare the clock state valid to
> >           * avoid re-reading it on next vmsave (which would return
> > @@ -149,25 +173,80 @@
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
> > +/*
> > + * When migrating, read the clock just before migration,
> > + * so that the guest clock counts during the events
> > + * between:
> > + *
> > + *  * vm_stop()
> > + *  *
> > + *  * pre_save()
> > + *
> > + *  This reduces kvmclock difference on migration from 5s
> > + *  to 0.1s (when max_downtime == 5s), because sending the
> > + *  final pages of memory (which happens between vm_stop()
> > + *  and pre_save()) takes max_downtime.
> > + */
> > +static void kvmclock_pre_save(void *opaque)
> > +{
> > +    KVMClockState *s = opaque;
> > +
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
> > --- qemu-mig-advance-clock.orig/include/hw/i386/pc.h	2016-11-17
> > 15:07:11.220632761 -0200
> > +++ qemu-mig-advance-clock/include/hw/i386/pc.h	2016-11-17 15:08:58.096791416
> > -0200
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
> > --- qemu-mig-advance-clock.orig/target-i386/kvm.c	2016-11-17
> > 15:07:11.221632762 -0200
> > +++ qemu-mig-advance-clock/target-i386/kvm.c	2016-11-17 15:07:15.867639659
> > -0200
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
> > --- qemu-mig-advance-clock.orig/target-i386/kvm_i386.h	2016-11-17
> > 15:07:11.222632764 -0200
> > +++ qemu-mig-advance-clock/target-i386/kvm_i386.h	2016-11-17
> > 15:07:15.867639659 -0200
> > @@ -17,6 +17,7 @@
> >  
> >  bool kvm_allows_irq0_override(void);
> >  bool kvm_has_smm(void);
> > +bool kvm_has_adjust_clock_stable(void);
> >  void kvm_synchronize_all_tsc(void);
> >  void kvm_arch_reset_vcpu(X86CPU *cs);
> >  void kvm_arch_do_init_vcpu(X86CPU *cs);
> > 
> > 
> > 
> > 
