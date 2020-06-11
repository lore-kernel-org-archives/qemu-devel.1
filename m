Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8195C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 05:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC60320812
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 05:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC60320812
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjGFU-00046p-0o
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 01:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1jjGEJ-0002oN-NE
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 01:58:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38536)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1jjGEH-0002YB-6b
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 01:58:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id f185so3806478wmf.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 22:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hi7asyT08MJpRVZtlrtD3h0DgWR9WoNxciZGNbdqAo0=;
 b=FH+CRdFzW7WyOjGvzhMR7zeMnzfSjGJFAlr4NxOB8sUu2G83fRZxBXe/lIm47g8JSs
 afrqyPZk4ZltH139KeCLTxOSvovUkhkGE+hMk4LA6j5HQFK2Qd/cOoupBtNcJ49FDdOG
 mylJsJU/WlmFXUs3zugdoekfKBRE7i96FaQ8/x5pPYQOzobe5/Fkbyt1Rfqs9iyDVKAz
 q55IIsQ0+j9UpvzPpMPpAAWYu4YD3SfMETczqz0y/cWdCWjgHMjOiwEXo/v8V5NgTiU5
 MF3T+eCaVgmFu1ywQtCHQ/nKWVS+FJqA2apOrNsLMiktbmytOSxFhLxfuPjseIgX+TBt
 kKqw==
X-Gm-Message-State: AOAM532a7rU205RTJUYjBd81xBqlk07h2DMgHSKgneazQkwxgsK4nqUl
 r0xVgFxN9HySVMPM/BMkT9qL9zK2
X-Google-Smtp-Source: ABdhPJxMSJgCgXVzhx/mz8OcGxNaQwCT85U7DOK7EcmKuQXnH6nbtUjpxi8d19JqPHkFjMI1eaR4zw==
X-Received: by 2002:a1c:de82:: with SMTP id v124mr6496058wmg.89.1591855092887; 
 Wed, 10 Jun 2020 22:58:12 -0700 (PDT)
Received: from thl530.multi.box (pd9e83fc6.dip0.t-ipconnect.de.
 [217.232.63.198])
 by smtp.gmail.com with ESMTPSA id 88sm3363831wre.45.2020.06.10.22.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 22:58:12 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/m68k/mcf5206: Replace remaining hw_error()s by
 qemu_log_mask()
Date: Thu, 11 Jun 2020 07:58:07 +0200
Message-Id: <20200611055807.15921-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.65; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 01:58:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw_error() dumps the CPU state and exits QEMU. This is ok during initial
code development (to see where the guest code is currently executing),
but it is certainly not the desired behavior that we want to present to
normal users, and it can also cause trouble when e.g. fuzzing devices.
Thus let's replace these hw_error()s by qemu_log_mask()s instead.

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
2.26.2


