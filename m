Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B937AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83AE220637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVmGKZWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83AE220637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tgn-0007vL-Lo
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP5-0003RA-Hu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP4-0002G6-C4
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:19 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36171)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tP3-0002Du-Dq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:17 -0500
Received: by mail-wm1-x32b.google.com with SMTP id g83so6437339wme.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WO6MlmMNplhxoUnWkFVSAFSYs5grFV+Q/M4i3h2rCwI=;
 b=NVmGKZWSoiLVIP8O3WoaGkAUz+Cwo9gHnE4fr602Lc/OPm1pksvXMY/AmTmPX5ZvY1
 kGUntyocYKQJmSPgwceDbWAc2A2oxUSvp2EWDW/xPqtc5KJDkzmx3luWbEh9j+P+AVVT
 CvmAIm5J50OcqxVuLdywePGr4YURErBGZ6TWIlwUkKRRPusg6gKgWqjIxWSK1iIDo+5W
 OycPUMwGehkXZUy6RVYs2mqN9//NZAHolvOdV+gm8wJgyFgSmYBi1dAsdSdicGnB/cqy
 74xDOTMVtjq/4bVIaD32P+oJYTXA2GC6JEyUVsn3FYKqpl1kRGgUqnx+pQJt4sOaTNa5
 S6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WO6MlmMNplhxoUnWkFVSAFSYs5grFV+Q/M4i3h2rCwI=;
 b=Si9NUW3CHwZRfKiS/ssb6JO1v+AEFI+qt2YDbqmFPTaK4QkaGZuosw6hR/oYkytk/g
 uX2U1m91cfA+K430/LaFMkRMHBTj6YB0c3zhbMjK3wJ1VbFW0dZrPw3myrhWCvroweCR
 2GKfe3ZbW9dTyspIfBk7zm02dQgW6jsr6ZpzJTeZEuCJ3wT9XDOWwDTOYKWWGo9ppPec
 eDXEgixtm75PTmOKR9GoloMXe/TIYBDWCMUCCe4SGnsY2p1zPdURWLZbXw54s0PsLOu1
 k6DPKhH4eo6uy5hzWcrIBYtPJgYhUnP2Ks1GpJVMtEF3RUwE3/21cS9cy80yclSBXzjB
 NPPg==
X-Gm-Message-State: ANhLgQ3meMMBqWbalm/x5F6XmeYIL0cT+bmNJmp+3B24pFj0elfgUlIL
 f9gh2X+b9xBF0mbLws0YHvSjSPjvzE88RQ==
X-Google-Smtp-Source: ADFU+vu04e27+PF5VuIm571xYGq16mhP3QUoIWGP8gj7MiYzTCrSndGbPW3PL3pvfs1e5HUcC1L2ow==
X-Received: by 2002:a05:600c:4108:: with SMTP id
 j8mr10357134wmi.188.1583425875784; 
 Thu, 05 Mar 2020 08:31:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/37] hw/arm/spitz: move timer_new from init() into realize()
 to avoid memleaks
Date: Thu,  5 Mar 2020 16:30:35 +0000
Message-Id: <20200305163100.22912-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Message-id: 20200227025055.14341-4-pannengyuan@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/spitz.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index e0010881038..cbfa6934cfd 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -524,11 +524,16 @@ static void spitz_keyboard_init(Object *obj)
 
     spitz_keyboard_pre_map(s);
 
-    s->kbdtimer = timer_new_ns(QEMU_CLOCK_VIRTUAL, spitz_keyboard_tick, s);
     qdev_init_gpio_in(dev, spitz_keyboard_strobe, SPITZ_KEY_STROBE_NUM);
     qdev_init_gpio_out(dev, s->sense, SPITZ_KEY_SENSE_NUM);
 }
 
+static void spitz_keyboard_realize(DeviceState *dev, Error **errp)
+{
+    SpitzKeyboardState *s = SPITZ_KEYBOARD(dev);
+    s->kbdtimer = timer_new_ns(QEMU_CLOCK_VIRTUAL, spitz_keyboard_tick, s);
+}
+
 /* LCD backlight controller */
 
 #define LCDTG_RESCTL	0x00
@@ -1115,6 +1120,7 @@ static void spitz_keyboard_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_spitz_kbd;
+    dc->realize = spitz_keyboard_realize;
 }
 
 static const TypeInfo spitz_keyboard_info = {
-- 
2.20.1


