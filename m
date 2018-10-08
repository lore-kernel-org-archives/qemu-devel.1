Received: from eggs.gnu.org ([2001:4830:134:3::10]:41338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNf-0005AV-0T
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNZ-0005lJ-AV
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNY-0005j4-OZ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:37 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:22 +0200
Message-Id: <20181008173125.19678-29-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 28/31] fsdev: Clean up error reporting in
 qemu_fsdev_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

Calling error_report() from within a a function that takes an Error **
argument is suspicious.  qemu_fsdev_add() does that, and its caller
fsdev_init_func() then fails without setting an error.  Its caller
main(), via qemu_opts_foreach(), is fine with it, but clean it up
anyway.

Cc: Greg Kurz <groug@kaod.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 fsdev/qemu-fsdev-dummy.c |  2 +-
 fsdev/qemu-fsdev.c       | 12 +++++-------
 fsdev/qemu-fsdev.h       |  2 +-
 hw/9pfs/xen-9p-backend.c |  7 ++++++-
 vl.c                     |  8 +++-----
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fsdev/qemu-fsdev-dummy.c b/fsdev/qemu-fsdev-dummy.c
index 6dc0fbc4c4..489cd29081 100644
--- a/fsdev/qemu-fsdev-dummy.c
+++ b/fsdev/qemu-fsdev-dummy.c
@@ -15,7 +15,7 @@
 #include "qemu/config-file.h"
 #include "qemu/module.h"
 
-int qemu_fsdev_add(QemuOpts *opts)
+int qemu_fsdev_add(QemuOpts *opts, Error **errp)
 {
     return 0;
 }
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 8a4afbffbd..7a3b87cc9e 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -30,7 +30,7 @@ static FsDriverTable FsDrivers[] = {
     { .name = "proxy", .ops = &proxy_ops},
 };
 
-int qemu_fsdev_add(QemuOpts *opts)
+int qemu_fsdev_add(QemuOpts *opts, Error **errp)
 {
     int i;
     struct FsDriverListEntry *fsle;
@@ -38,10 +38,9 @@ int qemu_fsdev_add(QemuOpts *opts)
     const char *fsdriver = qemu_opt_get(opts, "fsdriver");
     const char *writeout = qemu_opt_get(opts, "writeout");
     bool ro = qemu_opt_get_bool(opts, "readonly", 0);
-    Error *local_err = NULL;
 
     if (!fsdev_id) {
-        error_report("fsdev: No id specified");
+        error_setg(errp, "fsdev: No id specified");
         return -1;
     }
 
@@ -53,11 +52,11 @@ int qemu_fsdev_add(QemuOpts *opts)
         }
 
         if (i == ARRAY_SIZE(FsDrivers)) {
-            error_report("fsdev: fsdriver %s not found", fsdriver);
+            error_setg(errp, "fsdev: fsdriver %s not found", fsdriver);
             return -1;
         }
     } else {
-        error_report("fsdev: No fsdriver specified");
+        error_setg(errp, "fsdev: No fsdriver specified");
         return -1;
     }
 
@@ -76,8 +75,7 @@ int qemu_fsdev_add(QemuOpts *opts)
     }
 
     if (fsle->fse.ops->parse_opts) {
-        if (fsle->fse.ops->parse_opts(opts, &fsle->fse, &local_err)) {
-            error_report_err(local_err);
+        if (fsle->fse.ops->parse_opts(opts, &fsle->fse, errp)) {
             g_free(fsle->fse.fsdev_id);
             g_free(fsle);
             return -1;
diff --git a/fsdev/qemu-fsdev.h b/fsdev/qemu-fsdev.h
index 65e4b1cfab..d9716b4144 100644
--- a/fsdev/qemu-fsdev.h
+++ b/fsdev/qemu-fsdev.h
@@ -38,7 +38,7 @@ typedef struct FsDriverListEntry {
     QTAILQ_ENTRY(FsDriverListEntry) next;
 } FsDriverListEntry;
 
-int qemu_fsdev_add(QemuOpts *opts);
+int qemu_fsdev_add(QemuOpts *opts, Error **errp);
 FsDriverEntry *get_fsdev_fsentry(char *id);
 extern FileOperations local_ops;
 extern FileOperations handle_ops;
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 6026780f95..3f54a21c76 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -14,6 +14,7 @@
 #include "hw/9pfs/9p.h"
 #include "hw/xen/xen_backend.h"
 #include "hw/9pfs/xen-9pfs.h"
+#include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "fsdev/qemu-fsdev.h"
@@ -355,6 +356,7 @@ static int xen_9pfs_free(struct XenDevice *xendev)
 
 static int xen_9pfs_connect(struct XenDevice *xendev)
 {
+    Error *err = NULL;
     int i;
     Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
     V9fsState *s = &xen_9pdev->state;
@@ -452,7 +454,10 @@ static int xen_9pfs_connect(struct XenDevice *xendev)
     qemu_opt_set(fsdev, "path", xen_9pdev->path, NULL);
     qemu_opt_set(fsdev, "security_model", xen_9pdev->security_model, NULL);
     qemu_opts_set_id(fsdev, s->fsconf.fsdev_id);
-    qemu_fsdev_add(fsdev);
+    qemu_fsdev_add(fsdev, &err);
+    if (err) {
+        error_report_err(err);
+    }
     v9fs_device_realize_common(s, &xen_9p_transport, NULL);
 
     return 0;
diff --git a/vl.c b/vl.c
index b6f9212f09..4aa976c4cc 100644
--- a/vl.c
+++ b/vl.c
@@ -2249,7 +2249,7 @@ static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 #ifdef CONFIG_VIRTFS
 static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
-    return qemu_fsdev_add(opts);
+    return qemu_fsdev_add(opts, errp);
 }
 #endif
 
@@ -4188,10 +4188,8 @@ int main(int argc, char **argv, char **envp)
                       chardev_init_func, NULL, &error_fatal);
 
 #ifdef CONFIG_VIRTFS
-    if (qemu_opts_foreach(qemu_find_opts("fsdev"),
-                          fsdev_init_func, NULL, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("fsdev"),
+                      fsdev_init_func, NULL, &error_fatal);
 #endif
 
     if (qemu_opts_foreach(qemu_find_opts("device"),
-- 
2.17.1
