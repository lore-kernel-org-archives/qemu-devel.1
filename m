Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F6BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D6921D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWF5qjup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D6921D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLh9u-0001di-9n
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 02:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1kLdaL-0003tm-SW
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 22:35:45 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b]:36118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1kLdaK-0006mE-2s
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 22:35:45 -0400
Received: by mail-qk1-x72b.google.com with SMTP id q63so1538227qkf.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 19:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ygBnasl7QoVQUKFVpcjb38zHixZE+c8N2z51GZVXIxs=;
 b=oWF5qjupA2nDJCcld3ut7W2FEH19wGGpBFXaYPN1+PUYjQJpXMUkafWm6u7ETciUw6
 tLpYt1O7+GzOzNHIwwlu3jLTO7vyL/QN8p1BykxD2BdecZ4wSFkKnp92W9LpSlLfaj1X
 xXrNCeNgds9huaZgWp/xDjhXTaIQk5LkWP1aCZukETe7b5wKw4Ghl/y6j2Glqic+acbe
 pCZvZbtSrajQm7Dzh5d6ZJRZAhthoXBc2Y5HiFn8/QYYx8y4fIl9uTOtBnJA5R2me2sF
 zbURWNLeNqoAzC2+YEiIwjeG6bDMhpHh51de8vk4Y6b/h9sbB7ZcmWeYlg31EEa2NDCo
 /AKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ygBnasl7QoVQUKFVpcjb38zHixZE+c8N2z51GZVXIxs=;
 b=Hde9pPJqe/FuAQOa1+exQ8j6nOPqwZxWIqk796HcR/63LMEZectliJIX4SjEie6eSP
 PyLqj6tsRamFkpAqsXSG1NPyJhPDDkP/xvyHs8bnzOE95MNQgtrd5DPk8g4xFNtxoXXY
 lOmTSBaM8HFE0kNpRpsYVElNx5xWlJYPYRZwAuXOAmWMU3HqeDaWQfTovCIpL2gO4o3a
 lfk7tpF0/RJy23HH4Np0vGwEn1JBcCitkWCiEKuwJV0uSbMLvYDXLgxXKuxahoTJJUZL
 +O0hvoYGwRSR8XMhZAx/7bHzf6XHwFaapWccPjYYRYiBWqdy6G1wkyYuFqzWrymlspMw
 xfuQ==
X-Gm-Message-State: AOAM532wyIlJ6/0W1IMzCkRkutkhXaaLk+kqY5UB1k1V1O4D3dICzf8x
 VKAqTdxwOZfbdt3u3mwu6uxkCdEEjYHfnQ==
X-Google-Smtp-Source: ABdhPJw92pZnoAJz+FD3L81VJXYywcl1nquMmR1Vr5776AbnB6vvwcRwxD/KVyejR49O+fp8689uAQ==
X-Received: by 2002:a37:4c15:: with SMTP id z21mr2204658qka.194.1601001342674; 
 Thu, 24 Sep 2020 19:35:42 -0700 (PDT)
Received: from localhost.localdomain (dsl-10-130-151.b2b2c.ca. [72.10.130.151])
 by smtp.gmail.com with ESMTPSA id g19sm906131qka.84.2020.09.24.19.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 19:35:42 -0700 (PDT)
From: Maxim Cournoyer <maxim.cournoyer@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5.1.0] build: Build and install the info manual.
Date: Thu, 24 Sep 2020 22:36:30 -0400
Message-Id: <20200925023630.26301-1-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=maxim.cournoyer@gmail.com; helo=mail-qk1-x72b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2020 02:23:43 -0400
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
Cc: Maxim Cournoyer <maxim.cournoyer@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Take advantage of the Sphinx texinfo backend to generate a QEMU info
manual.  The texinfo format allows for more structure and info readers
provide more advanced navigation capabilities compared to manpages
readers.

* configure (infodir): Add the --infodir option, which allows
configuring the directory under which the info manuals are installed.
* docs/index.rst: Include the top level documents to prevent
warnings (treated as errors by sphinx-build).
* Makefile (sphinxdocs-info, $(MANUAL_BUILDDIR)/QEMU.texi)): New targets.
(info): Depend on sphinxdocs-info.
(install-doc): Install the info manual.
---
 Makefile       | 13 +++++++++++--
 configure      |  7 +++++++
 docs/index.rst |  2 ++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 13dd708c4a..da78612d85 100644
--- a/Makefile
+++ b/Makefile
@@ -864,12 +864,14 @@ endef
 # Note that we deliberately do not install the "devel" manual: it is
 # for QEMU developers, and not interesting to our users.
 .PHONY: install-sphinxdocs
-install-sphinxdocs: sphinxdocs
+install-sphinxdocs: sphinxdocs sphinxdocs-info
 	$(call install-manual,interop)
 	$(call install-manual,specs)
 	$(call install-manual,system)
 	$(call install-manual,tools)
 	$(call install-manual,user)
+	$(INSTALL_DIR) "$(DESTDIR)$(infodir)"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/QEMU.info "$(DESTDIR)$(infodir)"
 
 install-doc: $(DOCS) install-sphinxdocs
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
@@ -1067,6 +1069,13 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
             $(MANUAL_BUILDDIR)/tools/index.html \
             $(MANUAL_BUILDDIR)/user/index.html
 
+# Build the complete info manual.
+.PHONE: sphinxdocs-info
+sphinxdocs-info: $(MANUAL_BUILDDIR)/QEMU.info
+
+$(MANUAL_BUILDDIR)/QEMU.texi: $(call manual-deps,*) $(wildcard $(SRC_PATH)/docs/*.rst)
+	$(call build-manual,,texinfo)
+
 # Canned command to build a single manual
 # Arguments: $1 = manual name, $2 = Sphinx builder ('html' or 'man')
 # Note the use of different doctree for each (manual, builder) tuple;
@@ -1126,7 +1135,7 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
 	@cp -p $< $@
 
 html: docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
-info: docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
+info: docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info sphinxdocs-info
 pdf: docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
 txt: docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 
diff --git a/configure b/configure
index 2acc4d1465..3691bd2e0c 100755
--- a/configure
+++ b/configure
@@ -415,6 +415,7 @@ LDFLAGS_SHARED="-shared"
 modules="no"
 module_upgrades="no"
 prefix="/usr/local"
+infodir="\${prefix}/share/info"
 mandir="\${prefix}/share/man"
 datadir="\${prefix}/share"
 firmwarepath="\${prefix}/share/qemu-firmware"
@@ -987,6 +988,7 @@ if test "$mingw32" = "yes" ; then
     LIBS="-liberty $LIBS"
   fi
   prefix="c:/Program Files/QEMU"
+  infodir="\${prefix}"
   mandir="\${prefix}"
   datadir="\${prefix}"
   qemu_docdir="\${prefix}"
@@ -1087,6 +1089,8 @@ for opt do
     static="yes"
     QEMU_PKG_CONFIG_FLAGS="--static $QEMU_PKG_CONFIG_FLAGS"
   ;;
+  --infodir=*) infodir="$optarg"
+  ;;
   --mandir=*) mandir="$optarg"
   ;;
   --bindir=*) bindir="$optarg"
@@ -1780,6 +1784,7 @@ Advanced options (experts only):
   --smbd=SMBD              use specified smbd [$smbd]
   --with-git=GIT           use specified git [$git]
   --static                 enable static build [$static]
+  --infodir=PATH           install info manual in PATH
   --mandir=PATH            install man pages in PATH
   --datadir=PATH           install firmware in PATH$confsuffix
   --docdir=PATH            install documentation in PATH$confsuffix
@@ -6836,6 +6841,7 @@ echo "include directory $(eval echo $includedir)"
 echo "config directory  $(eval echo $sysconfdir)"
 if test "$mingw32" = "no" ; then
 echo "local state directory   $(eval echo $local_statedir)"
+echo "Info manual directory   $(eval echo $infodir)"
 echo "Manual directory  $(eval echo $mandir)"
 echo "ELF interp prefix $interp_prefix"
 else
@@ -7059,6 +7065,7 @@ echo "bindir=$bindir" >> $config_host_mak
 echo "libdir=$libdir" >> $config_host_mak
 echo "libexecdir=$libexecdir" >> $config_host_mak
 echo "includedir=$includedir" >> $config_host_mak
+echo "infodir=$infodir" >> $config_host_mak
 echo "mandir=$mandir" >> $config_host_mak
 echo "sysconfdir=$sysconfdir" >> $config_host_mak
 echo "qemu_confdir=$qemu_confdir" >> $config_host_mak
diff --git a/docs/index.rst b/docs/index.rst
index 763e3d0426..4f155b51d7 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -9,6 +9,7 @@ Welcome to QEMU's documentation!
 .. toctree::
    :maxdepth: 2
    :caption: Contents:
+   :glob:
 
    system/index
    user/index
@@ -16,3 +17,4 @@ Welcome to QEMU's documentation!
    interop/index
    specs/index
    devel/index
+   *
-- 
2.28.0


