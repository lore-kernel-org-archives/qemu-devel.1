Received: from eggs.gnu.org ([2001:4830:134:3::10]:47045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pW-00052x-3m
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pT-0007OB-8N
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:33 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:40444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bishara@daynix.com>) id 1g96pT-0007N5-1f
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:31 -0400
Received: by mail-wr1-x429.google.com with SMTP id d2-v6so13293486wro.7
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 04:02:30 -0700 (PDT)
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Sun,  7 Oct 2018 14:02:17 +0300
Message-Id: <20181007110223.129692-2-bishara@daynix.com>
In-Reply-To: <20181007110223.129692-1-bishara@daynix.com>
References: <20181007110223.129692-1-bishara@daynix.com>
Subject: [Qemu-devel] [PATCH v2 1/7] qga: group agent init/cleanup init
 separate routines
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

This patch better separates the init/cleanup routines out into
separate functions to make the start-up procedure a bit easier to
follow. This will be useful when we eventually break out the actual
start/stop of the agent's main loop into separates routines that
can be called multiple times after the init phase.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/main.c | 82 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index c399320d3c..fd02086bfc 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1211,9 +1211,21 @@ static bool check_is_frozen(GAState *s)
     return false;
 }
 
-static int run_agent(GAState *s, GAConfig *config, int socket_activation)
+static GAState *initialize_agent(GAConfig *config)
 {
-    ga_state = s;
+    GAState *s = g_new0(GAState, 1);
+
+    g_assert(ga_state == NULL);
+
+    s->log_level = config->log_level;
+    s->log_file = stderr;
+#ifdef CONFIG_FSFREEZE
+    s->fsfreeze_hook = config->fsfreeze_hook;
+#endif
+    s->pstate_filepath = g_strdup_printf("%s/qga.state", config->state_dir);
+    s->state_filepath_isfrozen = g_strdup_printf("%s/qga.state.isfrozen",
+                                                 config->state_dir);
+    s->frozen = check_is_frozen(s);
 
     g_log_set_default_handler(ga_log, s);
     g_log_set_fatal_mask(NULL, G_LOG_LEVEL_ERROR);
@@ -1229,7 +1241,7 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
     if (g_mkdir_with_parents(config->state_dir, S_IRWXU) == -1) {
         g_critical("unable to create (an ancestor of) the state directory"
                    " '%s': %s", config->state_dir, strerror(errno));
-        return EXIT_FAILURE;
+        return NULL;
     }
 #endif
 
@@ -1254,7 +1266,7 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
             if (!log_file) {
                 g_critical("unable to open specified log file: %s",
                            strerror(errno));
-                return EXIT_FAILURE;
+                return NULL;
             }
             s->log_file = log_file;
         }
@@ -1265,7 +1277,7 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
                                s->pstate_filepath,
                                ga_is_frozen(s))) {
         g_critical("failed to load persistent state");
-        return EXIT_FAILURE;
+        return NULL;
     }
 
     config->blacklist = ga_command_blacklist_init(config->blacklist);
@@ -1286,12 +1298,37 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
 #ifndef _WIN32
     if (!register_signal_handlers()) {
         g_critical("failed to register signal handlers");
-        return EXIT_FAILURE;
+        return NULL;
     }
 #endif
 
     s->main_loop = g_main_loop_new(NULL, false);
 
+    ga_state = s;
+    return s;
+}
+
+static void cleanup_agent(GAState *s)
+{
+    if (s->command_state) {
+        ga_command_state_cleanup_all(s->command_state);
+        ga_command_state_free(s->command_state);
+        json_message_parser_destroy(&s->parser);
+    }
+    if (s->channel) {
+        ga_channel_free(s->channel);
+    }
+    g_free(s->pstate_filepath);
+    g_free(s->state_filepath_isfrozen);
+    if (s->main_loop) {
+        g_main_loop_unref(s->main_loop);
+    }
+    g_free(s);
+    ga_state = NULL;
+}
+
+static int run_agent(GAState *s, GAConfig *config, int socket_activation)
+{
     if (!channel_init(ga_state, config->method, config->channel_path,
                       socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {
         g_critical("failed to initialize guest agent channel");
@@ -1315,7 +1352,7 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
 int main(int argc, char **argv)
 {
     int ret = EXIT_SUCCESS;
-    GAState *s = g_new0(GAState, 1);
+    GAState *s;
     GAConfig *config = g_new0(GAConfig, 1);
     int socket_activation;
 
@@ -1383,44 +1420,25 @@ int main(int argc, char **argv)
         }
     }
 
-    s->log_level = config->log_level;
-    s->log_file = stderr;
-#ifdef CONFIG_FSFREEZE
-    s->fsfreeze_hook = config->fsfreeze_hook;
-#endif
-    s->pstate_filepath = g_strdup_printf("%s/qga.state", config->state_dir);
-    s->state_filepath_isfrozen = g_strdup_printf("%s/qga.state.isfrozen",
-                                                 config->state_dir);
-    s->frozen = check_is_frozen(s);
-
     if (config->dumpconf) {
         config_dump(config);
         goto end;
     }
 
+    s = initialize_agent(config);
+    if (!s) {
+        g_critical("error initializing guest agent");
+        goto end;
+    }
     ret = run_agent(s, config, socket_activation);
+    cleanup_agent(s);
 
 end:
-    if (s->command_state) {
-        ga_command_state_cleanup_all(s->command_state);
-        ga_command_state_free(s->command_state);
-        json_message_parser_destroy(&s->parser);
-    }
-    if (s->channel) {
-        ga_channel_free(s->channel);
-    }
-    g_free(s->pstate_filepath);
-    g_free(s->state_filepath_isfrozen);
-
     if (config->daemonize) {
         unlink(config->pid_filepath);
     }
 
     config_free(config);
-    if (s->main_loop) {
-        g_main_loop_unref(s->main_loop);
-    }
-    g_free(s);
 
     return ret;
 }
-- 
2.17.0
