Received: from eggs.gnu.org ([2001:4830:134:3::10]:40057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dgvIA-0000QQ-HU
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dgvI6-0003lB-Jh
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:59:06 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dgvI6-0003jj-DM
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:59:02 -0400
Received: by mail-wm0-x244.google.com with SMTP id q189so11935383wmd.0
	for <qemu-devel@nongnu.org>; Sun, 13 Aug 2017 08:59:00 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 13 Aug 2017 18:58:48 +0300
Message-Id: <20170813155849.11368-3-sameeh@daynix.com>
In-Reply-To: <20170813155849.11368-1-sameeh@daynix.com>
References: <20170813155849.11368-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH 2/3] qga: main: make qga config and socket
 activation global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Cc: yan@daynix.com

From: Sameeh Jubran <sjubran@redhat.com>

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 qga/main.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 1b381d0..cf312b9 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -92,7 +92,28 @@ struct GAState {
     GAPersistentState pstate;
 };
 
+typedef struct GAConfig {
+    char *channel_path;
+    char *method;
+    char *log_filepath;
+    char *pid_filepath;
+#ifdef CONFIG_FSFREEZE
+    char *fsfreeze_hook;
+#endif
+    char *state_dir;
+#ifdef _WIN32
+    const char *service;
+#endif
+    gchar *bliststr; /* blacklist may point to this string */
+    GList *blacklist;
+    int daemonize;
+    GLogLevelFlags log_level;
+    int dumpconf;
+} GAConfig;
+
 struct GAState *ga_state;
+struct GAConfig *ga_config;
+int ga_socket_activation;
 QmpCommandList ga_commands;
 
 /* commands that are safe to issue while filesystems are frozen */
@@ -942,25 +963,6 @@ static GList *split_list(const gchar *str, const gchar *delim)
     return list;
 }
 
-typedef struct GAConfig {
-    char *channel_path;
-    char *method;
-    char *log_filepath;
-    char *pid_filepath;
-#ifdef CONFIG_FSFREEZE
-    char *fsfreeze_hook;
-#endif
-    char *state_dir;
-#ifdef _WIN32
-    const char *service;
-#endif
-    gchar *bliststr; /* blacklist may point to this string */
-    GList *blacklist;
-    int daemonize;
-    GLogLevelFlags log_level;
-    int dumpconf;
-} GAConfig;
-
 static void config_load(GAConfig *config)
 {
     GError *gerr = NULL;
@@ -1353,7 +1355,7 @@ int main(int argc, char **argv)
 {
     int ret = EXIT_SUCCESS;
     GAState *s = g_new0(GAState, 1);
-    GAConfig *config = g_new0(GAConfig, 1);
+    GAConfig *config = ga_config = g_new0(GAConfig, 1);
     int socket_activation;
 
     config->log_level = G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
@@ -1376,7 +1378,7 @@ int main(int argc, char **argv)
         config->method = g_strdup("virtio-serial");
     }
 
-    socket_activation = check_socket_activation();
+    ga_socket_activation = socket_activation = check_socket_activation();
     if (socket_activation > 1) {
         g_critical("qemu-ga only supports listening on one socket");
         ret = EXIT_FAILURE;
-- 
2.9.4
