Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D68BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0D921741
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fr82j0dD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0D921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLq11-000587-Mt
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLppz-0002rK-KB
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:42145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLppt-0007cv-Ia
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:43 -0400
Received: by mail-wr1-x433.google.com with SMTP id c18so4061177wrm.9
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P/lRZdjmbM+i2Bneg/hO0ZOlO6BgKhfMQmpeyPmCGjo=;
 b=Fr82j0dDOxTQuZBkiobLKYO95T6lkzphWgY6qcWsQmXXUqbi9ZEjnxmyLFUnGX0BwC
 Ux8y3YNFdD2+vVyKgkVO7Qh8wV+lJAWygs+ykRF54WzbaGlBn5VHZ1DN7sd0U2Yac1v7
 j36+KcN2rflxTUVhNnYctheFRUN5cjzun9iYr9IUn5IWHfBlD6cs/TKRETxo4AMBBx7p
 jZwsuNZBSPhKPPP0bymefXYGwEW4PIbJzcnPaDWV8dLZ+OjvsiM5n0bfR2zmfa3NvelU
 Y63MCEItTImLTc4ha3TGx+mIQCCC/1k5v0//BPxntiHEl76SdXVoQFwW8yEAWDz6vCf6
 47pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P/lRZdjmbM+i2Bneg/hO0ZOlO6BgKhfMQmpeyPmCGjo=;
 b=gCbiVddlweM6Sgk02xJ7CirPMNq6MHBRUAJ7nxeE7/3P4oLfpqp2kZLQCgzOhTT49y
 6zV2LIw2WQRxvII2/j9jLcHeIv8CLn4OjDzqA0KVTMENoafFm1KvDbf/m8ARIS8WsJU6
 Byr9MVv+bD41bxB1RYYDTsAw4dK+z7Q3gqISNZvWzLuO8OiOCO5hTA2hhDzrgvDzFXp0
 WVmUvohmy9KbTaFgmfDtWEnEO3wdXP0hqxEssM0fNVplrWExjn+mssFhcabnxE/1v+hL
 a37jvEsfcIf0P21rzMqwRvAICeV6rjlpAwGZ55E6tBv/bXWyipFVmEZsd51lx0MFiwWh
 u2Ug==
X-Gm-Message-State: AOAM530pACGAzu1aW8cccWYUGJilUX7fAOXUjPVEQrUbvn6H+LLCpp8C
 nwr7aNGTexlzZat2GzJje8pEjg==
X-Google-Smtp-Source: ABdhPJy4qcv7Yn8VOCy+QmK2D6gvszP+60K/lcrvtMYpW5JxoGHI9NkOMg94Vt3Bt2Nic8ejLN6Rmw==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr4916953wrq.381.1601048436176; 
 Fri, 25 Sep 2020 08:40:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y1sm3203232wma.36.2020.09.25.08.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:40:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4815E1FF87;
 Fri, 25 Sep 2020 16:40:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 01/15] tests/tcg: reinstate or replace desired parts of
 rules.mak
Date: Fri, 25 Sep 2020 16:40:13 +0100
Message-Id: <20200925154027.12672-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925154027.12672-1-alex.bennee@linaro.org>
References: <20200925154027.12672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Commit 660f79309303d696531ffb394719dfab3e0c42c0 was a bit overzealous
with respect to tests/tcg, which needed quiet-command and $(BUILD_DIR).
Reinstate quiet-command, and replace $(BUILD_DIR) with just the
current directory.

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200921163425.1410280-1-pbonzini@redhat.com>
---
 tests/tcg/Makefile.qemu | 13 ++++++++++++-
 tests/tcg/configure.sh  |  4 ++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/Makefile.qemu b/tests/tcg/Makefile.qemu
index 0332bad10fd4..c096c611a2b4 100644
--- a/tests/tcg/Makefile.qemu
+++ b/tests/tcg/Makefile.qemu
@@ -11,9 +11,20 @@
 # The configure script fills in extra information about
 # useful docker images or alternative compiler flags.
 
+# Usage: $(call quiet-command,command and args,"NAME","args to print")
+# This will run "command and args", and either:
+#  if V=1 just print the whole command and args
+#  otherwise print the 'quiet' output in the format "  NAME     args to print"
+# NAME should be a short name of the command, 7 letters or fewer.
+# If called with only a single argument, will print nothing in quiet mode.
+quiet-command-run = $(if $(V),,$(if $2,printf "  %-7s %s\n" $2 $3 && ))$1
+quiet-@ = $(if $(V),,@)
+quiet-command = $(quiet-@)$(call quiet-command-run,$1,$2,$3)
+
 CROSS_CC_GUEST:=
 DOCKER_IMAGE:=
--include $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak
+
+-include tests/tcg/config-$(TARGET).mak
 
 GUEST_BUILD=
 TCG_MAKE=../Makefile.target
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 598a50cd4f31..be51bdb5a4a7 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -193,11 +193,11 @@ for target in $target_list; do
   case $target in
     *-linux-user | *-bsd-user)
       echo "CONFIG_USER_ONLY=y" >> $config_target_mak
-      echo "QEMU=\$(BUILD_DIR)/qemu-$arch" >> $config_target_mak
+      echo "QEMU=$PWD/qemu-$arch" >> $config_target_mak
       ;;
     *-softmmu)
       echo "CONFIG_SOFTMMU=y" >> $config_target_mak
-      echo "QEMU=\$(BUILD_DIR)/qemu-system-$arch" >> $config_target_mak
+      echo "QEMU=$PWD/qemu-system-$arch" >> $config_target_mak
       ;;
   esac
 
-- 
2.20.1


