Received: from eggs.gnu.org ([2001:4830:134:3::10]:48011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyF-0007H2-8W
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEy8-0006DI-LC
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:35 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:37726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEy5-00063j-Fo
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:31 -0400
Received: by mail-wr1-x432.google.com with SMTP id q1-v6so2207060wrs.4
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:19 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-231-174.clienti.tiscali.it.
	[78.12.231.174]) by smtp.gmail.com with ESMTPSA id
	a12-v6sm14270952wrr.71.2018.10.18.13.32.17
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Oct 2018 13:32:17 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:28 +0200
Message-Id: <1539894735-14232-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/48] es1370: more fixes for ADC_FRAMEADR and
 ADC_FRAMECNT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

They are not consecutive with DAC1_FRAME* and DAC2_FRAME*; Coverity
still complains about es1370_read, while es1370_write was fixed in
commit cf9270e5220671f49cc238deaf6136669cc07ae1.

Fixes: 154c1d1f960c5147a3f8ef00907504112f271cd8
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/audio/es1370.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 4f980a5..aa5a8d7 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -585,9 +585,12 @@ static uint64_t es1370_read(void *opaque, hwaddr addr, unsigned size)
 #endif
         break;
 
+    case ES1370_REG_ADC_FRAMECNT:
+        d += 2;
+        goto framecnt;
     case ES1370_REG_DAC1_FRAMECNT:
     case ES1370_REG_DAC2_FRAMECNT:
-    case ES1370_REG_ADC_FRAMECNT:
+    framecnt:
         d += (addr - ES1370_REG_DAC1_FRAMECNT) >> 3;
         val = d->frame_cnt;
 #ifdef DEBUG_ES1370
@@ -602,9 +605,12 @@ static uint64_t es1370_read(void *opaque, hwaddr addr, unsigned size)
 #endif
         break;
 
+    case ES1370_REG_ADC_FRAMEADR:
+        d += 2;
+        goto frameadr;
     case ES1370_REG_DAC1_FRAMEADR:
     case ES1370_REG_DAC2_FRAMEADR:
-    case ES1370_REG_ADC_FRAMEADR:
+    frameadr:
         d += (addr - ES1370_REG_DAC1_FRAMEADR) >> 3;
         val = d->frame_addr;
         break;
-- 
1.8.3.1
