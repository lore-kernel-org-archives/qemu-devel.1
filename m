Received: from eggs.gnu.org ([2001:4830:134:3::10]:36473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNijj-0004RE-V9
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNijj-0005E6-6L
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:48:44 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNijj-0005Db-2E
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:48:43 -0400
Received: by mail-qk0-x241.google.com with SMTP id a195-v6so9610533qkg.3
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 10:48:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 29 May 2018 14:48:21 -0300
Message-Id: <20180529174821.19964-5-f4bug@amsat.org>
In-Reply-To: <20180529174821.19964-1-f4bug@amsat.org>
References: <20180529174821.19964-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/4] device_tree: Replace
 error_setg(&error_fatal) by error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Use error_report() + exit() instead of error_setg(&error_fatal),
as suggested by the "qapi/error.h" documentation:

   Please don't error_setg(&error_fatal, ...), use error_report() and
   exit(), because that's more obvious.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.17.0
