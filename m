Received: from eggs.gnu.org ([2001:4830:134:3::10]:47448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJAa-0002vH-Fh
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJAZ-00074L-FL
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:34:20 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJAZ-000745-AL
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:34:19 -0400
Received: by mail-oi0-x243.google.com with SMTP id b187so13162216oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:34:19 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:34:18 +0300
Message-ID: <CA+KKJYBUqfm4W4sOJyVEzN=AjSSC=xnFYtnNg1=cObyaVn2k7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 04/43] xen-hvm: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony.perard@citrix.com

>From 05d558842b0a10ee3f0606eb54068b6ba03906a3 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 02:13:13 +0300
Subject: [PATCH 04/43] xen-hvm: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 xen-hvm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/xen-hvm.c b/xen-hvm.c
index 5043beb..abf0f72 100644
--- a/xen-hvm.c
+++ b/xen-hvm.c
@@ -29,15 +29,15 @@
 #include <xen/hvm/params.h>
 #include <xen/hvm/e820.h>

-//#define DEBUG_XEN_HVM
-
-#ifdef DEBUG_XEN_HVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "xen: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_XEN_HVM
+#define DEBUG_XEN_HVM 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                        \
+    if (DEBUG_XEN_HVM) {                              \
+        fprintf(stderr, "xen: " fmt, ## __VA_ARGS__); \
+    }                                                 \
+} while (0);

 static MemoryRegion ram_memory, ram_640k, ram_lo, ram_hi;
 static MemoryRegion *framebuffer;
-- 
2.8.0.rc3
