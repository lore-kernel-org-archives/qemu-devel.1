Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D25C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE39720756
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2P8CiVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE39720756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNONt-0007ha-Mz
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMR-00062y-1X
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMP-0004bi-EH
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601419476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2ptRm8f/lOeml0jS1cRqmJHNlSkXaKtAQigKfi/TLU=;
 b=h2P8CiVAm7wyUrLUqboHeVVgybVe3tNogJsmTeQy10jxr0bdyQdFz0NXv6cZgJIb637cFx
 28XSlyuCXfyKBfonbSvQhSpusbiMqJWf+wA4Wb27X+DiJcIWvIlNanhI7LO9sRilkxdd37
 lmCKBWMlo+LGSAJ3YlVq5N1Y8XDn5Og=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-n0M6fAjLNUioBqZoSh382Q-1; Tue, 29 Sep 2020 18:44:35 -0400
X-MC-Unique: n0M6fAjLNUioBqZoSh382Q-1
Received: by mail-wr1-f70.google.com with SMTP id a10so2314318wrw.22
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 15:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O2ptRm8f/lOeml0jS1cRqmJHNlSkXaKtAQigKfi/TLU=;
 b=iazuqX2BgmkYMoCKF4gGCu0c9G7vrVByXhZZ4h3BU5wcqvLXnPMhXN7gHMre8fy5RL
 /sS5lBjbxoD+utxwBGsLJfi0m6A5k+5iw4zgEmDS9QK9ewBBjvh8Kgceel6MHbNWSIAR
 6ZP2ueeM6n7kbvLjSKmGSQtgZKl8FpAnpvSF10WQav6TzkSWFBmVwpEAuS8l96NfLfoE
 VeeCFg3TcvPmCyynKhqoOw6XTjCcZHCFxz4IBfB225f8CmXv36S5ffjYxpe0teh5z0i7
 pcy+E8wzhciab4qJBEQdhZ8wtyQxv5ZgKUvTmFoPL9SdcKFMYCRM0SUZudcDSwucM+m1
 26nw==
X-Gm-Message-State: AOAM533HKdFT0Z9ZOt4RuWd4Q5sARtLMrX8KcfSpEnWV2jZ9HtLQ5y5+
 c6dZsG9c3tta/uFVPi09CaNi8hbHoMmxZAaoOuvJ/kJVkwQv1kkSNMsNOA/jygazn59BSq82tOH
 hFIXuCVvXwrf5ao4=
X-Received: by 2002:a5d:444b:: with SMTP id x11mr6634818wrr.402.1601419473912; 
 Tue, 29 Sep 2020 15:44:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4aaS54Wk933OJIRQKbP4cZ/YFPBu2pchNU62vp4qGrFYgoGCxMVfKfqvmCyuVMDLcMh8vXQ==
X-Received: by 2002:a5d:444b:: with SMTP id x11mr6634802wrr.402.1601419473707; 
 Tue, 29 Sep 2020 15:44:33 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id m10sm7056524wmi.9.2020.09.29.15.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 15:44:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/12] target/arm: Restrict ARMv7 R-profile cpus to TCG
 accel
Date: Wed, 30 Sep 2020 00:43:50 +0200
Message-Id: <20200929224355.1224017-8-philmd@redhat.com>
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

A KVM-only build won't be able to run R-profile cpus.

Only enable the following ARMv7 R-Profile CPUs when TCG is available:

  - Cortex-R5
  - Cortex-R5F

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e01eb55bc0..7f19872722 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -10,6 +10,10 @@ config ARM_V6
     bool
     select TCG
 
+config ARM_V7R
+    bool
+    select TCG
+
 config ARM_VIRT
     bool
     imply PCI_DEVICES
@@ -358,6 +362,7 @@ config XLNX_ZYNQMP_ARM
     bool
     select AHCI
     select ARM_GIC
+    select ARM_V7R
     select CADENCE
     select DDC
     select DPCD
-- 
2.26.2


