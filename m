Received: from eggs.gnu.org ([2001:4830:134:3::10]:47791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJC5-0003vH-Qt
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJC4-0007nG-Po
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:35:53 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJC4-0007mz-K8
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:35:52 -0400
Received: by mail-oi0-x241.google.com with SMTP id d2so5824630oig.2
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:35:52 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:35:51 +0300
Message-ID: <CA+KKJYBMk15mHZ3jNYVAwRmDy6Z65-5Jf__sDE6=FFZLwXx3Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 05/43] xen-mapcache: made printf always compile
 in debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony.perard@citrix.com

>From 0e4a8a20c9c05e547d42be1b9ef868d12e7b43a9 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 02:14:06 +0300
Subject: [PATCH 05/43] xen-mapcache: made printf always compile in debug
 output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 xen-mapcache.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/xen-mapcache.c b/xen-mapcache.c
index 1a96d2e..c2d1e6f 100644
--- a/xen-mapcache.c
+++ b/xen-mapcache.c
@@ -22,15 +22,15 @@
 #include "trace-root.h"


-//#define MAPCACHE_DEBUG
-
-#ifdef MAPCACHE_DEBUG
-#  define DPRINTF(fmt, ...) do { \
-    fprintf(stderr, "xen_mapcache: " fmt, ## __VA_ARGS__); \
-} while (0)
-#else
-#  define DPRINTF(fmt, ...) do { } while (0)
-#endif
+#ifndef MAPCACHE_DEBUG
+#define MAPCACHE_DEBUG 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                 \
+    if (MAPCACHE_DEBUG) {                                      \
+        fprintf(stderr, "xen_mapcache: " fmt, ## __VA_ARGS__); \
+    }                                                          \
+} while (0);

 #if HOST_LONG_BITS == 32
 #  define MCACHE_BUCKET_SHIFT 16
-- 
2.8.0.rc3
