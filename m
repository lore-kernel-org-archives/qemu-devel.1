Received: from eggs.gnu.org ([2001:4830:134:3::10]:41907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpoi-0004DO-Gi
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpoh-00061r-Fw
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:56:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8451)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dfpoh-00060T-AL
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:56:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F0A2CA360
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 15:56:10 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 10 Aug 2017 16:55:21 +0100
Message-Id: <20170810155522.31099-15-berrange@redhat.com>
In-Reply-To: <20170810155522.31099-1-berrange@redhat.com>
References: <20170810155522.31099-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 14/15] ui: remove qemu_input_linux_to_qcode
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

The qemu_input_linux_to_qcode method is only used in one place and
no new code should require it, so inline it at the only caller.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/ui/input.h | 1 -
 ui/input-keymap.c  | 8 --------
 ui/input-linux.c   | 4 ++--
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index b3827b6082..92e54c25e2 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -43,7 +43,6 @@ void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down);
 void qemu_input_event_send_key_delay(uint32_t delay_ms);
 int qemu_input_key_number_to_qcode(unsigned int nr);
 int qemu_input_qcode_to_scancode(QKeyCode qcode, bool down, int *codes);
-int qemu_input_linux_to_qcode(unsigned int lnx);
 
 InputEvent *qemu_input_event_new_btn(InputButton btn, bool down);
 void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down);
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 71c6a79e66..bbd818ef97 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -24,14 +24,6 @@
 #include "ui/input-keymap-xorgxquartz2qcode.c"
 #include "ui/input-keymap-xorgxwin2qcode.c"
 
-int qemu_input_linux_to_qcode(unsigned int lnx)
-{
-    if (lnx >= qemu_input_map_linux2qcode_len) {
-        return 0;
-    }
-    return qemu_input_map_linux2qcode[lnx];
-}
-
 int qemu_input_key_number_to_qcode(unsigned int nr)
 {
     if (nr >= qemu_input_map_qnum2qcode_len) {
diff --git a/ui/input-linux.c b/ui/input-linux.c
index 9720333b2c..f5eb589b1d 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -128,8 +128,8 @@ static void input_linux_handle_keyboard(InputLinux *il,
         }
 
         /* send event to guest when grab is active */
-        if (il->grab_active) {
-            int qcode = qemu_input_linux_to_qcode(event->code);
+        if (il->grab_active && event->code < qemu_input_map_linux2qcode_len) {
+            int qcode = qemu_input_map_linux2qcode[event->code];
             qemu_input_event_send_key_qcode(NULL, qcode, event->value);
         }
 
-- 
2.13.3
