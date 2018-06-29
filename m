Received: from eggs.gnu.org ([2001:4830:134:3::10]:49785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxal-0000N3-8M
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxak-0000CE-EF
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYxak-0000Bn-9u
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 29 Jun 2018 18:53:29 +0100
Message-Id: <20180629175330.19391-11-stefanha@redhat.com>
In-Reply-To: <20180629175330.19391-1-stefanha@redhat.com>
References: <20180629175330.19391-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/11] hw/block/fdc: Convert from
 FLOPPY_DPRINTF() macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/fdc.c        | 6 +++---
 hw/block/trace-events | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index cd29e27d8f..c7b4fe9b3e 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -40,6 +40,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "trace.h"
=20
 /********************************************************/
 /* debug Floppy devices */
@@ -934,7 +935,7 @@ static uint32_t fdctrl_read (void *opaque, uint32_t r=
eg)
         retval =3D (uint32_t)(-1);
         break;
     }
-    FLOPPY_DPRINTF("read reg%d: 0x%02x\n", reg & 7, retval);
+    trace_fdc_ioport_read(reg, retval);
=20
     return retval;
 }
@@ -943,9 +944,8 @@ static void fdctrl_write (void *opaque, uint32_t reg,=
 uint32_t value)
 {
     FDCtrl *fdctrl =3D opaque;
=20
-    FLOPPY_DPRINTF("write reg%d: 0x%02x\n", reg & 7, value);
-
     reg &=3D 7;
+    trace_fdc_ioport_write(reg, value);
     switch (reg) {
     case FD_REG_DOR:
         fdctrl_write_dor(fdctrl, value);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 6b9e733412..d842c45409 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -1,5 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
=20
+# hw/block/fdc.c
+fdc_ioport_read(uint8_t reg, uint8_t value) "read reg 0x%02x val 0x%02x"
+fdc_ioport_write(uint8_t reg, uint8_t value) "write reg 0x%02x val 0x%02=
x"
+
 # hw/block/virtio-blk.c
 virtio_blk_req_complete(void *vdev, void *req, int status) "vdev %p req =
%p status %d"
 virtio_blk_rw_complete(void *vdev, void *req, int ret) "vdev %p req %p r=
et %d"
--=20
2.17.1
