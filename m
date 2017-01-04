Received: from eggs.gnu.org ([2001:4830:134:3::10]:44502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cOmvI-0005Zd-Kl
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cOmvF-0003Nc-EU
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:52:16 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  4 Jan 2017 15:52:10 +0100
Message-Id: <20170104145210.31608-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] qga: fix erroneous argument to strerror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

process_command returns a negative value in case of error.  Make this
clear in the "if" statement and fix the strerror argument to flip it
to positive.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 6caf215..538e4ee 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -558,8 +558,8 @@ static void process_command(GAState *s, QDict *req)
     rsp = qmp_dispatch(QOBJECT(req));
     if (rsp) {
         ret = send_response(s, rsp);
-        if (ret) {
-            g_warning("error sending response: %s", strerror(ret));
+        if (ret < 0) {
+            g_warning("error sending response: %s", strerror(-ret));
         }
         qobject_decref(rsp);
     }
-- 
2.9.3
