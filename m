Received: from eggs.gnu.org ([2001:4830:134:3::10]:57687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPCC-0001Eb-1R
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPCB-00073j-54
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBPCA-00072I-TI
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E90318047A
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 17:26:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 19:25:43 +0200
Message-Id: <20170518172543.32694-12-quintela@redhat.com>
In-Reply-To: <20170518172543.32694-1-quintela@redhat.com>
References: <20170518172543.32694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 11/11] migration: Move
 include/migration/block.h into migration/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

All functions were internal, except blk_mig_init() that is exported in
misc.h now.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/misc.h                 | 8 ++++++++
 migration/block.c                        | 3 ++-
 {include/migration => migration}/block.h | 2 --
 migration/colo.c                         | 2 +-
 migration/migration.c                    | 2 +-
 vl.c                                     | 1 -
 6 files changed, 12 insertions(+), 6 deletions(-)
 rename {include/migration => migration}/block.h (93%)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 0b37714..d7892b7 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -18,4 +18,12 @@
 
 void ram_mig_init(void);
 
+/* migration/block.c */
+
+#ifdef CONFIG_LIVE_BLOCK_MIGRATION
+void blk_mig_init(void);
+#else
+static inline void blk_mig_init(void) {}
+#endif
+
 #endif
diff --git a/migration/block.c b/migration/block.c
index 3e27499..4d8c2e9 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -23,7 +23,8 @@
 #include "qemu/cutils.h"
 #include "qemu/queue.h"
 #include "qemu/timer.h"
-#include "migration/block.h"
+#include "block.h"
+#include "migration/misc.h"
 #include "migration/migration.h"
 #include "sysemu/blockdev.h"
 #include "qemu-file.h"
diff --git a/include/migration/block.h b/migration/block.h
similarity index 93%
rename from include/migration/block.h
rename to migration/block.h
index 28cff53..22ebe94 100644
--- a/include/migration/block.h
+++ b/migration/block.h
@@ -15,14 +15,12 @@
 #define MIGRATION_BLOCK_H
 
 #ifdef CONFIG_LIVE_BLOCK_MIGRATION
-void blk_mig_init(void);
 int blk_mig_active(void);
 uint64_t blk_mig_bytes_transferred(void);
 uint64_t blk_mig_bytes_remaining(void);
 uint64_t blk_mig_bytes_total(void);
 
 #else
-static inline void blk_mig_init(void) { }
 static inline int blk_mig_active(void)
 {
     return false;
diff --git a/migration/colo.c b/migration/colo.c
index 5be4656..f6a54d1 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -18,7 +18,7 @@
 #include "qemu-file.h"
 #include "savevm.h"
 #include "migration/colo.h"
-#include "migration/block.h"
+#include "block.h"
 #include "io/channel-buffer.h"
 #include "trace.h"
 #include "qemu/error-report.h"
diff --git a/migration/migration.c b/migration/migration.c
index ffad8e5..bb4be78 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -34,7 +34,7 @@
 #include "qapi/util.h"
 #include "qemu/sockets.h"
 #include "qemu/rcu.h"
-#include "migration/block.h"
+#include "block.h"
 #include "postcopy-ram.h"
 #include "qemu/thread.h"
 #include "qmp-commands.h"
diff --git a/vl.c b/vl.c
index 5b09937..ae90c4f 100644
--- a/vl.c
+++ b/vl.c
@@ -86,7 +86,6 @@ int main(int argc, char **argv)
 #include "qemu/log.h"
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
-#include "migration/block.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
 #include "sysemu/tpm.h"
-- 
2.9.3
