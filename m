Received: from eggs.gnu.org ([2001:4830:134:3::10]:41646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpoI-0003od-Q5
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpoH-0005kz-Qr
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:55:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dfpoH-0005kf-KX
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:55:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F3573E2C1
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 15:55:44 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 10 Aug 2017 16:55:11 +0100
Message-Id: <20170810155522.31099-5-berrange@redhat.com>
In-Reply-To: <20170810155522.31099-1-berrange@redhat.com>
References: <20170810155522.31099-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 04/15] ui: don't export qemu_input_event_new_key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

All public code should use qemu_input_event_send_key* functions
instead of creating an event directly.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/ui/input.h | 1 -
 ui/input.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 1e1cfa0fdf..576006c370 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -38,7 +38,6 @@ void qemu_input_event_send_impl(QemuConsole *src, InputEvent *evt);
 void qemu_input_event_sync(void);
 void qemu_input_event_sync_impl(void);
 
-InputEvent *qemu_input_event_new_key(KeyValue *key, bool down);
 void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down);
 void qemu_input_event_send_key_number(QemuConsole *src, int num, bool down);
 void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down);
diff --git a/ui/input.c b/ui/input.c
index 64e9103a61..ba85bf01a9 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -374,7 +374,7 @@ void qemu_input_event_sync(void)
     replay_input_sync_event();
 }
 
-InputEvent *qemu_input_event_new_key(KeyValue *key, bool down)
+static InputEvent *qemu_input_event_new_key(KeyValue *key, bool down)
 {
     InputEvent *evt = g_new0(InputEvent, 1);
     evt->u.key.data = g_new0(InputKeyEvent, 1);
-- 
2.13.3
