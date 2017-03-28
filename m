Received: from eggs.gnu.org ([2001:4830:134:3::10]:39857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvJ-0000BX-KK
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvI-0008Lv-DA
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:17 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Mar 2017 10:56:05 +0200
Message-Id: <1490691368-32099-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1490691368-32099-1-git-send-email-armbru@redhat.com>
References: <1490691368-32099-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 for-2.9 07/10] rbd: Clean up
 qemu_rbd_create()'s detour through QemuOpts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

The conversion from QDict to QemuOpts is pointless.  Simply get the
stuff straight from the QDict.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/rbd.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index b2afe07..16ea60a 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -376,7 +376,6 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
     rados_t cluster;
     rados_ioctx_t io_ctx;
     QDict *options = NULL;
-    QemuOpts *rbd_opts = NULL;
     int ret = 0;
 
     secretid = qemu_opt_get(opts, "password-secret");
@@ -407,19 +406,11 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
         goto exit;
     }
 
-    rbd_opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(rbd_opts, options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EINVAL;
-        goto exit;
-    }
-
-    pool       = qemu_opt_get(rbd_opts, "pool");
-    conf       = qemu_opt_get(rbd_opts, "conf");
-    clientname = qemu_opt_get(rbd_opts, "user");
-    name       = qemu_opt_get(rbd_opts, "image");
-    keypairs   = qemu_opt_get(rbd_opts, "=keyvalue-pairs");
+    pool       = qdict_get_try_str(options, "pool");
+    conf       = qdict_get_try_str(options, "conf");
+    clientname = qdict_get_try_str(options, "user");
+    name       = qdict_get_try_str(options, "image");
+    keypairs   = qdict_get_try_str(options, "=keyvalue-pairs");
 
     ret = rados_create(&cluster, clientname);
     if (ret < 0) {
@@ -470,7 +461,6 @@ shutdown:
 
 exit:
     QDECREF(options);
-    qemu_opts_del(rbd_opts);
     return ret;
 }
 
-- 
2.7.4
