Received: from eggs.gnu.org ([2001:4830:134:3::10]:58795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiq-0006UV-US
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsim-0004Ci-Ib
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:44 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsim-0004C0-Bw
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:40 -0400
Received: by mail-wr0-x241.google.com with SMTP id o8so2599429wra.1
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:40 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:47:13 +0100
Message-Id: <20180313224719.4954-64-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 63/69] replay: check return values of fwrite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch adds error reporting when fwrite cannot completely
save the buffer to the file.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20180227095259.1060.86410.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-internal.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 8e7474f787..b077cb5fd5 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -24,12 +24,23 @@
 static QemuMutex lock;
 
 /* File for replay writing */
+static bool write_error;
 FILE *replay_file;
 
+static void replay_write_error(void)
+{
+    if (!write_error) {
+        error_report("replay write error");
+        write_error = true;
+    }
+}
+
 void replay_put_byte(uint8_t byte)
 {
     if (replay_file) {
-        putc(byte, replay_file);
+        if (putc(byte, replay_file) == EOF) {
+            replay_write_error();
+        }
     }
 }
 
@@ -62,7 +73,9 @@ void replay_put_array(const uint8_t *buf, size_t size)
 {
     if (replay_file) {
         replay_put_dword(size);
-        fwrite(buf, 1, size, replay_file);
+        if (fwrite(buf, 1, size, replay_file) != size) {
+            replay_write_error();
+        }
     }
 }
 
-- 
2.14.3
