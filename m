Received: from eggs.gnu.org ([2001:4830:134:3::10]:54941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJXk-0006mF-0B
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJXj-0004ei-3m
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:58:16 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJXi-0004eP-Ur
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:58:15 -0400
Received: by mail-oi0-x243.google.com with SMTP id d2so5877094oig.2
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:58:14 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:58:13 +0300
Message-ID: <CA+KKJYCYcG-Z6R8_v=jwm93t_xd6gdvAO5EE4-1_35_BKagkHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 23/43] page-cahe: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

>From fc02b5cacabab0d1fc547167954abb7447bfef21 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:34:38 +0300
Subject: [PATCH 23/43] page-cahe: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 page_cache.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/page_cache.c b/page_cache.c
index 5f85787..783a9a4 100644
--- a/page_cache.c
+++ b/page_cache.c
@@ -18,13 +18,16 @@
 #include "qemu/host-utils.h"
 #include "migration/page_cache.h"

-#ifdef DEBUG_CACHE
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stdout, "cache: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+
+#ifndef DEBUG_CACHE
+#define DEBUG_CACHE 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                          \
+    if (DEBUG_CACHE) {                                  \
+        fprintf(stderr, "cache: " fmt, ## __VA_ARGS__); \
+    }                                                   \
+} while (0);

 /* the page in cache will not be replaced in two cycles */
 #define CACHED_PAGE_LIFETIME 2
-- 
2.8.0.rc3
