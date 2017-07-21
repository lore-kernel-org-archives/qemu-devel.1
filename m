Received: from eggs.gnu.org ([2001:4830:134:3::10]:40183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYZBy-0005kU-IY
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYZBw-0002HP-R9
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:46:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dYZBw-0002H3-Hd
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:46:08 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 21 Jul 2017 16:45:55 +0200
Message-Id: <1500648359-25931-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1500648359-25931-1-git-send-email-thuth@redhat.com>
References: <1500648359-25931-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/5] target/s390x: Move
 s390_cpu_dump_state() to helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Cc: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

translate.c can not be compiled with --disable-tcg, but we need
the s390_cpu_dump_state() in KVM-only builds, too. So let's move
that function to helper.c instead, which will also be compiled
when --disable-tcg has been specified.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/helper.c    | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c | 60 ------------------------------------------------
 2 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index aef09e1..30ac2a7 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -766,3 +766,63 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
 }
 #endif /* CONFIG_USER_ONLY */
+
+void s390_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
+                         int flags)
+{
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+    int i;
+
+    if (env->cc_op > 3) {
+        cpu_fprintf(f, "PSW=mask %016" PRIx64 " addr %016" PRIx64 " cc %15s\n",
+                    env->psw.mask, env->psw.addr, cc_name(env->cc_op));
+    } else {
+        cpu_fprintf(f, "PSW=mask %016" PRIx64 " addr %016" PRIx64 " cc %02x\n",
+                    env->psw.mask, env->psw.addr, env->cc_op);
+    }
+
+    for (i = 0; i < 16; i++) {
+        cpu_fprintf(f, "R%02d=%016" PRIx64, i, env->regs[i]);
+        if ((i % 4) == 3) {
+            cpu_fprintf(f, "\n");
+        } else {
+            cpu_fprintf(f, " ");
+        }
+    }
+
+    for (i = 0; i < 16; i++) {
+        cpu_fprintf(f, "F%02d=%016" PRIx64, i, get_freg(env, i)->ll);
+        if ((i % 4) == 3) {
+            cpu_fprintf(f, "\n");
+        } else {
+            cpu_fprintf(f, " ");
+        }
+    }
+
+    for (i = 0; i < 32; i++) {
+        cpu_fprintf(f, "V%02d=%016" PRIx64 "%016" PRIx64, i,
+                    env->vregs[i][0].ll, env->vregs[i][1].ll);
+        cpu_fprintf(f, (i % 2) ? "\n" : " ");
+    }
+
+#ifndef CONFIG_USER_ONLY
+    for (i = 0; i < 16; i++) {
+        cpu_fprintf(f, "C%02d=%016" PRIx64, i, env->cregs[i]);
+        if ((i % 4) == 3) {
+            cpu_fprintf(f, "\n");
+        } else {
+            cpu_fprintf(f, " ");
+        }
+    }
+#endif
+
+#ifdef DEBUG_INLINE_BRANCHES
+    for (i = 0; i < CC_OP_MAX; i++) {
+        cpu_fprintf(f, "  %15s = %10ld\t%10ld\n", cc_name(i),
+                    inline_branch_miss[i], inline_branch_hit[i]);
+    }
+#endif
+
+    cpu_fprintf(f, "\n");
+}
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 48b71f9..cd96a8d 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -93,66 +93,6 @@ static uint64_t pc_to_link_info(DisasContext *s, uint64_t pc)
     return pc;
 }
 
-void s390_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                         int flags)
-{
-    S390CPU *cpu = S390_CPU(cs);
-    CPUS390XState *env = &cpu->env;
-    int i;
-
-    if (env->cc_op > 3) {
-        cpu_fprintf(f, "PSW=mask %016" PRIx64 " addr %016" PRIx64 " cc %15s\n",
-                    env->psw.mask, env->psw.addr, cc_name(env->cc_op));
-    } else {
-        cpu_fprintf(f, "PSW=mask %016" PRIx64 " addr %016" PRIx64 " cc %02x\n",
-                    env->psw.mask, env->psw.addr, env->cc_op);
-    }
-
-    for (i = 0; i < 16; i++) {
-        cpu_fprintf(f, "R%02d=%016" PRIx64, i, env->regs[i]);
-        if ((i % 4) == 3) {
-            cpu_fprintf(f, "\n");
-        } else {
-            cpu_fprintf(f, " ");
-        }
-    }
-
-    for (i = 0; i < 16; i++) {
-        cpu_fprintf(f, "F%02d=%016" PRIx64, i, get_freg(env, i)->ll);
-        if ((i % 4) == 3) {
-            cpu_fprintf(f, "\n");
-        } else {
-            cpu_fprintf(f, " ");
-        }
-    }
-
-    for (i = 0; i < 32; i++) {
-        cpu_fprintf(f, "V%02d=%016" PRIx64 "%016" PRIx64, i,
-                    env->vregs[i][0].ll, env->vregs[i][1].ll);
-        cpu_fprintf(f, (i % 2) ? "\n" : " ");
-    }
-
-#ifndef CONFIG_USER_ONLY
-    for (i = 0; i < 16; i++) {
-        cpu_fprintf(f, "C%02d=%016" PRIx64, i, env->cregs[i]);
-        if ((i % 4) == 3) {
-            cpu_fprintf(f, "\n");
-        } else {
-            cpu_fprintf(f, " ");
-        }
-    }
-#endif
-
-#ifdef DEBUG_INLINE_BRANCHES
-    for (i = 0; i < CC_OP_MAX; i++) {
-        cpu_fprintf(f, "  %15s = %10ld\t%10ld\n", cc_name(i),
-                    inline_branch_miss[i], inline_branch_hit[i]);
-    }
-#endif
-
-    cpu_fprintf(f, "\n");
-}
-
 static TCGv_i64 psw_addr;
 static TCGv_i64 psw_mask;
 static TCGv_i64 gbea;
-- 
1.8.3.1
