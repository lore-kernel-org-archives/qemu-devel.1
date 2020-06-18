Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50381C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200DC208B3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4yE/P7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200DC208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltnJ-00012K-Db
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltkW-0004zo-My
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31905
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltkU-0004pK-QT
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592483670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3sUZncp9HyX8wsOOdfMGGFaKSzdrwh5zIZPnh2gp/QA=;
 b=I4yE/P7V5kXkt2D57/MLLKPQjXPLjE2c7Rv/qfjU4RXmgaEoNwUWVgVVThxoYJpUz/h0UD
 KzY/NQDCZi2IDkQpl/XBSPnbroJ5CA/nBUAr8mgkj1CBqdC6I4t8Cm9ikoq8s5xbaFd1n3
 bozFkYOza3/WpqsZpOfVT1X0wrA0iq0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-LnOc1MtvOEO1T9rs00LwMQ-1; Thu, 18 Jun 2020 08:34:28 -0400
X-MC-Unique: LnOc1MtvOEO1T9rs00LwMQ-1
Received: by mail-wm1-f70.google.com with SMTP id q7so1740650wmj.9
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3sUZncp9HyX8wsOOdfMGGFaKSzdrwh5zIZPnh2gp/QA=;
 b=iHjlaPit6SuwG9Z6+PQK28/e1YTUqXRRI0nHqGXNFxvRbtDG1g2Nqts54KzejenzLA
 QOnHC7pfX25DcIcqDT1wFtfmV4+hMAObXv7tVyOuTnK8eawyRe64OCrAxNzhrS6uRU+C
 EFA/pgXSf2hnLY8TF/ch4UFbmmleGQpwV5U5XpByIdK+/HUOv41BZCCCidTQl2L1eRw8
 5VCUwWb0S2Zfo0MRYF7BZSHkr3yNU3be9EtQcxxG9Wcrc9nlLNOUVI4We8lfw9RbCcpj
 if8AoSkNY544+Ro3/foHwlq47hAN8ofyNL7DE66phsYbIAQp66hdW8d7M3PMVC6D/jO4
 lEJA==
X-Gm-Message-State: AOAM530O68xO+nDr2nvEsyOAIduYi+8SaImMzkCD8j1toWMt4fQ+ZLqi
 NubP5XjMIFeEBohy1mf4yK8Euw6T6od5VmZosS1IhgPPENwS62cBu5TztH1A4m/gZIBG5uAVqcA
 QZYTQ4TNk1xNaueQ=
X-Received: by 2002:a1c:a905:: with SMTP id s5mr3775548wme.120.1592483667376; 
 Thu, 18 Jun 2020 05:34:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxkdsnq5ON0DDFE7gMrfVfXlMsKZh8D6ZIGLyYdGLiQXpD4VasZwRTyGsn2fN7ejTb07WaDg==
X-Received: by 2002:a1c:a905:: with SMTP id s5mr3775537wme.120.1592483667168; 
 Thu, 18 Jun 2020 05:34:27 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id a1sm3619517wmd.28.2020.06.18.05.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 05:34:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 09/10] Makefile: Allow target-specific optional Kconfig
Date: Thu, 18 Jun 2020 14:33:41 +0200
Message-Id: <20200618123342.10693-10-philmd@redhat.com>
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow use of target-specific Kconfig file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 00e8553745..c131c4e99d 100644
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
+		$(wildcard $(SRC_PATH)/target/$(call base-arch, $@)/Kconfig) \
 		> $@.tmp, "GEN", "$@.tmp")
 	$(call quiet-command, if test -f $@; then \
 	  if cmp -s $@.old $@; then \
-- 
2.21.3


