Received: from eggs.gnu.org ([2001:4830:134:3::10]:51250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHDkX-00039h-IC
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHDkS-0005wk-HJ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:02:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gHDkS-0005wZ-AW
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:02:52 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Oct 2018 21:02:49 +0100
Message-Id: <20181029200250.24029-3-kraxel@redhat.com>
In-Reply-To: <20181029200250.24029-1-kraxel@redhat.com>
References: <20181029200250.24029-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] hw: ccid-card-emulated: introduce
 clean_event_notifier
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

Call it in device unrealize function.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Message-id: 1539946236-18028-2-git-send-email-liq3ea@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/ccid-card-emulated.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 5c8b3c9907..b356edb0f3 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -409,6 +409,12 @@ static int init_event_notifier(EmulatedState *card, Error **errp)
     return 0;
 }
 
+static void clean_event_notifier(EmulatedState *card)
+{
+    event_notifier_set_handler(&card->notifier, NULL);
+    event_notifier_cleanup(&card->notifier);
+}
+
 #define CERTIFICATES_DEFAULT_DB "/etc/pki/nssdb"
 #define CERTIFICATES_ARGS_TEMPLATE\
     "db=\"%s\" use_hw=no soft=(,Virtual Reader,CAC,,%s,%s,%s)"
@@ -556,6 +562,7 @@ static void emulated_unrealize(CCIDCardState *base, Error **errp)
     qemu_cond_signal(&card->handle_apdu_cond);
     qemu_thread_join(&card->apdu_thread_id);
 
+    clean_event_notifier(card);
     /* threads exited, can destroy all condvars/mutexes */
     qemu_cond_destroy(&card->handle_apdu_cond);
     qemu_mutex_destroy(&card->handle_apdu_mutex);
-- 
2.9.3
