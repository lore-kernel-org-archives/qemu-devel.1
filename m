Received: from eggs.gnu.org ([209.51.188.92]:40209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7hb-0007SD-OV
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7hY-0007FP-OK
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:15:55 -0500
Received: from m15-113.126.com ([220.181.15.113]:49510)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7hT-00075K-4v
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:15:49 -0500
From: Fei Li <lifei1214@126.com>
Date: Mon, 28 Jan 2019 22:14:49 +0800
Message-Id: <20190128141506.12731-7-lifei1214@126.com>
In-Reply-To: <20190128141506.12731-1-lifei1214@126.com>
References: <20190128141506.12731-1-lifei1214@126.com>
Subject: [Qemu-devel] [PATCH for-4.0 06/11] qemu_thread: supplement error
 handling for emulated_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Markus Armbruster <armbru@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Fei Li <fli@suse.com>

From: Fei Li <fli@suse.com>

Utilize the existed errp to propagate the error and do the
corresponding cleanup to replace the temporary &error_abort.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
---
 hw/usb/ccid-card-emulated.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 0b170f6328..19b4b9a8fa 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -544,11 +544,16 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
         error_setg(errp, "%s: failed to initialize vcard", TYPE_EMULATED_CCID);
         goto out2;
     }
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
-                       card, QEMU_THREAD_JOINABLE, &error_abort);
-    qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
-                       card, QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
+                           card, QEMU_THREAD_JOINABLE, errp) < 0) {
+        goto out2;
+    }
+    if (qemu_thread_create(&card->apdu_thread_id, "ccid/apdu",
+                           handle_apdu_thread, card,
+                           QEMU_THREAD_JOINABLE, errp) < 0) {
+        qemu_thread_join(&card->event_thread_id);
+        goto out2;
+    }
 
     return;
 
-- 
2.17.2 (Apple Git-113)
