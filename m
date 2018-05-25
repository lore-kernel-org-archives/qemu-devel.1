Received: from eggs.gnu.org ([2001:4830:134:3::10]:32876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fMCq3-0001Sh-8e
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fMCpy-0003Fm-K5
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:32:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40910 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fMCpy-0003FW-Fw
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:32:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2372B401EF25
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 13:32:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 25 May 2018 15:32:45 +0200
Message-Id: <20180525133246.7839-2-quintela@redhat.com>
In-Reply-To: <20180525133246.7839-1-quintela@redhat.com>
References: <20180525133246.7839-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] migration: fix exec/fd migrations
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

Commit:

commit 36c2f8be2c4eb0003ac77a14910842b7ddd7337e
Author: Juan Quintela <quintela@redhat.com>
Date:   Wed Mar 7 08:40:52 2018 +0100

    migration: Delay start of migration main routines

Missed tcp and fd transports.  This fix its.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Tested-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20180523091411.1073-1-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/exec.c | 4 ++++
 migration/fd.c   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/migration/exec.c b/migration/exec.c
index 9d0f82f1f0..0bbeb63c97 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "channel.h"
 #include "exec.h"
+#include "migration.h"
 #include "io/channel-command.h"
 #include "trace.h"
 
@@ -48,6 +49,9 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
 {
     migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
+    if (!migrate_use_multifd()) {
+        migration_incoming_process();
+    }
     return G_SOURCE_REMOVE;
 }
 
diff --git a/migration/fd.c b/migration/fd.c
index 9a380bbbc4..fee34ffdc0 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 #include "channel.h"
 #include "fd.h"
+#include "migration.h"
 #include "monitor/monitor.h"
 #include "io/channel-util.h"
 #include "trace.h"
@@ -48,6 +49,9 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
 {
     migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
+    if (!migrate_use_multifd()) {
+        migration_incoming_process();
+    }
     return G_SOURCE_REMOVE;
 }
 
-- 
2.17.0
