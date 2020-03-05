Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C6DC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC19207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c16OyJIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC19207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tTm-0002zx-Kb
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP6-0003S3-HH
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP5-0002HS-B9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:20 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:38951)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tP5-0002GO-52
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:19 -0500
Received: by mail-wm1-x329.google.com with SMTP id j1so6421149wmi.4
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=3GK41nG/OoUPXZ9s0SYYzwW0XMBSCvTJmH8pW+e8Jw8=;
 b=c16OyJIc/hZ0Zou0sp0AnJXZWpb2lpshAHN5j0ff/dGNAh7x9PJC6vvpszBC4Q/9d2
 hFC4FP1zlEEN/Q3mkoipJwxFB/WeR+9Vkzu75STlsZse4FiDy2K1bfBScE19o4pptpjC
 0/YxYrSjAEPMXxTfZbpVoj6vjedrV01soOaFw5FZ5FoBLolvKDooFt5Xm07RmZiXpMPd
 eEIZIggUum6U7xpuXX4AvkltfThWp3sLVRjG/ModDI7XYXX3j3yTyYLRAIyp5k1KewkQ
 u/iylW8ADsRsGam5sy0CwsBoh5x2em47vApEA1OYHcl8v5BqOR2MxKZhOBHpfk3Cmvtv
 HieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3GK41nG/OoUPXZ9s0SYYzwW0XMBSCvTJmH8pW+e8Jw8=;
 b=khwg7fefMJUj4GDqBDHKTeYnkspjWKqQn7bre+jdzgn+N8pERTuKp1EtJ7nQ55HPi4
 8OQANdaumJ8Ig4PVRzrtGAHwMTGzD9Vf50xdtQPzKOUpvfjKFDpFCbdi+rsGSdqQNWEp
 aaO3IaMPLkYDax6WownWBW7MWEZ3kYeA+tUPpqP+xMl1jj1n6KBykm3wEdErQn7yZLuV
 VnH3BgSJgXg5848Al0DhZV7A606Wi9sqAwa32u1wWLPwEXNA0WrmXfv9dqvmYu3ETUCr
 3kGBfHUqHsaS1PwY4zP/qFzfdrjNBhhNCSJ/NUBTzM5p/cBOATK5t68ZuFLDWv5O0O3G
 lwRA==
X-Gm-Message-State: ANhLgQ15wNunNj0CnjGKCvlyDuVwkyCm+b3mOHN8Nb6uaWQQj0TiGHdJ
 TyYdIVqMl9GOOnHdACHyDFqRHaxmlQmRVg==
X-Google-Smtp-Source: ADFU+vu1xYX3jmOugfIzZdbMNUJW/m3L0ZEpHE3+CnwLVnGTEcPsEpJaEVbPe1t5UC34S6Spte1apg==
X-Received: by 2002:a1c:9a45:: with SMTP id c66mr6239189wme.115.1583425877865; 
 Thu, 05 Mar 2020 08:31:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/37] hw/timer/cadence_ttc: move timer_new from init() into
 realize() to avoid memleaks
Date: Thu,  5 Mar 2020 16:30:37 +0000
Message-Id: <20200305163100.22912-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

There are some memleaks when we call 'device_list_properties'. This patch move timer_new from init into realize to fix it.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200227025055.14341-7-pannengyuan@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/cadence_ttc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index 5e3128c1e37..b0ba6b2bbae 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -412,18 +412,23 @@ static void cadence_timer_init(uint32_t freq, CadenceTimerState *s)
 static void cadence_ttc_init(Object *obj)
 {
     CadenceTTCState *s = CADENCE_TTC(obj);
-    int i;
-
-    for (i = 0; i < 3; ++i) {
-        cadence_timer_init(133000000, &s->timer[i]);
-        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->timer[i].irq);
-    }
 
     memory_region_init_io(&s->iomem, obj, &cadence_ttc_ops, s,
                           "timer", 0x1000);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
 }
 
+static void cadence_ttc_realize(DeviceState *dev, Error **errp)
+{
+    CadenceTTCState *s = CADENCE_TTC(dev);
+    int i;
+
+    for (i = 0; i < 3; ++i) {
+        cadence_timer_init(133000000, &s->timer[i]);
+        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->timer[i].irq);
+    }
+}
+
 static int cadence_timer_pre_save(void *opaque)
 {
     cadence_timer_sync((CadenceTimerState *)opaque);
@@ -479,6 +484,7 @@ static void cadence_ttc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_cadence_ttc;
+    dc->realize = cadence_ttc_realize;
 }
 
 static const TypeInfo cadence_ttc_info = {
-- 
2.20.1


