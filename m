Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD35C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1E420792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JO8Lq9Us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1E420792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjp8e-00045A-BZ
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 15:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjp2P-000206-R7
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:08:25 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43566)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjp2O-0007b5-0S
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:08:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id l10so10819609wrr.10
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 12:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wXhgANSUKYnCKXs8uV1uCQPeeFPmHlGq9ilbgO5w6iI=;
 b=JO8Lq9UsZykrE9C0WuOwWC7dTAuP6f71RCn6aB0JBn5ZM0zkG5R76Umi5/NK6RN98t
 yEgqFveLHYJDzTIHiMp6NpuiGObJQr8ZjfCy5tmUwjR7Cx7UubM1EWjhirPv2s9Gh01P
 FO5j8akPAT2aSu2inJBdc7gOLQdqeyZRSSpaC1zzlr3DEHTJzRphtoAmnYqx9dyCcc+r
 gX7Fa8mctv2bJuZujX2aJdfDDiB7zeDmv/rGpiEWoptyuBhbnqNCVTslLr7GVDkCOwoT
 a5Ee4LLozPKMElnRNEEsi029cGN3eoLQMJvMe7TbDK/5tWHWGcdVktSEQzG4BO7Sk8uz
 fo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wXhgANSUKYnCKXs8uV1uCQPeeFPmHlGq9ilbgO5w6iI=;
 b=bca1aEgQ/G8HvIDaO3NmnoEyNromEonQ2W8VplYZNiGJyG3og+01l3i5qJPI68cmyc
 6uwpHtKkkshLcYL0LzLWZDBiwJrczI5A6GyALygLMTtkeYtSOjL14B5OX8jZB5EMA+IN
 ZYWUancc3hpnaiRXn9/WanXreLIBUZ4Bb85X6D8JPpDuuTEm+jv7aRIfZomJxyWHRTCQ
 17Xguf8SrifdyGWFS3D8DcMq6IuIPeJfAiX4TWAz30V9DTdKthF3bIQOn+5QNj22LFZV
 VV/MbPGLT0Zk8nr/jbEHclp4MZWApLxhEY/cin4n4jv6+Ycy1UZO5xImVOeogAXbyccS
 +VKQ==
X-Gm-Message-State: AOAM531tP3Soa4vAw0hb8snDrPs1c6hX++PS18wOhq/I1txFSXgDn0yl
 43HSxTwzOEa/qVrcMxpMPyUwfg==
X-Google-Smtp-Source: ABdhPJybUlFo7xQDhVy73X0+AJpszwm4nXLyGjmqxvjoVQvDAU51wAhC6jc4FKGbOX7/LRzIPs4gvw==
X-Received: by 2002:a1c:bd86:: with SMTP id n128mr390249wmf.5.1591988894976;
 Fri, 12 Jun 2020 12:08:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y66sm10497582wmy.24.2020.06.12.12.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 12:08:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AB00D1FF9E;
 Fri, 12 Jun 2020 20:02:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 16/18] tests: Disable select tests under TSan,
 which hit TSan issue.
Date: Fri, 12 Jun 2020 20:02:35 +0100
Message-Id: <20200612190237.30436-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612190237.30436-1-alex.bennee@linaro.org>
References: <20200612190237.30436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Disable a few tests under CONFIG_TSAN, which
run into a known TSan issue that results in a hang.
https://github.com/google/sanitizers/issues/1116

The disabled tests under TSan include all the qtests as well as
the test-char, test-qga, and test-qdev-global-props.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200609200738.445-14-robert.foley@linaro.org>
---
 tests/Makefile.include       | 9 +++++++--
 tests/qtest/Makefile.include | 7 +++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c2397de8ed6..8d82c24d835 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -55,7 +55,6 @@ SYSEMU_TARGET_LIST := $(subst -softmmu.mak,,$(notdir \
 
 check-unit-y += tests/check-qdict$(EXESUF)
 check-unit-y += tests/check-block-qdict$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) += tests/test-char$(EXESUF)
 check-unit-y += tests/check-qnum$(EXESUF)
 check-unit-y += tests/check-qstring$(EXESUF)
 check-unit-y += tests/check-qlist$(EXESUF)
@@ -108,7 +107,6 @@ check-unit-y += tests/test-qht$(EXESUF)
 check-unit-y += tests/test-qht-par$(EXESUF)
 check-unit-y += tests/test-bitops$(EXESUF)
 check-unit-y += tests/test-bitcnt$(EXESUF)
-check-unit-$(CONFIG_SOFTMMU) += tests/test-qdev-global-props$(EXESUF)
 check-unit-y += tests/check-qom-interface$(EXESUF)
 check-unit-y += tests/check-qom-proplist$(EXESUF)
 check-unit-y += tests/test-qemu-opts$(EXESUF)
@@ -123,9 +121,16 @@ check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-cipher$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-crypto-secret$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlscredsx509$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlssession$(EXESUF)
+ifndef CONFIG_TSAN
+# Some tests: test-char, test-qdev-global-props, and test-qga,
+# are not runnable under TSan due to a known issue.
+# https://github.com/google/sanitizers/issues/1116
+check-unit-$(CONFIG_SOFTMMU) += tests/test-char$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-qdev-global-props$(EXESUF)
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)
 endif
+endif
 check-unit-$(CONFIG_SOFTMMU) += tests/test-timed-average$(EXESUF)
 check-unit-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_INOTIFY1)) += tests/test-util-filemonitor$(EXESUF)
 check-unit-$(CONFIG_SOFTMMU) += tests/test-util-sockets$(EXESUF)
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 9e5a51d033a..71fd714a2a9 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -313,12 +313,15 @@ tests/qtest/tpm-tis-device-test$(EXESUF): tests/qtest/tpm-tis-device-test.o test
 # QTest rules
 
 TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
+QTEST_TARGETS =
+# The qtests are not runnable (yet) under TSan due to a known issue.
+# https://github.com/google/sanitizers/issues/1116
+ifndef CONFIG_TSAN
 ifeq ($(CONFIG_POSIX),y)
 QTEST_TARGETS = $(TARGETS)
 check-qtest-y=$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y:%=tests/qtest/%$(EXESUF)))
 check-qtest-y += $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF))
-else
-QTEST_TARGETS =
+endif
 endif
 
 qtest-obj-y = tests/qtest/libqtest.o $(test-util-obj-y)
-- 
2.20.1


