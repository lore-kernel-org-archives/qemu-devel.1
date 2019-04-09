Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB123C10F13
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 02:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 635E4213F2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 02:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="MXx0SDJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635E4213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33811 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDgCx-0008Bw-Kc
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 22:09:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDg6n-00031a-SQ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDg6k-0006c5-Vi
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:03:33 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:43065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDg6k-0006aF-KX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:03:30 -0400
Received: by mail-io1-xd42.google.com with SMTP id x3so12834127iol.10
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 19:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=+FJKZDZ/thc/HZMtzvi5GrqqIfTZ8U61JMcVdJoZFb8=;
	b=MXx0SDJL7zTFDtFPXrPklgzUY9DFrQU1D8fOYwuOjbmQEfan1eZQ2of9PLaJ2OmIWc
	RQlMyNdP+iDGLj+zEQnLdZUgIMqyJKIYIy9F5g3fsKKvGm2vx6GW4LWNBj19/1t0pnR0
	3euQB85HaxOS5R+8bjwfg5GgTT13D+SDkUPKfbPTv4DwMYqvU5vw/aP7f5zP8g4C6/4x
	5SGwRPXnFo4HeKM3a4TnBVOxY1NTKQ4i4cq3uBz+KDppMjg+EngbfGeyP46bo4f2hMMv
	8Yhu+lq4AzgJ4P1OHSHLkCfu0U52R8/W7jT8L/g5RuodwrMeBGnpX9zL5OYaumBkQE9P
	vuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=+FJKZDZ/thc/HZMtzvi5GrqqIfTZ8U61JMcVdJoZFb8=;
	b=O+ZAvvNMp7hdLvI0LMWUrqM+1yuHaeDbVKqhuvpugS/rcpOzkYsnf9w1qOOpmumROk
	2+j7WAi/D9XajMVEkBXZ3+axXGyRCx7NqZ+efLo7g75zhrhcbDc6tCxtGgm1PiIYElhY
	n1MQsxkj8/vR3WSLqWSv281tb+x6aV7FGBeIAXCRb/Wysif3XxvitnYl3mXj2QUGTHFj
	HpaCanxck/0oeeLJzQcloXb7gOfdf0M5JW7gg8AbACKZk3G2UVDgwRzutvWLH5qXusr3
	5zJ+OwlO+bCDLRQw6HwCH038OTKHoox/WL3pBAQpACU5HTsRqbwVmf0rqYqPj/uY3dtf
	m0hg==
X-Gm-Message-State: APjAAAUu4qDjMTVC/qm0/LHexRiQ4JE0gKKelK+pakRutLQ9NQXdsZRk
	aLe0NBhv3iq9XcE41bl8VAjCEZCM+F2LbA==
X-Google-Smtp-Source: APXvYqyOtzveXsOE44iBe+Gu5QLnBgW7E6hCDZ24Wuu1YbmheHV1gEzlak2yOXG96cvbzgO5faXABQ==
X-Received: by 2002:a5d:9914:: with SMTP id x20mr21164185iol.257.1554775408270;
	Mon, 08 Apr 2019 19:03:28 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	y203sm5969838itb.22.2019.04.08.19.03.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 19:03:27 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 22:01:29 -0400
Message-Id:
 <bbe417c354dfa908d5e1bc8f8ad7121ec9451682.1554774454.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1554774454.git.stephen.checkoway@oberlin.edu>
References: <cover.1554774454.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: [Qemu-devel] [PATCH v2 05/10] block/pflash_cfi02: Implement
 nonuniform sector sizes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409020129.zT_Stf274aDDoqxamJiu-VgNlKAwNEB1Gk1Dl2Ulglc@z>

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
---
 hw/block/pflash_cfi02.c   | 177 ++++++++++++++++++++++++++-----------
 tests/pflash-cfi02-test.c | 179 +++++++++++++++++++++++++++++---------
 2 files changed, 265 insertions(+), 91 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 101628b4ec..c4efbe8cdf 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -28,7 +28,6 @@
  * - unlock bypass command
  * - CFI queries
  *
- * It does not implement boot blocs with reduced size
  * It does not implement software data protection as found in many real chips
  * It does not implement erase suspend/resume commands
  * It does not implement multiple sectors erase
@@ -55,6 +54,13 @@ do {                                                       \
 
 #define PFLASH_LAZY_ROMD_THRESHOLD 42
 
+/*
+ * The size of the cfi_table indirectly depends on this and the start of the
+ * PRI table directly depends on it. 4 is the maximum size (and also what
+ * seems common) without changing the PRT table address.
+ */
+#define PFLASH_MAX_ERASE_REGIONS 4
+
 /* Special write cycle for CFI queries. */
 #define WCYCLE_CFI 7
 
@@ -64,8 +70,10 @@ struct PFlashCFI02 {
     /*< public >*/
 
     BlockBackend *blk;
-    uint32_t sector_len;
-    uint32_t nb_blocs;
+    uint32_t uniform_nb_blocs;
+    uint32_t uniform_sector_len;
+    uint32_t nb_blocs[PFLASH_MAX_ERASE_REGIONS];
+    uint32_t sector_len[PFLASH_MAX_ERASE_REGIONS];
     uint64_t total_len;
     uint64_t interleave_multiplier;
     uint8_t mappings;
@@ -86,7 +94,7 @@ struct PFlashCFI02 {
     uint16_t ident3;
     uint16_t unlock_addr0;
     uint16_t unlock_addr1;
-    uint8_t cfi_table[0x52];
+    uint8_t cfi_table[0x4D];
     QEMUTimer timer;
     /* The device replicates the flash memory across its memory space.  Emulate
      * that by having a container (.mem) filled with an array of aliases
@@ -189,6 +197,25 @@ static uint64_t pflash_data_read(PFlashCFI02 *pfl, hwaddr offset,
     return ret;
 }
 
+/*
+ * offset should be a byte offset of the QEMU device and _not_ a device
+ * offset.
+ */
+static uint32_t pflash_sector_len(PFlashCFI02 *pfl, hwaddr offset)
+{
+    assert(offset < pfl->total_len);
+    int nb_regions = pfl->cfi_table[0x2C];
+    hwaddr addr = 0;
+    for (int i = 0; i < nb_regions; ++i) {
+        uint64_t region_size = (uint64_t)pfl->nb_blocs[i] * pfl->sector_len[i];
+        if (addr <= offset && offset < addr + region_size) {
+            return pfl->sector_len[i];
+        }
+        addr += region_size;
+    }
+    abort();
+}
+
 static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
 {
     PFlashCFI02 *pfl = opaque;
@@ -285,6 +312,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
     PFlashCFI02 *pfl = opaque;
     uint8_t *p;
     uint8_t cmd;
+    uint32_t sector_len;
 
     cmd = value;
     if (pfl->cmd != 0xA0) {
@@ -446,12 +474,14 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         case 0x30:
             /* Sector erase */
             p = pfl->storage;
-            offset &= ~(pfl->sector_len - 1);
-            DPRINTF("%s: start sector erase at " TARGET_FMT_plx "\n", __func__,
-                    offset);
+            sector_len = pflash_sector_len(pfl, offset);
+            offset &= ~(sector_len - 1);
+            DPRINTF("%s: start sector erase at %0*" PRIx64 "-%0*" PRIx64 "\n",
+                    __func__, pfl->bank_width * 2, offset,
+                    pfl->bank_width * 2, offset + sector_len - 1);
             if (!pfl->ro) {
-                memset(p + offset, 0xFF, pfl->sector_len);
-                pflash_update(pfl, offset, pfl->sector_len);
+                memset(p + offset, 0xFF, sector_len);
+                pflash_update(pfl, offset, sector_len);
             }
             set_dq7(pfl, 0x00);
             /* Let's wait 1/2 second before sector erase is done */
@@ -515,15 +545,14 @@ static const MemoryRegionOps pflash_cfi02_ops = {
 static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
 {
     PFlashCFI02 *pfl = PFLASH_CFI02(dev);
-    uint32_t chip_len;
     int ret;
     Error *local_err = NULL;
 
-    if (pfl->sector_len == 0) {
+    if (pfl->uniform_sector_len == 0 && pfl->sector_len[0] == 0) {
         error_setg(errp, "attribute \"sector-length\" not specified or zero.");
         return;
     }
-    if (pfl->nb_blocs == 0) {
+    if (pfl->uniform_nb_blocs == 0 && pfl->nb_blocs[0] == 0) {
         error_setg(errp, "attribute \"num-blocks\" not specified or zero.");
         return;
     }
@@ -619,7 +648,53 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    pfl->total_len = pfl->sector_len * pfl->nb_blocs;
+    int num_devices = pfl->bank_width / pfl->device_width;
+    int nb_regions;
+    pfl->total_len = 0;
+    for (nb_regions = 0; nb_regions < PFLASH_MAX_ERASE_REGIONS; ++nb_regions) {
+        if (pfl->nb_blocs[nb_regions] == 0) {
+            break;
+        }
+        uint64_t sector_len_per_device = pfl->sector_len[nb_regions] /
+                                         num_devices;
+
+        /*
+         * The size of each flash sector must be a power of 2 and it must be
+         * aligned at the same power of 2.
+         */
+        if (sector_len_per_device & 0xff ||
+            sector_len_per_device >= (1 << 24) ||
+            !is_power_of_2(sector_len_per_device))
+        {
+            error_setg(errp, "unsupported configuration: "
+                       "sector length[%d] per device = %" PRIx64 ".",
+                       nb_regions, sector_len_per_device);
+            return;
+        }
+        if ((pfl->total_len / num_devices) & (sector_len_per_device - 1)) {
+            error_setg(errp, "unsupported configuration: "
+                       "flash region %d not correctly aligned.",
+                       nb_regions);
+            return;
+        }
+
+        pfl->total_len += (uint64_t)pfl->sector_len[nb_regions] *
+                          pfl->nb_blocs[nb_regions];
+    }
+
+    uint64_t uniform_len = (uint64_t)pfl->uniform_nb_blocs *
+                           pfl->uniform_sector_len;
+    if (nb_regions == 0) {
+        nb_regions = 1;
+        pfl->nb_blocs[0] = pfl->uniform_nb_blocs;
+        pfl->sector_len[0] = pfl->uniform_sector_len;
+        pfl->total_len = uniform_len;
+    } else if (uniform_len != 0 && uniform_len != pfl->total_len) {
+        error_setg(errp, "\"num-blocks\"*\"sector-length\" "
+                   "different from \"num-blocks0\"*\'sector-length0\" + ... + "
+                   "\"num-blocks3\"*\"sector-length3\"");
+        return;
+    }
 
     /*
      * If the flash is not a power of 2, then the code for handling multiple
@@ -631,18 +706,6 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    int num_devices = pfl->bank_width / pfl->device_width;
-    uint64_t sector_len_per_device = pfl->sector_len / num_devices;
-    uint64_t device_len = sector_len_per_device * pfl->nb_blocs;
-
-    if (sector_len_per_device & 0xff || sector_len_per_device >= (1 << 24)) {
-        error_setg(errp,
-                   "unsupported configuration: sector length per device = "
-                   "%" PRIx64 ".",
-                   sector_len_per_device);
-        return;
-    }
-
     memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
                                   &pflash_cfi02_ops, pfl, pfl->name,
                                   pfl->total_len, &local_err);
@@ -650,8 +713,6 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     pfl->unlock_addr0 &= 0x7FF;
     pfl->unlock_addr1 &= 0x7FF;
 
-    chip_len = pfl->sector_len * pfl->nb_blocs;
-
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -672,8 +733,8 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     }
 
     if (pfl->blk) {
-        if (!blk_check_size_and_read_all(pfl->blk, pfl->storage, chip_len,
-                                         errp)) {
+        if (!blk_check_size_and_read_all(pfl->blk, pfl->storage,
+                                         pfl->total_len, errp)) {
             vmstate_unregister_ram(&pfl->orig_mem, DEVICE(pfl));
             return;
         }
@@ -697,7 +758,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     pfl->cfi_table[0x13] = 0x02;
     pfl->cfi_table[0x14] = 0x00;
     /* Primary extended table address */
-    pfl->cfi_table[0x15] = 0x31;
+    pfl->cfi_table[0x15] = 0x40;
     pfl->cfi_table[0x16] = 0x00;
     /* Alternate command set (none) */
     pfl->cfi_table[0x17] = 0x00;
@@ -730,7 +791,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     /* Max timeout for chip erase */
     pfl->cfi_table[0x26] = 0x0D;
     /* Device size */
-    pfl->cfi_table[0x27] = ctz32(device_len);
+    pfl->cfi_table[0x27] = ctz32(pfl->total_len / num_devices);
     /* Flash device interface  */
     pfl->cfi_table[0x28] = device_interface_code;
     pfl->cfi_table[0x29] = device_interface_code >> 8;
@@ -739,37 +800,49 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     /*    pfl->cfi_table[0x2A] = 0x05; */
     pfl->cfi_table[0x2A] = 0x00;
     pfl->cfi_table[0x2B] = 0x00;
-    /* Number of erase block regions (uniform) */
-    pfl->cfi_table[0x2C] = 0x01;
-    /* Erase block region 1 */
-    pfl->cfi_table[0x2D] = pfl->nb_blocs - 1;
-    pfl->cfi_table[0x2E] = (pfl->nb_blocs - 1) >> 8;
-    pfl->cfi_table[0x2F] = sector_len_per_device >> 8;
-    pfl->cfi_table[0x30] = sector_len_per_device >> 16;
+    /* Number of erase block regions */
+    pfl->cfi_table[0x2C] = nb_regions;
+    /* Erase block regions */
+    for (int i = 0; i < nb_regions; ++i) {
+        uint32_t sector_len_per_device = pfl->sector_len[i] / num_devices;
+        pfl->cfi_table[0x2D + 4 * i] = pfl->nb_blocs[i] - 1;
+        pfl->cfi_table[0x2E + 4 * i] = (pfl->nb_blocs[i] - 1) >> 8;
+        pfl->cfi_table[0x2F + 4 * i] = sector_len_per_device >> 8;
+        pfl->cfi_table[0x30 + 4 * i] = sector_len_per_device >> 16;
+    }
 
     /* Extended */
-    pfl->cfi_table[0x31] = 'P';
-    pfl->cfi_table[0x32] = 'R';
-    pfl->cfi_table[0x33] = 'I';
+    pfl->cfi_table[0x40] = 'P';
+    pfl->cfi_table[0x41] = 'R';
+    pfl->cfi_table[0x42] = 'I';
 
-    pfl->cfi_table[0x34] = '1';
-    pfl->cfi_table[0x35] = '0';
+    pfl->cfi_table[0x43] = '1'; /* version 1.0 */
+    pfl->cfi_table[0x44] = '0';
 
-    pfl->cfi_table[0x36] = 0x00;
-    pfl->cfi_table[0x37] = 0x00;
-    pfl->cfi_table[0x38] = 0x00;
-    pfl->cfi_table[0x39] = 0x00;
+    pfl->cfi_table[0x45] = 0x00; /* Address sensitive unlock required. */
+    pfl->cfi_table[0x46] = 0x00; /* Erase suspend not supported. */
+    pfl->cfi_table[0x47] = 0x00; /* Sector protect not supported. */
+    pfl->cfi_table[0x48] = 0x00; /* Temporary sector unprotect not supported. */
 
-    pfl->cfi_table[0x3a] = 0x00;
+    pfl->cfi_table[0x49] = 0x00; /* Sector protect/unprotect scheme. */
 
-    pfl->cfi_table[0x3b] = 0x00;
-    pfl->cfi_table[0x3c] = 0x00;
+    pfl->cfi_table[0x4a] = 0x00; /* Simultaneous operation not supported. */
+    pfl->cfi_table[0x4b] = 0x00; /* Burst mode not supported. */
+    pfl->cfi_table[0x4c] = 0x00; /* Page mode not supported. */
 }
 
 static Property pflash_cfi02_properties[] = {
     DEFINE_PROP_DRIVE("drive", PFlashCFI02, blk),
-    DEFINE_PROP_UINT32("num-blocks", PFlashCFI02, nb_blocs, 0),
-    DEFINE_PROP_UINT32("sector-length", PFlashCFI02, sector_len, 0),
+    DEFINE_PROP_UINT32("num-blocks", PFlashCFI02, uniform_nb_blocs, 0),
+    DEFINE_PROP_UINT32("sector-length", PFlashCFI02, uniform_sector_len, 0),
+    DEFINE_PROP_UINT32("num-blocks0", PFlashCFI02, nb_blocs[0], 0),
+    DEFINE_PROP_UINT32("sector-length0", PFlashCFI02, sector_len[0], 0),
+    DEFINE_PROP_UINT32("num-blocks1", PFlashCFI02, nb_blocs[1], 0),
+    DEFINE_PROP_UINT32("sector-length1", PFlashCFI02, sector_len[1], 0),
+    DEFINE_PROP_UINT32("num-blocks2", PFlashCFI02, nb_blocs[2], 0),
+    DEFINE_PROP_UINT32("sector-length2", PFlashCFI02, sector_len[2], 0),
+    DEFINE_PROP_UINT32("num-blocks3", PFlashCFI02, nb_blocs[3], 0),
+    DEFINE_PROP_UINT32("sector-length3", PFlashCFI02, sector_len[3], 0),
     DEFINE_PROP_UINT8("width", PFlashCFI02, bank_width, 0),
     DEFINE_PROP_UINT8("device-width", PFlashCFI02, device_width, 0),
     DEFINE_PROP_UINT8("max-device-width", PFlashCFI02, max_device_width, 0),
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index 4d621e584d..dc85783a6a 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -21,6 +21,9 @@
 #define MP_FLASH_SIZE_MAX (32 * 1024 * 1024)
 #define BASE_ADDR (0x100000000ULL - MP_FLASH_SIZE_MAX)
 
+#define UNIFORM_FLASH_SIZE (8 * 1024 * 1024)
+#define UNIFORM_FLASH_SECTOR_SIZE (64 * 1024)
+
 /* Use a newtype to keep flash addresses separate from byte addresses. */
 typedef struct {
     uint64_t addr;
@@ -43,9 +46,14 @@ typedef struct {
 #define UNLOCK_BYPASS_RESET_CMD 0x00
 
 typedef struct {
+    /* Interleave configuration. */
     int bank_width;
     int device_width;
     int max_device_width;
+
+    /* Nonuniform block size. */
+    int nb_blocs[4];
+    int sector_len[4];
 } FlashConfig;
 
 static char image_path[] = "/tmp/qtest.XXXXXX";
@@ -60,12 +68,22 @@ static FlashConfig expand_config_defaults(const FlashConfig *c)
 {
     FlashConfig ret = *c;
 
+    if (ret.bank_width == 0) {
+        ret.bank_width = 2;
+    }
     if (ret.device_width == 0) {
         ret.device_width = ret.bank_width;
     }
     if (ret.max_device_width == 0) {
         ret.max_device_width = ret.device_width;
     }
+    if (ret.nb_blocs[0] == 0 && ret.sector_len[0] == 0) {
+        ret.sector_len[0] = UNIFORM_FLASH_SECTOR_SIZE;
+        ret.nb_blocs[0] = UNIFORM_FLASH_SIZE / UNIFORM_FLASH_SECTOR_SIZE;
+    }
+
+    /* XXX: Limitations of test harness. */
+    assert(ret.bank_width == 2);
     return ret;
 }
 
@@ -157,8 +175,8 @@ static inline uint64_t as_byte_addr(const FlashConfig *c, faddr flash_addr)
      * which is bank_width / device_width, and multiply that by the maximum
      * device width.
      */
-    int num_devices = c->bank_width / c->device_width;
-    return flash_addr.addr * (num_devices * c->max_device_width);
+    int nb_devices = c->bank_width / c->device_width;
+    return flash_addr.addr * (nb_devices * c->max_device_width);
 }
 
 /*
@@ -248,22 +266,53 @@ static void chip_erase(const FlashConfig *c)
     flash_cmd(c, UNLOCK0_ADDR, CHIP_ERASE_CMD);
 }
 
-static void test_flash(const void *opaque)
+/*
+ * Test flash commands with a variety of device geometry.
+ */
+static void test_geometry(const void *opaque)
 {
     const FlashConfig *config = opaque;
+    /* Set the properties that are under our control. */
     global_qtest = qtest_initf("-M musicpal,accel=qtest"
                                " -drive if=pflash,file=%s,format=raw,"
                                "copy-on-read"
+                               /* Interleave properties. */
                                " -global driver=cfi.pflash02,"
                                "property=device-width,value=%d"
                                " -global driver=cfi.pflash02,"
-                               "property=max-device-width,value=%d",
+                               "property=max-device-width,value=%d"
+                               /* Device geometry properties. */
+                               " -global driver=cfi.pflash02,"
+                               "property=num-blocks0,value=%d"
+                               " -global driver=cfi.pflash02,"
+                               "property=sector-length0,value=%d"
+                               " -global driver=cfi.pflash02,"
+                               "property=num-blocks1,value=%d"
+                               " -global driver=cfi.pflash02,"
+                               "property=sector-length1,value=%d"
+                               " -global driver=cfi.pflash02,"
+                               "property=num-blocks2,value=%d"
+                               " -global driver=cfi.pflash02,"
+                               "property=sector-length2,value=%d"
+                               " -global driver=cfi.pflash02,"
+                               "property=num-blocks3,value=%d"
+                               " -global driver=cfi.pflash02,"
+                               "property=sector-length3,value=%d",
                                image_path,
                                config->device_width,
-                               config->max_device_width);
+                               config->max_device_width,
+                               config->nb_blocs[0],
+                               config->sector_len[0],
+                               config->nb_blocs[1],
+                               config->sector_len[1],
+                               config->nb_blocs[2],
+                               config->sector_len[2],
+                               config->nb_blocs[3],
+                               config->sector_len[3]);
 
     const FlashConfig explicit_config = expand_config_defaults(config);
     const FlashConfig *c = &explicit_config;
+    int nb_devices = c->bank_width / c->device_width;
 
     /* Check the IDs. */
     unlock(c);
@@ -287,38 +336,52 @@ static void test_flash(const void *opaque)
     g_assert_cmpint(flash_query(c, FLASH_ADDR(0x11)), ==, replicate(c, 'R'));
     g_assert_cmpint(flash_query(c, FLASH_ADDR(0x12)), ==, replicate(c, 'Y'));
     /* Num erase regions. */
-    g_assert_cmpint(flash_query_1(c, FLASH_ADDR(0x2C)), >=, 1);
-    uint32_t nb_sectors = flash_query_1(c, FLASH_ADDR(0x2D)) +
-                          (flash_query_1(c, FLASH_ADDR(0x2E)) << 8) + 1;
-    uint32_t sector_len = (flash_query_1(c, FLASH_ADDR(0x2F)) << 8) +
-                          (flash_query_1(c, FLASH_ADDR(0x30)) << 16);
+    int nb_erase_regions = flash_query_1(c, FLASH_ADDR(0x2C));
+    g_assert_cmpint(nb_erase_regions, ==,
+                    !!c->nb_blocs[0] + !!c->nb_blocs[1] + !!c->nb_blocs[2] +
+                    !!c->nb_blocs[3]);
     reset(c);
-
     const uint64_t dq7 = replicate(c, 0x80);
     const uint64_t dq6 = replicate(c, 0x40);
-    /* Erase and program sector. */
-    for (uint32_t i = 0; i < nb_sectors; ++i) {
-        uint64_t byte_addr = i * sector_len;
-        sector_erase(c, byte_addr);
-        /* Read toggle. */
-        uint64_t status0 = flash_read(c, byte_addr);
-        /* DQ7 is 0 during an erase. */
-        g_assert_cmpint(status0 & dq7, ==, 0);
-        uint64_t status1 = flash_read(c, byte_addr);
-        /* DQ6 toggles during an erase. */
-        g_assert_cmpint(status0 & dq6, ==, ~status1 & dq6);
-        /* Wait for erase to complete. */
-        clock_step_next();
-        /* Ensure DQ6 has stopped toggling. */
-        g_assert_cmpint(flash_read(c, byte_addr), ==, flash_read(c, byte_addr));
-        /* Now the data should be valid. */
-        g_assert_cmpint(flash_read(c, byte_addr), ==, bank_mask(c));
 
-        /* Program a bit pattern. */
-        program(c, byte_addr, 0x55);
-        g_assert_cmpint(flash_read(c, byte_addr) & 0xFF, ==, 0x55);
-        program(c, byte_addr, 0xA5);
-        g_assert_cmpint(flash_read(c, byte_addr) & 0xFF, ==, 0x05);
+    uint64_t byte_addr = 0;
+    for (int region = 0; region < nb_erase_regions; ++region) {
+        uint64_t base = 0x2D + 4 * region;
+        flash_cmd(c, CFI_ADDR, CFI_CMD);
+        uint32_t nb_sectors = flash_query_1(c, FLASH_ADDR(base + 0)) +
+                              (flash_query_1(c, FLASH_ADDR(base + 1)) << 8) + 1;
+        uint32_t sector_len = (flash_query_1(c, FLASH_ADDR(base + 2)) << 8) +
+                              (flash_query_1(c, FLASH_ADDR(base + 3)) << 16);
+        sector_len *= nb_devices;
+        g_assert_cmpint(nb_sectors, ==, c->nb_blocs[region]);
+        g_assert_cmpint(sector_len, ==, c->sector_len[region]);
+        reset(c);
+
+        /* Erase and program sector. */
+        for (uint32_t i = 0; i < nb_sectors; ++i) {
+            sector_erase(c, byte_addr);
+            /* Read toggle. */
+            uint64_t status0 = flash_read(c, byte_addr);
+            /* DQ7 is 0 during an erase. */
+            g_assert_cmpint(status0 & dq7, ==, 0);
+            uint64_t status1 = flash_read(c, byte_addr);
+            /* DQ6 toggles during an erase. */
+            g_assert_cmpint(status0 & dq6, ==, ~status1 & dq6);
+            /* Wait for erase to complete. */
+            clock_step_next();
+            /* Ensure DQ6 has stopped toggling. */
+            g_assert_cmpint(flash_read(c, byte_addr), ==,
+                            flash_read(c, byte_addr));
+            /* Now the data should be valid. */
+            g_assert_cmpint(flash_read(c, byte_addr), ==, bank_mask(c));
+
+            /* Program a bit pattern. */
+            program(c, byte_addr, 0x55);
+            g_assert_cmpint(flash_read(c, byte_addr) & 0xFF, ==, 0x55);
+            program(c, byte_addr, 0xA5);
+            g_assert_cmpint(flash_read(c, byte_addr) & 0xFF, ==, 0x05);
+            byte_addr += sector_len;
+        }
     }
 
     /* Erase the chip. */
@@ -336,9 +399,11 @@ static void test_flash(const void *opaque)
     g_assert_cmpint(flash_read(c, 0), ==, flash_read(c, 0));
     /* Now the data should be valid. */
 
-    for (uint32_t i = 0; i < nb_sectors; ++i) {
-        uint64_t byte_addr = i * sector_len;
-        g_assert_cmpint(flash_read(c, byte_addr), ==, bank_mask(c));
+    for (int region = 0; region < nb_erase_regions; ++region) {
+        for (uint32_t i = 0; i < c->nb_blocs[region]; ++i) {
+            uint64_t byte_addr = i * c->sector_len[region];
+            g_assert_cmpint(flash_read(c, byte_addr), ==, bank_mask(c));
+        }
     }
 
     /* Unlock bypass */
@@ -430,6 +495,32 @@ static const FlashConfig configuration[] = {
         .device_width = 1,
         .max_device_width = 4,
     },
+    /* Nonuniform sectors (top boot). */
+    {
+        .bank_width = 2,
+        .nb_blocs = { 127, 1, 2, 1 },
+        .sector_len = { 0x10000, 0x08000, 0x02000, 0x04000 },
+    },
+    /* Nonuniform sectors (top boot) with two x8 devices. */
+    {
+        .bank_width = 2,
+        .device_width = 1,
+        .nb_blocs = { 127, 1, 2, 1 },
+        .sector_len = { 0x10000, 0x08000, 0x02000, 0x04000 },
+    },
+    /* Nonuniform sectors (bottom boot). */
+    {
+        .bank_width = 2,
+        .nb_blocs = { 1, 2, 1, 127 },
+        .sector_len = { 0x04000, 0x02000, 0x08000, 0x10000 },
+    },
+    /* Nonuniform sectors (bottom boot) with two x8 devices. */
+    {
+        .bank_width = 2,
+        .device_width = 1,
+        .nb_blocs = { 1, 2, 1, 127 },
+        .sector_len = { 0x04000, 0x02000, 0x08000, 0x10000 },
+    },
 };
 
 int main(int argc, char **argv)
@@ -438,7 +529,7 @@ int main(int argc, char **argv)
     if (fd == -1) {
         err(1, "Failed to create temporary file %s", image_path);
     }
-    if (ftruncate(fd, 8 * 1024 * 1024) < 0) {
+    if (ftruncate(fd, UNIFORM_FLASH_SIZE) < 0) {
         int error_code = errno;
         close(fd);
         unlink(image_path);
@@ -454,11 +545,21 @@ int main(int argc, char **argv)
     size_t nb_configurations = sizeof configuration / sizeof configuration[0];
     for (size_t i = 0; i < nb_configurations; ++i) {
         const FlashConfig *config = &configuration[i];
-        char *path = g_strdup_printf("pflash-cfi02/%d-%d-%d",
+        char *path = g_strdup_printf("pflash-cfi02"
+                                     "/geometry/%dx%x-%dx%x-%dx%x-%dx%x"
+                                     "/%d-%d-%d",
+                                     config->nb_blocs[0],
+                                     config->sector_len[0],
+                                     config->nb_blocs[1],
+                                     config->sector_len[1],
+                                     config->nb_blocs[2],
+                                     config->sector_len[2],
+                                     config->nb_blocs[3],
+                                     config->sector_len[3],
                                      config->bank_width,
                                      config->device_width,
                                      config->max_device_width);
-        qtest_add_data_func(path, config, test_flash);
+        qtest_add_data_func(path, config, test_geometry);
         g_free(path);
     }
     int result = g_test_run();
-- 
2.20.1 (Apple Git-117)


