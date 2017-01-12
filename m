Received: from eggs.gnu.org ([2001:4830:134:3::10]:55561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZ5-00089x-3e
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZ4-0006oL-AL
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:35 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVZ4-0006oE-66
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:34 -0500
Received: by mail-qk0-x241.google.com with SMTP id u25so944113qki.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:34 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:52 -0800
Message-Id: <20170112025606.27332-17-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
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
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <343d22b67790a08cd37bd66bfddeb1cad351ef43.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/ldst_helper.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 387732d..301616b 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -293,6 +293,20 @@ static inline target_ulong asi_address_mask(CPUSPARCState *env,
     }
     return addr;
 }
+
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
 #endif
 
 static void do_check_align(CPUSPARCState *env, target_ulong addr,
@@ -1118,13 +1132,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
 
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
 
@@ -1423,13 +1431,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
 
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
2.9.3
