Received: from eggs.gnu.org ([2001:4830:134:3::10]:36427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utu-0007zv-L5
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utt-0007s8-RK
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:46 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Utt-0007qi-KC
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:45 -0400
Received: by mail-wm0-x244.google.com with SMTP id w2so8775092wmw.1
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:45 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:16 +0200
Message-Id: <1523034681-33787-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/20] qemu-pr-helper: Daemonize before dropping
 privileges
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

After we've dropped privileges it might be not possible to write
pidfile. For instance, if this binary is run as root (because
user wants it to write pidfile to some privileged location)
writing pidfile fails because privileges are dropped before we
even get to that.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/qemu-pr-helper.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 21e1b8e..eeff80a 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -1081,13 +1081,6 @@ int main(int argc, char **argv)
                                          accept_client,
                                          NULL, NULL);
 
-#ifdef CONFIG_LIBCAP
-    if (drop_privileges() < 0) {
-        error_report("Failed to drop privileges: %s", strerror(errno));
-        exit(EXIT_FAILURE);
-    }
-#endif
-
     if (daemonize) {
         if (daemon(0, 0) < 0) {
             error_report("Failed to daemonize: %s", strerror(errno));
@@ -1096,6 +1089,13 @@ int main(int argc, char **argv)
         write_pidfile();
     }
 
+#ifdef CONFIG_LIBCAP
+    if (drop_privileges() < 0) {
+        error_report("Failed to drop privileges: %s", strerror(errno));
+        exit(EXIT_FAILURE);
+    }
+#endif
+
     state = RUNNING;
     do {
         main_loop_wait(false);
-- 
1.8.3.1
