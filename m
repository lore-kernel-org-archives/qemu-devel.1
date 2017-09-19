Received: from eggs.gnu.org ([2001:4830:134:3::10]:37022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du68s-0005bU-3y
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du68q-0004TR-Vq
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1du68q-0004Sz-Nt
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:56 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 18 Sep 2017 20:11:39 -0400
Message-Id: <20170919001147.23182-7-jsnow@redhat.com>
In-Reply-To: <20170919001147.23182-1-jsnow@redhat.com>
References: <20170919001147.23182-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/13] IDE: add tracing for data ports
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

To be used sparingly, but still interesting in the case of small
firmwares designed to reproduce bugs in QEMU IDE.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170901001502.29915-4-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c       | 12 +++++++++++-
 hw/ide/trace-events |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index cb250e6..82a19b1 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2259,6 +2259,8 @@ void ide_data_writew(void *opaque, uint32_t addr, u=
int32_t val)
     IDEState *s =3D idebus_active_if(bus);
     uint8_t *p;
=20
+    trace_ide_data_writew(addr, val, bus, s);
+
     /* PIO data access allowed only when DRQ bit is set. The result of a=
 write
      * during PIO out is indeterminate, just ignore it. */
     if (!(s->status & DRQ_STAT) || ide_is_pio_out(s)) {
@@ -2304,6 +2306,8 @@ uint32_t ide_data_readw(void *opaque, uint32_t addr=
)
         s->status &=3D ~DRQ_STAT;
         s->end_transfer_func(s);
     }
+
+    trace_ide_data_readw(addr, ret, bus, s);
     return ret;
 }
=20
@@ -2313,6 +2317,8 @@ void ide_data_writel(void *opaque, uint32_t addr, u=
int32_t val)
     IDEState *s =3D idebus_active_if(bus);
     uint8_t *p;
=20
+    trace_ide_data_writel(addr, val, bus, s);
+
     /* PIO data access allowed only when DRQ bit is set. The result of a=
 write
      * during PIO out is indeterminate, just ignore it. */
     if (!(s->status & DRQ_STAT) || ide_is_pio_out(s)) {
@@ -2343,7 +2349,8 @@ uint32_t ide_data_readl(void *opaque, uint32_t addr=
)
     /* PIO data access allowed only when DRQ bit is set. The result of a=
 read
      * during PIO in is indeterminate, return 0 and don't move forward. =
*/
     if (!(s->status & DRQ_STAT) || !ide_is_pio_out(s)) {
-        return 0;
+        ret =3D 0;
+        goto out;
     }
=20
     p =3D s->data_ptr;
@@ -2358,6 +2365,9 @@ uint32_t ide_data_readl(void *opaque, uint32_t addr=
)
         s->status &=3D ~DRQ_STAT;
         s->end_transfer_func(s);
     }
+
+out:
+    trace_ide_data_readl(addr, ret, bus, s);
     return ret;
 }
=20
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index bff8f39..17bc6f1 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -6,6 +6,11 @@ ide_ioport_read(uint32_t addr, const char *reg, uint32_t=
 val, void *bus, void *s
 ide_ioport_write(uint32_t addr, const char *reg, uint32_t val, void *bus=
, void *s) "IDE PIO wr @ 0x%"PRIx32" (%s); val 0x%02"PRIx32"; bus %p IDES=
tate %p"
 ide_status_read(uint32_t addr, uint32_t val, void *bus, void *s)        =
           "IDE PIO rd @ 0x%"PRIx32" (Alt Status); val 0x%02"PRIx32"; bus=
 %p; IDEState %p"
 ide_cmd_write(uint32_t addr, uint32_t val, void *bus)                   =
           "IDE PIO wr @ 0x%"PRIx32" (Device Control); val 0x%02"PRIx32";=
 bus %p"
+# Warning: verbose
+ide_data_readw(uint32_t addr, uint32_t val, void *bus, void *s)         =
           "IDE PIO rd @ 0x%"PRIx32" (Data: Word); val 0x%04"PRIx32"; bus=
 %p; IDEState %p"
+ide_data_writew(uint32_t addr, uint32_t val, void *bus, void *s)        =
           "IDE PIO wr @ 0x%"PRIx32" (Data: Word); val 0x%04"PRIx32"; bus=
 %p; IDEState %p"
+ide_data_readl(uint32_t addr, uint32_t val, void *bus, void *s)         =
           "IDE PIO rd @ 0x%"PRIx32" (Data: Long); val 0x%08"PRIx32"; bus=
 %p; IDEState %p"
+ide_data_writel(uint32_t addr, uint32_t val, void *bus, void *s)        =
           "IDE PIO wr @ 0x%"PRIx32" (Data: Long); val 0x%08"PRIx32"; bus=
 %p; IDEState %p"
 # misc
 ide_exec_cmd(void *bus, void *state, uint32_t cmd) "IDE exec cmd: bus %p=
; state %p; cmd 0x%02x"
 ide_cancel_dma_sync_buffered(void *fn, void *req) "invoking cb %p of buf=
fered request %p with -ECANCELED"
--=20
2.9.5
