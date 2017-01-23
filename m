Received: from eggs.gnu.org ([2001:4830:134:3::10]:38178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo1v-0003HK-5s
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo1u-0005zO-8T
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cVo1u-0005z1-0C
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:06 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jan 2017 21:27:30 -0200
Message-Id: <20170123232738.20796-6-ehabkost@redhat.com>
In-Reply-To: <20170123232738.20796-1-ehabkost@redhat.com>
References: <20170123232738.20796-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 05/13] arch_init: Remove unnecessary
 default_config_files table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The existing default_config_files table in arch_init.c has a
single entry, making it completely unnecessary. The whole code
can be replaced by a single qemu_read_config_file() call in vl.c.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170117180051.11958-1-ehabkost@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 6c4e287d57..c316ae1023 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -83,33 +83,6 @@ int graphic_depth = 32;
 
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
index ed1cbe9c73..abb0900fe4 100644
--- a/vl.c
+++ b/vl.c
@@ -2950,6 +2950,18 @@ static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
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
@@ -3077,10 +3089,8 @@ int main(int argc, char **argv, char **envp)
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
