Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FACC4321A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 21:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05552075E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 21:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05552075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgbbu-0006kV-Vu
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 17:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46812)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgb31-0004ML-5v
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgb2v-000345-LP
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:31:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hgb2c-0002Gw-BT; Thu, 27 Jun 2019 16:30:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E22FD821C3;
 Thu, 27 Jun 2019 20:30:35 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2A16600CC;
 Thu, 27 Jun 2019 20:30:30 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 22:27:14 +0200
Message-Id: <20190627202719.17739-24-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-1-philmd@redhat.com>
References: <20190627202719.17739-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 27 Jun 2019 20:30:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 23/28] hw/block/pflash_cfi02: Implement
 multi-sector erase
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

After two unlock cycles and a sector erase command, the AMD flash chips
start a 50 us erase time out. Any additional sector erase commands add a
sector to be erased and restart the 50 us timeout. During the timeout,
status bit DQ3 is cleared. After the time out, DQ3 is asserted during
erasure.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190426162624.55977-9-stephen.checkoway@oberlin.edu>
[PMD: Rebased]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c   | 94 +++++++++++++++++++++++++++++++--------
 tests/pflash-cfi02-test.c | 70 +++++++++++++++++++++++++----
 2 files changed, 137 insertions(+), 27 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 39daa95833..5874bd55ad 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -31,7 +31,6 @@
  * It does not support flash interleaving.
  * It does not implement software data protection as found in many real =
chips
  * It does not implement erase suspend/resume commands
- * It does not implement multiple sectors erase
  */
=20
 #include "qemu/osdep.h"
@@ -106,6 +105,7 @@ struct PFlashCFI02 {
     MemoryRegion orig_mem;
     int rom_mode;
     int read_counter; /* used for lazy switch-back to rom mode */
+    int sectors_to_erase;
     char *name;
     void *storage;
 };
@@ -135,6 +135,22 @@ static inline void toggle_dq6(PFlashCFI02 *pfl)
     pfl->status ^=3D 0x40;
 }
=20
+/*
+ * Turn on DQ3.
+ */
+static inline void assert_dq3(PFlashCFI02 *pfl)
+{
+    pfl->status |=3D 0x08;
+}
+
+/*
+ * Turn off DQ3.
+ */
+static inline void reset_dq3(PFlashCFI02 *pfl)
+{
+    pfl->status &=3D ~0x08;
+}
+
 /*
  * Set up replicated mappings of the same region.
  */
@@ -163,11 +179,37 @@ static size_t pflash_regions_count(PFlashCFI02 *pfl=
)
     return pfl->cfi_table[0x2c];
 }
=20
-static void pflash_timer (void *opaque)
+static void pflash_timer(void *opaque)
 {
     PFlashCFI02 *pfl =3D opaque;
=20
     trace_pflash_timer_expired(pfl->cmd);
+    if (pfl->cmd =3D=3D 0x30) {
+        /*
+         * Sector erase. If DQ3 is 0 when the timer expires, then the 50
+         * us erase timeout has expired so we need to start the timer fo=
r the
+         * sector erase algorithm. Otherwise, the erase completed and we=
 should
+         * go back to read array mode.
+         */
+        if ((pfl->status & 0x08) =3D=3D 0) {
+            assert_dq3(pfl);
+            /*
+             * CFI address 0x21 is "Typical timeout per individual block=
 erase
+             * 2^N ms"
+             */
+            uint64_t timeout =3D ((1ULL << pfl->cfi_table[0x21]) *
+                                pfl->sectors_to_erase) * 1000000;
+            timer_mod(&pfl->timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + timeout);
+            DPRINTF("%s: erase timeout fired; erasing %d sectors\n",
+                    __func__, pfl->sectors_to_erase);
+            return;
+        }
+        DPRINTF("%s: sector erase complete\n", __func__);
+        pfl->sectors_to_erase =3D 0;
+        reset_dq3(pfl);
+    }
+
     /* Reset flash */
     toggle_dq7(pfl);
     if (pfl->bypass) {
@@ -299,6 +341,24 @@ static void pflash_update(PFlashCFI02 *pfl, int offs=
et, int size)
     }
 }
=20
+static void pflash_sector_erase(PFlashCFI02 *pfl, hwaddr offset)
+{
+    uint64_t sector_len =3D pflash_sector_len(pfl, offset);
+    offset &=3D ~(sector_len - 1);
+    DPRINTF("%s: start sector erase at %0*" PRIx64 "-%0*" PRIx64 "\n",
+            __func__, pfl->width * 2, offset,
+            pfl->width * 2, offset + sector_len - 1);
+    if (!pfl->ro) {
+        uint8_t *p =3D pfl->storage;
+        memset(p + offset, 0xff, sector_len);
+        pflash_update(pfl, offset, sector_len);
+    }
+    set_dq7(pfl, 0x00);
+    ++pfl->sectors_to_erase;
+    /* Set (or reset) the 50 us timer for additional erase commands.  */
+    timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 50000=
);
+}
+
 static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                          unsigned int width)
 {
@@ -306,7 +366,6 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
     hwaddr boff;
     uint8_t *p;
     uint8_t cmd;
-    uint32_t sector_len;
=20
     trace_pflash_io_write(offset, width, width << 1, value, pfl->wcycle)=
;
     cmd =3D value;
@@ -469,20 +528,7 @@ static void pflash_write(void *opaque, hwaddr offset=
, uint64_t value,
             break;
         case 0x30:
             /* Sector erase */
-            p =3D pfl->storage;
-            sector_len =3D pflash_sector_len(pfl, offset);
-            offset &=3D ~(sector_len - 1);
-            DPRINTF("%s: start sector erase at %0*" PRIx64 "-%0*" PRIx64=
 "\n",
-                    __func__, pfl->width * 2, offset,
-                    pfl->width * 2, offset + sector_len - 1);
-            if (!pfl->ro) {
-                memset(p + offset, 0xff, sector_len);
-                pflash_update(pfl, offset, sector_len);
-            }
-            set_dq7(pfl, 0x00);
-            /* Let's wait 1/2 second before sector erase is done */
-            timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
 +
-                      (NANOSECONDS_PER_SECOND / 2));
+            pflash_sector_erase(pfl, offset);
             break;
         default:
             DPRINTF("%s: invalid command %02x (wc 5)\n", __func__, cmd);
@@ -496,7 +542,19 @@ static void pflash_write(void *opaque, hwaddr offset=
, uint64_t value,
             /* Ignore writes during chip erase */
             return;
         case 0x30:
-            /* Ignore writes during sector erase */
+            /*
+             * If DQ3 is 0, additional sector erase commands can be
+             * written and anything else (other than an erase suspend) r=
esets
+             * the device.
+             */
+            if ((pfl->status & 0x08) =3D=3D 0) {
+                if (cmd =3D=3D 0x30) {
+                    pflash_sector_erase(pfl, offset);
+                } else {
+                    goto reset_flash;
+                }
+            }
+            /* Ignore writes during the actual erase. */
             return;
         default:
             /* Should never happen */
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index 00e2261742..303bc87820 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -35,6 +35,7 @@ typedef struct {
 #define CFI_CMD 0x98
 #define UNLOCK0_CMD 0xAA
 #define UNLOCK1_CMD 0x55
+#define SECOND_UNLOCK_CMD 0x80
 #define AUTOSELECT_CMD 0x90
 #define RESET_CMD 0xF0
 #define PROGRAM_CMD 0xA0
@@ -196,7 +197,7 @@ static void reset(const FlashConfig *c)
 static void sector_erase(const FlashConfig *c, uint64_t byte_addr)
 {
     unlock(c);
-    flash_cmd(c, UNLOCK0_ADDR, 0x80);
+    flash_cmd(c, UNLOCK0_ADDR, SECOND_UNLOCK_CMD);
     unlock(c);
     flash_write(c, byte_addr, replicate(c, SECTOR_ERASE_CMD));
 }
@@ -235,7 +236,7 @@ static void program(const FlashConfig *c, uint64_t by=
te_addr, uint16_t data)
 static void chip_erase(const FlashConfig *c)
 {
     unlock(c);
-    flash_cmd(c, UNLOCK0_ADDR, 0x80);
+    flash_cmd(c, UNLOCK0_ADDR, SECOND_UNLOCK_CMD);
     unlock(c);
     flash_cmd(c, UNLOCK0_ADDR, CHIP_ERASE_CMD);
 }
@@ -315,6 +316,8 @@ static void test_geometry(const void *opaque)
=20
     const uint64_t dq7 =3D replicate(c, 0x80);
     const uint64_t dq6 =3D replicate(c, 0x40);
+    const uint64_t dq3 =3D replicate(c, 0x08);
+
     uint64_t byte_addr =3D 0;
     for (int region =3D 0; region < nb_erase_regions; ++region) {
         uint64_t base =3D 0x2D + 4 * region;
@@ -330,18 +333,29 @@ static void test_geometry(const void *opaque)
         /* Erase and program sector. */
         for (uint32_t i =3D 0; i < nb_sectors; ++i) {
             sector_erase(c, byte_addr);
-            /* Read toggle. */
+
+            /* Check that DQ3 is 0. */
+            g_assert_cmphex(flash_read(c, byte_addr) & dq3, =3D=3D, 0);
+            qtest_clock_step_next(c->qtest); /* Step over the 50 us time=
out. */
+
+            /* Check that DQ3 is 1. */
             uint64_t status0 =3D flash_read(c, byte_addr);
+            g_assert_cmphex(status0 & dq3, =3D=3D, dq3);
+
             /* DQ7 is 0 during an erase. */
             g_assert_cmphex(status0 & dq7, =3D=3D, 0);
             uint64_t status1 =3D flash_read(c, byte_addr);
+
             /* DQ6 toggles during an erase. */
             g_assert_cmphex(status0 & dq6, =3D=3D, ~status1 & dq6);
+
             /* Wait for erase to complete. */
-            qtest_clock_step_next(c->qtest);
+            wait_for_completion(c, byte_addr);
+
             /* Ensure DQ6 has stopped toggling. */
             g_assert_cmphex(flash_read(c, byte_addr), =3D=3D,
                             flash_read(c, byte_addr));
+
             /* Now the data should be valid. */
             g_assert_cmphex(flash_read(c, byte_addr), =3D=3D, bank_mask(=
c));
=20
@@ -404,6 +418,44 @@ static void test_geometry(const void *opaque)
     g_assert_cmphex(flash_query(c, FLASH_ADDR(0)), =3D=3D, replicate(c, =
0xBF));
     reset(c);
=20
+    /*
+     * Program a word on each sector, erase one or two sectors per regio=
n, and
+     * verify that all of those, and only those, are erased.
+     */
+    byte_addr =3D 0;
+    for (int region =3D 0; region < nb_erase_regions; ++region) {
+        for (int i =3D 0; i < config->nb_blocs[region]; ++i) {
+            program(c, byte_addr, 0);
+            byte_addr +=3D config->sector_len[region];
+        }
+    }
+    unlock(c);
+    flash_cmd(c, UNLOCK0_ADDR, SECOND_UNLOCK_CMD);
+    unlock(c);
+    byte_addr =3D 0;
+    const uint64_t erase_cmd =3D replicate(c, SECTOR_ERASE_CMD);
+    for (int region =3D 0; region < nb_erase_regions; ++region) {
+        flash_write(c, byte_addr, erase_cmd);
+        if (c->nb_blocs[region] > 1) {
+            flash_write(c, byte_addr + c->sector_len[region], erase_cmd)=
;
+        }
+        byte_addr +=3D c->sector_len[region] * c->nb_blocs[region];
+    }
+
+    qtest_clock_step_next(c->qtest); /* Step over the 50 us timeout. */
+    wait_for_completion(c, 0);
+    byte_addr =3D 0;
+    for (int region =3D 0; region < nb_erase_regions; ++region) {
+        for (int i =3D 0; i < config->nb_blocs[region]; ++i) {
+            if (i < 2) {
+                g_assert_cmphex(flash_read(c, byte_addr), =3D=3D, bank_m=
ask(c));
+            } else {
+                g_assert_cmphex(flash_read(c, byte_addr), =3D=3D, 0);
+            }
+            byte_addr +=3D config->sector_len[region];
+        }
+    }
+
     qtest_quit(qtest);
 }
=20
@@ -428,17 +480,17 @@ static void test_cfi_in_autoselect(const void *opaq=
ue)
     /* 1. Enter autoselect. */
     unlock(c);
     flash_cmd(c, UNLOCK0_ADDR, AUTOSELECT_CMD);
-    g_assert_cmpint(flash_query(c, FLASH_ADDR(0)), =3D=3D, replicate(c, =
0xBF));
+    g_assert_cmphex(flash_query(c, FLASH_ADDR(0)), =3D=3D, replicate(c, =
0xBF));
=20
     /* 2. Enter CFI. */
     flash_cmd(c, CFI_ADDR, CFI_CMD);
-    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x10)), =3D=3D, replicate(=
c, 'Q'));
-    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x11)), =3D=3D, replicate(=
c, 'R'));
-    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x12)), =3D=3D, replicate(=
c, 'Y'));
+    g_assert_cmphex(flash_query(c, FLASH_ADDR(0x10)), =3D=3D, replicate(=
c, 'Q'));
+    g_assert_cmphex(flash_query(c, FLASH_ADDR(0x11)), =3D=3D, replicate(=
c, 'R'));
+    g_assert_cmphex(flash_query(c, FLASH_ADDR(0x12)), =3D=3D, replicate(=
c, 'Y'));
=20
     /* 3. Exit CFI. */
     reset(c);
-    g_assert_cmpint(flash_query(c, FLASH_ADDR(0)), =3D=3D, replicate(c, =
0xBF));
+    g_assert_cmphex(flash_query(c, FLASH_ADDR(0)), =3D=3D, replicate(c, =
0xBF));
=20
     qtest_quit(qtest);
 }
--=20
2.20.1


