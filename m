Received: from eggs.gnu.org ([2001:4830:134:3::10]:53744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Bol-0000Pn-L5
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Bok-0005kS-Rt
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:29:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e5Bok-0005k5-Li
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:29:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD11C12B2D
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:29:01 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 19 Oct 2017 15:28:42 +0100
Message-Id: <20171019142848.572-4-berrange@redhat.com>
In-Reply-To: <20171019142848.572-1-berrange@redhat.com>
References: <20171019142848.572-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/9] ui: use correct union field for key
 number
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

The code converting key numbers to QKeyCode in the 'input-send-event'
command mistakenly accessed the key->u.qcode union field instead of
the key->u.number field. This is harmless because the fields use the
same size datatype in both cases, but none the less it should be fixed
to avoid confusion.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/input.c b/ui/input.c
index 290b47354a..4e821f8f2b 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -162,7 +162,7 @@ void qmp_input_send_event(bool has_device, const char *device,
         if (evt->type == INPUT_EVENT_KIND_KEY &&
             evt->u.key.data->key->type == KEY_VALUE_KIND_NUMBER) {
             KeyValue *key = evt->u.key.data->key;
-            QKeyCode code = qemu_input_key_number_to_qcode(key->u.qcode.data);
+            QKeyCode code = qemu_input_key_number_to_qcode(key->u.number.data);
             qemu_input_event_send_key_qcode(con, code, evt->u.key.data->down);
         } else {
             qemu_input_event_send(con, evt);
-- 
2.13.6
