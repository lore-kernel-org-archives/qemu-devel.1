Received: from eggs.gnu.org ([2001:4830:134:3::10]:57502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gS1Kg-00038R-66
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gS1Kc-0006ar-2Z
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:00:54 -0500
Date: Wed, 28 Nov 2018 16:00:16 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181128150016.GA25839@caravaggio>
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-5-sameo@linux.intel.com>
	<CAFEAcA9wvrnshOTYz-jZ0n6m7SfusYY+bnB-iPnQuVNqqdg5Ww@mail.gmail.com>
	<20181127153551.GC4393@caravaggio>
	<CAFEAcA9B5DPeot26-oGtR-h+xdfg+tmUPrYpKhaneaT1tr1yqQ@mail.gmail.com>
	<20181128104024.GD4393@caravaggio>
	<CAFEAcA-G3_uhH134_n8yobkJQJ7pOvu-vpLe9MkwVp5DmJOeag@mail.gmail.com>
	<20181128135719.GE4393@caravaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128135719.GE4393@caravaggio>
Subject: Re: [Qemu-devel] [PATCH 04/13] target: arm: Move all interrupt and
 exception handlers into their own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Nov 28, 2018 at 02:57:19PM +0100, Samuel Ortiz wrote:
> On Wed, Nov 28, 2018 at 11:39:57AM +0000, Peter Maydell wrote:
> > On Wed, 28 Nov 2018 at 10:40, Samuel Ortiz <sameo@linux.intel.com> wrote:
> > > Given that this piece of code effectively builds a dependency to TCG
> > > from the KVM code, I see a few solutions but I need your input here. We
> > > could:
> > >
> > > - Decide we don't want to support --disable-tcg for ARM. We'd then carry
> > >   this patch serie from the NEMU code repo. Worst case scenario, at
> > >   least for us.
> > > - Manage to implement exception injection from userspace without TCG.
> > >   Would it even be possible?
> > > - Offload exception injections back to the kernel in those cases. I feel
> > >   this would be the cleanest solution but may need kernel changes.
> > 
> > The kernel folk were firmly against 3, IIRC, but you can go
> > and have the discussion if you like.
> > 
> > I don't really see what the problem is. This is just a bit
> > of code that's used by both TCG and KVM. Therefore it goes
> > in the binary whether TCG is enabled or not. Other functions
> > and bits of code are TCG only and therefore don't go in a
> > KVM-only binary.
> Keeping this code with --disable-tcg means:
> 
> Keep arm_cpu_do_interrupt -> Keep check_for_semihosting -> Keep the arm
> instruction loading code -> Keep a large chunk of the TCG core code
> itself. Does that dependency chain looks fine to you?
A simplified, aarch64 specific arm_cpu_do_interrupt() implementation
would not pull the TCG code in. Something like:

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 0a502091e7..eba7ced564 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1034,7 +1034,6 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
 {
     int hsr_ec = syn_get_ec(debug_exit->hsr);
     ARMCPU *cpu = ARM_CPU(cs);
-    CPUClass *cc = CPU_GET_CLASS(cs);
     CPUARMState *env = &cpu->env;
 
     /* Ensure PC is synchronised */
@@ -1088,7 +1087,22 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
     env->exception.vaddress = debug_exit->far;
     env->exception.target_el = 1;
     qemu_mutex_lock_iothread();
-    cc->do_interrupt(cs);
+
+    /* Hooks may change global state so BQL should be held, also the
+     * BQL needs to be held for any modification of
+     * cs->interrupt_request.
+     */
+    g_assert(qemu_mutex_iothread_locked());
+
+    arm_call_pre_el_change_hook(cpu);
+
+    assert(!excp_is_internal(cs->exception_index));
+    arm_cpu_do_interrupt_aarch64(cs);
+
+    arm_call_el_change_hook(cpu);
+
+    cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+
     qemu_mutex_unlock_iothread();
 
     return false;
