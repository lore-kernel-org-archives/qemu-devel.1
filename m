Received: from eggs.gnu.org ([2001:4830:134:3::10]:54304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJVD-00057o-ON
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJVC-0003fk-9M
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:55:39 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJVC-0003fb-3B
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:55:38 -0400
Received: by mail-oi0-x242.google.com with SMTP id b187so13211824oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:55:37 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:55:36 +0300
Message-ID: <CA+KKJYCT_ct7YpdtpouvuriTbhdfAEsHuCXzfk2YPXRXKXKvHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 20/43] i386: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

>From a132733828991a950855138982d4a60858e92b04 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:32:16 +0300
Subject: [PATCH 20/43] i386: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/i386/acpi-build.c       | 17 +++++++++++------
 hw/i386/intel_iommu.c      | 18 +++++++++---------
 hw/i386/pc.c               | 16 ++++++++++------
 hw/i386/xen/xen_platform.c | 17 ++++++++++-------
 4 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2073108..53b3aaf 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -75,12 +75,17 @@
 #define ACPI_BUILD_TABLE_SIZE             0x20000

 /* #define DEBUG_ACPI_BUILD */
-#ifdef DEBUG_ACPI_BUILD
-#define ACPI_BUILD_DPRINTF(fmt, ...)        \
-    do {printf("ACPI_BUILD: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define ACPI_BUILD_DPRINTF(fmt, ...)
-#endif
+
+#ifndef DEBUG_ACPI_BUILD
+#define DEBUG_ACPI_BUILD 0
+#endif
+
+#define ACPI_BUILD_DPRINTF(fmt, ...)                             \
+    do {                                                         \
+        if (DEBUG_ACPI_BUILD) {                                  \
+            fprintf(stderr, "ACPI_BUILD: " fmt, ## __VA_ARGS__); \
+        }                                                        \
+    } while (0)

 /* Default IOAPIC ID */
 #define ACPI_BUILD_IOAPIC_ID 0x0
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 22d8226..562588b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -37,8 +37,10 @@
 #include "kvm_i386.h"
 #include "trace.h"

-/*#define DEBUG_INTEL_IOMMU*/
-#ifdef DEBUG_INTEL_IOMMU
+#ifndef DEBUG_INTEL_IOMMU
+#define DEBUG_INTEL_IOMMU 0
+#endif
+
 enum {
     DEBUG_GENERAL, DEBUG_CSR, DEBUG_INV, DEBUG_MMU, DEBUG_FLOG,
     DEBUG_CACHE, DEBUG_IR,
@@ -46,14 +48,12 @@ enum {
 #define VTD_DBGBIT(x)   (1 << DEBUG_##x)
 static int vtd_dbgflags = VTD_DBGBIT(GENERAL) | VTD_DBGBIT(CSR);

-#define VTD_DPRINTF(what, fmt, ...) do { \
-    if (vtd_dbgflags & VTD_DBGBIT(what)) { \
-        fprintf(stderr, "(vtd)%s: " fmt "\n", __func__, \
-                ## __VA_ARGS__); } \
+#define VTD_DPRINTF(what, fmt,
...)                                                  \
+    do
{                                                                       \
+        if (DEBUG_INTEL_IOMMU && vtd_dbgflags & VTD_DBGBIT(what))
{            \
+            fprintf(stderr, "(vtd)%s: " fmt "\n", __func__, ##
__VA_ARGS__);   \
+
}                                                                      \
     } while (0)
-#else
-#define VTD_DPRINTF(what, fmt, ...) do {} while (0)
-#endif

 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d24388e..87b4312 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -73,12 +73,16 @@
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ

-#ifdef DEBUG_IRQ
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("CPUIRQ: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_IRQ
+#define DEBUG_IRQ 0
+#endif
+
+#define DPRINTF(fmt, ...)                                    \
+    do {                                                     \
+        if (DEBUG_IRQ) {                                     \
+            fprintf(stderr, "CPUIRQ: " fmt, ## __VA_ARGS__); \
+        }                                                    \
+    } while (0)

 #define FW_CFG_ACPI_TABLES (FW_CFG_ARCH_LOCAL + 0)
 #define FW_CFG_SMBIOS_ENTRIES (FW_CFG_ARCH_LOCAL + 1)
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 6010f35..218bc2f 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -41,13 +41,16 @@

 //#define DEBUG_PLATFORM

-#ifdef DEBUG_PLATFORM
-#define DPRINTF(fmt, ...) do { \
-    fprintf(stderr, "xen_platform: " fmt, ## __VA_ARGS__); \
-} while (0)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
-#endif
+#ifndef DEBUG_PLATFORM
+#define DEBUG_PLATFORM 0
+#endif
+
+#define DPRINTF(fmt, ...)                                          \
+    do {                                                           \
+        if (DEBUG_PLATFORM) {                                      \
+            fprintf(stderr, "xen_platform: " fmt, ## __VA_ARGS__); \
+        }                                                          \
+    } while (0)

 #define PFFLAG_ROM_LOCK 1 /* Sets whether ROM memory area is RW or RO */

-- 
2.8.0.rc3
