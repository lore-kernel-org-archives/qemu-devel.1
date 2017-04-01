Received: from eggs.gnu.org ([2001:4830:134:3::10]:48526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJFY-00064F-Q2
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJFX-0001Yi-DV
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:39:28 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJFX-0001YP-6M
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:39:27 -0400
Received: by mail-oi0-x241.google.com with SMTP id d2so5833507oig.2
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:39:27 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:39:26 +0300
Message-ID: <CA+KKJYAayURWSAcsjXXszSbOn3k3az8jdpXnfz971hfRV4prhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 07/43] ldst_helper: made printf always compile
 in debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com

>From a827e069c46b272ab952dfde370c1954decdf3dd Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 02:15:48 +0300
Subject: [PATCH 07/43] ldst_helper: made printf always compile in debug
output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 target/sparc/ldst_helper.c | 67
+++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 57968d9..7fe9b85 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -25,38 +25,49 @@
 #include "exec/cpu_ldst.h"
 #include "asi.h"

-//#define DEBUG_MMU
-//#define DEBUG_MXCC
 //#define DEBUG_UNALIGNED
 //#define DEBUG_UNASSIGNED
-//#define DEBUG_ASI
-//#define DEBUG_CACHE_CONTROL

-#ifdef DEBUG_MMU
-#define DPRINTF_MMU(fmt, ...)                                   \
-    do { printf("MMU: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF_MMU(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_MMU
+#define DEBUG_MMU 0
+#endif

-#ifdef DEBUG_MXCC
-#define DPRINTF_MXCC(fmt, ...)                                  \
-    do { printf("MXCC: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF_MXCC(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_MXCC
+#define DEBUG_MXCC 0
+#endif

-#ifdef DEBUG_ASI
-#define DPRINTF_ASI(fmt, ...)                                   \
-    do { printf("ASI: " fmt , ## __VA_ARGS__); } while (0)
-#endif
+#ifndef DEBUG_ASI
+#define DEBUG_ASI 0
+#endif

-#ifdef DEBUG_CACHE_CONTROL
-#define DPRINTF_CACHE_CONTROL(fmt, ...)                                 \
-    do { printf("CACHE_CONTROL: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF_CACHE_CONTROL(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_CACHE_CONTROL
+#define DEBUG_CACHE_CONTROL 0
+#endif
+
+
+#define DPRINTF_MMU(fmt, ...) do {                    \
+    if (DEBUG_MMU) {                                  \
+        fprintf(stderr, "MMU: " fmt, ## __VA_ARGS__); \
+    }                                                 \
+} while (0);
+
+#define DPRINTF_MXCC(fmt, ...) do {                    \
+    if (DEBUG_MXCC) {                                  \
+        fprintf(stderr, "MXCC: " fmt, ## __VA_ARGS__); \
+    }                                                  \
+} while (0);
+
+#define DPRINTF_ASI(fmt, ...) do {                    \
+    if (DEBUG_ASI) {                                  \
+        fprintf(stderr, "ASI: " fmt, ## __VA_ARGS__); \
+    }                                                 \
+} while (0);
+
+#define DPRINTF_CACHE_CONTROL(fmt, ...) do {                    \
+    if (DEBUG_CACHE_CONTROL) {                                  \
+        fprintf(stderr, "CACHE_CONTROL: " fmt, ## __VA_ARGS__); \
+    }                                                           \
+} while (0);

 #ifdef TARGET_SPARC64
 #ifndef TARGET_ABI32
@@ -1631,7 +1642,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong
addr, target_ulong val,

             if (oldreg != env->immu.mmuregs[reg]) {
                 DPRINTF_MMU("immu change reg[%d]: 0x%016" PRIx64 " ->
0x%016"
-                            PRIx64 "\n", reg, oldreg, env->immuregs[reg]);
+                            PRIx64 "\n", reg, oldreg,
env->immu.mmuregs[reg]);
             }
 #ifdef DEBUG_MMU
             dump_mmu(stdout, fprintf, env);
@@ -1715,7 +1726,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong
addr, target_ulong val,

             if (oldreg != env->dmmu.mmuregs[reg]) {
                 DPRINTF_MMU("dmmu change reg[%d]: 0x%016" PRIx64 " ->
0x%016"
-                            PRIx64 "\n", reg, oldreg, env->dmmuregs[reg]);
+                            PRIx64 "\n", reg, oldreg,
env->dmmu.mmuregs[reg]);
             }
 #ifdef DEBUG_MMU
             dump_mmu(stdout, fprintf, env);
-- 
2.8.0.rc3
