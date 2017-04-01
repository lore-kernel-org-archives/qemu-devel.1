Received: from eggs.gnu.org ([2001:4830:134:3::10]:55160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJYT-0007PZ-1k
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJYO-0004ur-PA
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:58:57 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJYO-0004ua-J4
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:58:56 -0400
Received: by mail-oi0-x242.google.com with SMTP id f193so13230618oib.0
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:58:56 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:58:55 +0300
Message-ID: <CA+KKJYDrS0c0GoxctMGG2cg+8C9Jqg_2LoiRVy59J8rnXiZYPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 24/43] migration: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com

>From e5719e802fcd1d1b426d687524ed46f10d044941 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:35:10 +0300
Subject: [PATCH 24/43] migration: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 migration/block.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 7734ff7..a5b4e49 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -42,13 +42,15 @@

 //#define DEBUG_BLK_MIGRATION

-#ifdef DEBUG_BLK_MIGRATION
-#define DPRINTF(fmt, ...) \
-    do { printf("blk_migration: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_BLK_MIGRATION
+#define DEBUG_BLK_MIGRATION 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                  \
+    if (DEBUG_BLK_MIGRATION) {                                  \
+        fprintf(stderr, "blk_migration: " fmt, ## __VA_ARGS__); \
+    }                                                           \
+} while (0);

 typedef struct BlkMigDevState {
     /* Written during setup phase.  Can be read without a lock.  */
-- 
2.8.0.rc3
