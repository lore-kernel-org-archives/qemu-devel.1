Received: from eggs.gnu.org ([2001:4830:134:3::10]:37010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytG-0006ex-5E
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytF-0002qL-CG
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:38 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTytF-0002pv-60
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:37 -0500
Received: by mail-wm0-x242.google.com with SMTP id r144so7568333wme.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:37 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:29 +0100
Message-Id: <1484779123-18968-17-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PULL 16/30] target-sparc: allow priveleged ASIs in
 hyperprivileged mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/ldst_helper.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2e6439a..ade4fb0 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -293,6 +293,22 @@ static inline target_ulong asi_address_mask(CPUSPARCState *env,
     }
     return addr;
 }
+
+#ifndef CONFIG_USER_ONLY
+static inline void do_check_asi(CPUSPARCState *env, int asi, uintptr_t ra)
+{
+    /* ASIs >= 0x80 are user mode.
+     * ASIs >= 0x30 are hyper mode (or super if hyper is not available).
+     * ASIs <= 0x2f are super mode.
+     */
+    if (asi < 0x80
+        && !cpu_hypervisor_mode(env)
+        && (!cpu_supervisor_mode(env)
+            || (asi >= 0x30 && cpu_has_hypervisor(env)))) {
+        cpu_raise_exception_ra(env, TT_PRIV_ACT, ra);
+    }
+}
+#endif /* !CONFIG_USER_ONLY */
 #endif
 
 static void do_check_align(CPUSPARCState *env, target_ulong addr,
@@ -1118,13 +1134,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
 
     asi &= 0xff;
 
-    if ((asi < 0x80 && (env->pstate & PS_PRIV) == 0)
-        || (cpu_has_hypervisor(env)
-            && asi >= 0x30 && asi < 0x80
-            && !(env->hpstate & HS_PRIV))) {
-        cpu_raise_exception_ra(env, TT_PRIV_ACT, GETPC());
-    }
-
+    do_check_asi(env, asi, GETPC());
     do_check_align(env, addr, size - 1, GETPC());
     addr = asi_address_mask(env, asi, addr);
 
@@ -1423,13 +1433,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
 
     asi &= 0xff;
 
-    if ((asi < 0x80 && (env->pstate & PS_PRIV) == 0)
-        || (cpu_has_hypervisor(env)
-            && asi >= 0x30 && asi < 0x80
-            && !(env->hpstate & HS_PRIV))) {
-        cpu_raise_exception_ra(env, TT_PRIV_ACT, GETPC());
-    }
-
+    do_check_asi(env, asi, GETPC());
     do_check_align(env, addr, size - 1, GETPC());
     addr = asi_address_mask(env, asi, addr);
 
-- 
2.7.2
