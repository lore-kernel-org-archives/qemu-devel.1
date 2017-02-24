Received: from eggs.gnu.org ([2001:4830:134:3::10]:35117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmP-0003u0-NS
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmN-0004ul-2K
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1chJmM-0004Og-MP
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:38 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 17:35:27 +0000
Message-Id: <1487957728-8354-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
References: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH risu 8/9] Move recv_and_compare_register_info()
 and report_match_status() to reginfo.c
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

Move recv_and_compare_register_info() and report_match_status() to
reginfo.c -- they are essentially the same for all targets so
can be common code. The shared variables they use come with them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 reginfo.c      | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 risu.h         |   4 +-
 risu_aarch64.c | 108 -----------------------------------------------------
 risu_arm.c     | 116 ---------------------------------------------------------
 risu_m68k.c    |  94 ----------------------------------------------
 risu_ppc64le.c |  94 ----------------------------------------------
 6 files changed, 110 insertions(+), 414 deletions(-)

diff --git a/reginfo.c b/reginfo.c
index d62a2ed..96c6342 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -10,9 +10,17 @@
  *****************************************************************************/
 
 #include <stdio.h>
+#include <string.h>
 
 #include "risu.h"
 
+struct reginfo master_ri, apprentice_ri;
+
+uint8_t apprentice_memblock[MEMBLOCKLEN];
+
+static int mem_used = 0;
+static int packet_mismatch = 0;
+
 int send_register_info(int sock, void *uc)
 {
     struct reginfo ri;
@@ -41,3 +49,103 @@ int send_register_info(int sock, void *uc)
     }
     return 0;
 }
+
+/* Read register info from the socket and compare it with that from the
+ * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
+ * NB: called from a signal handler.
+ *
+ * We don't have any kind of identifying info in the incoming data
+ * that says whether it is register or memory data, so if the two
+ * sides get out of sync then we will fail obscurely.
+ */
+int recv_and_compare_register_info(int sock, void *uc)
+{
+    int resp = 0, op;
+
+    reginfo_init(&master_ri, uc);
+    op = get_risuop(&master_ri);
+
+    switch (op) {
+    case OP_COMPARE:
+    case OP_TESTEND:
+    default:
+        /* Do a simple register compare on (a) explicit request
+         * (b) end of test (c) a non-risuop UNDEF
+         */
+        if (recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri))) {
+            packet_mismatch = 1;
+            resp = 2;
+
+        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
+            /* register mismatch */
+            resp = 2;
+
+        } else if (op == OP_TESTEND) {
+            resp = 1;
+        }
+        send_response_byte(sock, resp);
+        break;
+      case OP_SETMEMBLOCK:
+          memblock = (void *)(uintptr_t)get_reginfo_paramreg(&master_ri);
+          break;
+      case OP_GETMEMBLOCK:
+          set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
+                                (uintptr_t)memblock);
+          break;
+      case OP_COMPAREMEM:
+         mem_used = 1;
+         if (recv_data_pkt(sock, apprentice_memblock, MEMBLOCKLEN)) {
+             packet_mismatch = 1;
+             resp = 2;
+         } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
+             /* memory mismatch */
+             resp = 2;
+         }
+         send_response_byte(sock, resp);
+         break;
+   }
+
+    return resp;
+}
+
+/* Print a useful report on the status of the last comparison
+ * done in recv_and_compare_register_info(). This is called on
+ * exit, so need not restrict itself to signal-safe functions.
+ * Should return 0 if it was a good match (ie end of test)
+ * and 1 for a mismatch.
+ */
+int report_match_status(void)
+{
+   int resp = 0;
+   fprintf(stderr, "match status...\n");
+   if (packet_mismatch) {
+       fprintf(stderr, "packet mismatch (probably disagreement "
+               "about UNDEF on load/store)\n");
+       /* We don't have valid reginfo from the apprentice side
+        * so stop now rather than printing anything about it.
+        */
+       fprintf(stderr, "master reginfo:\n");
+       reginfo_dump(&master_ri, stderr);
+       return 1;
+   }
+   if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
+       fprintf(stderr, "mismatch on regs!\n");
+       resp = 1;
+   }
+   if (mem_used && memcmp(memblock, &apprentice_memblock, MEMBLOCKLEN) != 0) {
+       fprintf(stderr, "mismatch on memory!\n");
+       resp = 1;
+   }
+   if (!resp) {
+       fprintf(stderr, "match!\n");
+       return 0;
+   }
+
+   fprintf(stderr, "master reginfo:\n");
+   reginfo_dump(&master_ri, stderr);
+   fprintf(stderr, "apprentice reginfo:\n");
+   reginfo_dump(&apprentice_ri, stderr);
+
+   reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
+   return resp;
+}
diff --git a/risu.h b/risu.h
index 0f00b5f..90e4f23 100644
--- a/risu.h
+++ b/risu.h
@@ -57,8 +57,6 @@ struct reginfo;
  */
 int send_register_info(int sock, void *uc);
 
-/* Interface provided by CPU-specific code: */
-
 /* Read register info from the socket and compare it with that from the
  * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
  * NB: called from a signal handler.
@@ -73,6 +71,8 @@ int recv_and_compare_register_info(int sock, void *uc);
  */
 int report_match_status(void);
 
+/* Interface provided by CPU-specific code: */
+
 /* Move the PC past this faulting insn by adjusting ucontext
  */
 void advance_pc(void *uc);
diff --git a/risu_aarch64.c b/risu_aarch64.c
index 7363eb1..cdd23d8 100644
--- a/risu_aarch64.c
+++ b/risu_aarch64.c
@@ -17,13 +17,6 @@
 #include "risu.h"
 #include "risu_reginfo_aarch64.h"
 
-struct reginfo master_ri, apprentice_ri;
-
-uint8_t apprentice_memblock[MEMBLOCKLEN];
-
-static int mem_used = 0;
-static int packet_mismatch = 0;
-
 void advance_pc(void *vuc)
 {
     ucontext_t *uc = vuc;
@@ -52,104 +45,3 @@ int get_risuop(struct reginfo *ri)
     uint32_t risukey = 0x00005af0;
     return (key != risukey) ? -1 : op;
 }
-
-/* Read register info from the socket and compare it with that from the
- * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
- * NB: called from a signal handler.
- *
- * We don't have any kind of identifying info in the incoming data
- * that says whether it is register or memory data, so if the two
- * sides get out of sync then we will fail obscurely.
- */
-int recv_and_compare_register_info(int sock, void *uc)
-{
-    int resp = 0, op;
-
-    reginfo_init(&master_ri, uc);
-    op = get_risuop(&master_ri);
-
-    switch (op) {
-    case OP_COMPARE:
-    case OP_TESTEND:
-    default:
-        /* Do a simple register compare on (a) explicit request
-         * (b) end of test (c) a non-risuop UNDEF
-         */
-        if (recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri))) {
-            packet_mismatch = 1;
-            resp = 2;
-
-        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
-            /* register mismatch */
-            resp = 2;
-
-        } else if (op == OP_TESTEND) {
-            resp = 1;
-        }
-        send_response_byte(sock, resp);
-        break;
-      case OP_SETMEMBLOCK:
-          memblock = (void *)get_reginfo_paramreg(&master_ri);
-          break;
-      case OP_GETMEMBLOCK:
-          set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
-                                (uintptr_t)memblock);
-          break;
-      case OP_COMPAREMEM:
-         mem_used = 1;
-         if (recv_data_pkt(sock, apprentice_memblock, MEMBLOCKLEN)) {
-             packet_mismatch = 1;
-             resp = 2;
-         } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
-             /* memory mismatch */
-             resp = 2;
-         }
-         send_response_byte(sock, resp);
-         break;
-   }
-
-    return resp;
-}
-
-/* Print a useful report on the status of the last comparison
- * done in recv_and_compare_register_info(). This is called on
- * exit, so need not restrict itself to signal-safe functions.
- * Should return 0 if it was a good match (ie end of test)
- * and 1 for a mismatch.
- */
-int report_match_status(void)
-{
-   int resp = 0;
-   fprintf(stderr, "match status...\n");
-   if (packet_mismatch) {
-       fprintf(stderr, "packet mismatch (probably disagreement "
-               "about UNDEF on load/store)\n");
-       /* We don't have valid reginfo from the apprentice side
-        * so stop now rather than printing anything about it.
-        */
-       fprintf(stderr, "master reginfo:\n");
-       reginfo_dump(&master_ri, stderr);
-       return 1;
-   }
-   if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) != 0)
-   {
-       fprintf(stderr, "mismatch on regs!\n");
-       resp = 1;
-   }
-   if (mem_used && memcmp(memblock, &apprentice_memblock, MEMBLOCKLEN) != 0) {
-       fprintf(stderr, "mismatch on memory!\n");
-       resp = 1;
-   }
-   if (!resp) {
-       fprintf(stderr, "match!\n");
-       return 0;
-   }
-
-   fprintf(stderr, "master reginfo:\n");
-   reginfo_dump(&master_ri, stderr);
-   fprintf(stderr, "apprentice reginfo:\n");
-   reginfo_dump(&apprentice_ri, stderr);
-
-   reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
-   return resp;
-}
diff --git a/risu_arm.c b/risu_arm.c
index 878b2ee..f570828 100644
--- a/risu_arm.c
+++ b/risu_arm.c
@@ -16,12 +16,6 @@
 #include "risu.h"
 #include "risu_reginfo_arm.h"
 
-struct reginfo master_ri, apprentice_ri;
-uint8_t apprentice_memblock[MEMBLOCKLEN];
-
-static int mem_used = 0;
-static int packet_mismatch = 0;
-
 int insnsize(ucontext_t *uc)
 {
    /* Return instruction size in bytes of the
@@ -76,113 +70,3 @@ int get_risuop(struct reginfo *ri)
    uint32_t risukey = (isz == 2) ? 0xdee0 : 0xe7fe5af0;
    return (key != risukey) ? -1 : op;
 }
-
-/* Read register info from the socket and compare it with that from the
- * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
- * NB: called from a signal handler.
- *
- * We don't have any kind of identifying info in the incoming data
- * that says whether it's register or memory data, so if the two
- * sides get out of sync then we will fail obscurely.
- */
-int recv_and_compare_register_info(int sock, void *uc)
-{
-   int resp = 0, op;
-
-   reginfo_init(&master_ri, uc);
-   op = get_risuop(&master_ri);
-
-   switch (op)
-   {
-      case OP_COMPARE:
-      case OP_TESTEND:
-      default:
-         /* Do a simple register compare on (a) explicit request
-          * (b) end of test (c) a non-risuop UNDEF
-          */
-         if (recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri)))
-         {
-            packet_mismatch = 1;
-            resp = 2;
-         }
-         else if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) != 0)
-         {
-            /* register mismatch */
-            resp = 2;
-         }
-         else if (op == OP_TESTEND)
-         {
-            resp = 1;
-         }
-         send_response_byte(sock, resp);
-         break;
-      case OP_SETMEMBLOCK:
-         memblock = (void *)(uintptr_t)get_reginfo_paramreg(&master_ri);
-         break;
-      case OP_GETMEMBLOCK:
-         set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
-                               (uintptr_t)memblock);
-         break;
-      case OP_COMPAREMEM:
-         mem_used = 1;
-         if (recv_data_pkt(sock, apprentice_memblock, MEMBLOCKLEN))
-         {
-            packet_mismatch = 1;
-            resp = 2;
-         }
-         else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0)
-         {
-            /* memory mismatch */
-            resp = 2;
-         }
-         send_response_byte(sock, resp);
-         break;
-   }
-   return resp;
-}
-
-/* Print a useful report on the status of the last comparison
- * done in recv_and_compare_register_info(). This is called on
- * exit, so need not restrict itself to signal-safe functions.
- * Should return 0 if it was a good match (ie end of test)
- * and 1 for a mismatch.
- */
-int report_match_status(void)
-{
-   int resp = 0;
-   fprintf(stderr, "match status...\n");
-   if (packet_mismatch)
-   {
-      fprintf(stderr, "packet mismatch (probably disagreement "
-              "about UNDEF on load/store)\n");
-      /* We don't have valid reginfo from the apprentice side
-       * so stop now rather than printing anything about it.
-       */
-      fprintf(stderr, "master reginfo:\n");
-      reginfo_dump(&master_ri, stderr);
-      return 1;
-   }
-   if (!reginfo_is_eq(&master_ri, &apprentice_ri))
-   {
-      fprintf(stderr, "mismatch on regs!\n");
-      resp = 1;
-   }
-   if (mem_used && memcmp(memblock, &apprentice_memblock, MEMBLOCKLEN) != 0)
-   {
-      fprintf(stderr, "mismatch on memory!\n");
-      resp = 1;
-   }
-   if (!resp)
-   {
-      fprintf(stderr, "match!\n");
-      return 0;
-   }
-
-   fprintf(stderr, "master reginfo:\n");
-   reginfo_dump(&master_ri, stderr);
-   fprintf(stderr, "apprentice reginfo:\n");
-   reginfo_dump(&apprentice_ri, stderr);
-
-   reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
-   return resp;
-}
diff --git a/risu_m68k.c b/risu_m68k.c
index c0e29ff..851487b 100644
--- a/risu_m68k.c
+++ b/risu_m68k.c
@@ -13,12 +13,6 @@
 #include "risu.h"
 #include "risu_reginfo_m68k.h"
 
-struct reginfo master_ri, apprentice_ri;
-static int mem_used = 0;
-static int packet_mismatch = 0;
-
-uint8_t apprentice_memblock[MEMBLOCKLEN];
-
 void advance_pc(void *vuc)
 {
     ucontext_t *uc = (ucontext_t*)vuc;
@@ -44,91 +38,3 @@ int get_risuop(struct reginfo *ri)
     uint32_t risukey = 0x4afc7000;
     return (key != risukey) ? -1 : op;
 }
-
-/* Read register info from the socket and compare it with that from the
- * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
- * NB: called from a signal handler.
- */
-int recv_and_compare_register_info(int sock, void *uc)
-{
-    int resp = 0;
-    int op;
-
-    reginfo_init(&master_ri, uc);
-    op = get_risuop(&master_ri);
-
-    switch (op) {
-    case OP_COMPARE:
-    case OP_TESTEND:
-    default:
-        if (recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri))) {
-            packet_mismatch = 1;
-            resp = 2;
-        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
-            resp = 2;
-        }
-        else if (op == OP_TESTEND) {
-            resp = 1;
-        }
-        send_response_byte(sock, resp);
-        break;
-    case OP_SETMEMBLOCK:
-        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&master_ri);
-        break;
-    case OP_GETMEMBLOCK:
-        set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
-                              (uintptr_t)memblock);
-        break;
-    case OP_COMPAREMEM:
-        mem_used = 1;
-        if (recv_data_pkt(sock, apprentice_memblock, MEMBLOCKLEN)) {
-            packet_mismatch = 1;
-            resp = 2;
-        } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
-            resp = 2;
-        }
-        send_response_byte(sock, resp);
-        break;
-    }
-    return resp;
-}
-
-/* Print a useful report on the status of the last comparison
- * done in recv_and_compare_register_info(). This is called on
- * exit, so need not restrict itself to signal-safe functions.
- * Should return 0 if it was a good match (ie end of test)
- * and 1 for a mismatch.
- */
-int report_match_status(void)
-{
-    int resp = 0;
-    fprintf(stderr, "match status...\n");
-
-    if (packet_mismatch) {
-        fprintf(stderr, "packet mismatch (probably disagreement "
-                "about UNDEF on load/store)\n");
-        fprintf(stderr, "master reginfo:\n");
-        reginfo_dump(&master_ri, stderr);
-    }
-    if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
-        fprintf(stderr, "mismatch on regs!\n");
-        resp = 1;
-    }
-    if (mem_used && memcmp(memblock, &apprentice_memblock, MEMBLOCKLEN) != 0) {
-        fprintf(stderr, "mismatch on memory!\n");
-        resp = 1;
-    }
-    if (!resp) {
-        fprintf(stderr, "match!\n");
-        return 0;
-    }
-
-    fprintf(stderr, "master reginfo:\n");
-    reginfo_dump(&master_ri, stderr);
-
-    fprintf(stderr, "apprentice reginfo:\n");
-    reginfo_dump(&apprentice_ri, stderr);
-
-    reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
-    return resp;
-}
diff --git a/risu_ppc64le.c b/risu_ppc64le.c
index 928f36f..c15d78e 100644
--- a/risu_ppc64le.c
+++ b/risu_ppc64le.c
@@ -18,12 +18,6 @@
 #include "risu.h"
 #include "risu_reginfo_ppc64le.h"
 
-struct reginfo master_ri, apprentice_ri;
-static int mem_used = 0;
-static int packet_mismatch = 0;
-
-uint8_t apprentice_memblock[MEMBLOCKLEN];
-
 void advance_pc(void *vuc)
 {
     ucontext_t *uc = (ucontext_t*)vuc;
@@ -49,91 +43,3 @@ int get_risuop(struct reginfo *ri)
     uint32_t risukey = 0x00005af0;
     return (key != risukey) ? -1 : op;
 }
-
-/* Read register info from the socket and compare it with that from the
- * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
- * NB: called from a signal handler.
- */
-int recv_and_compare_register_info(int sock, void *uc)
-{
-    int resp = 0;
-    int op;
-
-    reginfo_init(&master_ri, uc);
-    op = get_risuop(&master_ri);
-
-    switch (op) {
-    case OP_COMPARE:
-    case OP_TESTEND:
-    default:
-        if (recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri))) {
-            packet_mismatch = 1;
-            resp = 2;
-        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
-            resp = 2;
-        }
-        else if (op == OP_TESTEND) {
-            resp = 1;
-        }
-        send_response_byte(sock, resp);
-        break;
-    case OP_SETMEMBLOCK:
-        memblock = (void*)get_reginfo_paramreg(&master_ri);
-        break;
-    case OP_GETMEMBLOCK:
-        set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
-                              (uintptr_t)memblock);
-        break;
-    case OP_COMPAREMEM:
-        mem_used = 1;
-        if (recv_data_pkt(sock, apprentice_memblock, MEMBLOCKLEN)) {
-            packet_mismatch = 1;
-            resp = 2;
-        } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
-            resp = 2;
-        }
-        send_response_byte(sock, resp);
-        break;
-    }
-    return resp;
-}
-
-/* Print a useful report on the status of the last comparison
- * done in recv_and_compare_register_info(). This is called on
- * exit, so need not restrict itself to signal-safe functions.
- * Should return 0 if it was a good match (ie end of test)
- * and 1 for a mismatch.
- */
-int report_match_status(void)
-{
-    int resp = 0;
-    fprintf(stderr, "match status...\n");
-
-    if (packet_mismatch) {
-        fprintf(stderr, "packet mismatch (probably disagreement "
-                "about UNDEF on load/store)\n");
-        fprintf(stderr, "master reginfo:\n");
-        reginfo_dump(&master_ri, stderr);
-    }
-    if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
-        fprintf(stderr, "mismatch on regs!\n");
-        resp = 1;
-    }
-    if (mem_used && memcmp(memblock, &apprentice_memblock, MEMBLOCKLEN) != 0) {
-        fprintf(stderr, "mismatch on memory!\n");
-        resp = 1;
-    }
-    if (!resp) {
-        fprintf(stderr, "match!\n");
-        return 0;
-    }
-
-    fprintf(stderr, "master reginfo:\n");
-    reginfo_dump(&master_ri, stderr);
-
-    fprintf(stderr, "apprentice reginfo:\n");
-    reginfo_dump(&apprentice_ri, stderr);
-
-    reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
-    return resp;
-}
-- 
2.7.4
