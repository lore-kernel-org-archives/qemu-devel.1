Received: from eggs.gnu.org ([2001:4830:134:3::10]:50916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLsK2-0004LV-07
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLsJw-00084Z-BR
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:38:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLsJw-00084M-5A
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:38:28 -0400
Date: Thu, 24 May 2018 18:38:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527176250-178968-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b3cad0d-b849-6ba9-64cb-6a36a37cd19d@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/1] libqtest: add more exit status checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>

Add more checks on how did QEMU exit.

Legal ways to exit right now:
- exit(0) or return from main
- kill(SIGTERM) - sent by testing infrastructure

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Changes from v1:
- drop SIGTERM as suggested by Eric

 tests/libqtest.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index f869854..0576874 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -110,7 +110,12 @@ static void kill_qemu(QTestState *s)
         pid = waitpid(s->qemu_pid, &wstatus, 0);
 
         if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
+            /* Core dump is never OK */
             assert(!WCOREDUMP(wstatus));
+            /* Must exit normally */
+            assert(WIFEXITED(wstatus));
+            /* If exited normally - check exit status */
+            assert(!WIFEXITED(wstatus) || !WEXITSTATUS(wstatus));
         }
     }
 }
-- 
MST
