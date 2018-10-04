Received: from eggs.gnu.org ([2001:4830:134:3::10]:38596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1g822X-0004WV-V5
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1g822T-0005wk-HZ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:33 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:18317)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dcsapak@zita.proxmox.com>)
	id 1g822T-0005U9-5h
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:29 -0400
From: Dominik Csapak <d.csapak@proxmox.com>
Date: Thu,  4 Oct 2018 13:43:11 +0200
Message-Id: <20181004114312.27346-3-d.csapak@proxmox.com>
In-Reply-To: <20181004114312.27346-1-d.csapak@proxmox.com>
References: <20181004114312.27346-1-d.csapak@proxmox.com>
Subject: [Qemu-devel] [PATCH v2 2/3] tap: use qemu_launch_script instead of
 launch_script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sw@weilnetz.de, jasowang@redhat.com, thuth@redhat.com, philmd@redhat.com

Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
---
changes since v1:
* new in v2

 net/tap.c | 56 ++++++++++----------------------------------------------
 1 file changed, 10 insertions(+), 46 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index cc8525f154..15a0dd65b8 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -62,9 +62,6 @@ typedef struct TAPState {
     Notifier exit;
 } TAPState;
 
-static void launch_script(const char *setup_script, const char *ifname,
-                          int fd, Error **errp);
-
 static void tap_send(void *opaque);
 static void tap_writable(void *opaque);
 
@@ -300,7 +297,11 @@ static void tap_exit_notify(Notifier *notifier, void *data)
     Error *err = NULL;
 
     if (s->down_script[0]) {
-        launch_script(s->down_script, s->down_script_arg, s->fd, &err);
+        char *args[3];
+        args[0] = (char *)(s->down_script);
+        args[1] = (char *)(s->down_script_arg);
+        args[2] = NULL;
+        qemu_launch_script(s->down_script, args, s->fd, &err);
         if (err) {
             error_report_err(err);
         }
@@ -397,47 +398,6 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     return s;
 }
 
-static void launch_script(const char *setup_script, const char *ifname,
-                          int fd, Error **errp)
-{
-    int pid, status;
-    char *args[3];
-    char **parg;
-
-    /* try to launch network script */
-    pid = fork();
-    if (pid < 0) {
-        error_setg_errno(errp, errno, "could not launch network script %s",
-                         setup_script);
-        return;
-    }
-    if (pid == 0) {
-        int open_max = sysconf(_SC_OPEN_MAX), i;
-
-        for (i = 3; i < open_max; i++) {
-            if (i != fd) {
-                close(i);
-            }
-        }
-        parg = args;
-        *parg++ = (char *)setup_script;
-        *parg++ = (char *)ifname;
-        *parg = NULL;
-        execv(setup_script, args);
-        _exit(1);
-    } else {
-        while (waitpid(pid, &status, 0) != pid) {
-            /* loop */
-        }
-
-        if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
-            return;
-        }
-        error_setg(errp, "network script %s failed with status %d",
-                   setup_script, status);
-    }
-}
-
 static int recv_fd(int c)
 {
     int fd;
@@ -626,7 +586,11 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
     if (setup_script &&
         setup_script[0] != '\0' &&
         strcmp(setup_script, "no") != 0) {
-        launch_script(setup_script, ifname, fd, &err);
+        char *args[3];
+        args[0] = (char *)setup_script;
+        args[1] = (char *)ifname;
+        args[2] = NULL;
+        qemu_launch_script(setup_script, args, fd, &err);
         if (err) {
             error_propagate(errp, err);
             close(fd);
-- 
2.11.0
