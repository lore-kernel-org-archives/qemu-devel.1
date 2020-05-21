Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90477C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE33207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lc/OZWoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE33207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrU9-0004rz-Gc
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrM9-0005UT-L6
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:59:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37536
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrM8-0008NK-Vy
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590091192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndqFgBanjliYTdRp8N1sk+p/cY4owVogsc0x0ibf8Jw=;
 b=Lc/OZWoDp9jp5XCcD/ej/QA2cnq8t5rXNd8y+aXaRvCzDRWUEgEt5HD80j/gYryDR6PCoB
 q2eoT7DSSMExEgD2QJhQHJmv17BdqBNZxoKuIoeavTHUw3AnDR3w7R4zxZxNocq3FTf0p2
 8zHbFD2MRFxlFhqtxy061tkR6YQPX7o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-IR8o69A8O6q9IGQqSxcUOw-1; Thu, 21 May 2020 15:59:43 -0400
X-MC-Unique: IR8o69A8O6q9IGQqSxcUOw-1
Received: by mail-wm1-f70.google.com with SMTP id u11so2138142wmc.7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ndqFgBanjliYTdRp8N1sk+p/cY4owVogsc0x0ibf8Jw=;
 b=umIRR1GK9pdpEsTOo0F8aD8/2Y2xq32z3q0qKZbBLek1D+Mxt+cVmkVfmllYRUu9wY
 fEpzbYsmq/0POUSUkAhnK8J9dShFNGvgxgqTGuPLuzG+gpQtsmBAErauZ3QCZVO+dA+w
 6YOcQ0G9hTodcci05hSWeHF+GXMH/gHDeJYIYF/OUtWhH29u2SV/mR/WCtcgXa0aexoa
 4sXgkqGeT2FLoEyDR/XbzdswFEjH8u7JaN1PfSB0r0Y1DNWxaXI50CB4G1B7ZJedIazj
 IM4H+GLlrOcIbMtHOH7cWXevEDDh/MNqHWD3AB359OPF8YX/Pws/4v9XtpvuM3qeBomV
 nBFw==
X-Gm-Message-State: AOAM531qOF/QiwY/R1xLD2oejSmmJ7qIr1x/9r8ZmkiiN8LFE1/ofV0H
 pw5AQfD82KcrxIjWmaDWuLccUz5DBgrtlQkAgiH6qfg4yiMmgXhqEv+ba+5t6U7s5Xh5r/HQ4u1
 VoXGo0GVnkkezVGY=
X-Received: by 2002:adf:ea09:: with SMTP id q9mr199798wrm.399.1590091181641;
 Thu, 21 May 2020 12:59:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeaXm4iwycnKbL3KPvGpgmGXlS3CyVHkAmumZ3hSREIGIXaWVOKv0e6o6ImxUtk7uwY+Ha9A==
X-Received: by 2002:adf:ea09:: with SMTP id q9mr199773wrm.399.1590091181402;
 Thu, 21 May 2020 12:59:41 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 40sm6315242wrc.15.2020.05.21.12.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:59:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/11] Makefile: Remove dangerous EOL trailing backslash
Date: Thu, 21 May 2020 21:59:05 +0200
Message-Id: <20200521195911.19685-6-philmd@redhat.com>
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
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One might get caught trying to understand unexpected Makefile
behavior. Trailing backslash can help to split very long lines,
but are rather dangerous when nothing follow. Preserve other
developers debugging time by removing this one.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 40e4f7677b..6c9d718b2c 100644
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


