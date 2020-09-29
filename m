Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CE7C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028ED20756
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABzl7VNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028ED20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOSy-0005S5-UV
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMC-0005RQ-1F
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMA-0004aZ-As
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:23 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601419461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9dR9Nk0eM9jSf6djV760qyeufq0GIQie0fmgNB3aO7w=;
 b=ABzl7VNu1PaIwvHqYBjXD9sL92SzShanvI7/wPHo5VkZ/djlfFseeq/RaRxhCGK9k45Fpo
 Qfdj6qsoHQnDoMYZD2S6+G38u8rIzApA/r7q8/O6F2MBrdjUebf3HXzIgWbHjqR3+p7O2v
 s+8IWxyVrC/kJxl5I5wAcrwgBcf5PkQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-1PgIH-n4PGeCWxR7FD0nCA-1; Tue, 29 Sep 2020 18:44:20 -0400
X-MC-Unique: 1PgIH-n4PGeCWxR7FD0nCA-1
Received: by mail-wr1-f71.google.com with SMTP id g6so2366503wrv.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 15:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9dR9Nk0eM9jSf6djV760qyeufq0GIQie0fmgNB3aO7w=;
 b=eDarASBoID+NUK4+Nx2lCytO6fF8bHqeVIwam3mGZwdgxGM++QxvF/u0x9KP4NnJAY
 b7Q32+X7XFxW+HKYiBLzHwb8LEMxNv8FrpfSYuVWy9mlagyyJJheaP3iht+m2uziA1Ia
 xkEKNdp7DV8K/cHTW8cuOJPGrOSlg9zM+gyerkPG9boy8Et4tRiVtTTUAE4rmQF+rJ5V
 rhD8jlJ+/X9jnzB20sxv3aQe4j9LpjC2178DB4QpViAX6b7jb9ZygYCFO2qCIhmAAUtz
 HbSrIz+8nmzyXe3F8TCnl0n3HBQtJOXddLhmeUVC+X3VEjCuQrj2zxtSNWfGIbalJtiJ
 eOVw==
X-Gm-Message-State: AOAM530WWS5WOdAh634DDM/CjkqvvYth78mjIrT2KBPPAdSkp02vb4WZ
 +j5jLntHKg4w4tvoijG8uVIymHU6TNeLWpogRVN6onSPwODMs1GOiHcZwMglE8HQRvdespxBJtg
 a8oHs/pwxvfTEZxg=
X-Received: by 2002:adf:fd01:: with SMTP id e1mr6312408wrr.44.1601419458525;
 Tue, 29 Sep 2020 15:44:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwh51NEq7twr61W/5e9Rg5U9losDLPsHpgTL0nTFBNwMoNiIws2/CzkKqcV0aZDFoO9xffGw==
X-Received: by 2002:adf:fd01:: with SMTP id e1mr6312389wrr.44.1601419458354;
 Tue, 29 Sep 2020 15:44:18 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id y1sm7440740wmi.36.2020.09.29.15.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 15:44:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/12] target/arm: Restrict ARMv4 cpus to TCG accel
Date: Wed, 30 Sep 2020 00:43:47 +0200
Message-Id: <20200929224355.1224017-5-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

Only enable the following ARMv4 CPUs when TCG is available:

  - StrongARM (SA1100/1110)
  - OMAP1510 (TI925T)

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7d040827af..b546b20654 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -1,3 +1,7 @@
+config ARM_V4
+    bool
+    select TCG
+
 config ARM_VIRT
     bool
     imply PCI_DEVICES
@@ -30,6 +34,7 @@ config ARM_VIRT
 
 config CHEETAH
     bool
+    select ARM_V4
     select OMAP
     select TSC210X
 
@@ -244,6 +249,7 @@ config COLLIE
 
 config SX1
     bool
+    select ARM_V4
     select OMAP
 
 config VERSATILE
-- 
2.26.2


