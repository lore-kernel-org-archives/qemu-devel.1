Received: from eggs.gnu.org ([2001:4830:134:3::10]:39433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9EG-0000u6-4n
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9EB-0002d9-Gz
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:48 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37964)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9EB-0002cx-9V
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:43 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:08:40 +0300
Message-ID: <151127332036.6888.3168353085464706816.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 15/45] windbg: sized data buffer
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

Defined useful sized data buffer. It contains pointer to data and size of this data. Also, defined some macros for init and free.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 6ce870beb1..b729cd604e 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -67,6 +67,22 @@ typedef struct PacketData {
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
+
 InitedAddr *windbg_get_KPCR(void);
 InitedAddr *windbg_get_version(void);
 
