Received: from eggs.gnu.org ([2001:4830:134:3::10]:44380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcund-0005BH-Mt
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunc-0001g2-FX
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:42:51 +0200
Message-Id: <20180710154304.18304-12-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/24] Revert "block: Remove dead deprecation
 warning code"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Cornelia Huck <cohuck@redhat.com>

This reverts commit 6266e900b8083945cb766b45c124fb3c42932cb3.

Some deprecated -drive options were still in use by libvirt, only
fixed with libvirt commit b340c6c614 ("qemu: format serial and geometry
on frontend disk device"), which is not yet in any released version
of libvirt.

So let's hold off removing the deprecated options for one more QEMU
release.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 72f5347df5..37eb40670b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -775,6 +775,8 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     const char *filename;
     Error *local_err = NULL;
     int i;
+    const char *deprecated[] = {
+    };
 
     /* Change legacy command line options into QMP ones */
     static const struct {
@@ -851,6 +853,16 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
         goto fail;
     }
 
+    /* Other deprecated options */
+    if (!qtest_enabled()) {
+        for (i = 0; i < ARRAY_SIZE(deprecated); i++) {
+            if (qemu_opt_get(legacy_opts, deprecated[i]) != NULL) {
+                error_report("'%s' is deprecated, please use the corresponding "
+                             "option of '-device' instead", deprecated[i]);
+            }
+        }
+    }
+
     /* Media type */
     value = qemu_opt_get(legacy_opts, "media");
     if (value) {
-- 
2.13.6
