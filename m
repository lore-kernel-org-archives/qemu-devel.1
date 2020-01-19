Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92ECC33CAF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 23:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E65F206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 23:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E65F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itJhG-0005u8-9n
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 18:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1itJfi-00049W-6g
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 18:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1itJfg-0003kx-Ng
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 18:07:58 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:54650)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1itJfg-0003k5-Ij; Sun, 19 Jan 2020 18:07:56 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id EF3702991A; Sun, 19 Jan 2020 18:07:54 -0500 (EST)
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Message-Id: <484f90e6295afd927c38c25d5d216233551846d2.1579474761.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1579474761.git.fthain@telegraphics.com.au>
References: <cover.1579474761.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 02/14] dp8393x: Always use 32-bit accesses
Date: Mon, 20 Jan 2020 09:59:21 +1100
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The DP83932 and DP83934 have 32 data lines. The datasheet says,

    Data Bus: These bidirectional lines are used to transfer data on the
    system bus. When the SONIC is a bus master, 16-bit data is transferred
    on D15-D0 and 32-bit data is transferred on D31-D0. When the SONIC is
    accessed as a slave, register data is driven onto lines D15-D0.
    D31-D16 are held TRI-STATE if SONIC is in 16-bit mode. If SONIC is in
    32-bit mode, they are driven, but invalid.

Always use 32-bit accesses both as bus master and bus slave.

Force the MSW to zero in bus master mode.

This gets the Linux 'jazzsonic' driver working, and avoids the need for
prior hacks to make the NetBSD 'sn' driver work.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 hw/net/dp8393x.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 14901c1445..b2fd44bc2f 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -246,9 +246,19 @@ static void dp8393x_put(dp8393xState *s, int width, int offset,
                         uint16_t val)
 {
     if (s->big_endian) {
-        s->data[offset * width + width - 1] = cpu_to_be16(val);
+        if (width == 2) {
+            s->data[offset * 2] = 0;
+            s->data[offset * 2 + 1] = cpu_to_be16(val);
+        } else {
+            s->data[offset] = cpu_to_be16(val);
+        }
     } else {
-        s->data[offset * width] = cpu_to_le16(val);
+        if (width == 2) {
+            s->data[offset * 2] = cpu_to_le16(val);
+            s->data[offset * 2 + 1] = 0;
+        } else {
+            s->data[offset] = cpu_to_le16(val);
+        }
     }
 }
 
@@ -588,7 +598,7 @@ static uint64_t dp8393x_read(void *opaque, hwaddr addr, unsigned int size)
 
     DPRINTF("read 0x%04x from reg %s\n", val, reg_names[reg]);
 
-    return val;
+    return s->big_endian ? val << 16 : val;
 }
 
 static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
@@ -596,13 +606,14 @@ static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
 {
     dp8393xState *s = opaque;
     int reg = addr >> s->it_shift;
+    uint32_t val = s->big_endian ? data >> 16 : data;
 
-    DPRINTF("write 0x%04x to reg %s\n", (uint16_t)data, reg_names[reg]);
+    DPRINTF("write 0x%04x to reg %s\n", (uint16_t)val, reg_names[reg]);
 
     switch (reg) {
         /* Command register */
         case SONIC_CR:
-            dp8393x_do_command(s, data);
+            dp8393x_do_command(s, val);
             break;
         /* Prevent write to read-only registers */
         case SONIC_CAP2:
@@ -615,36 +626,36 @@ static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
         /* Accept write to some registers only when in reset mode */
         case SONIC_DCR:
             if (s->regs[SONIC_CR] & SONIC_CR_RST) {
-                s->regs[reg] = data & 0xbfff;
+                s->regs[reg] = val & 0xbfff;
             } else {
                 DPRINTF("writing to DCR invalid\n");
             }
             break;
         case SONIC_DCR2:
             if (s->regs[SONIC_CR] & SONIC_CR_RST) {
-                s->regs[reg] = data & 0xf017;
+                s->regs[reg] = val & 0xf017;
             } else {
                 DPRINTF("writing to DCR2 invalid\n");
             }
             break;
         /* 12 lower bytes are Read Only */
         case SONIC_TCR:
-            s->regs[reg] = data & 0xf000;
+            s->regs[reg] = val & 0xf000;
             break;
         /* 9 lower bytes are Read Only */
         case SONIC_RCR:
-            s->regs[reg] = data & 0xffe0;
+            s->regs[reg] = val & 0xffe0;
             break;
         /* Ignore most significant bit */
         case SONIC_IMR:
-            s->regs[reg] = data & 0x7fff;
+            s->regs[reg] = val & 0x7fff;
             dp8393x_update_irq(s);
             break;
         /* Clear bits by writing 1 to them */
         case SONIC_ISR:
-            data &= s->regs[reg];
-            s->regs[reg] &= ~data;
-            if (data & SONIC_ISR_RBE) {
+            val &= s->regs[reg];
+            s->regs[reg] &= ~val;
+            if (val & SONIC_ISR_RBE) {
                 dp8393x_do_read_rra(s);
             }
             dp8393x_update_irq(s);
@@ -657,17 +668,17 @@ static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
         case SONIC_REA:
         case SONIC_RRP:
         case SONIC_RWP:
-            s->regs[reg] = data & 0xfffe;
+            s->regs[reg] = val & 0xfffe;
             break;
         /* Invert written value for some registers */
         case SONIC_CRCT:
         case SONIC_FAET:
         case SONIC_MPT:
-            s->regs[reg] = data ^ 0xffff;
+            s->regs[reg] = val ^ 0xffff;
             break;
         /* All other registers have no special contrainst */
         default:
-            s->regs[reg] = data;
+            s->regs[reg] = val;
     }
 
     if (reg == SONIC_WT0 || reg == SONIC_WT1) {
@@ -678,8 +689,8 @@ static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps dp8393x_ops = {
     .read = dp8393x_read,
     .write = dp8393x_write,
-    .impl.min_access_size = 2,
-    .impl.max_access_size = 2,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.24.1


