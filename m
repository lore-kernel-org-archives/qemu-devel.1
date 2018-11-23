Received: from eggs.gnu.org ([2001:4830:134:3::10]:58221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gQ7bP-0008Lp-UK
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:18:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gQ7bP-0001r9-5e
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:18:19 -0500
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 23 Nov 2018 10:17:28 +0100
Message-Id: <20181123091729.29921-16-luc.michel@greensocs.com>
In-Reply-To: <20181123091729.29921-1-luc.michel@greensocs.com>
References: <20181123091729.29921-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 15/16] gdbstub: add multiprocess extension
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
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, mark.burton@greensocs.com, Eduardo Habkost <ehabkost@redhat.com>

Add multiprocess extension support by enabling multiprocess mode when
the peer requests it, and by replying that we actually support it in the
qSupported reply packet.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 gdbstub.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 6fc1630643..dc71e3f732 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1725,10 +1725,16 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
             snprintf(buf, sizeof(buf), "PacketSize=3D%x", MAX_PACKET_LEN=
GTH);
             cc =3D CPU_GET_CLASS(first_cpu);
             if (cc->gdb_core_xml_file !=3D NULL) {
                 pstrcat(buf, sizeof(buf), ";qXfer:features:read+");
             }
+
+            if (strstr(p, "multiprocess+")) {
+                s->multiprocess =3D true;
+            }
+            pstrcat(buf, sizeof(buf), ";multiprocess+");
+
             put_packet(s, buf);
             break;
         }
         if (strncmp(p, "Xfer:features:read:", 19) =3D=3D 0) {
             const char *xml;
--=20
2.19.1
