Received: from eggs.gnu.org ([2001:4830:134:3::10]:37065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du68t-0005bk-QX
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du68s-0004UZ-4p
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1du68r-0004Tc-S0
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:58 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 18 Sep 2017 20:11:41 -0400
Message-Id: <20170919001147.23182-9-jsnow@redhat.com>
In-Reply-To: <20170919001147.23182-1-jsnow@redhat.com>
References: <20170919001147.23182-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/13] IDE: replace DEBUG_AIO with trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170901001502.29915-6-jsnow@redhat.com
[Edited enum conditional for Clang --js]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/atapi.c            |  5 +----
 hw/ide/core.c             | 24 +++++++++++++++++-------
 hw/ide/trace-events       |  3 +++
 include/hw/ide/internal.h |  7 +++++--
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 9b84a1b..c0509c8 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -416,10 +416,7 @@ static void ide_atapi_cmd_read_dma_cb(void *opaque, =
int ret)
         s->io_buffer_size =3D n * 2048;
         data_offset =3D 0;
     }
-#ifdef DEBUG_AIO
-    printf("aio_read_cd: lba=3D%u n=3D%d\n", s->lba, n);
-#endif
-
+    trace_ide_atapi_cmd_read_dma_cb_aio(s, s->lba, n);
     s->bus->dma->iov.iov_base =3D (void *)(s->io_buffer + data_offset);
     s->bus->dma->iov.iov_len =3D n * ATAPI_SECTOR_SIZE;
     qemu_iovec_init_external(&s->bus->dma->qiov, &s->bus->dma->iov, 1);
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 82a19b1..b71ee4f 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -58,6 +58,21 @@ static const int smart_attributes[][12] =3D {
     { 190,  0x03, 0x00, 0x45, 0x45, 0x1f, 0x00, 0x1f, 0x1f, 0x00, 0x00, =
0x32},
 };
=20
+const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT] =3D {
+    [IDE_DMA_READ] =3D "DMA READ",
+    [IDE_DMA_WRITE] =3D "DMA WRITE",
+    [IDE_DMA_TRIM] =3D "DMA TRIM",
+    [IDE_DMA_ATAPI] =3D "DMA ATAPI"
+};
+
+static const char *IDE_DMA_CMD_str(enum ide_dma_cmd enval)
+{
+    if (enval >=3D IDE_DMA__BEGIN && enval < IDE_DMA__COUNT) {
+        return IDE_DMA_CMD_lookup[enval];
+    }
+    return "DMA UNKNOWN CMD";
+}
+
 static void ide_dummy_transfer_stop(IDEState *s);
=20
 static void padstr(char *str, const char *src, int len)
@@ -860,10 +875,7 @@ static void ide_dma_cb(void *opaque, int ret)
         goto eot;
     }
=20
-#ifdef DEBUG_AIO
-    printf("ide_dma_cb: sector_num=3D%" PRId64 " n=3D%d, cmd_cmd=3D%d\n"=
,
-           sector_num, n, s->dma_cmd);
-#endif
+    trace_ide_dma_cb(s, sector_num, n, IDE_DMA_CMD_str(s->dma_cmd));
=20
     if ((s->dma_cmd =3D=3D IDE_DMA_READ || s->dma_cmd =3D=3D IDE_DMA_WRI=
TE) &&
         !ide_sect_range_ok(s, sector_num, n)) {
@@ -2391,9 +2403,7 @@ void ide_bus_reset(IDEBus *bus)
=20
     /* pending async DMA */
     if (bus->dma->aiocb) {
-#ifdef DEBUG_AIO
-        printf("aio_cancel\n");
-#endif
+        trace_ide_bus_reset_aio();
         blk_aio_cancel(bus->dma->aiocb);
         bus->dma->aiocb =3D NULL;
     }
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 8c79a6c..cc8949c 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -18,6 +18,8 @@ ide_cancel_dma_sync_remaining(void) "draining all remai=
ning requests"
 ide_sector_read(int64_t sector_num, int nsectors) "sector=3D%"PRId64" ns=
ectors=3D%d"
 ide_sector_write(int64_t sector_num, int nsectors) "sector=3D%"PRId64" n=
sectors=3D%d"
 ide_reset(void *s) "IDEstate %p"
+ide_bus_reset_aio(void) "aio_cancel"
+ide_dma_cb(void *s, int64_t sector_num, int n, const char *dma) "IDEStat=
e %p; sector_num=3D%"PRId64" n=3D%d cmd=3D%s"
=20
 # BMDMA HBAs:
=20
@@ -51,5 +53,6 @@ ide_atapi_cmd_reply_end_new(void *s, int status) "IDESt=
ate: %p; new transfer sta
 ide_atapi_cmd_check_status(void *s) "IDEState: %p"
 ide_atapi_cmd_read(void *s, const char *method, int lba, int nb_sectors)=
 "IDEState: %p; read %s: LBA=3D%d nb_sectors=3D%d"
 ide_atapi_cmd(void *s, uint8_t cmd) "IDEState: %p; cmd: 0x%02x"
+ide_atapi_cmd_read_dma_cb_aio(void *s, int lba, int n) "IDEState: %p; ai=
o read: lba=3D%d n=3D%d"
 # Warning: Verbose
 ide_atapi_cmd_packet(void *s, uint16_t limit, const char *packet) "IDESt=
ate: %p; limit=3D0x%x packet: %s"
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 74efe8a..5b30d7a 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -14,7 +14,6 @@
 #include "block/scsi.h"
=20
 /* debug IDE devices */
-//#define DEBUG_AIO
 #define USE_DMA_CDROM
=20
 typedef struct IDEBus IDEBus;
@@ -333,12 +332,16 @@ struct unreported_events {
 };
=20
 enum ide_dma_cmd {
-    IDE_DMA_READ,
+    IDE_DMA__BEGIN =3D 0,
+    IDE_DMA_READ =3D IDE_DMA__BEGIN,
     IDE_DMA_WRITE,
     IDE_DMA_TRIM,
     IDE_DMA_ATAPI,
+    IDE_DMA__COUNT
 };
=20
+extern const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT];
+
 #define ide_cmd_is_read(s) \
 	((s)->dma_cmd =3D=3D IDE_DMA_READ)
=20
--=20
2.9.5
