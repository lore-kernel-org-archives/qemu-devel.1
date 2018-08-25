Received: from eggs.gnu.org ([2001:4830:134:3::10]:55809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ftTIV-0005z0-BS
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 03:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ftTIQ-0000nG-C7
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 03:47:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ftTIQ-0000lL-5J
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 03:47:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id v90-v6so9228892wrc.0
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 00:47:45 -0700 (PDT)
Received: from donizetti.lan (dynamic-adsl-78-12-184-59.clienti.tiscali.it.
	[78.12.184.59]) by smtp.gmail.com with ESMTPSA id
	z101-v6sm14977593wrb.55.2018.08.25.00.47.43
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 Aug 2018 00:47:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 25 Aug 2018 09:47:42 +0200
Message-Id: <20180825074742.15963-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] es1370: fix ADC_FRAMEADR and ADC_FRAMECNT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

They are not consecutive with DAC1_FRAME* and DAC2_FRAME*.

Fixes: 154c1d1f960c5147a3f8ef00907504112f271cd8
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/audio/es1370.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index dd75c9e8f5..4f980a598b 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -506,10 +506,13 @@ static void es1370_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
                 d - &s->chan[0], val >> 16, (val & 0xffff));
         break;
 
+    case ES1370_REG_ADC_FRAMEADR:
+        d += 2;
+        goto frameadr;
     case ES1370_REG_DAC1_FRAMEADR:
     case ES1370_REG_DAC2_FRAMEADR:
-    case ES1370_REG_ADC_FRAMEADR:
         d += (addr - ES1370_REG_DAC1_FRAMEADR) >> 3;
+    frameadr:
         d->frame_addr = val;
         ldebug ("chan %td frame address %#x\n", d - &s->chan[0], val);
         break;
@@ -521,10 +524,13 @@ static void es1370_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         lwarn ("writing to phantom frame address %#x\n", val);
         break;
 
+    case ES1370_REG_ADC_FRAMECNT:
+        d += 2;
+        goto framecnt;
     case ES1370_REG_DAC1_FRAMECNT:
     case ES1370_REG_DAC2_FRAMECNT:
-    case ES1370_REG_ADC_FRAMECNT:
         d += (addr - ES1370_REG_DAC1_FRAMECNT) >> 3;
+    framecnt:
         d->frame_cnt = val;
         d->leftover = 0;
         ldebug ("chan %td frame count %d, buffer size %d\n",
-- 
2.17.1
