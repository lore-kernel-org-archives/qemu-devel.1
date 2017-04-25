Received: from eggs.gnu.org ([2001:4830:134:3::10]:55511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38an-0007VT-06
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38ai-0005fJ-UC
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38ai-0005eA-N8
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A95B37E9D4
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:36 +0200
Message-Id: <20170425220451.6028-27-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 26/41] migration: Move
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
 include/migration/misc.h                 | 4 ++++
 migration/block.c                        | 3 ++-
 {include/migration => migration}/block.h | 1 -
 migration/migration.c                    | 2 +-
 vl.c                                     | 1 -
 5 files changed, 7 insertions(+), 4 deletions(-)
 rename {include/migration => migration}/block.h (95%)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 0b37714..9e64c16 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -18,4 +18,8 @@
 
 void ram_mig_init(void);
 
+/* migration/block.c */
+
+void blk_mig_init(void);
+
 #endif
diff --git a/migration/block.c b/migration/block.c
index c26bdb2..d19dc15 100644
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
similarity index 95%
rename from include/migration/block.h
rename to migration/block.h
index 41a1ac8..9f6febb 100644
--- a/include/migration/block.h
+++ b/migration/block.h
@@ -14,7 +14,6 @@
 #ifndef MIGRATION_BLOCK_H
 #define MIGRATION_BLOCK_H
 
-void blk_mig_init(void);
 int blk_mig_active(void);
 uint64_t blk_mig_bytes_transferred(void);
 uint64_t blk_mig_bytes_remaining(void);
diff --git a/migration/migration.c b/migration/migration.c
index 394930d..ff32086 100644
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
index 17c0297..605c98f 100644
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
