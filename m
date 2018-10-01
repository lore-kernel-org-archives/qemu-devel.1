Received: from eggs.gnu.org ([2001:4830:134:3::10]:35250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1g6wpn-0002kP-Fc
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1g6wpm-00061p-Lp
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:57:55 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Mon,  1 Oct 2018 13:57:03 +0200
Message-Id: <20181001115704.701-15-luc.michel@greensocs.com>
In-Reply-To: <20181001115704.701-1-luc.michel@greensocs.com>
References: <20181001115704.701-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/15] gdbstub: add multiprocess extension
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
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, mark.burton@greensocs.com

Add multiprocess extension support by enabling multiprocess mode when
the peer requests it, and by replying that we actually support it in the
qSupported reply packet.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 gdbstub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 51cc11981e..89f6803533 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1692,15 +1692,19 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
             put_packet(s, "OK");
             break;
         }
 #endif /* !CONFIG_USER_ONLY */
         if (is_query_packet(p, "Supported", ':')) {
+            if (strstr(p, "multiprocess+")) {
+                s->multiprocess =3D true;
+            }
             snprintf(buf, sizeof(buf), "PacketSize=3D%x", MAX_PACKET_LEN=
GTH);
             cc =3D CPU_GET_CLASS(first_cpu);
             if (cc->gdb_core_xml_file !=3D NULL) {
                 pstrcat(buf, sizeof(buf), ";qXfer:features:read+");
             }
+            pstrcat(buf, sizeof(buf), ";multiprocess+");
             put_packet(s, buf);
             break;
         }
         if (strncmp(p, "Xfer:features:read:", 19) =3D=3D 0) {
             const char *xml;
--=20
2.19.0
