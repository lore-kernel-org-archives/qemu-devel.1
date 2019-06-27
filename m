Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FE2C004E6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9C420828
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9C420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgbNT-0007aG-Eh
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 16:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46819)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgb32-0004ND-7z
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgb2y-000376-1z
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:31:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40264)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hgb2d-0002U8-9l; Thu, 27 Jun 2019 16:30:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 411DD30054AB;
 Thu, 27 Jun 2019 20:30:46 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F4F86012D;
 Thu, 27 Jun 2019 20:30:36 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 22:27:15 +0200
Message-Id: <20190627202719.17739-25-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-1-philmd@redhat.com>
References: <20190627202719.17739-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 27 Jun 2019 20:30:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 24/28] hw/block/pflash_cfi02: Implement
 erase suspend/resume
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stephen Checkoway <stephen.checkoway@oberlin.edu>

During a sector erase (but not a chip erase), the embeded erase program
can be suspended. Once suspended, the sectors not selected for erasure
may be read and programmed. Autoselect mode is allowed during erase
suspend mode. Presumably, CFI queries are similarly allowed so this
commit allows them as well.

Since guest firmware can use status bits DQ7, DQ6, DQ3, and DQ2 to
determine the current state of sector erasure, these bits are properly
implemented.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190426162624.55977-10-stephen.checkoway@oberlin.edu>
[PMD: Rebased]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c   | 154 ++++++++++++++++++++++++++++++++++----
 tests/pflash-cfi02-test.c | 110 +++++++++++++++++++++++++++
 2 files changed, 250 insertions(+), 14 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 5874bd55ad..a3665da3b8 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -30,7 +30,6 @@
  *
  * It does not support flash interleaving.
  * It does not implement software data protection as found in many real =
chips
- * It does not implement erase suspend/resume commands
  */
=20
 #include "qemu/osdep.h"
@@ -38,6 +37,7 @@
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
 #include "qapi/error.h"
+#include "qemu/bitmap.h"
 #include "qemu/timer.h"
 #include "sysemu/block-backend.h"
 #include "qemu/host-utils.h"
@@ -76,6 +76,7 @@ struct PFlashCFI02 {
     BlockBackend *blk;
     uint32_t uniform_nb_blocs;
     uint32_t uniform_sector_len;
+    uint32_t total_sectors;
     uint32_t nb_blocs[PFLASH_MAX_ERASE_REGIONS];
     uint32_t sector_len[PFLASH_MAX_ERASE_REGIONS];
     uint32_t chip_len;
@@ -106,6 +107,8 @@ struct PFlashCFI02 {
     int rom_mode;
     int read_counter; /* used for lazy switch-back to rom mode */
     int sectors_to_erase;
+    uint64_t erase_time_remaining;
+    unsigned long *sector_erase_map;
     char *name;
     void *storage;
 };
@@ -151,6 +154,14 @@ static inline void reset_dq3(PFlashCFI02 *pfl)
     pfl->status &=3D ~0x08;
 }
=20
+/*
+ * Toggle status bit DQ2.
+ */
+static inline void toggle_dq2(PFlashCFI02 *pfl)
+{
+    pfl->status ^=3D 0x04;
+}
+
 /*
  * Set up replicated mappings of the same region.
  */
@@ -179,6 +190,29 @@ static size_t pflash_regions_count(PFlashCFI02 *pfl)
     return pfl->cfi_table[0x2c];
 }
=20
+/*
+ * Returns the time it takes to erase the number of sectors scheduled fo=
r
+ * erasure based on CFI address 0x21 which is "Typical timeout per indiv=
idual
+ * block erase 2^N ms."
+ */
+static uint64_t pflash_erase_time(PFlashCFI02 *pfl)
+{
+    /*
+     * If there are no sectors to erase (which can happen if all of the =
sectors
+     * to be erased are protected), then erase takes 100 us. Protected s=
ectors
+     * aren't supported so this should never happen.
+     */
+    return ((1ULL << pfl->cfi_table[0x21]) * pfl->sectors_to_erase) * SC=
ALE_US;
+}
+
+/*
+ * Returns true if the device is currently in erase suspend mode.
+ */
+static inline bool pflash_erase_suspend_mode(PFlashCFI02 *pfl)
+{
+    return pfl->erase_time_remaining > 0;
+}
+
 static void pflash_timer(void *opaque)
 {
     PFlashCFI02 *pfl =3D opaque;
@@ -193,12 +227,7 @@ static void pflash_timer(void *opaque)
          */
         if ((pfl->status & 0x08) =3D=3D 0) {
             assert_dq3(pfl);
-            /*
-             * CFI address 0x21 is "Typical timeout per individual block=
 erase
-             * 2^N ms"
-             */
-            uint64_t timeout =3D ((1ULL << pfl->cfi_table[0x21]) *
-                                pfl->sectors_to_erase) * 1000000;
+            uint64_t timeout =3D pflash_erase_time(pfl);
             timer_mod(&pfl->timer,
                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + timeout);
             DPRINTF("%s: erase timeout fired; erasing %d sectors\n",
@@ -206,6 +235,7 @@ static void pflash_timer(void *opaque)
             return;
         }
         DPRINTF("%s: sector erase complete\n", __func__);
+        bitmap_zero(pfl->sector_erase_map, pfl->total_sectors);
         pfl->sectors_to_erase =3D 0;
         reset_dq3(pfl);
     }
@@ -233,24 +263,44 @@ static uint64_t pflash_data_read(PFlashCFI02 *pfl, =
hwaddr offset,
     return ret;
 }
=20
+typedef struct {
+    uint32_t len;
+    uint32_t num;
+} SectorInfo;
+
 /*
  * offset should be a byte offset of the QEMU device and _not_ a device
  * offset.
  */
-static uint32_t pflash_sector_len(PFlashCFI02 *pfl, hwaddr offset)
+static SectorInfo pflash_sector_info(PFlashCFI02 *pfl, hwaddr offset)
 {
     assert(offset < pfl->chip_len);
     hwaddr addr =3D 0;
+    uint32_t sector_num =3D 0;
     for (int i =3D 0; i < pflash_regions_count(pfl); ++i) {
         uint64_t region_size =3D (uint64_t)pfl->nb_blocs[i] * pfl->secto=
r_len[i];
         if (addr <=3D offset && offset < addr + region_size) {
-            return pfl->sector_len[i];
+            return (SectorInfo) {
+                .len =3D pfl->sector_len[i],
+                .num =3D sector_num + (offset - addr) / pfl->sector_len[=
i],
+            };
         }
+        sector_num +=3D pfl->nb_blocs[i];
         addr +=3D region_size;
     }
     abort();
 }
=20
+/*
+ * Returns true if the offset refers to a flash sector that is currently=
 being
+ * erased.
+ */
+static bool pflash_sector_is_erasing(PFlashCFI02 *pfl, hwaddr offset)
+{
+    long sector_num =3D pflash_sector_info(pfl, offset).num;
+    return test_bit(sector_num, pfl->sector_erase_map);
+}
+
 static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int wi=
dth)
 {
     PFlashCFI02 *pfl =3D opaque;
@@ -280,6 +330,15 @@ static uint64_t pflash_read(void *opaque, hwaddr off=
set, unsigned int width)
     case 0x80:
         /* We accept reads during second unlock sequence... */
     case 0x00:
+        if (pflash_erase_suspend_mode(pfl) &&
+            pflash_sector_is_erasing(pfl, offset)) {
+            /* Toggle bit 2, but not 6. */
+            toggle_dq2(pfl);
+            /* Status register read */
+            ret =3D pfl->status;
+            DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
+            break;
+        }
         /* Flash area read */
         ret =3D pflash_data_read(pfl, offset, width);
         break;
@@ -305,13 +364,16 @@ static uint64_t pflash_read(void *opaque, hwaddr of=
fset, unsigned int width)
         }
         DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx64 "\n", __func__, bof=
f, ret);
         break;
-    case 0xA0:
     case 0x10:
     case 0x30:
+        /* Toggle bit 2 during erase, but not program. */
+        toggle_dq2(pfl);
+    case 0xA0:
+        /* Toggle bit 6 */
+        toggle_dq6(pfl);
         /* Status register read */
         ret =3D pfl->status;
         DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
-        toggle_dq6(pfl);
         break;
     case 0x98:
         /* CFI query mode */
@@ -343,7 +405,8 @@ static void pflash_update(PFlashCFI02 *pfl, int offse=
t, int size)
=20
 static void pflash_sector_erase(PFlashCFI02 *pfl, hwaddr offset)
 {
-    uint64_t sector_len =3D pflash_sector_len(pfl, offset);
+    SectorInfo sector_info =3D pflash_sector_info(pfl, offset);
+    uint64_t sector_len =3D sector_info.len;
     offset &=3D ~(sector_len - 1);
     DPRINTF("%s: start sector erase at %0*" PRIx64 "-%0*" PRIx64 "\n",
             __func__, pfl->width * 2, offset,
@@ -355,6 +418,7 @@ static void pflash_sector_erase(PFlashCFI02 *pfl, hwa=
ddr offset)
     }
     set_dq7(pfl, 0x00);
     ++pfl->sectors_to_erase;
+    set_bit(sector_info.num, pfl->sector_erase_map);
     /* Set (or reset) the 50 us timer for additional erase commands.  */
     timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 50000=
);
 }
@@ -405,6 +469,25 @@ static void pflash_write(void *opaque, hwaddr offset=
, uint64_t value,
             pfl->cmd =3D 0x98;
             return;
         }
+        /* Handle erase resume in erase suspend mode, otherwise reset. *=
/
+        if (cmd =3D=3D 0x30) {
+            if (pflash_erase_suspend_mode(pfl)) {
+                /* Resume the erase. */
+                timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRT=
UAL) +
+                          pfl->erase_time_remaining);
+                pfl->erase_time_remaining =3D 0;
+                pfl->wcycle =3D 6;
+                pfl->cmd =3D 0x30;
+                set_dq7(pfl, 0x00);
+                assert_dq3(pfl);
+                return;
+            }
+            goto reset_flash;
+        }
+        /* Ignore erase suspend. */
+        if (cmd =3D=3D 0xB0) {
+            return;
+        }
         if (boff !=3D pfl->unlock_addr0 || cmd !=3D 0xAA) {
             DPRINTF("%s: unlock0 failed " TARGET_FMT_plx " %02x %04x\n",
                     __func__, boff, cmd, pfl->unlock_addr0);
@@ -450,6 +533,14 @@ static void pflash_write(void *opaque, hwaddr offset=
, uint64_t value,
             /* We need another unlock sequence */
             goto check_unlock0;
         case 0xA0:
+            if (pflash_erase_suspend_mode(pfl) &&
+                pflash_sector_is_erasing(pfl, offset)) {
+                /* Ignore writes to erasing sectors. */
+                if (pfl->bypass) {
+                    goto do_bypass;
+                }
+                goto reset_flash;
+            }
             trace_pflash_data_write(offset, width << 1, value, 0);
             if (!pfl->ro) {
                 p =3D (uint8_t *)pfl->storage + offset;
@@ -508,6 +599,10 @@ static void pflash_write(void *opaque, hwaddr offset=
, uint64_t value,
         }
         break;
     case 5:
+        if (pflash_erase_suspend_mode(pfl)) {
+            /* Erasing is not supported in erase suspend mode. */
+            goto reset_flash;
+        }
         switch (cmd) {
         case 0x10:
             if (boff !=3D pfl->unlock_addr0) {
@@ -542,6 +637,30 @@ static void pflash_write(void *opaque, hwaddr offset=
, uint64_t value,
             /* Ignore writes during chip erase */
             return;
         case 0x30:
+            if (cmd =3D=3D 0xB0) {
+                /*
+                 * If erase suspend happens during the erase timeout (so=
 DQ3 is
+                 * 0), then the device suspends erasing immediately. Set=
 the
+                 * remaining time to be the total time to erase. Otherwi=
se,
+                 * there is a maximum amount of time it can take to ente=
r
+                 * suspend mode. Let's ignore that and suspend immediate=
ly and
+                 * set the remaining time to the actual time remaining o=
n the
+                 * timer.
+                 */
+                if ((pfl->status & 0x08) =3D=3D 0) {
+                    pfl->erase_time_remaining =3D pflash_erase_time(pfl)=
;
+                } else {
+                    int64_t delta =3D timer_expire_time_ns(&pfl->timer) =
-
+                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+                    /* Make sure we have a positive time remaining. */
+                    pfl->erase_time_remaining =3D delta <=3D 0 ? 1 : del=
ta;
+                }
+                reset_dq3(pfl);
+                timer_del(&pfl->timer);
+                pfl->wcycle =3D 0;
+                pfl->cmd =3D 0;
+                return;
+            }
             /*
              * If DQ3 is 0, additional sector erase commands can be
              * written and anything else (other than an erase suspend) r=
esets
@@ -619,10 +738,12 @@ static void pflash_cfi02_realize(DeviceState *dev, =
Error **errp)
=20
     int nb_regions;
     pfl->chip_len =3D 0;
+    pfl->total_sectors =3D 0;
     for (nb_regions =3D 0; nb_regions < PFLASH_MAX_ERASE_REGIONS; ++nb_r=
egions) {
         if (pfl->nb_blocs[nb_regions] =3D=3D 0) {
             break;
         }
+        pfl->total_sectors +=3D pfl->nb_blocs[nb_regions];
         uint64_t sector_len_per_device =3D pfl->sector_len[nb_regions];
=20
         /*
@@ -656,6 +777,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
         pfl->nb_blocs[0] =3D pfl->uniform_nb_blocs;
         pfl->sector_len[0] =3D pfl->uniform_sector_len;
         pfl->chip_len =3D uniform_len;
+        pfl->total_sectors =3D pfl->uniform_nb_blocs;
     } else if (uniform_len !=3D 0 && uniform_len !=3D pfl->chip_len) {
         error_setg(errp, "\"num-blocks\"*\"sector-length\" "
                    "different from \"num-blocks0\"*\'sector-length0\" + =
... + "
@@ -697,6 +819,9 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
     pfl->unlock_addr0 &=3D 0x7FF;
     pfl->unlock_addr1 &=3D 0x7FF;
=20
+    /* Allocate memory for a bitmap for sectors being erased. */
+    pfl->sector_erase_map =3D bitmap_new(pfl->total_sectors);
+
     pflash_setup_mappings(pfl);
     pfl->rom_mode =3D 1;
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &pfl->mem);
@@ -781,8 +906,8 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
=20
     /* Address sensitive unlock required. */
     pfl->cfi_table[0x05 + pri_ofs] =3D 0x00;
-    /* Erase suspend not supported. */
-    pfl->cfi_table[0x06 + pri_ofs] =3D 0x00;
+    /* Erase suspend to read/write. */
+    pfl->cfi_table[0x06 + pri_ofs] =3D 0x02;
     /* Sector protect not supported. */
     pfl->cfi_table[0x07 + pri_ofs] =3D 0x00;
     /* Temporary sector unprotect not supported. */
@@ -829,6 +954,7 @@ static void pflash_cfi02_unrealize(DeviceState *dev, =
Error **errp)
 {
     PFlashCFI02 *pfl =3D PFLASH_CFI02(dev);
     timer_del(&pfl->timer);
+    g_free(pfl->sector_erase_map);
 }
=20
 static void pflash_cfi02_class_init(ObjectClass *klass, void *data)
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index 303bc87820..d3b23f4f66 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -43,6 +43,8 @@ typedef struct {
 #define CHIP_ERASE_CMD 0x10
 #define UNLOCK_BYPASS_CMD 0x20
 #define UNLOCK_BYPASS_RESET_CMD 0x00
+#define ERASE_SUSPEND_CMD 0xB0
+#define ERASE_RESUME_CMD SECTOR_ERASE_CMD
=20
 typedef struct {
     int bank_width;
@@ -241,6 +243,16 @@ static void chip_erase(const FlashConfig *c)
     flash_cmd(c, UNLOCK0_ADDR, CHIP_ERASE_CMD);
 }
=20
+static void erase_suspend(const FlashConfig *c)
+{
+    flash_cmd(c, FLASH_ADDR(0), ERASE_SUSPEND_CMD);
+}
+
+static void erase_resume(const FlashConfig *c)
+{
+    flash_cmd(c, FLASH_ADDR(0), ERASE_RESUME_CMD);
+}
+
 /*
  * Test flash commands with a variety of device geometry.
  */
@@ -312,11 +324,20 @@ static void test_geometry(const void *opaque)
     uint32_t device_len =3D 1 << flash_query_1(c, FLASH_ADDR(0x27));
     g_assert_cmphex(device_len, =3D=3D, UNIFORM_FLASH_SIZE);
=20
+    /* Check that erase suspend to read/write is supported. */
+    uint16_t pri =3D flash_query_1(c, FLASH_ADDR(0x15)) +
+                   (flash_query_1(c, FLASH_ADDR(0x16)) << 8);
+    g_assert_cmpint(pri, >=3D, 0x2D + 4 * nb_erase_regions);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(pri + 0)), =3D=3D, replica=
te(c, 'P'));
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(pri + 1)), =3D=3D, replica=
te(c, 'R'));
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(pri + 2)), =3D=3D, replica=
te(c, 'I'));
+    g_assert_cmpint(flash_query_1(c, FLASH_ADDR(pri + 6)), =3D=3D, 2); /=
* R/W */
     reset(c);
=20
     const uint64_t dq7 =3D replicate(c, 0x80);
     const uint64_t dq6 =3D replicate(c, 0x40);
     const uint64_t dq3 =3D replicate(c, 0x08);
+    const uint64_t dq2 =3D replicate(c, 0x04);
=20
     uint64_t byte_addr =3D 0;
     for (int region =3D 0; region < nb_erase_regions; ++region) {
@@ -456,6 +477,95 @@ static void test_geometry(const void *opaque)
         }
     }
=20
+    /* Test erase suspend/resume during erase timeout. */
+    sector_erase(c, 0);
+    /*
+     * Check that DQ 3 is 0 and DQ6 and DQ2 are toggling in the sector b=
eing
+     * erased as well as in a sector not being erased.
+     */
+    byte_addr =3D c->sector_len[0];
+    status0 =3D flash_read(c, 0);
+    status1 =3D flash_read(c, 0);
+    g_assert_cmpint(status0 & dq3, =3D=3D, 0);
+    g_assert_cmpint(status0 & dq6, =3D=3D, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, =3D=3D, ~status1 & dq2);
+    status0 =3D flash_read(c, byte_addr);
+    status1 =3D flash_read(c, byte_addr);
+    g_assert_cmpint(status0 & dq3, =3D=3D, 0);
+    g_assert_cmpint(status0 & dq6, =3D=3D, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, =3D=3D, ~status1 & dq2);
+
+    /*
+     * Check that after suspending, DQ6 does not toggle but DQ2 does tog=
gle in
+     * an erase suspended sector but that neither toggle (we should be
+     * getting data) in a sector not being erased.
+     */
+    erase_suspend(c);
+    status0 =3D flash_read(c, 0);
+    status1 =3D flash_read(c, 0);
+    g_assert_cmpint(status0 & dq6, =3D=3D, status1 & dq6);
+    g_assert_cmpint(status0 & dq2, =3D=3D, ~status1 & dq2);
+    g_assert_cmpint(flash_read(c, byte_addr), =3D=3D, flash_read(c, byte=
_addr));
+
+    /* Check that after resuming, DQ3 is 1 and DQ6 and DQ2 toggle. */
+    erase_resume(c);
+    status0 =3D flash_read(c, 0);
+    status1 =3D flash_read(c, 0);
+    g_assert_cmpint(status0 & dq3, =3D=3D, dq3);
+    g_assert_cmpint(status0 & dq6, =3D=3D, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, =3D=3D, ~status1 & dq2);
+    status0 =3D flash_read(c, byte_addr);
+    status1 =3D flash_read(c, byte_addr);
+    g_assert_cmpint(status0 & dq3, =3D=3D, dq3);
+    g_assert_cmpint(status0 & dq6, =3D=3D, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, =3D=3D, ~status1 & dq2);
+    wait_for_completion(c, 0);
+
+    /* Repeat this process but this time suspend after the timeout. */
+    sector_erase(c, 0);
+    qtest_clock_step_next(c->qtest);
+    /*
+     * Check that DQ 3 is 1 and DQ6 and DQ2 are toggling in the sector b=
eing
+     * erased as well as in a sector not being erased.
+     */
+    byte_addr =3D c->sector_len[0];
+    status0 =3D flash_read(c, 0);
+    status1 =3D flash_read(c, 0);
+    g_assert_cmpint(status0 & dq3, =3D=3D, dq3);
+    g_assert_cmpint(status0 & dq6, =3D=3D, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, =3D=3D, ~status1 & dq2);
+    status0 =3D flash_read(c, byte_addr);
+    status1 =3D flash_read(c, byte_addr);
+    g_assert_cmpint(status0 & dq3, =3D=3D, dq3);
+    g_assert_cmpint(status0 & dq6, =3D=3D, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, =3D=3D, ~status1 & dq2);
+
+    /*
+     * Check that after suspending, DQ6 does not toggle but DQ2 does tog=
gle in
+     * an erase suspended sector but that neither toggle (we should be
+     * getting data) in a sector not being erased.
+     */
+    erase_suspend(c);
+    status0 =3D flash_read(c, 0);
+    status1 =3D flash_read(c, 0);
+    g_assert_cmpint(status0 & dq6, =3D=3D, status1 & dq6);
+    g_assert_cmpint(status0 & dq2, =3D=3D, ~status1 & dq2);
+    g_assert_cmpint(flash_read(c, byte_addr), =3D=3D, flash_read(c, byte=
_addr));
+
+    /* Check that after resuming, DQ3 is 1 and DQ6 and DQ2 toggle. */
+    erase_resume(c);
+    status0 =3D flash_read(c, 0);
+    status1 =3D flash_read(c, 0);
+    g_assert_cmpint(status0 & dq3, =3D=3D, dq3);
+    g_assert_cmpint(status0 & dq6, =3D=3D, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, =3D=3D, ~status1 & dq2);
+    status0 =3D flash_read(c, byte_addr);
+    status1 =3D flash_read(c, byte_addr);
+    g_assert_cmpint(status0 & dq3, =3D=3D, dq3);
+    g_assert_cmpint(status0 & dq6, =3D=3D, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, =3D=3D, ~status1 & dq2);
+    wait_for_completion(c, 0);
+
     qtest_quit(qtest);
 }
=20
--=20
2.20.1


