Received: from eggs.gnu.org ([2001:4830:134:3::10]:39232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Dk-0000TO-BG
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Dj-0002Sb-GR
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:16 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37838)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Dj-0002ST-8W
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:15 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:08:12 +0300
Message-ID: <151127329238.6888.17213631612102603209.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 10/45] windbg: structures for parsing data
 stream
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

Added structures for parsing data stream from windbg to packet.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |   11 +++++++++++
 windbgstub.c                    |   30 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 42dbca1e22..2d74fb847a 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -48,6 +48,17 @@ typedef struct InitedAddr {
     bool is_init;
 } InitedAddr;
 
+typedef struct PacketData {
+    union {
+        struct {
+            DBGKD_MANIPULATE_STATE64 m64;
+            uint8_t extra[PACKET_MAX_SIZE - sizeof(DBGKD_MANIPULATE_STATE64)];
+        };
+        uint8_t buf[PACKET_MAX_SIZE];
+    };
+    uint16_t extra_size;
+} PacketData;
+
 InitedAddr *windbg_get_KPCR(void);
 InitedAddr *windbg_get_version(void);
 
diff --git a/windbgstub.c b/windbgstub.c
index e9aabd807b..395f244d4f 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -19,6 +19,36 @@
 #include "sysemu/kvm.h"
 #include "sysemu/reset.h"
 
+typedef enum ParsingState {
+    STATE_LEADER,
+    STATE_PACKET_TYPE,
+    STATE_PACKET_BYTE_COUNT,
+    STATE_PACKET_ID,
+    STATE_PACKET_CHECKSUM,
+    STATE_PACKET_DATA,
+    STATE_TRAILING_BYTE,
+} ParsingState;
+
+typedef enum ParsingResult {
+    RESULT_NONE,
+    RESULT_BREAKIN_BYTE,
+    RESULT_UNKNOWN_PACKET,
+    RESULT_CONTROL_PACKET,
+    RESULT_DATA_PACKET,
+    RESULT_ERROR,
+} ParsingResult;
+
+typedef struct ParsingContext {
+    /* index in the current buffer,
+       which depends on the current state */
+    int index;
+    ParsingState state;
+    ParsingResult result;
+    KD_PACKET packet;
+    PacketData data;
+    const char *name;
+} ParsingContext;
+
 typedef struct WindbgState {
     bool is_loaded;
 
