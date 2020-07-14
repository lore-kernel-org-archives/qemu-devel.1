Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953B9C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AE2217A0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAfT/rP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AE2217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHgR-00033T-La
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvHcT-0003Z8-Np
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:53:01 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:40611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvHcR-0003yD-S9
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:53:01 -0400
Received: by mail-wr1-x42c.google.com with SMTP id f2so20457982wrp.7
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V+m4RDPdg9U+KIn2pEcS3MKP2lWACszi+kXcKRp9FQM=;
 b=HAfT/rP2joqyeWRIqkXnpz45G4d0CgKCxAFmJyYlm6rT4xcD/Ii0N9dVRlG9/YLgkb
 tVhqazQDPWVprmr8QjIP7AA+QlM2vmvhKDDyoxDutxQEdkOtPVEf3h/obHy6OOdHH8c6
 karrwlKfWLdMyyBTabVKQARqiM9vBdHVgZRr/k596rsYIRI+5jMbbDxXt/y9NiPU5Mdk
 JPWRuVdYgOGmyqwo0bDeW82Ie9c5Abs20EVVhrwIs+RsqKOhJodkGhpSeK5mqM3/Wbk4
 JzobYRRNgnhRObU8reI1rQXiQ65oKTvVhts75tBLS8G+DjYOYO07eKpbwKceGWQAUZee
 c4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V+m4RDPdg9U+KIn2pEcS3MKP2lWACszi+kXcKRp9FQM=;
 b=rM16BvTahyZ7VfO25cAJRLkyWf1qURnWon/0amTU0LLaffs9EQ0ra4KqW9elAb/D/j
 GiHrIiawFf620gRR1iRdtlXmgdLeHdYxs/IgqbMDnM7ARINxAJuEemmNvzcPOCEVc4Ah
 xfqsHOrRisSVY3qiqUpdrRbJVMoIUxi21WmmFdU74FTTTckRar9xmVkbhSYnYHuex+Cx
 z5evuTcIwjhjYu7bZ0BV96YmoGUraLGf/l4VCPk6u8QFvHLAISdnuXgWjJJL/mLLAKef
 PBsuyGqLJGfRlL2CuuYS6wjGJHzqMl+nV4MqBPeWAmGHpegIDYQDGgcxjeNm9X7CPTxw
 ypWQ==
X-Gm-Message-State: AOAM531u6YFgYRinJNMq/pZO94cHwfjhfr7hUU6jjHJAx41tzR+pPqTV
 8fXh4PqOrFrr8rh2bCKWAGGn6A==
X-Google-Smtp-Source: ABdhPJxYKvRRDHNT8ywAwrxFwWy2cW9BAytjqX+4jPE+qWR7yp8Stts79J75qmUPPr8E1Pf/z1GGHA==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr3953705wrp.45.1594720378394; 
 Tue, 14 Jul 2020 02:52:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j75sm18206267wrj.22.2020.07.14.02.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 02:52:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E6D991FF93;
 Tue, 14 Jul 2020 10:52:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 7/9] tests/plugins: don't unconditionally add -Wpsabi
Date: Tue, 14 Jul 2020 10:52:45 +0100
Message-Id: <20200714095247.19573-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200714095247.19573-1-alex.bennee@linaro.org>
References: <20200714095247.19573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not all compilers support the -Wpsabi (clang-9 in my case). To handle
this gracefully we pare back the shared build machinery so the
Makefile is relatively "standalone". We still take advantage of
config-host.mak as configure has done a bunch of probing for us but
that is it.

Fixes: bac8d222a
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200713200415.26214-6-alex.bennee@linaro.org>

diff --git a/configure b/configure
index e1de2f5b24..08eaa99d19 100755
--- a/configure
+++ b/configure
@@ -7112,6 +7112,9 @@ echo "GIT_UPDATE=$git_update" >> $config_host_mak
 
 echo "ARCH=$ARCH" >> $config_host_mak
 
+echo "GLIB_CFLAGS=$glib_cflags" >> $config_host_mak
+echo "GLIB_LDFLAGS=$glib_ldflags" >> $config_host_mak
+
 if test "$default_devices" = "yes" ; then
   echo "CONFIG_MINIKCONF_MODE=--defconfig" >> $config_host_mak
 else
diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index 3a50451428..e9348fde4a 100644
--- a/tests/plugin/Makefile
+++ b/tests/plugin/Makefile
@@ -1,9 +1,16 @@
+# -*- Mode: makefile -*-
+#
+# This Makefile example is fairly independent from the main makefile
+# so users can take and adapt it for their build. We only really
+# include config-host.mak so we don't have to repeat probing for
+# cflags that the main configure has already done for us.
+#
+
 BUILD_DIR := $(CURDIR)/../..
 
 include $(BUILD_DIR)/config-host.mak
-include $(SRC_PATH)/rules.mak
 
-$(call set-vpath, $(SRC_PATH)/tests/plugin)
+VPATH += $(SRC_PATH)/tests/plugin
 
 NAMES :=
 NAMES += bb
@@ -17,11 +24,18 @@ NAMES += lockstep
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
-QEMU_CFLAGS += -fPIC -Wpsabi
-QEMU_CFLAGS += -I$(SRC_PATH)/include/qemu
+# The main QEMU uses Glib extensively so it's perfectly fine to use it
+# in plugins (which many example do).
+CFLAGS = $(GLIB_CFLAGS)
+CFLAGS += -fPIC
+CFLAGS += $(if $(findstring no-psabi,$(QEMU_CFLAGS)),-Wpsabi)
+CFLAGS += -I$(SRC_PATH)/include/qemu
 
 all: $(SONAMES)
 
+%.o: %.c
+	$(CC) $(CFLAGS) -c -o $@ $<
+
 lib%.so: %.o
 	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
 
-- 
2.20.1


