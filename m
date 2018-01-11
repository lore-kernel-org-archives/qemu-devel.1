Received: from eggs.gnu.org ([2001:4830:134:3::10]:47186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCS-00016V-BB
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCR-0001zl-BY
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:00 -0500
Received: from mail.ispras.ru ([83.149.199.45]:41912)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCR-0001zC-3k
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:26:59 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 11 Jan 2018 11:27:00 +0300
Message-ID: <20180111082700.27295.98444.stgit@pasha-VirtualBox>
In-Reply-To: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v3 22/30] replay: check return values of
 fwrite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

This patch adds error reporting when fwrite cannot completely
save the buffer to the file.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

--

v3: also check putc() return value
---
 replay/replay-internal.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index a1a7686..1034d8f 100644
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
 
