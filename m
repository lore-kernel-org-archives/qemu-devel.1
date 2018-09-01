Received: from eggs.gnu.org ([2001:4830:134:3::10]:35642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JZ-00068N-5y
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JY-0007yD-6O
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:45 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Sat,  1 Sep 2018 14:46:38 +0200
Message-Id: <20180901124639.19735-15-luc.michel@greensocs.com>
In-Reply-To: <20180901124639.19735-1-luc.michel@greensocs.com>
References: <20180901124639.19735-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 14/15] gdbstub: add multiprocess extension
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, mark.burton@greensocs.com

Add multiprocess extension support by enabling multiprocess mode when
the peer requests it, and by replying that we actually support it in the
qSupported reply packet.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 gdbstub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 6a55bf2785..d249803c8e 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1688,15 +1688,19 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             put_packet(s, "OK");
             break;
         }
 #endif /* !CONFIG_USER_ONLY */
         if (is_query_packet(p, "Supported", ':')) {
+            if (strstr(p, "multiprocess+")) {
+                s->multiprocess = true;
+            }
             snprintf(buf, sizeof(buf), "PacketSize=%x", MAX_PACKET_LENGTH);
             cc = CPU_GET_CLASS(first_cpu);
             if (cc->gdb_core_xml_file != NULL) {
                 pstrcat(buf, sizeof(buf), ";qXfer:features:read+");
             }
+            pstrcat(buf, sizeof(buf), ";multiprocess+");
             put_packet(s, buf);
             break;
         }
         if (strncmp(p, "Xfer:features:read:", 19) == 0) {
             const char *xml;
-- 
2.18.0
