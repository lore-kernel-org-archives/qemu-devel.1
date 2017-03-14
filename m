Received: from eggs.gnu.org ([2001:4830:134:3::10]:56060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cnq4I-0005KA-3d
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cnq4F-0002OS-Mt
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:17:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cnq4F-0002OE-CT
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:17:03 -0400
Date: Tue, 14 Mar 2017 14:16:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170314171632.GS4694@thinpad.lan.raisama.net>
References: <20170314140807.6061-1-git@kirschju.re>
	<20170314140807.6061-2-git@kirschju.re>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314140807.6061-2-git@kirschju.re>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] X86: Move rdmsr/wrmsr functionality
 to standalone functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Kirsch <git@kirschju.re>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, Mar 14, 2017 at 03:08:06PM +0100, Julian Kirsch wrote:
> Add two new functions to provide read/write access to model specific registers
> (MSRs) on x86. Move original functionality to new functions
> x86_cpu_[rd|wr]msr and make list of available MSRs consistent with KVM.

I would prefer to see code movement and other changes (like
reordering) in separate patches, to make it easier to review.

To help reviewers, below is the diff between the old functions in
misc_helper.c and new functions in helper.c:

--- /tmp/msrfuncs-old.c	2017-03-14 14:12:04.739686970 -0300
+++ /tmp/msrfuncs-new.c	2017-03-14 14:11:50.108486602 -0300
@@ -1,10 +1,10 @@
-void helper_rdmsr(CPUX86State *env)
+uint64_t x86_cpu_rdmsr(CPUX86State *env, uint32_t idx, bool *valid)
 {
     uint64_t val;
+    *valid = true;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 0, GETPC());
-
-    switch ((uint32_t)env->regs[R_ECX]) {
+    /* MSR list loosely following the order in kvm.c */
+    switch (idx) {
     case MSR_IA32_SYSENTER_CS:
         val = env->sysenter_cs;
         break;
@@ -14,20 +14,37 @@
     case MSR_IA32_SYSENTER_EIP:
         val = env->sysenter_eip;
         break;
-    case MSR_IA32_APICBASE:
-        val = cpu_get_apic_base(x86_env_get_cpu(env)->apic_state);
-        break;
-    case MSR_EFER:
-        val = env->efer;
+    case MSR_PAT:
+        val = env->pat;
         break;
     case MSR_STAR:
         val = env->star;
         break;
-    case MSR_PAT:
-        val = env->pat;
+#ifdef TARGET_X86_64
+    case MSR_CSTAR:
+        val = env->cstar;
         break;
-    case MSR_VM_HSAVE_PA:
-        val = env->vm_hsave;
+    case MSR_KERNELGSBASE:
+        val = env->kernelgsbase;
+        break;
+    case MSR_GSBASE:
+        val = env->segs[R_GS].base;
+        break;
+    case MSR_FSBASE:
+        val = env->segs[R_FS].base;
+        break;
+    case MSR_FMASK:
+        val = env->fmask;
+        break;
+    case MSR_LSTAR:
+        val = env->lstar;
+        break;
+#endif
+    case MSR_EFER:
+        val = env->efer;
+        break;
+    case MSR_IA32_APICBASE:
+        val = cpu_get_apic_base(x86_env_get_cpu(env)->apic_state);
         break;
     case MSR_IA32_PERF_STATUS:
         /* tsc_increment_by_tick */
@@ -35,58 +52,161 @@
         /* CPU multiplier */
         val |= (((uint64_t)4ULL) << 40);
         break;
-#ifdef TARGET_X86_64
-    case MSR_LSTAR:
-        val = env->lstar;
+    case MSR_IA32_TSC:
+        val = env->tsc;
         break;
-    case MSR_CSTAR:
-        val = env->cstar;
+    case MSR_TSC_AUX:
+        val = env->tsc_aux;
         break;
-    case MSR_FMASK:
-        val = env->fmask;
+    case MSR_TSC_ADJUST:
+        val = env->tsc_adjust;
         break;
-    case MSR_FSBASE:
-        val = env->segs[R_FS].base;
+    case MSR_IA32_TSCDEADLINE:
+        val = env->tsc_deadline;
         break;
-    case MSR_GSBASE:
-        val = env->segs[R_GS].base;
+    case MSR_VM_HSAVE_PA:
+        val = env->vm_hsave;
         break;
-    case MSR_KERNELGSBASE:
-        val = env->kernelgsbase;
+#ifdef CONFIG_KVM
+    /* Export kvm specific pseudo MSRs using their new ordinals only */
+    case MSR_KVM_SYSTEM_TIME_NEW:
+        val = env->system_time_msr;
+        break;
+    case MSR_KVM_WALL_CLOCK_NEW:
+        val = env->wall_clock_msr;
         break;
-    case MSR_TSC_AUX:
-        val = env->tsc_aux;
+    case MSR_KVM_ASYNC_PF_EN:
+        val = env->async_pf_en_msr;
+        break;
+    case MSR_KVM_PV_EOI_EN:
+        val = env->pv_eoi_en_msr;
+        break;
+    case MSR_KVM_STEAL_TIME:
+        val = env->steal_time_msr;
         break;
 #endif
-    case MSR_MTRRphysBase(0):
-    case MSR_MTRRphysBase(1):
-    case MSR_MTRRphysBase(2):
-    case MSR_MTRRphysBase(3):
-    case MSR_MTRRphysBase(4):
-    case MSR_MTRRphysBase(5):
-    case MSR_MTRRphysBase(6):
-    case MSR_MTRRphysBase(7):
-        val = env->mtrr_var[((uint32_t)env->regs[R_ECX] -
-                             MSR_MTRRphysBase(0)) / 2].base;
+    case MSR_MCG_STATUS:
+        val = env->mcg_status;
         break;
-    case MSR_MTRRphysMask(0):
-    case MSR_MTRRphysMask(1):
-    case MSR_MTRRphysMask(2):
-    case MSR_MTRRphysMask(3):
-    case MSR_MTRRphysMask(4):
-    case MSR_MTRRphysMask(5):
-    case MSR_MTRRphysMask(6):
-    case MSR_MTRRphysMask(7):
-        val = env->mtrr_var[((uint32_t)env->regs[R_ECX] -
-                             MSR_MTRRphysMask(0)) / 2].mask;
+    case MSR_MCG_CAP:
+        val = env->mcg_cap;
+        break;
+    case MSR_MCG_CTL:
+        if (env->mcg_cap & MCG_CTL_P) {
+            val = env->mcg_ctl;
+        } else {
+            val = 0;
+        }
+        break;
+    case MSR_MCG_EXT_CTL:
+        if (env->mcg_cap & MCG_CTL_P) {
+            val = env->mcg_ext_ctl;
+        } else {
+            val = 0;
+        }
+        break;
+    case MSR_IA32_MISC_ENABLE:
+        val = env->msr_ia32_misc_enable;
+        break;
+    case MSR_IA32_SMBASE:
+        val = env->smbase;
+        break;
+    case MSR_IA32_FEATURE_CONTROL:
+        val = env->msr_ia32_feature_control;
+        break;
+    case MSR_IA32_BNDCFGS:
+        val = env->msr_bndcfgs;
+        break;
+    case MSR_IA32_XSS:
+        val = env->xss;
+        break;
+    default:
+        if (idx >= MSR_MC0_CTL &&
+            idx < MSR_MC0_CTL + (env->mcg_cap & 0xff) * 4) {
+            val = env->mce_banks[idx - MSR_MC0_CTL];
+            break;
+        }
+        /* XXX: Pass request to underlying KVM? */
+        val = 0;
+        *valid = false;
+        break;
+    case MSR_CORE_PERF_FIXED_CTR_CTRL:
+        val = env->msr_fixed_ctr_ctrl;
+        break;
+    case MSR_CORE_PERF_GLOBAL_CTRL:
+        val = env->msr_global_ctrl;
+        break;
+    case MSR_CORE_PERF_GLOBAL_STATUS:
+        val = env->msr_global_status;
+        break;
+    case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
+        val = env->msr_global_ovf_ctrl;
+        break;
+    case MSR_CORE_PERF_FIXED_CTR0 ... MSR_CORE_PERF_FIXED_CTR0 + MAX_FIXED_COUNTERS - 1:
+        val = env->msr_fixed_counters[idx - MSR_CORE_PERF_FIXED_CTR0];
+        break;
+    case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR0 + MAX_GP_COUNTERS - 1:
+        val = env->msr_gp_counters[idx - MSR_P6_PERFCTR0];
+        break;
+    case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
+        val = env->msr_gp_evtsel[idx - MSR_P6_EVNTSEL0];
+        break;
+#if defined CONFIG_KVM && defined TARGET_X86_64
+    case HV_X64_MSR_HYPERCALL:
+        val = env->msr_hv_hypercall;
+        break;
+    case HV_X64_MSR_GUEST_OS_ID:
+        val = env->msr_hv_guest_os_id;
+        break;
+    case HV_X64_MSR_APIC_ASSIST_PAGE:
+        val = env->msr_hv_vapic;
+        break;
+    case HV_X64_MSR_REFERENCE_TSC:
+        val = env->msr_hv_tsc;
+        break;
+    case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
+        val = env->msr_hv_crash_params[idx - HV_X64_MSR_CRASH_P0];
+        break;
+    case HV_X64_MSR_VP_RUNTIME:
+        val = env->msr_hv_runtime;
+        break;
+    case HV_X64_MSR_SCONTROL:
+        val = env->msr_hv_synic_control;
+        break;
+    case HV_X64_MSR_SVERSION:
+        val = env->msr_hv_synic_version;
+        break;
+    case HV_X64_MSR_SIEFP:
+        val = env->msr_hv_synic_evt_page;
+        break;
+    case HV_X64_MSR_SIMP:
+        val = env->msr_hv_synic_msg_page;
+        break;
+    case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
+        val = env->msr_hv_synic_sint[idx - HV_X64_MSR_SINT0];
+        break;
+    case HV_X64_MSR_STIMER0_CONFIG:
+    case HV_X64_MSR_STIMER1_CONFIG:
+    case HV_X64_MSR_STIMER2_CONFIG:
+    case HV_X64_MSR_STIMER3_CONFIG:
+        val = env->msr_hv_stimer_config[(idx - HV_X64_MSR_STIMER0_CONFIG) / 2];
+        break;
+    case HV_X64_MSR_STIMER0_COUNT:
+    case HV_X64_MSR_STIMER1_COUNT:
+    case HV_X64_MSR_STIMER2_COUNT:
+    case HV_X64_MSR_STIMER3_COUNT:
+        val = env->msr_hv_stimer_count[(idx - HV_X64_MSR_STIMER0_COUNT) / 2];
+        break;
+#endif
+    case MSR_MTRRdefType:
+        val = env->mtrr_deftype;
         break;
     case MSR_MTRRfix64K_00000:
         val = env->mtrr_fixed[0];
         break;
     case MSR_MTRRfix16K_80000:
     case MSR_MTRRfix16K_A0000:
-        val = env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
-                              MSR_MTRRfix16K_80000 + 1];
+        val = env->mtrr_fixed[idx - MSR_MTRRfix16K_80000 + 1];
         break;
     case MSR_MTRRfix4K_C0000:
     case MSR_MTRRfix4K_C8000:
@@ -96,11 +216,27 @@
     case MSR_MTRRfix4K_E8000:
     case MSR_MTRRfix4K_F0000:
     case MSR_MTRRfix4K_F8000:
-        val = env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
-                              MSR_MTRRfix4K_C0000 + 3];
+        val = env->mtrr_fixed[idx - MSR_MTRRfix4K_C0000 + 3];
         break;
-    case MSR_MTRRdefType:
-        val = env->mtrr_deftype;
+    case MSR_MTRRphysBase(0):
+    case MSR_MTRRphysBase(1):
+    case MSR_MTRRphysBase(2):
+    case MSR_MTRRphysBase(3):
+    case MSR_MTRRphysBase(4):
+    case MSR_MTRRphysBase(5):
+    case MSR_MTRRphysBase(6):
+    case MSR_MTRRphysBase(7):
+        val = env->mtrr_var[(idx - MSR_MTRRphysBase(0)) / 2].base;
+        break;
+    case MSR_MTRRphysMask(0):
+    case MSR_MTRRphysMask(1):
+    case MSR_MTRRphysMask(2):
+    case MSR_MTRRphysMask(3):
+    case MSR_MTRRphysMask(4):
+    case MSR_MTRRphysMask(5):
+    case MSR_MTRRphysMask(6):
+    case MSR_MTRRphysMask(7):
+        val = env->mtrr_var[(idx - MSR_MTRRphysMask(0)) / 2].mask;
         break;
     case MSR_MTRRcap:
         if (env->features[FEAT_1_EDX] & CPUID_MTRR) {
@@ -108,54 +244,22 @@
                 MSR_MTRRcap_WC_SUPPORTED;
         } else {
             /* XXX: exception? */
+            *valid = false;
             val = 0;
         }
         break;
-    case MSR_MCG_CAP:
-        val = env->mcg_cap;
-        break;
-    case MSR_MCG_CTL:
-        if (env->mcg_cap & MCG_CTL_P) {
-            val = env->mcg_ctl;
-        } else {
-            val = 0;
-        }
-        break;
-    case MSR_MCG_STATUS:
-        val = env->mcg_status;
-        break;
-    case MSR_IA32_MISC_ENABLE:
-        val = env->msr_ia32_misc_enable;
-        break;
-    case MSR_IA32_BNDCFGS:
-        val = env->msr_bndcfgs;
-        break;
-    default:
-        if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
-            && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
-            (4 * env->mcg_cap & 0xff)) {
-            uint32_t offset = (uint32_t)env->regs[R_ECX] - MSR_MC0_CTL;
-            val = env->mce_banks[offset];
-            break;
-        }
-        /* XXX: exception? */
-        val = 0;
-        break;
     }
-    env->regs[R_EAX] = (uint32_t)(val);
-    env->regs[R_EDX] = (uint32_t)(val >> 32);
+
+    return val;
 }
 
-void helper_wrmsr(CPUX86State *env)
+void x86_cpu_wrmsr(CPUX86State *env, uint32_t idx, uint64_t val, bool *valid)
 {
-    uint64_t val;
-
-    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, GETPC());
-
-    val = ((uint32_t)env->regs[R_EAX]) |
-        ((uint64_t)((uint32_t)env->regs[R_EDX]) << 32);
+    *valid = true;
+    /* FIXME: With KVM nabled, only report success if we are sure the new value
+     * will actually be written back by the KVM subsystem later. */
 
-    switch ((uint32_t)env->regs[R_ECX]) {
+    switch (idx) {
     case MSR_IA32_SYSENTER_CS:
         env->sysenter_cs = val & 0xffff;
         break;
@@ -165,9 +269,56 @@
     case MSR_IA32_SYSENTER_EIP:
         env->sysenter_eip = val;
         break;
-    case MSR_IA32_APICBASE:
-        cpu_set_apic_base(x86_env_get_cpu(env)->apic_state, val);
+    case MSR_PAT:
+        env->pat = val;
+        break;
+    case MSR_STAR:
+        env->star = val;
+        break;
+    case MSR_VM_HSAVE_PA:
+        env->vm_hsave = val;
         break;
+    case MSR_TSC_AUX:
+        env->tsc_aux = val;
+        break;
+    case MSR_TSC_ADJUST:
+        env->tsc_adjust = val;
+        break;
+    case MSR_IA32_MISC_ENABLE:
+        env->msr_ia32_misc_enable = val;
+        break;
+    case MSR_IA32_SMBASE:
+        env->smbase = val;
+        break;
+    case MSR_IA32_BNDCFGS:
+        /* FIXME: #GP if reserved bits are set.  */
+        /* FIXME: Extend highest implemented bit of linear address.  */
+        env->msr_bndcfgs = val;
+        cpu_sync_bndcs_hflags(env);
+        break;
+    case MSR_IA32_XSS:
+        env->xss = val;
+        break;
+#ifdef TARGET_X86_64
+    case MSR_CSTAR:
+        env->cstar = val;
+        break;
+    case MSR_KERNELGSBASE:
+        env->kernelgsbase = val;
+        break;
+    case MSR_GSBASE:
+        env->segs[R_GS].base = val;
+        break;
+    case MSR_FSBASE:
+        env->segs[R_FS].base = val;
+        break;
+    case MSR_FMASK:
+        env->fmask = val;
+        break;
+    case MSR_LSTAR:
+        env->lstar = val;
+        break;
+#endif
     case MSR_EFER:
         {
             uint64_t update_mask;
@@ -195,35 +346,121 @@
                           (val & update_mask));
         }
         break;
-    case MSR_STAR:
-        env->star = val;
+    case MSR_IA32_APICBASE:
+        cpu_set_apic_base(x86_env_get_cpu(env)->apic_state, val);
         break;
-    case MSR_PAT:
-        env->pat = val;
+    case MSR_IA32_TSC:
+        env->tsc = val;
         break;
-    case MSR_VM_HSAVE_PA:
-        env->vm_hsave = val;
+#ifdef CONFIG_KVM
+    case MSR_KVM_SYSTEM_TIME:
+        env->system_time_msr = val;
+        break;
+    case MSR_KVM_WALL_CLOCK:
+        env->wall_clock_msr = val;
+        break;
+    case MSR_KVM_ASYNC_PF_EN:
+        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
+            env->async_pf_en_msr = val;
+        } else {
+            *valid = false;
+        }
+    case MSR_KVM_PV_EOI_EN:
+        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
+            env->pv_eoi_en_msr = val;
+        } else {
+            *valid = false;
+        }
+
+#endif
+    case MSR_CORE_PERF_FIXED_CTR_CTRL:
+        env->msr_fixed_ctr_ctrl = val;
         break;
-#ifdef TARGET_X86_64
-    case MSR_LSTAR:
-        env->lstar = val;
+    case MSR_CORE_PERF_GLOBAL_CTRL:
+        env->msr_global_ctrl = val;
         break;
-    case MSR_CSTAR:
-        env->cstar = val;
+    case MSR_CORE_PERF_GLOBAL_STATUS:
+        env->msr_global_status = val;
         break;
-    case MSR_FMASK:
-        env->fmask = val;
+    case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
+        env->msr_global_ovf_ctrl = val;
         break;
-    case MSR_FSBASE:
-        env->segs[R_FS].base = val;
+    case MSR_CORE_PERF_FIXED_CTR0 ... MSR_CORE_PERF_FIXED_CTR0 + MAX_FIXED_COUNTERS - 1:
+        env->msr_fixed_counters[idx - MSR_CORE_PERF_FIXED_CTR0] = val;
         break;
-    case MSR_GSBASE:
-        env->segs[R_GS].base = val;
+    case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR0 + MAX_GP_COUNTERS - 1:
+        env->msr_gp_counters[idx - MSR_P6_PERFCTR0] = val;
         break;
-    case MSR_KERNELGSBASE:
-        env->kernelgsbase = val;
+    case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
+        env->msr_gp_evtsel[idx - MSR_P6_EVNTSEL0] = val;
+        break;
+#if defined CONFIG_KVM && defined TARGET_X86_64
+    case HV_X64_MSR_HYPERCALL:
+        env->msr_hv_hypercall = val;
+        break;
+    case HV_X64_MSR_GUEST_OS_ID:
+        env->msr_hv_guest_os_id = val;
+        break;
+    case HV_X64_MSR_APIC_ASSIST_PAGE:
+        env->msr_hv_vapic = val;
+        break;
+    case HV_X64_MSR_REFERENCE_TSC:
+        env->msr_hv_tsc = val;
+        break;
+    case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
+        env->msr_hv_crash_params[idx - HV_X64_MSR_CRASH_P0] = val;
+        break;
+    case HV_X64_MSR_VP_RUNTIME:
+        env->msr_hv_runtime = val;
+        break;
+    case HV_X64_MSR_SCONTROL:
+        env->msr_hv_synic_control = val;
+        break;
+    case HV_X64_MSR_SVERSION:
+        env->msr_hv_synic_version = val;
+        break;
+    case HV_X64_MSR_SIEFP:
+        env->msr_hv_synic_evt_page = val;
+        break;
+    case HV_X64_MSR_SIMP:
+        env->msr_hv_synic_msg_page = val;
+        break;
+    case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
+        env->msr_hv_synic_sint[idx - HV_X64_MSR_SINT0] = val;
+        break;
+    case HV_X64_MSR_STIMER0_CONFIG:
+    case HV_X64_MSR_STIMER1_CONFIG:
+    case HV_X64_MSR_STIMER2_CONFIG:
+    case HV_X64_MSR_STIMER3_CONFIG:
+        env->msr_hv_stimer_config[(idx - HV_X64_MSR_STIMER0_CONFIG) / 2] = val;
+        break;
+    case HV_X64_MSR_STIMER0_COUNT:
+    case HV_X64_MSR_STIMER1_COUNT:
+    case HV_X64_MSR_STIMER2_COUNT:
+    case HV_X64_MSR_STIMER3_COUNT:
+        env->msr_hv_stimer_count[(idx - HV_X64_MSR_STIMER0_COUNT) / 2] = val;
         break;
 #endif
+    case MSR_MTRRdefType:
+        env->mtrr_deftype = val;
+        break;
+    case MSR_MTRRfix64K_00000:
+        env->mtrr_fixed[idx - MSR_MTRRfix64K_00000] = val;
+        break;
+    case MSR_MTRRfix16K_80000:
+    case MSR_MTRRfix16K_A0000:
+        env->mtrr_fixed[idx - MSR_MTRRfix16K_80000 + 1] = val;
+        break;
+    case MSR_MTRRfix4K_C0000:
+    case MSR_MTRRfix4K_C8000:
+    case MSR_MTRRfix4K_D0000:
+    case MSR_MTRRfix4K_D8000:
+    case MSR_MTRRfix4K_E0000:
+    case MSR_MTRRfix4K_E8000:
+    case MSR_MTRRfix4K_F0000:
+    case MSR_MTRRfix4K_F8000:
+        env->mtrr_fixed[idx - MSR_MTRRfix4K_C0000 + 3] = val;
+        break;
     case MSR_MTRRphysBase(0):
     case MSR_MTRRphysBase(1):
     case MSR_MTRRphysBase(2):
@@ -232,8 +469,7 @@
     case MSR_MTRRphysBase(5):
     case MSR_MTRRphysBase(6):
     case MSR_MTRRphysBase(7):
-        env->mtrr_var[((uint32_t)env->regs[R_ECX] -
-                       MSR_MTRRphysBase(0)) / 2].base = val;
+        env->mtrr_var[(idx - MSR_MTRRphysBase(0)) / 2].base = val;
         break;
     case MSR_MTRRphysMask(0):
     case MSR_MTRRphysMask(1):
@@ -243,31 +479,7 @@
     case MSR_MTRRphysMask(5):
     case MSR_MTRRphysMask(6):
     case MSR_MTRRphysMask(7):
-        env->mtrr_var[((uint32_t)env->regs[R_ECX] -
-                       MSR_MTRRphysMask(0)) / 2].mask = val;
-        break;
-    case MSR_MTRRfix64K_00000:
-        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
-                        MSR_MTRRfix64K_00000] = val;
-        break;
-    case MSR_MTRRfix16K_80000:
-    case MSR_MTRRfix16K_A0000:
-        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
-                        MSR_MTRRfix16K_80000 + 1] = val;
-        break;
-    case MSR_MTRRfix4K_C0000:
-    case MSR_MTRRfix4K_C8000:
-    case MSR_MTRRfix4K_D0000:
-    case MSR_MTRRfix4K_D8000:
-    case MSR_MTRRfix4K_E0000:
-    case MSR_MTRRfix4K_E8000:
-    case MSR_MTRRfix4K_F0000:
-    case MSR_MTRRfix4K_F8000:
-        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
-                        MSR_MTRRfix4K_C0000 + 3] = val;
-        break;
-    case MSR_MTRRdefType:
-        env->mtrr_deftype = val;
+        env->mtrr_var[(idx - MSR_MTRRphysMask(0)) / 2].mask = val;
         break;
     case MSR_MCG_STATUS:
         env->mcg_status = val;
@@ -278,31 +490,19 @@
             env->mcg_ctl = val;
         }
         break;
-    case MSR_TSC_AUX:
-        env->tsc_aux = val;
-        break;
-    case MSR_IA32_MISC_ENABLE:
-        env->msr_ia32_misc_enable = val;
-        break;
-    case MSR_IA32_BNDCFGS:
-        /* FIXME: #GP if reserved bits are set.  */
-        /* FIXME: Extend highest implemented bit of linear address.  */
-        env->msr_bndcfgs = val;
-        cpu_sync_bndcs_hflags(env);
-        break;
     default:
-        if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
-            && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
-            (4 * env->mcg_cap & 0xff)) {
-            uint32_t offset = (uint32_t)env->regs[R_ECX] - MSR_MC0_CTL;
+        if (idx >= MSR_MC0_CTL &&
+            idx < MSR_MC0_CTL + (env->mcg_cap & 0xff) * 4) {
+            uint32_t offset = idx - MSR_MC0_CTL;
             if ((offset & 0x3) != 0
                 || (val == 0 || val == ~(uint64_t)0)) {
                 env->mce_banks[offset] = val;
             }
             break;
         }
-        /* XXX: exception? */
+        /* XXX: Pass request to underlying KVM? */
+        val = 0;
+        *valid = false;
         break;
     }
 }


> This enables other parts of the qemu codebase to read/write MSRs by means of
> the newly introduced functions. The helper_[rd|wr]msr functions in
> misc_helper.c now consist of stubs extracting the arguments from the
> current state of the CPU registers and then pass control to the new functions.
> 
> Signed-off-by: Julian Kirsch <git@kirschju.re>
[...]

-- 
Eduardo
