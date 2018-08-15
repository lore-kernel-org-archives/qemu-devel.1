Received: from eggs.gnu.org ([2001:4830:134:3::10]:52278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLk-0004kW-Do
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLe-0001LF-2t
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 15 Aug 2018 14:55:26 +0200
Message-Id: <20180815125537.10651-11-kwolf@redhat.com>
In-Reply-To: <20180815125537.10651-1-kwolf@redhat.com>
References: <20180815125537.10651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/21] block: Remove dead deprecation warning
 code
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

This reinstates commit 6266e900b8083945cb766b45c124fb3c42932cb3,
which was temporarily reverted for the 3.0 release so that libvirt gets
some extra time to update their command lines.

We removed all options from the 'deprecated' array, so the code is dead
and can be removed as well.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 blockdev.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 37eb40670b..72f5347df5 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -775,8 +775,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     const char *filename;
     Error *local_err = NULL;
     int i;
-    const char *deprecated[] = {
-    };
 
     /* Change legacy command line options into QMP ones */
     static const struct {
@@ -853,16 +851,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
         goto fail;
     }
 
-    /* Other deprecated options */
-    if (!qtest_enabled()) {
-        for (i = 0; i < ARRAY_SIZE(deprecated); i++) {
-            if (qemu_opt_get(legacy_opts, deprecated[i]) != NULL) {
-                error_report("'%s' is deprecated, please use the corresponding "
-                             "option of '-device' instead", deprecated[i]);
-            }
-        }
-    }
-
     /* Media type */
     value = qemu_opt_get(legacy_opts, "media");
     if (value) {
-- 
2.13.6
