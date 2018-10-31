Received: from eggs.gnu.org ([2001:4830:134:3::10]:60407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfUx-0000bU-BC
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfUv-0002Kb-Le
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:42 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729]:44838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHfUv-0002KD-GN
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:41 -0400
Received: by mail-qk1-x729.google.com with SMTP id n12so8565530qkh.11
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 18:40:41 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 20:38:18 -0500
Message-Id: <20181031013821.24023-22-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
References: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v2 21/24] qga: add --retry-path option for
 re-initializing channel on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This adds an option to instruct the agent to periodically attempt
re-opening the communication channel after a channel error has
occurred. The main use-case for this is providing an OS-independent
way of allowing the agent to survive situations like hotplug/unplug of
the communication channel, or initial guest set up where the agent may
be installed/started prior to the installation of the channel device's
driver.

There are nicer ways of implementing this functionality via things
like systemd services, but this option is useful for platforms like
*BSD/w32.

Currently a channel error will result in the GSource for that channel
being removed from the GMainLoop, but the main loop continuing to run.
That behavior results in a dead loop when --retry-path isn't set, and
prevents us from knowing when to attempt re-opening the channel when
it is set, so we also force the loop to exit as part of this patch.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/main.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 761007deb4..506a314140 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -58,6 +58,7 @@
 #endif
 #define QGA_SENTINEL_BYTE 0xFF
 #define QGA_CONF_DEFAULT CONFIG_QEMU_CONFDIR G_DIR_SEPARATOR_S "qemu-ga.conf"
+#define QGA_RETRY_INTERVAL 5
 
 static struct {
     const char *state_dir;
@@ -98,6 +99,7 @@ struct GAState {
     GAPersistentState pstate;
     GAConfig *config;
     int socket_activation;
+    bool force_exit;
 };
 
 struct GAState *ga_state;
@@ -120,6 +122,7 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
 VOID WINAPI service_main(DWORD argc, TCHAR *argv[]);
 #endif
 static int run_agent(GAState *s);
+static void stop_agent(GAState *s, bool requested);
 
 static void
 init_dfl_pathnames(void)
@@ -168,9 +171,7 @@ static void quit_handler(int sig)
     }
     g_debug("received signal num %d, quitting", sig);
 
-    if (g_main_loop_is_running(ga_state->main_loop)) {
-        g_main_loop_quit(ga_state->main_loop);
-    }
+    stop_agent(ga_state, true);
 }
 
 #ifndef _WIN32
@@ -255,6 +256,10 @@ QEMU_COPYRIGHT "\n"
 "                    to list available RPCs)\n"
 "  -D, --dump-conf   dump a qemu-ga config file based on current config\n"
 "                    options / command-line parameters to stdout\n"
+"  -r, --retry-path  attempt re-opening path if it's unavailable or closed\n"
+"                    due to an error which may be recoverable in the future\n"
+"                    (virtio-serial driver re-install, serial device hot\n"
+"                    plug/unplug, etc.)\n"
 "  -h, --help        display this help and exit\n"
 "\n"
 QEMU_HELP_BOTTOM "\n"
@@ -614,6 +619,7 @@ static gboolean channel_event_cb(GIOCondition condition, gpointer data)
     switch (status) {
     case G_IO_STATUS_ERROR:
         g_warning("error reading channel");
+        stop_agent(s, false);
         return false;
     case G_IO_STATUS_NORMAL:
         buf[count] = 0;
@@ -927,6 +933,7 @@ struct GAConfig {
     int daemonize;
     GLogLevelFlags log_level;
     int dumpconf;
+    bool retry_path;
 };
 
 static void config_load(GAConfig *config)
@@ -976,6 +983,10 @@ static void config_load(GAConfig *config)
         /* enable all log levels */
         config->log_level = G_LOG_LEVEL_MASK;
     }
+    if (g_key_file_has_key(keyfile, "general", "retry-path", NULL)) {
+        config->retry_path =
+            g_key_file_get_boolean(keyfile, "general", "retry-path", &gerr);
+    }
     if (g_key_file_has_key(keyfile, "general", "blacklist", NULL)) {
         config->bliststr =
             g_key_file_get_string(keyfile, "general", "blacklist", &gerr);
@@ -1037,6 +1048,8 @@ static void config_dump(GAConfig *config)
     g_key_file_set_string(keyfile, "general", "statedir", config->state_dir);
     g_key_file_set_boolean(keyfile, "general", "verbose",
                            config->log_level == G_LOG_LEVEL_MASK);
+    g_key_file_set_boolean(keyfile, "general", "retry-path",
+                           config->retry_path);
     tmp = list_join(config->blacklist, ',');
     g_key_file_set_string(keyfile, "general", "blacklist", tmp);
     g_free(tmp);
@@ -1055,7 +1068,7 @@ static void config_dump(GAConfig *config)
 
 static void config_parse(GAConfig *config, int argc, char **argv)
 {
-    const char *sopt = "hVvdm:p:l:f:F::b:s:t:D";
+    const char *sopt = "hVvdm:p:l:f:F::b:s:t:Dr";
     int opt_ind = 0, ch;
     const struct option lopt[] = {
         { "help", 0, NULL, 'h' },
@@ -1075,6 +1088,7 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         { "service", 1, NULL, 's' },
 #endif
         { "statedir", 1, NULL, 't' },
+        { "retry-path", 0, NULL, 'r' },
         { NULL, 0, NULL, 0 }
     };
 
@@ -1119,6 +1133,9 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         case 'D':
             config->dumpconf = 1;
             break;
+        case 'r':
+            config->retry_path = true;
+            break;
         case 'b': {
             if (is_help_option(optarg)) {
                 qmp_for_each_command(&ga_commands, ga_print_cmd, NULL);
@@ -1322,9 +1339,6 @@ static void cleanup_agent(GAState *s)
         ga_command_state_free(s->command_state);
         json_message_parser_destroy(&s->parser);
     }
-    if (s->channel) {
-        ga_channel_free(s->channel);
-    }
     g_free(s->pstate_filepath);
     g_free(s->state_filepath_isfrozen);
     if (s->main_loop) {
@@ -1334,7 +1348,7 @@ static void cleanup_agent(GAState *s)
     ga_state = NULL;
 }
 
-static int run_agent(GAState *s)
+static int run_agent_once(GAState *s)
 {
     if (!channel_init(s, s->config->method, s->config->channel_path,
                       s->socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {
@@ -1344,9 +1358,41 @@ static int run_agent(GAState *s)
 
     g_main_loop_run(ga_state->main_loop);
 
+    if (s->channel) {
+        ga_channel_free(s->channel);
+    }
+
     return EXIT_SUCCESS;
 }
 
+static int run_agent(GAState *s)
+{
+    int ret = EXIT_SUCCESS;
+
+    s->force_exit = false;
+
+    do {
+        ret = run_agent_once(s);
+        if (s->config->retry_path && !s->force_exit) {
+            g_warning("agent stopped unexpectedly, restarting...");
+            sleep(QGA_RETRY_INTERVAL);
+        }
+    } while (s->config->retry_path && !s->force_exit);
+
+    return ret;
+}
+
+static void stop_agent(GAState *s, bool requested)
+{
+    if (!s->force_exit) {
+        s->force_exit = requested;
+    }
+
+    if (g_main_loop_is_running(s->main_loop)) {
+        g_main_loop_quit(s->main_loop);
+    }
+}
+
 int main(int argc, char **argv)
 {
     int ret = EXIT_SUCCESS;
-- 
2.17.1
