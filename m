Received: from eggs.gnu.org ([2001:4830:134:3::10]:38592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtF-000278-RI
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtF-0007B2-3f
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:26:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50188 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmtE-0007AJ-TZ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:26:57 -0400
Date: Fri, 1 Jun 2018 19:26:54 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-9-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 08/31] libqtest: fail if child coredumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>

Right now tests report OK status if QEMU crashes during cleanup.
Let's catch that case and fail the test.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 43fb97e035..f869854849 100644
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
