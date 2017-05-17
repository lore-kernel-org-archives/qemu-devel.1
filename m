Received: from eggs.gnu.org ([2001:4830:134:3::10]:49937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB1Uj-00073T-8m
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB1Uh-000074-Qs
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:08:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dB1Uh-00006y-Hv
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:08:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DABDC23E6D0
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 16:08:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 17 May 2017 18:08:03 +0200
Message-Id: <20170517160804.22245-2-quintela@redhat.com>
In-Reply-To: <20170517160804.22245-1-quintela@redhat.com>
References: <20170517160804.22245-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] exec: Create include for target_page_size()
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

That is the only function that we need from exec.c, and having to
include the whole sysemu.h for this.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 exec.c                     |  1 +
 include/exec/target_page.h | 20 ++++++++++++++++++++
 include/sysemu/sysemu.h    |  1 -
 migration/migration.c      |  1 +
 migration/postcopy-ram.c   |  1 +
 migration/savevm.c         |  1 +
 6 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 include/exec/target_page.h

diff --git a/exec.c b/exec.c
index eac6085..e9a201a 100644
--- a/exec.c
+++ b/exec.c
@@ -24,6 +24,7 @@
 #include "qemu/cutils.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/target_page.h"
 #include "tcg.h"
 #include "hw/qdev-core.h"
 #if !defined(CONFIG_USER_ONLY)
diff --git a/include/exec/target_page.h b/include/exec/target_page.h
new file mode 100644
index 0000000..0961591
--- /dev/null
+++ b/include/exec/target_page.h
@@ -0,0 +1,20 @@
+
+ /*
+ * QEMU exec target page sizes
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
+#ifndef EXEC_TARGET_PAGE_H
+#define EXEC_TARGET_PAGE_H
+
+size_t qemu_target_page_size(void);
+
+#endif
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 765358e..ed8fe3b 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -67,7 +67,6 @@ int qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
 void qemu_system_reset(bool report);
 void qemu_system_guest_panicked(GuestPanicInformation *info);
-size_t qemu_target_page_size(void);
 
 void qemu_add_exit_notifier(Notifier *notify);
 void qemu_remove_exit_notifier(Notifier *notify);
diff --git a/migration/migration.c b/migration/migration.c
index 75a728a..4429a8c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -37,6 +37,7 @@
 #include "qom/cpu.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
+#include "exec/target_page.h"
 #include "io/channel-buffer.h"
 #include "io/channel-tls.h"
 #include "migration/colo.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 64f09e1..82f719a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu-common.h"
+#include "exec/target_page.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
 #include "postcopy-ram.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index 8565103..8763700 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -43,6 +43,7 @@
 #include "qemu/queue.h"
 #include "sysemu/cpus.h"
 #include "exec/memory.h"
+#include "exec/target_page.h"
 #include "qmp-commands.h"
 #include "trace.h"
 #include "qemu/bitops.h"
-- 
2.9.3
