Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB9CCA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AADFA2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAuE0g5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADFA2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfF9-0002jg-QT
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjD-0008Ii-Or
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj7-0007qV-D1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:38 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdj7-0007pT-6h
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:33 -0400
Received: by mail-wr1-x42e.google.com with SMTP id p4so26247263wrm.8
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bW6P2NgO+nuwZAStwk4n4lKvUPFNwzLT5MNnpnO4GMQ=;
 b=ZAuE0g5h1/sf6lx7tbMjIzenhYtXPfDQUHtzmTcXzEGe+2hb+KOFhz8ZNJqwmEawz/
 qpTlBNbQSmc1ycUav4M/hoQH/H9RNCcHGsaUM7l66rscTL59Ri0zb6D4dNxNHWtQORBw
 6qwKOfOupZy0GS9vk0UvQnCvq/5zi/2Geh30isPTJQoYl8WyXiPWst30MnxHjfJJTDan
 GUJfGAiRpbXdTNrsJFY7sTgkHCG0AoSl2VSvouRQheQjTdCeYP7h0HxhqzNAOxxMtT8V
 yCyeuRQUzRjsvC9cdIMqlXwK34cvFdP/2sUHihcWFrxRw2Ao3xY0mQintm9L0vvSu0O4
 65fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bW6P2NgO+nuwZAStwk4n4lKvUPFNwzLT5MNnpnO4GMQ=;
 b=FZVy+IrDcOo+wTUWQpjNVDkQEQLXWuKH+8MGMC2eyv3SYEqR9l3usg4uNKGYqFW4/D
 Cchp6VLIL+dY3T4b0MlFx/vHAfiOMe6badcKOBR2bQZKJpa1tcOEP9SijcxoZ8RqkHV9
 pKrr4XbFTRCebhPNSa+6Sdiu49BjaPcZt2lH/xPYUtOTxoo9VflG6YT1icIOXGfxMbKc
 Gw1+h+KEYfq7/6PbBrHKLc1P77fVGqcWP/X5MVY83RTcsZKfEldl3KL3WXxBFTdtLfjO
 qoHrqD8pUy54fDPUdWwjHtGYolwkChMsqqCHIT+g5SnfchnwViZZI+JoCe9bXoCf/IYX
 nRmg==
X-Gm-Message-State: APjAAAW6hlMw2AywFGKhemlvog9GURBf9DMYtNk/aXgdZTQ0pXSc/ESj
 uwDkJcZB1I7v4vtuiCCWf5thmeE1
X-Google-Smtp-Source: APXvYqztTibCuTQvi2u9iQrk872E+KxXKE3LNyVz1ZyQjNfGgxXOEZeqA1kFRahlXLVYkAXo0lXAuA==
X-Received: by 2002:adf:9185:: with SMTP id 5mr4254381wri.389.1571925871860;
 Thu, 24 Oct 2019 07:04:31 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/39] mc146818rtc: move structure to header file
Date: Thu, 24 Oct 2019 16:03:47 +0200
Message-Id: <1571925835-31930-32-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hervé Poussineau <hpoussin@reactos.org>

We are now able to embed a timer in another object.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
Message-Id: <20171216090228.28505-4-hpoussin@reactos.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191018133547.10936-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c         | 30 ------------------------------
 include/hw/timer/mc146818rtc.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index c979db0..09edb93 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -71,36 +71,6 @@
 #define RTC_CLOCK_RATE            32768
 #define UIP_HOLD_LENGTH           (8 * NANOSECONDS_PER_SECOND / 32768)
 
-#define MC146818_RTC(obj) OBJECT_CHECK(RTCState, (obj), TYPE_MC146818_RTC)
-
-typedef struct RTCState {
-    ISADevice parent_obj;
-
-    MemoryRegion io;
-    MemoryRegion coalesced_io;
-    uint8_t cmos_data[128];
-    uint8_t cmos_index;
-    int32_t base_year;
-    uint64_t base_rtc;
-    uint64_t last_update;
-    int64_t offset;
-    qemu_irq irq;
-    int it_shift;
-    /* periodic timer */
-    QEMUTimer *periodic_timer;
-    int64_t next_periodic_time;
-    /* update-ended timer */
-    QEMUTimer *update_timer;
-    uint64_t next_alarm_time;
-    uint16_t irq_reinject_on_ack_count;
-    uint32_t irq_coalesced;
-    uint32_t period;
-    QEMUTimer *coalesced_timer;
-    LostTickPolicy lost_tick_policy;
-    Notifier suspend_notifier;
-    QLIST_ENTRY(RTCState) link;
-} RTCState;
-
 static void rtc_set_time(RTCState *s);
 static void rtc_update_time(RTCState *s);
 static void rtc_set_cmos(RTCState *s, const struct tm *tm);
diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/timer/mc146818rtc.h
index fe6ed63..0f1c886 100644
--- a/include/hw/timer/mc146818rtc.h
+++ b/include/hw/timer/mc146818rtc.h
@@ -1,10 +1,43 @@
 #ifndef MC146818RTC_H
 #define MC146818RTC_H
 
+#include "qapi/qapi-types-misc.h"
+#include "qemu/queue.h"
+#include "qemu/timer.h"
 #include "hw/isa/isa.h"
 #include "hw/timer/mc146818rtc_regs.h"
 
 #define TYPE_MC146818_RTC "mc146818rtc"
+#define MC146818_RTC(obj) OBJECT_CHECK(RTCState, (obj), TYPE_MC146818_RTC)
+
+typedef struct RTCState {
+    ISADevice parent_obj;
+
+    MemoryRegion io;
+    MemoryRegion coalesced_io;
+    uint8_t cmos_data[128];
+    uint8_t cmos_index;
+    int32_t base_year;
+    uint64_t base_rtc;
+    uint64_t last_update;
+    int64_t offset;
+    qemu_irq irq;
+    int it_shift;
+    /* periodic timer */
+    QEMUTimer *periodic_timer;
+    int64_t next_periodic_time;
+    /* update-ended timer */
+    QEMUTimer *update_timer;
+    uint64_t next_alarm_time;
+    uint16_t irq_reinject_on_ack_count;
+    uint32_t irq_coalesced;
+    uint32_t period;
+    QEMUTimer *coalesced_timer;
+    Notifier clock_reset_notifier;
+    LostTickPolicy lost_tick_policy;
+    Notifier suspend_notifier;
+    QLIST_ENTRY(RTCState) link;
+} RTCState;
 
 ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,
                              qemu_irq intercept_irq);
-- 
1.8.3.1



