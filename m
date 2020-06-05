Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA380C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838D62053B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OugnNChD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838D62053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh72Z-0003hr-Hd
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6xw-0002oy-Lc
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57766
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6xv-00057F-QE
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591342835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GPfSgBN6V2tVMS8P3LJc7AXq2ATI7aQPyqGZHft5RHs=;
 b=OugnNChDcM8wgNvGxnQKmNdJ1sKADzF/9jVkfDMciL2LIzjq/5xVXO8FkreKEsdxvkMEp7
 nPO5ZLT15eIJxxsUAXHr//K4AQp39y8aXbcEXVD7rl/ChQBPl0GRKyF/BNmVgA1k+Ckx+f
 32i+0WhkxfgnbczwbEb9WqGA2d2JrUE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-DwXWdZY0P2miYzaQ0IlBWw-1; Fri, 05 Jun 2020 03:40:33 -0400
X-MC-Unique: DwXWdZY0P2miYzaQ0IlBWw-1
Received: by mail-wr1-f70.google.com with SMTP id s17so3398564wrt.7
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 00:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GPfSgBN6V2tVMS8P3LJc7AXq2ATI7aQPyqGZHft5RHs=;
 b=NT0ielxDEEsMctfFi/E9VQ0HrZSBHvkvyxIIbPBC3edvoQQcr3BxHXkFtUp4hiQmZe
 MhrzeK/PN4srzf4T7TxIJM4SwqP64kgftJNGrXS74n2so6LcTnanHVa1XIXfLRRdTJLh
 zr5JKeo3Ywbvb67JoHoh+hUQdUM13EutHP4kph3CQt7jBSQxrO8ViBKHfhjte7Ek+7Fi
 t7BQ2eMSSf1hBYqPGJ/kAIlJ+x8GFAsXhEMscIiGs9fOTcRNQyyn7CD54fuSB83YOLpo
 BsIhu+sTEJS+/SlxVcds3jjZ3ZLldD2rG3pNoKOvEGvS1FOhMThg7XAzRvLQNUP+e4BQ
 7Cdg==
X-Gm-Message-State: AOAM5308+0F880o/rdgrl/Nn4K19fzThPMXWJ5EHnjIHtY+aGpXgIUe0
 Kf1fKa2KINhvoajqmh5I4eTZA7FqAsl4pLGE/ZvG5hqBvTPyC0mx4Bght7Gk+6ziS3zaJJANeFV
 zx5ri0H8n30BW2es=
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr1412051wme.65.1591342832052; 
 Fri, 05 Jun 2020 00:40:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7KKUv93hD9TfhvE/aBK2eR+wUxxJ7VNHpm6ivd4VdMPS6qSwW5MPAV68QZinWjD0eYsddBQ==
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr1412038wme.65.1591342831885; 
 Fri, 05 Jun 2020 00:40:31 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id g187sm10610557wma.17.2020.06.05.00.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 00:40:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/11] Makefile: Write MINIKCONF variables as one entry per
 line
Date: Fri,  5 Jun 2020 09:39:49 +0200
Message-Id: <20200605073953.19268-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605073953.19268-1-philmd@redhat.com>
References: <20200605073953.19268-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 6c9d718b2c..7666f81e8a 100644
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


