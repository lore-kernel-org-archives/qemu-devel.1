Received: from eggs.gnu.org ([2001:4830:134:3::10]:55274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwd-0005fw-EV
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwa-0001Le-BP
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:19 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwa-0001KG-17
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:16 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:04:54 +0200
Message-Id: <20170525210508.4910-13-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 12/26] target/s390x: improve 24-bit and 31-bit
 addresses read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Improve fix_address to also handle the 24-bit mode. Rename fix_address
to wrap_address to better explain what is changed.

For the same reason, rename get_address into get_address_rel and
get_address_31fix into get_address_rel.

Finally replace many calls to get_address_rel with x2 = 0 and b2 = 0 by
call to wrap_address.

Note that get_address_relget_address_rel is only used in the EXECUTE
helper, so we can get rid of it as the same time as the helper.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/mem_helper.c | 90 +++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 43 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index bc9fd50b24..2b0cde13b4 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -366,16 +366,22 @@ uint32_t HELPER(clm)(CPUS390XState *env, uint32_t r1, uint32_t mask,
     return cc;
 }
 
-static inline uint64_t fix_address(CPUS390XState *env, uint64_t a)
+static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
 {
-    /* 31-Bit mode */
     if (!(env->psw.mask & PSW_MASK_64)) {
-        a &= 0x7fffffff;
+        if (!(env->psw.mask & PSW_MASK_32)) {
+            /* 24-Bit mode */
+            a &= 0x00ffffff;
+        } else {
+            /* 31-Bit mode */
+            a &= 0x7fffffff;
+        }
     }
     return a;
 }
 
-static inline uint64_t get_address(CPUS390XState *env, int x2, int b2, int d2)
+static inline uint64_t get_address_rel(CPUS390XState *env,
+                                       int x2, int b2, int d2)
 {
     uint64_t r = d2;
     if (x2) {
@@ -384,12 +390,12 @@ static inline uint64_t get_address(CPUS390XState *env, int x2, int b2, int d2)
     if (b2) {
         r += env->regs[b2];
     }
-    return fix_address(env, r);
+    return wrap_address(env, r);
 }
 
-static inline uint64_t get_address_31fix(CPUS390XState *env, int reg)
+static inline uint64_t get_address(CPUS390XState *env, int reg)
 {
-    return fix_address(env, env->regs[reg]);
+    return wrap_address(env, env->regs[reg]);
 }
 
 /* search string (c is byte to search, r2 is string, r1 end of string) */
@@ -400,8 +406,8 @@ uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
     uint32_t len;
     uint8_t v, c = r0;
 
-    str = fix_address(env, str);
-    end = fix_address(env, end);
+    str = wrap_address(env, str);
+    end = wrap_address(env, end);
 
     /* Assume for now that R2 is unmodified.  */
     env->retxl = str;
@@ -435,8 +441,8 @@ uint64_t HELPER(clst)(CPUS390XState *env, uint64_t c, uint64_t s1, uint64_t s2)
     uint32_t len;
 
     c = c & 0xff;
-    s1 = fix_address(env, s1);
-    s2 = fix_address(env, s2);
+    s1 = wrap_address(env, s1);
+    s2 = wrap_address(env, s2);
 
     /* Lest we fail to service interrupts in a timely manner, limit the
        amount of work we're willing to do.  For now, let's cap at 8k.  */
@@ -482,8 +488,8 @@ uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t c, uint64_t d, uint64_t s)
     uint32_t len;
 
     c = c & 0xff;
-    d = fix_address(env, d);
-    s = fix_address(env, s);
+    d = wrap_address(env, d);
+    s = wrap_address(env, s);
 
     /* Lest we fail to service interrupts in a timely manner, limit the
        amount of work we're willing to do.  For now, let's cap at 8k.  */
@@ -572,9 +578,9 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
     uintptr_t ra = GETPC();
     uint64_t destlen = env->regs[r1 + 1] & 0xffffff;
-    uint64_t dest = get_address_31fix(env, r1);
+    uint64_t dest = get_address(env, r1);
     uint64_t srclen = env->regs[r2 + 1] & 0xffffff;
-    uint64_t src = get_address_31fix(env, r2);
+    uint64_t src = get_address(env, r2);
     uint8_t pad = env->regs[r2 + 1] >> 24;
     uint8_t v;
     uint32_t cc;
@@ -615,9 +621,9 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
 {
     uintptr_t ra = GETPC();
     uint64_t destlen = env->regs[r1 + 1];
-    uint64_t dest = env->regs[r1];
+    uint64_t dest = get_address(env, r1);
     uint64_t srclen = env->regs[r3 + 1];
-    uint64_t src = env->regs[r3];
+    uint64_t src = get_address(env, r3);
     uint8_t pad = a2 & 0xff;
     uint8_t v;
     uint32_t cc;
@@ -625,8 +631,6 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
     if (!(env->psw.mask & PSW_MASK_64)) {
         destlen = (uint32_t)destlen;
         srclen = (uint32_t)srclen;
-        dest &= 0x7fffffff;
-        src &= 0x7fffffff;
     }
 
     if (destlen == srclen) {
@@ -666,9 +670,9 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
 {
     uintptr_t ra = GETPC();
     uint64_t destlen = env->regs[r1 + 1];
-    uint64_t dest = get_address_31fix(env, r1);
+    uint64_t dest = get_address(env, r1);
     uint64_t srclen = env->regs[r3 + 1];
-    uint64_t src = get_address_31fix(env, r3);
+    uint64_t src = get_address(env, r3);
     uint8_t pad = a2 & 0xff;
     uint32_t cc = 0;
 
@@ -1050,7 +1054,7 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
     uint64_t abs_addr;
     int i;
 
-    real_addr = fix_address(env, real_addr);
+    real_addr = wrap_address(env, real_addr);
     abs_addr = mmu_real2abs(env, real_addr) & TARGET_PAGE_MASK;
     if (!address_space_access_valid(&address_space_memory, abs_addr,
                                     TARGET_PAGE_SIZE, true)) {
@@ -1084,7 +1088,7 @@ uint64_t HELPER(iske)(CPUS390XState *env, uint64_t r2)
 {
     static S390SKeysState *ss;
     static S390SKeysClass *skeyclass;
-    uint64_t addr = get_address(env, 0, 0, r2);
+    uint64_t addr = wrap_address(env, r2);
     uint8_t key;
 
     if (addr > ram_size) {
@@ -1107,7 +1111,7 @@ void HELPER(sske)(CPUS390XState *env, uint64_t r1, uint64_t r2)
 {
     static S390SKeysState *ss;
     static S390SKeysClass *skeyclass;
-    uint64_t addr = get_address(env, 0, 0, r2);
+    uint64_t addr = wrap_address(env, r2);
     uint8_t key;
 
     if (addr > ram_size) {
@@ -1254,14 +1258,14 @@ uint64_t HELPER(lura)(CPUS390XState *env, uint64_t addr)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
 
-    return (uint32_t)ldl_phys(cs->as, get_address(env, 0, 0, addr));
+    return (uint32_t)ldl_phys(cs->as, wrap_address(env, addr));
 }
 
 uint64_t HELPER(lurag)(CPUS390XState *env, uint64_t addr)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
 
-    return ldq_phys(cs->as, get_address(env, 0, 0, addr));
+    return ldq_phys(cs->as, wrap_address(env, addr));
 }
 
 /* store using real address */
@@ -1269,7 +1273,7 @@ void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
 
-    stl_phys(cs->as, get_address(env, 0, 0, addr), (uint32_t)v1);
+    stl_phys(cs->as, wrap_address(env, addr), (uint32_t)v1);
 
     if ((env->psw.mask & PSW_MASK_PER) &&
         (env->cregs[9] & PER_CR9_EVENT_STORE) &&
@@ -1284,7 +1288,7 @@ void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
 
-    stq_phys(cs->as, get_address(env, 0, 0, addr), v1);
+    stq_phys(cs->as, wrap_address(env, addr), v1);
 
     if ((env->psw.mask & PSW_MASK_PER) &&
         (env->cregs[9] & PER_CR9_EVENT_STORE) &&
@@ -1369,32 +1373,32 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
         d2 = extract64(insn, 16, 12);
         switch (opc & 0xf) {
         case 0x2:
-            do_helper_mvc(env, l, get_address(env, 0, b1, d1),
-                          get_address(env, 0, b2, d2), 0);
+            do_helper_mvc(env, l, get_address_rel(env, 0, b1, d1),
+                          get_address_rel(env, 0, b2, d2), 0);
             return;
         case 0x4:
-            env->cc_op = do_helper_nc(env, l, get_address(env, 0, b1, d1),
-                                      get_address(env, 0, b2, d2), 0);
+            env->cc_op = do_helper_nc(env, l, get_address_rel(env, 0, b1, d1),
+                                      get_address_rel(env, 0, b2, d2), 0);
             return;
         case 0x5:
-            env->cc_op = do_helper_clc(env, l, get_address(env, 0, b1, d1),
-                                       get_address(env, 0, b2, d2), 0);
+            env->cc_op = do_helper_clc(env, l, get_address_rel(env, 0, b1, d1),
+                                       get_address_rel(env, 0, b2, d2), 0);
             return;
         case 0x6:
-            env->cc_op = do_helper_oc(env, l, get_address(env, 0, b1, d1),
-                                      get_address(env, 0, b2, d2), 0);
+            env->cc_op = do_helper_oc(env, l, get_address_rel(env, 0, b1, d1),
+                                      get_address_rel(env, 0, b2, d2), 0);
             return;
         case 0x7:
-            env->cc_op = do_helper_xc(env, l, get_address(env, 0, b1, d1),
-                                      get_address(env, 0, b2, d2), 0);
+            env->cc_op = do_helper_xc(env, l, get_address_rel(env, 0, b1, d1),
+                                      get_address_rel(env, 0, b2, d2), 0);
             return;
         case 0xc:
-            do_helper_tr(env, l, get_address(env, 0, b1, d1),
-                         get_address(env, 0, b2, d2), 0);
+            do_helper_tr(env, l, get_address_rel(env, 0, b1, d1),
+                         get_address_rel(env, 0, b2, d2), 0);
             return;
         case 0xd:
-            env->cc_op = do_helper_trt(env, l, get_address(env, 0, b1, d1),
-                                       get_address(env, 0, b2, d2), 0);
+            env->cc_op = do_helper_trt(env, l, get_address_rel(env, 0, b1, d1),
+                                       get_address_rel(env, 0, b2, d2), 0);
             return;
         }
     } else if (opc == 0x0a) {
@@ -1410,7 +1414,7 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
         r3 = extract64(insn, 48, 4);
         b2 = extract64(insn, 44, 4);
         d2 = extract64(insn, 32, 12);
-        env->cc_op = helper_icm(env, r1, get_address(env, 0, b2, d2), r3);
+        env->cc_op = helper_icm(env, r1, get_address_rel(env, 0, b2, d2), r3);
         return;
     }
 
-- 
2.11.0
