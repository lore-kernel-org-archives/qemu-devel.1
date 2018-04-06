Received: from eggs.gnu.org ([2001:4830:134:3::10]:36440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utv-00083b-Vz
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utu-0007uN-Vo
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:47 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:37794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Utu-0007sh-Or
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:46 -0400
Received: by mail-wr0-x241.google.com with SMTP id l49so2417703wrl.4
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:17 +0200
Message-Id: <1523034681-33787-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/20] qemu-pr-helper: Write pidfile more often
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

Let's write pidfile even if user did not request --daemon but
they requested just --pidfile. Libvirt will use exactly this.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/qemu-pr-helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index eeff80a..d0f8317 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -924,6 +924,7 @@ int main(int argc, char **argv)
     Error *local_err = NULL;
     char *trace_file = NULL;
     bool daemonize = false;
+    bool pidfile_specified = false;
     unsigned socket_activation;
 
     struct sigaction sa_sigterm;
@@ -954,6 +955,7 @@ int main(int argc, char **argv)
         case 'f':
             g_free(pidfile);
             pidfile = g_strdup(optarg);
+            pidfile_specified = true;
             break;
 #ifdef CONFIG_LIBCAP
         case 'u': {
@@ -1086,9 +1088,11 @@ int main(int argc, char **argv)
             error_report("Failed to daemonize: %s", strerror(errno));
             exit(EXIT_FAILURE);
         }
-        write_pidfile();
     }
 
+    if (daemonize || pidfile_specified)
+        write_pidfile();
+
 #ifdef CONFIG_LIBCAP
     if (drop_privileges() < 0) {
         error_report("Failed to drop privileges: %s", strerror(errno));
-- 
1.8.3.1
