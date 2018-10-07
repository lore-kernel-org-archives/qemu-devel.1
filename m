Received: from eggs.gnu.org ([2001:4830:134:3::10]:47069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pY-00053j-9L
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pV-0007Oy-UC
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:47038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bishara@daynix.com>) id 1g96pU-0007OI-7w
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id a2-v6so10658508wrc.13
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 04:02:32 -0700 (PDT)
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Sun,  7 Oct 2018 14:02:18 +0300
Message-Id: <20181007110223.129692-3-bishara@daynix.com>
In-Reply-To: <20181007110223.129692-1-bishara@daynix.com>
References: <20181007110223.129692-1-bishara@daynix.com>
Subject: [Qemu-devel] [PATCH v2 2/7] qga: hang GAConfig/socket_activation
 off of GAState global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Sameeh Jubran <sameeh@daynix.com>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

For w32 services we rely on the global GAState to access resources
associated with the agent within service_main(). Currently this is
sufficient for starting the agent since we open the channel once prior
to calling service_main(), and simply start the GMainLoop to start the
agent from within service_main().

Eventually we want to be able to also [re-]open the communication
channel from within service_main(), which requires access to
config/socket_activation variables, so we hang them off GAState in
preparation for that.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
---
 qga/main.c | 54 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index fd02086bfc..9f4dc0b2c5 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -69,6 +69,25 @@ typedef struct GAPersistentState {
     int64_t fd_counter;
 } GAPersistentState;
 
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
 struct GAState {
     JSONMessageParser parser;
     GMainLoop *main_loop;
@@ -94,6 +113,8 @@ struct GAState {
 #endif
     gchar *pstate_filepath;
     GAPersistentState pstate;
+    GAConfig *config;
+    int socket_activation;
 };
 
 struct GAState *ga_state;
@@ -905,25 +926,6 @@ static GList *split_list(const gchar *str, const gchar *delim)
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
@@ -1211,7 +1213,7 @@ static bool check_is_frozen(GAState *s)
     return false;
 }
 
-static GAState *initialize_agent(GAConfig *config)
+static GAState *initialize_agent(GAConfig *config, int socket_activation)
 {
     GAState *s = g_new0(GAState, 1);
 
@@ -1304,6 +1306,8 @@ static GAState *initialize_agent(GAConfig *config)
 
     s->main_loop = g_main_loop_new(NULL, false);
 
+    s->config = config;
+    s->socket_activation = socket_activation;
     ga_state = s;
     return s;
 }
@@ -1327,10 +1331,10 @@ static void cleanup_agent(GAState *s)
     ga_state = NULL;
 }
 
-static int run_agent(GAState *s, GAConfig *config, int socket_activation)
+static int run_agent(GAState *s)
 {
-    if (!channel_init(ga_state, config->method, config->channel_path,
-                      socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {
+    if (!channel_init(s, s->config->method, s->config->channel_path,
+                      s->socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {
         g_critical("failed to initialize guest agent channel");
         return EXIT_FAILURE;
     }
@@ -1425,12 +1429,12 @@ int main(int argc, char **argv)
         goto end;
     }
 
-    s = initialize_agent(config);
+    s = initialize_agent(config, socket_activation);
     if (!s) {
         g_critical("error initializing guest agent");
         goto end;
     }
-    ret = run_agent(s, config, socket_activation);
+    ret = run_agent(s);
     cleanup_agent(s);
 
 end:
-- 
2.17.0
