Received: from eggs.gnu.org ([2001:4830:134:3::10]:60325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfUt-0000YM-B9
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfUs-0002HG-8W
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:39 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d]:35448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHfUr-0002EY-BE
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:38 -0400
Received: by mail-qt1-x82d.google.com with SMTP id a10-v6so15979019qtp.2
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 18:40:32 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 20:38:16 -0500
Message-Id: <20181031013821.24023-20-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
References: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v2 19/24] qga: hang GAConfig/socket_activation
 off of GAState global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Sameeh Jubran <sameeh@daynix.com>

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
*dont move GAConfig struct, just the typedef
*fix build bisect for w32
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/main.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index ab3eaa5163..eb31f99b38 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -69,6 +69,8 @@ typedef struct GAPersistentState {
     int64_t fd_counter;
 } GAPersistentState;
 
+typedef struct GAConfig GAConfig;
+
 struct GAState {
     JSONMessageParser parser;
     GMainLoop *main_loop;
@@ -94,6 +96,8 @@ struct GAState {
 #endif
     gchar *pstate_filepath;
     GAPersistentState pstate;
+    GAConfig *config;
+    int socket_activation;
 };
 
 struct GAState *ga_state;
@@ -905,7 +909,7 @@ static GList *split_list(const gchar *str, const gchar *delim)
     return list;
 }
 
-typedef struct GAConfig {
+struct GAConfig {
     char *channel_path;
     char *method;
     char *log_filepath;
@@ -922,7 +926,7 @@ typedef struct GAConfig {
     int daemonize;
     GLogLevelFlags log_level;
     int dumpconf;
-} GAConfig;
+};
 
 static void config_load(GAConfig *config)
 {
@@ -1211,7 +1215,7 @@ static bool check_is_frozen(GAState *s)
     return false;
 }
 
-static GAState *initialize_agent(GAConfig *config)
+static GAState *initialize_agent(GAConfig *config, int socket_activation)
 {
     GAState *s = g_new0(GAState, 1);
 
@@ -1304,6 +1308,8 @@ static GAState *initialize_agent(GAConfig *config)
 
     s->main_loop = g_main_loop_new(NULL, false);
 
+    s->config = config;
+    s->socket_activation = socket_activation;
     ga_state = s;
     return s;
 }
@@ -1327,17 +1333,17 @@ static void cleanup_agent(GAState *s)
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
 #ifndef _WIN32
     g_main_loop_run(ga_state->main_loop);
 #else
-    if (config->daemonize) {
+    if (s->config->daemonize) {
         SERVICE_TABLE_ENTRY service_table[] = {
             { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } };
         StartServiceCtrlDispatcher(service_table);
@@ -1425,12 +1431,12 @@ int main(int argc, char **argv)
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
2.17.1
