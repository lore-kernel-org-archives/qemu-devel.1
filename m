Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BEAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C935A20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1Obcw32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C935A20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrNy-0000bH-V5
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrMT-0006Ou-8L
 for qemu-devel@nongnu.org; Thu, 21 May 2020 16:00:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56951
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrMR-0008RJ-Qt
 for qemu-devel@nongnu.org; Thu, 21 May 2020 16:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590091211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KqNAKdeyZY4N/WN8/VheKglAqudMynHtJmA2N/wtx2U=;
 b=S1Obcw32/03+rU+2owm3Gdo0cWs5afHvEHwE+TK/lsCFvu4ingKl1uYhfoGzeeI5HOAlSu
 O6G+7tfSKyVtHG/ple3sYyfNweWmpCTIhSr6sRtomPrmvD59zXpGMAt0unlPal2pZirltp
 ZZJRPRCEQyp+aT+nYVCL+pjOhx+PvPk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-RGSS0_ILPP60lnD7rkMGAg-1; Thu, 21 May 2020 16:00:09 -0400
X-MC-Unique: RGSS0_ILPP60lnD7rkMGAg-1
Received: by mail-wr1-f71.google.com with SMTP id x8so3356726wrl.16
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 13:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KqNAKdeyZY4N/WN8/VheKglAqudMynHtJmA2N/wtx2U=;
 b=o+Fy4G1LZzWry/jn1Aj48BeQnnykCiPSmAt92m3dbwHX7Zttr90mNx6k0J4alhcqHS
 C7emuI7eAtRTIIKh0r0fP9BgE64ehyALdsa5Nuwcex1DE8cyaeM14NXKt60FToWm0fuK
 FMJyHNdau02Drc0k0mK4LkMd+wvt8BTUhDzVMdX6nPx+iT7zlt47U9VGaS0l0cmRQygh
 AUG4p+GY9LwKedzmwce2Qs6MV2F3egkqaApBYxiTdNrEbDOvF+NYGi8N83QPQYbht04Z
 o4NyEcN8N9RKJi5FeoMg8Z5jFR0kHliAh04CvBo3r7exiDbP6twWZsmNVPeD1Hj2cOQL
 qwag==
X-Gm-Message-State: AOAM530EN9tX6wCLn8E2RIAFU5oXpOwS001fjeWDhK3ovdntLK7WQGpJ
 b8+pllwnCqB5KT12jlpk8DLhatYouPcxfYUsUmLrm0uV2u+IAuvApiTYS1+v4kGmqiV+NpY+ExN
 07PWBXDeSOCMfS6M=
X-Received: by 2002:a05:6000:8:: with SMTP id h8mr235570wrx.372.1590091208451; 
 Thu, 21 May 2020 13:00:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFiASs60kuKf7BHaBAyYehIKPHjS2uDg/uQRBajStXclZHOmXYaH79bLCSVBU3344As7Vczg==
X-Received: by 2002:a05:6000:8:: with SMTP id h8mr235543wrx.372.1590091208262; 
 Thu, 21 May 2020 13:00:08 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id j4sm5672973wrx.24.2020.05.21.13.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 13:00:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/11] Makefile: Allow target-specific optional Kconfig
Date: Thu, 21 May 2020 21:59:10 +0200
Message-Id: <20200521195911.19685-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200521195911.19685-1-philmd@redhat.com>
References: <20200521195911.19685-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow use of target-specific Kconfig file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v3: Use base-arch() to include TARGET_BASE_ARCH/Kconfig
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f8a45e1379..d5009cd304 100644
--- a/Makefile
+++ b/Makefile
@@ -423,11 +423,13 @@ MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host \
                    $(SRC_PATH)/accel/Kconfig \
                    $(SRC_PATH)/hw/Kconfig
 MINIKCONF_DEPS = $(MINIKCONF_INPUTS) \
-                 $(wildcard $(SRC_PATH)/hw/*/Kconfig)
+                 $(wildcard $(SRC_PATH)/hw/*/Kconfig) \
+                 $(wildcard $(SRC_PATH)/target/*/Kconfig)
 MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py
 
 $(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MINIKCONF_DEPS) $(BUILD_DIR)/config-host.mak
 	$(call quiet-command, $(MINIKCONF) $(MINIKCONF_ARGS) \
+		$(wildcard $(SRC_PATH)/target/$(call base-arch, $(firstword $(subst -, ,$@)))/Kconfig) \
 		> $@.tmp, "GEN", "$@.tmp")
 	$(call quiet-command, if test -f $@; then \
 	  if cmp -s $@.old $@; then \
-- 
2.21.3


