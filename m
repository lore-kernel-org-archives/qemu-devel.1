Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5DBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5C1246AC
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1R00FOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5C1246AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hx7-0004Gz-QL
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hhS-0001no-O5
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hhR-0005B5-BU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:14 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:55018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hhR-0005AY-4t
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:13 -0500
Received: by mail-wm1-x331.google.com with SMTP id z12so3617355wmi.4
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KZqjVn+qMnkasneI7ZXq95Cdi2Za+tgcJ/H/2tX6ZEg=;
 b=g1R00FOvoNcCfJIm9+LBN/r3inqntGOd4ry1fzwynYR7dJ9uSrb/vhWn5QSKzMhdPo
 4ueBdmGWG9t5OHFogEUP5L1+/jeqouTpOFgZqg3le27A+9gqXqBcrmcONyCpb8Am9URp
 Qw7xXDQ72GTO9/vB7xrR1w11tIgF/tcm6lsRWNlFnIpsYnqvhIfh1z+ApXcPeyQqcJxM
 317D5Mm9BzvFlMYKHxO9Rkf73PsEnCcswKLYov6mYYSh8wBkHrTw20QSHWuRRf/Pd5br
 7R4yh6Bd2YNycrZVCldeoau0fcsZZE0ZnQwIE9srkjnMovDZYG4Q0XtRWGFXfpIgp21R
 UN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KZqjVn+qMnkasneI7ZXq95Cdi2Za+tgcJ/H/2tX6ZEg=;
 b=Fi5DHSYIlTxRlXbJNs9hDN43Q07jGzcqa+PqDMEMZ7e8WKMSCpBXJEg0c7l+8G6WUA
 MiB5XnVaze+yQbRtDpU6kRxOjXdnKiWaTc2WaxCbZmxxCGtIs8eqwSkHCuTtFUXhVXZN
 QXMWR59tZJlbU53/5iwAj2cL8NOKJAxeM1T4G+e+9KTCpPThkUUhTlBcCi7GqI4XZQaJ
 qUVqLbtUx96JBf8ROk+QC8pvpKfVjQqlRstRv0UvyqQI5a8gJVWXZCNqSBZqcp94jy2o
 zRM+GDBTyrE/rDF4ZVe82Hn1TvrchAXV/jgXkBb258fZh7o5QeJ3djEukFQ/GUsNCp5F
 6mAA==
X-Gm-Message-State: APjAAAVijq/YrTnWQrIWsgQn66WgOQUTgzLar+pDbWCKvaYU+P2K8HF8
 Al/Osmhf9G2VXk2G9IMHnbf9kD0f3VT4OA==
X-Google-Smtp-Source: APXvYqzIOKrrTxmnAl+JSCgGlFeRAJFIFfXVMZVzQaour/jOys5/JK+9caZ3oStFi30JwOF/j5xUHA==
X-Received: by 2002:a7b:c778:: with SMTP id x24mr5610241wmk.59.1582904229823; 
 Fri, 28 Feb 2020 07:37:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:37:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 29/33] docs: Generate qemu.1 manpage with Sphinx
Date: Fri, 28 Feb 2020 15:36:15 +0000
Message-Id: <20200228153619.9906-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Generate the qemu.1 manpage using Sphinx; we do this with a new
top-level rst source file which is just the skeleton of the manpage
and which includes .rst.inc fragments where it needs to incorporate
sections from the larger HTML manuals.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile                     | 10 ++++----
 docs/system/conf.py          |  2 ++
 docs/system/qemu-manpage.rst | 45 ++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 6 deletions(-)
 create mode 100644 docs/system/qemu-manpage.rst

diff --git a/Makefile b/Makefile
index f7d08997dbf..ef10b9a031d 100644
--- a/Makefile
+++ b/Makefile
@@ -344,7 +344,8 @@ MANUAL_BUILDDIR := docs
 endif
 
 ifdef BUILD_DOCS
-DOCS=qemu-doc.html qemu-doc.txt qemu.1
+DOCS=qemu-doc.html qemu-doc.txt
+DOCS+=$(MANUAL_BUILDDIR)/system/qemu.1
 DOCS+=$(MANUAL_BUILDDIR)/tools/qemu-img.1
 DOCS+=$(MANUAL_BUILDDIR)/tools/qemu-nbd.8
 DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-ga.8
@@ -856,7 +857,7 @@ install-doc: $(DOCS) install-sphinxdocs
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)"
 ifdef CONFIG_POSIX
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
-	$(INSTALL_DATA) qemu.1 "$(DESTDIR)$(mandir)/man1"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
@@ -1082,7 +1083,7 @@ $(MANUAL_BUILDDIR)/user/index.html: $(call manual-deps,user)
 
 $(call define-manpage-rule,interop,qemu-ga.8)
 
-$(call define-manpage-rule,system,qemu-block-drivers.7 qemu-cpu-models.7)
+$(call define-manpage-rule,system,qemu.1 qemu-block-drivers.7 qemu-cpu-models.7)
 
 $(call define-manpage-rule,tools,\
        qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
@@ -1109,9 +1110,6 @@ docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
 	@cp -p $< $@
 
-qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
-qemu.1: docs/system/qemu-option-trace.texi
-
 html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
 info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
 pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
diff --git a/docs/system/conf.py b/docs/system/conf.py
index 23cab3fb364..6251849fefc 100644
--- a/docs/system/conf.py
+++ b/docs/system/conf.py
@@ -17,6 +17,8 @@ html_theme_options['description'] = u'System Emulation User''s Guide'
 # One entry per manual page. List of tuples
 # (source start file, name, description, authors, manual section).
 man_pages = [
+    ('qemu-manpage', 'qemu', u'QEMU User Documentation',
+     ['Fabrice Bellard'], 1),
     ('qemu-block-drivers', 'qemu-block-drivers',
      u'QEMU block drivers reference',
      ['Fabrice Bellard and the QEMU Project developers'], 7),
diff --git a/docs/system/qemu-manpage.rst b/docs/system/qemu-manpage.rst
new file mode 100644
index 00000000000..e9a25d0680f
--- /dev/null
+++ b/docs/system/qemu-manpage.rst
@@ -0,0 +1,45 @@
+:orphan:
+
+..
+   This file is the skeleton for the qemu.1 manpage. It mostly
+   should simply include the .rst.inc files corresponding to the
+   parts of the documentation that go in the manpage as well as the
+   HTML manual.
+
+Title
+=====
+
+Synopsis
+--------
+
+.. parsed-literal::
+
+   |qemu_system| [options] [disk_image]
+
+Description
+-----------
+
+.. include:: target-i386-desc.rst.inc
+
+Options
+-------
+
+disk_image is a raw hard disk image for IDE hard disk 0. Some targets do
+not need a disk image.
+
+.. hxtool-doc:: qemu-options.hx
+
+.. include:: keys.rst.inc
+
+.. include:: mux-chardev.rst.inc
+
+Notes
+-----
+
+.. include:: device-url-syntax.rst.inc
+
+See also
+--------
+
+The HTML documentation of QEMU for more precise information and Linux
+user mode emulator invocation.
-- 
2.20.1


