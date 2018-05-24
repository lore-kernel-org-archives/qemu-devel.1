Received: from eggs.gnu.org ([2001:4830:134:3::10]:33860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLrG1-0005w6-FS
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLrFt-00050C-QI
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:30:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51762 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLrFt-0004oq-L2
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:30:13 -0400
Date: Thu, 24 May 2018 17:30:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527172175-129517-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] libqtest: fail if child coredumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>

Right now tests report OK status if QEMU crashes during cleanup.
Let's catch that case and fail the test.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/libqtest.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 43fb97e..f869854 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -103,8 +103,15 @@ static int socket_accept(int sock)
 static void kill_qemu(QTestState *s)
 {
     if (s->qemu_pid != -1) {
+        int wstatus = 0;
+        pid_t pid;
+
         kill(s->qemu_pid, SIGTERM);
-        waitpid(s->qemu_pid, NULL, 0);
+        pid = waitpid(s->qemu_pid, &wstatus, 0);
+
+        if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
+            assert(!WCOREDUMP(wstatus));
+        }
     }
 }
 
-- 
MST
