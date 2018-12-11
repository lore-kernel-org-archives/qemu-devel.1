Received: from eggs.gnu.org ([2001:4830:134:3::10]:37630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gWkwF-0008RU-IB
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gWkwE-0004s2-Bx
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:31:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gWkwE-0004rj-3N
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:31:14 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 11 Dec 2018 17:31:05 +0100
Message-Id: <20181211163105.31834-3-lvivier@redhat.com>
In-Reply-To: <20181211163105.31834-1-lvivier@redhat.com>
References: <20181211163105.31834-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] scsi-generic: Convert from DPRINTF()
 macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/scsi/scsi-generic.c | 56 ++++++++++++++++++++----------------------
 hw/scsi/trace-events   | 11 +++++++++
 2 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 7237b4162e..842f8e0893 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -18,21 +18,10 @@
 #include "hw/scsi/scsi.h"
 #include "hw/scsi/emulation.h"
 #include "sysemu/block-backend.h"
+#include "trace.h"
=20
 #ifdef __linux__
=20
-//#define DEBUG_SCSI
-
-#ifdef DEBUG_SCSI
-#define DPRINTF(fmt, ...) \
-do { printf("scsi-generic: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
-
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "scsi-generic: " fmt , ## __VA_ARGS__); } while (0)
-
 #include <scsi/sg.h>
 #include "scsi/constants.h"
=20
@@ -98,8 +87,7 @@ static void scsi_command_complete_noio(SCSIGenericReq *=
r, int ret)
         }
     }
=20
-    DPRINTF("Command complete 0x%p tag=3D0x%x status=3D%d\n",
-            r, r->req.tag, status);
+    trace_scsi_generic_command_complete_noio(r, r->req.tag, status);
=20
     scsi_req_complete(&r->req, status);
 done:
@@ -259,7 +247,7 @@ static void scsi_read_complete(void * opaque, int ret=
)
     }
=20
     len =3D r->io_header.dxfer_len - r->io_header.resid;
-    DPRINTF("Data ready tag=3D0x%x len=3D%d\n", r->req.tag, len);
+    trace_scsi_generic_read_complete(r->req.tag, len);
=20
     r->len =3D -1;
=20
@@ -335,7 +323,7 @@ static void scsi_read_data(SCSIRequest *req)
     SCSIDevice *s =3D r->req.dev;
     int ret;
=20
-    DPRINTF("scsi_read_data tag=3D0x%x\n", req->tag);
+    trace_scsi_generic_read_data(req->tag);
=20
     /* The request is used as the AIO opaque value, so add a ref.  */
     scsi_req_ref(&r->req);
@@ -356,7 +344,7 @@ static void scsi_write_complete(void * opaque, int re=
t)
     SCSIGenericReq *r =3D (SCSIGenericReq *)opaque;
     SCSIDevice *s =3D r->req.dev;
=20
-    DPRINTF("scsi_write_complete() ret =3D %d\n", ret);
+    trace_scsi_generic_write_complete(ret);
=20
     assert(r->req.aiocb !=3D NULL);
     r->req.aiocb =3D NULL;
@@ -371,7 +359,7 @@ static void scsi_write_complete(void * opaque, int re=
t)
     if (r->req.cmd.buf[0] =3D=3D MODE_SELECT && r->req.cmd.buf[4] =3D=3D=
 12 &&
         s->type =3D=3D TYPE_TAPE) {
         s->blocksize =3D (r->buf[9] << 16) | (r->buf[10] << 8) | r->buf[=
11];
-        DPRINTF("block size %d\n", s->blocksize);
+        trace_scsi_generic_write_complete_blocksize(s->blocksize);
     }
=20
     scsi_command_complete_noio(r, ret);
@@ -388,7 +376,7 @@ static void scsi_write_data(SCSIRequest *req)
     SCSIDevice *s =3D r->req.dev;
     int ret;
=20
-    DPRINTF("scsi_write_data tag=3D0x%x\n", req->tag);
+    trace_scsi_generic_write_data(req->tag);
     if (r->len =3D=3D 0) {
         r->len =3D r->buflen;
         scsi_req_data(&r->req, r->len);
@@ -411,6 +399,21 @@ static uint8_t *scsi_get_buf(SCSIRequest *req)
     return r->buf;
 }
=20
+static void scsi_generic_command_dump(uint8_t *cmd, int len)
+{
+    int i;
+    char *line_buffer, *p;
+
+    line_buffer =3D g_malloc(len * 5 + 1);
+
+    for (i =3D 0, p =3D line_buffer; i < len; i++) {
+        p +=3D sprintf(p, " 0x%02x", cmd[i]);
+    }
+    trace_scsi_generic_send_command(line_buffer);
+
+    g_free(line_buffer);
+}
+
 /* Execute a scsi command.  Returns the length of the data expected by t=
he
    command.  This will be Positive for data transfers from the device
    (eg. disk reads), negative for transfers to the device (eg. disk writ=
es),
@@ -422,16 +425,9 @@ static int32_t scsi_send_command(SCSIRequest *req, u=
int8_t *cmd)
     SCSIDevice *s =3D r->req.dev;
     int ret;
=20
-#ifdef DEBUG_SCSI
-    DPRINTF("Command: data=3D0x%02x", cmd[0]);
-    {
-        int i;
-        for (i =3D 1; i < r->req.cmd.len; i++) {
-            printf(" 0x%02x", cmd[i]);
-        }
-        printf("\n");
+    if (trace_event_get_state_backends(TRACE_SCSI_GENERIC_SEND_COMMAND))=
 {
+        scsi_generic_command_dump(cmd, r->req.cmd.len);
     }
-#endif
=20
     if (r->req.cmd.xfer =3D=3D 0) {
         g_free(r->buf);
@@ -693,7 +689,7 @@ static void scsi_generic_realize(SCSIDevice *s, Error=
 **errp)
=20
     /* define device state */
     s->type =3D scsiid.scsi_type;
-    DPRINTF("device type %d\n", s->type);
+    trace_scsi_generic_realize_type(s->type);
=20
     switch (s->type) {
     case TYPE_TAPE:
@@ -716,7 +712,7 @@ static void scsi_generic_realize(SCSIDevice *s, Error=
 **errp)
         break;
     }
=20
-    DPRINTF("block size %d\n", s->blocksize);
+    trace_scsi_generic_realize_blocksize(s->blocksize);
=20
     /* Only used by scsi-block, but initialize it nevertheless to be cle=
an.  */
     s->default_scsi_version =3D -1;
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index e9625f790c..3c2fd7f52f 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -320,3 +320,14 @@ scsi_disk_emulate_command_UNKNOWN(int cmd, const cha=
r *name) "Unknown SCSI comma
 scsi_disk_dma_command_READ(uint64_t lba, uint32_t len) "Read (sector %" =
PRId64 ", count %u)"
 scsi_disk_dma_command_WRITE(const char *cmd, uint64_t lba, int len) "Wri=
te %s(sector %" PRId64 ", count %u)"
 scsi_disk_new_request(uint32_t lun, uint32_t tag, const char *line) "Com=
mand: lun=3D%d tag=3D0x%x data=3D%s"
+
+# hw/scsi/scsi-generic.c
+scsi_generic_command_complete_noio(void *req, uint32_t tag, int statuc) =
"Command complete %p tag=3D0x%x status=3D%d"
+scsi_generic_read_complete(uint32_t tag, int len) "Data ready tag=3D0x%x=
 len=3D%d"
+scsi_generic_read_data(uint32_t tag) "scsi_read_data tag=3D0x%x"
+scsi_generic_write_complete(int ret) "scsi_write_complete() ret =3D %d"
+scsi_generic_write_complete_blocksize(int blocksize) "block size %d"
+scsi_generic_write_data(uint32_t tag) "scsi_write_data tag=3D0x%x"
+scsi_generic_send_command(const char *line) "Command: data=3D%s"
+scsi_generic_realize_type(int type) "device type %d"
+scsi_generic_realize_blocksize(int blocksize) "block size %d"
--=20
2.19.2
