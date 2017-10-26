Received: from eggs.gnu.org ([2001:4830:134:3::10]:54788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rcT-0000hS-QC
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rcP-0005QY-Qq
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7rcP-0005Pa-HH
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:21 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9QNU5Wx006108
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:31:17 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dur20bfyb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:31:16 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 17:31:15 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 18:30:49 -0500
In-Reply-To: <20171026233054.21133-1-mdroth@linux.vnet.ibm.com>
References: <20171026233054.21133-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171026233054.21133-2-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/6] qga: group agent init/cleanup init
 separate routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sameeh@daynix.com, yan@daynix.com, daniel@daynix.com

This patch better separates the init/cleanup routines out into
separate functions to make make the start-up procedure a bit easier
to follow. This will be useful when we eventually break out the
actual start/stop of the agent's main loop into separates routines
that can be called multiple times after the init phase.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/main.c | 82 ++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 62a62755bd..73aa9ac507 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1250,9 +1250,21 @@ static bool check_is_frozen(GAState *s)
     return false;
 }
 
-static int run_agent(GAState *s, GAConfig *config, int socket_activation)
+static GAState *initialize_agent(GAConfig *config)
 {
-    ga_state = s;
+    GAState *s = g_new0(GAState, 1);
+
+    g_assert_null(ga_state);
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
@@ -1268,7 +1280,7 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
     if (g_mkdir_with_parents(config->state_dir, S_IRWXU) == -1) {
         g_critical("unable to create (an ancestor of) the state directory"
                    " '%s': %s", config->state_dir, strerror(errno));
-        return EXIT_FAILURE;
+        return NULL;
     }
 #endif
 
@@ -1293,7 +1305,7 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
             if (!log_file) {
                 g_critical("unable to open specified log file: %s",
                            strerror(errno));
-                return EXIT_FAILURE;
+                return NULL;
             }
             s->log_file = log_file;
         }
@@ -1304,7 +1316,7 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
                                s->pstate_filepath,
                                ga_is_frozen(s))) {
         g_critical("failed to load persistent state");
-        return EXIT_FAILURE;
+        return NULL;
     }
 
     config->blacklist = ga_command_blacklist_init(config->blacklist);
@@ -1325,12 +1337,37 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
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
@@ -1354,7 +1391,7 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
 int main(int argc, char **argv)
 {
     int ret = EXIT_SUCCESS;
-    GAState *s = g_new0(GAState, 1);
+    GAState *s;
     GAConfig *config = g_new0(GAConfig, 1);
     int socket_activation;
 
@@ -1422,44 +1459,25 @@ int main(int argc, char **argv)
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
2.11.0
