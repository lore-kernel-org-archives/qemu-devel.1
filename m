Received: from eggs.gnu.org ([2001:4830:134:3::10]:35252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1g6wpn-0002kQ-GZ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1g6wpm-00061o-Lp
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:57:55 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Mon,  1 Oct 2018 13:57:02 +0200
Message-Id: <20181001115704.701-14-luc.michel@greensocs.com>
In-Reply-To: <20181001115704.701-1-luc.michel@greensocs.com>
References: <20181001115704.701-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/15] gdbstub: gdb_set_stop_cpu: ignore
 request when process is not attached
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

When gdb_set_stop_cpu() is called with a CPU associated to a process
currently not attached by the GDB client, return without modifying the
stop CPU. Otherwise, GDB get confused if it receives packets with a
thread-id it does not know about.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 gdbstub.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index c27a3edf1d..51cc11981e 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1763,10 +1763,19 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
     return RS_IDLE;
 }
=20
 void gdb_set_stop_cpu(CPUState *cpu)
 {
+    GDBProcess *p =3D gdb_get_cpu_process(gdbserver_state, cpu);
+
+    if (!p->attached) {
+        /* Having a stop CPU corresponding to a process that is not atta=
ched
+         * confuses GDB. So we ignore the request.
+         */
+        return;
+    }
+
     gdbserver_state->c_cpu =3D cpu;
     gdbserver_state->g_cpu =3D cpu;
 }
=20
 #ifndef CONFIG_USER_ONLY
--=20
2.19.0
