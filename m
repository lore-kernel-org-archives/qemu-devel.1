Received: from eggs.gnu.org ([2001:4830:134:3::10]:54807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rcU-0000hW-GK
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rcQ-0005RH-EU
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7rcQ-0005QO-5i
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9QNUPPW136574
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:31:18 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dukyaer6g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:31:18 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 19:31:17 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 18:30:52 -0500
In-Reply-To: <20171026233054.21133-1-mdroth@linux.vnet.ibm.com>
References: <20171026233054.21133-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171026233054.21133-5-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 4/6] qga: add --retry-path option for
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
Cc: sameeh@daynix.com, yan@daynix.com, daniel@daynix.com

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
 qga/main.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 2422ccf2f8..8154e70c3c 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -55,6 +55,7 @@
 #endif
 #define QGA_SENTINEL_BYTE 0xFF
 #define QGA_CONF_DEFAULT CONFIG_QEMU_CONFDIR G_DIR_SEPARATOR_S "qemu-ga.conf"
+#define QGA_RETRY_INTERVAL 5
 
 static struct {
     const char *state_dir;
@@ -83,6 +84,7 @@ typedef struct GAConfig {
     int daemonize;
     GLogLevelFlags log_level;
     int dumpconf;
+    bool retry_path;
 } GAConfig;
 
 struct GAState {
@@ -112,6 +114,7 @@ struct GAState {
     GAPersistentState pstate;
     GAConfig *config;
     int socket_activation;
+    bool force_exit;
 };
 
 struct GAState *ga_state;
@@ -134,6 +137,7 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
 VOID WINAPI service_main(DWORD argc, TCHAR *argv[]);
 #endif
 static int run_agent(GAState *s);
+static void stop_agent(GAState *s, bool requested);
 
 static void
 init_dfl_pathnames(void)
@@ -182,9 +186,7 @@ static void quit_handler(int sig)
     }
     g_debug("received signal num %d, quitting", sig);
 
-    if (g_main_loop_is_running(ga_state->main_loop)) {
-        g_main_loop_quit(ga_state->main_loop);
-    }
+    stop_agent(ga_state, true);
 }
 
 #ifndef _WIN32
@@ -269,6 +271,10 @@ QEMU_COPYRIGHT "\n"
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
@@ -670,6 +676,7 @@ static gboolean channel_event_cb(GIOCondition condition, gpointer data)
     switch (status) {
     case G_IO_STATUS_ERROR:
         g_warning("error reading channel");
+        stop_agent(s, false);
         return false;
     case G_IO_STATUS_NORMAL:
         buf[count] = 0;
@@ -1013,6 +1020,10 @@ static void config_load(GAConfig *config)
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
@@ -1074,6 +1085,8 @@ static void config_dump(GAConfig *config)
     g_key_file_set_string(keyfile, "general", "statedir", config->state_dir);
     g_key_file_set_boolean(keyfile, "general", "verbose",
                            config->log_level == G_LOG_LEVEL_MASK);
+    g_key_file_set_boolean(keyfile, "general", "retry-path",
+                           config->retry_path);
     tmp = list_join(config->blacklist, ',');
     g_key_file_set_string(keyfile, "general", "blacklist", tmp);
     g_free(tmp);
@@ -1092,7 +1105,7 @@ static void config_dump(GAConfig *config)
 
 static void config_parse(GAConfig *config, int argc, char **argv)
 {
-    const char *sopt = "hVvdm:p:l:f:F::b:s:t:D";
+    const char *sopt = "hVvdm:p:l:f:F::b:s:t:Dr";
     int opt_ind = 0, ch;
     const struct option lopt[] = {
         { "help", 0, NULL, 'h' },
@@ -1112,6 +1125,7 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         { "service", 1, NULL, 's' },
 #endif
         { "statedir", 1, NULL, 't' },
+        { "retry-path", 0, NULL, 'r' },
         { NULL, 0, NULL, 0 }
     };
 
@@ -1156,6 +1170,9 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         case 'D':
             config->dumpconf = 1;
             break;
+        case 'r':
+            config->retry_path = true;
+            break;
         case 'b': {
             if (is_help_option(optarg)) {
                 qmp_for_each_command(&ga_commands, ga_print_cmd, NULL);
@@ -1359,9 +1376,6 @@ static void cleanup_agent(GAState *s)
         ga_command_state_free(s->command_state);
         json_message_parser_destroy(&s->parser);
     }
-    if (s->channel) {
-        ga_channel_free(s->channel);
-    }
     g_free(s->pstate_filepath);
     g_free(s->state_filepath_isfrozen);
     if (s->main_loop) {
@@ -1371,7 +1385,7 @@ static void cleanup_agent(GAState *s)
     ga_state = NULL;
 }
 
-static int run_agent(GAState *s)
+static int run_agent_once(GAState *s)
 {
     if (!channel_init(s, s->config->method, s->config->channel_path,
                       s->socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {
@@ -1381,9 +1395,41 @@ static int run_agent(GAState *s)
 
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
2.11.0
