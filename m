Received: from eggs.gnu.org ([2001:4830:134:3::10]:42603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=435739c2e=owen.smith@citrix.com>)
	id 1dwrBH-0005u3-At
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=435739c2e=owen.smith@citrix.com>)
	id 1dwrBC-000413-Mj
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:49:51 -0400
Received: from smtp.citrix.com ([66.165.176.89]:54430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=435739c2e=owen.smith@citrix.com>)
	id 1dwrBC-00040M-Ew
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:49:46 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Tue, 26 Sep 2017 14:43:37 +0000
Message-ID: <1506437019-17946-2-git-send-email-owen.smith@citrix.com>
In-Reply-To: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
References: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3 v4] ui/input: add qemu_input_qcode_to_linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sstabellini@kernel.org, anthony.perard@citrix.com, kraxel@redhat.com
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Owen Smith <owen.smith@citrix.com>

Build a reverse mapping on first call that converts qcodes to
linux KEY_* identifiers.

Signed-off-by: Owen Smith <owen.smith@citrix.com>
---
 include/ui/input.h |  1 +
 ui/input-keymap.c  | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/ui/input.h b/include/ui/input.h
index c488585..c3c1664 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -49,6 +49,7 @@ int qemu_input_key_value_to_qcode(const KeyValue *value);
 int qemu_input_key_value_to_scancode(const KeyValue *value, bool down,
                                      int *codes);
 int qemu_input_linux_to_qcode(unsigned int lnx);
+unsigned int qemu_input_qcode_to_linux(int qcode);
 
 InputEvent *qemu_input_event_new_btn(InputButton btn, bool down);
 void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down);
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index cf979c2..5f020fc 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -300,6 +300,7 @@ static const int qcode_to_number[] = {
 };
 
 static int number_to_qcode[0x100];
+static unsigned int qcode_to_linux[Q_KEY_CODE__MAX];
 
 int qemu_input_linux_to_qcode(unsigned int lnx)
 {
@@ -307,6 +308,21 @@ int qemu_input_linux_to_qcode(unsigned int lnx)
     return linux_to_qcode[lnx];
 }
 
+unsigned int qemu_input_qcode_to_linux(int qcode)
+{
+    static int first = true;
+
+    if (first) {
+        unsigned int lnx;
+        first = false;
+        for (lnx = 0; lnx < KEY_CNT; ++lnx) {
+            qcode_to_linux[linux_to_qcode[lnx]] = lnx;
+        }
+    }
+
+    return qcode_to_linux[qcode];
+}
+
 int qemu_input_key_value_to_number(const KeyValue *value)
 {
     if (value->type == KEY_VALUE_KIND_QCODE) {
-- 
2.1.4
