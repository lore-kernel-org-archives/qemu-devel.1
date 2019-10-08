Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD7DC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E49D2070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpCIrSAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E49D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtN0-0004SE-Hb
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7e-0006ok-L8
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7d-0002Oy-6n
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:06 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40682)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7c-0002No-RL
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:05 -0400
Received: by mail-wm1-x343.google.com with SMTP id b24so3925226wmj.5
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YG0gX4qWdrO9GT0PeX8Gop+wch2VyWRSSaF9t3LJ9nc=;
 b=TpCIrSAKnC+ubgTuHzcWi7xGznG+/JaMKEd1aE538WLALpO9OSGu+9B7sUshwK4tEU
 kkFLeaKq1pzihfNMPe41qXO/jk1Lq6L0mmna5gO3jGVQGXL2tpb2scJw5Omm7H/kZBpi
 exjT5XV4Qy+HFjV40S+zAhmRzRHJVjtLXezbTMkZ33PHOTtCTOlCkbsgJRwnTQrr+oQc
 uKXFk8NwTc5gnRnjEazCuLBOWQ2+PoEGix6fXuQIsWMfuY2cZ5OAZA3SEDYyFKHnNONt
 yWi8naR3uF90HtASyOVYNauz7uGwF5MY/NyZQi4SFMHLYTCZKcjMHon5/yOjTJa+Qea9
 mUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YG0gX4qWdrO9GT0PeX8Gop+wch2VyWRSSaF9t3LJ9nc=;
 b=ep/EA0JkF+P1TSHXmMtYW4U8tCja4VZxkgJzfl5QkX/VKNVMVBgYQQA2WVJMuN3fu2
 aJKinTMCUWpWVRvrvXfX9YqJKLo2e8wo1rocPeskzLHfP5EC9JpxcMqwe06BafsK2xgH
 Sa1pf1J2zKDzcDadNZKvx329dC5SivGbPfIvtwgWvk9XWJlVNtETxXPWTFsCrqySGoaS
 VpkLkg7uqNQRGic2q/PpiLxiQGwUsuF6mil7WWy/pDffvkCK+TIs0GErp74ZNHdkYnmM
 OuMZzxrmunw0VD+9cDBIfJspsrohyr5J0vfJF1fPEnOyArlrN1xNDOl4aUht/f0+qBQF
 rqSw==
X-Gm-Message-State: APjAAAXFQmCy/SvPdb+AHGKKU8hq2HvH0gs6gtJWZ7vbwDkGC6Iiwopc
 B6KDM1+9vFP/7SkNsOqbOT1kDQ==
X-Google-Smtp-Source: APXvYqz1+amI1wGizxub69MRVAZm6lD05unmpVsu+Y0zqL+2RvdpLU+lKDO26bgTieaF5a0ZFfr7zA==
X-Received: by 2002:a1c:2382:: with SMTP id j124mr5026948wmj.154.1570555083764; 
 Tue, 08 Oct 2019 10:18:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:18:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 16/21] hw/timer/exynos4210_rtc.c: Switch main ptimer to
 transaction-based API
Date: Tue,  8 Oct 2019 18:17:35 +0100
Message-Id: <20191008171740.9679-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008171740.9679-1-peter.maydell@linaro.org>
References: <20191008171740.9679-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the exynos41210_rtc main ptimer over to the transaction-based
API, completing the transition for this device.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/exynos4210_rtc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index b7ae99e9aa7..f85483a07f8 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -28,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
@@ -195,6 +194,7 @@ static void check_alarm_raise(Exynos4210RTCState *s)
  * RTC update frequency
  * Parameters:
  *     reg_value - current RTCCON register or his new value
+ * Must be called within a ptimer_transaction_begin/commit block for s->ptimer.
  */
 static void exynos4210_rtc_update_freq(Exynos4210RTCState *s,
                                        uint32_t reg_value)
@@ -402,6 +402,7 @@ static void exynos4210_rtc_write(void *opaque, hwaddr offset,
         break;
     case RTCCON:
         ptimer_transaction_begin(s->ptimer_1Hz);
+        ptimer_transaction_begin(s->ptimer);
         if (value & RTC_ENABLE) {
             exynos4210_rtc_update_freq(s, value);
         }
@@ -432,6 +433,7 @@ static void exynos4210_rtc_write(void *opaque, hwaddr offset,
             }
         }
         ptimer_transaction_commit(s->ptimer_1Hz);
+        ptimer_transaction_commit(s->ptimer);
         s->reg_rtccon = value;
         break;
     case TICCNT:
@@ -539,8 +541,10 @@ static void exynos4210_rtc_reset(DeviceState *d)
 
     s->reg_curticcnt = 0;
 
+    ptimer_transaction_begin(s->ptimer);
     exynos4210_rtc_update_freq(s, s->reg_rtccon);
     ptimer_stop(s->ptimer);
+    ptimer_transaction_commit(s->ptimer);
     ptimer_transaction_begin(s->ptimer_1Hz);
     ptimer_stop(s->ptimer_1Hz);
     ptimer_transaction_commit(s->ptimer_1Hz);
@@ -559,12 +563,12 @@ static void exynos4210_rtc_init(Object *obj)
 {
     Exynos4210RTCState *s = EXYNOS4210_RTC(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
-    QEMUBH *bh;
 
-    bh = qemu_bh_new(exynos4210_rtc_tick, s);
-    s->ptimer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->ptimer = ptimer_init(exynos4210_rtc_tick, s, PTIMER_POLICY_DEFAULT);
+    ptimer_transaction_begin(s->ptimer);
     ptimer_set_freq(s->ptimer, RTC_BASE_FREQ);
     exynos4210_rtc_update_freq(s, 0);
+    ptimer_transaction_commit(s->ptimer);
 
     s->ptimer_1Hz = ptimer_init(exynos4210_rtc_1Hz_tick,
                                 s, PTIMER_POLICY_DEFAULT);
-- 
2.20.1


