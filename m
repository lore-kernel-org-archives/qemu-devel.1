Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02EFC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100E620756
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dX3/d53c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100E620756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOR5-0002iD-Vl
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMZ-0006NE-K2
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMW-0004cM-Qj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601419484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMKffrN5obKOm6UxS550K4u6DmnYBBMm9AG93ufLP5A=;
 b=dX3/d53cc/OQ5ZJwSNpFB27aNssc/1+w4FzLIglKoNg5uLKzopaFVfgRfLmgNnWHTQvPIl
 hOelDFnCeS+KKdMki3o9wvXyGCK5ZkjJQe1w1aI8AAs1OIW6qoWqOBQBrQAiDTPauaj56P
 iVGeiJsHsJqHstsovuu5CLWi1UZr1Js=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-0BYgPhcCNoSr6K5VgsRObg-1; Tue, 29 Sep 2020 18:44:40 -0400
X-MC-Unique: 0BYgPhcCNoSr6K5VgsRObg-1
Received: by mail-wm1-f72.google.com with SMTP id y6so195719wmi.7
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 15:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VMKffrN5obKOm6UxS550K4u6DmnYBBMm9AG93ufLP5A=;
 b=HPjYYGF6nKCDGbQvqn3EnVzJPi17gY4xtt8lEgTIdGbFFk1/GUrW78QQOG53AWvwM+
 /nW7L8HlMP/h+SramX+bZRBxvNEtHBxAbS8IxYLLbPqgoeBFYmJX9hfj9muPPwBH+aIO
 xAPIcBDt7raG++FiejemIT3tTEdVdIwRJfJMK11dJFQGAuZJi8pRae4xgFD5SkDPXTKh
 7jloHmnciZM1osg3uE3sHCGvHRfqBgvLE5PJCeggD/gTSqddwHTnira2nsFL7xEIAvYR
 DAcVMc0ZdonzfhYiuCfXXnqjNeJ//sQLlA0CBxes9GvPvO/mMyrvJkrdgoOk6qK+Ddp3
 SjsA==
X-Gm-Message-State: AOAM530WpMAiHnC59xoA7cgjB0wRpFd/7ylQLxiotGVfFgCK3KJ2s/OO
 5xn5h4LUxqOGbEitCltByJpuCe7JbjAXzpWwlHwS9BlttL6UFq8KwBR/PFHIdpnHaMsa9YXz8QL
 t3xEzpC/VCLlcBig=
X-Received: by 2002:a7b:c76d:: with SMTP id x13mr6762360wmk.10.1601419478956; 
 Tue, 29 Sep 2020 15:44:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxd5/l6Pz82+iT32jI8EMtGES+WPwtktxL0xH6iDe0EYmyk+iEByXkfuzuL6KdhyW+6NVNK1w==
X-Received: by 2002:a7b:c76d:: with SMTP id x13mr6762351wmk.10.1601419478789; 
 Tue, 29 Sep 2020 15:44:38 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id l17sm6922065wme.11.2020.09.29.15.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 15:44:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/12] target/arm: Restrict ARMv7 M-profile cpus to TCG
 accel
Date: Wed, 30 Sep 2020 00:43:51 +0200
Message-Id: <20200929224355.1224017-9-philmd@redhat.com>
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

A KVM-only build won't be able to run M-profile cpus.

Only enable the following ARMv7 M-Profile CPUs when TCG is available:

  - Cortex-M0
  - Cortex-M3
  - Cortex-M4
  - Cortex-M33

We don't need to enforce CONFIG_ARM_V7M in default-configs because
all machines using a Cortex-M are already explicitly selected.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 default-configs/arm-softmmu.mak | 3 ---
 hw/arm/Kconfig                  | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 08a32123b4..002c97862b 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -1,8 +1,5 @@
 # Default configuration for arm-softmmu
 
-# TODO: ARM_V7M is currently always required - make this more flexible!
-CONFIG_ARM_V7M=y
-
 # CONFIG_PCI_DEVICES=n
 # CONFIG_TEST_DEVICES=n
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7f19872722..15faa2f2d7 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -14,6 +14,10 @@ config ARM_V7R
     bool
     select TCG
 
+config ARM_V7M
+    bool
+    select TCG
+
 config ARM_VIRT
     bool
     imply PCI_DEVICES
-- 
2.26.2


