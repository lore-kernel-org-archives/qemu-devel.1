Received: from eggs.gnu.org ([2001:4830:134:3::10]:53257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTY5G-00073l-8a
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTY5C-00047o-El
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:02:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTY5C-00047h-9A
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:02:10 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46712C056790
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:02:09 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 17 Jan 2017 16:00:51 -0200
Message-Id: <20170117180051.11958-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] arch_init: Remove unnecessary
 default_config_files table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The existing default_config_files table in arch_init.c has a
single entry, making it completely unnecessary. The whole code
can be replaced by a single qemu_read_config_file() call in vl.c.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qemu/config-file.h |  4 ----
 arch_init.c                | 27 ---------------------------
 vl.c                       | 18 ++++++++++++++----
 3 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/include/qemu/config-file.h b/include/qemu/config-file.h
index 8d4b2b6d94..c80d5c8a33 100644
--- a/include/qemu/config-file.h
+++ b/include/qemu/config-file.h
@@ -23,8 +23,4 @@ int qemu_read_config_file(const char *filename);
 void qemu_config_parse_qdict(QDict *options, QemuOptsList **lists,
                              Error **errp);
 
-/* Read default QEMU config files
- */
-int qemu_read_default_config_files(bool userconfig);
-
 #endif /* QEMU_CONFIG_FILE_H */
diff --git a/arch_init.c b/arch_init.c
index 5cc58b2c35..e9b6d62d18 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -84,33 +84,6 @@ int graphic_depth = 32;
 
 const uint32_t arch_type = QEMU_ARCH;
 
-static struct defconfig_file {
-    const char *filename;
-    /* Indicates it is an user config file (disabled by -no-user-config) */
-    bool userconfig;
-} default_config_files[] = {
-    { CONFIG_QEMU_CONFDIR "/qemu.conf",                   true },
-    { NULL }, /* end of list */
-};
-
-int qemu_read_default_config_files(bool userconfig)
-{
-    int ret;
-    struct defconfig_file *f;
-
-    for (f = default_config_files; f->filename; f++) {
-        if (!userconfig && f->userconfig) {
-            continue;
-        }
-        ret = qemu_read_config_file(f->filename);
-        if (ret < 0 && ret != -ENOENT) {
-            return ret;
-        }
-    }
-
-    return 0;
-}
-
 struct soundhw {
     const char *name;
     const char *descr;
diff --git a/vl.c b/vl.c
index c643d3ff3a..b563f9b924 100644
--- a/vl.c
+++ b/vl.c
@@ -2990,6 +2990,18 @@ static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
+static int qemu_read_default_config_file(void)
+{
+    int ret;
+
+    ret = qemu_read_config_file(CONFIG_QEMU_CONFDIR "/qemu.conf");
+    if (ret < 0 && ret != -ENOENT) {
+        return ret;
+    }
+
+    return 0;
+}
+
 int main(int argc, char **argv, char **envp)
 {
     int i;
@@ -3117,10 +3129,8 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
-    if (defconfig) {
-        int ret;
-        ret = qemu_read_default_config_files(userconfig);
-        if (ret < 0) {
+    if (defconfig && userconfig) {
+        if (qemu_read_default_config_file() < 0) {
             exit(1);
         }
     }
-- 
2.11.0.259.g40922b1
