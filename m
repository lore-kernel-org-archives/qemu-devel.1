Received: from eggs.gnu.org ([2001:4830:134:3::10]:33170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rd8-0003Hq-BG
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rd4-00052i-BY
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:09:58 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56638)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rd3-00051g-J7
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:09:54 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 17 Oct 2017 16:09:47 +0300
Message-ID: <150824578694.6816.15621161801519932541.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 10/43] windbg: structures for parsing data
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
index ff260287dc..d6abb82dfa 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -55,6 +55,17 @@ typedef struct InitedAddr {
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
 
