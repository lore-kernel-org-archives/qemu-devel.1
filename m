Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1263C31E41
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 15:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4322085A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 15:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjaPkB9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4322085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haMC0-0005Uz-LI
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 11:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haMAR-00047n-AD
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haMAL-0004lW-MM
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:25:01 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:40960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haMAJ-0004gE-SS
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:24:57 -0400
Received: by mail-wr1-x429.google.com with SMTP id c2so9612240wrm.8
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wf1rBZIYOLaVLqVG55fM2V+yvtysYWVZ87PUdH2633g=;
 b=wjaPkB9VNtyhPdtjVqaEI/wNv+iFQkJg9SjNkTiKRwkJlEcW80U6JRPHoCroFGvWmH
 VmAeZYm6Vxl0tQdin/Q4M3tFOTj7Krq7HoZOfNjLlRadhvwRCJj8JFYXlaClohyO272L
 fAbWGjG8RIR44NOPD8sg1zWWMN236M5HhqbjZO1LkjOnBgPgg38DPISVSMwcyyeYmiHA
 y2RAhjlp4DJXiMYbjzidujZRYVRQnUT+OrAR0yIwlgaMeI6pU0I49mPRyNc+8bzdUZ0t
 jYaaKTyYozWMcAJ3RO575DRsPn2DaA5L5QfBgqLmKgRUrvTqvrfFQx+8AbrBQY2oGF0B
 mTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wf1rBZIYOLaVLqVG55fM2V+yvtysYWVZ87PUdH2633g=;
 b=pxQDY73YwgOrc5fP6/xD/BNqm8ZokdyHU9Y+P594FiIktlTOKDMoZKNAGGOeZqxxL9
 1W8EeRZc+E1/3gMB5jx/5uIZcR6EN8sftgqRFUNePmRkQCppGuWyZYjftiPj8UBSOS9m
 jtBxu2XvEnmkwtCrgELJAAS00NUx0xY9S/7sMApO3PLnfLMeVOTVS/MtimF0io525Y2V
 xuT+DkInUltXBpK/ubVIwRIPmfAYETI5avS+4JWZn07DOZ75DbtSe1kg6hpOcPV0oktd
 X0Gl8hk2hSp18oIBOoR5kOy9mK09SShEVSX1TTT5J48WtHKlnihs+b3FP3qWAMCuZoj/
 39zw==
X-Gm-Message-State: APjAAAUUfZENrcjEmNx10ds60ALQxS7ueFI5HdhXFonrxGhE56fPzZ2X
 4XvEU1E5b6TDKZGgQX6XH4d9rcU3bEgIpA==
X-Google-Smtp-Source: APXvYqz+jAS8gcqDQjN6QcHK6jaaUn0mLBXMfnUX7jRK7qu4vqDtahkM9rOQLkARyOpRi+9PhbACcw==
X-Received: by 2002:a05:6000:104e:: with SMTP id
 c14mr33946197wrx.71.1560180288663; 
 Mon, 10 Jun 2019 08:24:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b203sm11945920wmd.41.2019.06.10.08.24.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 08:24:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 16:24:44 +0100
Message-Id: <20190610152444.20859-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610152444.20859-1-peter.maydell@linaro.org>
References: <20190610152444.20859-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PATCH 2/2] docs: Build and install specs manual
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we have some rST format docs in the docs/specs/ manual, we should
actually build and install it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile           |  7 ++++++-
 docs/specs/conf.py | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 docs/specs/conf.py

diff --git a/Makefile b/Makefile
index 8e2fc6624c3..cfb18f15254 100644
--- a/Makefile
+++ b/Makefile
@@ -731,6 +731,7 @@ distclean: clean
 	rm -rf .doctrees
 	$(call clean-manual,devel)
 	$(call clean-manual,interop)
+	$(call clean-manual,specs)
 	for d in $(TARGET_DIRS); do \
 	rm -rf $$d || exit 1 ; \
         done
@@ -781,6 +782,7 @@ endef
 .PHONY: install-sphinxdocs
 install-sphinxdocs: sphinxdocs
 	$(call install-manual,interop)
+	$(call install-manual,specs)
 
 install-doc: $(DOCS) install-sphinxdocs
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
@@ -962,7 +964,7 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
 # and handles "don't rebuild things unless necessary" itself.
 # The '.doctrees' files are cached information to speed this up.
 .PHONY: sphinxdocs
-sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop/index.html
+sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop/index.html $(MANUAL_BUILDDIR)/specs/index.html
 
 # Canned command to build a single manual
 build-manual = $(call quiet-command,sphinx-build $(if $(V),,-q) -W -n -b html -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
@@ -975,6 +977,9 @@ $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
 $(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
 	$(call build-manual,interop)
 
+$(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
+	$(call build-manual,specs)
+
 qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
 
diff --git a/docs/specs/conf.py b/docs/specs/conf.py
new file mode 100644
index 00000000000..4d56f3ae13c
--- /dev/null
+++ b/docs/specs/conf.py
@@ -0,0 +1,16 @@
+# -*- coding: utf-8 -*-
+#
+# QEMU documentation build configuration file for the 'specs' manual.
+#
+# This includes the top level conf file and then makes any necessary tweaks.
+import sys
+import os
+
+qemu_docdir = os.path.abspath("..")
+parent_config = os.path.join(qemu_docdir, "conf.py")
+exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
+
+# This slightly misuses the 'description', but is the best way to get
+# the manual title to appear in the sidebar.
+html_theme_options['description'] = \
+    u'System Emulation Guest Hardware Specifications'
-- 
2.20.1


