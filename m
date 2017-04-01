Received: from eggs.gnu.org ([2001:4830:134:3::10]:49785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJKZ-0007Tz-CW
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJKY-0006zB-2D
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:44:39 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJKX-0006z3-TP
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:44:37 -0400
Received: by mail-oi0-x243.google.com with SMTP id t11so13194278oib.1
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:44:37 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:44:36 +0300
Message-ID: <CA+KKJYD3duCUjOuYH-fsH1HTUkGLugF6-YX0L1+Kdd9z-sVYqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 09/43] ppc: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, agraf@suse.de, david@gibson.dropbear.id.au

>From 236c82fee189c22b88313fda71816e486edab8a6 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:23:58 +0300
Subject: [PATCH 09/43] ppc: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 target/ppc/kvm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9f1f132..5425055 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -50,15 +50,15 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #endif

-//#define DEBUG_KVM
-
-#ifdef DEBUG_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_KVM
+#define DEBUG_KVM 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                \
+    if (DEBUG_KVM) {                         \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);

 #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"

-- 
2.8.0.rc3
