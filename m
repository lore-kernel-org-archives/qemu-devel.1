Received: from eggs.gnu.org ([2001:4830:134:3::10]:48138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9D09-0002Mt-B8
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9D08-0004uP-Ix
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d9D08-0004tq-9r
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3205913A60
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:01:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 12 May 2017 18:00:44 +0200
Message-Id: <20170512160055.9081-2-quintela@redhat.com>
In-Reply-To: <20170512160055.9081-1-quintela@redhat.com>
References: <20170512160055.9081-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 01/12] migration: Create migration/xbzrle.h
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  4 ----
 migration/ram.c               |  1 +
 migration/xbzrle.c            |  2 +-
 migration/xbzrle.h            | 21 +++++++++++++++++++++
 tests/test-xbzrle.c           |  2 +-
 5 files changed, 24 insertions(+), 6 deletions(-)
 create mode 100644 migration/xbzrle.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 7ce3a7e..ae181a4 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -270,10 +270,6 @@ bool migrate_zero_blocks(void);
 
 bool migrate_auto_converge(void);
 
-int xbzrle_encode_buffer(uint8_t *old_buf, uint8_t *new_buf, int slen,
-                         uint8_t *dst, int dlen);
-int xbzrle_decode_buffer(uint8_t *src, int slen, uint8_t *dst, int dlen);
-
 int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
 bool migrate_colo_enabled(void);
diff --git a/migration/ram.c b/migration/ram.c
index 76c118c..2564c00 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -35,6 +35,7 @@
 #include "qemu/bitmap.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
+#include "xbzrle.h"
 #include "migration/migration.h"
 #include "postcopy-ram.h"
 #include "exec/address-spaces.h"
diff --git a/migration/xbzrle.c b/migration/xbzrle.c
index c858339..1ba482d 100644
--- a/migration/xbzrle.c
+++ b/migration/xbzrle.c
@@ -12,7 +12,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "include/migration/migration.h"
+#include "xbzrle.h"
 
 /*
   page = zrun nzrun
diff --git a/migration/xbzrle.h b/migration/xbzrle.h
new file mode 100644
index 0000000..a0db507
--- /dev/null
+++ b/migration/xbzrle.h
@@ -0,0 +1,21 @@
+/*
+ * QEMU live migration
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_MIGRATION_XBZRLE_H
+#define QEMU_MIGRATION_XBZRLE_H
+
+int xbzrle_encode_buffer(uint8_t *old_buf, uint8_t *new_buf, int slen,
+                         uint8_t *dst, int dlen);
+
+int xbzrle_decode_buffer(uint8_t *src, int slen, uint8_t *dst, int dlen);
+#endif
diff --git a/tests/test-xbzrle.c b/tests/test-xbzrle.c
index 49f6419..f5e08de 100644
--- a/tests/test-xbzrle.c
+++ b/tests/test-xbzrle.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/cutils.h"
-#include "include/migration/migration.h"
+#include "../migration/xbzrle.h"
 
 #define PAGE_SIZE 4096
 
-- 
2.9.3
