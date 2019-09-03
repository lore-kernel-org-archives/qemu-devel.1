Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C163C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377A023431
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAuRoDL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377A023431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5B3b-00058D-Tp
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArY-00031y-Im
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArW-00061W-El
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:53094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArW-000610-8C
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id t17so18753733wmi.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8/T9mmX0W7AG1ACKL4IcYUCZwX8sRH9ZWIp1nKl2B4A=;
 b=AAuRoDL5j9IeKmGoUhmWSkrEBwvKGYGZmNtP9QXU8QRBQUgG6gJbMWvUNyTs2H7k2w
 xEV3vizI4J5IvwXnHZ2sStnmedl1bfca6A+bRqefbt3hG1BLw/S5nWyZ7wO0RGJno5d7
 5ZiKFECXa3cBp+reT0uNLDDdKAFhCAVbznL/jWhaXQBuz+gRnpP3APpQ2fZIhycx5CIS
 bH8hgXx/vJJi49f1ShLcE5FBxdvKvDQsHOL0W7Hlbs1ofU6hMJnrlUxAJ2u8jfg0GIp1
 Q3ZDQAEq1/LttU3zXDPNzxqCJwIp63OxUTnEAMeYRwlAPyc1sRQz++YoT1cFs0GmoWM0
 gPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8/T9mmX0W7AG1ACKL4IcYUCZwX8sRH9ZWIp1nKl2B4A=;
 b=ixboqM44FQsMjTIhrhpHOnSfL/cAXmbbePiPRFcUNNaA2c0O2EJHbQufEkLL9PQdBA
 L+jYcWheA9KLBlnDDgBudR8SVTOGWzrdWN9xC9aDPpNyBfyeu8cbx5fEIOBZUydILBrv
 u43+hpRcSQO8S4t3CKjyiuaIh5/aBssht/Go70DPCtChIwe0TDmL3ghOv2Nrnm1L+el0
 fiKI6PILCCXAKCp4P0al/ZY/7iUy16eTnioEi6vCHmC9KAgUWIgc9BCmARYKcS1HSE/A
 TZE9viSNd0K1WsCtYoTfdscoCR5XB5mkWFR99e6Sg8453NHf3BrNhhD0XQSKuSeKwOrP
 +MQg==
X-Gm-Message-State: APjAAAUprlKRcfcEf4VYAPrFGqtAieJ8NrWtEhy2litQza35X1JlDrIz
 g07WM89/a+XxG8WZqM43a8dH4QOX3zP7TA==
X-Google-Smtp-Source: APXvYqzudDbzpjH8QAPCM+sKkDIKxsvcQU5S602XH/po1ze53H7lxE2O0jukDpSEqU4iS0YIvXrB9A==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr760170wmb.151.1567525012984;
 Tue, 03 Sep 2019 08:36:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:27 +0100
Message-Id: <20190903153633.6651-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PULL 15/21] hw/net/xilinx_axi: Use
 object_initialize_child for correct ref. counting
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

As explained in commit aff39be0ed97:

  Both functions, object_initialize() and object_property_add_child()
  increase the reference counter of the new object, so one of the
  references has to be dropped afterwards to get the reference
  counting right. Otherwise the child object will not be properly
  cleaned up when the parent gets destroyed.
  Thus let's use now object_initialize_child() instead to get the
  reference counting here right.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190823143249.8096-7-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/xilinx_axienet.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index d8716a1f737..2c8c065401a 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -994,15 +994,14 @@ static void xilinx_enet_init(Object *obj)
     XilinxAXIEnet *s = XILINX_AXI_ENET(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    object_initialize(&s->rx_data_dev, sizeof(s->rx_data_dev),
-                      TYPE_XILINX_AXI_ENET_DATA_STREAM);
-    object_initialize(&s->rx_control_dev, sizeof(s->rx_control_dev),
-                      TYPE_XILINX_AXI_ENET_CONTROL_STREAM);
-    object_property_add_child(OBJECT(s), "axistream-connected-target",
-                              (Object *)&s->rx_data_dev, &error_abort);
-    object_property_add_child(OBJECT(s), "axistream-control-connected-target",
-                              (Object *)&s->rx_control_dev, &error_abort);
-
+    object_initialize_child(OBJECT(s), "axistream-connected-target",
+                            &s->rx_data_dev, sizeof(s->rx_data_dev),
+                            TYPE_XILINX_AXI_ENET_DATA_STREAM, &error_abort,
+                            NULL);
+    object_initialize_child(OBJECT(s), "axistream-control-connected-target",
+                            &s->rx_control_dev, sizeof(s->rx_control_dev),
+                            TYPE_XILINX_AXI_ENET_CONTROL_STREAM, &error_abort,
+                            NULL);
     sysbus_init_irq(sbd, &s->irq);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &enet_ops, s, "enet", 0x40000);
-- 
2.20.1


