Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07EAC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5534D2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHdetca4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5534D2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTIFv-0007VD-8k
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 01:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kTIER-0006aV-Vo
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kTIEP-0002YK-JE
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602825884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxtuLzdJo8GjTOuAgOrDwvK/4bPK4aKYuQsn5L+FMWM=;
 b=DHdetca4fw8eLc15sGSDbCLDND2c3l78GjWoGfzplpK/m64UqKugHMbk8xv7sMCRbhF7k+
 vPIiybGbmusZdUre+CdF3I6bAxkg62YovbnuG4WPpGiS9omWPsjSr9bbes/tU3HEwh6mn9
 VH4RUR6ApIs7/tuungdC4uQ2IN2MU7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-Ssgol0qqO7CmnDRub6ficQ-1; Fri, 16 Oct 2020 01:24:42 -0400
X-MC-Unique: Ssgol0qqO7CmnDRub6ficQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C19D01007465;
 Fri, 16 Oct 2020 05:24:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D827B5D9CA;
 Fri, 16 Oct 2020 05:24:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 047781750A; Fri, 16 Oct 2020 07:24:36 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] usb: hcd-dwc2: change assert()s to
 qemu_log_mask(LOG_GUEST_ERROR...)
Date: Fri, 16 Oct 2020 07:24:33 +0200
Message-Id: <20201016052435.26180-2-kraxel@redhat.com>
In-Reply-To: <20201016052435.26180-1-kraxel@redhat.com>
References: <20201016052435.26180-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:29:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paul Zimmerman <pauldzim@gmail.com>

Change several assert()s to qemu_log_mask(LOG_GUEST_ERROR...),
to prevent the guest from causing Qemu to assert. Also fix up
several existing qemu_log_mask()s to include the function name in
the message.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
Message-id: 20200920021449.830-1-pauldzim@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-dwc2.c | 100 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 81 insertions(+), 19 deletions(-)

diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index 97688d21bf0f..64c23c1ed084 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -238,7 +238,12 @@ static void dwc2_handle_packet(DWC2State *s, uint32_t devadr, USBDevice *dev,
     pid = get_field(hctsiz, TSIZ_SC_MC_PID);
     pcnt = get_field(hctsiz, TSIZ_PKTCNT);
     len = get_field(hctsiz, TSIZ_XFERSIZE);
-    assert(len <= DWC2_MAX_XFER_SIZE);
+    if (len > DWC2_MAX_XFER_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: HCTSIZ transfer size too large\n", __func__);
+        return;
+    }
+
     chan = index >> 3;
     p = &s->packet[chan];
 
@@ -663,7 +668,12 @@ static uint64_t dwc2_glbreg_read(void *ptr, hwaddr addr, int index,
     DWC2State *s = ptr;
     uint32_t val;
 
-    assert(addr <= GINTSTS2);
+    if (addr > GINTSTS2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        return 0;
+    }
+
     val = s->glbreg[index];
 
     switch (addr) {
@@ -690,7 +700,12 @@ static void dwc2_glbreg_write(void *ptr, hwaddr addr, int index, uint64_t val,
     uint32_t old;
     int iflg = 0;
 
-    assert(addr <= GINTSTS2);
+    if (addr > GINTSTS2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        return;
+    }
+
     mmio = &s->glbreg[index];
     old = *mmio;
 
@@ -715,27 +730,34 @@ static void dwc2_glbreg_write(void *ptr, hwaddr addr, int index, uint64_t val,
         val &= ~GRSTCTL_DMAREQ;
         if (!(old & GRSTCTL_TXFFLSH) && (val & GRSTCTL_TXFFLSH)) {
                 /* TODO - TX fifo flush */
-            qemu_log_mask(LOG_UNIMP, "Tx FIFO flush not implemented\n");
+            qemu_log_mask(LOG_UNIMP, "%s: Tx FIFO flush not implemented\n",
+                          __func__);
         }
         if (!(old & GRSTCTL_RXFFLSH) && (val & GRSTCTL_RXFFLSH)) {
                 /* TODO - RX fifo flush */
-            qemu_log_mask(LOG_UNIMP, "Rx FIFO flush not implemented\n");
+            qemu_log_mask(LOG_UNIMP, "%s: Rx FIFO flush not implemented\n",
+                          __func__);
         }
         if (!(old & GRSTCTL_IN_TKNQ_FLSH) && (val & GRSTCTL_IN_TKNQ_FLSH)) {
                 /* TODO - device IN token queue flush */
-            qemu_log_mask(LOG_UNIMP, "Token queue flush not implemented\n");
+            qemu_log_mask(LOG_UNIMP, "%s: Token queue flush not implemented\n",
+                          __func__);
         }
         if (!(old & GRSTCTL_FRMCNTRRST) && (val & GRSTCTL_FRMCNTRRST)) {
                 /* TODO - host frame counter reset */
-            qemu_log_mask(LOG_UNIMP, "Frame counter reset not implemented\n");
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: Frame counter reset not implemented\n",
+                          __func__);
         }
         if (!(old & GRSTCTL_HSFTRST) && (val & GRSTCTL_HSFTRST)) {
                 /* TODO - host soft reset */
-            qemu_log_mask(LOG_UNIMP, "Host soft reset not implemented\n");
+            qemu_log_mask(LOG_UNIMP, "%s: Host soft reset not implemented\n",
+                          __func__);
         }
         if (!(old & GRSTCTL_CSFTRST) && (val & GRSTCTL_CSFTRST)) {
                 /* TODO - core soft reset */
-            qemu_log_mask(LOG_UNIMP, "Core soft reset not implemented\n");
+            qemu_log_mask(LOG_UNIMP, "%s: Core soft reset not implemented\n",
+                          __func__);
         }
         /* don't allow clearing of self-clearing bits */
         val |= old & (GRSTCTL_TXFFLSH | GRSTCTL_RXFFLSH |
@@ -774,7 +796,12 @@ static uint64_t dwc2_fszreg_read(void *ptr, hwaddr addr, int index,
     DWC2State *s = ptr;
     uint32_t val;
 
-    assert(addr == HPTXFSIZ);
+    if (addr != HPTXFSIZ) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        return 0;
+    }
+
     val = s->fszreg[index];
 
     trace_usb_dwc2_fszreg_read(addr, val);
@@ -789,7 +816,12 @@ static void dwc2_fszreg_write(void *ptr, hwaddr addr, int index, uint64_t val,
     uint32_t *mmio;
     uint32_t old;
 
-    assert(addr == HPTXFSIZ);
+    if (addr != HPTXFSIZ) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        return;
+    }
+
     mmio = &s->fszreg[index];
     old = *mmio;
 
@@ -810,7 +842,12 @@ static uint64_t dwc2_hreg0_read(void *ptr, hwaddr addr, int index,
     DWC2State *s = ptr;
     uint32_t val;
 
-    assert(addr >= HCFG && addr <= HPRT0);
+    if (addr < HCFG || addr > HPRT0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        return 0;
+    }
+
     val = s->hreg0[index];
 
     switch (addr) {
@@ -837,7 +874,12 @@ static void dwc2_hreg0_write(void *ptr, hwaddr addr, int index, uint64_t val,
     int prst = 0;
     int iflg = 0;
 
-    assert(addr >= HCFG && addr <= HPRT0);
+    if (addr < HCFG || addr > HPRT0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        return;
+    }
+
     mmio = &s->hreg0[index];
     old = *mmio;
 
@@ -923,7 +965,12 @@ static uint64_t dwc2_hreg1_read(void *ptr, hwaddr addr, int index,
     DWC2State *s = ptr;
     uint32_t val;
 
-    assert(addr >= HCCHAR(0) && addr <= HCDMAB(DWC2_NB_CHAN - 1));
+    if (addr < HCCHAR(0) || addr > HCDMAB(DWC2_NB_CHAN - 1)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        return 0;
+    }
+
     val = s->hreg1[index];
 
     trace_usb_dwc2_hreg1_read(addr, hreg1nm[index & 7], addr >> 5, val);
@@ -941,7 +988,12 @@ static void dwc2_hreg1_write(void *ptr, hwaddr addr, int index, uint64_t val,
     int enflg = 0;
     int disflg = 0;
 
-    assert(addr >= HCCHAR(0) && addr <= HCDMAB(DWC2_NB_CHAN - 1));
+    if (addr < HCCHAR(0) || addr > HCDMAB(DWC2_NB_CHAN - 1)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        return;
+    }
+
     mmio = &s->hreg1[index];
     old = *mmio;
 
@@ -1008,7 +1060,12 @@ static uint64_t dwc2_pcgreg_read(void *ptr, hwaddr addr, int index,
     DWC2State *s = ptr;
     uint32_t val;
 
-    assert(addr >= PCGCTL && addr <= PCGCCTL1);
+    if (addr < PCGCTL || addr > PCGCCTL1) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        return 0;
+    }
+
     val = s->pcgreg[index];
 
     trace_usb_dwc2_pcgreg_read(addr, pcgregnm[index], val);
@@ -1023,7 +1080,12 @@ static void dwc2_pcgreg_write(void *ptr, hwaddr addr, int index,
     uint32_t *mmio;
     uint32_t old;
 
-    assert(addr >= PCGCTL && addr <= PCGCCTL1);
+    if (addr < PCGCTL || addr > PCGCCTL1) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        return;
+    }
+
     mmio = &s->pcgreg[index];
     old = *mmio;
 
@@ -1108,7 +1170,7 @@ static uint64_t dwc2_hreg2_read(void *ptr, hwaddr addr, unsigned size)
 {
     /* TODO - implement FIFOs to support slave mode */
     trace_usb_dwc2_hreg2_read(addr, addr >> 12, 0);
-    qemu_log_mask(LOG_UNIMP, "FIFO read not implemented\n");
+    qemu_log_mask(LOG_UNIMP, "%s: FIFO read not implemented\n", __func__);
     return 0;
 }
 
@@ -1119,7 +1181,7 @@ static void dwc2_hreg2_write(void *ptr, hwaddr addr, uint64_t val,
 
     /* TODO - implement FIFOs to support slave mode */
     trace_usb_dwc2_hreg2_write(addr, addr >> 12, orig, 0, val);
-    qemu_log_mask(LOG_UNIMP, "FIFO write not implemented\n");
+    qemu_log_mask(LOG_UNIMP, "%s: FIFO write not implemented\n", __func__);
 }
 
 static const MemoryRegionOps dwc2_mmio_hreg2_ops = {
-- 
2.27.0


