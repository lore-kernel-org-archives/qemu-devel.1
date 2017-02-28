Received: from eggs.gnu.org ([2001:4830:134:3::10]:43825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cilPm-0003Jw-Cw
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cilPi-0003hr-Tt
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:18 -0500
Received: from clearmind.me ([178.32.49.9]:49925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ale@clearmind.me>) id 1cilPi-0003ga-GH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:14 -0500
From: Alessandro Di Federico <ale+qemu@clearmind.me>
Date: Tue, 28 Feb 2017 18:19:17 +0100
Message-Id: <20170228171921.21602-4-ale+qemu@clearmind.me>
In-Reply-To: <20170228171921.21602-1-ale+qemu@clearmind.me>
References: <20170228171921.21602-1-ale+qemu@clearmind.me>
Sender: ale@clearmind.me
Subject: [Qemu-devel] [PATCH 3/7] Move *_cpu_dump_state to translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The *_cpu_dump_state functions used to be spread in different files
(mainly translate.c but also helper.c and cpu.c). This patch simply
moves, for uniformity reasons, in translate.c those that were not there
yet.
---
 target/alpha/helper.c     |  34 -----
 target/alpha/translate.c  |  34 +++++
 target/hppa/helper.c      |  25 ----
 target/hppa/translate.c   |  25 ++++
 target/i386/helper.c      | 323 ----------------------------------------------
 target/i386/translate.c   | 323 ++++++++++++++++++++++++++++++++++++++++++++++
 target/sparc/cpu.c        |  85 ------------
 target/sparc/translate.c  |  85 ++++++++++++
 target/tilegx/cpu.c       |  26 ----
 target/tilegx/cpu.h       |   3 +
 target/tilegx/translate.c |  26 ++++
 11 files changed, 496 insertions(+), 493 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index a5c308859b..041a9d1c2c 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -418,40 +418,6 @@ bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-void alpha_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                          int flags)
-{
-    static const char *linux_reg_names[] = {
-        "v0 ", "t0 ", "t1 ", "t2 ", "t3 ", "t4 ", "t5 ", "t6 ",
-        "t7 ", "s0 ", "s1 ", "s2 ", "s3 ", "s4 ", "s5 ", "fp ",
-        "a0 ", "a1 ", "a2 ", "a3 ", "a4 ", "a5 ", "t8 ", "t9 ",
-        "t10", "t11", "ra ", "t12", "at ", "gp ", "sp ", "zero",
-    };
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
-    int i;
-
-    cpu_fprintf(f, "     PC  " TARGET_FMT_lx "      PS  %02x\n",
-                env->pc, env->ps);
-    for (i = 0; i < 31; i++) {
-        cpu_fprintf(f, "IR%02d %s " TARGET_FMT_lx " ", i,
-                    linux_reg_names[i], cpu_alpha_load_gr(env, i));
-        if ((i % 3) == 2)
-            cpu_fprintf(f, "\n");
-    }
-
-    cpu_fprintf(f, "lock_a   " TARGET_FMT_lx " lock_v   " TARGET_FMT_lx "\n",
-                env->lock_addr, env->lock_value);
-
-    for (i = 0; i < 31; i++) {
-        cpu_fprintf(f, "FIR%02d    " TARGET_FMT_lx " ", i,
-                    *((uint64_t *)(&env->fir[i])));
-        if ((i % 3) == 2)
-            cpu_fprintf(f, "\n");
-    }
-    cpu_fprintf(f, "\n");
-}
-
 /* This should only be called from translate, via gen_excp.
    We expect that ENV->PC has already been updated.  */
 void QEMU_NORETURN helper_excp(CPUAlphaState *env, int excp, int error)
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 055286a7b8..df06591997 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -3025,3 +3025,37 @@ void restore_state_to_opc(CPUAlphaState *env, TranslationBlock *tb,
 {
     env->pc = data[0];
 }
+
+void alpha_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
+                          int flags)
+{
+    static const char *linux_reg_names[] = {
+        "v0 ", "t0 ", "t1 ", "t2 ", "t3 ", "t4 ", "t5 ", "t6 ",
+        "t7 ", "s0 ", "s1 ", "s2 ", "s3 ", "s4 ", "s5 ", "fp ",
+        "a0 ", "a1 ", "a2 ", "a3 ", "a4 ", "a5 ", "t8 ", "t9 ",
+        "t10", "t11", "ra ", "t12", "at ", "gp ", "sp ", "zero",
+    };
+    AlphaCPU *cpu = ALPHA_CPU(cs);
+    CPUAlphaState *env = &cpu->env;
+    int i;
+
+    cpu_fprintf(f, "     PC  " TARGET_FMT_lx "      PS  %02x\n",
+                env->pc, env->ps);
+    for (i = 0; i < 31; i++) {
+        cpu_fprintf(f, "IR%02d %s " TARGET_FMT_lx " ", i,
+                    linux_reg_names[i], cpu_alpha_load_gr(env, i));
+        if ((i % 3) == 2)
+            cpu_fprintf(f, "\n");
+    }
+
+    cpu_fprintf(f, "lock_a   " TARGET_FMT_lx " lock_v   " TARGET_FMT_lx "\n",
+                env->lock_addr, env->lock_value);
+
+    for (i = 0; i < 31; i++) {
+        cpu_fprintf(f, "FIR%02d    " TARGET_FMT_lx " ", i,
+                    *((uint64_t *)(&env->fir[i])));
+        if ((i % 3) == 2)
+            cpu_fprintf(f, "\n");
+    }
+    cpu_fprintf(f, "\n");
+}
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index ba04a9a52b..c7eecfc457 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -110,28 +110,3 @@ bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     abort();
     return false;
 }
-
-void hppa_cpu_dump_state(CPUState *cs, FILE *f,
-                         fprintf_function cpu_fprintf, int flags)
-{
-    HPPACPU *cpu = HPPA_CPU(cs);
-    CPUHPPAState *env = &cpu->env;
-    int i;
-
-    cpu_fprintf(f, "IA_F " TARGET_FMT_lx
-                   " IA_B " TARGET_FMT_lx
-                   " PSW  " TARGET_FMT_lx
-                   " [N:" TARGET_FMT_ld " V:%d"
-                   " CB:" TARGET_FMT_lx "]\n              ",
-                env->iaoq_f, env->iaoq_b, cpu_hppa_get_psw(env),
-                env->psw_n, env->psw_v < 0,
-                ((env->psw_cb >> 4) & 0x01111111) | (env->psw_cb_msb << 28));
-    for (i = 1; i < 32; i++) {
-        cpu_fprintf(f, "GR%02d " TARGET_FMT_lx " ", i, env->gr[i]);
-        if ((i % 4) == 3) {
-            cpu_fprintf(f, "\n");
-        }
-    }
-
-    /* ??? FR */
-}
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 5d571f0a4e..5eeb35abc3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3937,3 +3937,28 @@ void restore_state_to_opc(CPUHPPAState *env, TranslationBlock *tb,
        that the instruction was not nullified.  */
     env->psw_n = 0;
 }
+
+void hppa_cpu_dump_state(CPUState *cs, FILE *f,
+                         fprintf_function cpu_fprintf, int flags)
+{
+    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
+    int i;
+
+    cpu_fprintf(f, "IA_F " TARGET_FMT_lx
+                   " IA_B " TARGET_FMT_lx
+                   " PSW  " TARGET_FMT_lx
+                   " [N:" TARGET_FMT_ld " V:%d"
+                   " CB:" TARGET_FMT_lx "]\n              ",
+                env->iaoq_f, env->iaoq_b, cpu_hppa_get_psw(env),
+                env->psw_n, env->psw_v < 0,
+                ((env->psw_cb >> 4) & 0x01111111) | (env->psw_cb_msb << 28));
+    for (i = 1; i < 32; i++) {
+        cpu_fprintf(f, "GR%02d " TARGET_FMT_lx " ", i, env->gr[i]);
+        if ((i % 4) == 3) {
+            cpu_fprintf(f, "\n");
+        }
+    }
+
+    /* ??? FR */
+}
diff --git a/target/i386/helper.c b/target/i386/helper.c
index e2af3404f2..9bfcf8f238 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -55,132 +55,6 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
     return 0;
 }
 
-/***********************************************************/
-/* x86 debug */
-
-static const char *cc_op_str[CC_OP_NB] = {
-    "DYNAMIC",
-    "EFLAGS",
-
-    "MULB",
-    "MULW",
-    "MULL",
-    "MULQ",
-
-    "ADDB",
-    "ADDW",
-    "ADDL",
-    "ADDQ",
-
-    "ADCB",
-    "ADCW",
-    "ADCL",
-    "ADCQ",
-
-    "SUBB",
-    "SUBW",
-    "SUBL",
-    "SUBQ",
-
-    "SBBB",
-    "SBBW",
-    "SBBL",
-    "SBBQ",
-
-    "LOGICB",
-    "LOGICW",
-    "LOGICL",
-    "LOGICQ",
-
-    "INCB",
-    "INCW",
-    "INCL",
-    "INCQ",
-
-    "DECB",
-    "DECW",
-    "DECL",
-    "DECQ",
-
-    "SHLB",
-    "SHLW",
-    "SHLL",
-    "SHLQ",
-
-    "SARB",
-    "SARW",
-    "SARL",
-    "SARQ",
-
-    "BMILGB",
-    "BMILGW",
-    "BMILGL",
-    "BMILGQ",
-
-    "ADCX",
-    "ADOX",
-    "ADCOX",
-
-    "CLR",
-};
-
-static void
-cpu_x86_dump_seg_cache(CPUX86State *env, FILE *f, fprintf_function cpu_fprintf,
-                       const char *name, struct SegmentCache *sc)
-{
-#ifdef TARGET_X86_64
-    if (env->hflags & HF_CS64_MASK) {
-        cpu_fprintf(f, "%-3s=%04x %016" PRIx64 " %08x %08x", name,
-                    sc->selector, sc->base, sc->limit, sc->flags & 0x00ffff00);
-    } else
-#endif
-    {
-        cpu_fprintf(f, "%-3s=%04x %08x %08x %08x", name, sc->selector,
-                    (uint32_t)sc->base, sc->limit, sc->flags & 0x00ffff00);
-    }
-
-    if (!(env->hflags & HF_PE_MASK) || !(sc->flags & DESC_P_MASK))
-        goto done;
-
-    cpu_fprintf(f, " DPL=%d ", (sc->flags & DESC_DPL_MASK) >> DESC_DPL_SHIFT);
-    if (sc->flags & DESC_S_MASK) {
-        if (sc->flags & DESC_CS_MASK) {
-            cpu_fprintf(f, (sc->flags & DESC_L_MASK) ? "CS64" :
-                           ((sc->flags & DESC_B_MASK) ? "CS32" : "CS16"));
-            cpu_fprintf(f, " [%c%c", (sc->flags & DESC_C_MASK) ? 'C' : '-',
-                        (sc->flags & DESC_R_MASK) ? 'R' : '-');
-        } else {
-            cpu_fprintf(f,
-                        (sc->flags & DESC_B_MASK || env->hflags & HF_LMA_MASK)
-                        ? "DS  " : "DS16");
-            cpu_fprintf(f, " [%c%c", (sc->flags & DESC_E_MASK) ? 'E' : '-',
-                        (sc->flags & DESC_W_MASK) ? 'W' : '-');
-        }
-        cpu_fprintf(f, "%c]", (sc->flags & DESC_A_MASK) ? 'A' : '-');
-    } else {
-        static const char *sys_type_name[2][16] = {
-            { /* 32 bit mode */
-                "Reserved", "TSS16-avl", "LDT", "TSS16-busy",
-                "CallGate16", "TaskGate", "IntGate16", "TrapGate16",
-                "Reserved", "TSS32-avl", "Reserved", "TSS32-busy",
-                "CallGate32", "Reserved", "IntGate32", "TrapGate32"
-            },
-            { /* 64 bit mode */
-                "<hiword>", "Reserved", "LDT", "Reserved", "Reserved",
-                "Reserved", "Reserved", "Reserved", "Reserved",
-                "TSS64-avl", "Reserved", "TSS64-busy", "CallGate64",
-                "Reserved", "IntGate64", "TrapGate64"
-            }
-        };
-        cpu_fprintf(f, "%s",
-                    sys_type_name[(env->hflags & HF_LMA_MASK) ? 1 : 0]
-                                 [(sc->flags & DESC_TYPE_MASK)
-                                  >> DESC_TYPE_SHIFT]);
-    }
-done:
-    cpu_fprintf(f, "\n");
-}
-
 #ifndef CONFIG_USER_ONLY
 
 /* ARRAY_SIZE check is not required because
@@ -371,203 +245,6 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
 }
 #endif /* !CONFIG_USER_ONLY */
 
-#define DUMP_CODE_BYTES_TOTAL    50
-#define DUMP_CODE_BYTES_BACKWARD 20
-
-void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                        int flags)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-    int eflags, i, nb;
-    char cc_op_name[32];
-    static const char *seg_name[6] = { "ES", "CS", "SS", "DS", "FS", "GS" };
-
-    eflags = cpu_compute_eflags(env);
-#ifdef TARGET_X86_64
-    if (env->hflags & HF_CS64_MASK) {
-        cpu_fprintf(f,
-                    "RAX=%016" PRIx64 " RBX=%016" PRIx64 " RCX=%016" PRIx64 " RDX=%016" PRIx64 "\n"
-                    "RSI=%016" PRIx64 " RDI=%016" PRIx64 " RBP=%016" PRIx64 " RSP=%016" PRIx64 "\n"
-                    "R8 =%016" PRIx64 " R9 =%016" PRIx64 " R10=%016" PRIx64 " R11=%016" PRIx64 "\n"
-                    "R12=%016" PRIx64 " R13=%016" PRIx64 " R14=%016" PRIx64 " R15=%016" PRIx64 "\n"
-                    "RIP=%016" PRIx64 " RFL=%08x [%c%c%c%c%c%c%c] CPL=%d II=%d A20=%d SMM=%d HLT=%d\n",
-                    env->regs[R_EAX],
-                    env->regs[R_EBX],
-                    env->regs[R_ECX],
-                    env->regs[R_EDX],
-                    env->regs[R_ESI],
-                    env->regs[R_EDI],
-                    env->regs[R_EBP],
-                    env->regs[R_ESP],
-                    env->regs[8],
-                    env->regs[9],
-                    env->regs[10],
-                    env->regs[11],
-                    env->regs[12],
-                    env->regs[13],
-                    env->regs[14],
-                    env->regs[15],
-                    env->eip, eflags,
-                    eflags & DF_MASK ? 'D' : '-',
-                    eflags & CC_O ? 'O' : '-',
-                    eflags & CC_S ? 'S' : '-',
-                    eflags & CC_Z ? 'Z' : '-',
-                    eflags & CC_A ? 'A' : '-',
-                    eflags & CC_P ? 'P' : '-',
-                    eflags & CC_C ? 'C' : '-',
-                    env->hflags & HF_CPL_MASK,
-                    (env->hflags >> HF_INHIBIT_IRQ_SHIFT) & 1,
-                    (env->a20_mask >> 20) & 1,
-                    (env->hflags >> HF_SMM_SHIFT) & 1,
-                    cs->halted);
-    } else
-#endif
-    {
-        cpu_fprintf(f, "EAX=%08x EBX=%08x ECX=%08x EDX=%08x\n"
-                    "ESI=%08x EDI=%08x EBP=%08x ESP=%08x\n"
-                    "EIP=%08x EFL=%08x [%c%c%c%c%c%c%c] CPL=%d II=%d A20=%d SMM=%d HLT=%d\n",
-                    (uint32_t)env->regs[R_EAX],
-                    (uint32_t)env->regs[R_EBX],
-                    (uint32_t)env->regs[R_ECX],
-                    (uint32_t)env->regs[R_EDX],
-                    (uint32_t)env->regs[R_ESI],
-                    (uint32_t)env->regs[R_EDI],
-                    (uint32_t)env->regs[R_EBP],
-                    (uint32_t)env->regs[R_ESP],
-                    (uint32_t)env->eip, eflags,
-                    eflags & DF_MASK ? 'D' : '-',
-                    eflags & CC_O ? 'O' : '-',
-                    eflags & CC_S ? 'S' : '-',
-                    eflags & CC_Z ? 'Z' : '-',
-                    eflags & CC_A ? 'A' : '-',
-                    eflags & CC_P ? 'P' : '-',
-                    eflags & CC_C ? 'C' : '-',
-                    env->hflags & HF_CPL_MASK,
-                    (env->hflags >> HF_INHIBIT_IRQ_SHIFT) & 1,
-                    (env->a20_mask >> 20) & 1,
-                    (env->hflags >> HF_SMM_SHIFT) & 1,
-                    cs->halted);
-    }
-
-    for(i = 0; i < 6; i++) {
-        cpu_x86_dump_seg_cache(env, f, cpu_fprintf, seg_name[i],
-                               &env->segs[i]);
-    }
-    cpu_x86_dump_seg_cache(env, f, cpu_fprintf, "LDT", &env->ldt);
-    cpu_x86_dump_seg_cache(env, f, cpu_fprintf, "TR", &env->tr);
-
-#ifdef TARGET_X86_64
-    if (env->hflags & HF_LMA_MASK) {
-        cpu_fprintf(f, "GDT=     %016" PRIx64 " %08x\n",
-                    env->gdt.base, env->gdt.limit);
-        cpu_fprintf(f, "IDT=     %016" PRIx64 " %08x\n",
-                    env->idt.base, env->idt.limit);
-        cpu_fprintf(f, "CR0=%08x CR2=%016" PRIx64 " CR3=%016" PRIx64 " CR4=%08x\n",
-                    (uint32_t)env->cr[0],
-                    env->cr[2],
-                    env->cr[3],
-                    (uint32_t)env->cr[4]);
-        for(i = 0; i < 4; i++)
-            cpu_fprintf(f, "DR%d=%016" PRIx64 " ", i, env->dr[i]);
-        cpu_fprintf(f, "\nDR6=%016" PRIx64 " DR7=%016" PRIx64 "\n",
-                    env->dr[6], env->dr[7]);
-    } else
-#endif
-    {
-        cpu_fprintf(f, "GDT=     %08x %08x\n",
-                    (uint32_t)env->gdt.base, env->gdt.limit);
-        cpu_fprintf(f, "IDT=     %08x %08x\n",
-                    (uint32_t)env->idt.base, env->idt.limit);
-        cpu_fprintf(f, "CR0=%08x CR2=%08x CR3=%08x CR4=%08x\n",
-                    (uint32_t)env->cr[0],
-                    (uint32_t)env->cr[2],
-                    (uint32_t)env->cr[3],
-                    (uint32_t)env->cr[4]);
-        for(i = 0; i < 4; i++) {
-            cpu_fprintf(f, "DR%d=" TARGET_FMT_lx " ", i, env->dr[i]);
-        }
-        cpu_fprintf(f, "\nDR6=" TARGET_FMT_lx " DR7=" TARGET_FMT_lx "\n",
-                    env->dr[6], env->dr[7]);
-    }
-    if (flags & CPU_DUMP_CCOP) {
-        if ((unsigned)env->cc_op < CC_OP_NB)
-            snprintf(cc_op_name, sizeof(cc_op_name), "%s", cc_op_str[env->cc_op]);
-        else
-            snprintf(cc_op_name, sizeof(cc_op_name), "[%d]", env->cc_op);
-#ifdef TARGET_X86_64
-        if (env->hflags & HF_CS64_MASK) {
-            cpu_fprintf(f, "CCS=%016" PRIx64 " CCD=%016" PRIx64 " CCO=%-8s\n",
-                        env->cc_src, env->cc_dst,
-                        cc_op_name);
-        } else
-#endif
-        {
-            cpu_fprintf(f, "CCS=%08x CCD=%08x CCO=%-8s\n",
-                        (uint32_t)env->cc_src, (uint32_t)env->cc_dst,
-                        cc_op_name);
-        }
-    }
-    cpu_fprintf(f, "EFER=%016" PRIx64 "\n", env->efer);
-    if (flags & CPU_DUMP_FPU) {
-        int fptag;
-        fptag = 0;
-        for(i = 0; i < 8; i++) {
-            fptag |= ((!env->fptags[i]) << i);
-        }
-        cpu_fprintf(f, "FCW=%04x FSW=%04x [ST=%d] FTW=%02x MXCSR=%08x\n",
-                    env->fpuc,
-                    (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11,
-                    env->fpstt,
-                    fptag,
-                    env->mxcsr);
-        for(i=0;i<8;i++) {
-            CPU_LDoubleU u;
-            u.d = env->fpregs[i].d;
-            cpu_fprintf(f, "FPR%d=%016" PRIx64 " %04x",
-                        i, u.l.lower, u.l.upper);
-            if ((i & 1) == 1)
-                cpu_fprintf(f, "\n");
-            else
-                cpu_fprintf(f, " ");
-        }
-        if (env->hflags & HF_CS64_MASK)
-            nb = 16;
-        else
-            nb = 8;
-        for(i=0;i<nb;i++) {
-            cpu_fprintf(f, "XMM%02d=%08x%08x%08x%08x",
-                        i,
-                        env->xmm_regs[i].ZMM_L(3),
-                        env->xmm_regs[i].ZMM_L(2),
-                        env->xmm_regs[i].ZMM_L(1),
-                        env->xmm_regs[i].ZMM_L(0));
-            if ((i & 1) == 1)
-                cpu_fprintf(f, "\n");
-            else
-                cpu_fprintf(f, " ");
-        }
-    }
-    if (flags & CPU_DUMP_CODE) {
-        target_ulong base = env->segs[R_CS].base + env->eip;
-        target_ulong offs = MIN(env->eip, DUMP_CODE_BYTES_BACKWARD);
-        uint8_t code;
-        char codestr[3];
-
-        cpu_fprintf(f, "Code=");
-        for (i = 0; i < DUMP_CODE_BYTES_TOTAL; i++) {
-            if (cpu_memory_rw_debug(cs, base - offs + i, &code, 1, 0) == 0) {
-                snprintf(codestr, sizeof(codestr), "%02x", code);
-            } else {
-                snprintf(codestr, sizeof(codestr), "??");
-            }
-            cpu_fprintf(f, "%s%s%s%s", i > 0 ? " " : "",
-                        i == offs ? "<" : "", codestr, i == offs ? ">" : "");
-        }
-        cpu_fprintf(f, "\n");
-    }
-}
-
 /***********************************************************/
 /* x86 mmu */
 /* XXX: add PGE support */
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 72c1b03a2a..5623ee65a6 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8526,3 +8526,326 @@ void restore_state_to_opc(CPUX86State *env, TranslationBlock *tb,
         env->cc_op = cc_op;
     }
 }
+
+/***********************************************************/
+/* x86 debug */
+
+static const char *cc_op_str[CC_OP_NB] = {
+    "DYNAMIC",
+    "EFLAGS",
+
+    "MULB",
+    "MULW",
+    "MULL",
+    "MULQ",
+
+    "ADDB",
+    "ADDW",
+    "ADDL",
+    "ADDQ",
+
+    "ADCB",
+    "ADCW",
+    "ADCL",
+    "ADCQ",
+
+    "SUBB",
+    "SUBW",
+    "SUBL",
+    "SUBQ",
+
+    "SBBB",
+    "SBBW",
+    "SBBL",
+    "SBBQ",
+
+    "LOGICB",
+    "LOGICW",
+    "LOGICL",
+    "LOGICQ",
+
+    "INCB",
+    "INCW",
+    "INCL",
+    "INCQ",
+
+    "DECB",
+    "DECW",
+    "DECL",
+    "DECQ",
+
+    "SHLB",
+    "SHLW",
+    "SHLL",
+    "SHLQ",
+
+    "SARB",
+    "SARW",
+    "SARL",
+    "SARQ",
+
+    "BMILGB",
+    "BMILGW",
+    "BMILGL",
+    "BMILGQ",
+
+    "ADCX",
+    "ADOX",
+    "ADCOX",
+
+    "CLR",
+};
+
+static void
+cpu_x86_dump_seg_cache(CPUX86State *env, FILE *f, fprintf_function cpu_fprintf,
+                       const char *name, struct SegmentCache *sc)
+{
+#ifdef TARGET_X86_64
+    if (env->hflags & HF_CS64_MASK) {
+        cpu_fprintf(f, "%-3s=%04x %016" PRIx64 " %08x %08x", name,
+                    sc->selector, sc->base, sc->limit, sc->flags & 0x00ffff00);
+    } else
+#endif
+    {
+        cpu_fprintf(f, "%-3s=%04x %08x %08x %08x", name, sc->selector,
+                    (uint32_t)sc->base, sc->limit, sc->flags & 0x00ffff00);
+    }
+
+    if (!(env->hflags & HF_PE_MASK) || !(sc->flags & DESC_P_MASK))
+        goto done;
+
+    cpu_fprintf(f, " DPL=%d ", (sc->flags & DESC_DPL_MASK) >> DESC_DPL_SHIFT);
+    if (sc->flags & DESC_S_MASK) {
+        if (sc->flags & DESC_CS_MASK) {
+            cpu_fprintf(f, (sc->flags & DESC_L_MASK) ? "CS64" :
+                           ((sc->flags & DESC_B_MASK) ? "CS32" : "CS16"));
+            cpu_fprintf(f, " [%c%c", (sc->flags & DESC_C_MASK) ? 'C' : '-',
+                        (sc->flags & DESC_R_MASK) ? 'R' : '-');
+        } else {
+            cpu_fprintf(f,
+                        (sc->flags & DESC_B_MASK || env->hflags & HF_LMA_MASK)
+                        ? "DS  " : "DS16");
+            cpu_fprintf(f, " [%c%c", (sc->flags & DESC_E_MASK) ? 'E' : '-',
+                        (sc->flags & DESC_W_MASK) ? 'W' : '-');
+        }
+        cpu_fprintf(f, "%c]", (sc->flags & DESC_A_MASK) ? 'A' : '-');
+    } else {
+        static const char *sys_type_name[2][16] = {
+            { /* 32 bit mode */
+                "Reserved", "TSS16-avl", "LDT", "TSS16-busy",
+                "CallGate16", "TaskGate", "IntGate16", "TrapGate16",
+                "Reserved", "TSS32-avl", "Reserved", "TSS32-busy",
+                "CallGate32", "Reserved", "IntGate32", "TrapGate32"
+            },
+            { /* 64 bit mode */
+                "<hiword>", "Reserved", "LDT", "Reserved", "Reserved",
+                "Reserved", "Reserved", "Reserved", "Reserved",
+                "TSS64-avl", "Reserved", "TSS64-busy", "CallGate64",
+                "Reserved", "IntGate64", "TrapGate64"
+            }
+        };
+        cpu_fprintf(f, "%s",
+                    sys_type_name[(env->hflags & HF_LMA_MASK) ? 1 : 0]
+                                 [(sc->flags & DESC_TYPE_MASK)
+                                  >> DESC_TYPE_SHIFT]);
+    }
+done:
+    cpu_fprintf(f, "\n");
+}
+
+#define DUMP_CODE_BYTES_TOTAL    50
+#define DUMP_CODE_BYTES_BACKWARD 20
+
+void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
+                        int flags)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    int eflags, i, nb;
+    char cc_op_name[32];
+    static const char *seg_name[6] = { "ES", "CS", "SS", "DS", "FS", "GS" };
+
+    eflags = cpu_compute_eflags(env);
+#ifdef TARGET_X86_64
+    if (env->hflags & HF_CS64_MASK) {
+        cpu_fprintf(f,
+                    "RAX=%016" PRIx64 " RBX=%016" PRIx64 " RCX=%016" PRIx64 " RDX=%016" PRIx64 "\n"
+                    "RSI=%016" PRIx64 " RDI=%016" PRIx64 " RBP=%016" PRIx64 " RSP=%016" PRIx64 "\n"
+                    "R8 =%016" PRIx64 " R9 =%016" PRIx64 " R10=%016" PRIx64 " R11=%016" PRIx64 "\n"
+                    "R12=%016" PRIx64 " R13=%016" PRIx64 " R14=%016" PRIx64 " R15=%016" PRIx64 "\n"
+                    "RIP=%016" PRIx64 " RFL=%08x [%c%c%c%c%c%c%c] CPL=%d II=%d A20=%d SMM=%d HLT=%d\n",
+                    env->regs[R_EAX],
+                    env->regs[R_EBX],
+                    env->regs[R_ECX],
+                    env->regs[R_EDX],
+                    env->regs[R_ESI],
+                    env->regs[R_EDI],
+                    env->regs[R_EBP],
+                    env->regs[R_ESP],
+                    env->regs[8],
+                    env->regs[9],
+                    env->regs[10],
+                    env->regs[11],
+                    env->regs[12],
+                    env->regs[13],
+                    env->regs[14],
+                    env->regs[15],
+                    env->eip, eflags,
+                    eflags & DF_MASK ? 'D' : '-',
+                    eflags & CC_O ? 'O' : '-',
+                    eflags & CC_S ? 'S' : '-',
+                    eflags & CC_Z ? 'Z' : '-',
+                    eflags & CC_A ? 'A' : '-',
+                    eflags & CC_P ? 'P' : '-',
+                    eflags & CC_C ? 'C' : '-',
+                    env->hflags & HF_CPL_MASK,
+                    (env->hflags >> HF_INHIBIT_IRQ_SHIFT) & 1,
+                    (env->a20_mask >> 20) & 1,
+                    (env->hflags >> HF_SMM_SHIFT) & 1,
+                    cs->halted);
+    } else
+#endif
+    {
+        cpu_fprintf(f, "EAX=%08x EBX=%08x ECX=%08x EDX=%08x\n"
+                    "ESI=%08x EDI=%08x EBP=%08x ESP=%08x\n"
+                    "EIP=%08x EFL=%08x [%c%c%c%c%c%c%c] CPL=%d II=%d A20=%d SMM=%d HLT=%d\n",
+                    (uint32_t)env->regs[R_EAX],
+                    (uint32_t)env->regs[R_EBX],
+                    (uint32_t)env->regs[R_ECX],
+                    (uint32_t)env->regs[R_EDX],
+                    (uint32_t)env->regs[R_ESI],
+                    (uint32_t)env->regs[R_EDI],
+                    (uint32_t)env->regs[R_EBP],
+                    (uint32_t)env->regs[R_ESP],
+                    (uint32_t)env->eip, eflags,
+                    eflags & DF_MASK ? 'D' : '-',
+                    eflags & CC_O ? 'O' : '-',
+                    eflags & CC_S ? 'S' : '-',
+                    eflags & CC_Z ? 'Z' : '-',
+                    eflags & CC_A ? 'A' : '-',
+                    eflags & CC_P ? 'P' : '-',
+                    eflags & CC_C ? 'C' : '-',
+                    env->hflags & HF_CPL_MASK,
+                    (env->hflags >> HF_INHIBIT_IRQ_SHIFT) & 1,
+                    (env->a20_mask >> 20) & 1,
+                    (env->hflags >> HF_SMM_SHIFT) & 1,
+                    cs->halted);
+    }
+
+    for(i = 0; i < 6; i++) {
+        cpu_x86_dump_seg_cache(env, f, cpu_fprintf, seg_name[i],
+                               &env->segs[i]);
+    }
+    cpu_x86_dump_seg_cache(env, f, cpu_fprintf, "LDT", &env->ldt);
+    cpu_x86_dump_seg_cache(env, f, cpu_fprintf, "TR", &env->tr);
+
+#ifdef TARGET_X86_64
+    if (env->hflags & HF_LMA_MASK) {
+        cpu_fprintf(f, "GDT=     %016" PRIx64 " %08x\n",
+                    env->gdt.base, env->gdt.limit);
+        cpu_fprintf(f, "IDT=     %016" PRIx64 " %08x\n",
+                    env->idt.base, env->idt.limit);
+        cpu_fprintf(f, "CR0=%08x CR2=%016" PRIx64 " CR3=%016" PRIx64 " CR4=%08x\n",
+                    (uint32_t)env->cr[0],
+                    env->cr[2],
+                    env->cr[3],
+                    (uint32_t)env->cr[4]);
+        for(i = 0; i < 4; i++)
+            cpu_fprintf(f, "DR%d=%016" PRIx64 " ", i, env->dr[i]);
+        cpu_fprintf(f, "\nDR6=%016" PRIx64 " DR7=%016" PRIx64 "\n",
+                    env->dr[6], env->dr[7]);
+    } else
+#endif
+    {
+        cpu_fprintf(f, "GDT=     %08x %08x\n",
+                    (uint32_t)env->gdt.base, env->gdt.limit);
+        cpu_fprintf(f, "IDT=     %08x %08x\n",
+                    (uint32_t)env->idt.base, env->idt.limit);
+        cpu_fprintf(f, "CR0=%08x CR2=%08x CR3=%08x CR4=%08x\n",
+                    (uint32_t)env->cr[0],
+                    (uint32_t)env->cr[2],
+                    (uint32_t)env->cr[3],
+                    (uint32_t)env->cr[4]);
+        for(i = 0; i < 4; i++) {
+            cpu_fprintf(f, "DR%d=" TARGET_FMT_lx " ", i, env->dr[i]);
+        }
+        cpu_fprintf(f, "\nDR6=" TARGET_FMT_lx " DR7=" TARGET_FMT_lx "\n",
+                    env->dr[6], env->dr[7]);
+    }
+    if (flags & CPU_DUMP_CCOP) {
+        if ((unsigned)env->cc_op < CC_OP_NB)
+            snprintf(cc_op_name, sizeof(cc_op_name), "%s", cc_op_str[env->cc_op]);
+        else
+            snprintf(cc_op_name, sizeof(cc_op_name), "[%d]", env->cc_op);
+#ifdef TARGET_X86_64
+        if (env->hflags & HF_CS64_MASK) {
+            cpu_fprintf(f, "CCS=%016" PRIx64 " CCD=%016" PRIx64 " CCO=%-8s\n",
+                        env->cc_src, env->cc_dst,
+                        cc_op_name);
+        } else
+#endif
+        {
+            cpu_fprintf(f, "CCS=%08x CCD=%08x CCO=%-8s\n",
+                        (uint32_t)env->cc_src, (uint32_t)env->cc_dst,
+                        cc_op_name);
+        }
+    }
+    cpu_fprintf(f, "EFER=%016" PRIx64 "\n", env->efer);
+    if (flags & CPU_DUMP_FPU) {
+        int fptag;
+        fptag = 0;
+        for(i = 0; i < 8; i++) {
+            fptag |= ((!env->fptags[i]) << i);
+        }
+        cpu_fprintf(f, "FCW=%04x FSW=%04x [ST=%d] FTW=%02x MXCSR=%08x\n",
+                    env->fpuc,
+                    (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11,
+                    env->fpstt,
+                    fptag,
+                    env->mxcsr);
+        for(i=0;i<8;i++) {
+            CPU_LDoubleU u;
+            u.d = env->fpregs[i].d;
+            cpu_fprintf(f, "FPR%d=%016" PRIx64 " %04x",
+                        i, u.l.lower, u.l.upper);
+            if ((i & 1) == 1)
+                cpu_fprintf(f, "\n");
+            else
+                cpu_fprintf(f, " ");
+        }
+        if (env->hflags & HF_CS64_MASK)
+            nb = 16;
+        else
+            nb = 8;
+        for(i=0;i<nb;i++) {
+            cpu_fprintf(f, "XMM%02d=%08x%08x%08x%08x",
+                        i,
+                        env->xmm_regs[i].ZMM_L(3),
+                        env->xmm_regs[i].ZMM_L(2),
+                        env->xmm_regs[i].ZMM_L(1),
+                        env->xmm_regs[i].ZMM_L(0));
+            if ((i & 1) == 1)
+                cpu_fprintf(f, "\n");
+            else
+                cpu_fprintf(f, " ");
+        }
+    }
+    if (flags & CPU_DUMP_CODE) {
+        target_ulong base = env->segs[R_CS].base + env->eip;
+        target_ulong offs = MIN(env->eip, DUMP_CODE_BYTES_BACKWARD);
+        uint8_t code;
+        char codestr[3];
+
+        cpu_fprintf(f, "Code=");
+        for (i = 0; i < DUMP_CODE_BYTES_TOTAL; i++) {
+            if (cpu_memory_rw_debug(cs, base - offs + i, &code, 1, 0) == 0) {
+                snprintf(codestr, sizeof(codestr), "%02x", code);
+            } else {
+                snprintf(codestr, sizeof(codestr), "??");
+            }
+            cpu_fprintf(f, "%s%s%s%s", i > 0 ? " " : "",
+                        i == offs ? "<" : "", codestr, i == offs ? ">" : "");
+        }
+        cpu_fprintf(f, "\n");
+    }
+}
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index d606eb53f4..652cbef425 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -686,91 +686,6 @@ void sparc_cpu_list(FILE *f, fprintf_function cpu_fprintf)
                    "fpu_version mmu_version nwindows\n");
 }
 
-static void cpu_print_cc(FILE *f, fprintf_function cpu_fprintf,
-                         uint32_t cc)
-{
-    cpu_fprintf(f, "%c%c%c%c", cc & PSR_NEG ? 'N' : '-',
-                cc & PSR_ZERO ? 'Z' : '-', cc & PSR_OVF ? 'V' : '-',
-                cc & PSR_CARRY ? 'C' : '-');
-}
-
-#ifdef TARGET_SPARC64
-#define REGS_PER_LINE 4
-#else
-#define REGS_PER_LINE 8
-#endif
-
-void sparc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                          int flags)
-{
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
-    int i, x;
-
-    cpu_fprintf(f, "pc: " TARGET_FMT_lx "  npc: " TARGET_FMT_lx "\n", env->pc,
-                env->npc);
-
-    for (i = 0; i < 8; i++) {
-        if (i % REGS_PER_LINE == 0) {
-            cpu_fprintf(f, "%%g%d-%d:", i, i + REGS_PER_LINE - 1);
-        }
-        cpu_fprintf(f, " " TARGET_FMT_lx, env->gregs[i]);
-        if (i % REGS_PER_LINE == REGS_PER_LINE - 1) {
-            cpu_fprintf(f, "\n");
-        }
-    }
-    for (x = 0; x < 3; x++) {
-        for (i = 0; i < 8; i++) {
-            if (i % REGS_PER_LINE == 0) {
-                cpu_fprintf(f, "%%%c%d-%d: ",
-                            x == 0 ? 'o' : (x == 1 ? 'l' : 'i'),
-                            i, i + REGS_PER_LINE - 1);
-            }
-            cpu_fprintf(f, TARGET_FMT_lx " ", env->regwptr[i + x * 8]);
-            if (i % REGS_PER_LINE == REGS_PER_LINE - 1) {
-                cpu_fprintf(f, "\n");
-            }
-        }
-    }
-
-    for (i = 0; i < TARGET_DPREGS; i++) {
-        if ((i & 3) == 0) {
-            cpu_fprintf(f, "%%f%02d: ", i * 2);
-        }
-        cpu_fprintf(f, " %016" PRIx64, env->fpr[i].ll);
-        if ((i & 3) == 3) {
-            cpu_fprintf(f, "\n");
-        }
-    }
-#ifdef TARGET_SPARC64
-    cpu_fprintf(f, "pstate: %08x ccr: %02x (icc: ", env->pstate,
-                (unsigned)cpu_get_ccr(env));
-    cpu_print_cc(f, cpu_fprintf, cpu_get_ccr(env) << PSR_CARRY_SHIFT);
-    cpu_fprintf(f, " xcc: ");
-    cpu_print_cc(f, cpu_fprintf, cpu_get_ccr(env) << (PSR_CARRY_SHIFT - 4));
-    cpu_fprintf(f, ") asi: %02x tl: %d pil: %x gl: %d\n", env->asi, env->tl,
-                env->psrpil, env->gl);
-    cpu_fprintf(f, "tbr: " TARGET_FMT_lx " hpstate: " TARGET_FMT_lx " htba: "
-                TARGET_FMT_lx "\n", env->tbr, env->hpstate, env->htba);
-    cpu_fprintf(f, "cansave: %d canrestore: %d otherwin: %d wstate: %d "
-                "cleanwin: %d cwp: %d\n",
-                env->cansave, env->canrestore, env->otherwin, env->wstate,
-                env->cleanwin, env->nwindows - 1 - env->cwp);
-    cpu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx " fprs: "
-                TARGET_FMT_lx "\n", env->fsr, env->y, env->fprs);
-
-#else
-    cpu_fprintf(f, "psr: %08x (icc: ", cpu_get_psr(env));
-    cpu_print_cc(f, cpu_fprintf, cpu_get_psr(env));
-    cpu_fprintf(f, " SPE: %c%c%c) wim: %08x\n", env->psrs ? 'S' : '-',
-                env->psrps ? 'P' : '-', env->psret ? 'E' : '-',
-                env->wim);
-    cpu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx "\n",
-                env->fsr, env->y);
-#endif
-    cpu_fprintf(f, "\n");
-}
-
 static void sparc_cpu_set_pc(CPUState *cs, vaddr value)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 655060cd9a..248ff9018d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5964,3 +5964,88 @@ void restore_state_to_opc(CPUSPARCState *env, TranslationBlock *tb,
         env->npc = npc;
     }
 }
+
+static void cpu_print_cc(FILE *f, fprintf_function cpu_fprintf,
+                         uint32_t cc)
+{
+    cpu_fprintf(f, "%c%c%c%c", cc & PSR_NEG ? 'N' : '-',
+                cc & PSR_ZERO ? 'Z' : '-', cc & PSR_OVF ? 'V' : '-',
+                cc & PSR_CARRY ? 'C' : '-');
+}
+
+#ifdef TARGET_SPARC64
+#define REGS_PER_LINE 4
+#else
+#define REGS_PER_LINE 8
+#endif
+
+void sparc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
+                          int flags)
+{
+    SPARCCPU *cpu = SPARC_CPU(cs);
+    CPUSPARCState *env = &cpu->env;
+    int i, x;
+
+    cpu_fprintf(f, "pc: " TARGET_FMT_lx "  npc: " TARGET_FMT_lx "\n", env->pc,
+                env->npc);
+
+    for (i = 0; i < 8; i++) {
+        if (i % REGS_PER_LINE == 0) {
+            cpu_fprintf(f, "%%g%d-%d:", i, i + REGS_PER_LINE - 1);
+        }
+        cpu_fprintf(f, " " TARGET_FMT_lx, env->gregs[i]);
+        if (i % REGS_PER_LINE == REGS_PER_LINE - 1) {
+            cpu_fprintf(f, "\n");
+        }
+    }
+    for (x = 0; x < 3; x++) {
+        for (i = 0; i < 8; i++) {
+            if (i % REGS_PER_LINE == 0) {
+                cpu_fprintf(f, "%%%c%d-%d: ",
+                            x == 0 ? 'o' : (x == 1 ? 'l' : 'i'),
+                            i, i + REGS_PER_LINE - 1);
+            }
+            cpu_fprintf(f, TARGET_FMT_lx " ", env->regwptr[i + x * 8]);
+            if (i % REGS_PER_LINE == REGS_PER_LINE - 1) {
+                cpu_fprintf(f, "\n");
+            }
+        }
+    }
+
+    for (i = 0; i < TARGET_DPREGS; i++) {
+        if ((i & 3) == 0) {
+            cpu_fprintf(f, "%%f%02d: ", i * 2);
+        }
+        cpu_fprintf(f, " %016" PRIx64, env->fpr[i].ll);
+        if ((i & 3) == 3) {
+            cpu_fprintf(f, "\n");
+        }
+    }
+#ifdef TARGET_SPARC64
+    cpu_fprintf(f, "pstate: %08x ccr: %02x (icc: ", env->pstate,
+                (unsigned)cpu_get_ccr(env));
+    cpu_print_cc(f, cpu_fprintf, cpu_get_ccr(env) << PSR_CARRY_SHIFT);
+    cpu_fprintf(f, " xcc: ");
+    cpu_print_cc(f, cpu_fprintf, cpu_get_ccr(env) << (PSR_CARRY_SHIFT - 4));
+    cpu_fprintf(f, ") asi: %02x tl: %d pil: %x gl: %d\n", env->asi, env->tl,
+                env->psrpil, env->gl);
+    cpu_fprintf(f, "tbr: " TARGET_FMT_lx " hpstate: " TARGET_FMT_lx " htba: "
+                TARGET_FMT_lx "\n", env->tbr, env->hpstate, env->htba);
+    cpu_fprintf(f, "cansave: %d canrestore: %d otherwin: %d wstate: %d "
+                "cleanwin: %d cwp: %d\n",
+                env->cansave, env->canrestore, env->otherwin, env->wstate,
+                env->cleanwin, env->nwindows - 1 - env->cwp);
+    cpu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx " fprs: "
+                TARGET_FMT_lx "\n", env->fsr, env->y, env->fprs);
+
+#else
+    cpu_fprintf(f, "psr: %08x (icc: ", cpu_get_psr(env));
+    cpu_print_cc(f, cpu_fprintf, cpu_get_psr(env));
+    cpu_fprintf(f, " SPE: %c%c%c) wim: %08x\n", env->psrs ? 'S' : '-',
+                env->psrps ? 'P' : '-', env->psret ? 'E' : '-',
+                env->wim);
+    cpu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx "\n",
+                env->fsr, env->y);
+#endif
+    cpu_fprintf(f, "\n");
+}
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index d90e38e88c..b79868e1e4 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -27,32 +27,6 @@
 #include "linux-user/syscall_defs.h"
 #include "exec/exec-all.h"
 
-static void tilegx_cpu_dump_state(CPUState *cs, FILE *f,
-                                  fprintf_function cpu_fprintf, int flags)
-{
-    static const char * const reg_names[TILEGX_R_COUNT] = {
-         "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
-         "r8",  "r9", "r10", "r11", "r12", "r13", "r14", "r15",
-        "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
-        "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
-        "r32", "r33", "r34", "r35", "r36", "r37", "r38", "r39",
-        "r40", "r41", "r42", "r43", "r44", "r45", "r46", "r47",
-        "r48", "r49", "r50", "r51",  "bp",  "tp",  "sp",  "lr"
-    };
-
-    TileGXCPU *cpu = TILEGX_CPU(cs);
-    CPUTLGState *env = &cpu->env;
-    int i;
-
-    for (i = 0; i < TILEGX_R_COUNT; i++) {
-        cpu_fprintf(f, "%-4s" TARGET_FMT_lx "%s",
-                    reg_names[i], env->regs[i],
-                    (i % 4) == 3 ? "\n" : " ");
-    }
-    cpu_fprintf(f, "PC  " TARGET_FMT_lx " CEX " TARGET_FMT_lx "\n\n",
-                env->pc, env->spregs[TILEGX_SPR_CMPEXCH]);
-}
-
 TileGXCPU *cpu_tilegx_init(const char *cpu_model)
 {
     TileGXCPU *cpu;
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index f32be49f65..aa40bbd6bb 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -178,4 +178,7 @@ static inline void cpu_get_tb_cpu_state(CPUTLGState *env, target_ulong *pc,
     *flags = 0;
 }
 
+void tilegx_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
+                           int flags);
+
 #endif
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index ff2ef7b63d..a170b744f4 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2455,3 +2455,29 @@ void tilegx_tcg_init(void)
                                              reg_names[i]);
     }
 }
+
+void tilegx_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
+                           int flags)
+{
+    static const char * const reg_names[TILEGX_R_COUNT] = {
+         "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
+         "r8",  "r9", "r10", "r11", "r12", "r13", "r14", "r15",
+        "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
+        "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
+        "r32", "r33", "r34", "r35", "r36", "r37", "r38", "r39",
+        "r40", "r41", "r42", "r43", "r44", "r45", "r46", "r47",
+        "r48", "r49", "r50", "r51",  "bp",  "tp",  "sp",  "lr"
+    };
+
+    TileGXCPU *cpu = TILEGX_CPU(cs);
+    CPUTLGState *env = &cpu->env;
+    int i;
+
+    for (i = 0; i < TILEGX_R_COUNT; i++) {
+        cpu_fprintf(f, "%-4s" TARGET_FMT_lx "%s",
+                    reg_names[i], env->regs[i],
+                    (i % 4) == 3 ? "\n" : " ");
+    }
+    cpu_fprintf(f, "PC  " TARGET_FMT_lx " CEX " TARGET_FMT_lx "\n\n",
+                env->pc, env->spregs[TILEGX_SPR_CMPEXCH]);
+}
-- 
2.11.1
