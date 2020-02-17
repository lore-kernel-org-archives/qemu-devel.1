Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425FCC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1532064C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkMX4Kbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1532064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3il0-0003kZ-75
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3ij2-0000EG-A7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3ij1-0007aa-2f
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:54:24 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:39446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3ij0-0007aB-Sq
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:54:23 -0500
Received: by mail-wm1-x32f.google.com with SMTP id c84so19026132wme.4
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 07:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6hI0n20giRzzyVfmQ+VBLXwlFrGhiyF16wKxV55G/0g=;
 b=NkMX4Kbl7cCq3zYZP8DTzWESHJPYbPAO27gzdVcyyfQMgvIQCfP6A4EB1KcL+N9PXc
 hJD4Ru5NiOBKEYCWeL7eZnYTKAzoq7Ik6KNlUSpUtH/N3yjeb05fBcGfdq2o2wGjNgGH
 o6buvHZGuGP2x//Rj4Ac4VnbxJ/ksdPc8deupP/TRuwk41W872O0PszHuuOcAHj3iL7l
 CgVybJbaKM2ibBBTKnzuheLgiPX2hJR+4h+jXktAcjL28xxvPbLil2GzzqZk9sDiGjBo
 WW6YfGiFKHFgn+aG5ILH6fJYO36rAUEmM4Yy9k+UPexE0ouWM1LeqcXhh/wbSSUgMNXu
 fqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6hI0n20giRzzyVfmQ+VBLXwlFrGhiyF16wKxV55G/0g=;
 b=MIyFvLWKc4fk5vtxv3ClFGN2aa5LGAX/17Vx9XYDDqpnXRiY7occK5Ls7E+7O6APU3
 cy5YgwKm6Jwjo/GzuiiXUYIrM1QEN1xJjY04vhVg/krUTer0ulig5Kwf9UwrU3RMZpsB
 iar3yErpqvAZidzCw9RwhBHCfC3BaGgzK+CHRhK8f2Z8eftZ7J6uLOYi79revE/O/g9M
 xhCbUnmrOlV38WbZpGhqkKgvJK7eOdUOFk5/aS5kP7HFaRWldI2CdQdtIJ0bTsDXRrRk
 6m7bq5wzxuZWPf0PYgWOsZC5YPuh+Xvd2jou7LFpCXiVhc9YGupFn05+agT6KgpaQdeD
 DLyw==
X-Gm-Message-State: APjAAAVan2Y9AZsw4IJ7EbmC784LidCKqU7laC8TP2Y7fJjNv6aEg/yd
 o0AigTSrJ/AEpq1TIhYcJ7s8012pXrdSTw==
X-Google-Smtp-Source: APXvYqwjqh7QxCf0PS64C/vfBFDtW59A/gWmvKGhseqHmRPTR39sleAE1s3EDlpaaFscbfRMXoIjDQ==
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr24004846wmf.189.1581954861632; 
 Mon, 17 Feb 2020 07:54:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q9sm1465626wrx.18.2020.02.17.07.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 07:54:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] docs: Move qemu-option-trace.rst.inc to docs/
Date: Mon, 17 Feb 2020 15:54:14 +0000
Message-Id: <20200217155415.30949-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200217155415.30949-1-peter.maydell@linaro.org>
References: <20200217155415.30949-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

The qemu-option-trace.rst.inc file contains a rST documentation
fragment which describes trace options common to qemu-nbd and
qemu-img.  We put this file into interop/, but we'd like to move the
qemu-nbd and qemu-img files into the tools/ manual.  We could move
the .rst.inc file along with them, but we're eventually going to want
to use it for the main QEMU binary options documentation too, and
that will be in system/.  So move qemu-option-trace.rst.inc to the
top-level docs/ directory, where all these files can include it via

   .. include:: ../qemu-option-trace.rst.inc

This does have the slight downside that we now need to explicitly
tell Make which manuals use this file rather than relying on
a wildcard for all .rst.inc in the manual.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile                                     | 5 ++---
 docs/interop/qemu-img.rst                    | 2 +-
 docs/interop/qemu-nbd.rst                    | 2 +-
 docs/{interop => }/qemu-option-trace.rst.inc | 0
 4 files changed, 4 insertions(+), 5 deletions(-)
 rename docs/{interop => }/qemu-option-trace.rst.inc (100%)

diff --git a/Makefile b/Makefile
index ceb85f67c4b..886d4299d54 100644
--- a/Makefile
+++ b/Makefile
@@ -1036,7 +1036,6 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
 build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" $(SPHINX_BUILD) $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
-              $(wildcard $(SRC_PATH)/docs/$1/*.rst.inc) \
               $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
 # Macro to write out the rule and dependencies for building manpages
 # Usage: $(call define-manpage-rule,manualname,manpage1 manpage2...[,extradeps])
@@ -1050,7 +1049,7 @@ endef
 $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
 	$(call build-manual,devel,html)
 
-$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC_PATH)/qemu-img-cmds.hx
+$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc
 	$(call build-manual,interop,html)
 
 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
@@ -1065,7 +1064,7 @@ $(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools)
 $(call define-manpage-rule,interop,\
        qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
        virtiofsd.1 virtfs-proxy-helper.1,\
-       $(SRC_PATH)/qemu-img-cmds.hx)
+       $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc)
 
 $(call define-manpage-rule,system,qemu-block-drivers.7)
 
diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
index 42e4451db4a..b6cab449750 100644
--- a/docs/interop/qemu-img.rst
+++ b/docs/interop/qemu-img.rst
@@ -34,7 +34,7 @@ Standard options:
 
 .. option:: -T, --trace [[enable=]PATTERN][,events=FILE][,file=FILE]
 
-  .. include:: qemu-option-trace.rst.inc
+  .. include:: ../qemu-option-trace.rst.inc
 
 The following commands are supported:
 
diff --git a/docs/interop/qemu-nbd.rst b/docs/interop/qemu-nbd.rst
index e5484031005..667861cb22e 100644
--- a/docs/interop/qemu-nbd.rst
+++ b/docs/interop/qemu-nbd.rst
@@ -188,7 +188,7 @@ driver options if ``--image-opts`` is specified.
 
 .. option:: -T, --trace [[enable=]PATTERN][,events=FILE][,file=FILE]
 
-  .. include:: qemu-option-trace.rst.inc
+  .. include:: ../qemu-option-trace.rst.inc
 
 Examples
 --------
diff --git a/docs/interop/qemu-option-trace.rst.inc b/docs/qemu-option-trace.rst.inc
similarity index 100%
rename from docs/interop/qemu-option-trace.rst.inc
rename to docs/qemu-option-trace.rst.inc
-- 
2.20.1


