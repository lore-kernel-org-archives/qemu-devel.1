Received: from eggs.gnu.org ([2001:4830:134:3::10]:59360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngD-00044j-L8
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngC-0000qf-OG
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:33 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51896)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngC-0000qO-G9
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:32 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:05:30 +0300
Message-ID: <150642393032.3900.4598141276692628379.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 15/43] windbg: sized data buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Defined useful sized data buffer. It contains pointer to data and size of this data. Also, defined some macroses for init and free.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index cf2996d8cb..791721d472 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -86,6 +86,21 @@ typedef struct PacketData {
     uint16_t extra_size;
 } PacketData;
 
+typedef struct SizedBuf {
+    uint8_t *data;
+    size_t size;
+} SizedBuf;
+
+#define SBUF_INIT(buf, mem_ptr, len) do { \
+    buf.data = mem_ptr;                   \
+    buf.size = len;                       \
+} while (false)
+#define SBUF_MALLOC(buf, size) SBUF_INIT(buf, g_malloc0(size), size)
+#define SBUF_FREE(buf) do { \
+    g_free(buf.data);       \
+    buf.data = NULL;        \
+    buf.size = 0;           \
+} while (false)
 bool windbg_on_load(void);
 void windbg_on_exit(void);
 
