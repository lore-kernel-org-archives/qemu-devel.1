Received: from eggs.gnu.org ([2001:4830:134:3::10]:48491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e5I3R-00056l-Vq
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e5I3Q-0007j3-P8
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:08:37 -0400
Date: Thu, 19 Oct 2017 14:08:24 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CAFEAcA9t7i4JLbn2X5r2KqdA00fSEZPLEW4PpCsp_uyg8Gsm0A@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1710191404250.27209@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710181539580.27209@sstabellini-ThinkPad-X260>
	<CAFEAcA9t7i4JLbn2X5r2KqdA00fSEZPLEW4PpCsp_uyg8Gsm0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] don't hardcode EL1 in
 extended_addresses_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Julien Grall <julien.grall@linaro.org>

On Thu, 19 Oct 2017, Peter Maydell wrote:
> On 18 October 2017 at 23:41, Stefano Stabellini <sstabellini@kernel.org> wrote:
> > extended_addresses_enabled calls arm_el_is_aa64, hardcoding exception
> > level 1. Instead, retrieve the current el calling arm_current_el.
> >
> > Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> >
> > diff --git a/target/arm/internals.h b/target/arm/internals.h
> > index 1f6efef..63507d9 100644
> > --- a/target/arm/internals.h
> > +++ b/target/arm/internals.h
> > @@ -187,7 +187,7 @@ static inline unsigned int arm_pamax(ARMCPU *cpu)
> >  static inline bool extended_addresses_enabled(CPUARMState *env)
> >  {
> >      TCR *tcr = &env->cp15.tcr_el[arm_is_secure(env) ? 3 : 1];
> > -    return arm_el_is_aa64(env, 1) ||
> > +    return arm_el_is_aa64(env, arm_current_el(env)) ||
> >             (arm_feature(env, ARM_FEATURE_LPAE) && (tcr->raw_tcr & TTBCR_EAE));
> >  }
> 
> Hmm. The current code was definitely written under a "aarch64
> only supports EL0 and EL1" assumption, but I'm not sure
> this change is entirely correct.
> 
> We use this function in 3 places:
> 
>  * identifying whether to flush TLBs on CONTEXTIDR writes
>     -- using current EL seems like the right thing (but I'm not
>        sure -- perhaps we should pass in the S/NS from which
>        version of the 32-bit banked register is being updated
>        rather than using arm_is_secure(env) ???)
>  * choosing a PAR format for ATS operations
>     -- using the current EL is closer to correct that what we
>        have now. There are cases for a 32-bit CPU in Hyp mode that
>        this code mishandles, but we don't support that yet.
>  * choosing an FSR value when taking a breakpoint or watchpoint trap
>     -- here what we want the function to mean is "what is the
>        FSR format for the EL we're about to take this debug
>        exception to", which isn't necessarily the answer for the
>        current EL (consider 32 bit EL0 under a 64-bit EL1)
> 
> So this change will fix the PAR format for ATS operations
> made at AArch64 EL2 when EL1 is AArch32, but it will break
> the FSR format for breakpoints/watchpoints hit at AArch32 EL0
> and taken to AArch64 EL1, I think.
> 
> We probably need to separate out these uses to not all try
> to use the same function, and clarify what they're checking.


What if we do use a single extended_addresses_enabled function, but we
pass the EL to check? I think it makes sense, but please check the
changes below, especially the ones to arm_debug_excp_handler.
What do you think?


diff --git a/target/arm/helper.c b/target/arm/helper.c
index 96113fe..2298428 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -500,7 +500,7 @@ static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = arm_env_get_cpu(env);
 
     if (raw_read(env, ri) != value && !arm_feature(env, ARM_FEATURE_PMSA)
-        && !extended_addresses_enabled(env)) {
+        && !extended_addresses_enabled(env, arm_current_el(env))) {
         /* For VMSA (when not using the LPAE long descriptor page table
          * format) this register includes the ASID, so do a TLB flush.
          * For PMSA it is purely a process ID and no action is needed.
@@ -2162,7 +2162,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
 
     ret = get_phys_addr(env, value, access_type, mmu_idx,
                         &phys_addr, &attrs, &prot, &page_size, &fsr, &fi);
-    if (extended_addresses_enabled(env)) {
+    if (extended_addresses_enabled(env, arm_current_el(env))) {
         /* fsr is a DFSR/IFSR value for the long descriptor
          * translation table format, but with WnR always clear.
          * Convert it to a 64-bit PAR.
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 43106a2..6792df2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -217,10 +217,10 @@ static inline unsigned int arm_pamax(ARMCPU *cpu)
  * This is always the case if our translation regime is 64 bit,
  * but depends on TTBCR.EAE for 32 bit.
  */
-static inline bool extended_addresses_enabled(CPUARMState *env)
+static inline bool extended_addresses_enabled(CPUARMState *env, unsigned int el)
 {
-    TCR *tcr = &env->cp15.tcr_el[arm_is_secure(env) ? 3 : 1];
-    return arm_el_is_aa64(env, 1) ||
+    TCR *tcr = &env->cp15.tcr_el[el];
+    return arm_el_is_aa64(env, el) ||
            (arm_feature(env, ARM_FEATURE_LPAE) && (tcr->raw_tcr & TTBCR_EAE));
 }
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 3914145..4f46eb8 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -1378,7 +1378,7 @@ void arm_debug_excp_handler(CPUState *cs)
 
             cs->watchpoint_hit = NULL;
 
-            if (extended_addresses_enabled(env)) {
+            if (extended_addresses_enabled(env, arm_debug_target_el(env))) {
                 env->exception.fsr = (1 << 9) | 0x22;
             } else {
                 env->exception.fsr = 0x2;
@@ -1402,7 +1402,7 @@ void arm_debug_excp_handler(CPUState *cs)
             return;
         }
 
-        if (extended_addresses_enabled(env)) {
+        if (extended_addresses_enabled(env, arm_debug_target_el(env))) {
             env->exception.fsr = (1 << 9) | 0x22;
         } else {
             env->exception.fsr = 0x2;
