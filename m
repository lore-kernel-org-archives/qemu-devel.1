Received: from eggs.gnu.org ([2001:4830:134:3::10]:46195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iQ-00022G-HP
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iP-000091-If
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:50 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:13 -0500
Message-Id: <20180619014319.28272-48-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 047/113] qemu-pr-helper: Actually allow users
 to specify pidfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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
(cherry picked from commit f8e1a989644f22ba2f7afb0e13b6ce2309ea9503)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 scsi/qemu-pr-helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 9fe615c73c..12474d162c 100644
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
2.11.0
