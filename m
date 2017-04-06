Received: from eggs.gnu.org ([2001:4830:134:3::10]:43263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw5PS-0004JS-2S
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw5PO-0001bB-HQ
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cw5PO-0001aq-7F
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:16:58 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v36BDvHO023493
	for <qemu-devel@nongnu.org>; Thu, 6 Apr 2017 07:16:57 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29nmfmrmvd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 07:16:56 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 6 Apr 2017 12:16:54 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu,  6 Apr 2017 13:16:39 +0200
In-Reply-To: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
References: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
Message-Id: <20170406111646.12624-4-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.10 03/10] s390x/pci: make printf always
 compile in debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Danil Antonov <g.danil.anto@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Danil Antonov <g.danil.anto@gmail.com>

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
Message-Id: <CA+KKJYBi31Bs7DtVdzZdwG2t+u5+FGiAhQpd3pqJzUX1O8Cprg@mail.gmail.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-pci-bus.c  | 16 ++++++++++------
 hw/s390x/s390-pci-inst.c | 16 ++++++++++------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 69b0291e8a..0f62363434 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -24,14 +24,18 @@
 #include "qemu/error-report.h"
 
 /* #define DEBUG_S390PCI_BUS */
-#ifdef DEBUG_S390PCI_BUS
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
+
+#ifndef DEBUG_S390PCI_BUS
+#define DEBUG_S390PCI_BUS  0
 #endif
 
+#define DPRINTF(fmt, ...)                                         \
+    do {                                                          \
+        if (DEBUG_S390PCI_BUS) {                                  \
+            fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); \
+        }                                                         \
+    } while (0)
+
 S390pciState *s390_get_phb(void)
 {
     static S390pciState *phb;
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index d2a8c0a083..763eebd67f 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -21,14 +21,18 @@
 #include "sysemu/hw_accel.h"
 
 /* #define DEBUG_S390PCI_INST */
-#ifdef DEBUG_S390PCI_INST
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "s390pci-inst: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
+
+#ifndef DEBUG_S390PCI_INST
+#define DEBUG_S390PCI_INST  0
 #endif
 
+#define DPRINTF(fmt, ...)                                          \
+    do {                                                           \
+        if (DEBUG_S390PCI_INST) {                                  \
+            fprintf(stderr, "s390pci-inst: " fmt, ## __VA_ARGS__); \
+        }                                                          \
+    } while (0)
+
 static void s390_set_status_code(CPUS390XState *env,
                                  uint8_t r, uint64_t status_code)
 {
-- 
2.11.0
