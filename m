Received: from eggs.gnu.org ([2001:4830:134:3::10]:45396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkh0-0007Ly-KL
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkgz-0007zi-0C
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:50 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:57894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cKkgy-0007zO-K7
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:48 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 24 Dec 2016 12:40:23 +0100
Message-Id: <1482579633-3393-3-git-send-email-laurent@vivier.eu>
In-Reply-To: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
References: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 02/12] target-m68k: Split gen_lea and gen_ea
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Provide gen_lea_mode and gen_ea_mode, where the mode can be
specified manually, rather than taken from the instruction.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <1478206203-4606-3-git-send-email-rth@twiddle.net>
---
 target/m68k/translate.c | 112 +++++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 53 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index a9066dc..aaa221e 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -697,37 +697,37 @@ static void gen_partset_reg(int opsize, TCGv reg, TCGv val)
 
 /* Generate code for an "effective address".  Does not adjust the base
    register for autoincrement addressing modes.  */
-static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
-                    int opsize)
+static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
+                         int mode, int reg0, int opsize)
 {
     TCGv reg;
     TCGv tmp;
     uint16_t ext;
     uint32_t offset;
 
-    switch ((insn >> 3) & 7) {
+    switch (mode) {
     case 0: /* Data register direct.  */
     case 1: /* Address register direct.  */
         return NULL_QREG;
     case 2: /* Indirect register */
     case 3: /* Indirect postincrement.  */
-        return AREG(insn, 0);
+        return get_areg(s, reg0);
     case 4: /* Indirect predecrememnt.  */
-        reg = AREG(insn, 0);
+        reg = get_areg(s, reg0);
         tmp = tcg_temp_new();
         tcg_gen_subi_i32(tmp, reg, opsize_bytes(opsize));
         return tmp;
     case 5: /* Indirect displacement.  */
-        reg = AREG(insn, 0);
+        reg = get_areg(s, reg0);
         tmp = tcg_temp_new();
         ext = read_im16(env, s);
         tcg_gen_addi_i32(tmp, reg, (int16_t)ext);
         return tmp;
     case 6: /* Indirect index + displacement.  */
-        reg = AREG(insn, 0);
+        reg = get_areg(s, reg0);
         return gen_lea_indexed(env, s, reg);
     case 7: /* Other */
-        switch (insn & 7) {
+        switch (reg0) {
         case 0: /* Absolute short.  */
             offset = (int16_t)read_im16(env, s);
             return tcg_const_i32(offset);
@@ -749,39 +749,26 @@ static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
     return NULL_QREG;
 }
 
-/* Helper function for gen_ea. Reuse the computed address between the
-   for read/write operands.  */
-static inline TCGv gen_ea_once(CPUM68KState *env, DisasContext *s,
-                               uint16_t insn, int opsize, TCGv val,
-                               TCGv *addrp, ea_what what)
+static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
+                    int opsize)
 {
-    TCGv tmp;
-
-    if (addrp && what == EA_STORE) {
-        tmp = *addrp;
-    } else {
-        tmp = gen_lea(env, s, insn, opsize);
-        if (IS_NULL_QREG(tmp))
-            return tmp;
-        if (addrp)
-            *addrp = tmp;
-    }
-    return gen_ldst(s, opsize, tmp, val, what);
+    int mode = extract32(insn, 3, 3);
+    int reg0 = REG(insn, 0);
+    return gen_lea_mode(env, s, mode, reg0, opsize);
 }
 
-/* Generate code to load/store a value from/into an EA.  If VAL > 0 this is
+/* Generate code to load/store a value from/into an EA.  If WHAT > 0 this is
    a write otherwise it is a read (0 == sign extend, -1 == zero extend).
    ADDRP is non-null for readwrite operands.  */
-static TCGv gen_ea(CPUM68KState *env, DisasContext *s, uint16_t insn,
-                   int opsize, TCGv val, TCGv *addrp, ea_what what)
+static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
+                        int opsize, TCGv val, TCGv *addrp, ea_what what)
 {
-    TCGv reg;
-    TCGv result;
-    uint32_t offset;
+    TCGv reg, tmp, result;
+    int32_t offset;
 
-    switch ((insn >> 3) & 7) {
+    switch (mode) {
     case 0: /* Data register direct.  */
-        reg = DREG(insn, 0);
+        reg = cpu_dregs[reg0];
         if (what == EA_STORE) {
             gen_partset_reg(opsize, reg, val);
             return store_dummy;
@@ -789,7 +776,7 @@ static TCGv gen_ea(CPUM68KState *env, DisasContext *s, uint16_t insn,
             return gen_extend(reg, opsize, what == EA_LOADS);
         }
     case 1: /* Address register direct.  */
-        reg = AREG(insn, 0);
+        reg = get_areg(s, reg0);
         if (what == EA_STORE) {
             tcg_gen_mov_i32(reg, val);
             return store_dummy;
@@ -797,45 +784,56 @@ static TCGv gen_ea(CPUM68KState *env, DisasContext *s, uint16_t insn,
             return gen_extend(reg, opsize, what == EA_LOADS);
         }
     case 2: /* Indirect register */
-        reg = AREG(insn, 0);
+        reg = get_areg(s, reg0);
         return gen_ldst(s, opsize, reg, val, what);
     case 3: /* Indirect postincrement.  */
-        reg = AREG(insn, 0);
+        reg = get_areg(s, reg0);
         result = gen_ldst(s, opsize, reg, val, what);
         if (what == EA_STORE || !addrp) {
             TCGv tmp = tcg_temp_new();
             tcg_gen_addi_i32(tmp, reg, opsize_bytes(opsize));
-            delay_set_areg(s, REG(insn, 0), tmp, true);
+            delay_set_areg(s, reg0, tmp, true);
         }
         return result;
     case 4: /* Indirect predecrememnt.  */
-        {
-            TCGv tmp;
-            if (addrp && what == EA_STORE) {
-                tmp = *addrp;
-            } else {
-                tmp = gen_lea(env, s, insn, opsize);
-                if (IS_NULL_QREG(tmp))
-                    return tmp;
-                if (addrp)
-                    *addrp = tmp;
+        if (addrp && what == EA_STORE) {
+            tmp = *addrp;
+        } else {
+            tmp = gen_lea_mode(env, s, mode, reg0, opsize);
+            if (IS_NULL_QREG(tmp)) {
+                return tmp;
             }
-            result = gen_ldst(s, opsize, tmp, val, what);
-            if (what == EA_STORE || !addrp) {
-                delay_set_areg(s, REG(insn, 0), tmp, false);
+            if (addrp) {
+                *addrp = tmp;
             }
         }
+        result = gen_ldst(s, opsize, tmp, val, what);
+        if (what == EA_STORE || !addrp) {
+            delay_set_areg(s, reg0, tmp, false);
+        }
         return result;
     case 5: /* Indirect displacement.  */
     case 6: /* Indirect index + displacement.  */
-        return gen_ea_once(env, s, insn, opsize, val, addrp, what);
+    do_indirect:
+        if (addrp && what == EA_STORE) {
+            tmp = *addrp;
+        } else {
+            tmp = gen_lea_mode(env, s, mode, reg0, opsize);
+            if (IS_NULL_QREG(tmp)) {
+                return tmp;
+            }
+            if (addrp) {
+                *addrp = tmp;
+            }
+        }
+        return gen_ldst(s, opsize, tmp, val, what);
     case 7: /* Other */
-        switch (insn & 7) {
+        switch (reg0) {
         case 0: /* Absolute short.  */
         case 1: /* Absolute long.  */
         case 2: /* pc displacement  */
         case 3: /* pc index+displacement.  */
-            return gen_ea_once(env, s, insn, opsize, val, addrp, what);
+            goto do_indirect;
         case 4: /* Immediate.  */
             /* Sign extend values for consistency.  */
             switch (opsize) {
@@ -868,6 +866,14 @@ static TCGv gen_ea(CPUM68KState *env, DisasContext *s, uint16_t insn,
     return NULL_QREG;
 }
 
+static TCGv gen_ea(CPUM68KState *env, DisasContext *s, uint16_t insn,
+                   int opsize, TCGv val, TCGv *addrp, ea_what what)
+{
+    int mode = extract32(insn, 3, 3);
+    int reg0 = REG(insn, 0);
+    return gen_ea_mode(env, s, mode, reg0, opsize, val, addrp, what);
+}
+
 typedef struct {
     TCGCond tcond;
     bool g1;
-- 
2.7.4
