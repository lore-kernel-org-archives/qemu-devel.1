Received: from eggs.gnu.org ([2001:4830:134:3::10]:34329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtk-0003Qi-VY
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtj-0002EC-L6
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:32 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOtj-0002Dx-G5
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:31 -0400
Received: by mail-qt0-x241.google.com with SMTP id s33so19305068qtg.3
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:31 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:31:00 -0700
Message-Id: <20170607003119.14778-52-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 51/70] target/s390x: improve 24-bit and
 31-bit addresses read
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

From: Aurelien Jarno <aurelien@aurel32.net>

Improve fix_address to also handle the 24-bit mode. Rename fix_address
to wrap_address to better explain what is changed.

Replace the calls to get_address with x2 = 0 and b2 = 0 by
call to wrap_address, leading to the removal of this function. Rename
get_address_31fix into get_address.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170531220129.27724-15-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 71 +++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 40 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 10754dd..aba26be 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -365,30 +365,23 @@ uint32_t HELPER(clm)(CPUS390XState *env, uint32_t r1, uint32_t mask,
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
-{
-    uint64_t r = d2;
-    if (x2) {
-        r += env->regs[x2];
-    }
-    if (b2) {
-        r += env->regs[b2];
-    }
-    return fix_address(env, r);
-}
-
-static inline uint64_t get_address_31fix(CPUS390XState *env, int reg)
+static inline uint64_t get_address(CPUS390XState *env, int reg)
 {
-    return fix_address(env, env->regs[reg]);
+    return wrap_address(env, env->regs[reg]);
 }
 
 /* search string (c is byte to search, r2 is string, r1 end of string) */
@@ -399,8 +392,8 @@ uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
     uint32_t len;
     uint8_t v, c = r0;
 
-    str = fix_address(env, str);
-    end = fix_address(env, end);
+    str = wrap_address(env, str);
+    end = wrap_address(env, end);
 
     /* Assume for now that R2 is unmodified.  */
     env->retxl = str;
@@ -434,8 +427,8 @@ uint64_t HELPER(clst)(CPUS390XState *env, uint64_t c, uint64_t s1, uint64_t s2)
     uint32_t len;
 
     c = c & 0xff;
-    s1 = fix_address(env, s1);
-    s2 = fix_address(env, s2);
+    s1 = wrap_address(env, s1);
+    s2 = wrap_address(env, s2);
 
     /* Lest we fail to service interrupts in a timely manner, limit the
        amount of work we're willing to do.  For now, let's cap at 8k.  */
@@ -481,8 +474,8 @@ uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t c, uint64_t d, uint64_t s)
     uint32_t len;
 
     c = c & 0xff;
-    d = fix_address(env, d);
-    s = fix_address(env, s);
+    d = wrap_address(env, d);
+    s = wrap_address(env, s);
 
     /* Lest we fail to service interrupts in a timely manner, limit the
        amount of work we're willing to do.  For now, let's cap at 8k.  */
@@ -540,9 +533,9 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
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
@@ -583,9 +576,9 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
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
@@ -593,8 +586,6 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
     if (!(env->psw.mask & PSW_MASK_64)) {
         destlen = (uint32_t)destlen;
         srclen = (uint32_t)srclen;
-        dest &= 0x7fffffff;
-        src &= 0x7fffffff;
     }
 
     if (destlen == srclen) {
@@ -634,9 +625,9 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
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
 
@@ -1020,7 +1011,7 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
     uint64_t abs_addr;
     int i;
 
-    real_addr = fix_address(env, real_addr);
+    real_addr = wrap_address(env, real_addr);
     abs_addr = mmu_real2abs(env, real_addr) & TARGET_PAGE_MASK;
     if (!address_space_access_valid(&address_space_memory, abs_addr,
                                     TARGET_PAGE_SIZE, true)) {
@@ -1054,7 +1045,7 @@ uint64_t HELPER(iske)(CPUS390XState *env, uint64_t r2)
 {
     static S390SKeysState *ss;
     static S390SKeysClass *skeyclass;
-    uint64_t addr = get_address(env, 0, 0, r2);
+    uint64_t addr = wrap_address(env, r2);
     uint8_t key;
 
     if (addr > ram_size) {
@@ -1077,7 +1068,7 @@ void HELPER(sske)(CPUS390XState *env, uint64_t r1, uint64_t r2)
 {
     static S390SKeysState *ss;
     static S390SKeysClass *skeyclass;
-    uint64_t addr = get_address(env, 0, 0, r2);
+    uint64_t addr = wrap_address(env, r2);
     uint8_t key;
 
     if (addr > ram_size) {
@@ -1234,14 +1225,14 @@ uint64_t HELPER(lura)(CPUS390XState *env, uint64_t addr)
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
@@ -1249,7 +1240,7 @@ void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
 
-    stl_phys(cs->as, get_address(env, 0, 0, addr), (uint32_t)v1);
+    stl_phys(cs->as, wrap_address(env, addr), (uint32_t)v1);
 
     if ((env->psw.mask & PSW_MASK_PER) &&
         (env->cregs[9] & PER_CR9_EVENT_STORE) &&
@@ -1264,7 +1255,7 @@ void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
 
-    stq_phys(cs->as, get_address(env, 0, 0, addr), v1);
+    stq_phys(cs->as, wrap_address(env, addr), v1);
 
     if ((env->psw.mask & PSW_MASK_PER) &&
         (env->cregs[9] & PER_CR9_EVENT_STORE) &&
@@ -1357,8 +1348,8 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
             uint32_t d1 = extract64(insn, 32, 12);
             uint32_t b2 = extract64(insn, 28, 4);
             uint32_t d2 = extract64(insn, 16, 12);
-            uint64_t a1 = get_address(env, 0, b1, d1);
-            uint64_t a2 = get_address(env, 0, b2, d2);
+            uint64_t a1 = wrap_address(env, env->regs[b1] + d1);
+            uint64_t a2 = wrap_address(env, env->regs[b2] + d2);
 
             env->cc_op = helper(env, l, a1, a2, 0);
             env->psw.addr += ilen;
-- 
2.9.4
