Received: from eggs.gnu.org ([2001:4830:134:3::10]:57147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDSMq-0006GD-JY
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDSMn-0001Vl-Mi
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:50:56 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gDSMn-0001MI-B1
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:50:53 -0400
Received: by mail-pl1-x643.google.com with SMTP id c8-v6so15693100plo.9
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 03:50:44 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 19 Oct 2018 03:50:35 -0700
Message-Id: <1539946236-18028-2-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1539946236-18028-1-git-send-email-liq3ea@gmail.com>
References: <1539946236-18028-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] hw: ccid-card-emulated: introduce
 clean_event_notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@163.com, Li Qiang <liq3ea@gmail.com>

Call it in device unrealize function.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/usb/ccid-card-emulated.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 5c8b3c9..b356edb 100644
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
1.8.3.1
