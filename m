Received: from eggs.gnu.org ([209.51.188.92]:35260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gkSEM-0007Ff-Oe
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gkSEH-00046U-DT
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:22:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gkSEG-00041X-GH
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:22:28 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 18 Jan 2019 12:22:13 +0100
Message-Id: <20190118112213.11173-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH] gdbstub: Avoid NULL dereference in
 gdb_handle_packet()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@wdc.com>, Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The "Hg" GDB packet is used to select the current thread, and can fail.
GDB doesn't not check for failure and emits further packets that can
access and dereference s->c_cpu or s->g_cpu.

Add a check that returns "E22" (EINVAL) when those pointers are not set.

Peter Maydell reported:
  GDB doesn't check the "Hg" packet failures and emit a
  "qXfer:features:read" packet which accesses th
  Looking at the protocol trace from the gdb end:
  (gdb) set debug remote 1
  (gdb) target remote :1234
  Remote debugging using :1234
  Sending packet:
  $qSupported:multiprocess+;swbreak+;hwbreak+;qRelocInsn+;fork-events+;vf=
ork-events+;exec-events+;vContSupported+;QThreadEvents+;no-resumed+;xmlRe=
gisters=3Di386#6a...Ack
  Packet received: PacketSize=3D1000;qXfer:features:read+;multiprocess+
  Packet qSupported (supported-packets) is supported
  Sending packet: $vMustReplyEmpty#3a...Ack
  Packet received:
  Sending packet: $Hgp0.0#ad...Ack
  Packet received: E22
  Sending packet: $qXfer:features:read:target.xml:0,ffb#79...Ack
  [here is where QEMU crashes]

  What seems to happen is that GDB's attempt to set the
  current thread with the "Hg" command fails because
  gdb_get_cpu() fails, and so we return an E22 error status.
  GDB (incorrectly) ignores this and issues a general command
  anyway, and then QEMU crashes because we don't handle s->g_cpu
  being NULL in this command's handling code.

Fixes: c145eeae1cc
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
RFC because these are many if..break but I can't think of a cleaner way
today.
The protocol isn't specific about the error, can it be "E03" for ESRCH
(No such process)?
---
 gdbstub.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index bfc7afb509..480005b094 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1306,6 +1306,10 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
         put_packet(s, "OK");
         break;
     case '?':
+        if (!s->c_cpu) {
+            put_packet(s, "E22");
+            break;
+        }
         /* TODO: Make this return the correct value for user-mode.  */
         snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
                  gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread=
_id)));
@@ -1394,6 +1398,10 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
         /* Detach packet */
         pid =3D 1;
=20
+        if (!s->c_cpu || !s->g_cpu) {
+            put_packet(s, "E22");
+            break;
+        }
         if (s->multiprocess) {
             unsigned long lpid;
             if (*p !=3D ';') {
@@ -1429,6 +1437,10 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
         put_packet(s, "OK");
         break;
     case 's':
+        if (!s->s_cpu) {
+            put_packet(s, "E22");
+            break;
+        }
         if (*p !=3D '\0') {
             addr =3D strtoull(p, (char **)&p, 16);
             gdb_set_cpu_pc(s, addr);
@@ -1441,6 +1453,10 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
             target_ulong ret;
             target_ulong err;
=20
+            if (!s->s_cpu) {
+                put_packet(s, "E22");
+                break;
+            }
             ret =3D strtoull(p, (char **)&p, 16);
             if (*p =3D=3D ',') {
                 p++;
@@ -1463,6 +1479,10 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
         }
         break;
     case 'g':
+        if (!s->g_cpu) {
+            put_packet(s, "E22");
+            break;
+        }
         cpu_synchronize_state(s->g_cpu);
         len =3D 0;
         for (addr =3D 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
@@ -1473,6 +1493,10 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
         put_packet(s, buf);
         break;
     case 'G':
+        if (!s->g_cpu) {
+            put_packet(s, "E22");
+            break;
+        }
         cpu_synchronize_state(s->g_cpu);
         registers =3D mem_buf;
         len =3D strlen(p) / 2;
@@ -1485,6 +1509,10 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
         put_packet(s, "OK");
         break;
     case 'm':
+        if (!s->g_cpu) {
+            put_packet(s, "E22");
+            break;
+        }
         addr =3D strtoull(p, (char **)&p, 16);
         if (*p =3D=3D ',')
             p++;
@@ -1504,6 +1532,10 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
         }
         break;
     case 'M':
+        if (!s->g_cpu) {
+            put_packet(s, "E22");
+            break;
+        }
         addr =3D strtoull(p, (char **)&p, 16);
         if (*p =3D=3D ',')
             p++;
@@ -1642,6 +1674,10 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
             put_packet(s, "OK");
             break;
         } else if (strcmp(p,"C") =3D=3D 0) {
+            if (!s->g_cpu) {
+                put_packet(s, "E22");
+                break;
+            }
             /*
              * "Current thread" remains vague in the spec, so always ret=
urn
              * the first thread of the current process (gdb returns the
@@ -1745,6 +1781,10 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
             const char *xml;
             target_ulong total_len;
=20
+            if (!s->g_cpu) {
+                put_packet(s, "E22");
+                break;
+            }
             process =3D gdb_get_cpu_process(s, s->g_cpu);
             cc =3D CPU_GET_CLASS(s->g_cpu);
             if (cc->gdb_core_xml_file =3D=3D NULL) {
--=20
2.17.2
