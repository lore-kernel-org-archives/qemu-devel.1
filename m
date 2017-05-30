Received: from eggs.gnu.org ([2001:4830:134:3::10]:36031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dFdEU-0007eR-JM
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dFdEQ-000842-HZ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:14:30 -0400
Date: Tue, 30 May 2017 10:14:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170530091416.GF2120@work-vm>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170526052319.28096-3-david@gibson.dropbear.id.au>
	<20170529224605.0d1c31ef@bahia.ttt.fr.ibm.com>
	<20170530061523.GD12163@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170530061523.GD12163@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCHv4 2/5] migration: Mark CPU states dirty
 before incoming migration/loadvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, quintela@redhat.com, sursingh@redhat.com, sbobroff@redhat.com

* David Gibson (david@gibson.dropbear.id.au) wrote:
> On Mon, May 29, 2017 at 10:46:05PM +0200, Greg Kurz wrote:
> > On Fri, 26 May 2017 15:23:16 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> > 
> > > As a rule, CPU internal state should never be updated when
> > > !cpu->kvm_vcpu_dirty (or the HAX equivalent).  If that is done, then
> > > subsequent calls to cpu_synchronize_state() - usually safe and idempotent -
> > > will clobber state.
> > > 
> > > However, we routinely do this during a loadvm or incoming migration.
> > > Usually this is called shortly after a reset, which will clear all the cpu
> > > dirty flags with cpu_synchronize_all_post_reset().  Nothing is expected
> > > to set the dirty flags again before the cpu state is loaded from the
> > > incoming stream.
> > > 
> > > This means that it isn't safe to call cpu_synchronize_state() from a
> > > post_load handler, which is non-obvious and potentially inconvenient.
> > > 
> > > We could cpu_synchronize_all_state() before the loadvm, but that would be
> > > overkill since a) we expect the state to already be synchronized from the
> > > reset and b) we expect to completely rewrite the state with a call to
> > > cpu_synchronize_all_post_init() at the end of qemu_loadvm_state().
> > > 
> > > To clear this up, this patch introduces cpu_synchronize_pre_loadvm() and
> > > associated helpers, which simply marks the cpu state as dirty without
> > > actually changing anything.  i.e. it says we want to discard any existing
> > > KVM (or HAX) state and replace it with what we're going to load.
> > > 
> > 
> > This makes sense and looks nicer than adding a post-load specific path to
> > ppc_set_compat() indeed.
> > 
> > Just one remark below.
> > 
> > > Cc: Juan Quintela <quintela@redhat.com>
> > > Cc: Dave Gilbert <dgilbert@redhat.com>
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  cpus.c                    |  9 +++++++++
> > >  include/sysemu/cpus.h     |  1 +
> > >  include/sysemu/hax.h      |  1 +
> > >  include/sysemu/hw_accel.h | 10 ++++++++++
> > >  include/sysemu/kvm.h      |  1 +
> > >  kvm-all.c                 | 10 ++++++++++
> > >  migration/savevm.c        |  2 ++
> > >  target/i386/hax-all.c     | 10 ++++++++++
> > >  8 files changed, 44 insertions(+)
> > > 
> > > diff --git a/cpus.c b/cpus.c
> > > index 516e5cb..6398439 100644
> > > --- a/cpus.c
> > > +++ b/cpus.c
> > > @@ -921,6 +921,15 @@ void cpu_synchronize_all_post_init(void)
> > >      }
> > >  }
> > >  
> > > +void cpu_synchronize_all_pre_loadvm(void)
> > > +{
> > > +    CPUState *cpu;
> > > +
> > > +    CPU_FOREACH(cpu) {
> > > +        cpu_synchronize_pre_loadvm(cpu);
> > > +    }
> > > +}
> > > +
> > >  static int do_vm_stop(RunState state)
> > >  {
> > >      int ret = 0;
> > > diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> > > index a8053f1..731756d 100644
> > > --- a/include/sysemu/cpus.h
> > > +++ b/include/sysemu/cpus.h
> > > @@ -27,6 +27,7 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockType type);
> > >  void cpu_synchronize_all_states(void);
> > >  void cpu_synchronize_all_post_reset(void);
> > >  void cpu_synchronize_all_post_init(void);
> > > +void cpu_synchronize_all_pre_loadvm(void);
> > >  
> > >  void qtest_clock_warp(int64_t dest);
> > >  
> > > diff --git a/include/sysemu/hax.h b/include/sysemu/hax.h
> > > index d9f0239..232a68a 100644
> > > --- a/include/sysemu/hax.h
> > > +++ b/include/sysemu/hax.h
> > > @@ -33,6 +33,7 @@ int hax_populate_ram(uint64_t va, uint32_t size);
> > >  void hax_cpu_synchronize_state(CPUState *cpu);
> > >  void hax_cpu_synchronize_post_reset(CPUState *cpu);
> > >  void hax_cpu_synchronize_post_init(CPUState *cpu);
> > > +void hax_cpu_synchronize_pre_loadvm(CPUState *cpu);
> > >  
> > >  #ifdef CONFIG_HAX
> > >  
> > > diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
> > > index c9b3105..469ffda 100644
> > > --- a/include/sysemu/hw_accel.h
> > > +++ b/include/sysemu/hw_accel.h
> > > @@ -45,4 +45,14 @@ static inline void cpu_synchronize_post_init(CPUState *cpu)
> > >      }
> > >  }
> > >  
> > > +static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
> > > +{
> > > +    if (kvm_enabled()) {
> > > +        kvm_cpu_synchronize_pre_loadvm(cpu);
> > > +    }
> > > +    if (hax_enabled()) {
> > > +        hax_cpu_synchronize_pre_loadvm(cpu);
> > > +    }
> > > +}
> > > +
> > >  #endif /* QEMU_HW_ACCEL_H */
> > > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > > index 5cc83f2..a45c145 100644
> > > --- a/include/sysemu/kvm.h
> > > +++ b/include/sysemu/kvm.h
> > > @@ -459,6 +459,7 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
> > >  void kvm_cpu_synchronize_state(CPUState *cpu);
> > >  void kvm_cpu_synchronize_post_reset(CPUState *cpu);
> > >  void kvm_cpu_synchronize_post_init(CPUState *cpu);
> > > +void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu);
> > >  
> > >  void kvm_init_cpu_signals(CPUState *cpu);
> > >  
> > > diff --git a/kvm-all.c b/kvm-all.c
> > > index 90b8573..a8485bd 100644
> > > --- a/kvm-all.c
> > > +++ b/kvm-all.c
> > > @@ -1896,6 +1896,16 @@ void kvm_cpu_synchronize_post_init(CPUState *cpu)
> > >      run_on_cpu(cpu, do_kvm_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
> > >  }
> > >  
> > > +static void do_kvm_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_data arg)
> > > +{
> > > +    cpu->kvm_vcpu_dirty = true;
> > > +}
> > > +
> > > +void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu)
> > > +{
> > > +    run_on_cpu(cpu, do_kvm_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
> > 
> > Do we really need to run_on_cpu() since we only set the dirty flag ?
> 
> Um.. yeah.. I'm not sure.  I left it in out of paranoia, because I
> wasn't sure if there could be memory ordering issues between the qemu
> threads if we just set it from the migration thread.
> 
> I'm hoping Dave or Juan will have a better idea.

I don't know the kvm cpu sync stuff well enough.

Dave

> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
