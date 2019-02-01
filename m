Received: from eggs.gnu.org ([209.51.188.92]:40396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpRDq-0003g2-Ve
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpRDp-0007o4-2H
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:18:38 -0500
Received: from m50-111.126.com ([123.125.50.111]:54035)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpRDn-0007m5-53
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:18:36 -0500
From: Fei Li <lifei1214@126.com>
Date: Fri,  1 Feb 2019 13:17:58 +0800
Message-Id: <20190201051806.53183-4-lifei1214@126.com>
In-Reply-To: <20190201051806.53183-1-lifei1214@126.com>
References: <20190201051806.53183-1-lifei1214@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v11 for-4.0 03/11] qemu_thread: supplement
 error handling for qmp_dump_guest_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Fei Li <fli@suse.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Fei Li <fli@suse.com>

Utilize the existed errp to propagate the error instead of the
temporary &error_abort.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
---
 dump.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/dump.c b/dump.c
index e4886bc9c3..92cc277015 100644
--- a/dump.c
+++ b/dump.c
@@ -2020,9 +2020,8 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     if (detach_p) {
         /* detached dump */
         s->detached = true;
-        /* TODO: let the further caller handle the error instead of abort() */
         qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
-                           s, QEMU_THREAD_DETACHED, &error_abort);
+                           s, QEMU_THREAD_DETACHED, errp);
     } else {
         /* sync dump */
         dump_process(s, errp);
-- 
2.17.2 (Apple Git-113)
