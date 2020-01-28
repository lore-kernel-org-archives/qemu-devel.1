Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789D1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4692422522
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEZJWO1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4692422522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVNm-0007tO-Gu
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4G-0006T4-FP
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4E-0008IL-Gr
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:28 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:38240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4E-0008Ec-9z
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:26 -0500
Received: by mail-wr1-x429.google.com with SMTP id y17so17101631wrh.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+MaXVKBMBtu1uPF+4k843da/2H/M7WJ/wxG+lhTARZo=;
 b=qEZJWO1CUO2r2nJ4Zw1ljZgR3NKAvZMvwl+WvsX5uy4MNNF2j+zmjmeEWIH8JTplNe
 YeFROSwSKXDZtifbKXhsbSpxwEtU7/07/HqNe2btJX6qosti7QItmCqbiedeeWgEYW1A
 Sh8cVb8h3ut+gwMCxQqgRULuOaqGa2D8eJ+mP+/NGpxS2CFuo6Ns/OIe2us8rMECUgMt
 5eFQee82b6t4hfaFOgDnFX4zIIUYhEPaJR2XOK7GKAY/1KXCPHfQYmAsXEyEFlBFJNIV
 hqQEoY5Ptuh+teTSXcExKgPT5byuokvRuC9R72kUNqJsWd8ouZQF1u8YCSv3chWNsa70
 xLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+MaXVKBMBtu1uPF+4k843da/2H/M7WJ/wxG+lhTARZo=;
 b=KNz68lbMcrge4MNh+7+M+CFFU2j11TIjNrauU3Kzg4L7f7KmPKZI9QlsFn9j97gLZq
 i+bymEDIcnn+k7Ie6l+oDi0w7F+UJLf8VkyYz7NWb5XDOOca3A32VRyg3WfSwxoj3oMC
 VNjFTcEJwBCw0Ypd0pE9bqZslRxZkADeqHpT9/fZtIUmsm5ck4SdOUsR+ixY5qssy50y
 4EVQ632X3G9gF4Wmzelujd6YeE/9QsTyuGrgsvs/WygNkutQ1gn83C4IrtybNnqv7s+a
 gXsUChwNeeZXV2zc5EHE9cOS/4jxRCTle+2rZeWU4SXyZ9Yvb4B5dfsM8AaNH8Gk2ftR
 OXFw==
X-Gm-Message-State: APjAAAWGRde1DbYZMYawZWJ+bqNaxrxwQwjKF0R+050XZ1n+iQXqY9yU
 hIcgl5ZNIkBm7stbQ+lHXVpFCvwh
X-Google-Smtp-Source: APXvYqzsarxFmOaA8Y8aIYsCx9zsCtucaWkGXpo9MFmVoFj2lziY7UZbMc/0OMuKZYOp5kfPz8dRmg==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr30125873wrn.83.1580234063662; 
 Tue, 28 Jan 2020 09:54:23 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 014/142] meson: add remaining generated tcg trace helpers
Date: Tue, 28 Jan 2020 18:51:34 +0100
Message-Id: <20200128175342.9066-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile          | 51 -----------------------------------------------
 trace/meson.build | 14 +++++++++++++
 2 files changed, 14 insertions(+), 51 deletions(-)

diff --git a/Makefile b/Makefile
index d1ee562a9f..f9c3b73ba6 100644
--- a/Makefile
+++ b/Makefile
@@ -122,61 +122,10 @@ FULL_VERSION := $(if $(QEMU_PKGVERSION),$(VERSION) ($(QEMU_PKGVERSION)),$(VERSIO
 
 generated-files-y = qemu-version.h config-host.h qemu-options.def
 
-generated-files-y += trace/generated-tcg-tracers.h
-
-generated-files-y += trace/generated-helpers-wrappers.h
-generated-files-y += trace/generated-helpers.h
-generated-files-y += trace/generated-helpers.c
-
 generated-files-y += module_block.h
 
 generated-files-y += .git-submodule-status
 
-tracetool-y = $(SRC_PATH)/scripts/tracetool.py
-tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
-
-trace/generated-helpers-wrappers.h: trace/generated-helpers-wrappers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace/generated-helpers-wrappers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	@mkdir -p $(dir $@)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-wrapper-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-trace/generated-helpers.h: trace/generated-helpers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace/generated-helpers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	@mkdir -p $(dir $@)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-trace/generated-helpers.c: trace/generated-helpers.c-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace/generated-helpers.c-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	@mkdir -p $(dir $@)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-c \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-trace/generated-helpers.o: trace/generated-helpers.c
-
-trace/generated-tcg-tracers.h: trace/generated-tcg-tracers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	@mkdir -p $(dir $@)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
 KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
 KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
 
diff --git a/trace/meson.build b/trace/meson.build
index d0e5d17cef..8ea8db7a23 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -61,6 +61,20 @@ custom_target('trace-events-all',
               install: true,
               install_dir: config_host['qemu_datadir'])
 
+foreach d : [
+  ['generated-tcg-tracers.h', 'tcg-h'],
+  ['generated-helpers.c', 'tcg-helper-c'],
+  ['generated-helpers.h', 'tcg-helper-h'],
+  ['generated-helpers-wrappers.h', 'tcg-helper-wrapper-h'],
+]
+  custom_target(d[0],
+                output: d[0],
+                input: meson.source_root() / 'trace-events',
+                command: [ tracetool, '--group=root', '--format=@0@'.format(d[1]), '@INPUT@' ],
+                build_by_default: true, # to be removed when added to a target
+                capture: true)
+endforeach
+
 if 'CONFIG_TRACE_UST' in config_host
   trace_ust_all_h = custom_target('trace-ust-all.h',
                                   output: 'trace-ust-all.h',
-- 
2.21.0



