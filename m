Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D83FC4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0724620756
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkFf5Ij4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0724620756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOSd-0004xK-UH
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMJ-0005ic-2d
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMH-0004b0-Dg
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601419468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o4HjcXP3qwr6X7IJP4D/f1xvLwTdd8bPvM5GyTvUpNE=;
 b=FkFf5Ij41zCOn7dYNCLzUE2DTM4mv3RpTx0tyOdWu9jOYAQlorbAMTCbK41VhXF1yFntJz
 ztV8xfQV2PqN+nt6Fs01xCgh4uNa7uF7ZDyXnyiJF5YAyWfwdWXEzpShQD5/Wgu0lbXpmJ
 wUS59jgNCFiDYnRuSoWH9SHD3xBREww=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-3dNZJy3gM9W8NzT5YdoyVg-1; Tue, 29 Sep 2020 18:44:25 -0400
X-MC-Unique: 3dNZJy3gM9W8NzT5YdoyVg-1
Received: by mail-wr1-f70.google.com with SMTP id i10so2346927wrq.5
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 15:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o4HjcXP3qwr6X7IJP4D/f1xvLwTdd8bPvM5GyTvUpNE=;
 b=dRXQHLmYUC8frp6y2HyPLY2Db5t5bmjoCKQSHi1HWtREMgS18GX7s5dVkB6D4wyya5
 VgrdfijWn/2+c0lRaZ3WkYbqmS0SzgpkhI/PTJtgOZP0tmPfwaXzSi0wiHQuT/dordqJ
 spVF/mXugfBUydduhoUcfVb89rLvVWaSx2yBLrCwqdCvKfYkAcFvv2zm8TgEONShwlKQ
 jb7K2KMCa5Lx7AZokp0U3IsymVMdwgjPfbeXltpo4h6Qy2nMdzcZ6AdBmLCiHs0vsZ5n
 al6Aeo+UvPQ/fT/kLUUyEyAmozOOC3OWqRRnt+2l3lSDSxsCLqL5S9o0r8lV7n4FBLwR
 rI6w==
X-Gm-Message-State: AOAM531lac6KTB+jixi3DFHWjmYg4PleDBr0zcDmqJ6OOA/h6Fwhjy11
 bRaQYMejm2ndhZKH/Q25mZ9v6Jyyrf0p1W+eR/l+ITc+uefOonp0bqXOTE7OnlAc0KVwwlu7cat
 t+JMxM5+EnQQ0hww=
X-Received: by 2002:adf:83c3:: with SMTP id 61mr6487537wre.287.1601419463554; 
 Tue, 29 Sep 2020 15:44:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiKG03zq+uHxa3VA+7jIh3VXyDityJ8NdNAGTWh+0EeM/7OentrHFt37Qc69GgvEZbvFzI7w==
X-Received: by 2002:adf:83c3:: with SMTP id 61mr6487523wre.287.1601419463375; 
 Tue, 29 Sep 2020 15:44:23 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id l4sm8483138wrc.14.2020.09.29.15.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 15:44:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/12] target/arm: Restrict ARMv5 cpus to TCG accel
Date: Wed, 30 Sep 2020 00:43:48 +0200
Message-Id: <20200929224355.1224017-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929224355.1224017-1-philmd@redhat.com>
References: <20200929224355.1224017-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM requires a cpu based on (at least) the ARMv7 architecture.

Only enable the following ARMv5 CPUs when TCG is available:

  - ARM926
  - ARM946
  - ARM1026
  - XScale (PXA250/255/260/261/262/270)

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b546b20654..d2876b2c8b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -2,6 +2,10 @@ config ARM_V4
     bool
     select TCG
 
+config ARM_V5
+    bool
+    select TCG
+
 config ARM_VIRT
     bool
     imply PCI_DEVICES
@@ -44,6 +48,7 @@ config CUBIEBOARD
 
 config DIGIC
     bool
+    select ARM_V5
     select PTIMER
     select PFLASH_CFI02
 
@@ -73,6 +78,7 @@ config HIGHBANK
 
 config INTEGRATOR
     bool
+    select ARM_V5
     select ARM_TIMER
     select INTEGRATOR_DEBUG
     select PL011 # UART
@@ -99,6 +105,7 @@ config MUSCA
 
 config MUSICPAL
     bool
+    select ARM_V5
     select BITBANG_I2C
     select MARVELL_88W8618
     select PTIMER
@@ -138,6 +145,7 @@ config OMAP
 
 config PXA2XX
     bool
+    select ARM_V5
     select FRAMEBUFFER
     select I2C
     select SERIAL
@@ -254,6 +262,7 @@ config SX1
 
 config VERSATILE
     bool
+    select ARM_V5
     select ARM_TIMER # sp804
     select PFLASH_CFI01
     select LSI_SCSI_PCI
@@ -373,6 +382,7 @@ config NPCM7XX
 
 config FSL_IMX25
     bool
+    select ARM_V5
     select IMX
     select IMX_FEC
     select IMX_I2C
@@ -399,6 +409,7 @@ config FSL_IMX6
 
 config ASPEED_SOC
     bool
+    select ARM_V5
     select DS1338
     select FTGMAC100
     select I2C
-- 
2.26.2


