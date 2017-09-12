Received: from eggs.gnu.org ([2001:4830:134:3::10]:48591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkS5-0000hs-DO
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkRz-0003RD-I2
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drkRz-0003Qk-Cu
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:37:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7988AC04B92C
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 12:37:58 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 13:37:36 +0100
Message-Id: <20170912123744.14730-5-berrange@redhat.com>
In-Reply-To: <20170912123744.14730-1-berrange@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v5 04/12] ui: don't export
 qemu_input_event_new_key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

All public code should use qemu_input_event_send_key* functions
instead of creating an event directly.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/ui/input.h | 1 -
 ui/input.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 479cc46cfc..f8cee43f65 100644
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
index 9914daf0b4..23f9f2c5e0 100644
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
2.13.5
