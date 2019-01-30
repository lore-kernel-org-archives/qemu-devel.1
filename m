Received: from eggs.gnu.org ([209.51.188.92]:34920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gogOf-0004ym-RO
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gogOe-0006dV-T1
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:18:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gogOe-0006dB-LL
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:18:40 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 30 Jan 2019 11:18:12 +0800
Message-Id: <20190130031817.27780-2-stefanha@redhat.com>
In-Reply-To: <20190130031817.27780-1-stefanha@redhat.com>
References: <20190130031817.27780-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/6] display: ensure qxl log_buf is a nul
 terminated string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The QXL_IO_LOG command allows the guest to send log messages to the host
via a buffer in the QXLRam struct. QEMU prints these to the console if
the qxl 'guestdebug' option is set to non-zero. It will also feed them
to the trace subsystem if any backends are built-in.

In both cases the log_buf data will get treated as being as a nul
terminated string, by the printf '%s' format specifier and / or other
code reading the buffer.

QEMU does nothing to guarantee that the log_buf really is nul terminated,
so there is potential for out of bounds array access.

This would affect any QEMU which has the log, syslog or ftrace trace
backends built into QEMU. It can only be triggered if the 'qxl_io_log'
trace event is enabled, however, so they are not vulnerable without
specific administrative action to enable this.

It would also affect QEMU if the 'guestdebug' parameter is set to a
non-zero value, which again is not the default and requires explicit
admin opt-in.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190123120016.4538-2-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/display/qxl.c        | 14 ++++++++++----
 hw/display/trace-events |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 8e9a65e75b..da8fd5a40a 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1763,10 +1763,16 @@ async_common:
         qxl_set_mode(d, val, 0);
         break;
     case QXL_IO_LOG:
-        trace_qxl_io_log(d->id, d->ram->log_buf);
-        if (d->guestdebug) {
-            fprintf(stderr, "qxl/guest-%d: %" PRId64 ": %s", d->id,
-                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), d->ram->log_b=
uf);
+        if (TRACE_QXL_IO_LOG_ENABLED || d->guestdebug) {
+            /* We cannot trust the guest to NUL terminate d->ram->log_bu=
f */
+            char *log_buf =3D g_strndup((const char *)d->ram->log_buf,
+                                      sizeof(d->ram->log_buf));
+            trace_qxl_io_log(d->id, log_buf);
+            if (d->guestdebug) {
+                fprintf(stderr, "qxl/guest-%d: %" PRId64 ": %s", d->id,
+                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), log_buf);
+            }
+            g_free(log_buf);
         }
         break;
     case QXL_IO_RESET:
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 5a48c6cb6a..387c6b8931 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -72,7 +72,7 @@ qxl_interface_update_area_complete_rest(int qid, uint32=
_t num_updated_rects) "%d
 qxl_interface_update_area_complete_overflow(int qid, int max) "%d max=3D=
%d"
 qxl_interface_update_area_complete_schedule_bh(int qid, uint32_t num_dir=
ty) "%d #dirty=3D%d"
 qxl_io_destroy_primary_ignored(int qid, const char *mode) "%d %s"
-qxl_io_log(int qid, const uint8_t *log_buf) "%d %s"
+qxl_io_log(int qid, const char *log_buf) "%d %s"
 qxl_io_read_unexpected(int qid) "%d"
 qxl_io_unexpected_vga_mode(int qid, uint64_t addr, uint64_t val, const c=
har *desc) "%d 0x%"PRIx64"=3D%"PRIu64" (%s)"
 qxl_io_write(int qid, const char *mode, uint64_t addr, const char *aname=
, uint64_t val, unsigned size, int async) "%d %s addr=3D%"PRIu64 " (%s) v=
al=3D%"PRIu64" size=3D%u async=3D%d"
--=20
2.20.1
