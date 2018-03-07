Received: from eggs.gnu.org ([2001:4830:134:3::10]:59714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoK-0004yR-Kb
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoG-0006Dx-S7
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36520 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1etWoG-0006Dc-NL
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F1C0D142B
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:00:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Mar 2018 11:59:59 +0100
Message-Id: <20180307110010.2205-14-quintela@redhat.com>
In-Reply-To: <20180307110010.2205-1-quintela@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 13/24] migration: Introduce
 multifd_recv_new_channel()
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
 migration/migration.c | 3 ++-
 migration/ram.c       | 6 ++++++
 migration/ram.h       | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index c398665de7..919343232e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -448,8 +448,9 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
     if (!mis->from_src_file) {
         QEMUFile *f = qemu_fopen_channel_input(ioc);
         migration_fd_process_incoming(f);
+        return;
     }
-    /* We still only have a single channel.  Nothing to do here yet */
+    multifd_recv_new_channel(ioc);
 }
 
 /**
diff --git a/migration/ram.c b/migration/ram.c
index 977e675f46..f48c74585f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -36,6 +36,7 @@
 #include "xbzrle.h"
 #include "ram.h"
 #include "migration.h"
+#include "socket.h"
 #include "migration/register.h"
 #include "migration/misc.h"
 #include "qemu-file.h"
@@ -624,6 +625,11 @@ int multifd_load_setup(void)
     return 0;
 }
 
+void multifd_recv_new_channel(QIOChannel *ioc)
+{
+    /* nothing to do yet */
+}
+
 /**
  * save_page_header: write page header to wire
  *
diff --git a/migration/ram.h b/migration/ram.h
index 53f0021c51..a2031acf59 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -32,6 +32,7 @@
 #include "qemu-common.h"
 #include "qapi/qapi-types-migration.h"
 #include "exec/cpu-common.h"
+#include "io/channel.h"
 
 extern MigrationStats ram_counters;
 extern XBZRLECacheStats xbzrle_counters;
@@ -44,6 +45,7 @@ int multifd_save_setup(void);
 int multifd_save_cleanup(Error **errp);
 int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
+void multifd_recv_new_channel(QIOChannel *ioc);
 
 uint64_t ram_pagesize_summary(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
-- 
2.14.3
