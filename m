Received: from eggs.gnu.org ([2001:4830:134:3::10]:38876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXUob-00009Z-AN
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXUoa-000723-AG
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:58:09 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXUoa-00071m-3v
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:58:08 -0400
Received: by mail-qt0-x241.google.com with SMTP id b20-v6so3341498qtp.1
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:58:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 25 Jun 2018 13:57:49 -0300
Message-Id: <20180625165749.3910-4-f4bug@amsat.org>
In-Reply-To: <20180625165749.3910-1-f4bug@amsat.org>
References: <20180625165749.3910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 3/3] device_tree: Replace
 error_setg(&error_fatal) by error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>

Use error_report() + exit() instead of error_setg(&error_fatal),
as suggested by the "qapi/error.h" documentation:

   Please don't error_setg(&error_fatal, ...), use error_report() and
   exit(), because that's more obvious.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 device_tree.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/device_tree.c b/device_tree.c
index 52c3358a55..3553819257 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -140,15 +140,16 @@ static void read_fstree(void *fdt, const char *dirname)
     const char *parent_node;
 
     if (strstr(dirname, root_dir) != dirname) {
-        error_setg(&error_fatal, "%s: %s must be searched within %s",
-                   __func__, dirname, root_dir);
+        error_report("%s: %s must be searched within %s",
+                     __func__, dirname, root_dir);
+        exit(1);
     }
     parent_node = &dirname[strlen(SYSFS_DT_BASEDIR)];
 
     d = opendir(dirname);
     if (!d) {
-        error_setg(&error_fatal, "%s cannot open %s", __func__, dirname);
-        return;
+        error_report("%s cannot open %s", __func__, dirname);
+        exit(1);
     }
 
     while ((de = readdir(d)) != NULL) {
@@ -162,7 +163,8 @@ static void read_fstree(void *fdt, const char *dirname)
         tmpnam = g_strdup_printf("%s/%s", dirname, de->d_name);
 
         if (lstat(tmpnam, &st) < 0) {
-            error_setg(&error_fatal, "%s cannot lstat %s", __func__, tmpnam);
+            error_report("%s cannot lstat %s", __func__, tmpnam);
+            exit(1);
         }
 
         if (S_ISREG(st.st_mode)) {
@@ -170,8 +172,9 @@ static void read_fstree(void *fdt, const char *dirname)
             gsize len;
 
             if (!g_file_get_contents(tmpnam, &val, &len, NULL)) {
-                error_setg(&error_fatal, "%s not able to extract info from %s",
-                           __func__, tmpnam);
+                error_report("%s not able to extract info from %s",
+                             __func__, tmpnam);
+                exit(1);
             }
 
             if (strlen(parent_node) > 0) {
@@ -206,9 +209,9 @@ void *load_device_tree_from_sysfs(void)
     host_fdt = create_device_tree(&host_fdt_size);
     read_fstree(host_fdt, SYSFS_DT_BASEDIR);
     if (fdt_check_header(host_fdt)) {
-        error_setg(&error_fatal,
-                   "%s host device tree extracted into memory is invalid",
-                   __func__);
+        error_report("%s host device tree extracted into memory is invalid",
+                     __func__);
+        exit(1);
     }
     return host_fdt;
 }
-- 
2.18.0
