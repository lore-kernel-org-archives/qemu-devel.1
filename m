Received: from eggs.gnu.org ([2001:4830:134:3::10]:36411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYd37-0002DZ-Hc
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYd36-0000ZC-JT
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:49 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYd36-0000WI-Al
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:48 -0400
Received: by mail-wr0-x243.google.com with SMTP id b8-v6so6658913wro.6
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 12:57:48 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	d102-v6sm12516646wma.10.2018.06.28.12.57.46
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Jun 2018 12:57:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 21:57:36 +0200
Message-Id: <1530215858-1525-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530215858-1525-1-git-send-email-pbonzini@redhat.com>
References: <1530215858-1525-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] pr-manager: put stubs in .c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/scsi/pr-manager.h |  9 ---------
 scsi/Makefile.objs        |  1 +
 scsi/pr-manager-stub.c    | 24 ++++++++++++++++++++++++
 3 files changed, 25 insertions(+), 9 deletions(-)
 create mode 100644 scsi/pr-manager-stub.c

diff --git a/include/scsi/pr-manager.h b/include/scsi/pr-manager.h
index 5d2f13a..71971ae 100644
--- a/include/scsi/pr-manager.h
+++ b/include/scsi/pr-manager.h
@@ -41,15 +41,6 @@ BlockAIOCB *pr_manager_execute(PRManager *pr_mgr,
                                BlockCompletionFunc *complete,
                                void *opaque);
 
-#ifdef CONFIG_LINUX
 PRManager *pr_manager_lookup(const char *id, Error **errp);
-#else
-static inline PRManager *pr_manager_lookup(const char *id, Error **errp)
-{
-    /* The classes do not exist at all!  */
-    error_setg(errp, "No persistent reservation manager with id '%s'", id);
-    return NULL;
-}
-#endif
 
 #endif
diff --git a/scsi/Makefile.objs b/scsi/Makefile.objs
index 4d25e47..bb8789c 100644
--- a/scsi/Makefile.objs
+++ b/scsi/Makefile.objs
@@ -1,3 +1,4 @@
 block-obj-y += utils.o
 
 block-obj-$(CONFIG_LINUX) += pr-manager.o pr-manager-helper.o
+block-obj-$(call lnot,$(CONFIG_LINUX)) += pr-manager-stub.o
diff --git a/scsi/pr-manager-stub.c b/scsi/pr-manager-stub.c
new file mode 100644
index 0000000..632f17c
--- /dev/null
+++ b/scsi/pr-manager-stub.c
@@ -0,0 +1,24 @@
+/*
+ * Persistent reservation manager - stub for non-Linux platforms
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Author: Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This code is licensed under the LGPL.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "scsi/pr-manager.h"
+#include "trace.h"
+#include "qapi/qapi-types-block.h"
+#include "qapi/qapi-commands-block.h"
+
+PRManager *pr_manager_lookup(const char *id, Error **errp)
+{
+    /* The classes do not exist at all!  */
+    error_setg(errp, "No persistent reservation manager with id '%s'", id);
+        return NULL;
+}
-- 
1.8.3.1
