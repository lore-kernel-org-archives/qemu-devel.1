Received: from eggs.gnu.org ([208.118.235.92]:33204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnKw-0001OV-L4
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnKv-0003qb-GA
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:34 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:60285)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gbnKv-0003pj-6Z
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:33 -0500
From: Fei Li <fli@suse.com>
Date: Tue, 25 Dec 2018 22:04:41 +0800
Message-Id: <20181225140449.15786-9-fli@suse.com>
In-Reply-To: <20181225140449.15786-1-fli@suse.com>
References: <20181225140449.15786-1-fli@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-4.0 v9 08/16] qemu_thread: supplement error
 handling for qmp_dump_guest_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: lifei1214@126.com, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Utilize the existed errp to propagate the error instead of the
temporary &error_abort.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
---
 dump.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/dump.c b/dump.c
index c35d6ddd22..ef5ea324fa 100644
--- a/dump.c
+++ b/dump.c
@@ -2020,9 +2020,10 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     if (detach_p) {
         /* detached dump */
         s->detached = true;
-        /* TODO: let the further caller handle the error instead of abort() */
-        qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
-                           s, QEMU_THREAD_DETACHED, &error_abort);
+        if (!qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
+                           s, QEMU_THREAD_DETACHED, errp)) {
+            /* keep 'if' here in case there is further error handling logic */
+        }
     } else {
         /* sync dump */
         dump_process(s, errp);
-- 
2.13.7
