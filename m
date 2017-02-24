Received: from eggs.gnu.org ([2001:4830:134:3::10]:35116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmP-0003tz-Me
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmN-0004yT-TI
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1chJmN-0004Og-K2
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:39 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 17:35:26 +0000
Message-Id: <1487957728-8354-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
References: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH risu 7/9] Move send_register_info() to reginfo.c
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

send_register_info() is now essentially the same code for all
target CPUs, so move it into reginfo.c rather than having
duplicated code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile       |  4 ++--
 reginfo.c      | 43 +++++++++++++++++++++++++++++++++++++++++++
 risu.h         | 13 ++++++++++++-
 risu_aarch64.c | 29 -----------------------------
 risu_arm.c     | 30 ------------------------------
 risu_m68k.c    | 27 ---------------------------
 risu_ppc64le.c | 27 ---------------------------
 7 files changed, 57 insertions(+), 116 deletions(-)
 create mode 100644 reginfo.c

diff --git a/Makefile b/Makefile
index d20c4e4..9a29bb4 100644
--- a/Makefile
+++ b/Makefile
@@ -17,10 +17,10 @@ VPATH=$(SRCDIR)
 
 CFLAGS ?= -g
 
-ALL_CFLAGS = -Wall -D_GNU_SOURCE $(CFLAGS) $(EXTRA_CFLAGS)
+ALL_CFLAGS = -Wall -D_GNU_SOURCE -DARCH=$(ARCH) $(CFLAGS) $(EXTRA_CFLAGS)
 
 PROG=risu
-SRCS=risu.c comms.c risu_$(ARCH).c risu_reginfo_$(ARCH).c
+SRCS=risu.c comms.c reginfo.c risu_$(ARCH).c risu_reginfo_$(ARCH).c
 HDRS=risu.h
 BINS=test_$(ARCH).bin
 
diff --git a/reginfo.c b/reginfo.c
new file mode 100644
index 0000000..d62a2ed
--- /dev/null
+++ b/reginfo.c
@@ -0,0 +1,43 @@
+/******************************************************************************
+ * Copyright (c) 2017 Linaro Limited
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Peter Maydell (Linaro) - initial implementation
+ *****************************************************************************/
+
+#include <stdio.h>
+
+#include "risu.h"
+
+int send_register_info(int sock, void *uc)
+{
+    struct reginfo ri;
+    int op;
+    reginfo_init(&ri, uc);
+    op = get_risuop(&ri);
+
+    switch (op) {
+    case OP_COMPARE:
+    case OP_TESTEND:
+    default:
+        /* Do a simple register compare on (a) explicit request
+         * (b) end of test (c) a non-risuop UNDEF
+         */
+        return send_data_pkt(sock, &ri, sizeof(ri));
+    case OP_SETMEMBLOCK:
+        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&ri);
+       break;
+    case OP_GETMEMBLOCK:
+        set_ucontext_paramreg(uc,
+                              get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
+        break;
+    case OP_COMPAREMEM:
+        return send_data_pkt(sock, memblock, MEMBLOCKLEN);
+        break;
+    }
+    return 0;
+}
diff --git a/risu.h b/risu.h
index d95dace..0f00b5f 100644
--- a/risu.h
+++ b/risu.h
@@ -16,6 +16,15 @@
 #include <stdint.h>
 #include <ucontext.h>
 
+/* GCC computed include to pull in the correct risu_reginfo_*.h for
+ * the architecture.
+ */
+#define REGINFO_HEADER2(X) #X
+#define REGINFO_HEADER1(ARCHNAME) REGINFO_HEADER2(risu_reginfo_ ## ARCHNAME.h)
+#define REGINFO_HEADER(ARCH) REGINFO_HEADER1(ARCH)
+
+#include REGINFO_HEADER(ARCH)
+
 /* Socket related routines */
 int master_connect(int port);
 int apprentice_connect(const char *hostname, int port);
@@ -40,7 +49,7 @@ extern int test_fp_exc;
 
 struct reginfo;
 
-/* Interface provided by CPU-specific code: */
+/* Functions operating on reginfo */
 
 /* Send the register information from the struct ucontext down the socket.
  * Return the response code from the master.
@@ -48,6 +57,8 @@ struct reginfo;
  */
 int send_register_info(int sock, void *uc);
 
+/* Interface provided by CPU-specific code: */
+
 /* Read register info from the socket and compare it with that from the
  * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
  * NB: called from a signal handler.
diff --git a/risu_aarch64.c b/risu_aarch64.c
index 81573e3..7363eb1 100644
--- a/risu_aarch64.c
+++ b/risu_aarch64.c
@@ -53,35 +53,6 @@ int get_risuop(struct reginfo *ri)
     return (key != risukey) ? -1 : op;
 }
 
-int send_register_info(int sock, void *uc)
-{
-    struct reginfo ri;
-    int op;
-    reginfo_init(&ri, uc);
-    op = get_risuop(&ri);
-
-    switch (op) {
-    case OP_COMPARE:
-    case OP_TESTEND:
-    default:
-        /* Do a simple register compare on (a) explicit request
-         * (b) end of test (c) a non-risuop UNDEF
-         */
-        return send_data_pkt(sock, &ri, sizeof(ri));
-    case OP_SETMEMBLOCK:
-        memblock = (void *)get_reginfo_paramreg(&ri);
-       break;
-    case OP_GETMEMBLOCK:
-        set_ucontext_paramreg(uc,
-                              get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
-        break;
-    case OP_COMPAREMEM:
-        return send_data_pkt(sock, memblock, MEMBLOCKLEN);
-        break;
-    }
-    return 0;
-}
-
 /* Read register info from the socket and compare it with that from the
  * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
  * NB: called from a signal handler.
diff --git a/risu_arm.c b/risu_arm.c
index 36ac3c8..878b2ee 100644
--- a/risu_arm.c
+++ b/risu_arm.c
@@ -77,36 +77,6 @@ int get_risuop(struct reginfo *ri)
    return (key != risukey) ? -1 : op;
 }
 
-int send_register_info(int sock, void *uc)
-{
-   struct reginfo ri;
-   int op;
-   reginfo_init(&ri, uc);
-   op = get_risuop(&ri);
-
-   switch (op)
-   {
-      case OP_COMPARE:
-      case OP_TESTEND:
-      default:
-         /* Do a simple register compare on (a) explicit request
-          * (b) end of test (c) a non-risuop UNDEF
-          */
-         return send_data_pkt(sock, &ri, sizeof(ri));
-      case OP_SETMEMBLOCK:
-         memblock = (void *)(uintptr_t)get_reginfo_paramreg(&ri);
-         break;
-      case OP_GETMEMBLOCK:
-         set_ucontext_paramreg(uc,
-                               get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
-         break;
-      case OP_COMPAREMEM:
-         return send_data_pkt(sock, memblock, MEMBLOCKLEN);
-         break;
-   }
-   return 0;
-}
-
 /* Read register info from the socket and compare it with that from the
  * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
  * NB: called from a signal handler.
diff --git a/risu_m68k.c b/risu_m68k.c
index e345b25..c0e29ff 100644
--- a/risu_m68k.c
+++ b/risu_m68k.c
@@ -45,33 +45,6 @@ int get_risuop(struct reginfo *ri)
     return (key != risukey) ? -1 : op;
 }
 
-int send_register_info(int sock, void *uc)
-{
-    struct reginfo ri;
-    int op;
-
-    reginfo_init(&ri, uc);
-    op = get_risuop(&ri);
-
-    switch (op) {
-    case OP_COMPARE:
-    case OP_TESTEND:
-    default:
-        return send_data_pkt(sock, &ri, sizeof(ri));
-    case OP_SETMEMBLOCK:
-        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&ri);
-        break;
-    case OP_GETMEMBLOCK:
-        set_ucontext_paramreg(uc,
-                              get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
-        break;
-    case OP_COMPAREMEM:
-        return send_data_pkt(sock, memblock, MEMBLOCKLEN);
-        break;
-    }
-    return 0;
-}
-
 /* Read register info from the socket and compare it with that from the
  * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
  * NB: called from a signal handler.
diff --git a/risu_ppc64le.c b/risu_ppc64le.c
index 8757712..928f36f 100644
--- a/risu_ppc64le.c
+++ b/risu_ppc64le.c
@@ -50,33 +50,6 @@ int get_risuop(struct reginfo *ri)
     return (key != risukey) ? -1 : op;
 }
 
-int send_register_info(int sock, void *uc)
-{
-    struct reginfo ri;
-    int op;
-
-    reginfo_init(&ri, uc);
-    op = get_risuop(&ri);
-
-    switch (op) {
-    case OP_COMPARE:
-    case OP_TESTEND:
-    default:
-        return send_data_pkt(sock, &ri, sizeof(ri));
-    case OP_SETMEMBLOCK:
-        memblock = (void*)get_reginfo_paramreg(&ri);
-        break;
-    case OP_GETMEMBLOCK:
-        set_ucontext_paramreg(uc,
-                              get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
-        break;
-    case OP_COMPAREMEM:
-        return send_data_pkt(sock, memblock, MEMBLOCKLEN);
-        break;
-    }
-    return 0;
-}
-
 /* Read register info from the socket and compare it with that from the
  * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
  * NB: called from a signal handler.
-- 
2.7.4
