Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663CFCA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BE921A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsLWphyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BE921A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNe3I-0005Vq-Sq
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjB-0008Gj-VN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjA-0007sf-Ko
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:37 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:41163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdjA-0007sE-EQ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:36 -0400
Received: by mail-wr1-x42b.google.com with SMTP id p4so26247502wrm.8
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TFNvMP30xKoxAS2yg65BboQPupWQoCvJdN+IX9nNhRA=;
 b=KsLWphywSX1L6cyres/TN1Q3j2zhRs9rTPQFaJ9cslNvZXkpCodV3tIf82ap9gMO5F
 NCFU1LDCVJs2qOu8cwK9rW2xO+XMbBzBwvFTKSZuu2pPLGKv13xHCW1IuKrnD8XOru0E
 SkwGn2gUOs3auQ1sZSYkcLKcmmDgmBTjPqdgaN5A87+EFEJu/fAVJdgyRgip0CxW42n1
 WPKDfI/b0ivFs2v2RFP66gRv8habcPbo4hnnqaaxBUUKqLlRpBm1yZyzk9GwRI1EqhE+
 u595Qj7mDITmDU6qbq7YbgeePRQ1thscXEHaN4jXM/Q8Vzf6O0ZpuP8DeSJhMzh+SNGO
 ejBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TFNvMP30xKoxAS2yg65BboQPupWQoCvJdN+IX9nNhRA=;
 b=oRDH4/7GZrkduTIRlaTWEsdKA+QbO1cYPQI1Z0s+NlQjK+RdaYli/rDzSy8ZXkfvaq
 RlDvK5FQhw0LC2QeW/eIt5JQaQ8eMkiDkZhXIFHIDaecIjDfVujLAoDsR0kDC0TM4FTS
 DLBF3E195sRszkuR7odKwtJk0O1f3FPvm/9ypgI5wfhNa/l3WEJKyKunZoHtTYGvt9Lw
 Vo4CstAHFZQZCPT+QThrAIjZCd4Rx+99yiSmUXm69zq+Ur92h3WffYfiif/Qh2MhVp1X
 X6QIdiPAs0To7wrMKtR1pzcPLC3IRiHgx8KmnbzBFcbHNJvc850tfDHS7EGPCD9cYbNf
 GZqA==
X-Gm-Message-State: APjAAAUd6gqN9reSQW4hioCsR2GnRUQYknMXSTTz6tCAJFQTTJ9StBpl
 6z/4bAt5SevaSf0JoK/orV7fYn0O
X-Google-Smtp-Source: APXvYqztFrsNnrrGr7QkdaPYQE2E5Kh+CcCetQXHY3GRZK5e6nhQ8e+ex9lHLiqv2tv0enQtsV2oeQ==
X-Received: by 2002:a5d:674f:: with SMTP id l15mr4391648wrw.80.1571925875139; 
 Thu, 24 Oct 2019 07:04:35 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/39] mc146818rtc: always register rtc to rtc list
Date: Thu, 24 Oct 2019 16:03:50 +0200
Message-Id: <1571925835-31930-35-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

We are not required anymore to use rtc_init() function.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
Message-Id: <20171216090228.28505-5-hpoussin@reactos.org>
[PMD: rebased, fix OBJECT() value]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191018133547.10936-5-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index dce4dae..0d7784b 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -964,17 +964,16 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     object_property_add_tm(OBJECT(s), "date", rtc_get_date, NULL);
 
     qdev_init_gpio_out(dev, &s->irq, 1);
+    QLIST_INSERT_HEAD(&rtc_devices, s, link);
 }
 
 ISADevice *mc146818_rtc_init(ISABus *bus, int base_year, qemu_irq intercept_irq)
 {
     DeviceState *dev;
     ISADevice *isadev;
-    RTCState *s;
 
     isadev = isa_create(bus, TYPE_MC146818_RTC);
     dev = DEVICE(isadev);
-    s = MC146818_RTC(isadev);
     qdev_prop_set_int32(dev, "base_year", base_year);
     qdev_init_nofail(dev);
     if (intercept_irq) {
@@ -982,9 +981,8 @@ ISADevice *mc146818_rtc_init(ISABus *bus, int base_year, qemu_irq intercept_irq)
     } else {
         isa_connect_gpio_out(isadev, 0, RTC_ISA_IRQ);
     }
-    QLIST_INSERT_HEAD(&rtc_devices, s, link);
 
-    object_property_add_alias(qdev_get_machine(), "rtc-time", OBJECT(s),
+    object_property_add_alias(qdev_get_machine(), "rtc-time", OBJECT(isadev),
                               "date", NULL);
 
     return isadev;
@@ -1016,8 +1014,6 @@ static void rtc_class_initfn(ObjectClass *klass, void *data)
     dc->reset = rtc_resetdev;
     dc->vmsd = &vmstate_rtc;
     dc->props = mc146818rtc_properties;
-    /* Reason: needs to be wired up by rtc_init() */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo mc146818rtc_info = {
-- 
1.8.3.1



