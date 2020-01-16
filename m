Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356D6C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30CB2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kc3nHDz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30CB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is5yU-0003Zy-UA
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1is5vc-0000EJ-B2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:15:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1is5va-0006lH-OD
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:15:20 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1is5va-0006kP-IL
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:15:18 -0500
Received: by mail-wr1-x436.google.com with SMTP id w15so19350086wru.4
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 06:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dfwkptdMPu/C9yAOU7ujCDeXXt0/3/ztxjQs/BryDaQ=;
 b=kc3nHDz/EMAp88zh7+QW3zB+ExGdngiPE7QjT+GCZWyfEb7a3aek5y7vowkGQlS26Z
 uW6vEb3G1NIHV0EMO1az/5JgsrtGit2RQyiGejHvSm8RLVrp7x+P0oFmGRJC4qDm8rVU
 oA3WGK5Wx+kOy+u6WrdvL8Rn24khYy6ww513SpWatf9e7Va2CrQYZhLfEr8Vd8IDNz5L
 /7wLj47NMX4kPLrlGB5NX2GHV6BOaDHcwKUtSeOvYTbWz4C+sdfnofyEFIyN3UVQ2k2Q
 oq7NLjw+CA61RKbiio8MoeOYs2eqOOKmekR+qCtfRDgLxPIyttZs86HW5Fa4wgkeOX5f
 HGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dfwkptdMPu/C9yAOU7ujCDeXXt0/3/ztxjQs/BryDaQ=;
 b=t7JrxmTsOk9fxKukYDuFIfjfi/PM82Djqayvtf5r6UVl1C2Rfz4OQLDWIKCzsQJRZT
 u497mWTGnGRpFF8TL7tCznNcX8woXSPN2dyLwTKnhGgIMh6SoH1SVfVoB/MOh/Tebr5S
 kPeSTTPUjD6YWlHY4atj7ARxlE940PW2THrMll3IwwDFq8EkbEtaVEUCfvwQlUODGy5T
 jQH0ewcdkMSsosnVyOR2ItazeG5Qa+pr5f+5DgC73AED/aiANR1/kZNbYuklXlMeaieJ
 n1t+JMDMo3UK6oQQ2BhZ3sYkuRRZEL5WtkZxGFDBnwl7afWgDP6urqz66CBol4WFgfIX
 ixuA==
X-Gm-Message-State: APjAAAUS0i/7nx+14283xdjWKBbQTYcCQ/RDdpF7rBUXZdEIyAc2we/+
 MHxrNVa7wlRlokKXGLepUETxnazd1mtBCw==
X-Google-Smtp-Source: APXvYqzCcHaDH+c8lL7oTYD4whLTSribHiGxj5WafLzQpvX+woeFUm3CD0rok/RcFnxkirY+2UylvQ==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr3542210wrv.108.1579184117235; 
 Thu, 16 Jan 2020 06:15:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 25sm4584169wmi.32.2020.01.16.06.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 06:15:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] docs: Create stub system manual
Date: Thu, 16 Jan 2020 14:15:10 +0000
Message-Id: <20200116141511.16849-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116141511.16849-1-peter.maydell@linaro.org>
References: <20200116141511.16849-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want a user-facing manual which contains system emulation
documentation. Create an empty one which we can populate.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile              | 10 +++++++++-
 docs/system/conf.py   | 15 +++++++++++++++
 docs/system/index.rst | 16 ++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/conf.py
 create mode 100644 docs/system/index.rst

diff --git a/Makefile b/Makefile
index 7a8a50d8700..4372d0d1fbd 100644
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


