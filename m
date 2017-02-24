Received: from eggs.gnu.org ([2001:4830:134:3::10]:35196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmT-0003uv-HY
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmS-0005G3-0a
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:45 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1chJmR-0004Og-No
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:43 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 17:35:21 +0000
Message-Id: <1487957728-8354-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
References: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH risu 2/9] Abstract out getting and setting
 parameter register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>

From: Peter Maydell <pmaydell@chiark.greenend.org.uk>

The SETMEMBLOCK operation takes a parameter in a register,
and GETMEMBLOCK returns a result in a register. Abstract
these out into functions provided by the backend, so we
can use common code for send_register_info() and
recv_and_compare_register_info().

Signed-off-by: Peter Maydell <pmaydell@chiark.greenend.org.uk>
---
 risu.h         | 11 +++++++++++
 risu_aarch64.c | 19 +++++++++++++------
 risu_arm.c     | 20 ++++++++++++++------
 risu_m68k.c    | 19 +++++++++++++------
 risu_ppc64le.c | 19 +++++++++++++------
 5 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/risu.h b/risu.h
index 26ed834..4f923b2 100644
--- a/risu.h
+++ b/risu.h
@@ -37,6 +37,8 @@ extern int test_fp_exc;
 /* The memory block should be this long */
 #define MEMBLOCKLEN 8192
 
+struct reginfo;
+
 /* Interface provided by CPU-specific code: */
 
 /* Send the register information from the struct ucontext down the socket.
@@ -63,4 +65,13 @@ int report_match_status(void);
  */
 void advance_pc(void *uc);
 
+/* Set the parameter register in a ucontext_t to the specified value.
+ * (32-bit targets can ignore high 32 bits.)
+ * vuc is a ucontext_t* cast to void*.
+ */
+void set_ucontext_paramreg(void *vuc, uint64_t value);
+
+/* Return the value of the parameter register from a reginfo. */
+uint64_t get_reginfo_paramreg(struct reginfo *ri);
+
 #endif /* RISU_H */
diff --git a/risu_aarch64.c b/risu_aarch64.c
index f150dcd..f13338d 100644
--- a/risu_aarch64.c
+++ b/risu_aarch64.c
@@ -30,10 +30,15 @@ void advance_pc(void *vuc)
     uc->uc_mcontext.pc += 4;
 }
 
-static void set_x0(void *vuc, uint64_t x0)
+void set_ucontext_paramreg(void *vuc, uint64_t value)
 {
     ucontext_t *uc = vuc;
-    uc->uc_mcontext.regs[0] = x0;
+    uc->uc_mcontext.regs[0] = value;
+}
+
+uint64_t get_reginfo_paramreg(struct reginfo *ri)
+{
+    return ri->regs[0];
 }
 
 static int get_risuop(uint32_t insn)
@@ -63,10 +68,11 @@ int send_register_info(int sock, void *uc)
          */
         return send_data_pkt(sock, &ri, sizeof(ri));
     case OP_SETMEMBLOCK:
-        memblock = (void *)ri.regs[0];
+        memblock = (void *)get_reginfo_paramreg(&ri);
        break;
     case OP_GETMEMBLOCK:
-        set_x0(uc, ri.regs[0] + (uintptr_t)memblock);
+        set_ucontext_paramreg(uc,
+                              get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
         return send_data_pkt(sock, memblock, MEMBLOCKLEN);
@@ -111,10 +117,11 @@ int recv_and_compare_register_info(int sock, void *uc)
         send_response_byte(sock, resp);
         break;
       case OP_SETMEMBLOCK:
-          memblock = (void *)master_ri.regs[0];
+          memblock = (void *)get_reginfo_paramreg(&master_ri);
           break;
       case OP_GETMEMBLOCK:
-          set_x0(uc, master_ri.regs[0] + (uintptr_t)memblock);
+          set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
+                                (uintptr_t)memblock);
           break;
       case OP_COMPAREMEM:
          mem_used = 1;
diff --git a/risu_arm.c b/risu_arm.c
index bdfb59b..c2b79a5 100644
--- a/risu_arm.c
+++ b/risu_arm.c
@@ -52,10 +52,16 @@ void advance_pc(void *vuc)
    uc->uc_mcontext.arm_pc += insnsize(uc);
 }
 
-static void set_r0(void *vuc, uint32_t r0)
+
+void set_ucontext_paramreg(void *vuc, uint64_t value)
 {
    ucontext_t *uc = vuc;
-   uc->uc_mcontext.arm_r0 = r0;
+   uc->uc_mcontext.arm_r0 = value;
+}
+
+uint64_t get_reginfo_paramreg(struct reginfo *ri)
+{
+    return ri->gpreg[0];
 }
 
 static int get_risuop(uint32_t insn, int isz)
@@ -87,10 +93,11 @@ int send_register_info(int sock, void *uc)
           */
          return send_data_pkt(sock, &ri, sizeof(ri));
       case OP_SETMEMBLOCK:
-         memblock = (void *)ri.gpreg[0];
+         memblock = (void *)(uintptr_t)get_reginfo_paramreg(&ri);
          break;
       case OP_GETMEMBLOCK:
-         set_r0(uc, ri.gpreg[0] + (uintptr_t)memblock);
+         set_ucontext_paramreg(uc,
+                               get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
          break;
       case OP_COMPAREMEM:
          return send_data_pkt(sock, memblock, MEMBLOCKLEN);
@@ -139,10 +146,11 @@ int recv_and_compare_register_info(int sock, void *uc)
          send_response_byte(sock, resp);
          break;
       case OP_SETMEMBLOCK:
-         memblock = (void *)master_ri.gpreg[0];
+         memblock = (void *)(uintptr_t)get_reginfo_paramreg(&master_ri);
          break;
       case OP_GETMEMBLOCK:
-         set_r0(uc, master_ri.gpreg[0] + (uintptr_t)memblock);
+         set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
+                               (uintptr_t)memblock);
          break;
       case OP_COMPAREMEM:
          mem_used = 1;
diff --git a/risu_m68k.c b/risu_m68k.c
index 15e30b1..feb3912 100644
--- a/risu_m68k.c
+++ b/risu_m68k.c
@@ -25,10 +25,15 @@ void advance_pc(void *vuc)
     uc->uc_mcontext.gregs[R_PC] += 4;
 }
 
-void set_a0(void *vuc, uint32_t a0)
+void set_ucontext_paramreg(void *vuc, uint64_t value)
 {
     ucontext_t *uc = vuc;
-    uc->uc_mcontext.gregs[R_A0] = a0;
+    uc->uc_mcontext.gregs[R_A0] = value;
+}
+
+uint64_t get_reginfo_paramreg(struct reginfo *ri)
+{
+    return ri->gregs[R_A0];
 }
 
 static int get_risuop(uint32_t insn)
@@ -53,10 +58,11 @@ int send_register_info(int sock, void *uc)
     default:
         return send_data_pkt(sock, &ri, sizeof(ri));
     case OP_SETMEMBLOCK:
-        memblock = (void*)ri.gregs[R_A0];
+        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&ri);
         break;
     case OP_GETMEMBLOCK:
-        set_a0(uc, ri.gregs[R_A0] + (uintptr_t)memblock);
+        set_ucontext_paramreg(uc,
+                              get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
         return send_data_pkt(sock, memblock, MEMBLOCKLEN);
@@ -93,10 +99,11 @@ int recv_and_compare_register_info(int sock, void *uc)
         send_response_byte(sock, resp);
         break;
     case OP_SETMEMBLOCK:
-        memblock = (void*)master_ri.gregs[R_A0];
+        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&master_ri);
         break;
     case OP_GETMEMBLOCK:
-        set_a0(uc, master_ri.gregs[R_A0] + (uintptr_t)memblock);
+        set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
+                              (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
         mem_used = 1;
diff --git a/risu_ppc64le.c b/risu_ppc64le.c
index 1c986a9..05b0294 100644
--- a/risu_ppc64le.c
+++ b/risu_ppc64le.c
@@ -30,10 +30,15 @@ void advance_pc(void *vuc)
     uc->uc_mcontext.regs->nip += 4;
 }
 
-void set_x0(void *vuc, uint64_t x0)
+void set_ucontext_paramreg(void *vuc, uint64_t value)
 {
     ucontext_t *uc = vuc;
-    uc->uc_mcontext.gp_regs[0] = x0;
+    uc->uc_mcontext.gp_regs[0] = value;
+}
+
+uint64_t get_reginfo_paramreg(struct reginfo *ri)
+{
+    return ri->gregs[0];
 }
 
 static int get_risuop(uint32_t insn)
@@ -58,10 +63,11 @@ int send_register_info(int sock, void *uc)
     default:
         return send_data_pkt(sock, &ri, sizeof(ri));
     case OP_SETMEMBLOCK:
-        memblock = (void*)ri.gregs[0];
+        memblock = (void*)get_reginfo_paramreg(&ri);
         break;
     case OP_GETMEMBLOCK:
-        set_x0(uc, ri.gregs[0] + (uintptr_t)memblock);
+        set_ucontext_paramreg(uc,
+                              get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
         return send_data_pkt(sock, memblock, MEMBLOCKLEN);
@@ -98,10 +104,11 @@ int recv_and_compare_register_info(int sock, void *uc)
         send_response_byte(sock, resp);
         break;
     case OP_SETMEMBLOCK:
-        memblock = (void*)master_ri.gregs[0];
+        memblock = (void*)get_reginfo_paramreg(&master_ri);
         break;
     case OP_GETMEMBLOCK:
-        set_x0(uc, master_ri.gregs[0] + (uintptr_t)memblock);
+        set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
+                              (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
         mem_used = 1;
-- 
2.7.4
