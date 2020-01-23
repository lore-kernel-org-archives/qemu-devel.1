Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF80C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE89721D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5iWbe2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE89721D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuejS-0006sz-Sf
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrp-0005eB-6w
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucro-0004bP-5F
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:53 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:50346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrn-0004Yl-VA
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:52 -0500
Received: by mail-wm1-x32b.google.com with SMTP id a5so2651069wmb.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X02/VemgHHXV35UWmb1MJdddNEMCdoCFB79eUsdW5b0=;
 b=Y5iWbe2TwPEBlobL71ujWaHx0k2YzTfplSDTG5nExlL//nu+bt7UbwiH9pfujsXyLc
 cPpGYNtD9rHQKsMywgmQVDkQRNWMDBx177BJ9VYau3vwKQJ4/vBkcSMFMSEO95wbphja
 OwaZiSwlXcxpFuopPpPUqxuRd9W3r8ODobdSByg1pyeBXnemP2McPrXnydeHiZP8vIKd
 qhpR4fS/EPkAU/+vJ/wsDrxY+OXEJ8wO+ZEAcWX9xvi3ip2XsPYs0YPWb/0h610gcxaI
 aEJouikCNIdmqhEMTB9qBbj/1/3YeyyT+M9aoympaLMzaA1cQSfWqYlnuBZ5pRo4LqUZ
 lHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=X02/VemgHHXV35UWmb1MJdddNEMCdoCFB79eUsdW5b0=;
 b=GvM1PBZD2hvzIa6acQb2H6FCT+Ccj5Aa3QyNyVn9kR2oN0bcHko1g8jrE/HVvPdB39
 fC2vTuB4/+foL0Cra8uKNFmFzU6GPxhxZYaYYSskZHbmO0XpH52J0y9VmXy9Lp2vbJtQ
 1c/hvvlPqUK6zMlHzmTPS+5jhxQbmPav5jrwcdQjhALrfciIb12gymBM9olei8KkaKcC
 zbi+IebOUf86u379/156IjOEoKeFPWH+mdrVqFm6qgfWYZwFHmnIoB9OrzwE/Qa9G09l
 qTE3ldE2aQhHUuF4bUDSQWcQA6QKiVd74oAcvXOMwnpRBnJTSq/iUUjOJTueDG8ETRY5
 h1Sg==
X-Gm-Message-State: APjAAAVw/j8QvJw3l46aPwQTh5Ksp4jzKdPJjGBP341f219ad5lH6QpI
 Fgab3k7yvNNhRoRThpjdIO96pJlV
X-Google-Smtp-Source: APXvYqzi82jcO2+iP/FF/LMfwpZdZs+UiqkONlTOdXDCtb1x32q/GjSNFwg0Bl3RNF0WyrJWZLC2TA==
X-Received: by 2002:a1c:23cf:: with SMTP id j198mr4368161wmj.188.1579787390856; 
 Thu, 23 Jan 2020 05:49:50 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 50/59] qdev: move instance properties to class properties
Date: Thu, 23 Jan 2020 14:48:53 +0100
Message-Id: <1579787342-27146-51-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-21-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 8047ac9..7abf569 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -944,14 +944,6 @@ static void device_initfn(Object *obj)
     dev->realized = false;
     dev->allow_unplug_during_migration = false;
 
-    object_property_add_bool(obj, "realized",
-                             device_get_realized, device_set_realized, NULL);
-    object_property_add_bool(obj, "hotpluggable",
-                             device_get_hotpluggable, NULL, NULL);
-    object_property_add_bool(obj, "hotplugged",
-                             device_get_hotplugged, NULL,
-                             &error_abort);
-
     class = object_get_class(OBJECT(dev));
     do {
         for (prop = DEVICE_CLASS(class)->props; prop && prop->name; prop++) {
@@ -961,9 +953,6 @@ static void device_initfn(Object *obj)
         class = object_class_get_parent(class);
     } while (class != object_class_by_name(TYPE_DEVICE));
 
-    object_property_add_link(OBJECT(dev), "parent_bus", TYPE_BUS,
-                             (Object **)&dev->parent_bus, NULL, 0,
-                             &error_abort);
     QLIST_INIT(&dev->gpios);
 }
 
@@ -1059,6 +1048,19 @@ static void device_class_init(ObjectClass *class, void *data)
     dc->hotpluggable = true;
     dc->user_creatable = true;
     vc->get_id = device_vmstate_if_get_id;
+
+    object_class_property_add_bool(class, "realized",
+                                   device_get_realized, device_set_realized,
+                                   &error_abort);
+    object_class_property_add_bool(class, "hotpluggable",
+                                   device_get_hotpluggable, NULL,
+                                   &error_abort);
+    object_class_property_add_bool(class, "hotplugged",
+                                   device_get_hotplugged, NULL,
+                                   &error_abort);
+    object_class_property_add_link(class, "parent_bus", TYPE_BUS,
+                                   offsetof(DeviceState, parent_bus), NULL, 0,
+                                   &error_abort);
 }
 
 void device_class_set_props(DeviceClass *dc, Property *props)
-- 
1.8.3.1



