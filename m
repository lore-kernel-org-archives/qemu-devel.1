Received: from eggs.gnu.org ([2001:4830:134:3::10]:49965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dZwi5-0007nW-Bz
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 06:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dZwi2-0000IG-2P
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 06:05:01 -0400
Received: from mail-eopbgr30091.outbound.protection.outlook.com
	([40.107.3.91]:14416
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dZwi1-0000Gx-60
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 06:04:58 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 25 Jul 2017 13:04:41 +0300
Message-Id: <1500977081-120929-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] char: don't exit on hmp 'chardev-add help'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

qemu_chr_new_from_opts() is used from both vl.c and hmp,
and it is quite confusing to see qemu suddenly exit after receiving a help
option in hmp.

Do exit(0) from vl.c instead.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 include/chardev/char.h |  4 +++-
 chardev/char.c         |  2 +-
 vl.c                   | 10 ++++++----
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index 1604ea9..66dde46 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -65,7 +65,9 @@ struct Chardev {
  *
  * @opts see qemu-config.c for a list of valid options
  *
- * Returns: a new character backend
+ * Returns: on success: a new character backend
+ *          otherwise:  NULL; @errp specifies the error
+ *                            or left untouched in case of help option
  */
 Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
                                 Error **errp);
diff --git a/chardev/char.c b/chardev/char.c
index c34b44a..5d283b9 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -620,7 +620,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
 
         error_report("Available chardev backend types: %s", str->str);
         g_string_free(str, true);
-        exit(0);
+        return NULL;
     }
 
     if (id == NULL) {
diff --git a/vl.c b/vl.c
index fb6b2ef..47bfe51 100644
--- a/vl.c
+++ b/vl.c
@@ -2344,10 +2344,12 @@ static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
 
-    qemu_chr_new_from_opts(opts, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        return -1;
+    if (!qemu_chr_new_from_opts(opts, &local_err)) {
+        if (local_err) {
+            error_report_err(local_err);
+            return -1;
+        }
+        exit(0);
     }
     return 0;
 }
-- 
2.7.4
