Received: from eggs.gnu.org ([2001:4830:134:3::10]:47095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pa-00055h-GJ
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pY-0007Q7-9O
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:38 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bishara@daynix.com>) id 1g96pW-0007PD-Pc
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:35 -0400
Received: by mail-wr1-x42c.google.com with SMTP id z4-v6so17740351wrb.1
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 04:02:34 -0700 (PDT)
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Sun,  7 Oct 2018 14:02:20 +0300
Message-Id: <20181007110223.129692-5-bishara@daynix.com>
In-Reply-To: <20181007110223.129692-1-bishara@daynix.com>
References: <20181007110223.129692-1-bishara@daynix.com>
Subject: [Qemu-devel] [PATCH v2 4/7] qga: add --retry-path option for
 re-initializing channel on failure
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
index 23a0a46b84..f359499aaa 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -58,6 +58,7 @@
 #endif
 #define QGA_SENTINEL_BYTE 0xFF
 #define QGA_CONF_DEFAULT CONFIG_QEMU_CONFDIR G_DIR_SEPARATOR_S "qemu-ga.conf"
+#define QGA_RETRY_INTERVAL 5
 
 static struct {
     const char *state_dir;
@@ -86,6 +87,7 @@ typedef struct GAConfig {
     int daemonize;
     GLogLevelFlags log_level;
     int dumpconf;
+    bool retry_path;
 } GAConfig;
 
 struct GAState {
@@ -115,6 +117,7 @@ struct GAState {
     GAPersistentState pstate;
     GAConfig *config;
     int socket_activation;
+    bool force_exit;
 };
 
 struct GAState *ga_state;
@@ -137,6 +140,7 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
 VOID WINAPI service_main(DWORD argc, TCHAR *argv[]);
 #endif
 static int run_agent(GAState *s);
+static void stop_agent(GAState *s, bool requested);
 
 static void
 init_dfl_pathnames(void)
@@ -185,9 +189,7 @@ static void quit_handler(int sig)
     }
     g_debug("received signal num %d, quitting", sig);
 
-    if (g_main_loop_is_running(ga_state->main_loop)) {
-        g_main_loop_quit(ga_state->main_loop);
-    }
+    stop_agent(ga_state, true);
 }
 
 #ifndef _WIN32
@@ -272,6 +274,10 @@ QEMU_COPYRIGHT "\n"
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
@@ -631,6 +637,7 @@ static gboolean channel_event_cb(GIOCondition condition, gpointer data)
     switch (status) {
     case G_IO_STATUS_ERROR:
         g_warning("error reading channel");
+        stop_agent(s, false);
         return false;
     case G_IO_STATUS_NORMAL:
         buf[count] = 0;
@@ -974,6 +981,10 @@ static void config_load(GAConfig *config)
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
@@ -1035,6 +1046,8 @@ static void config_dump(GAConfig *config)
     g_key_file_set_string(keyfile, "general", "statedir", config->state_dir);
     g_key_file_set_boolean(keyfile, "general", "verbose",
                            config->log_level == G_LOG_LEVEL_MASK);
+    g_key_file_set_boolean(keyfile, "general", "retry-path",
+                           config->retry_path);
     tmp = list_join(config->blacklist, ',');
     g_key_file_set_string(keyfile, "general", "blacklist", tmp);
     g_free(tmp);
@@ -1053,7 +1066,7 @@ static void config_dump(GAConfig *config)
 
 static void config_parse(GAConfig *config, int argc, char **argv)
 {
-    const char *sopt = "hVvdm:p:l:f:F::b:s:t:D";
+    const char *sopt = "hVvdm:p:l:f:F::b:s:t:Dr";
     int opt_ind = 0, ch;
     const struct option lopt[] = {
         { "help", 0, NULL, 'h' },
@@ -1073,6 +1086,7 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         { "service", 1, NULL, 's' },
 #endif
         { "statedir", 1, NULL, 't' },
+        { "retry-path", 0, NULL, 'r' },
         { NULL, 0, NULL, 0 }
     };
 
@@ -1117,6 +1131,9 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         case 'D':
             config->dumpconf = 1;
             break;
+        case 'r':
+            config->retry_path = true;
+            break;
         case 'b': {
             if (is_help_option(optarg)) {
                 qmp_for_each_command(&ga_commands, ga_print_cmd, NULL);
@@ -1320,9 +1337,6 @@ static void cleanup_agent(GAState *s)
         ga_command_state_free(s->command_state);
         json_message_parser_destroy(&s->parser);
     }
-    if (s->channel) {
-        ga_channel_free(s->channel);
-    }
     g_free(s->pstate_filepath);
     g_free(s->state_filepath_isfrozen);
     if (s->main_loop) {
@@ -1332,7 +1346,7 @@ static void cleanup_agent(GAState *s)
     ga_state = NULL;
 }
 
-static int run_agent(GAState *s)
+static int run_agent_once(GAState *s)
 {
     if (!channel_init(s, s->config->method, s->config->channel_path,
                       s->socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {
@@ -1342,9 +1356,41 @@ static int run_agent(GAState *s)
 
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
2.17.0
