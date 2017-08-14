Received: from eggs.gnu.org ([2001:4830:134:3::10]:47953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhEoV-0006QX-8N
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhEoT-0003qX-Tf
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhEoT-0003qF-Ky
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:49:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BBDA70001
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 12:49:44 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 14 Aug 2017 13:49:18 +0100
Message-Id: <20170814124927.30134-4-berrange@redhat.com>
In-Reply-To: <20170814124927.30134-1-berrange@redhat.com>
References: <20170814124927.30134-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/12] ui: convert key events to QKeyCodes
 immediately
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

Always use QKeyCode in the InputKeyEvent struct, by converting key
numbers to QKeyCode at the time the event is created.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/input.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/ui/input.c b/ui/input.c
index af05f06368..64e9103a61 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -400,10 +400,8 @@ void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down)
 
 void qemu_input_event_send_key_number(QemuConsole *src, int num, bool down)
 {
-    KeyValue *key = g_new0(KeyValue, 1);
-    key->type = KEY_VALUE_KIND_NUMBER;
-    key->u.number.data = num;
-    qemu_input_event_send_key(src, key, down);
+    QKeyCode code = qemu_input_key_number_to_qcode(num);
+    qemu_input_event_send_key_qcode(src, code, down);
 }
 
 void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down)
-- 
2.13.3
