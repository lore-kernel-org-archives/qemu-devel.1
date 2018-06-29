Received: from eggs.gnu.org ([2001:4830:134:3::10]:33744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumi-0007OE-AT
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumg-0006M9-0A
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYumf-00069Y-Ka
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:01 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumU-0004Ur-V6
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:53:50 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:52:55 +0100
Message-Id: <20180629145347.652-4-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/55] device_tree: Replace
 error_setg(&error_fatal) by error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Use error_report() + exit() instead of error_setg(&error_fatal),
as suggested by the "qapi/error.h" documentation:

   Please don't error_setg(&error_fatal, ...), use error_report() and
   exit(), because that's more obvious.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-id: 20180625165749.3910-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 device_tree.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/device_tree.c b/device_tree.c
index 52c3358a558..3553819257b 100644
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
2.17.1
