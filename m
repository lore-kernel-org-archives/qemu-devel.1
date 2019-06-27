Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48D3C004E6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5BE2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5BE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgbDa-0004kO-Cs
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 16:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46383)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgb2Y-0003uX-OJ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgb2J-00026F-2Q
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:30:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hgb1n-0001MT-MX; Thu, 27 Jun 2019 16:29:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D02A2C057F4B;
 Thu, 27 Jun 2019 20:29:54 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75E10600CC;
 Thu, 27 Jun 2019 20:29:49 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 22:27:09 +0200
Message-Id: <20190627202719.17739-19-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-1-philmd@redhat.com>
References: <20190627202719.17739-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 27 Jun 2019 20:29:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 18/28] hw/block/pflash_cfi02: Implement
 nonuniform sector sizes
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

Some flash chips support sectors of different sizes. For example, the
AMD AM29LV160DT has 31 64 kB sectors, one 32 kB sector, two 8 kB
sectors, and a 16 kB sector, in that order. The AM29LV160DB has those in
the reverse order.

The `num-blocks` and `sector-length` properties work exactly as they did
before: a flash device with uniform sector lengths. To get non-uniform
sector lengths for up to four regions, the following properties may be
set
- region 0. `num-blocks0` and `sector-length0`;
- region 1. `num-blocks1` and `sector-length1`;
- region 2. `num-blocks2` and `sector-length2`; and
- region 3. `num-blocks3` and `sector-length3`.

If the uniform and nonuniform properties are set, then both must specify
a flash device with the same total size. It would be better to disallow
both being set, or make `num-blocks0` and `sector-length0` alias
`num-blocks` and `sector-length`, but that would make testing currently
impossible.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190426162624.55977-6-stephen.checkoway@oberlin.edu>
[PMD: Rebased, add assert() on pri_offset]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c   | 141 +++++++++++++++++++++++++++-------
 tests/pflash-cfi02-test.c | 155 ++++++++++++++++++++++++++++----------
 2 files changed, 231 insertions(+), 65 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 01d9c5d75a..1f096ec185 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -29,7 +29,6 @@
  * - CFI queries
  *
  * It does not support flash interleaving.
- * It does not implement boot blocs with reduced size
  * It does not implement software data protection as found in many real =
chips
  * It does not implement erase suspend/resume commands
  * It does not implement multiple sectors erase
@@ -57,6 +56,13 @@ do {                                                  =
     \
=20
 #define PFLASH_LAZY_ROMD_THRESHOLD 42
=20
+/*
+ * The size of the cfi_table indirectly depends on this and the start of=
 the
+ * PRI table directly depends on it. 4 is the maximum size (and also wha=
t
+ * seems common) without changing the PRT table address.
+ */
+#define PFLASH_MAX_ERASE_REGIONS 4
+
 /* Special write cycles for CFI queries. */
 enum {
     WCYCLE_CFI              =3D 7,
@@ -68,8 +74,10 @@ struct PFlashCFI02 {
     /*< public >*/
=20
     BlockBackend *blk;
-    uint32_t sector_len;
-    uint32_t nb_blocs;
+    uint32_t uniform_nb_blocs;
+    uint32_t uniform_sector_len;
+    uint32_t nb_blocs[PFLASH_MAX_ERASE_REGIONS];
+    uint32_t sector_len[PFLASH_MAX_ERASE_REGIONS];
     uint32_t chip_len;
     uint8_t mappings;
     uint8_t width;
@@ -86,7 +94,7 @@ struct PFlashCFI02 {
     uint16_t ident3;
     uint16_t unlock_addr0;
     uint16_t unlock_addr1;
-    uint8_t cfi_table[0x52];
+    uint8_t cfi_table[0x4d];
     QEMUTimer timer;
     /* The device replicates the flash memory across its memory space.  =
Emulate
      * that by having a container (.mem) filled with an array of aliases
@@ -177,6 +185,25 @@ static uint64_t pflash_data_read(PFlashCFI02 *pfl, h=
waddr offset,
     return ret;
 }
=20
+/*
+ * offset should be a byte offset of the QEMU device and _not_ a device
+ * offset.
+ */
+static uint32_t pflash_sector_len(PFlashCFI02 *pfl, hwaddr offset)
+{
+    assert(offset < pfl->chip_len);
+    int nb_regions =3D pfl->cfi_table[0x2C];
+    hwaddr addr =3D 0;
+    for (int i =3D 0; i < nb_regions; ++i) {
+        uint64_t region_size =3D (uint64_t)pfl->nb_blocs[i] * pfl->secto=
r_len[i];
+        if (addr <=3D offset && offset < addr + region_size) {
+            return pfl->sector_len[i];
+        }
+        addr +=3D region_size;
+    }
+    abort();
+}
+
 static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int wi=
dth)
 {
     PFlashCFI02 *pfl =3D opaque;
@@ -191,10 +218,11 @@ static uint64_t pflash_read(void *opaque, hwaddr of=
fset, unsigned int width)
     }
     offset &=3D pfl->chip_len - 1;
     boff =3D offset & 0xFF;
-    if (pfl->width =3D=3D 2)
+    if (pfl->width =3D=3D 2) {
         boff =3D boff >> 1;
-    else if (pfl->width =3D=3D 4)
+    } else if (pfl->width =3D=3D 4) {
         boff =3D boff >> 2;
+    }
     switch (pfl->cmd) {
     default:
         /* This should never happen : reset state & treat it as a read*/
@@ -273,6 +301,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
     hwaddr boff;
     uint8_t *p;
     uint8_t cmd;
+    uint32_t sector_len;
=20
     trace_pflash_io_write(offset, width, width << 1, value, pfl->wcycle)=
;
     cmd =3D value;
@@ -282,10 +311,11 @@ static void pflash_write(void *opaque, hwaddr offse=
t, uint64_t value,
     offset &=3D pfl->chip_len - 1;
=20
     boff =3D offset;
-    if (pfl->width =3D=3D 2)
+    if (pfl->width =3D=3D 2) {
         boff =3D boff >> 1;
-    else if (pfl->width =3D=3D 4)
+    } else if (pfl->width =3D=3D 4) {
         boff =3D boff >> 2;
+    }
     /* Only the least-significant 11 bits are used in most cases. */
     boff &=3D 0x7FF;
     switch (pfl->wcycle) {
@@ -420,12 +450,14 @@ static void pflash_write(void *opaque, hwaddr offse=
t, uint64_t value,
         case 0x30:
             /* Sector erase */
             p =3D pfl->storage;
-            offset &=3D ~(pfl->sector_len - 1);
-            DPRINTF("%s: start sector erase at " TARGET_FMT_plx "\n", __=
func__,
-                    offset);
+            sector_len =3D pflash_sector_len(pfl, offset);
+            offset &=3D ~(sector_len - 1);
+            DPRINTF("%s: start sector erase at %0*" PRIx64 "-%0*" PRIx64=
 "\n",
+                    __func__, pfl->width * 2, offset,
+                    pfl->width * 2, offset + sector_len - 1);
             if (!pfl->ro) {
-                memset(p + offset, 0xFF, pfl->sector_len);
-                pflash_update(pfl, offset, pfl->sector_len);
+                memset(p + offset, 0xff, sector_len);
+                pflash_update(pfl, offset, sector_len);
             }
             set_dq7(pfl, 0x00);
             /* Let's wait 1/2 second before sector erase is done */
@@ -493,11 +525,11 @@ static void pflash_cfi02_realize(DeviceState *dev, =
Error **errp)
     int ret;
     Error *local_err =3D NULL;
=20
-    if (pfl->sector_len =3D=3D 0) {
+    if (pfl->uniform_sector_len =3D=3D 0 && pfl->sector_len[0] =3D=3D 0)=
 {
         error_setg(errp, "attribute \"sector-length\" not specified or z=
ero.");
         return;
     }
-    if (pfl->nb_blocs =3D=3D 0) {
+    if (pfl->uniform_nb_blocs =3D=3D 0 && pfl->nb_blocs[0] =3D=3D 0) {
         error_setg(errp, "attribute \"num-blocks\" not specified or zero=
.");
         return;
     }
@@ -506,7 +538,51 @@ static void pflash_cfi02_realize(DeviceState *dev, E=
rror **errp)
         return;
     }
=20
-    pfl->chip_len =3D pfl->sector_len * pfl->nb_blocs;
+    int nb_regions;
+    pfl->chip_len =3D 0;
+    for (nb_regions =3D 0; nb_regions < PFLASH_MAX_ERASE_REGIONS; ++nb_r=
egions) {
+        if (pfl->nb_blocs[nb_regions] =3D=3D 0) {
+            break;
+        }
+        uint64_t sector_len_per_device =3D pfl->sector_len[nb_regions];
+
+        /*
+         * The size of each flash sector must be a power of 2 and it mus=
t be
+         * aligned at the same power of 2.
+         */
+        if (sector_len_per_device & 0xff ||
+            sector_len_per_device >=3D (1 << 24) ||
+            !is_power_of_2(sector_len_per_device))
+        {
+            error_setg(errp, "unsupported configuration: "
+                       "sector length[%d] per device =3D %" PRIx64 ".",
+                       nb_regions, sector_len_per_device);
+            return;
+        }
+        if (pfl->chip_len & (sector_len_per_device - 1)) {
+            error_setg(errp, "unsupported configuration: "
+                       "flash region %d not correctly aligned.",
+                       nb_regions);
+            return;
+        }
+
+        pfl->chip_len +=3D (uint64_t)pfl->sector_len[nb_regions] *
+                          pfl->nb_blocs[nb_regions];
+    }
+
+    uint64_t uniform_len =3D (uint64_t)pfl->uniform_nb_blocs *
+                           pfl->uniform_sector_len;
+    if (nb_regions =3D=3D 0) {
+        nb_regions =3D 1;
+        pfl->nb_blocs[0] =3D pfl->uniform_nb_blocs;
+        pfl->sector_len[0] =3D pfl->uniform_sector_len;
+        pfl->chip_len =3D uniform_len;
+    } else if (uniform_len !=3D 0 && uniform_len !=3D pfl->chip_len) {
+        error_setg(errp, "\"num-blocks\"*\"sector-length\" "
+                   "different from \"num-blocks0\"*\'sector-length0\" + =
... + "
+                   "\"num-blocks3\"*\"sector-length3\"");
+        return;
+    }
=20
     memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
                                   &pflash_cfi02_ops, pfl, pfl->name,
@@ -552,7 +628,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
     pfl->status =3D 0;
=20
     /* Hardcoded CFI table (mostly from SG29 Spansion flash) */
-    const uint16_t pri_ofs =3D 0x31;
+    const uint16_t pri_ofs =3D 0x40;
     /* Standard "QRY" string */
     pfl->cfi_table[0x10] =3D 'Q';
     pfl->cfi_table[0x11] =3D 'R';
@@ -603,14 +679,17 @@ static void pflash_cfi02_realize(DeviceState *dev, =
Error **errp)
     //    pfl->cfi_table[0x2A] =3D 0x05;
     pfl->cfi_table[0x2A] =3D 0x00;
     pfl->cfi_table[0x2B] =3D 0x00;
-    /* Number of erase block regions (uniform) */
-    pfl->cfi_table[0x2C] =3D 0x01;
-    /* Erase block region 1 */
-    pfl->cfi_table[0x2D] =3D pfl->nb_blocs - 1;
-    pfl->cfi_table[0x2E] =3D (pfl->nb_blocs - 1) >> 8;
-    pfl->cfi_table[0x2F] =3D pfl->sector_len >> 8;
-    pfl->cfi_table[0x30] =3D pfl->sector_len >> 16;
-    assert(0x30 < pri_ofs);
+    /* Number of erase block regions */
+    pfl->cfi_table[0x2c] =3D nb_regions;
+    /* Erase block regions */
+    for (int i =3D 0; i < nb_regions; ++i) {
+        uint32_t sector_len_per_device =3D pfl->sector_len[i];
+        pfl->cfi_table[0x2d + 4 * i] =3D pfl->nb_blocs[i] - 1;
+        pfl->cfi_table[0x2e + 4 * i] =3D (pfl->nb_blocs[i] - 1) >> 8;
+        pfl->cfi_table[0x2f + 4 * i] =3D sector_len_per_device >> 8;
+        pfl->cfi_table[0x30 + 4 * i] =3D sector_len_per_device >> 16;
+    }
+    assert(0x2c + 4 * nb_regions < pri_ofs);
=20
     /* Extended */
     pfl->cfi_table[0x00 + pri_ofs] =3D 'P';
@@ -644,8 +723,16 @@ static void pflash_cfi02_realize(DeviceState *dev, E=
rror **errp)
=20
 static Property pflash_cfi02_properties[] =3D {
     DEFINE_PROP_DRIVE("drive", PFlashCFI02, blk),
-    DEFINE_PROP_UINT32("num-blocks", PFlashCFI02, nb_blocs, 0),
-    DEFINE_PROP_UINT32("sector-length", PFlashCFI02, sector_len, 0),
+    DEFINE_PROP_UINT32("num-blocks", PFlashCFI02, uniform_nb_blocs, 0),
+    DEFINE_PROP_UINT32("sector-length", PFlashCFI02, uniform_sector_len,=
 0),
+    DEFINE_PROP_UINT32("num-blocks0", PFlashCFI02, nb_blocs[0], 0),
+    DEFINE_PROP_UINT32("sector-length0", PFlashCFI02, sector_len[0], 0),
+    DEFINE_PROP_UINT32("num-blocks1", PFlashCFI02, nb_blocs[1], 0),
+    DEFINE_PROP_UINT32("sector-length1", PFlashCFI02, sector_len[1], 0),
+    DEFINE_PROP_UINT32("num-blocks2", PFlashCFI02, nb_blocs[2], 0),
+    DEFINE_PROP_UINT32("sector-length2", PFlashCFI02, sector_len[2], 0),
+    DEFINE_PROP_UINT32("num-blocks3", PFlashCFI02, nb_blocs[3], 0),
+    DEFINE_PROP_UINT32("sector-length3", PFlashCFI02, sector_len[3], 0),
     DEFINE_PROP_UINT8("width", PFlashCFI02, width, 0),
     DEFINE_PROP_UINT8("mappings", PFlashCFI02, mappings, 0),
     DEFINE_PROP_UINT8("big-endian", PFlashCFI02, be, 0),
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index b00f5ca2e7..1659eaebce 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -17,9 +17,11 @@
  */
=20
 #define MP_FLASH_SIZE_MAX (32 * 1024 * 1024)
-#define FLASH_SIZE (8 * 1024 * 1024)
 #define BASE_ADDR (0x100000000ULL - MP_FLASH_SIZE_MAX)
=20
+#define UNIFORM_FLASH_SIZE (8 * 1024 * 1024)
+#define UNIFORM_FLASH_SECTOR_SIZE (64 * 1024)
+
 /* Use a newtype to keep flash addresses separate from byte addresses. *=
/
 typedef struct {
     uint64_t addr;
@@ -44,6 +46,10 @@ typedef struct {
 typedef struct {
     int bank_width;
=20
+    /* Nonuniform block size. */
+    int nb_blocs[4];
+    int sector_len[4];
+
     QTestState *qtest;
 } FlashConfig;
=20
@@ -62,6 +68,10 @@ static FlashConfig expand_config_defaults(const FlashC=
onfig *c)
     if (ret.bank_width =3D=3D 0) {
         ret.bank_width =3D 2;
     }
+    if (ret.nb_blocs[0] =3D=3D 0 && ret.sector_len[0] =3D=3D 0) {
+        ret.sector_len[0] =3D UNIFORM_FLASH_SECTOR_SIZE;
+        ret.nb_blocs[0] =3D UNIFORM_FLASH_SIZE / UNIFORM_FLASH_SECTOR_SI=
ZE;
+    }
=20
     /* XXX: Limitations of test harness. */
     assert(ret.bank_width =3D=3D 2);
@@ -230,13 +240,41 @@ static void chip_erase(const FlashConfig *c)
     flash_cmd(c, UNLOCK0_ADDR, CHIP_ERASE_CMD);
 }
=20
-static void test_flash(const void *opaque)
+/*
+ * Test flash commands with a variety of device geometry.
+ */
+static void test_geometry(const void *opaque)
 {
     const FlashConfig *config =3D opaque;
     QTestState *qtest;
     qtest =3D qtest_initf("-M musicpal,accel=3Dqtest"
-                        " -drive if=3Dpflash,file=3D%s,format=3Draw,copy=
-on-read",
-                        image_path);
+                        " -drive if=3Dpflash,file=3D%s,format=3Draw,copy=
-on-read"
+                        /* Device geometry properties. */
+                        " -global driver=3Dcfi.pflash02,"
+                        "property=3Dnum-blocks0,value=3D%d"
+                        " -global driver=3Dcfi.pflash02,"
+                        "property=3Dsector-length0,value=3D%d"
+                        " -global driver=3Dcfi.pflash02,"
+                        "property=3Dnum-blocks1,value=3D%d"
+                        " -global driver=3Dcfi.pflash02,"
+                        "property=3Dsector-length1,value=3D%d"
+                        " -global driver=3Dcfi.pflash02,"
+                        "property=3Dnum-blocks2,value=3D%d"
+                        " -global driver=3Dcfi.pflash02,"
+                        "property=3Dsector-length2,value=3D%d"
+                        " -global driver=3Dcfi.pflash02,"
+                        "property=3Dnum-blocks3,value=3D%d"
+                        " -global driver=3Dcfi.pflash02,"
+                        "property=3Dsector-length3,value=3D%d",
+                        image_path,
+                        config->nb_blocs[0],
+                        config->sector_len[0],
+                        config->nb_blocs[1],
+                        config->sector_len[1],
+                        config->nb_blocs[2],
+                        config->sector_len[2],
+                        config->nb_blocs[3],
+                        config->sector_len[3]);
     FlashConfig explicit_config =3D expand_config_defaults(config);
     explicit_config.qtest =3D qtest;
     const FlashConfig *c =3D &explicit_config;
@@ -264,39 +302,56 @@ static void test_flash(const void *opaque)
     g_assert_cmphex(flash_query(c, FLASH_ADDR(0x12)), =3D=3D, replicate(=
c, 'Y'));
=20
     /* Num erase regions. */
-    g_assert_cmphex(flash_query_1(c, FLASH_ADDR(0x2C)), >=3D, 1);
+    int nb_erase_regions =3D flash_query_1(c, FLASH_ADDR(0x2C));
+    g_assert_cmphex(nb_erase_regions, =3D=3D,
+                    !!c->nb_blocs[0] + !!c->nb_blocs[1] + !!c->nb_blocs[=
2] +
+                    !!c->nb_blocs[3]);
+
+    /* Check device length. */
+    uint32_t device_len =3D 1 << flash_query_1(c, FLASH_ADDR(0x27));
+    g_assert_cmphex(device_len, =3D=3D, UNIFORM_FLASH_SIZE);
=20
-    uint32_t nb_sectors =3D flash_query_1(c, FLASH_ADDR(0x2D)) +
-                          (flash_query_1(c, FLASH_ADDR(0x2E)) << 8) + 1;
-    uint32_t sector_len =3D (flash_query_1(c, FLASH_ADDR(0x2F)) << 8) +
-                          (flash_query_1(c, FLASH_ADDR(0x30)) << 16);
     reset(c);
=20
     const uint64_t dq7 =3D replicate(c, 0x80);
     const uint64_t dq6 =3D replicate(c, 0x40);
-    /* Erase and program sector. */
-    for (uint32_t i =3D 0; i < nb_sectors; ++i) {
-        uint64_t byte_addr =3D i * sector_len;
-        sector_erase(c, byte_addr);
-        /* Read toggle. */
-        uint64_t status0 =3D flash_read(c, byte_addr);
-        /* DQ7 is 0 during an erase. */
-        g_assert_cmphex(status0 & dq7, =3D=3D, 0);
-        uint64_t status1 =3D flash_read(c, byte_addr);
-        /* DQ6 toggles during an erase. */
-        g_assert_cmphex(status0 & dq6, =3D=3D, ~status1 & dq6);
-        /* Wait for erase to complete. */
-        qtest_clock_step_next(c->qtest);
-        /* Ensure DQ6 has stopped toggling. */
-        g_assert_cmphex(flash_read(c, byte_addr), =3D=3D, flash_read(c, =
byte_addr));
-        /* Now the data should be valid. */
-        g_assert_cmphex(flash_read(c, byte_addr), =3D=3D, bank_mask(c));
+    uint64_t byte_addr =3D 0;
+    for (int region =3D 0; region < nb_erase_regions; ++region) {
+        uint64_t base =3D 0x2D + 4 * region;
+        flash_cmd(c, CFI_ADDR, CFI_CMD);
+        uint32_t nb_sectors =3D flash_query_1(c, FLASH_ADDR(base + 0)) +
+                              (flash_query_1(c, FLASH_ADDR(base + 1)) <<=
 8) + 1;
+        uint32_t sector_len =3D (flash_query_1(c, FLASH_ADDR(base + 2)) =
<< 8) +
+                              (flash_query_1(c, FLASH_ADDR(base + 3)) <<=
 16);
+        g_assert_cmphex(nb_sectors, =3D=3D, c->nb_blocs[region]);
+        g_assert_cmphex(sector_len, =3D=3D, c->sector_len[region]);
+        reset(c);
=20
-        /* Program a bit pattern. */
-        program(c, byte_addr, 0x55);
-        g_assert_cmphex(flash_read(c, byte_addr) & 0xFF, =3D=3D, 0x55);
-        program(c, byte_addr, 0xA5);
-        g_assert_cmphex(flash_read(c, byte_addr) & 0xFF, =3D=3D, 0x05);
+        /* Erase and program sector. */
+        for (uint32_t i =3D 0; i < nb_sectors; ++i) {
+            sector_erase(c, byte_addr);
+            /* Read toggle. */
+            uint64_t status0 =3D flash_read(c, byte_addr);
+            /* DQ7 is 0 during an erase. */
+            g_assert_cmphex(status0 & dq7, =3D=3D, 0);
+            uint64_t status1 =3D flash_read(c, byte_addr);
+            /* DQ6 toggles during an erase. */
+            g_assert_cmphex(status0 & dq6, =3D=3D, ~status1 & dq6);
+            /* Wait for erase to complete. */
+            qtest_clock_step_next(c->qtest);
+            /* Ensure DQ6 has stopped toggling. */
+            g_assert_cmphex(flash_read(c, byte_addr), =3D=3D,
+                            flash_read(c, byte_addr));
+            /* Now the data should be valid. */
+            g_assert_cmphex(flash_read(c, byte_addr), =3D=3D, bank_mask(=
c));
+
+            /* Program a bit pattern. */
+            program(c, byte_addr, 0x55);
+            g_assert_cmphex(flash_read(c, byte_addr) & 0xFF, =3D=3D, 0x5=
5);
+            program(c, byte_addr, 0xA5);
+            g_assert_cmphex(flash_read(c, byte_addr) & 0xFF, =3D=3D, 0x0=
5);
+            byte_addr +=3D sector_len;
+        }
     }
=20
     /* Erase the chip. */
@@ -314,9 +369,11 @@ static void test_flash(const void *opaque)
     g_assert_cmphex(flash_read(c, 0), =3D=3D, flash_read(c, 0));
     /* Now the data should be valid. */
=20
-    for (uint32_t i =3D 0; i < nb_sectors; ++i) {
-        uint64_t byte_addr =3D i * sector_len;
-        g_assert_cmphex(flash_read(c, byte_addr), =3D=3D, bank_mask(c));
+    for (int region =3D 0; region < nb_erase_regions; ++region) {
+        for (uint32_t i =3D 0; i < c->nb_blocs[region]; ++i) {
+            uint64_t byte_addr =3D i * c->sector_len[region];
+            g_assert_cmphex(flash_read(c, byte_addr), =3D=3D, bank_mask(=
c));
+        }
     }
=20
     /* Unlock bypass */
@@ -364,6 +421,18 @@ static const FlashConfig configuration[] =3D {
     {
         .bank_width =3D 2,
     },
+    /* Nonuniform sectors (top boot). */
+    {
+        .bank_width =3D 2,
+        .nb_blocs =3D { 127, 1, 2, 1 },
+        .sector_len =3D { 0x10000, 0x08000, 0x02000, 0x04000 },
+    },
+    /* Nonuniform sectors (bottom boot). */
+    {
+        .bank_width =3D 2,
+        .nb_blocs =3D { 1, 2, 1, 127 },
+        .sector_len =3D { 0x04000, 0x02000, 0x08000, 0x10000 },
+    },
 };
=20
 int main(int argc, char **argv)
@@ -374,12 +443,12 @@ int main(int argc, char **argv)
                    strerror(errno));
         exit(EXIT_FAILURE);
     }
-    if (ftruncate(fd, FLASH_SIZE) < 0) {
+    if (ftruncate(fd, UNIFORM_FLASH_SIZE) < 0) {
         int error_code =3D errno;
         close(fd);
         unlink(image_path);
         g_printerr("Failed to truncate file %s to %u MB: %s\n", image_pa=
th,
-                   FLASH_SIZE, strerror(error_code));
+                   UNIFORM_FLASH_SIZE, strerror(error_code));
         exit(EXIT_FAILURE);
     }
     close(fd);
@@ -390,9 +459,19 @@ int main(int argc, char **argv)
     size_t nb_configurations =3D sizeof configuration / sizeof configura=
tion[0];
     for (size_t i =3D 0; i < nb_configurations; ++i) {
         const FlashConfig *config =3D &configuration[i];
-        char *path =3D g_strdup_printf("pflash-cfi02/%d",
+        char *path =3D g_strdup_printf("pflash-cfi02"
+                                     "/geometry/%dx%x-%dx%x-%dx%x-%dx%x"
+                                     "/%d",
+                                     config->nb_blocs[0],
+                                     config->sector_len[0],
+                                     config->nb_blocs[1],
+                                     config->sector_len[1],
+                                     config->nb_blocs[2],
+                                     config->sector_len[2],
+                                     config->nb_blocs[3],
+                                     config->sector_len[3],
                                      config->bank_width);
-        qtest_add_data_func(path, config, test_flash);
+        qtest_add_data_func(path, config, test_geometry);
         g_free(path);
     }
     int result =3D g_test_run();
--=20
2.20.1


