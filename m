Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C128EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EEB5207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TB/Re3O7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEB5207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrSn-00038u-RA
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrM7-0005Nr-V8
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:59:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrM6-0008Mr-VX
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590091190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GPfSgBN6V2tVMS8P3LJc7AXq2ATI7aQPyqGZHft5RHs=;
 b=TB/Re3O7xAnpelHUB91gzuFOdAEmmZYJoJBYqsMIFi/ii4iuRjIfho9+1QCBbIkc28jFfE
 p667Dl/SLtxfQIKT9Nzr8inqEH3yYItdnphBM/hn8xJsOu0X0JSCXN9a3qYcoEXUcwLLaO
 9N7ibF5+xtxMFjuaCoG3sdcdNqqDOMQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-oOY7oJjKNOyTLnQABzpLQQ-1; Thu, 21 May 2020 15:59:48 -0400
X-MC-Unique: oOY7oJjKNOyTLnQABzpLQQ-1
Received: by mail-wr1-f71.google.com with SMTP id 90so3341499wrg.23
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GPfSgBN6V2tVMS8P3LJc7AXq2ATI7aQPyqGZHft5RHs=;
 b=O4//dpWD/GCBsC00zeuU+e4eawwLEvsrlD0ZJfFH8zWim35ucjz4DL3jsCex0iXfO+
 wbaB4x/UtvDpoRCufLGWCIAAIvPSNFKC+FBBlVh8aO1PUwyPIqBeWL8r4WFhA+vaxGrq
 ab1bHQms5XjAVc5wri7UYWLhssu6f4+G0wz8NW2YtmPln2ab/FlgSIXclYT4sjF1EDzj
 Kyr77tH94nLyIJD2jU4Udithgr+ByOdMYH/gI8PVAbMt9j3o+wJbYZ+YvJFGCHbKz8E3
 ZxLIXHEt6u62Hgqwu2YindRNReUDPW/0H+S65ngnZZecqaktsV39EkRV32Cq0y0pTpgR
 14uA==
X-Gm-Message-State: AOAM530b2ewiIM5qvZHfiW3io0LxihD73ugaJmXsJn/rvwS6PRVMjJhP
 zxCK4cXX5R4NhJtyTgYQYPhkoNBrYktJMoK1FLU6QAfwXLpveM9nGTlUOmH3S3mMyOHfFFRfVB0
 UwjEKP+NtTlqdAv8=
X-Received: by 2002:a7b:c1d2:: with SMTP id a18mr10054083wmj.176.1590091187090; 
 Thu, 21 May 2020 12:59:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjZ/S3jGknoIdp45jf+F28heqmGYmWTQiFWjpn32tfASHwwq+r3kJugCXtOLIEjzXuVa/5cA==
X-Received: by 2002:a7b:c1d2:: with SMTP id a18mr10054054wmj.176.1590091186867; 
 Thu, 21 May 2020 12:59:46 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q5sm7928308wra.36.2020.05.21.12.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:59:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/11] Makefile: Write MINIKCONF variables as one entry per
 line
Date: Thu, 21 May 2020 21:59:06 +0200
Message-Id: <20200521195911.19685-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200521195911.19685-1-philmd@redhat.com>
References: <20200521195911.19685-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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


