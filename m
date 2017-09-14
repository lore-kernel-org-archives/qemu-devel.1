Received: from eggs.gnu.org ([2001:4830:134:3::10]:55432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dsSXd-00089j-FF
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dsSXY-0005Va-JQ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:42:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43021)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dsSXY-0005UT-92
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:42:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4ABD081DE3
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:42:39 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 14 Sep 2017 13:42:35 +0200
Message-Id: <20170914114236.25343-2-kraxel@redhat.com>
In-Reply-To: <20170914114236.25343-1-kraxel@redhat.com>
References: <20170914114236.25343-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] add qemu_add_data_dir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Add helper function to add a directory to the qemu search path, so we
don't duplicate the checks.  Add a check for duplicate entries, so we
stop trying to open files twice.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/vl.c b/vl.c
index fb1f05b937..37a3401920 100644
--- a/vl.c
+++ b/vl.c
@@ -2272,6 +2272,24 @@ char *qemu_find_file(int type, const char *name)
     return NULL;
 }
 
+static void qemu_add_data_dir(const char *path)
+{
+    int i;
+
+    if (path == NULL) {
+        return;
+    }
+    if (data_dir_idx == ARRAY_SIZE(data_dir)) {
+        return;
+    }
+    for (i = 0; i < data_dir_idx; i++) {
+        if (strcmp(data_dir[i], path) == 0) {
+            return; /* duplicate */
+        }
+    }
+    data_dir[data_dir_idx++] = path;
+}
+
 static inline bool nonempty_str(const char *str)
 {
     return str && *str;
@@ -3450,8 +3468,8 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_L:
                 if (is_help_option(optarg)) {
                     list_data_dirs = true;
-                } else if (data_dir_idx < ARRAY_SIZE(data_dir)) {
-                    data_dir[data_dir_idx++] = optarg;
+                } else {
+                    qemu_add_data_dir(optarg);
                 }
                 break;
             case QEMU_OPTION_bios:
@@ -4216,16 +4234,10 @@ int main(int argc, char **argv, char **envp)
 
     /* If no data_dir is specified then try to find it relative to the
        executable path.  */
-    if (data_dir_idx < ARRAY_SIZE(data_dir)) {
-        data_dir[data_dir_idx] = os_find_datadir();
-        if (data_dir[data_dir_idx] != NULL) {
-            data_dir_idx++;
-        }
-    }
+    qemu_add_data_dir(os_find_datadir());
+
     /* If all else fails use the install path specified when building. */
-    if (data_dir_idx < ARRAY_SIZE(data_dir)) {
-        data_dir[data_dir_idx++] = CONFIG_QEMU_DATADIR;
-    }
+    qemu_add_data_dir(CONFIG_QEMU_DATADIR);
 
     /* -L help lists the data directories and exits. */
     if (list_data_dirs) {
-- 
2.9.3
