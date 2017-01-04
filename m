Received: from eggs.gnu.org ([2001:4830:134:3::10]:45568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cOmzP-00089B-6P
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cOmzM-0005sa-15
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:56:31 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  4 Jan 2017 15:56:24 +0100
Message-Id: <20170104145624.2849-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-img: remove dead check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

options must be non-NULL here, because it has been checked before.
Reported by Coverity.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-img.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 5df66fe..74e3362 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3455,13 +3455,11 @@ static int img_amend(int argc, char **argv)
 
     create_opts = qemu_opts_append(create_opts, bs->drv->create_opts);
     opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);
-    if (options) {
-        qemu_opts_do_parse(opts, options, NULL, &err);
-        if (err) {
-            error_report_err(err);
-            ret = -1;
-            goto out;
-        }
+    qemu_opts_do_parse(opts, options, NULL, &err);
+    if (err) {
+        error_report_err(err);
+        ret = -1;
+        goto out;
     }
 
     /* In case the driver does not call amend_status_cb() */
-- 
2.9.3
