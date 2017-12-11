Received: from eggs.gnu.org ([2001:4830:134:3::10]:34849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5E-0004QN-Dj
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO57-0003r5-Mw
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:24 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44166)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO57-0003pe-99
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:17 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:25:01 +0300
Message-ID: <151299870172.4808.15431911733778760401.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 39/46] windbg: implemented kd_api_read_msr
 and kd_api_write_msr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |    2 
 target/i386/windbgstub.c        |  328 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    8 +
 3 files changed, 338 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 8cdb275555..6e73ef973c 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -88,6 +88,8 @@ void kd_api_write_io_space(CPUState *cpu, PacketData *pd);
 void kd_api_read_physical_memory(CPUState *cpu, PacketData *pd);
 void kd_api_write_physical_memory(CPUState *cpu, PacketData *pd);
 void kd_api_get_version(CPUState *cpu, PacketData *pd);
+void kd_api_read_msr(CPUState *cpu, PacketData *pd);
+void kd_api_write_msr(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 5e094e81d7..7985dcfaf0 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -1007,6 +1007,334 @@ void kd_api_write_control_space(CPUState *cpu, PacketData *pd)
     stl_p(&mem->ActualBytesWritten, len);
 }
 
+#if defined(CONFIG_USER_ONLY)
+void kd_api_read_msr(CPUState *cpu, PacketData *pd)
+{
+}
+
+void kd_api_write_msr(CPUState *cpu, PacketData *pd)
+{
+}
+#else
+void kd_api_read_msr(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_READ_WRITE_MSR *m64c = &pd->m64.u.ReadWriteMsr;
+    CPUArchState *env = cpu->env_ptr;
+
+    uint64_t val;
+
+    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 0, 0);
+
+    switch ((uint32_t)env->regs[R_ECX]) {
+    case MSR_IA32_SYSENTER_CS:
+        val = env->sysenter_cs;
+        break;
+    case MSR_IA32_SYSENTER_ESP:
+        val = env->sysenter_esp;
+        break;
+    case MSR_IA32_SYSENTER_EIP:
+        val = env->sysenter_eip;
+        break;
+    case MSR_IA32_APICBASE:
+        val = cpu_get_apic_base(x86_env_get_cpu(env)->apic_state);
+        break;
+    case MSR_EFER:
+        val = env->efer;
+        break;
+    case MSR_STAR:
+        val = env->star;
+        break;
+    case MSR_PAT:
+        val = env->pat;
+        break;
+    case MSR_VM_HSAVE_PA:
+        val = env->vm_hsave;
+        break;
+    case MSR_IA32_PERF_STATUS:
+        /* tsc_increment_by_tick */
+        val = 1000ULL;
+        /* CPU multiplier */
+        val |= (((uint64_t)4ULL) << 40);
+        break;
+#ifdef TARGET_X86_64
+    case MSR_LSTAR:
+        val = env->lstar;
+        break;
+    case MSR_CSTAR:
+        val = env->cstar;
+        break;
+    case MSR_FMASK:
+        val = env->fmask;
+        break;
+    case MSR_FSBASE:
+        val = env->segs[R_FS].base;
+        break;
+    case MSR_GSBASE:
+        val = env->segs[R_GS].base;
+        break;
+    case MSR_KERNELGSBASE:
+        val = env->kernelgsbase;
+        break;
+    case MSR_TSC_AUX:
+        val = env->tsc_aux;
+        break;
+#endif
+    case MSR_MTRRphysBase(0):
+    case MSR_MTRRphysBase(1):
+    case MSR_MTRRphysBase(2):
+    case MSR_MTRRphysBase(3):
+    case MSR_MTRRphysBase(4):
+    case MSR_MTRRphysBase(5):
+    case MSR_MTRRphysBase(6):
+    case MSR_MTRRphysBase(7):
+        val = env->mtrr_var[((uint32_t)env->regs[R_ECX] -
+                             MSR_MTRRphysBase(0)) / 2].base;
+        break;
+    case MSR_MTRRphysMask(0):
+    case MSR_MTRRphysMask(1):
+    case MSR_MTRRphysMask(2):
+    case MSR_MTRRphysMask(3):
+    case MSR_MTRRphysMask(4):
+    case MSR_MTRRphysMask(5):
+    case MSR_MTRRphysMask(6):
+    case MSR_MTRRphysMask(7):
+        val = env->mtrr_var[((uint32_t)env->regs[R_ECX] -
+                             MSR_MTRRphysMask(0)) / 2].mask;
+        break;
+    case MSR_MTRRfix64K_00000:
+        val = env->mtrr_fixed[0];
+        break;
+    case MSR_MTRRfix16K_80000:
+    case MSR_MTRRfix16K_A0000:
+        val = env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
+                              MSR_MTRRfix16K_80000 + 1];
+        break;
+    case MSR_MTRRfix4K_C0000:
+    case MSR_MTRRfix4K_C8000:
+    case MSR_MTRRfix4K_D0000:
+    case MSR_MTRRfix4K_D8000:
+    case MSR_MTRRfix4K_E0000:
+    case MSR_MTRRfix4K_E8000:
+    case MSR_MTRRfix4K_F0000:
+    case MSR_MTRRfix4K_F8000:
+        val = env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
+                              MSR_MTRRfix4K_C0000 + 3];
+        break;
+    case MSR_MTRRdefType:
+        val = env->mtrr_deftype;
+        break;
+    case MSR_MTRRcap:
+        if (env->features[FEAT_1_EDX] & CPUID_MTRR) {
+            val = MSR_MTRRcap_VCNT | MSR_MTRRcap_FIXRANGE_SUPPORT |
+                MSR_MTRRcap_WC_SUPPORTED;
+        } else {
+            /* XXX: exception? */
+            val = 0;
+        }
+        break;
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
+    case MSR_MCG_STATUS:
+        val = env->mcg_status;
+        break;
+    case MSR_IA32_MISC_ENABLE:
+        val = env->msr_ia32_misc_enable;
+        break;
+    case MSR_IA32_BNDCFGS:
+        val = env->msr_bndcfgs;
+        break;
+    default:
+        if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
+            && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
+            (4 * env->mcg_cap & 0xff)) {
+            uint32_t offset = (uint32_t)env->regs[R_ECX] - MSR_MC0_CTL;
+            val = env->mce_banks[offset];
+            break;
+        }
+        /* XXX: exception? */
+        val = 0;
+        break;
+    }
+
+    stq_p(&val, val);
+    m64c->DataValueLow  = val;
+    m64c->DataValueHigh = val >> 32;
+    pd->m64.ReturnStatus = STATUS_SUCCESS;
+}
+
+void kd_api_write_msr(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_READ_WRITE_MSR *m64c = &pd->m64.u.ReadWriteMsr;
+    CPUArchState *env = cpu->env_ptr;
+
+    uint64_t val;
+
+    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, 0);
+
+    val = m64c->DataValueLow | ((uint64_t) m64c->DataValueHigh) << 32;
+    val = ldq_p(&val);
+
+    switch ((uint32_t)env->regs[R_ECX]) {
+    case MSR_IA32_SYSENTER_CS:
+        env->sysenter_cs = val & 0xffff;
+        break;
+    case MSR_IA32_SYSENTER_ESP:
+        env->sysenter_esp = val;
+        break;
+    case MSR_IA32_SYSENTER_EIP:
+        env->sysenter_eip = val;
+        break;
+    case MSR_IA32_APICBASE:
+        cpu_set_apic_base(x86_env_get_cpu(env)->apic_state, val);
+        break;
+    case MSR_EFER:
+        {
+            uint64_t update_mask;
+
+            update_mask = 0;
+            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_SYSCALL) {
+                update_mask |= MSR_EFER_SCE;
+            }
+            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
+                update_mask |= MSR_EFER_LME;
+            }
+            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_FFXSR) {
+                update_mask |= MSR_EFER_FFXSR;
+            }
+            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_NX) {
+                update_mask |= MSR_EFER_NXE;
+            }
+            if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
+                update_mask |= MSR_EFER_SVME;
+            }
+            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_FFXSR) {
+                update_mask |= MSR_EFER_FFXSR;
+            }
+            cpu_load_efer(env, (env->efer & ~update_mask) |
+                          (val & update_mask));
+        }
+        break;
+    case MSR_STAR:
+        env->star = val;
+        break;
+    case MSR_PAT:
+        env->pat = val;
+        break;
+    case MSR_VM_HSAVE_PA:
+        env->vm_hsave = val;
+        break;
+#ifdef TARGET_X86_64
+    case MSR_LSTAR:
+        env->lstar = val;
+        break;
+    case MSR_CSTAR:
+        env->cstar = val;
+        break;
+    case MSR_FMASK:
+        env->fmask = val;
+        break;
+    case MSR_FSBASE:
+        env->segs[R_FS].base = val;
+        break;
+    case MSR_GSBASE:
+        env->segs[R_GS].base = val;
+        break;
+    case MSR_KERNELGSBASE:
+        env->kernelgsbase = val;
+        break;
+#endif
+    case MSR_MTRRphysBase(0):
+    case MSR_MTRRphysBase(1):
+    case MSR_MTRRphysBase(2):
+    case MSR_MTRRphysBase(3):
+    case MSR_MTRRphysBase(4):
+    case MSR_MTRRphysBase(5):
+    case MSR_MTRRphysBase(6):
+    case MSR_MTRRphysBase(7):
+        env->mtrr_var[((uint32_t)env->regs[R_ECX] -
+                       MSR_MTRRphysBase(0)) / 2].base = val;
+        break;
+    case MSR_MTRRphysMask(0):
+    case MSR_MTRRphysMask(1):
+    case MSR_MTRRphysMask(2):
+    case MSR_MTRRphysMask(3):
+    case MSR_MTRRphysMask(4):
+    case MSR_MTRRphysMask(5):
+    case MSR_MTRRphysMask(6):
+    case MSR_MTRRphysMask(7):
+        env->mtrr_var[((uint32_t)env->regs[R_ECX] -
+                       MSR_MTRRphysMask(0)) / 2].mask = val;
+        break;
+    case MSR_MTRRfix64K_00000:
+        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
+                        MSR_MTRRfix64K_00000] = val;
+        break;
+    case MSR_MTRRfix16K_80000:
+    case MSR_MTRRfix16K_A0000:
+        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
+                        MSR_MTRRfix16K_80000 + 1] = val;
+        break;
+    case MSR_MTRRfix4K_C0000:
+    case MSR_MTRRfix4K_C8000:
+    case MSR_MTRRfix4K_D0000:
+    case MSR_MTRRfix4K_D8000:
+    case MSR_MTRRfix4K_E0000:
+    case MSR_MTRRfix4K_E8000:
+    case MSR_MTRRfix4K_F0000:
+    case MSR_MTRRfix4K_F8000:
+        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
+                        MSR_MTRRfix4K_C0000 + 3] = val;
+        break;
+    case MSR_MTRRdefType:
+        env->mtrr_deftype = val;
+        break;
+    case MSR_MCG_STATUS:
+        env->mcg_status = val;
+        break;
+    case MSR_MCG_CTL:
+        if ((env->mcg_cap & MCG_CTL_P)
+            && (val == 0 || val == ~(uint64_t)0)) {
+            env->mcg_ctl = val;
+        }
+        break;
+    case MSR_TSC_AUX:
+        env->tsc_aux = val;
+        break;
+    case MSR_IA32_MISC_ENABLE:
+        env->msr_ia32_misc_enable = val;
+        break;
+    case MSR_IA32_BNDCFGS:
+        /* FIXME: #GP if reserved bits are set.  */
+        /* FIXME: Extend highest implemented bit of linear address.  */
+        env->msr_bndcfgs = val;
+        cpu_sync_bndcs_hflags(env);
+        break;
+    default:
+        if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
+            && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
+            (4 * env->mcg_cap & 0xff)) {
+            uint32_t offset = (uint32_t)env->regs[R_ECX] - MSR_MC0_CTL;
+            if ((offset & 0x3) != 0
+                || (val == 0 || val == ~(uint64_t)0)) {
+                env->mce_banks[offset] = val;
+            }
+            break;
+        }
+        /* XXX: exception? */
+        break;
+    }
+
+    pd->m64.ReturnStatus = STATUS_SUCCESS;
+}
+
 bool windbg_on_load(void)
 {
     CPUState *cpu = qemu_get_cpu(0);
diff --git a/windbgstub.c b/windbgstub.c
index 06e99199b6..45f61917d9 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -197,6 +197,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_write_physical_memory(cpu, &ctx->data);
         break;
 
+    case DbgKdReadMachineSpecificRegister:
+        kd_api_read_msr(cpu, &ctx->data);
+        break;
+
+    case DbgKdWriteMachineSpecificRegister:
+        kd_api_write_msr(cpu, &ctx->data);
+        break;
+
     case DbgKdGetVersionApi:
         kd_api_get_version(cpu, &ctx->data);
         break;
