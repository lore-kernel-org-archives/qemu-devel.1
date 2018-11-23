Received: from eggs.gnu.org ([2001:4830:134:3::10]:44334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj9-0000LT-Cq
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj6-0003pH-MU
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:39 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCj6-0003nu-GY
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:36 -0500
Received: by mail-wm1-x341.google.com with SMTP id 125so12200616wmh.0
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:57 +0100
Message-Id: <20181123144558.5048-37-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 36/37] tcg/i386: Require segment
 syscalls to succeed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

There ought be no reason they should ever fail.  If we don't know
how to set a segment base register for user-only (NetBSD, OpenBSD?),
then error out if we cannot proceed.

This is one more step toward the removal of all scratch registers
during user-only guest memory operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 54 +++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 55c5a8516c..19a0fa8a03 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1814,9 +1814,12 @@ int arch_prctl(int code, unsigned long addr);
 static int guest_base_flags;
 static inline void setup_guest_base_seg(void)
 {
-    if (arch_prctl(ARCH_SET_GS, guest_base) == 0) {
-        guest_base_flags = P_GS;
+    /* There is no reason this syscall should fail.  */
+    if (arch_prctl(ARCH_SET_GS, guest_base) < 0) {
+        perror("arch_prctl(ARCH_SET_GS)");
+        exit(1);
     }
+    guest_base_flags = P_GS;
 }
 #elif defined (__FreeBSD__) || defined (__FreeBSD_kernel__)
 # include <machine/sysarch.h>
@@ -1824,13 +1827,28 @@ static inline void setup_guest_base_seg(void)
 static int guest_base_flags;
 static inline void setup_guest_base_seg(void)
 {
-    if (sysarch(AMD64_SET_GSBASE, &guest_base) == 0) {
-        guest_base_flags = P_GS;
+    /* There is no reason this syscall should fail.  */
+    if (sysarch(AMD64_SET_GSBASE, &guest_base) < 0) {
+        perror("sysarch(AMD64_SET_GSBASE)");
+        exit(1);
     }
+    guest_base_flags = P_GS;
 }
 #else
 # define guest_base_flags 0
-static inline void setup_guest_base_seg(void) { }
+static inline void setup_guest_base_seg(void)
+{
+    /*
+     * Verify we can proceed without scratch registers.
+     * If guest_base > INT32_MAX, then it would need to be loaded.
+     * If 32-bit guest, the address would need to be zero-extended.
+     */
+    if (TCG_TARGET_REG_BITS == 64
+        && (TARGET_LONG_BITS == 32 || guest_base > INT32_MAX)) {
+        error_report("Segment base register not supported on this OS");
+        exit(1);
+    }
+}
 #endif /* SOFTMMU */
 
 static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
@@ -2013,16 +2031,6 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
             if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
                 seg |= P_ADDR32;
             }
-        } else if (TCG_TARGET_REG_BITS == 64) {
-            if (TARGET_LONG_BITS == 32) {
-                tcg_out_ext32u(s, TCG_REG_L0, base);
-                base = TCG_REG_L0;
-            }
-            if (offset != guest_base) {
-                tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_L1, guest_base);
-                index = TCG_REG_L1;
-                offset = 0;
-            }
         }
 
         tcg_out_qemu_ld_direct(s, datalo, datahi,
@@ -2156,22 +2164,6 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
             if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
                 seg |= P_ADDR32;
             }
-        } else if (TCG_TARGET_REG_BITS == 64) {
-            /* ??? Note that we can't use the same SIB addressing scheme
-               as for loads, since we require L0 free for bswap.  */
-            if (offset != guest_base) {
-                if (TARGET_LONG_BITS == 32) {
-                    tcg_out_ext32u(s, TCG_REG_L0, base);
-                    base = TCG_REG_L0;
-                }
-                tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_L1, guest_base);
-                tgen_arithr(s, ARITH_ADD + P_REXW, TCG_REG_L1, base);
-                base = TCG_REG_L1;
-                offset = 0;
-            } else if (TARGET_LONG_BITS == 32) {
-                tcg_out_ext32u(s, TCG_REG_L1, base);
-                base = TCG_REG_L1;
-            }
         }
 
         tcg_out_qemu_st_direct(s, datalo, datahi, base, offset, seg, opc);
-- 
2.17.2
