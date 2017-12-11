Received: from eggs.gnu.org ([2001:4830:134:3::10]:33598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO2R-0000fh-L2
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO2Q-000272-KY
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:22:31 -0500
Received: from mail.ispras.ru ([83.149.199.45]:43450)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO2Q-00026e-DV
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:22:30 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:22:15 +0300
Message-ID: <151299853501.4808.4968277796848274446.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 10/46] windbg: structures for parsing data
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
index ced03b0663..b7e65faefe 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -52,6 +52,17 @@ typedef struct InitedAddr {
     bool is_init;
 } InitedAddr;
 
+typedef struct PacketData {
+    union {
+        struct {
+            DBGKD_MANIPULATE_STATE64 m64;
+            uint8_t extra[0];
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
 
