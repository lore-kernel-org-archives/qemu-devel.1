Received: from eggs.gnu.org ([2001:4830:134:3::10]:49827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxas-0000V3-Qe
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxan-0000FN-R7
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:54:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42180 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYxan-0000Ev-Kl
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 29 Jun 2018 18:53:30 +0100
Message-Id: <20180629175330.19391-12-stefanha@redhat.com>
In-Reply-To: <20180629175330.19391-1-stefanha@redhat.com>
References: <20180629175330.19391-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/11] hw/block/pflash_cfi: Convert from
 DPRINTF() macro to trace events
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
[Fixed lx -> PRIx64 as suggested by Philippe.
--Stefan]
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/pflash_cfi01.c | 42 +++++++++++++++--------------------------
 hw/block/pflash_cfi02.c | 18 +++++++++---------
 hw/block/trace-events   | 13 +++++++++++++
 3 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index e4b5b3c273..bffb4c40e7 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -47,6 +47,7 @@
 #include "qemu/log.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
+#include "trace.h"
=20
 #define PFLASH_BUG(fmt, ...) \
 do { \
@@ -120,7 +121,7 @@ static void pflash_timer (void *opaque)
 {
     pflash_t *pfl =3D opaque;
=20
-    DPRINTF("%s: command %02x done\n", __func__, pfl->cmd);
+    trace_pflash_timer_expired(pfl->cmd);
     /* Reset flash */
     pfl->status ^=3D 0x80;
     memory_region_rom_device_set_romd(&pfl->mem, true);
@@ -218,15 +219,14 @@ static uint32_t pflash_devid_query(pflash_t *pfl, h=
waddr offset)
     switch (boff & 0xFF) {
     case 0:
         resp =3D pfl->ident0;
-        DPRINTF("%s: Manufacturer Code %04x\n", __func__, resp);
+        trace_pflash_manufacturer_id(resp);
         break;
     case 1:
         resp =3D pfl->ident1;
-        DPRINTF("%s: Device ID Code %04x\n", __func__, resp);
+        trace_pflash_device_id(resp);
         break;
     default:
-        DPRINTF("%s: Read Device Information offset=3D%x\n", __func__,
-                (unsigned)offset);
+        trace_pflash_device_info(offset);
         return 0;
         break;
     }
@@ -251,8 +251,7 @@ static uint32_t pflash_data_read(pflash_t *pfl, hwadd=
r offset,
     switch (width) {
     case 1:
         ret =3D p[offset];
-        DPRINTF("%s: data offset " TARGET_FMT_plx " %02x\n",
-                __func__, offset, ret);
+        trace_pflash_data_read8(offset, ret);
         break;
     case 2:
         if (be) {
@@ -262,8 +261,7 @@ static uint32_t pflash_data_read(pflash_t *pfl, hwadd=
r offset,
             ret =3D p[offset];
             ret |=3D p[offset + 1] << 8;
         }
-        DPRINTF("%s: data offset " TARGET_FMT_plx " %04x\n",
-                __func__, offset, ret);
+        trace_pflash_data_read16(offset, ret);
         break;
     case 4:
         if (be) {
@@ -277,8 +275,7 @@ static uint32_t pflash_data_read(pflash_t *pfl, hwadd=
r offset,
             ret |=3D p[offset + 2] << 16;
             ret |=3D p[offset + 3] << 24;
         }
-        DPRINTF("%s: data offset " TARGET_FMT_plx " %08x\n",
-                __func__, offset, ret);
+        trace_pflash_data_read32(offset, ret);
         break;
     default:
         DPRINTF("BUG in %s\n", __func__);
@@ -294,11 +291,7 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr o=
ffset,
     uint32_t ret;
=20
     ret =3D -1;
-
-#if 0
-    DPRINTF("%s: reading offset " TARGET_FMT_plx " under cmd %02x width =
%d\n",
-            __func__, offset, pfl->cmd, width);
-#endif
+    trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
     switch (pfl->cmd) {
     default:
         /* This should never happen : reset state & treat it as a read *=
/
@@ -349,15 +342,14 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr =
offset,
             switch (boff) {
             case 0:
                 ret =3D pfl->ident0 << 8 | pfl->ident1;
-                DPRINTF("%s: Manufacturer Code %04x\n", __func__, ret);
+                trace_pflash_manufacturer_id(ret);
                 break;
             case 1:
                 ret =3D pfl->ident2 << 8 | pfl->ident3;
-                DPRINTF("%s: Device ID Code %04x\n", __func__, ret);
+                trace_pflash_device_id(ret);
                 break;
             default:
-                DPRINTF("%s: Read Device Information boff=3D%x\n", __fun=
c__,
-                        (unsigned)boff);
+                trace_pflash_device_info(boff);
                 ret =3D 0;
                 break;
             }
@@ -425,9 +417,7 @@ static inline void pflash_data_write(pflash_t *pfl, h=
waddr offset,
 {
     uint8_t *p =3D pfl->storage;
=20
-    DPRINTF("%s: block write offset " TARGET_FMT_plx
-            " value %x counter %016" PRIx64 "\n",
-            __func__, offset, value, pfl->counter);
+    trace_pflash_data_write(offset, value, width, pfl->counter);
     switch (width) {
     case 1:
         p[offset] =3D value;
@@ -466,9 +456,7 @@ static void pflash_write(pflash_t *pfl, hwaddr offset=
,
=20
     cmd =3D value;
=20
-    DPRINTF("%s: writing offset " TARGET_FMT_plx " value %08x width %d w=
cycle 0x%x\n",
-            __func__, offset, value, width, pfl->wcycle);
-
+    trace_pflash_write(offset, value, width, pfl->wcycle);
     if (!pfl->wcycle) {
         /* Set the device in I/O access mode */
         memory_region_rom_device_set_romd(&pfl->mem, false);
@@ -656,8 +644,8 @@ static void pflash_write(pflash_t *pfl, hwaddr offset=
,
                   "\n", __func__, offset, pfl->wcycle, pfl->cmd, value);
=20
  reset_flash:
+    trace_pflash_reset();
     memory_region_rom_device_set_romd(&pfl->mem, true);
-
     pfl->wcycle =3D 0;
     pfl->cmd =3D 0;
 }
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 6c18e5e578..0f8b7b8c7b 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -43,6 +43,7 @@
 #include "sysemu/block-backend.h"
 #include "qemu/host-utils.h"
 #include "hw/sysbus.h"
+#include "trace.h"
=20
 //#define PFLASH_DEBUG
 #ifdef PFLASH_DEBUG
@@ -124,7 +125,7 @@ static void pflash_timer (void *opaque)
 {
     pflash_t *pfl =3D opaque;
=20
-    DPRINTF("%s: command %02x done\n", __func__, pfl->cmd);
+    trace_pflash_timer_expired(pfl->cmd);
     /* Reset flash */
     pfl->status ^=3D 0x80;
     if (pfl->bypass) {
@@ -143,8 +144,8 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr of=
fset,
     uint32_t ret;
     uint8_t *p;
=20
-    DPRINTF("%s: offset " TARGET_FMT_plx "\n", __func__, offset);
     ret =3D -1;
+    trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
     /* Lazy reset to ROMD mode after a certain amount of read accesses *=
/
     if (!pfl->rom_mode && pfl->wcycle =3D=3D 0 &&
         ++pfl->read_counter > PFLASH_LAZY_ROMD_THRESHOLD) {
@@ -172,7 +173,7 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr of=
fset,
         switch (width) {
         case 1:
             ret =3D p[offset];
-//            DPRINTF("%s: data offset %08x %02x\n", __func__, offset, r=
et);
+            trace_pflash_data_read8(offset, ret);
             break;
         case 2:
             if (be) {
@@ -182,7 +183,7 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr of=
fset,
                 ret =3D p[offset];
                 ret |=3D p[offset + 1] << 8;
             }
-//            DPRINTF("%s: data offset %08x %04x\n", __func__, offset, r=
et);
+            trace_pflash_data_read16(offset, ret);
             break;
         case 4:
             if (be) {
@@ -196,7 +197,7 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr of=
fset,
                 ret |=3D p[offset + 2] << 16;
                 ret |=3D p[offset + 3] << 24;
             }
-//            DPRINTF("%s: data offset %08x %08x\n", __func__, offset, r=
et);
+            trace_pflash_data_read32(offset, ret);
             break;
         }
         break;
@@ -274,8 +275,7 @@ static void pflash_write (pflash_t *pfl, hwaddr offse=
t,
 #endif
         goto reset_flash;
     }
-    DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d %d\n", __func__,
-            offset, value, width, pfl->wcycle);
+    trace_pflash_write(offset, value, width, pfl->wcycle);
     offset &=3D pfl->chip_len - 1;
=20
     DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d\n", __func__,
@@ -345,8 +345,7 @@ static void pflash_write (pflash_t *pfl, hwaddr offse=
t,
             /* We need another unlock sequence */
             goto check_unlock0;
         case 0xA0:
-            DPRINTF("%s: write data offset " TARGET_FMT_plx " %08x %d\n"=
,
-                    __func__, offset, value, width);
+            trace_pflash_data_write(offset, value, width, 0);
             p =3D pfl->storage;
             if (!pfl->ro) {
                 switch (width) {
@@ -483,6 +482,7 @@ static void pflash_write (pflash_t *pfl, hwaddr offse=
t,
=20
     /* Reset flash */
  reset_flash:
+    trace_pflash_reset();
     pfl->bypass =3D 0;
     pfl->wcycle =3D 0;
     pfl->cmd =3D 0;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index d842c45409..335c092450 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -4,6 +4,19 @@
 fdc_ioport_read(uint8_t reg, uint8_t value) "read reg 0x%02x val 0x%02x"
 fdc_ioport_write(uint8_t reg, uint8_t value) "write reg 0x%02x val 0x%02=
x"
=20
+# hw/block/pflash_cfi0?.c
+pflash_reset(void) "reset"
+pflash_read(uint64_t offset, uint8_t cmd, int width, uint8_t wcycle) "of=
fset:0x%04"PRIx64" cmd:0x%02x width:%d wcycle:%u"
+pflash_write(uint64_t offset, uint32_t value, int width, uint8_t wcycle)=
 "offset:0x%04"PRIx64" value:0x%03x width:%d wcycle:%u"
+pflash_timer_expired(uint8_t cmd) "command 0x%02x done"
+pflash_data_read8(uint64_t offset, uint32_t value) "data offset:0x%04"PR=
Ix64" value:0x%02x"
+pflash_data_read16(uint64_t offset, uint32_t value) "data offset:0x%04"P=
RIx64" value:0x%04x"
+pflash_data_read32(uint64_t offset, uint32_t value) "data offset:0x%04"P=
RIx64" value:0x%08x"
+pflash_data_write(uint64_t offset, uint32_t value, int width, uint64_t c=
ounter) "data offset:0x%04"PRIx64" value:0x%08x width:%d counter:0x%016"P=
RIx64
+pflash_manufacturer_id(uint16_t id) "Read Manufacturer ID: 0x%04x"
+pflash_device_id(uint16_t id) "Read Device ID: 0x%04x"
+pflash_device_info(uint64_t offset) "Read Device Information offset:0x%0=
4"PRIx64
+
 # hw/block/virtio-blk.c
 virtio_blk_req_complete(void *vdev, void *req, int status) "vdev %p req =
%p status %d"
 virtio_blk_rw_complete(void *vdev, void *req, int ret) "vdev %p req %p r=
et %d"
--=20
2.17.1
