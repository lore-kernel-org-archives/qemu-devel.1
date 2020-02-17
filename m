Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB9BC34025
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0EB22464
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJZRoPNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0EB22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3ijr-0001df-6Y
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:55:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3ij4-0000I8-73
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:54:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3ij2-0007bV-Js
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:54:26 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:43705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3ij2-0007bA-Cz
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:54:24 -0500
Received: by mail-wr1-x42b.google.com with SMTP id r11so20293153wrq.10
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 07:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uARvTUAfTed0ANLAB+83sxjOhOEVAWMdCK2VFJ9k4bY=;
 b=uJZRoPNcx9m0JmKZupv9fEEEhSYb9aQf/zdQ/BByKggrb0spYPgjYztIQJUD3YLTEL
 Ul3uJZipbldPELKvQUcuH6USbuDJ6jSdc6O0uoGllOUzEBuuts89Zpo0LF8aQvjO2noX
 x9dr7wC1wP9F+vJL5GVT9FD7466TocXGS0BzPI5kH0qIFs95YyYvaNETL3KKsCjGs0jl
 eGlWsTVb0LJlxcCdyjq1Sx1FiFbwysXVqN7hOCtU3GHCbcFrwSEzf+6KxGoWfUmCFey0
 4Ll8K2Xjmks7fO7d6QsBDKvYDFTnXQ8Oko1F8uQGyH+FZqjl9x/fWWkmOeN1kF1vFisx
 4gHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uARvTUAfTed0ANLAB+83sxjOhOEVAWMdCK2VFJ9k4bY=;
 b=hry3tnZiNfbpMSO70r6/W0LIWACoxtqT06fEdUR4+mICBCbTqjeIye4lV9qrgVZ62E
 OGvaqvUwxDtNDGopi83XJMzYdb/ql4Ay0T1qWy9NiF9n/ePDZAJ4WPTzdzehBzgYP2qk
 PFWhoEB/0auPPDM2bjHVN9rYBkN2I7AMnatFIaM/4jfb3zqmbaILpsDmEOLw3uH1cdrG
 jiQCyYV0vmwHS7O2A1FJWCfp6USNjTmJE327tTUbgbFCUfqN+p53pD41azbI3xJM9dmj
 QmDFv2X1+ZVyvgDWhgu0eAkKJKUDE6Oc+U21GD86Rc0Jir3Vhoq7nA6N7NKX0/Xv440h
 QkqA==
X-Gm-Message-State: APjAAAWD41B2KQZLyPaTao0nHcW0tKwmqnf3EkLi32p7WdA3gnUJyni8
 WKgy7nzO3IHKsDIlf/CYEGVChiZSl9D70A==
X-Google-Smtp-Source: APXvYqy7iwyF21R0Jklc+Hj3GDq0/FT/6bVHHILlf9azgSqUL9NoLb3XEqkvuvwHtzhXS2o9cDyW+Q==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr22933366wrw.265.1581954862875; 
 Mon, 17 Feb 2020 07:54:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q9sm1465626wrx.18.2020.02.17.07.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 07:54:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] docs: Move tools documentation to tools manual
Date: Mon, 17 Feb 2020 15:54:15 +0000
Message-Id: <20200217155415.30949-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200217155415.30949-1-peter.maydell@linaro.org>
References: <20200217155415.30949-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

Move the following tools documentation files to the new tools manual:

 docs/interop/qemu-img.rst
 docs/interop/qemu-nbd.rst
 docs/interop/virtfs-proxy-helper.rst
 docs/interop/qemu-trace-stap.rst
 docs/interop/virtiofsd.rst

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile                                      | 34 ++++++++++---------
 docs/interop/conf.py                          | 12 -------
 docs/interop/index.rst                        |  5 ---
 docs/tools/conf.py                            | 17 ++++++++++
 docs/tools/index.rst                          |  6 ++++
 docs/{interop => tools}/qemu-img.rst          |  0
 docs/{interop => tools}/qemu-nbd.rst          |  0
 docs/{interop => tools}/qemu-trace-stap.rst   |  0
 .../virtfs-proxy-helper.rst                   |  0
 docs/{interop => tools}/virtiofsd.rst         |  0
 10 files changed, 41 insertions(+), 33 deletions(-)
 rename docs/{interop => tools}/qemu-img.rst (100%)
 rename docs/{interop => tools}/qemu-nbd.rst (100%)
 rename docs/{interop => tools}/qemu-trace-stap.rst (100%)
 rename docs/{interop => tools}/virtfs-proxy-helper.rst (100%)
 rename docs/{interop => tools}/virtiofsd.rst (100%)

diff --git a/Makefile b/Makefile
index 886d4299d54..7a9c682a2c0 100644
--- a/Makefile
+++ b/Makefile
@@ -345,11 +345,11 @@ endif
 
 ifdef BUILD_DOCS
 DOCS=qemu-doc.html qemu-doc.txt qemu.1
-DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-img.1
-DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-nbd.8
+DOCS+=$(MANUAL_BUILDDIR)/tools/qemu-img.1
+DOCS+=$(MANUAL_BUILDDIR)/tools/qemu-nbd.8
 DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-ga.8
 ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
-DOCS+=$(MANUAL_BUILDDIR)/interop/virtiofsd.1
+DOCS+=$(MANUAL_BUILDDIR)/tools/virtiofsd.1
 endif
 DOCS+=$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
@@ -357,10 +357,10 @@ DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qe
 DOCS+=docs/qemu-cpu-models.7
 DOCS+=$(MANUAL_BUILDDIR)/index.html
 ifdef CONFIG_VIRTFS
-DOCS+=$(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1
+DOCS+=$(MANUAL_BUILDDIR)/tools/virtfs-proxy-helper.1
 endif
 ifdef CONFIG_TRACE_SYSTEMTAP
-DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-trace-stap.1
+DOCS+=$(MANUAL_BUILDDIR)/tools/qemu-trace-stap.1
 endif
 else
 DOCS=
@@ -848,12 +848,12 @@ ifdef CONFIG_POSIX
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
 ifeq ($(CONFIG_TOOLS),y)
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-img.1 "$(DESTDIR)$(mandir)/man1"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-img.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-nbd.8 "$(DESTDIR)$(mandir)/man8"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-nbd.8 "$(DESTDIR)$(mandir)/man8"
 endif
 ifdef CONFIG_TRACE_SYSTEMTAP
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
 endif
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
@@ -864,10 +864,10 @@ endif
 endif
 ifdef CONFIG_VIRTFS
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
-	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
 endif
 ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
-	$(INSTALL_DATA) docs/interop/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
+	$(INSTALL_DATA) docs/tools/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
 endif
 
 install-datadir:
@@ -1049,7 +1049,7 @@ endef
 $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
 	$(call build-manual,devel,html)
 
-$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc
+$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
 	$(call build-manual,interop,html)
 
 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
@@ -1058,16 +1058,18 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
 $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
 	$(call build-manual,system,html)
 
-$(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools)
+$(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools) $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc
 	$(call build-manual,tools,html)
 
-$(call define-manpage-rule,interop,\
-       qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
-       virtiofsd.1 virtfs-proxy-helper.1,\
-       $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc)
+$(call define-manpage-rule,interop,qemu-ga.8)
 
 $(call define-manpage-rule,system,qemu-block-drivers.7)
 
+$(call define-manpage-rule,tools,\
+       qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
+       virtiofsd.1 virtfs-proxy-helper.1,\
+       $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc)
+
 $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
 	@mkdir -p "$(MANUAL_BUILDDIR)"
 	$(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
index b3cda17042c..42ce7e3d365 100644
--- a/docs/interop/conf.py
+++ b/docs/interop/conf.py
@@ -19,16 +19,4 @@ html_theme_options['description'] = u'System Emulation Management and Interopera
 man_pages = [
     ('qemu-ga', 'qemu-ga', u'QEMU Guest Agent',
      ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
-    ('qemu-img', 'qemu-img', u'QEMU disk image utility',
-     ['Fabrice Bellard'], 1),
-    ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
-     ['Anthony Liguori <anthony@codemonkey.ws>'], 8),
-    ('qemu-trace-stap', 'qemu-trace-stap', u'QEMU SystemTap trace tool',
-     [], 1),
-    ('virtfs-proxy-helper', 'virtfs-proxy-helper',
-     u'QEMU 9p virtfs proxy filesystem helper',
-     ['M. Mohan Kumar'], 1),
-    ('virtiofsd', 'virtiofsd', u'QEMU virtio-fs shared file system daemon',
-     ['Stefan Hajnoczi <stefanha@redhat.com>',
-      'Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>'], 1),
 ]
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index e8455b4270c..049387ac6de 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -18,10 +18,5 @@ Contents:
    live-block-operations
    pr-helper
    qemu-ga
-   qemu-img
-   qemu-nbd
-   qemu-trace-stap
    vhost-user
    vhost-user-gpu
-   virtfs-proxy-helper
-   virtiofsd
diff --git a/docs/tools/conf.py b/docs/tools/conf.py
index 56461110b9d..9052d17d6d4 100644
--- a/docs/tools/conf.py
+++ b/docs/tools/conf.py
@@ -14,3 +14,20 @@ exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
 # the manual title to appear in the sidebar.
 html_theme_options['description'] = \
     u'Tools Guide'
+
+# One entry per manual page. List of tuples
+# (source start file, name, description, authors, manual section).
+man_pages = [
+    ('qemu-img', 'qemu-img', u'QEMU disk image utility',
+     ['Fabrice Bellard'], 1),
+    ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
+     ['Anthony Liguori <anthony@codemonkey.ws>'], 8),
+    ('qemu-trace-stap', 'qemu-trace-stap', u'QEMU SystemTap trace tool',
+     [], 1),
+    ('virtfs-proxy-helper', 'virtfs-proxy-helper',
+     u'QEMU 9p virtfs proxy filesystem helper',
+     ['M. Mohan Kumar'], 1),
+    ('virtiofsd', 'virtiofsd', u'QEMU virtio-fs shared file system daemon',
+     ['Stefan Hajnoczi <stefanha@redhat.com>',
+      'Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>'], 1),
+]
diff --git a/docs/tools/index.rst b/docs/tools/index.rst
index c5a4a13ec7a..232ce9f3e46 100644
--- a/docs/tools/index.rst
+++ b/docs/tools/index.rst
@@ -9,3 +9,9 @@ Contents:
 
 .. toctree::
    :maxdepth: 2
+
+   qemu-img
+   qemu-nbd
+   qemu-trace-stap
+   virtfs-proxy-helper
+   virtiofsd
diff --git a/docs/interop/qemu-img.rst b/docs/tools/qemu-img.rst
similarity index 100%
rename from docs/interop/qemu-img.rst
rename to docs/tools/qemu-img.rst
diff --git a/docs/interop/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
similarity index 100%
rename from docs/interop/qemu-nbd.rst
rename to docs/tools/qemu-nbd.rst
diff --git a/docs/interop/qemu-trace-stap.rst b/docs/tools/qemu-trace-stap.rst
similarity index 100%
rename from docs/interop/qemu-trace-stap.rst
rename to docs/tools/qemu-trace-stap.rst
diff --git a/docs/interop/virtfs-proxy-helper.rst b/docs/tools/virtfs-proxy-helper.rst
similarity index 100%
rename from docs/interop/virtfs-proxy-helper.rst
rename to docs/tools/virtfs-proxy-helper.rst
diff --git a/docs/interop/virtiofsd.rst b/docs/tools/virtiofsd.rst
similarity index 100%
rename from docs/interop/virtiofsd.rst
rename to docs/tools/virtiofsd.rst
-- 
2.20.1


