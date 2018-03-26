Received: from eggs.gnu.org ([2001:4830:134:3::10]:57304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJD-0006kx-2a
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ8-00073c-Uu
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:11 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:43 +0200
Message-Id: <1522071403-52486-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/16] qemu-pr-helper: Actually allow users to
 specify pidfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>, qemu-stable@nongnu.org

From: Michal Privoznik <mprivozn@redhat.com>

Due to wrong specification of arguments to getopt_long() any
attempt to set pidfile resulted in:

1) the default to be leaked
2) the @pidfile variable to be set to NULL (because optarg is
NULL without this patch).

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Message-Id: <6f10cd53d361a395aa0e85a9311ec4e9a8fc11e5.1521868451.git.mprivozn@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/qemu-pr-helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 3facbba..21e1b8e 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -903,12 +903,12 @@ static int drop_privileges(void)
 
 int main(int argc, char **argv)
 {
-    const char *sopt = "hVk:fdT:u:g:vq";
+    const char *sopt = "hVk:f:dT:u:g:vq";
     struct option lopt[] = {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
         { "socket", required_argument, NULL, 'k' },
-        { "pidfile", no_argument, NULL, 'f' },
+        { "pidfile", required_argument, NULL, 'f' },
         { "daemon", no_argument, NULL, 'd' },
         { "trace", required_argument, NULL, 'T' },
         { "user", required_argument, NULL, 'u' },
@@ -952,7 +952,8 @@ int main(int argc, char **argv)
             }
             break;
         case 'f':
-            pidfile = optarg;
+            g_free(pidfile);
+            pidfile = g_strdup(optarg);
             break;
 #ifdef CONFIG_LIBCAP
         case 'u': {
-- 
1.8.3.1
