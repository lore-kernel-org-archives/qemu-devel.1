Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674ADC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3AA206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqJTEobW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3AA206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdvA-0003Dw-A8
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdpY-0000Zj-7w
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:09:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28799
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdpX-00032j-HK
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589562542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CgUPsSauJHPAfqEtx3F/6v2O6U+cLNjTuefN7n8Nwkw=;
 b=bqJTEobWgVSjzOa6BbHyjNsXpl02Krc0OJSZ3MTRTu7yZx27H3hiJ3kVrMS2JYHp7r2bH/
 4yn9O6qSKl4vtCHGe3W3R5iQD/niFAND8GEsB4Qt7VcpDCtY2Dyjwwf8Q9qyAVHhvfBw/z
 LfAuyuuYtfKg67IisrK7DY3Npe5tUAk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-Xnf5Q2tvMxqYqJHzZf-ZcQ-1; Fri, 15 May 2020 13:08:59 -0400
X-MC-Unique: Xnf5Q2tvMxqYqJHzZf-ZcQ-1
Received: by mail-wr1-f69.google.com with SMTP id z10so1485280wrs.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 10:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CgUPsSauJHPAfqEtx3F/6v2O6U+cLNjTuefN7n8Nwkw=;
 b=FG6Y8j+t8jLSAlpZlUQKMkCwAyUz2QXI2QNFE1CxAr2neCIQ3z9mpvACQnHtPDnhbA
 RBXuUTGReZl2S7PRcYKlPu65Io8ERz+lr6jyR/xgTz6ZEnNb+WnFttzYX6gRKKVojW4B
 x8DhditWWkixMK79qFCf4WqENZOzpD9ALudX+zg99QGTjlIigbh244/7SoL/nU13juRC
 uEkxeNDmEnV4nMyMjUrE2pfgTP3CbaqEv/Vtrr8+ZPfaTyjwnKn/NEfW61XhG4PS2yxM
 pivcN97CufpdNDyjFCm7AuQaDh37T3oxdLUl86iI83XarIinuDc28kSupPlYWEln1KRY
 YTdQ==
X-Gm-Message-State: AOAM533wwOg2N/e5MVipmzvmL8LidzBlYLTuryBtNIyvNE3XqRK3s+Nc
 t0dQ41AFxlxyUFJ77K/MOjlbH4ReL4M3fJPneDXbmagUAU1w+8Igu2MtWcXHbnmV8LGsCjfhbG5
 nUueCNmXYcvKRlgQ=
X-Received: by 2002:a1c:e2c5:: with SMTP id z188mr5022593wmg.35.1589562538399; 
 Fri, 15 May 2020 10:08:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJJOiiUiXarfUTi9eHtH6/U/9GLQ3jYfatS4wmFNE1+6AEO5VZwL6RE9VQse4OAM+Qh57d8A==
X-Received: by 2002:a1c:e2c5:: with SMTP id z188mr5022566wmg.35.1589562538245; 
 Fri, 15 May 2020 10:08:58 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z12sm1931109wmc.6.2020.05.15.10.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 10:08:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/10] Makefile: Allow target-specific optional Kconfig
Date: Fri, 15 May 2020 19:08:03 +0200
Message-Id: <20200515170804.5707-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200515170804.5707-1-philmd@redhat.com>
References: <20200515170804.5707-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
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
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Michael Walle <michael@walle.cc>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow use of target-specific Kconfig file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b4c0830b26..5fce168fcb 100644
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
+		$(wildcard $(SRC_PATH)/target/$(firstword $(subst -, ,$@))/Kconfig) \
 		> $@.tmp, "GEN", "$@.tmp")
 	$(call quiet-command, if test -f $@; then \
 	  if cmp -s $@.old $@; then \
-- 
2.21.3


