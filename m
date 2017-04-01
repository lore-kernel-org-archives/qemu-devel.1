Received: from eggs.gnu.org ([2001:4830:134:3::10]:47042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJ8c-0001jm-Pl
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJ8b-0006Of-Mr
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:32:18 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJ8b-0006OS-HE
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:32:17 -0400
Received: by mail-oi0-x243.google.com with SMTP id f193so13168831oib.0
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:32:17 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:32:16 +0300
Message-ID: <CA+KKJYCFww2wY=QcpkPEv-U8ebaYP6TDBF4871qY1baCrNNgrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 03/43] xen-common: made printf always compile
 in debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, sstabellini@kernel.org

>From 0e3f1f202ebbf14259dee89e523c1fbc6f08d4ed Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 02:12:31 +0300
Subject: [PATCH 03/43] xen-common: made printf always compile in debug
output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 xen-common.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/xen-common.c b/xen-common.c
index fd2c928..9361974 100644
--- a/xen-common.c
+++ b/xen-common.c
@@ -15,15 +15,15 @@
 #include "sysemu/accel.h"
 #include "migration/migration.h"

-//#define DEBUG_XEN
-
-#ifdef DEBUG_XEN
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "xen: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_XEN
+#define DEBUG_XEN 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                        \
+    if (DEBUG_XEN) {                                  \
+        fprintf(stderr, "xen: " fmt, ## __VA_ARGS__); \
+    }                                                 \
+} while (0);

 static int store_dev_info(int domid, Chardev *cs, const char *string)
 {
-- 
2.8.0.rc3
