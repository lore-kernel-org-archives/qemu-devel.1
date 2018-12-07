Received: from eggs.gnu.org ([2001:4830:134:3::10]:57458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gVC1O-00081q-A2
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gVC1H-0005Wz-DJ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:02:05 -0500
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri,  7 Dec 2018 10:01:30 +0100
Message-Id: <20181207090135.7651-13-luc.michel@greensocs.com>
In-Reply-To: <20181207090135.7651-1-luc.michel@greensocs.com>
References: <20181207090135.7651-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 12/16] gdbstub: add support for vAttach
 packets
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

Add support for the vAttach packets. In multiprocess mode, GDB sends
them to attach to additional processes.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 gdbstub.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 1cf1bea428..8601be533b 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1347,10 +1347,45 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
                     break;
                 }
                 goto unknown_command;
             }
             break;
+        } else if (strncmp(p, "Attach;", 7) =3D=3D 0) {
+            unsigned long pid;
+
+            p +=3D 7;
+
+            if (qemu_strtoul(p, &p, 16, &pid)) {
+                put_packet(s, "E22");
+                break;
+            }
+
+            process =3D gdb_get_process(s, pid);
+
+            if (process =3D=3D NULL) {
+                put_packet(s, "E22");
+                break;
+            }
+
+            cpu =3D get_first_cpu_in_process(s, process);
+
+            if (cpu =3D=3D NULL) {
+                /* Refuse to attach an empty process */
+                put_packet(s, "E22");
+                break;
+            }
+
+            process->attached =3D true;
+
+            s->g_cpu =3D cpu;
+            s->c_cpu =3D cpu;
+
+            snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRA=
P,
+                     gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_=
id)));
+
+            put_packet(s, buf);
+            break;
         } else {
             goto unknown_command;
         }
     case 'k':
         /* Kill the target */
--=20
2.19.2
