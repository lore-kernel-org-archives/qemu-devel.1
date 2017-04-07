Received: from eggs.gnu.org ([2001:4830:134:3::10]:32856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwUwg-0006um-Q7
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwUwc-00038f-Nd
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:33:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cwUwc-00038T-Fw
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:32:58 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  7 Apr 2017 15:32:54 +0100
Message-Id: <20170407143254.22061-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.10] slirp/smb: Replace constant strings
 by glib string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, berrange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

gcc 7 (on fedora 26) objects to many of the snprintf's
in the smb path and command creation because it can't
figure out that the smb_dir (i.e. the /tmp dir for the configuration)
is known to be short.

Replace all these fixed length buffers by g_str* functions that dynamically
allocate and use g_dir_make_tmp to make the directory.
(It's fairly new glib but we have a compat function for it).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 net/slirp.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index f97ec23345..9f6521190b 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -80,7 +80,7 @@ typedef struct SlirpState {
     Slirp *slirp;
     Notifier exit_notifier;
 #ifndef _WIN32
-    char smb_dir[128];
+    gchar *smb_dir;
 #endif
 } SlirpState;
 
@@ -558,11 +558,10 @@ int net_slirp_redir(const char *redir_str)
 /* automatic user mode samba server configuration */
 static void slirp_smb_cleanup(SlirpState *s)
 {
-    char cmd[128];
     int ret;
 
-    if (s->smb_dir[0] != '\0') {
-        snprintf(cmd, sizeof(cmd), "rm -rf %s", s->smb_dir);
+    if (s->smb_dir) {
+        gchar *cmd = g_strdup_printf("rm -rf %s", s->smb_dir);
         ret = system(cmd);
         if (ret == -1 || !WIFEXITED(ret)) {
             error_report("'%s' failed.", cmd);
@@ -570,15 +569,17 @@ static void slirp_smb_cleanup(SlirpState *s)
             error_report("'%s' failed. Error code: %d",
                          cmd, WEXITSTATUS(ret));
         }
-        s->smb_dir[0] = '\0';
+        g_free(cmd);
+        g_free(s->smb_dir);
+        s->smb_dir = NULL;
     }
 }
 
 static int slirp_smb(SlirpState* s, const char *exported_dir,
                      struct in_addr vserver_addr)
 {
-    char smb_conf[128];
-    char smb_cmdline[128];
+    char *smb_conf;
+    char *smb_cmdline;
     struct passwd *passwd;
     FILE *f;
 
@@ -600,19 +601,19 @@ static int slirp_smb(SlirpState* s, const char *exported_dir,
         return -1;
     }
 
-    snprintf(s->smb_dir, sizeof(s->smb_dir), "/tmp/qemu-smb.XXXXXX");
-    if (!mkdtemp(s->smb_dir)) {
-        error_report("could not create samba server dir '%s'", s->smb_dir);
-        s->smb_dir[0] = 0;
+    s->smb_dir = g_dir_make_tmp("qemu-smb.XXXXXX", NULL);
+    if (!s->smb_dir) {
+        error_report("could not create samba server dir");
         return -1;
     }
-    snprintf(smb_conf, sizeof(smb_conf), "%s/%s", s->smb_dir, "smb.conf");
+    smb_conf = g_strdup_printf("%s/%s", s->smb_dir, "smb.conf");
 
     f = fopen(smb_conf, "w");
     if (!f) {
         slirp_smb_cleanup(s);
         error_report("could not create samba server configuration file '%s'",
                      smb_conf);
+        g_free(smb_conf);
         return -1;
     }
     fprintf(f,
@@ -651,15 +652,18 @@ static int slirp_smb(SlirpState* s, const char *exported_dir,
             );
     fclose(f);
 
-    snprintf(smb_cmdline, sizeof(smb_cmdline), "%s -l %s -s %s",
+    smb_cmdline = g_strdup_printf("%s -l %s -s %s",
              CONFIG_SMBD_COMMAND, s->smb_dir, smb_conf);
+    g_free(smb_conf);
 
     if (slirp_add_exec(s->slirp, 0, smb_cmdline, &vserver_addr, 139) < 0 ||
         slirp_add_exec(s->slirp, 0, smb_cmdline, &vserver_addr, 445) < 0) {
         slirp_smb_cleanup(s);
+        g_free(smb_cmdline);
         error_report("conflicting/invalid smbserver address");
         return -1;
     }
+    g_free(smb_cmdline);
     return 0;
 }
 
-- 
2.12.2
