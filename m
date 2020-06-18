Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A35C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA9A2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hS+wkltg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA9A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltoe-0004nG-Ai
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltkG-0004Xn-Ah
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39004
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltkE-0004mm-Mz
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592483653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEMJhILyxek/z4RDZ2pbESBFvDfPdQGCY1WFh6w88b0=;
 b=hS+wkltgxQYzDXD1BO35Tmi7fZumBZHhUspf86Ej1ARs+6Bckdgeih0xsSUJybWFpscE+X
 FkcysBeB2c0M119aDe490CrLRAarrQnqR0oRCM2pWbrwTi6CuNoWrhEF9v7WSl6rJbgRGw
 OgQP1gpVMe5Fa1/L5Dis9+NcNaryHJM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-zugF_S90NpaxafxtEOLLWw-1; Thu, 18 Jun 2020 08:34:10 -0400
X-MC-Unique: zugF_S90NpaxafxtEOLLWw-1
Received: by mail-wm1-f72.google.com with SMTP id v24so2534279wmh.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uEMJhILyxek/z4RDZ2pbESBFvDfPdQGCY1WFh6w88b0=;
 b=CyrGtOgKBYA54sJoMcc4/46YHbFhzFWXPQPa2bJdPtigQPUg9ruxXFjJRiAXNtfsOA
 kJbZ1/HyXDdp8rk5WEozQsR8Wa+buCyQduzw3D8318Bl4BgAuzXYdXdz6mSkFFNitKCj
 Op23w8bhr5ZSGUj0WLgvaikAiFbA/vYbT/LOtS2OHradZGpbhGxQRCdanzDso8ZE0k1E
 AkTRMqcf0a3zRt5Y8qlt8sIXDnnrJJgysOAdIyQZ7QZFuYG/ZQB5focGRT/t/FxtLnqe
 tTO68jEiUp/WZ1I2n5OonyMNwHM/XhrrV0hn2fG3+xd/7qCsExxitwZXViNSuAtXUeeP
 yxtQ==
X-Gm-Message-State: AOAM532P/OqbKmXX7f/b1mps/U2ldvhrN2zzkZ/jZ04LfO01PYJsx4D5
 ORcNq/+uN8QS+OgOq5uhO0RSypr6vR5Gxe2x0AQvppl+uyYTABvIi8UPjHia0gn/4dCjRzlebzs
 RCYj3vMDGU7qUscE=
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr4065021wmh.78.1592483648764; 
 Thu, 18 Jun 2020 05:34:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVHhI6KmPhhKtEQk3TjEf5dIJg92iCm+tfHTZGrEHTkqhgppJ9ON9PDmigjKJLysG3GqdSUQ==
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr4065003wmh.78.1592483648544; 
 Thu, 18 Jun 2020 05:34:08 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id u12sm3494529wrq.90.2020.06.18.05.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 05:34:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 05/10] Makefile: Remove dangerous EOL trailing backslash
Date: Thu, 18 Jun 2020 14:33:37 +0200
Message-Id: <20200618123342.10693-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200618123342.10693-1-philmd@redhat.com>
References: <20200618123342.10693-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One might get caught trying to understand unexpected Makefile
behavior. Trailing backslash can help to split very long lines,
but are rather dangerous when nothing follow. Preserve other
developers debugging time by removing this one.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 48f23aa978..0d9ef87e6d 100644
--- a/Makefile
+++ b/Makefile
@@ -420,7 +420,7 @@ MINIKCONF_ARGS = \
 
 MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
 MINIKCONF_DEPS = $(MINIKCONF_INPUTS) $(wildcard $(SRC_PATH)/hw/*/Kconfig)
-MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \
+MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py
 
 $(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MINIKCONF_DEPS) $(BUILD_DIR)/config-host.mak
 	$(call quiet-command, $(MINIKCONF) $(MINIKCONF_ARGS) > $@.tmp, "GEN", "$@.tmp")
-- 
2.21.3


