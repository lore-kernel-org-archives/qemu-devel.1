Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB22C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B522206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCNeKht0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B522206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8mj-0007aL-NZ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh8jG-0000ae-Fq
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:33:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41649
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh8jF-0004av-ON
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591349613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndqFgBanjliYTdRp8N1sk+p/cY4owVogsc0x0ibf8Jw=;
 b=bCNeKht01M4jkMdUwRVCxPok2YyYghIeOismE9l/38pA2bTYsrzROYAQzIZnY2tzdb562s
 /4t3dkhi7p6ZXLLUdlkBJv/+Qkc5cHEr+XRLl5wzH/QRtExYA5TO4xVzbrPfdSnDIvniHN
 WdVEyKK4AZM/K9JQ8gor+sfhC+lgQYs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-ZsZS2OoWOK6xKyHaxzYAJA-1; Fri, 05 Jun 2020 05:33:30 -0400
X-MC-Unique: ZsZS2OoWOK6xKyHaxzYAJA-1
Received: by mail-wr1-f70.google.com with SMTP id a4so3542692wrp.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 02:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ndqFgBanjliYTdRp8N1sk+p/cY4owVogsc0x0ibf8Jw=;
 b=iNm9ZxRZoz888uqauaLhb9+0PJjSxFf1xEhH7ctb5ZUqVjMo3mbnPiComzYPmZCzDo
 +buzvV08dJ4QDQOaOnTDJ/5Y2ozl1N/pkq7C04tanf/a3tyX3A7CullF52XrIJ17fb/1
 rKdGCC4FIGtvJ90GDW+UJ74AWVzVjSIUyd0FykPxRhZN8e4XSsXI0HFzzBBJ57iG/ZtW
 02o2mfGwp+JVA94E24qrvze3+nW1MpPHq9Q6jf/ynVTZOgLSla3zMjRGIcbWmPc3UoPn
 3BpLSJh4XdBVqkf9A3qCWIuJ0Vu2Z06IxCAA0PJXFJF0d2kwMSLlRY1WyUcIb/FG35m3
 gUOA==
X-Gm-Message-State: AOAM531ZWvC7COHNTSwZf6yES23GnqU9Zq/A7+4CONYv7iRDCD4ba4wE
 gCp+6+UTRWZIKS/i0kOZlShooosdPr4c+gF5xZV3DH6iPwanGRRghdZWJs0PeG8YZzkvrW5kYM5
 oABfoCrzzEVgrmeY=
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr1770999wmi.0.1591349608365;
 Fri, 05 Jun 2020 02:33:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4TzGH0T5JReVg5d+u3CHLUfwMKnudHkNNvvoTkxKjqB4Fw7sddmTy6J2l+0Hg9RSoR6YfHA==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr1770981wmi.0.1591349608191;
 Fri, 05 Jun 2020 02:33:28 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a16sm11671984wrx.8.2020.06.05.02.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 02:33:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/11] Makefile: Remove dangerous EOL trailing backslash
Date: Fri,  5 Jun 2020 11:32:51 +0200
Message-Id: <20200605093256.30351-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605093256.30351-1-philmd@redhat.com>
References: <20200605093256.30351-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>
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


