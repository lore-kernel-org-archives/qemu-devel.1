Received: from eggs.gnu.org ([2001:4830:134:3::10]:60978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3z-0001CQ-JR
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3o-0005gs-JU
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:21 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA3n-0005PF-H1
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:15 -0400
Received: by mail-wm0-x243.google.com with SMTP id y2-v6so3642512wma.1
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:07 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-184-244.clienti.tiscali.it.
	[78.12.184.244]) by smtp.gmail.com with ESMTPSA id
	v6-v6sm2608955wmc.43.2018.08.21.10.03.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 Aug 2018 10:03:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:35 +0200
Message-Id: <1534870966-9287-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/74] es1370: simplify MemoryRegionOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use the automatic subregister extraction from the memory API, and avoid
that Coverity complains about missing fallthrough comments.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/audio/es1370.c | 235 ++++++------------------------------------------------
 1 file changed, 25 insertions(+), 210 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 59cf252..dd75c9e 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -474,82 +474,7 @@ static inline uint32_t es1370_fixup (ES1370State *s, uint32_t addr)
     return addr;
 }
 
-static void es1370_writeb(void *opaque, uint32_t addr, uint32_t val)
-{
-    ES1370State *s = opaque;
-    uint32_t shift, mask;
-
-    addr = es1370_fixup (s, addr);
-
-    switch (addr) {
-    case ES1370_REG_CONTROL:
-    case ES1370_REG_CONTROL + 1:
-    case ES1370_REG_CONTROL + 2:
-    case ES1370_REG_CONTROL + 3:
-        shift = (addr - ES1370_REG_CONTROL) << 3;
-        mask = 0xff << shift;
-        val = (s->ctl & ~mask) | ((val & 0xff) << shift);
-        es1370_update_voices (s, val, s->sctl);
-        print_ctl (val);
-        break;
-    case ES1370_REG_MEMPAGE:
-        s->mempage = val;
-        break;
-    case ES1370_REG_SERIAL_CONTROL:
-    case ES1370_REG_SERIAL_CONTROL + 1:
-    case ES1370_REG_SERIAL_CONTROL + 2:
-    case ES1370_REG_SERIAL_CONTROL + 3:
-        shift = (addr - ES1370_REG_SERIAL_CONTROL) << 3;
-        mask = 0xff << shift;
-        val = (s->sctl & ~mask) | ((val & 0xff) << shift);
-        es1370_maybe_lower_irq (s, val);
-        es1370_update_voices (s, s->ctl, val);
-        print_sctl (val);
-        break;
-    default:
-        lwarn ("writeb %#x <- %#x\n", addr, val);
-        break;
-    }
-}
-
-static void es1370_writew(void *opaque, uint32_t addr, uint32_t val)
-{
-    ES1370State *s = opaque;
-    addr = es1370_fixup (s, addr);
-    uint32_t shift, mask;
-    struct chan *d = &s->chan[0];
-
-    switch (addr) {
-    case ES1370_REG_CODEC:
-        dolog ("ignored codec write address %#x, data %#x\n",
-               (val >> 8) & 0xff, val & 0xff);
-        s->codec = val;
-        break;
-
-    case ES1370_REG_CONTROL:
-    case ES1370_REG_CONTROL + 2:
-        shift = (addr != ES1370_REG_CONTROL) << 4;
-        mask = 0xffff << shift;
-        val = (s->ctl & ~mask) | ((val & 0xffff) << shift);
-        es1370_update_voices (s, val, s->sctl);
-        print_ctl (val);
-        break;
-
-    case ES1370_REG_ADC_SCOUNT:
-        d++;
-    case ES1370_REG_DAC2_SCOUNT:
-        d++;
-    case ES1370_REG_DAC1_SCOUNT:
-        d->scount = (d->scount & ~0xffff) | (val & 0xffff);
-        break;
-
-    default:
-        lwarn ("writew %#x <- %#x\n", addr, val);
-        break;
-    }
-}
-
-static void es1370_writel(void *opaque, uint32_t addr, uint32_t val)
+static void es1370_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
 {
     ES1370State *s = opaque;
     struct chan *d = &s->chan[0];
@@ -572,21 +497,19 @@ static void es1370_writel(void *opaque, uint32_t addr, uint32_t val)
         print_sctl (val);
         break;
 
-    case ES1370_REG_ADC_SCOUNT:
-        d++;
-    case ES1370_REG_DAC2_SCOUNT:
-        d++;
     case ES1370_REG_DAC1_SCOUNT:
+    case ES1370_REG_DAC2_SCOUNT:
+    case ES1370_REG_ADC_SCOUNT:
+        d += (addr - ES1370_REG_DAC1_SCOUNT) >> 2;
         d->scount = (val & 0xffff) | (d->scount & ~0xffff);
         ldebug ("chan %td CURR_SAMP_CT %d, SAMP_CT %d\n",
                 d - &s->chan[0], val >> 16, (val & 0xffff));
         break;
 
-    case ES1370_REG_ADC_FRAMEADR:
-        d++;
-    case ES1370_REG_DAC2_FRAMEADR:
-        d++;
     case ES1370_REG_DAC1_FRAMEADR:
+    case ES1370_REG_DAC2_FRAMEADR:
+    case ES1370_REG_ADC_FRAMEADR:
+        d += (addr - ES1370_REG_DAC1_FRAMEADR) >> 3;
         d->frame_addr = val;
         ldebug ("chan %td frame address %#x\n", d - &s->chan[0], val);
         break;
@@ -598,11 +521,10 @@ static void es1370_writel(void *opaque, uint32_t addr, uint32_t val)
         lwarn ("writing to phantom frame address %#x\n", val);
         break;
 
-    case ES1370_REG_ADC_FRAMECNT:
-        d++;
-    case ES1370_REG_DAC2_FRAMECNT:
-        d++;
     case ES1370_REG_DAC1_FRAMECNT:
+    case ES1370_REG_DAC2_FRAMECNT:
+    case ES1370_REG_ADC_FRAMECNT:
+        d += (addr - ES1370_REG_DAC1_FRAMECNT) >> 3;
         d->frame_cnt = val;
         d->leftover = 0;
         ldebug ("chan %td frame count %d, buffer size %d\n",
@@ -615,84 +537,7 @@ static void es1370_writel(void *opaque, uint32_t addr, uint32_t val)
     }
 }
 
-static uint32_t es1370_readb(void *opaque, uint32_t addr)
-{
-    ES1370State *s = opaque;
-    uint32_t val;
-
-    addr = es1370_fixup (s, addr);
-
-    switch (addr) {
-    case 0x1b:                  /* Legacy */
-        lwarn ("Attempt to read from legacy register\n");
-        val = 5;
-        break;
-    case ES1370_REG_MEMPAGE:
-        val = s->mempage;
-        break;
-    case ES1370_REG_CONTROL + 0:
-    case ES1370_REG_CONTROL + 1:
-    case ES1370_REG_CONTROL + 2:
-    case ES1370_REG_CONTROL + 3:
-        val = s->ctl >> ((addr - ES1370_REG_CONTROL) << 3);
-        break;
-    case ES1370_REG_STATUS + 0:
-    case ES1370_REG_STATUS + 1:
-    case ES1370_REG_STATUS + 2:
-    case ES1370_REG_STATUS + 3:
-        val = s->status >> ((addr - ES1370_REG_STATUS) << 3);
-        break;
-    default:
-        val = ~0;
-        lwarn ("readb %#x -> %#x\n", addr, val);
-        break;
-    }
-    return val;
-}
-
-static uint32_t es1370_readw(void *opaque, uint32_t addr)
-{
-    ES1370State *s = opaque;
-    struct chan *d = &s->chan[0];
-    uint32_t val;
-
-    addr = es1370_fixup (s, addr);
-
-    switch (addr) {
-    case ES1370_REG_ADC_SCOUNT + 2:
-        d++;
-    case ES1370_REG_DAC2_SCOUNT + 2:
-        d++;
-    case ES1370_REG_DAC1_SCOUNT + 2:
-        val = d->scount >> 16;
-        break;
-
-    case ES1370_REG_ADC_FRAMECNT:
-        d++;
-    case ES1370_REG_DAC2_FRAMECNT:
-        d++;
-    case ES1370_REG_DAC1_FRAMECNT:
-        val = d->frame_cnt & 0xffff;
-        break;
-
-    case ES1370_REG_ADC_FRAMECNT + 2:
-        d++;
-    case ES1370_REG_DAC2_FRAMECNT + 2:
-        d++;
-    case ES1370_REG_DAC1_FRAMECNT + 2:
-        val = d->frame_cnt >> 16;
-        break;
-
-    default:
-        val = ~0;
-        lwarn ("readw %#x -> %#x\n", addr, val);
-        break;
-    }
-
-    return val;
-}
-
-static uint32_t es1370_readl(void *opaque, uint32_t addr)
+static uint64_t es1370_read(void *opaque, hwaddr addr, unsigned size)
 {
     ES1370State *s = opaque;
     uint32_t val;
@@ -717,11 +562,10 @@ static uint32_t es1370_readl(void *opaque, uint32_t addr)
         val = s->sctl;
         break;
 
-    case ES1370_REG_ADC_SCOUNT:
-        d++;
-    case ES1370_REG_DAC2_SCOUNT:
-        d++;
     case ES1370_REG_DAC1_SCOUNT:
+    case ES1370_REG_DAC2_SCOUNT:
+    case ES1370_REG_ADC_SCOUNT:
+        d += (addr - ES1370_REG_DAC1_SCOUNT) >> 2;
         val = d->scount;
 #ifdef DEBUG_ES1370
         {
@@ -735,11 +579,10 @@ static uint32_t es1370_readl(void *opaque, uint32_t addr)
 #endif
         break;
 
-    case ES1370_REG_ADC_FRAMECNT:
-        d++;
-    case ES1370_REG_DAC2_FRAMECNT:
-        d++;
     case ES1370_REG_DAC1_FRAMECNT:
+    case ES1370_REG_DAC2_FRAMECNT:
+    case ES1370_REG_ADC_FRAMECNT:
+        d += (addr - ES1370_REG_DAC1_FRAMECNT) >> 3;
         val = d->frame_cnt;
 #ifdef DEBUG_ES1370
         {
@@ -753,11 +596,10 @@ static uint32_t es1370_readl(void *opaque, uint32_t addr)
 #endif
         break;
 
-    case ES1370_REG_ADC_FRAMEADR:
-        d++;
-    case ES1370_REG_DAC2_FRAMEADR:
-        d++;
     case ES1370_REG_DAC1_FRAMEADR:
+    case ES1370_REG_DAC2_FRAMEADR:
+    case ES1370_REG_ADC_FRAMEADR:
+        d += (addr - ES1370_REG_DAC1_FRAMEADR) >> 3;
         val = d->frame_addr;
         break;
 
@@ -908,44 +750,17 @@ static void es1370_adc_callback (void *opaque, int avail)
     es1370_run_channel (s, ADC_CHANNEL, avail);
 }
 
-static uint64_t es1370_read(void *opaque, hwaddr addr,
-                            unsigned size)
-{
-    switch (size) {
-    case 1:
-        return es1370_readb(opaque, addr);
-    case 2:
-        return es1370_readw(opaque, addr);
-    case 4:
-        return es1370_readl(opaque, addr);
-    default:
-        return -1;
-    }
-}
-
-static void es1370_write(void *opaque, hwaddr addr, uint64_t val,
-                      unsigned size)
-{
-    switch (size) {
-    case 1:
-        es1370_writeb(opaque, addr, val);
-        break;
-    case 2:
-        es1370_writew(opaque, addr, val);
-        break;
-    case 4:
-        es1370_writel(opaque, addr, val);
-        break;
-    }
-}
-
 static const MemoryRegionOps es1370_io_ops = {
     .read = es1370_read,
     .write = es1370_write,
-    .impl = {
+    .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
     },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-- 
1.8.3.1
