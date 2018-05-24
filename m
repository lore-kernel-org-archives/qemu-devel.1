Received: from eggs.gnu.org ([2001:4830:134:3::10]:45065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLrzj-00017m-AE
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLrzg-00042K-78
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:17:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLrzg-000420-2C
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:17:32 -0400
Date: Thu, 24 May 2018 18:17:31 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527174955-160019-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b3cad0d-b849-6ba9-64cb-6a36a37cd19d@redhat.com>
Subject: [Qemu-devel] [PATCH 2/1] libqtest: add more exit status checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>

Add more checks on how did QEMU exit.

Legal ways to exit right now:
- exit(0) or return from main
- kill(SIGTERM) - sent by testing infrastructure

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
---

TODO: refactor testing infrastructure to stop
QEMU through QMP as opposed to SIGTERM.


 tests/libqtest.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index f869854..2470f57 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -110,7 +110,14 @@ static void kill_qemu(QTestState *s)
         pid = waitpid(s->qemu_pid, &wstatus, 0);
 
         if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
+            /* Core dump is never OK */
             assert(!WCOREDUMP(wstatus));
+            /* Either exit normally or get killed */
+            assert((WIFEXITED(wstatus) || WIFSIGNALED(wstatus)));
+            /* Exited normally - check exit status. */
+            assert(!WIFEXITED(wstatus) || WEXITSTATUS(wstatus) == 0);
+            /* Killed - we only ever send SIGTERM. */
+            assert(!WIFSIGNALED(wstatus) || WTERMSIG(wstatus) == SIGTERM);
         }
     }
 }
-- 
MST
