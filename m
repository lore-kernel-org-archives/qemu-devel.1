Received: from eggs.gnu.org ([2001:4830:134:3::10]:51353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHDkc-0003Jb-K4
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHDkb-00061e-Mc
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:03:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gHDkb-00061N-D2
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:03:01 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Oct 2018 21:02:50 +0100
Message-Id: <20181029200250.24029-4-kraxel@redhat.com>
In-Reply-To: <20181029200250.24029-1-kraxel@redhat.com>
References: <20181029200250.24029-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] hw: ccid-card-emulated: cleanup resource
 when realize in error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Message-id: 1539946236-18028-3-git-send-email-liq3ea@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/ccid-card-emulated.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index b356edb0f3..25976ed84f 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -499,7 +499,7 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
     card->reader = NULL;
     card->quit_apdu_thread = 0;
     if (init_event_notifier(card, errp) < 0) {
-        return;
+        goto out1;
     }
 
     card->backend = 0;
@@ -513,7 +513,7 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
         for (ptable = backend_enum_table; ptable->name != NULL; ++ptable) {
             error_append_hint(errp, "%s\n", ptable->name);
         }
-        return;
+        goto out2;
     }
 
     /* TODO: a passthru backened that works on local machine. third card type?*/
@@ -523,31 +523,39 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
         } else {
             error_setg(errp, "%s: you must provide all three certs for"
                        " certificates backend", TYPE_EMULATED_CCID);
-            return;
+            goto out2;
         }
     } else {
         if (card->backend != BACKEND_NSS_EMULATED) {
             error_setg(errp, "%s: bad backend specified. The options are:%s"
                        " (default), %s.", TYPE_EMULATED_CCID,
                        BACKEND_NSS_EMULATED_NAME, BACKEND_CERTIFICATES_NAME);
-            return;
+            goto out2;
         }
         if (card->cert1 != NULL || card->cert2 != NULL || card->cert3 != NULL) {
             error_setg(errp, "%s: unexpected cert parameters to nss emulated "
                        "backend", TYPE_EMULATED_CCID);
-            return;
+            goto out2;
         }
         /* default to mirroring the local hardware readers */
         ret = wrap_vcard_emul_init(NULL);
     }
     if (ret != VCARD_EMUL_OK) {
         error_setg(errp, "%s: failed to initialize vcard", TYPE_EMULATED_CCID);
-        return;
+        goto out2;
     }
     qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
                        card, QEMU_THREAD_JOINABLE);
     qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
                        card, QEMU_THREAD_JOINABLE);
+
+out2:
+    clean_event_notifier(card);
+out1:
+    qemu_cond_destroy(&card->handle_apdu_cond);
+    qemu_mutex_destroy(&card->handle_apdu_mutex);
+    qemu_mutex_destroy(&card->vreader_mutex);
+    qemu_mutex_destroy(&card->event_list_mutex);
 }
 
 static void emulated_unrealize(CCIDCardState *base, Error **errp)
-- 
2.9.3
