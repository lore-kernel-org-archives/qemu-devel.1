Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92238C34024
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6102422525
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWfZavEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6102422525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3ijl-0001Sw-J2
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3ij1-0000Bv-9l
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:54:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3ij0-0007a0-1T
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:54:23 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:41512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3iiz-0007ZZ-Ra
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:54:21 -0500
Received: by mail-wr1-x434.google.com with SMTP id c9so20362471wrw.8
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 07:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CxKFlXsnQYhsWYWx6B12C8s0P7Rfc/lRy7Ey0zj8/uo=;
 b=oWfZavEHVAlA7oXC33ISZFvdaeTk2/oRRUg/omJpVuGWsAoaLTSfJY4M1PYpq+m6r+
 SCFwyJNRUPEp5CghFMyvGpetwDhxtBGqrXfm597xCn1c2qyYOCFPaSjkYK3GgDSPPHQy
 snkiGumDp9Z1u1KgJGUmehNGbAxvpN2vChZlR3S2ILAoDgbrd31V2Ef7fI59CS4wzt5a
 du/+A+ZSTntg2lNs2EbxZ0XogPtWyVLrOsKLEsztSPdApkntDUoizvhWCW1cDf90f2QI
 CPAcU/ilH1oxc9J5jccbKnVoZTkrhQ+SuUxopp94/BuK4Z+s2T04AfdHtnPZk1W8jdHz
 i9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CxKFlXsnQYhsWYWx6B12C8s0P7Rfc/lRy7Ey0zj8/uo=;
 b=Mi7QBglEAY5H0ljmI2ZU7aYUkqj7Owv8yI3bnEF9/5yku3DszlQ6ML6Tf2fIyhZCmB
 hSlxn1E2vIHHYRgyHmc/24uomSPCT9fjNMMShNpJHgd9BVkWSLFpcX/GjEhN6BB+qHcd
 Xnfveam4GogGVQzp9LvQGcF2hBaxG2KQhZ9cCcRcPzyk/ZAflLkd7jP82B+eP6QKi7v9
 R1vRp3/mGu//7bYG6Q/kIbsWSEf2U7yBp5HeQbgrE5xh95x0ygLUWIl98vunPwQX4doW
 RBzUVipJaZEUmVP75uN2JQYgeP2Dm/w0gui+Jg9NRLuCg8BsGeXS6SW0vMeHTWxU5KLj
 tZnw==
X-Gm-Message-State: APjAAAXM1zzrQNt5qOzbf8oj1rxeJCzCZcTQSKObK5HlEc3OXE9RVr7T
 UDkdtBwerUdCj77oqBq6BDoPcBPcj+PFhQ==
X-Google-Smtp-Source: APXvYqy2p1r0hfwOfNL9cUfxVqjI8B6A2W7jUL7S+tzkeJvvjQNnWQKBvcx6sbbQFr9hKJdUy05nHA==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr22149470wru.382.1581954860158; 
 Mon, 17 Feb 2020 07:54:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q9sm1465626wrx.18.2020.02.17.07.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 07:54:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] docs: Create new 'tools' manual
Date: Mon, 17 Feb 2020 15:54:13 +0000
Message-Id: <20200217155415.30949-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200217155415.30949-1-peter.maydell@linaro.org>
References: <20200217155415.30949-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the documentation for QEMU "tools" which are standalone
binaries like qemu-img is an awkward fit in our current 5-manual
split. We've put it into "interop", but they're not really
about interoperability.

Create a new top level manual "tools" which will be a better
home for this documentation. This commit creates an empty
initial manual; we will move the relevant documentation
files in a subsequent commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile             |  8 +++++++-
 docs/index.html.in   |  1 +
 docs/index.rst       |  1 +
 docs/tools/conf.py   | 16 ++++++++++++++++
 docs/tools/index.rst | 11 +++++++++++
 5 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 docs/tools/conf.py
 create mode 100644 docs/tools/index.rst

diff --git a/Makefile b/Makefile
index b5a7377cb18..ceb85f67c4b 100644
--- a/Makefile
+++ b/Makefile
@@ -773,6 +773,7 @@ distclean: clean
 	$(call clean-manual,interop)
 	$(call clean-manual,specs)
 	$(call clean-manual,system)
+	$(call clean-manual,tools)
 	for d in $(TARGET_DIRS); do \
 	rm -rf $$d || exit 1 ; \
         done
@@ -830,6 +831,7 @@ install-sphinxdocs: sphinxdocs
 	$(call install-manual,interop)
 	$(call install-manual,specs)
 	$(call install-manual,system)
+	$(call install-manual,tools)
 
 install-doc: $(DOCS) install-sphinxdocs
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
@@ -1023,7 +1025,8 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
 sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
             $(MANUAL_BUILDDIR)/interop/index.html \
             $(MANUAL_BUILDDIR)/specs/index.html \
-            $(MANUAL_BUILDDIR)/system/index.html
+            $(MANUAL_BUILDDIR)/system/index.html \
+            $(MANUAL_BUILDDIR)/tools/index.html
 
 # Canned command to build a single manual
 # Arguments: $1 = manual name, $2 = Sphinx builder ('html' or 'man')
@@ -1056,6 +1059,9 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
 $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
 	$(call build-manual,system,html)
 
+$(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools)
+	$(call build-manual,tools,html)
+
 $(call define-manpage-rule,interop,\
        qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
        virtiofsd.1 virtfs-proxy-helper.1,\
diff --git a/docs/index.html.in b/docs/index.html.in
index 8512933d145..cf61b1cf448 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -13,6 +13,7 @@
             <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
             <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
             <li><a href="system/index.html">System Emulation User's Guide</a></li>
+            <li><a href="tools/index.html">Tools Guide</a></li>
         </ul>
     </body>
 </html>
diff --git a/docs/index.rst b/docs/index.rst
index 46405d4f077..acd604fa8a9 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -14,3 +14,4 @@ Welcome to QEMU's documentation!
    devel/index
    specs/index
    system/index
+   tools/index
diff --git a/docs/tools/conf.py b/docs/tools/conf.py
new file mode 100644
index 00000000000..56461110b9d
--- /dev/null
+++ b/docs/tools/conf.py
@@ -0,0 +1,16 @@
+# -*- coding: utf-8 -*-
+#
+# QEMU documentation build configuration file for the 'tools' manual.
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
+    u'Tools Guide'
diff --git a/docs/tools/index.rst b/docs/tools/index.rst
new file mode 100644
index 00000000000..c5a4a13ec7a
--- /dev/null
+++ b/docs/tools/index.rst
@@ -0,0 +1,11 @@
+.. This is the top level page for the 'tools' manual
+
+
+QEMU Tools Guide
+================
+
+
+Contents:
+
+.. toctree::
+   :maxdepth: 2
-- 
2.20.1


