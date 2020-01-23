Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96D5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964592071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7YzdQXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964592071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugWQ-00055N-5C
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRb-0000Hx-AC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRZ-0003iN-OZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:55 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:36368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRZ-0003ht-HZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:53 -0500
Received: by mail-wr1-x432.google.com with SMTP id z3so3564546wru.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=pwJvuoYj5XQgcYzCmAadQQKwmUSyeHP8Y+GhQZSCMJc=;
 b=X7YzdQXt8Ycy5cal2fosnzgWxHIO2uYbo9hGlx7XUQo3ChWOfxOwsd+wXXEyK/K2ZQ
 toAU/CgcuXpdaXBjBm0qRCX7DxUpn4RpZ8rq2pbuwgfdalwvf+asdEkaJZlj5r2A0BPT
 UQrUK382WgeTSAoaccjkl0BINOdaLbPRHYTtrdAV6ZiPrALi+YH6rQ/z5vWTJHRQ8hER
 BveqBtW7eT/0t+z7VPfKSvWTyYjVYrYlHmppMdNmww5fy+ofTjZ7cUaQm5mlKbk9zObo
 vsmDFkb0O7uF6iMSLmWDSVpAK4jncf7z82kBWOeul9iK27vBvTp3bPrFHlR84z80mW8f
 HLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pwJvuoYj5XQgcYzCmAadQQKwmUSyeHP8Y+GhQZSCMJc=;
 b=RuM5aQaF4lY7AaQ9zgKHg9fLUcyZhnA49UmA274/7x403KKblWg68hIMBqmVwU/VBj
 sO2bcDYcmVRAiCLq9qWy0uHqMT15S3equzklVHzVfvTaY6ZtgXCrUwHwmPIzDEuzjXk0
 1eNFwym3yupucxnW8lYL5PvcbxsOTGaL44lwiluAyOTAU9/3RDoC35V4eUOL6V7l8Wku
 kNlg6syJ+gIA1J5MRrl8U1yaREQNVFg1kTZoJsKVoO6MqNzmsdTJbJC3PRbPJDI2XDnC
 QNLqjDbJMlOQtH/b/oKmrHnV4uQdlaZR78HAFIfp+dPYLmMEdKB/R9G7MrMENo4W3GmC
 BNEA==
X-Gm-Message-State: APjAAAXhbORZ8LuFfYN6wozF8YIq8G8/LP5tk3r+3IorGPSPAGgPrBJ1
 DQzLSn19O/xmzHTRlyIY9CNrUxhKjxpe8Q==
X-Google-Smtp-Source: APXvYqyMsI9BQJIdNPUQtwuTOtBbVo+g4Su6VB4NvwoyBH/iIeeKBXOpRGHz28M53MOd1CsdJ6uM7w==
X-Received: by 2002:adf:f382:: with SMTP id m2mr18020626wro.163.1579793452393; 
 Thu, 23 Jan 2020 07:30:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.30.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:30:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/20] docs: Create stub system manual
Date: Thu, 23 Jan 2020 15:30:30 +0000
Message-Id: <20200123153041.4248-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

We want a user-facing manual which contains system emulation
documentation. Create an empty one which we can populate.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20200116141511.16849-3-peter.maydell@linaro.org
---
 Makefile              | 10 +++++++++-
 docs/index.html.in    |  1 +
 docs/system/conf.py   | 15 +++++++++++++++
 docs/system/index.rst | 16 ++++++++++++++++
 4 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/conf.py
 create mode 100644 docs/system/index.rst

diff --git a/Makefile b/Makefile
index b4a6c28107d..2ab6a17205f 100644
--- a/Makefile
+++ b/Makefile
@@ -757,6 +757,7 @@ distclean: clean
 	$(call clean-manual,devel)
 	$(call clean-manual,interop)
 	$(call clean-manual,specs)
+	$(call clean-manual,system)
 	for d in $(TARGET_DIRS); do \
 	rm -rf $$d || exit 1 ; \
         done
@@ -813,6 +814,7 @@ endef
 install-sphinxdocs: sphinxdocs
 	$(call install-manual,interop)
 	$(call install-manual,specs)
+	$(call install-manual,system)
 
 install-doc: $(DOCS) install-sphinxdocs
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
@@ -1000,7 +1002,10 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
 # and handles "don't rebuild things unless necessary" itself.
 # The '.doctrees' files are cached information to speed this up.
 .PHONY: sphinxdocs
-sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop/index.html $(MANUAL_BUILDDIR)/specs/index.html
+sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
+            $(MANUAL_BUILDDIR)/interop/index.html \
+            $(MANUAL_BUILDDIR)/specs/index.html \
+            $(MANUAL_BUILDDIR)/system/index.html
 
 # Canned command to build a single manual
 # Arguments: $1 = manual name, $2 = Sphinx builder ('html' or 'man')
@@ -1022,6 +1027,9 @@ $(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
 	$(call build-manual,specs,html)
 
+$(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
+	$(call build-manual,system,html)
+
 $(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
 	$(call build-manual,interop,man)
 
diff --git a/docs/index.html.in b/docs/index.html.in
index 94eb782cf7e..8512933d145 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -12,6 +12,7 @@
             <li><a href="qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
             <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
             <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
+            <li><a href="system/index.html">System Emulation User's Guide</a></li>
         </ul>
     </body>
 </html>
diff --git a/docs/system/conf.py b/docs/system/conf.py
new file mode 100644
index 00000000000..6435b4d3f8e
--- /dev/null
+++ b/docs/system/conf.py
@@ -0,0 +1,15 @@
+# -*- coding: utf-8 -*-
+#
+# QEMU documentation build configuration file for the 'system' manual.
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
+html_theme_options['description'] = u'System Emulation User''s Guide'
diff --git a/docs/system/index.rst b/docs/system/index.rst
new file mode 100644
index 00000000000..ea8ea5fe3dc
--- /dev/null
+++ b/docs/system/index.rst
@@ -0,0 +1,16 @@
+.. This is the top level page for the 'system' manual.
+
+
+QEMU System Emulation User's Guide
+==================================
+
+This manual is the overall guide for users using QEMU
+for full system emulation (as opposed to user-mode emulation).
+This includes working with hypervisors such as KVM, Xen, Hax
+or Hypervisor.Framework.
+
+Contents:
+
+.. toctree::
+   :maxdepth: 2
+
-- 
2.20.1


