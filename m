Received: from eggs.gnu.org ([2001:4830:134:3::10]:32805)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<3jaRvWwYKCnYUiUnYmaiiafY.WigkYgo-XYpYfhihaho.ila@flex--aoates.bounces.google.com>)
	id 1fogjZ-0004iB-DM
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 23:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<3jaRvWwYKCnYUiUnYmaiiafY.WigkYgo-XYpYfhihaho.ila@flex--aoates.bounces.google.com>)
	id 1fogjX-0002hr-TL
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 23:08:01 -0400
Received: from mail-ua1-x94a.google.com ([2607:f8b0:4864:20::94a]:56020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<3jaRvWwYKCnYUiUnYmaiiafY.WigkYgo-XYpYfhihaho.ila@flex--aoates.bounces.google.com>)
	id 1fogjX-0002h5-Mr
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 23:07:59 -0400
Received: by mail-ua1-x94a.google.com with SMTP id h11-v6so4601099uao.22
	for <qemu-devel@nongnu.org>; Sat, 11 Aug 2018 20:07:58 -0700 (PDT)
Date: Sat, 11 Aug 2018 23:07:40 -0400
Message-Id: <20180812030740.99170-1-aoates@google.com>
Mime-Version: 1.0
From: Andrew Oates <aoates@google.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] target-i386: Fix lcall to call gate in IA-32e
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org
Cc: Andrew Oates <aoates@google.com>

Currently call gates are always treated as 32-bit gates.  In IA-32e mode
(either compatibility or 64-bit submode), system segment descriptors are
always 64-bit.  Treating them as 32-bit has the expected unfortunate
effect: only the lower 32 bits of the offset are loaded, the stack
pointer is truncated, a bad new stack pointer is loaded from the TSS (if
switching privilege levels), etc.

This change adds support for 64-bit call gate to the lcall instruction.
Additionally, there should be a check for non-canonical stack pointers,
but I've omitted that since there doesn't seem to be checks for
non-canonical addresses in this code elsewhere.

I've left the raise_exception_err_ra lines unwapped at 80 columns to
match the style in the rest of the file.

Signed-off-by: Andrew Oates <aoates@google.com>
---
 target/i386/seg_helper.c | 145 ++++++++++++++++++++++++++++-----------
 1 file changed, 106 insertions(+), 39 deletions(-)

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 00301a0c04..d3b31f3c1b 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -518,6 +518,11 @@ static void switch_tss(CPUX86State *env, int tss_selector,
 
 static inline unsigned int get_sp_mask(unsigned int e2)
 {
+#ifdef TARGET_X86_64
+    if (e2 & DESC_L_MASK) {
+        return 0;
+    } else
+#endif
     if (e2 & DESC_B_MASK) {
         return 0xffffffff;
     } else {
@@ -1724,12 +1729,12 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
                             int shift, target_ulong next_eip)
 {
     int new_stack, i;
-    uint32_t e1, e2, cpl, dpl, rpl, selector, offset, param_count;
-    uint32_t ss = 0, ss_e1 = 0, ss_e2 = 0, sp, type, ss_dpl, sp_mask;
+    uint32_t e1, e2, cpl, dpl, rpl, selector, param_count;
+    uint32_t ss = 0, ss_e1 = 0, ss_e2 = 0, type, ss_dpl, sp_mask;
     uint32_t val, limit, old_sp_mask;
-    target_ulong ssp, old_ssp;
+    target_ulong ssp, old_ssp, offset, sp;
 
-    LOG_PCALL("lcall %04x:%08x s=%d\n", new_cs, (uint32_t)new_eip, shift);
+    LOG_PCALL("lcall %04x:" TARGET_FMT_lx " s=%d\n", new_cs, new_eip, shift);
     LOG_PCALL_STATE(CPU(x86_env_get_cpu(env)));
     if ((new_cs & 0xfffc) == 0) {
         raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
@@ -1833,8 +1838,23 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
             raise_exception_err_ra(env, EXCP0B_NOSEG,  new_cs & 0xfffc, GETPC());
         }
         selector = e1 >> 16;
-        offset = (e2 & 0xffff0000) | (e1 & 0x0000ffff);
         param_count = e2 & 0x1f;
+        offset = (e2 & 0xffff0000) | (e1 & 0x0000ffff);
+#ifdef TARGET_X86_64
+        if (env->efer & MSR_EFER_LMA) {
+            /* load the upper 8 bytes of the 64-bit call gate */
+            if (load_segment_ra(env, &e1, &e2, new_cs + 8, GETPC())) {
+                raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc,
+                                       GETPC());
+            }
+            type = (e2 >> DESC_TYPE_SHIFT) & 0x1f;
+            if (type != 0) {
+                raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc,
+                                       GETPC());
+            }
+            offset |= ((target_ulong)e1) << 32;
+        }
+#endif
         if ((selector & 0xfffc) == 0) {
             raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
         }
@@ -1849,46 +1869,80 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
         if (dpl > cpl) {
             raise_exception_err_ra(env, EXCP0D_GPF, selector & 0xfffc, GETPC());
         }
+#ifdef TARGET_X86_64
+        if (env->efer & MSR_EFER_LMA) {
+            if (!(e2 & DESC_L_MASK)) {
+                raise_exception_err_ra(env, EXCP0D_GPF, selector & 0xfffc, GETPC());
+            }
+            if (e2 & DESC_B_MASK) {
+                raise_exception_err_ra(env, EXCP0D_GPF, selector & 0xfffc, GETPC());
+            }
+            shift++;
+        }
+#endif
         if (!(e2 & DESC_P_MASK)) {
             raise_exception_err_ra(env, EXCP0B_NOSEG, selector & 0xfffc, GETPC());
         }
 
         if (!(e2 & DESC_C_MASK) && dpl < cpl) {
             /* to inner privilege */
-            get_ss_esp_from_tss(env, &ss, &sp, dpl, GETPC());
-            LOG_PCALL("new ss:esp=%04x:%08x param_count=%d env->regs[R_ESP]="
-                      TARGET_FMT_lx "\n", ss, sp, param_count,
-                      env->regs[R_ESP]);
-            if ((ss & 0xfffc) == 0) {
-                raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
-            }
-            if ((ss & 3) != dpl) {
-                raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
-            }
-            if (load_segment_ra(env, &ss_e1, &ss_e2, ss, GETPC()) != 0) {
-                raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
-            }
-            ss_dpl = (ss_e2 >> DESC_DPL_SHIFT) & 3;
-            if (ss_dpl != dpl) {
-                raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
-            }
-            if (!(ss_e2 & DESC_S_MASK) ||
-                (ss_e2 & DESC_CS_MASK) ||
-                !(ss_e2 & DESC_W_MASK)) {
-                raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
-            }
-            if (!(ss_e2 & DESC_P_MASK)) {
-                raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
+#ifdef TARGET_X86_64
+            if (shift == 2) {
+                sp = get_rsp_from_tss(env, dpl);
+                ss = dpl;  /* SS = NULL selector with RPL = new CPL */
+                new_stack = 1;
+                sp_mask = 0;
+                ssp = 0;  /* SS base is always zero in IA-32e mode */
+                LOG_PCALL("new ss:rsp=%04x:%016llx env->regs[R_ESP]="
+                          TARGET_FMT_lx "\n", ss, sp, env->regs[R_ESP]);
+            } else
+#endif
+            {
+                uint32_t sp32;
+                get_ss_esp_from_tss(env, &ss, &sp32, dpl, GETPC());
+                LOG_PCALL("new ss:esp=%04x:%08x param_count=%d env->regs[R_ESP]="
+                          TARGET_FMT_lx "\n", ss, sp32, param_count,
+                          env->regs[R_ESP]);
+                sp = sp32;
+                if ((ss & 0xfffc) == 0) {
+                    raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
+                }
+                if ((ss & 3) != dpl) {
+                    raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
+                }
+                if (load_segment_ra(env, &ss_e1, &ss_e2, ss, GETPC()) != 0) {
+                    raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
+                }
+                ss_dpl = (ss_e2 >> DESC_DPL_SHIFT) & 3;
+                if (ss_dpl != dpl) {
+                    raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
+                }
+                if (!(ss_e2 & DESC_S_MASK) ||
+                    (ss_e2 & DESC_CS_MASK) ||
+                    !(ss_e2 & DESC_W_MASK)) {
+                    raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
+                }
+                if (!(ss_e2 & DESC_P_MASK)) {
+                    raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
+                }
+
+                sp_mask = get_sp_mask(ss_e2);
+                ssp = get_seg_base(ss_e1, ss_e2);
             }
 
             /* push_size = ((param_count * 2) + 8) << shift; */
 
             old_sp_mask = get_sp_mask(env->segs[R_SS].flags);
             old_ssp = env->segs[R_SS].base;
-
-            sp_mask = get_sp_mask(ss_e2);
-            ssp = get_seg_base(ss_e1, ss_e2);
-            if (shift) {
+#ifdef TARGET_X86_64
+            if (shift == 2) {
+                /* XXX: verify if new stack address is canonical */
+                PUSHQ_RA(sp, env->segs[R_SS].selector, GETPC());
+                PUSHQ_RA(sp, env->regs[R_ESP], GETPC());
+                /* parameters aren't supported for 64-bit call gates */
+            } else
+#endif
+            if (shift == 1) {
                 PUSHL_RA(ssp, sp, sp_mask, env->segs[R_SS].selector, GETPC());
                 PUSHL_RA(ssp, sp, sp_mask, env->regs[R_ESP], GETPC());
                 for (i = param_count - 1; i >= 0; i--) {
@@ -1917,7 +1971,13 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
             new_stack = 0;
         }
 
-        if (shift) {
+#ifdef TARGET_X86_64
+        if (shift == 2) {
+            PUSHQ_RA(sp, env->segs[R_CS].selector, GETPC());
+            PUSHQ_RA(sp, next_eip, GETPC());
+        } else
+#endif
+        if (shift == 1) {
             PUSHL_RA(ssp, sp, sp_mask, env->segs[R_CS].selector, GETPC());
             PUSHL_RA(ssp, sp, sp_mask, next_eip, GETPC());
         } else {
@@ -1928,11 +1988,18 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
         /* from this point, not restartable */
 
         if (new_stack) {
-            ss = (ss & ~3) | dpl;
-            cpu_x86_load_seg_cache(env, R_SS, ss,
-                                   ssp,
-                                   get_seg_limit(ss_e1, ss_e2),
-                                   ss_e2);
+#ifdef TARGET_X86_64
+            if (shift == 2) {
+                cpu_x86_load_seg_cache(env, R_SS, ss, 0, 0, 0);
+            } else
+#endif
+            {
+                ss = (ss & ~3) | dpl;
+                cpu_x86_load_seg_cache(env, R_SS, ss,
+                                       ssp,
+                                       get_seg_limit(ss_e1, ss_e2),
+                                       ss_e2);
+            }
         }
 
         selector = (selector & ~3) | dpl;
-- 
2.17.0
