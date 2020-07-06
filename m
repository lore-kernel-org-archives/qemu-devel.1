Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1274AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC13206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLqDLsb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC13206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsLds-0001G3-4p
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 03:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsLYb-0003QL-Nd
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 03:28:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52266
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsLYY-0004Lt-VK
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 03:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594020530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NpLhPcTzNcz5EtG/xYX0R96tjV4b1A8773ZUPrdDRUg=;
 b=CLqDLsb6CVKUaG7UCVGgtVYAPkOFzeQJsfMCsAzmphoRP5nk44drYG91Vu9j5UGtUwS8lO
 NHPJRvmwUqPF3gzQec1x/I38C7H0sXC1uGO9rj5rEZEfhPKEM+NVArulagxfXgDzAkUBxO
 sMlgeOpJfv39WvdRgQHw9zpoOOVWED8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-LecQw-LdOfGZXFgyTts6KQ-1; Mon, 06 Jul 2020 03:28:48 -0400
X-MC-Unique: LecQw-LdOfGZXFgyTts6KQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3AC28014D7;
 Mon,  6 Jul 2020 07:28:46 +0000 (UTC)
Received: from thuth.com (ovpn-112-144.ams2.redhat.com [10.36.112.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F3235D9CC;
 Mon,  6 Jul 2020 07:28:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 5/6] hw/m68k/mcf5206: Replace remaining hw_error()s by
 qemu_log_mask()
Date: Mon,  6 Jul 2020 09:28:34 +0200
Message-Id: <20200706072835.23582-6-thuth@redhat.com>
In-Reply-To: <20200706072835.23582-1-thuth@redhat.com>
References: <20200706072835.23582-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@tuxfamily.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <huth@tuxfamily.org>

hw_error() dumps the CPU state and exits QEMU. This is ok during initial
code development (to see where the guest code is currently executing),
but it is certainly not the desired behavior that we want to present to
normal users, and it can also cause trouble when e.g. fuzzing devices.
Thus let's replace these hw_error()s by qemu_log_mask()s instead.

Message-Id: <20200611055807.15921-1-huth@tuxfamily.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Thomas Huth <thuth@tuxfamily.org>
---
 hw/m68k/mcf5206.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index a2fef04f8e..94a37a1a46 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -10,7 +10,6 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/m68k/mcf.h"
 #include "qemu/timer.h"
@@ -69,10 +68,16 @@ static void m5206_timer_recalibrate(m5206_timer_state *s)
     if (mode == 2)
         prescale *= 16;
 
-    if (mode == 3 || mode == 0)
-        hw_error("m5206_timer: mode %d not implemented\n", mode);
-    if ((s->tmr & TMR_FRR) == 0)
-        hw_error("m5206_timer: free running mode not implemented\n");
+    if (mode == 3 || mode == 0) {
+        qemu_log_mask(LOG_UNIMP, "m5206_timer: mode %d not implemented\n",
+                      mode);
+        goto exit;
+    }
+    if ((s->tmr & TMR_FRR) == 0) {
+        qemu_log_mask(LOG_UNIMP,
+                      "m5206_timer: free running mode not implemented\n");
+        goto exit;
+    }
 
     /* Assume 66MHz system clock.  */
     ptimer_set_freq(s->timer, 66000000 / prescale);
@@ -391,7 +396,9 @@ static uint32_t m5206_mbar_readb(void *opaque, hwaddr offset)
     m5206_mbar_state *s = (m5206_mbar_state *)opaque;
     offset &= 0x3ff;
     if (offset >= 0x200) {
-        hw_error("Bad MBAR read offset 0x%x", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad MBAR read offset 0x%" HWADDR_PRIX,
+                      offset);
+        return 0;
     }
     if (m5206_mbar_width[offset >> 2] > 1) {
         uint16_t val;
@@ -410,7 +417,9 @@ static uint32_t m5206_mbar_readw(void *opaque, hwaddr offset)
     int width;
     offset &= 0x3ff;
     if (offset >= 0x200) {
-        hw_error("Bad MBAR read offset 0x%x", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad MBAR read offset 0x%" HWADDR_PRIX,
+                      offset);
+        return 0;
     }
     width = m5206_mbar_width[offset >> 2];
     if (width > 2) {
@@ -434,7 +443,9 @@ static uint32_t m5206_mbar_readl(void *opaque, hwaddr offset)
     int width;
     offset &= 0x3ff;
     if (offset >= 0x200) {
-        hw_error("Bad MBAR read offset 0x%x", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad MBAR read offset 0x%" HWADDR_PRIX,
+                      offset);
+        return 0;
     }
     width = m5206_mbar_width[offset >> 2];
     if (width < 4) {
@@ -458,7 +469,9 @@ static void m5206_mbar_writeb(void *opaque, hwaddr offset,
     int width;
     offset &= 0x3ff;
     if (offset >= 0x200) {
-        hw_error("Bad MBAR write offset 0x%x", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad MBAR write offset 0x%" HWADDR_PRIX,
+                      offset);
+        return;
     }
     width = m5206_mbar_width[offset >> 2];
     if (width > 1) {
@@ -482,7 +495,9 @@ static void m5206_mbar_writew(void *opaque, hwaddr offset,
     int width;
     offset &= 0x3ff;
     if (offset >= 0x200) {
-        hw_error("Bad MBAR write offset 0x%x", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad MBAR write offset 0x%" HWADDR_PRIX,
+                      offset);
+        return;
     }
     width = m5206_mbar_width[offset >> 2];
     if (width > 2) {
@@ -510,7 +525,9 @@ static void m5206_mbar_writel(void *opaque, hwaddr offset,
     int width;
     offset &= 0x3ff;
     if (offset >= 0x200) {
-        hw_error("Bad MBAR write offset 0x%x", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad MBAR write offset 0x%" HWADDR_PRIX,
+                      offset);
+        return;
     }
     width = m5206_mbar_width[offset >> 2];
     if (width < 4) {
-- 
2.18.1


