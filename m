Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8386FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5AC2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IzHaPyZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5AC2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltlS-0006Of-HN
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltkI-0004dH-UW
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38347
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltkH-0004n2-6r
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592483656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Xv7dqcOt/a007Bmcgr2XEyjme3j+U6w+N/ObKr33dg=;
 b=IzHaPyZeM1C4K45Vrd0BQ2wK4Pi3Alk3UlNOESsMsS6TAgBIaxQksR35NmZ4sFAHgsawvF
 /jXemQYTOsI0DVnAAX9D6+Y2fZvu6ozvI0an+w3r5661BPWDeAnglDYNvbI38klrt8prfj
 0lTKSdn4XvBOEqRxfyMCDLD9h4zInGE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-WTMQJe9yM9-biQdF3Fyzgg-1; Thu, 18 Jun 2020 08:34:14 -0400
X-MC-Unique: WTMQJe9yM9-biQdF3Fyzgg-1
Received: by mail-wr1-f69.google.com with SMTP id f5so2719686wrv.22
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Xv7dqcOt/a007Bmcgr2XEyjme3j+U6w+N/ObKr33dg=;
 b=lVOoJS89DlSBgkqU5CXAUEKtVfrmEmCCqLBxqD0xGPzZCnoVx3dX9QYP9stAq4da+z
 ivVXTt095MUw8eoVBANLAj3/z/dwAkSu5wNWM/lrVjpdNFMJbhM8bwxIqcNv+KMeCMTU
 c+mHTN8hm5CBAJb4lKf3DqHzfMOOoyfJh115UNGM8TvZddY9yT/WPCZ/Ol8f11zOEuqX
 gY0gDDVNe7Q4Pv/bq3zzL/Kx5kEOTQiOfKbpo/G08P1r+dwBzHvuDHkKKXNcHSIutUR6
 7s5uSbQBMov7k1tGqHxT31yAIMhyJnDf8V2M/CWhKY/tjm4Iq3dXl/7c47NpjpPjC8Di
 ODGw==
X-Gm-Message-State: AOAM530B1MGLwVreUNdFDBX9vJM32m24aOOJLYNCjFShASA/eyN5wJgD
 ekxajL9e+3qI4l9dC0zQO+AvEia78EikqnvD90ZMhlSQz0SpJqdd5N316fQ/l/TFXz1EinIU67Q
 yyQnKWWXauMoR/mw=
X-Received: by 2002:a1c:3b43:: with SMTP id i64mr4005774wma.112.1592483653444; 
 Thu, 18 Jun 2020 05:34:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVEIJl8ICf3cNbzu7iG//m28+h9oiB+qxzS9awHZvqlOIljtMAXL1Jl43rr0i5ImXrfKQuEg==
X-Received: by 2002:a1c:3b43:: with SMTP id i64mr4005754wma.112.1592483653286; 
 Thu, 18 Jun 2020 05:34:13 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id y17sm3509461wrd.58.2020.06.18.05.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 05:34:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 06/10] Makefile: Write MINIKCONF variables as one entry per
 line
Date: Thu, 18 Jun 2020 14:33:38 +0200
Message-Id: <20200618123342.10693-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200618123342.10693-1-philmd@redhat.com>
References: <20200618123342.10693-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Having one entry per line helps reviews/refactors. As we are
going to modify the MINIKCONF variables, split them now to
ease further review.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 0d9ef87e6d..b7f41a2ef2 100644
--- a/Makefile
+++ b/Makefile
@@ -418,12 +418,15 @@ MINIKCONF_ARGS = \
     CONFIG_LINUX=$(CONFIG_LINUX) \
     CONFIG_PVRDMA=$(CONFIG_PVRDMA)
 
-MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
-MINIKCONF_DEPS = $(MINIKCONF_INPUTS) $(wildcard $(SRC_PATH)/hw/*/Kconfig)
+MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host \
+                   $(SRC_PATH)/hw/Kconfig
+MINIKCONF_DEPS = $(MINIKCONF_INPUTS) \
+                 $(wildcard $(SRC_PATH)/hw/*/Kconfig)
 MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py
 
 $(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MINIKCONF_DEPS) $(BUILD_DIR)/config-host.mak
-	$(call quiet-command, $(MINIKCONF) $(MINIKCONF_ARGS) > $@.tmp, "GEN", "$@.tmp")
+	$(call quiet-command, $(MINIKCONF) $(MINIKCONF_ARGS) \
+		> $@.tmp, "GEN", "$@.tmp")
 	$(call quiet-command, if test -f $@; then \
 	  if cmp -s $@.old $@; then \
 	    mv $@.tmp $@; \
-- 
2.21.3


