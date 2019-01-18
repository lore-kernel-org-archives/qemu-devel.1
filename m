Received: from eggs.gnu.org ([209.51.188.92]:58365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkXzR-0002vD-Hy
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkXzQ-0003Y5-E8
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:31:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55835)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gkXzQ-0003EF-29
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:31:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B421DB947
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 17:31:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 18 Jan 2019 17:31:00 +0000
Message-Id: <20190118173103.4903-2-berrange@redhat.com>
In-Reply-To: <20190118173103.4903-1-berrange@redhat.com>
References: <20190118173103.4903-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/4] display: ensure qxl log_buf is a nul
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

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

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/display/qxl.c        | 3 ++-
 hw/display/trace-events | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 8e9a65e75b..eefdf4baac 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1763,7 +1763,8 @@ async_common:
         qxl_set_mode(d, val, 0);
         break;
     case QXL_IO_LOG:
-        trace_qxl_io_log(d->id, d->ram->log_buf);
+        d->ram->log_buf[sizeof(d->ram->log_buf) - 1] =3D '\0';
+        trace_qxl_io_log(d->id, (const char *)d->ram->log_buf);
         if (d->guestdebug) {
             fprintf(stderr, "qxl/guest-%d: %" PRId64 ": %s", d->id,
                     qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), d->ram->log_b=
uf);
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
