Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C830C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47EFD2076A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NS3Pw91X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47EFD2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKwV-0007iV-Gx
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnb-0002xH-9o
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:38:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24009
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKna-0005vr-DK
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591634337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrjLSR8uCADAjzmKHMCv5VE/lxL5JFvlmGcsgDcBaxI=;
 b=NS3Pw91XXiO8ad4WwIkHX1ux1Ul/xDx7o9K4iy6KargK+z4Es1BZXYqkp9Q2Gt8LN1NbMw
 u1PAyF6nViQgfom+EG6TGAjDLpFnmqKZGRh4HhdGJuKNZsCBIV5hsXTc4v0oVcbpWBToCJ
 RlUwxirqa/8OBFipWOeiRBatFP9lOvU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-RvYVCQXJOVe1ItV7YopkWQ-1; Mon, 08 Jun 2020 12:38:56 -0400
X-MC-Unique: RvYVCQXJOVe1ItV7YopkWQ-1
Received: by mail-wm1-f70.google.com with SMTP id j128so30882wmj.6
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JrjLSR8uCADAjzmKHMCv5VE/lxL5JFvlmGcsgDcBaxI=;
 b=JI9Upl6diDuYkMZvVCsaXolWW2NLfIo3Pc3RjCWQveaWT6CdFvodqI77N6o3sttlWe
 PNI2vpvbJTOx6Rr4X5hvqjqs6h8sF0UiBEdm26cfhvabGeehGNfMC337+rPGagaWqe9n
 tiGACZdwz9I6C0X5PfU4+bBzG2frbTj5ntAhzCH38o0I1p+w0R5fYu5MXEWUgNpkQ6+5
 duJvSBrM83BSxYpxHqiApaS4/nuYGWxN0i4PwfQDt34adc2CQdGHYf7pabS0AsexKdfz
 5b2WH5s01Pd2PdpoaOYN9dOPdGaSgqbGynZLIC6pf2lMRdqy84eSJ3yzF7/3Me0ipgtj
 /S5A==
X-Gm-Message-State: AOAM530I4A+lpjoNBb5W0WUgE+WjQnJDVp72iGTNDP2y43wfHryK45BU
 IK8Cam3aeVfRnqYCdLNvBsK6m2sJ5or3t+IInFU0FIivqYpGhCkaWqvcHWe0EiOZ9eWcu5ia3Ou
 aN+WJsGKxeou8614=
X-Received: by 2002:adf:f582:: with SMTP id f2mr26391581wro.204.1591634334512; 
 Mon, 08 Jun 2020 09:38:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPFniFzHjk5teyNXNWkZREiVNsJWSWy4PiMhC1DBrMxd2DRKgv00Di/GFy9MxvPbkihGUfdw==
X-Received: by 2002:adf:f582:: with SMTP id f2mr26391567wro.204.1591634334363; 
 Mon, 08 Jun 2020 09:38:54 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id j190sm91841wmb.33.2020.06.08.09.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:38:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 06/10] Makefile: Write MINIKCONF variables as one entry per
 line
Date: Mon,  8 Jun 2020 18:38:19 +0200
Message-Id: <20200608163823.8890-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608163823.8890-1-philmd@redhat.com>
References: <20200608163823.8890-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 52956b16fd..93903e94b1 100644
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


