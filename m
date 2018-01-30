Received: from eggs.gnu.org ([2001:4830:134:3::10]:52332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egZt0-0008Jw-VS
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egZsv-0004IT-UO
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:39:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1egZsv-0004EG-JW
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:39:53 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0UHdkQx113103
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 12:39:50 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ftt7wsv8q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 12:39:49 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 30 Jan 2018 17:39:43 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 30 Jan 2018 18:39:30 +0100
In-Reply-To: <20180130173935.5172-1-groug@kaod.org>
References: <20180130173935.5172-1-groug@kaod.org>
Message-Id: <20180130173935.5172-6-groug@kaod.org>
Subject: [Qemu-devel] [PULL 05/10] tests: virtio-9p: use the synth backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

The purpose of virtio-9p-test is to test the virtio-9p device, especially
the 9p server state machine. We don't really care what fsdev backend we're
using. Moreover, if we want to be able to test the flush request or a
device reset with in-flights I/O, it is close to impossible to achieve
with a physical backend because we cannot ask it reliably to put an I/O
on hold at a specific point in time.

Fortunately, we can do that with the synthetic backend, which allows to
register callbacks on read/write accesses to a specific file. This will
be used by a later patch to test the 9P flush request.

The walk request test is converted to using the synth backend.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/9p-synth.c     | 16 ++++++++++++++++
 hw/9pfs/9p-synth.h     |  4 ++++
 tests/virtio-9p-test.c | 22 ++++++----------------
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 8f255e91c00f..dcbd320da17a 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -19,6 +19,7 @@
 #include "qemu/rcu.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/cutils.h"
+#include "sysemu/qtest.h"
 
 /* Root node for synth file system */
 static V9fsSynthNode synth_root = {
@@ -527,6 +528,21 @@ static int synth_init(FsContext *ctx, Error **errp)
 
     /* Mark the subsystem is ready for use */
     synth_fs = 1;
+
+    if (qtest_enabled()) {
+        V9fsSynthNode *node = NULL;
+        int i, ret;
+
+        /* Directory hierarchy for WALK test */
+        for (i = 0; i < P9_MAXWELEM; i++) {
+            char *name = g_strdup_printf(QTEST_V9FS_SYNTH_WALK_FILE, i);
+
+            ret = qemu_v9fs_synth_mkdir(node, 0700, name, &node);
+            assert(!ret);
+            g_free(name);
+        }
+    }
+
     return 0;
 }
 
diff --git a/hw/9pfs/9p-synth.h b/hw/9pfs/9p-synth.h
index 49c2fc7b274e..876b4ef58288 100644
--- a/hw/9pfs/9p-synth.h
+++ b/hw/9pfs/9p-synth.h
@@ -49,4 +49,8 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int mode,
                              const char *name, v9fs_synth_read read,
                              v9fs_synth_write write, void *arg);
 
+/* qtest stuff */
+
+#define QTEST_V9FS_SYNTH_WALK_FILE "WALK%d"
+
 #endif
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index cb086315a36e..652198156731 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -17,6 +17,7 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/9pfs/9p.h"
+#include "hw/9pfs/9p-synth.h"
 
 #define QVIRTIO_9P_TIMEOUT_US (10 * 1000 * 1000)
 
@@ -26,23 +27,19 @@ typedef struct {
     QVirtioDevice *dev;
     QOSState *qs;
     QVirtQueue *vq;
-    char *test_share;
 } QVirtIO9P;
 
 static QVirtIO9P *qvirtio_9p_start(const char *driver)
 {
     const char *arch = qtest_get_arch();
-    const char *cmd = "-fsdev local,id=fsdev0,security_model=none,path=%s "
+    const char *cmd = "-fsdev synth,id=fsdev0 "
                       "-device %s,fsdev=fsdev0,mount_tag=%s";
     QVirtIO9P *v9p = g_new0(QVirtIO9P, 1);
 
-    v9p->test_share = g_strdup("/tmp/qtest.XXXXXX");
-    g_assert_nonnull(mkdtemp(v9p->test_share));
-
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        v9p->qs = qtest_pc_boot(cmd, v9p->test_share, driver, mount_tag);
+        v9p->qs = qtest_pc_boot(cmd, driver, mount_tag);
     } else if (strcmp(arch, "ppc64") == 0) {
-        v9p->qs = qtest_spapr_boot(cmd, v9p->test_share, driver, mount_tag);
+        v9p->qs = qtest_spapr_boot(cmd, driver, mount_tag);
     } else {
         g_printerr("virtio-9p tests are only available on x86 or ppc64\n");
         exit(EXIT_FAILURE);
@@ -54,8 +51,6 @@ static QVirtIO9P *qvirtio_9p_start(const char *driver)
 static void qvirtio_9p_stop(QVirtIO9P *v9p)
 {
     qtest_shutdown(v9p->qs);
-    rmdir(v9p->test_share);
-    g_free(v9p->test_share);
     g_free(v9p);
 }
 
@@ -422,17 +417,14 @@ static void fs_attach(QVirtIO9P *v9p)
 
 static void fs_walk(QVirtIO9P *v9p)
 {
-    char *wnames[P9_MAXWELEM], *paths[P9_MAXWELEM];
-    char *last_path = v9p->test_share;
+    char *wnames[P9_MAXWELEM];
     uint16_t nwqid;
     v9fs_qid *wqid;
     int i;
     P9Req *req;
 
     for (i = 0; i < P9_MAXWELEM; i++) {
-        wnames[i] = g_strdup_printf("%s%d", __func__, i);
-        last_path = paths[i] = g_strdup_printf("%s/%s", last_path, wnames[i]);
-        g_assert(!mkdir(paths[i], 0700));
+        wnames[i] = g_strdup_printf(QTEST_V9FS_SYNTH_WALK_FILE, i);
     }
 
     fs_attach(v9p);
@@ -443,8 +435,6 @@ static void fs_walk(QVirtIO9P *v9p)
     g_assert_cmpint(nwqid, ==, P9_MAXWELEM);
 
     for (i = 0; i < P9_MAXWELEM; i++) {
-        rmdir(paths[P9_MAXWELEM - i - 1]);
-        g_free(paths[P9_MAXWELEM - i - 1]);
         g_free(wnames[i]);
     }
 
-- 
2.13.6
