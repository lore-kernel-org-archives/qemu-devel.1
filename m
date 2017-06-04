Received: from eggs.gnu.org ([2001:4830:134:3::10]:49954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZQt-0007BQ-7J
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZQs-0002fV-0L
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:19 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZQr-0002eH-OO
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:17 -0400
Received: by mail-pg0-x244.google.com with SMTP id f127so7254645pgc.2
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:17 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:03 -0700
Message-Id: <20170604173509.29684-4-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 03/69] target/s390x: Move helper_ex to end of
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

This will avoid needing forward declarations in following patches.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 161 +++++++++++++++++++++++-----------------------
 1 file changed, 81 insertions(+), 80 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e3325a4..90b62fa 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -436,86 +436,6 @@ static uint32_t helper_icm(CPUS390XState *env, uint32_t r1, uint64_t address,
     return cc;
 }
 
-/* execute instruction
-   this instruction executes an insn modified with the contents of r1
-   it does not change the executed instruction in memory
-   it does not change the program counter
-   in other words: tricky...
-   currently implemented by interpreting the cases it is most commonly used in
-*/
-uint32_t HELPER(ex)(CPUS390XState *env, uint32_t cc, uint64_t v1,
-                    uint64_t addr, uint64_t ret)
-{
-    S390CPU *cpu = s390_env_get_cpu(env);
-    uint16_t insn = cpu_lduw_code(env, addr);
-
-    HELPER_LOG("%s: v1 0x%lx addr 0x%lx insn 0x%x\n", __func__, v1, addr,
-               insn);
-    if ((insn & 0xf0ff) == 0xd000) {
-        uint32_t l, insn2, b1, b2, d1, d2;
-
-        l = v1 & 0xff;
-        insn2 = cpu_ldl_code(env, addr + 2);
-        b1 = (insn2 >> 28) & 0xf;
-        b2 = (insn2 >> 12) & 0xf;
-        d1 = (insn2 >> 16) & 0xfff;
-        d2 = insn2 & 0xfff;
-        switch (insn & 0xf00) {
-        case 0x200:
-            helper_mvc(env, l, get_address(env, 0, b1, d1),
-                       get_address(env, 0, b2, d2));
-            break;
-        case 0x400:
-            cc = helper_nc(env, l, get_address(env, 0, b1, d1),
-                            get_address(env, 0, b2, d2));
-            break;
-        case 0x500:
-            cc = helper_clc(env, l, get_address(env, 0, b1, d1),
-                            get_address(env, 0, b2, d2));
-            break;
-        case 0x600:
-            cc = helper_oc(env, l, get_address(env, 0, b1, d1),
-                            get_address(env, 0, b2, d2));
-            break;
-        case 0x700:
-            cc = helper_xc(env, l, get_address(env, 0, b1, d1),
-                           get_address(env, 0, b2, d2));
-            break;
-        case 0xc00:
-            helper_tr(env, l, get_address(env, 0, b1, d1),
-                      get_address(env, 0, b2, d2));
-            break;
-        case 0xd00:
-            cc = helper_trt(env, l, get_address(env, 0, b1, d1),
-                            get_address(env, 0, b2, d2));
-            break;
-        default:
-            goto abort;
-        }
-    } else if ((insn & 0xff00) == 0x0a00) {
-        /* supervisor call */
-        HELPER_LOG("%s: svc %ld via execute\n", __func__, (insn | v1) & 0xff);
-        env->psw.addr = ret - 4;
-        env->int_svc_code = (insn | v1) & 0xff;
-        env->int_svc_ilen = 4;
-        helper_exception(env, EXCP_SVC);
-    } else if ((insn & 0xff00) == 0xbf00) {
-        uint32_t insn2, r1, r3, b2, d2;
-
-        insn2 = cpu_ldl_code(env, addr + 2);
-        r1 = (insn2 >> 20) & 0xf;
-        r3 = (insn2 >> 16) & 0xf;
-        b2 = (insn2 >> 12) & 0xf;
-        d2 = insn2 & 0xfff;
-        cc = helper_icm(env, r1, get_address(env, 0, b2, d2), r3);
-    } else {
-    abort:
-        cpu_abort(CPU(cpu), "EXECUTE on instruction prefix 0x%x not implemented\n",
-                  insn);
-    }
-    return cc;
-}
-
 /* load access registers r1 to r3 from memory at a2 */
 void HELPER(lam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
@@ -1262,3 +1182,84 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
     return ret;
 }
 #endif
+
+/* execute instruction
+   this instruction executes an insn modified with the contents of r1
+   it does not change the executed instruction in memory
+   it does not change the program counter
+   in other words: tricky...
+   currently implemented by interpreting the cases it is most commonly used.
+*/
+uint32_t HELPER(ex)(CPUS390XState *env, uint32_t cc, uint64_t v1,
+                    uint64_t addr, uint64_t ret)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+    uint16_t insn = cpu_lduw_code(env, addr);
+
+    HELPER_LOG("%s: v1 0x%lx addr 0x%lx insn 0x%x\n", __func__, v1, addr,
+               insn);
+    if ((insn & 0xf0ff) == 0xd000) {
+        uint32_t l, insn2, b1, b2, d1, d2;
+
+        l = v1 & 0xff;
+        insn2 = cpu_ldl_code(env, addr + 2);
+        b1 = (insn2 >> 28) & 0xf;
+        b2 = (insn2 >> 12) & 0xf;
+        d1 = (insn2 >> 16) & 0xfff;
+        d2 = insn2 & 0xfff;
+        switch (insn & 0xf00) {
+        case 0x200:
+            helper_mvc(env, l, get_address(env, 0, b1, d1),
+                       get_address(env, 0, b2, d2));
+            break;
+        case 0x400:
+            cc = helper_nc(env, l, get_address(env, 0, b1, d1),
+                            get_address(env, 0, b2, d2));
+            break;
+        case 0x500:
+            cc = helper_clc(env, l, get_address(env, 0, b1, d1),
+                            get_address(env, 0, b2, d2));
+            break;
+        case 0x600:
+            cc = helper_oc(env, l, get_address(env, 0, b1, d1),
+                            get_address(env, 0, b2, d2));
+            break;
+        case 0x700:
+            cc = helper_xc(env, l, get_address(env, 0, b1, d1),
+                           get_address(env, 0, b2, d2));
+            break;
+        case 0xc00:
+            helper_tr(env, l, get_address(env, 0, b1, d1),
+                      get_address(env, 0, b2, d2));
+            break;
+        case 0xd00:
+            cc = helper_trt(env, l, get_address(env, 0, b1, d1),
+                            get_address(env, 0, b2, d2));
+            break;
+        default:
+            goto abort;
+        }
+    } else if ((insn & 0xff00) == 0x0a00) {
+        /* supervisor call */
+        HELPER_LOG("%s: svc %ld via execute\n", __func__, (insn | v1) & 0xff);
+        env->psw.addr = ret - 4;
+        env->int_svc_code = (insn | v1) & 0xff;
+        env->int_svc_ilen = 4;
+        helper_exception(env, EXCP_SVC);
+    } else if ((insn & 0xff00) == 0xbf00) {
+        uint32_t insn2, r1, r3, b2, d2;
+
+        insn2 = cpu_ldl_code(env, addr + 2);
+        r1 = (insn2 >> 20) & 0xf;
+        r3 = (insn2 >> 16) & 0xf;
+        b2 = (insn2 >> 12) & 0xf;
+        d2 = insn2 & 0xfff;
+        cc = helper_icm(env, r1, get_address(env, 0, b2, d2), r3);
+    } else {
+    abort:
+        cpu_abort(CPU(cpu),
+                  "EXECUTE on instruction prefix 0x%x not implemented\n",
+                  insn);
+    }
+    return cc;
+}
-- 
2.9.4
