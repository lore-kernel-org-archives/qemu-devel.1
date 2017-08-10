Received: from eggs.gnu.org ([2001:4830:134:3::10]:41883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpog-0004BI-86
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpoe-0005xL-B1
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:56:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dfpoe-0005x0-4X
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:56:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D50274F1BD
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 15:56:06 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 10 Aug 2017 16:55:20 +0100
Message-Id: <20170810155522.31099-14-berrange@redhat.com>
In-Reply-To: <20170810155522.31099-1-berrange@redhat.com>
References: <20170810155522.31099-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 13/15] ui: remove qemu_input_qcode_to_number
 method
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

The qemu_input_qcode_to_number method is only used in one place and
no new code should require it, so inline it at the only caller.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/ui/input.h |  1 -
 ui/input-keymap.c  | 16 +++++++---------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 7ac1d62747..b3827b6082 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -42,7 +42,6 @@ void qemu_input_event_send_key_number(QemuConsole *src, int num, bool down);
 void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down);
 void qemu_input_event_send_key_delay(uint32_t delay_ms);
 int qemu_input_key_number_to_qcode(unsigned int nr);
-int qemu_input_qcode_to_number(QKeyCode qcode);
 int qemu_input_qcode_to_scancode(QKeyCode qcode, bool down, int *codes);
 int qemu_input_linux_to_qcode(unsigned int lnx);
 
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 566b8f2000..71c6a79e66 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -32,14 +32,6 @@ int qemu_input_linux_to_qcode(unsigned int lnx)
     return qemu_input_map_linux2qcode[lnx];
 }
 
-int qemu_input_qcode_to_number(QKeyCode qcode)
-{
-    if (qcode >= qemu_input_map_qcode2qnum_len) {
-        return 0;
-    }
-    return qemu_input_map_qcode2qnum[qcode];
-}
-
 int qemu_input_key_number_to_qcode(unsigned int nr)
 {
     if (nr >= qemu_input_map_qnum2qcode_len) {
@@ -51,9 +43,15 @@ int qemu_input_key_number_to_qcode(unsigned int nr)
 int qemu_input_qcode_to_scancode(QKeyCode qcode, bool down,
                                  int *codes)
 {
-    int keycode = qemu_input_qcode_to_number(qcode);
+    int keycode;
     int count = 0;
 
+    if (qcode >= qemu_input_map_qcode2qnum_len) {
+        keycode = 0;
+    } else {
+        keycode = qemu_input_map_qcode2qnum[qcode];
+    }
+
     if (qcode == Q_KEY_CODE_PAUSE) {
         /* specific case */
         int v = down ? 0 : 0x80;
-- 
2.13.3
