Received: from eggs.gnu.org ([2001:4830:134:3::10]:59572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrW-0004Jc-2B
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrV-0007Bt-2U
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:38 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dcZrU-0007Av-SE
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:36 -0400
Received: by mail-wm0-x242.google.com with SMTP id d40so3781765wma.3
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 09:17:36 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  1 Aug 2017 18:17:13 +0200
Message-Id: <1501604245-33460-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/17] char: don't exit on hmp 'chardev-add help'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

qemu_chr_new_from_opts() is used from both vl.c and hmp,
and it is quite confusing to see qemu suddenly exit after receiving a help
option in hmp.

Do exit(0) from vl.c instead.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-Id: <1500977081-120929-1-git-send-email-anton.nefedov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char.c         |  2 +-
 include/chardev/char.h |  4 +++-
 vl.c                   | 10 ++++++----
 3 files changed, 10 insertions(+), 6 deletions(-)

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
diff --git a/vl.c b/vl.c
index dd803fc..99fcfa0 100644
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
1.8.3.1
