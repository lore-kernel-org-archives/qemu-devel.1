Received: from eggs.gnu.org ([2001:4830:134:3::10]:52549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctwyj-0007HM-IY
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctwyg-0000o5-Vc
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:52:37 -0400
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:39974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ctwyg-0000nm-OU
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:52:34 -0400
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 0E5F23422B
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 15:52:32 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 31 Mar 2017 15:52:23 +0200
Message-ID: <149096834395.26958.7919143982719167728.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.10 PATCH] fsdev: move stub to libqemustub.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

The qemu_fsdev_add() stub is used by targets that don't build VirtFS, like
CRIS for example. This can be handled by libqemustub.a.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/Makefile.objs      |    6 ------
 fsdev/qemu-fsdev-dummy.c |   21 ---------------------
 stubs/Makefile.objs      |    1 +
 stubs/qemu-fsdev-dummy.c |   21 +++++++++++++++++++++
 4 files changed, 22 insertions(+), 27 deletions(-)
 delete mode 100644 fsdev/qemu-fsdev-dummy.c
 create mode 100644 stubs/qemu-fsdev-dummy.c

diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
index 659df6e18767..e2eea86d680a 100644
--- a/fsdev/Makefile.objs
+++ b/fsdev/Makefile.objs
@@ -2,11 +2,5 @@ ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
 # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
 # only pull in the actual virtio-9p device if we also enabled virtio.
 common-obj-y = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
-else
-common-obj-y = qemu-fsdev-dummy.o
 endif
 common-obj-y += qemu-fsdev-opts.o qemu-fsdev-throttle.o
-
-# Toplevel always builds this; targets without virtio will put it in
-# common-obj-y
-common-obj-$(CONFIG_ALL) += qemu-fsdev-dummy.o
diff --git a/fsdev/qemu-fsdev-dummy.c b/fsdev/qemu-fsdev-dummy.c
deleted file mode 100644
index 6dc0fbc4c402..000000000000
--- a/fsdev/qemu-fsdev-dummy.c
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * 9p
- *
- * Copyright IBM, Corp. 2010
- *
- * Authors:
- *  Gautham R Shenoy <ego@in.ibm.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- */
-#include "qemu/osdep.h"
-#include "qemu-fsdev.h"
-#include "qemu/config-file.h"
-#include "qemu/module.h"
-
-int qemu_fsdev_add(QemuOpts *opts)
-{
-    return 0;
-}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 224f04ba6970..f67943da20e9 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -37,3 +37,4 @@ stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += vmgenid.o
+stub-obj-$(CONFIG_VIRTFS) += qemu-fsdev-dummy.o
diff --git a/stubs/qemu-fsdev-dummy.c b/stubs/qemu-fsdev-dummy.c
new file mode 100644
index 000000000000..12f2be21f915
--- /dev/null
+++ b/stubs/qemu-fsdev-dummy.c
@@ -0,0 +1,21 @@
+/*
+ * 9p
+ *
+ * Copyright IBM, Corp. 2010
+ *
+ * Authors:
+ *  Gautham R Shenoy <ego@in.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+#include "qemu/osdep.h"
+#include "fsdev/qemu-fsdev.h"
+#include "qemu/config-file.h"
+#include "qemu/module.h"
+
+int qemu_fsdev_add(QemuOpts *opts)
+{
+    return 0;
+}
