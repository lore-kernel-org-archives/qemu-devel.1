Received: from eggs.gnu.org ([209.51.188.92]:40210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7hb-0007SE-OT
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7hY-0007FD-Nb
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:15:55 -0500
Received: from m15-113.126.com ([220.181.15.113]:49514)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7hT-00075S-25
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:15:49 -0500
From: Fei Li <lifei1214@126.com>
Date: Mon, 28 Jan 2019 22:14:46 +0800
Message-Id: <20190128141506.12731-4-lifei1214@126.com>
In-Reply-To: <20190128141506.12731-1-lifei1214@126.com>
References: <20190128141506.12731-1-lifei1214@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-4.0 03/11] qemu_thread: supplement error
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
Cc: Markus Armbruster <armbru@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Fei Li <fli@suse.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
