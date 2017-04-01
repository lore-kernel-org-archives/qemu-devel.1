Received: from eggs.gnu.org ([2001:4830:134:3::10]:51222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJO7-00017O-Hq
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJO4-0000o3-If
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:48:19 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJO4-0000nf-Bu
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:48:16 -0400
Received: by mail-oi0-x241.google.com with SMTP id b187so13194757oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:48:16 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:48:15 +0300
Message-ID: <CA+KKJYDx2R0TbFepouc=+d8KpVEwBtH7JDzxu1nCc3Gk9XX94w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 13/43] pci: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, marcel@redhat.com

>From 7ff1463852763cbe7b8260147aa0c19bf91c8cbb Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:27:57 +0300
Subject: [PATCH 13/43] pci: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/pci/msi.c      | 17 +++++++++++------
 hw/pci/pci.c      | 16 +++++++++++-----
 hw/pci/pci_host.c | 16 ++++++++++------
 hw/pci/pcie.c     | 18 ++++++++++++------
 hw/pci/pcie_aer.c | 18 ++++++++++++------
 5 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index a87b227..b7cfa5c 100644
--- a/hw/pci/msi.c
+++ b/hw/pci/msi.c
@@ -72,12 +72,17 @@ static inline uint8_t msi_cap_sizeof(uint16_t flags)

 //#define MSI_DEBUG

-#ifdef MSI_DEBUG
-# define MSI_DPRINTF(fmt, ...)                                          \
-    fprintf(stderr, "%s:%d " fmt, __func__, __LINE__, ## __VA_ARGS__)
-#else
-# define MSI_DPRINTF(fmt, ...)  do { } while (0)
-#endif
+#ifndef MSI_DEBUG
+#define MSI_DEBUG 0
+#endif
+
+#define MSI_DPRINTF(fmt,
...)                                                  \
+    do
{                                                                       \
+        if (MSI_DEBUG)
{                                                       \
+            fprintf(stderr, "%s:%d " fmt, __func__, __LINE__, ##
__VA_ARGS__); \
+
}                                                                      \
+    } while (0)
+
 #define MSI_DEV_PRINTF(dev, fmt, ...)                                   \
     MSI_DPRINTF("%s:%x " fmt, (dev)->name, (dev)->devfn, ## __VA_ARGS__)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e6b08e1..80d08af 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -43,11 +43,17 @@
 #include "qemu/cutils.h"

 //#define DEBUG_PCI
-#ifdef DEBUG_PCI
-# define PCI_DPRINTF(format, ...)       printf(format, ## __VA_ARGS__)
-#else
-# define PCI_DPRINTF(format, ...)       do { } while (0)
-#endif
+//
+#ifndef DEBUG_PCI
+#define DEBUG_PCI 0
+#endif
+
+#define PCI_DPRINTF(fmt, ...)                             \
+    do {                                                  \
+        if (DEBUG_PCI) {                                  \
+            fprintf(stderr, "pci: " fmt, ## __VA_ARGS__); \
+        }                                                 \
+    } while (0)

 static void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent);
 static char *pcibus_get_dev_path(DeviceState *dev);
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 5eaa935..83fde14 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -27,12 +27,16 @@
 /* debug PCI */
 //#define DEBUG_PCI

-#ifdef DEBUG_PCI
-#define PCI_DPRINTF(fmt, ...) \
-do { printf("pci_host_data: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define PCI_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_PCI
+#define DEBUG_PCI 0
+#endif
+
+#define PCI_DPRINTF(fmt, ...)                                       \
+    do {                                                            \
+        if (DEBUG_PCI) {                                            \
+            fprintf(stderr, "pci_host_data: " fmt, ## __VA_ARGS__); \
+        }                                                           \
+    } while (0)

 /*
  * PCI address
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 18e634f..5148f69 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -30,12 +30,18 @@
 #include "qemu/range.h"

 //#define DEBUG_PCIE
-#ifdef DEBUG_PCIE
-# define PCIE_DPRINTF(fmt, ...)                                         \
-    fprintf(stderr, "%s:%d " fmt, __func__, __LINE__, ## __VA_ARGS__)
-#else
-# define PCIE_DPRINTF(fmt, ...) do {} while (0)
-#endif
+
+#ifndef DEBUG_PCIE
+#define DEBUG_PCIE 0
+#endif
+
+#define PCIE_DPRINTF(fmt,
...)                                                 \
+    do
{                                                                       \
+        if (DEBUG_PCIE)
{                                                      \
+            fprintf(stderr, "%s:%d " fmt, __func__, __LINE__, ##
__VA_ARGS__); \
+
}                                                                      \
+    } while (0)
+
 #define PCIE_DEV_PRINTF(dev, fmt, ...)                                  \
     PCIE_DPRINTF("%s:%x "fmt, (dev)->name, (dev)->devfn, ## __VA_ARGS__)

diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index a8c1820..5dfedda 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -32,12 +32,18 @@
 #include "qapi/error.h"

 //#define DEBUG_PCIE
-#ifdef DEBUG_PCIE
-# define PCIE_DPRINTF(fmt, ...)                                         \
-    fprintf(stderr, "%s:%d " fmt, __func__, __LINE__, ## __VA_ARGS__)
-#else
-# define PCIE_DPRINTF(fmt, ...) do {} while (0)
-#endif
+
+#ifndef DEBUG_PCIE
+#define DEBUG_PCIE 0
+#endif
+
+#define PCIE_DPRINTF(fmt,
...)                                                \
+    do
{                                                                      \
+        if (DEBUG_PCIE)
{                                                     \
+            fprintf(stderr, "%s:%d " fmt, __func__, __LINE__, ##
__VA_ARGS__) \
+
}                                                                     \
+    } while (0)
+
 #define PCIE_DEV_PRINTF(dev, fmt, ...)                                  \
     PCIE_DPRINTF("%s:%x "fmt, (dev)->name, (dev)->devfn, ## __VA_ARGS__)

-- 
2.8.0.rc3
