Received: from eggs.gnu.org ([2001:4830:134:3::10]:40657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBW-0000zy-IZ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBT-0000dk-9S
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46151
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d1TBT-0000dW-36
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:51 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3L7caVo026826
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:50 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29y02dy31m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:50 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 21 Apr 2017 08:40:48 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 21 Apr 2017 09:40:30 +0200
In-Reply-To: <20170421074038.774-1-cornelia.huck@de.ibm.com>
References: <20170421074038.774-1-cornelia.huck@de.ibm.com>
Message-Id: <20170421074038.774-4-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 03/11] s390x/pci: make printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Danil Antonov <g.danil.anto@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Danil Antonov <g.danil.anto@gmail.com>

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
Message-Id: <CA+KKJYBi31Bs7DtVdzZdwG2t+u5+FGiAhQpd3pqJzUX1O8Cprg@mail.gmail.com>
[CH: remove now misleading comments]
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-pci-bus.c  | 16 +++++++++-------
 hw/s390x/s390-pci-inst.c | 16 +++++++++-------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 69b0291e8a..1570f2d12a 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -23,15 +23,17 @@
 #include "hw/pci/msi.h"
 #include "qemu/error-report.h"
 
-/* #define DEBUG_S390PCI_BUS */
-#ifdef DEBUG_S390PCI_BUS
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
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
index d2a8c0a083..f520ce105f 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -20,15 +20,17 @@
 #include "qemu/error-report.h"
 #include "sysemu/hw_accel.h"
 
-/* #define DEBUG_S390PCI_INST */
-#ifdef DEBUG_S390PCI_INST
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "s390pci-inst: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
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
