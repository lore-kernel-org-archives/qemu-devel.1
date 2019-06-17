Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12D6C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC65208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYvfy6vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC65208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49038 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuMY-000345-P7
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53405)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hct4w-0000RW-9k
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hct4u-0007Ne-Kk
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:38841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hct4u-0007Ld-B7
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id s15so9469161wmj.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=aoRd/IN7MHr76s2KiDTvTo7JU64fLK5LtzUk1fqaZJY=;
 b=bYvfy6vweBD6NJMzpBC6zQIoZJT8BwDm7As6LeqCtnO6y7Pe4UDJLL+ZPy96rawztW
 54y67AeYhoR0bJuENnVXk8IkUSARx8erUnaRD9gHV4uh8HvUP8+g44xLx/t5+0Id7jNb
 ux4UzwkuFSJmiFaHelCWPiPNFsZI8ATJIgCOdrb/X3Yss+YkGVQvICKB9y+ev4ZP5YRr
 49aN7ghrvDMPZBDrdVMLgSsFFh1LVl/QWU3/uTiGRMu6PW/p5Ja1NwOiRnl5iKsSwChG
 efKOiuaddMM3xv1SDdgN0rpXjg3dUmiweNFUdoMeKPhRVWd90VMgE6OfWWS243iRax0o
 3YXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aoRd/IN7MHr76s2KiDTvTo7JU64fLK5LtzUk1fqaZJY=;
 b=bCryXq39yf9ikFdvueEsUNZD/ghCrPq2SRkxLqLUdBvhuES6e6BfI5aIxuFW2mx7/b
 Z+kriJ2nPw9gss1+ox6WXUP6KltBimJNmeJLGfS78Td7rFVRt8f5cJNyqsiYNRuKWboy
 mv8MtxC6MNJ4YrmvczE2Y0vnFrQ2MnnVl7CyoAXqxmrHOFCBwrimDl3oDnZmfnslDKgx
 egCGDSH7D0ur4O0wnQmu/Yo7zFh1lQY0AvKtdd9dBP0v9gAXiXyXfSaudkMfuIgb3BCs
 Wo+VJRUi6IeKnUSHpy4LejAqAXbt8fRn5xD7uch0+KBdkVgSF5x6wFO9km0LUSKIkZBD
 7AKA==
X-Gm-Message-State: APjAAAWl9R6LfCfz80LQBT3TPQUGrvXGxsyYxqdGJ/lMEUizKxBaOxs9
 G4NWAiPT5Ep5XBobf38soJGMDp4o+Cl0iw==
X-Google-Smtp-Source: APXvYqxaUc48hhZfTuJQJG4NoShPRMDJn7ZHuqs3HCLmyrV8tMIZmwFOobG4ELy1vWhnx9/JXKyLvQ==
X-Received: by 2002:a1c:1947:: with SMTP id 68mr18621532wmz.165.1560783466917; 
 Mon, 17 Jun 2019 07:57:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s10sm14690750wmf.8.2019.06.17.07.57.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:57:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:57:40 +0100
Message-Id: <20190617145740.9881-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617145740.9881-1-peter.maydell@linaro.org>
References: <20190617145740.9881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 4/4] docs: Build and install specs manual
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we have some rST format docs in the docs/specs/ manual, we should
actually build and install it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-id: 20190610152444.20859-3-peter.maydell@linaro.org
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


