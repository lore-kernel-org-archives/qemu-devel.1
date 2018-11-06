Received: from eggs.gnu.org ([2001:4830:134:3::10]:41678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK3NF-0006gS-W9
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK3NB-0003c8-4s
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:34:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gK3NA-0002YT-U4
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:34:33 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Nov 2018 15:33:30 +0000
Message-Id: <20181106153330.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1] replay: Exit on errors reading from
 replay log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

Currently replay_get_byte() does not check for an error
from getc(). Coverity points out (CID 1390622) that this
could result in unexpected behaviour (such as looping
forever, if we use the replay_get_dword() return value
for a loop count). We don't expect reads from the replay
log to fail, and if they do there is no way we can
continue. So make them fatal errors.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Disclaimer: checked only with "make check".

 replay/replay-internal.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 1cea1d4dc91..8f87e9b957e 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -35,6 +35,12 @@ static void replay_write_error(void)
     }
 }
 
+static void replay_read_error(void)
+{
+    error_report("error reading the replay data");
+    exit(1);
+}
+
 void replay_put_byte(uint8_t byte)
 {
     if (replay_file) {
@@ -83,7 +89,11 @@ uint8_t replay_get_byte(void)
 {
     uint8_t byte = 0;
     if (replay_file) {
-        byte = getc(replay_file);
+        int r = getc(replay_file);
+        if (r == EOF) {
+            replay_read_error();
+        }
+        byte = r;
     }
     return byte;
 }
@@ -126,7 +136,7 @@ void replay_get_array(uint8_t *buf, size_t *size)
     if (replay_file) {
         *size = replay_get_dword();
         if (fread(buf, 1, *size, replay_file) != *size) {
-            error_report("replay read error");
+            replay_read_error();
         }
     }
 }
@@ -137,7 +147,7 @@ void replay_get_array_alloc(uint8_t **buf, size_t *size)
         *size = replay_get_dword();
         *buf = g_malloc(*size);
         if (fread(*buf, 1, *size, replay_file) != *size) {
-            error_report("replay read error");
+            replay_read_error();
         }
     }
 }
-- 
2.19.1
