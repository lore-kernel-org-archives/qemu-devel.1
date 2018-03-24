Received: from eggs.gnu.org ([2001:4830:134:3::10]:45407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1ezbWC-0005Wu-6o
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 01:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1ezbWB-00067L-FI
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 01:15:04 -0400
From: Michal Privoznik <mprivozn@redhat.com>
Date: Sat, 24 Mar 2018 06:14:49 +0100
Message-Id: <6f10cd53d361a395aa0e85a9311ec4e9a8fc11e5.1521868451.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-pr-helper: Actually allow users to
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
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, famz@redhat.com, qemu-block@nongnu.org

Due to wrong specification of arguments to getopt_long() any
attempt to set pidfile resulted in:

1) the default to be leaked
2) the @pidfile variable to be set to NULL (because optarg is
NULL without this patch).

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 scsi/qemu-pr-helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 3facbba170..21e1b8ea60 100644
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
2.16.1
