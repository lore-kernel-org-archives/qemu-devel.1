Received: from eggs.gnu.org ([2001:4830:134:3::10]:51049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUK4-0001D5-6q
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUK0-0000lF-PP
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fbUK0-0000kv-HF
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:04 -0400
Received: by mail-wr1-x444.google.com with SMTP id k7-v6so4865155wrq.0
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 10:15:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Jul 2018 19:14:22 +0200
Message-Id: <1530897268-22932-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
References: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] pr-helper: Rework socket path handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>

From: Michal Privoznik <mprivozn@redhat.com>

When reviewing Paolo's pr-helper patches I've noticed couple of
problems:

1) socket_path needs to be calculated at two different places
(one for printing out help, the other if socket activation is NOT
used),

2) even though the default socket_path is allocated in
compute_default_paths() it is the only default path the function
handles. For instance, pidfile is allocated outside of this
function. And yet again, at different places than 1)

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Message-Id: <c791ba035f26ea957e8f3602e3009b621769b1ba.1530611283.git.mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/qemu-pr-helper.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index c89a446..1528a71 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -76,14 +76,12 @@ static int gid = -1;
 
 static void compute_default_paths(void)
 {
-    if (!socket_path) {
-        socket_path = qemu_get_local_state_pathname("run/qemu-pr-helper.sock");
-    }
+    socket_path = qemu_get_local_state_pathname("run/qemu-pr-helper.sock");
+    pidfile = qemu_get_local_state_pathname("run/qemu-pr-helper.pid");
 }
 
 static void usage(const char *name)
 {
-    compute_default_paths();
     (printf) (
 "Usage: %s [OPTIONS] FILE\n"
 "Persistent Reservation helper program for QEMU\n"
@@ -841,19 +839,6 @@ static gboolean accept_client(QIOChannel *ioc, GIOCondition cond, gpointer opaqu
     return TRUE;
 }
 
-
-/*
- * Check socket parameters compatibility when socket activation is used.
- */
-static const char *socket_activation_validate_opts(void)
-{
-    if (socket_path != NULL) {
-        return "Unix socket can't be set when using socket activation";
-    }
-
-    return NULL;
-}
-
 static void termsig_handler(int signum)
 {
     atomic_cmpxchg(&state, RUNNING, TERMINATE);
@@ -927,6 +912,7 @@ int main(int argc, char **argv)
     char *trace_file = NULL;
     bool daemonize = false;
     bool pidfile_specified = false;
+    bool socket_path_specified = false;
     unsigned socket_activation;
 
     struct sigaction sa_sigterm;
@@ -943,12 +929,14 @@ int main(int argc, char **argv)
     qemu_add_opts(&qemu_trace_opts);
     qemu_init_exec_dir(argv[0]);
 
-    pidfile = qemu_get_local_state_pathname("run/qemu-pr-helper.pid");
+    compute_default_paths();
 
     while ((ch = getopt_long(argc, argv, sopt, lopt, &opt_ind)) != -1) {
         switch (ch) {
         case 'k':
-            socket_path = optarg;
+            g_free(socket_path);
+            socket_path = g_strdup(optarg);
+            socket_path_specified = true;
             if (socket_path[0] != '/') {
                 error_report("socket path must be absolute");
                 exit(EXIT_FAILURE);
@@ -1039,10 +1027,9 @@ int main(int argc, char **argv)
     socket_activation = check_socket_activation();
     if (socket_activation == 0) {
         SocketAddress saddr;
-        compute_default_paths();
         saddr = (SocketAddress){
             .type = SOCKET_ADDRESS_TYPE_UNIX,
-            .u.q_unix.path = g_strdup(socket_path)
+            .u.q_unix.path = socket_path,
         };
         server_ioc = qio_channel_socket_new();
         if (qio_channel_socket_listen_sync(server_ioc, &saddr, &local_err) < 0) {
@@ -1050,12 +1037,10 @@ int main(int argc, char **argv)
             error_report_err(local_err);
             return 1;
         }
-        g_free(saddr.u.q_unix.path);
     } else {
         /* Using socket activation - check user didn't use -p etc. */
-        const char *err_msg = socket_activation_validate_opts();
-        if (err_msg != NULL) {
-            error_report("%s", err_msg);
+        if (socket_path_specified) {
+            error_report("Unix socket can't be set when using socket activation");
             exit(EXIT_FAILURE);
         }
 
@@ -1072,7 +1057,6 @@ int main(int argc, char **argv)
                          error_get_pretty(local_err));
             exit(EXIT_FAILURE);
         }
-        socket_path = NULL;
     }
 
     if (qemu_init_main_loop(&local_err)) {
-- 
1.8.3.1
