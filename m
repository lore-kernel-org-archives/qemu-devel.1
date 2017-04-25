Received: from eggs.gnu.org ([2001:4830:134:3::10]:55240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aM-0007Ak-SS
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aL-0005Ff-T0
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38aL-0005Ey-JL
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 906408004A
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:24 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:25 +0200
Message-Id: <20170425220451.6028-16-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 15/41] migration: Create include for migration
 snapshots
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

Start removing migration code from sysemu/sysemu.h.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                        |  1 +
 include/migration/snapshot.h | 20 ++++++++++++++++++++
 include/sysemu/sysemu.h      |  3 ---
 migration/savevm.c           |  1 +
 replay/replay-snapshot.c     |  1 +
 vl.c                         |  1 +
 6 files changed, 24 insertions(+), 3 deletions(-)
 create mode 100644 include/migration/snapshot.h

diff --git a/hmp.c b/hmp.c
index d81f71e..235cc2a 100644
--- a/hmp.c
+++ b/hmp.c
@@ -39,6 +39,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "hw/intc/intc.h"
+#include "migration/snapshot.h"
 
 #ifdef CONFIG_SPICE
 #include <spice/enums.h>
diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
new file mode 100644
index 0000000..a390fea
--- /dev/null
+++ b/include/migration/snapshot.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU save vm functions
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
+#ifndef QEMU_MIGRATION_SAVEVM_H
+#define QEMU_MIGRATION_SAVEVM_H
+
+int save_vmstate(const char *name, Error **errp);
+int load_vmstate(const char *name, Error **errp);
+
+#endif
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 3340202..0d496d3 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -75,9 +75,6 @@ void qemu_remove_exit_notifier(Notifier *notify);
 void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
-int save_vmstate(const char *name, Error **errp);
-int load_vmstate(const char *name, Error **errp);
-
 void qemu_announce_self(void);
 
 /* Subcommands for QEMU_VM_COMMAND */
diff --git a/migration/savevm.c b/migration/savevm.c
index 1b2a83c..2f76a8a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -36,6 +36,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/timer.h"
 #include "migration/migration.h"
+#include "migration/snapshot.h"
 #include "qemu-file-channel.h"
 #include "postcopy-ram.h"
 #include "qapi/qmp/qerror.h"
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index fdc4353..86ae8dd 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -19,6 +19,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qemu/error-report.h"
 #include "migration/vmstate.h"
+#include "migration/snapshot.h"
 
 static void replay_pre_save(void *opaque)
 {
diff --git a/vl.c b/vl.c
index 8b3ec2e..53a9d19 100644
--- a/vl.c
+++ b/vl.c
@@ -87,6 +87,7 @@ int main(int argc, char **argv)
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
 #include "migration/block.h"
+#include "migration/snapshot.h"
 #include "sysemu/tpm.h"
 #include "sysemu/dma.h"
 #include "audio/audio.h"
-- 
2.9.3
