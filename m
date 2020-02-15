Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D585C3F68F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 00:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF103207FF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 00:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcIxJxJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF103207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2l5g-0001Ed-3s
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 19:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j2l4t-0008FP-2D
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j2l4s-0003BT-5G
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:12:59 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j2l4q-00036K-8G; Fri, 14 Feb 2020 19:12:56 -0500
Received: by mail-pg1-x543.google.com with SMTP id j4so5746063pgi.1;
 Fri, 14 Feb 2020 16:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hbeVP/BW+IaFARdpXG4HDpnB43Wxr9sq7+fPSUPZvsM=;
 b=FcIxJxJbxQ80ZNP3JZjFhtw0vGua8ZGcSIWcBBllDo2ahg2vwRfrxqE6CU6jlo5ISR
 naPkleDMMnZ2agi8xrwGx8k8InWJQi2DOnX+fsFiZxIx/jbhqZJz6UAML7IXOykyh/ni
 5B2UPozbvWZNH1YZYEBi3SiziMCGbW+nl9n2uRWtCKYtWQ/Ws76YSP4WU5i/fzpt+1pU
 D7CHlPOFM97yd07sZaSYc4vW7xbFiCOwdxWKf7+e3FxruQHzWFUWfVUZ5GYn7bvhYgbf
 2AnxsbNGhm9ojPNIsOvJF/dm7XUGIYcSX0HdVjjWg/3SnGBbwuZi6sqeFipjmoYJaojf
 xeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=hbeVP/BW+IaFARdpXG4HDpnB43Wxr9sq7+fPSUPZvsM=;
 b=I8zb/5UvLMR4O+nRgZyYHSkp0ahL1zrDM9TqeyM9vmrCeQfSY0NItzuV16Wp1zykY3
 atbBL+GgaMjNdzCYiHtwzzy9ESQ/SF81FGIEQcBkjb71Wio/CNqVmjovC/pPoZi60Nff
 vcJbeU0VIyh7AgtxUf4Und+uZNB0bSD0PdsZ/yJQ0dcjp2uoA3VeYhMtr9kjuldUtylJ
 gMJ4Pm6OSDzVFWGAb91hU5ceIO/zgzkfrfWHrLi7peW+CNjqpGy+mc1KoaWsYjXKpJLl
 L4jCV/YNf3JuPpZKxM0r+ZUxqDqfMgz+mqudg+eUGJ+BjeT6RnZd5XmYs5+93UhmhboB
 RgkQ==
X-Gm-Message-State: APjAAAUNHA95buxKkt7uS4/jfwviyploUNWAws874Z5cQ4pdmeCL7zlF
 bpkzpmKtI7JhmMLmA2y9O3k=
X-Google-Smtp-Source: APXvYqyBldKLT1Pm6J6WzLd5PAbioQ0hGgJHYVWZ/kXoX0PMAv2KwB6r5eOx2oGy2LKKXApz4P7/5Q==
X-Received: by 2002:aa7:8809:: with SMTP id c9mr5802564pfo.238.1581725575362; 
 Fri, 14 Feb 2020 16:12:55 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id c184sm8431141pfa.39.2020.02.14.16.12.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Feb 2020 16:12:54 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/3] hcd-ehci: Introduce "companion-enable" sysbus property
Date: Fri, 14 Feb 2020 16:12:47 -0800
Message-Id: <20200215001248.2642-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200215001248.2642-1-linux@roeck-us.net>
References: <20200215001248.2642-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We'll use this property in a follow-up patch to insantiate an EHCI
bus with companion support.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch

 hw/usb/hcd-ehci-sysbus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index b5a014f968..014ad3d552 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -33,6 +33,8 @@ static const VMStateDescription vmstate_ehci_sysbus = {
 
 static Property ehci_sysbus_properties[] = {
     DEFINE_PROP_UINT32("maxframes", EHCISysBusState, ehci.maxframes, 128),
+    DEFINE_PROP_BOOL("companion-enable", EHCISysBusState, ehci.companion_enable,
+                     false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.17.1


