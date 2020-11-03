Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15863C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0CE223AC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4MvPffN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0CE223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxXl-0007wD-PL
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOO-0004DB-Tw
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxON-0006Oc-1z
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kxx7KBtrm7vYLNNi8ILRStjcIKIqdM/KqZjCc2FDurE=;
 b=J4MvPffNBLz/4rgzk61x0Yb/YmZe7Hhg5RZei5S/yiLNH14JkfUsy1h3M03EYECVJBvgXe
 9h05OL93jOthUV87kCdlLHnfL4VyD5YG6JxXtw9GZT7/a4wYwfLCVH/Tj0DgLjFX8sT1RZ
 //5EV84IrzL3zDOfbb+Ab2onQGF64JE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-HR66kw6DOxGNHnWlmCdMLA-1; Tue, 03 Nov 2020 09:34:31 -0500
X-MC-Unique: HR66kw6DOxGNHnWlmCdMLA-1
Received: by mail-wm1-f70.google.com with SMTP id l16so2703610wmh.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kxx7KBtrm7vYLNNi8ILRStjcIKIqdM/KqZjCc2FDurE=;
 b=DWBro23smbQnvjG98pEAiN1Es9gVNeR0jfBU6FGE32EuhCC8p2b7zY4UlvW0KVxLjn
 hNMCQBxt4xDJFv4gXSOmVRjsYf8OSoY9dL3SwYF54w/upX6DICAnAUXUJ+BYZFsUGZ5S
 k7cjZwJZ7sI01QbxWudjx+zgFW57p2z4/u0pcApUUz+HoNWXEe1r6Q+d//E7FEUuj9tx
 lS+WTftknubQDPgp78LYPkkUrSbbVYuQyxx0mcRJsU0Ppxxn8BM4TQoUuSwvrsHoLiMa
 A0guPsHfv6eGWBK6c1m5neBLCgg3aoWGsP91OrmmH94+Pgm/U6nMYWMoWE61KO9Ai+d6
 z7lg==
X-Gm-Message-State: AOAM532C+sBxTVxetUBpAvl/JD7zlA41JiOhfvutmDHDA8yru5F/k1vS
 5ZnAiuyC4RGcD5N6R/cMS6p3l3w81I6yxrWHzyiEGtw/7eKJmpK6A6T0g4tD9Oh+G4lrFnEKiD8
 F4sQt7eTCmL652Jk=
X-Received: by 2002:a1c:98ce:: with SMTP id a197mr61569wme.116.1604414070366; 
 Tue, 03 Nov 2020 06:34:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKVunZqn0Mb1UMJ7Mlm5F/4ar5hjxQx1IXTL681GXBN2N0ONneg14ArRXb85LDPM4U6gNF2g==
X-Received: by 2002:a1c:98ce:: with SMTP id a197mr61550wme.116.1604414070226; 
 Tue, 03 Nov 2020 06:34:30 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id j127sm3336605wma.31.2020.11.03.06.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:34:28 -0800 (PST)
Date: Tue, 3 Nov 2020 09:34:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/38] hw/acpi : add spaces around operator
Message-ID: <20201103142306.71782-11-mst@redhat.com>
References: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103142306.71782-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Kai Deng <dengkai1@huawei.com>,
 Xinhao Zhang <zhangxinhao1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xinhao Zhang <zhangxinhao1@huawei.com>

Fix code style. Operator needs spaces both sides.

Signed-off-by: Xinhao Zhang <zhangxinhao1@huawei.com>
Signed-off-by: Kai Deng <dengkai1@huawei.com>
Message-Id: <20201103102634.273021-3-zhangxinhao1@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/pcihp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 32ae8b2c0a..17c32e0ffd 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -400,7 +400,7 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
     s->io_len = ACPI_PCIHP_SIZE;
     s->io_base = ACPI_PCIHP_ADDR;
 
-    s->root= root_bus;
+    s->root = root_bus;
     s->legacy_piix = !bridges_enabled;
 
     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
-- 
MST


