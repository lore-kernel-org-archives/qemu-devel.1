Received: from eggs.gnu.org ([2001:4830:134:3::10]:55231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rdR-0001eh-MA
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rdN-000664-Pk
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:32:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44098
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7rdN-0005Pj-KM
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:32:21 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9QNTbEa076063
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:31:17 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dunp59cj3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:31:17 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 19:31:16 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 18:30:50 -0500
In-Reply-To: <20171026233054.21133-1-mdroth@linux.vnet.ibm.com>
References: <20171026233054.21133-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171026233054.21133-3-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/6] qga: hang GAConfig/socket_activation off
 of GAState global
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
---
 qga/main.c | 54 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 73aa9ac507..6826cd5f45 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -66,6 +66,25 @@ typedef struct GAPersistentState {
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
@@ -91,6 +110,8 @@ struct GAState {
 #endif
     gchar *pstate_filepath;
     GAPersistentState pstate;
+    GAConfig *config;
+    int socket_activation;
 };
 
 struct GAState *ga_state;
@@ -944,25 +965,6 @@ static GList *split_list(const gchar *str, const gchar *delim)
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
@@ -1250,7 +1252,7 @@ static bool check_is_frozen(GAState *s)
     return false;
 }
 
-static GAState *initialize_agent(GAConfig *config)
+static GAState *initialize_agent(GAConfig *config, int socket_activation)
 {
     GAState *s = g_new0(GAState, 1);
 
@@ -1343,6 +1345,8 @@ static GAState *initialize_agent(GAConfig *config)
 
     s->main_loop = g_main_loop_new(NULL, false);
 
+    s->config = config;
+    s->socket_activation = socket_activation;
     ga_state = s;
     return s;
 }
@@ -1366,10 +1370,10 @@ static void cleanup_agent(GAState *s)
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
@@ -1464,12 +1468,12 @@ int main(int argc, char **argv)
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
2.11.0
