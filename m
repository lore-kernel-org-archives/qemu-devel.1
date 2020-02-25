Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9696EC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDF121556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="us8CBfRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDF121556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Xzl-0005rE-GM
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Xyk-0004sp-N4
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:02:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Xyg-00077N-Lz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:02:18 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6Xyg-00076F-Fi
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:02:14 -0500
Received: by mail-wr1-x42a.google.com with SMTP id g3so14142274wrs.12
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2WeRFxRDj29Rw57/hlFSEnuTXmXxVpiUVgtHYi4nBgQ=;
 b=us8CBfRkUh6PwMMzAeIMdFOve4vmfj3T4QgEXnW3tXuRY6cvWkaf0mtRJc99EgbgEZ
 jqHqcZsj7ra0MaSIj4lKjtZ9LQIvl4GcYOXppB9z+FzgrvRoVRB1OTVEs8kDc+tkkGXF
 kkYgrwNg2Iv4TmKXywNXk2thysFLCCjoHrSnZxHIqotjLOPp5/3VHwPuwUIZJUlQilrb
 VWoEHXdWMwWbgEiVRCY+5Ai9PU+s6XbNfuyEL1Xa6svd5ENno3sgacIlVDpKmsvRKwfv
 +nzqhCEwW8FrbWhfXbgrlDTn9ZiGPPIBDfsVnusrrBNq4wi6XKb0Gv8lBLTnwNo+R/3s
 Nazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2WeRFxRDj29Rw57/hlFSEnuTXmXxVpiUVgtHYi4nBgQ=;
 b=Ar8Fsd7IkiUT0tiyeIjrUF0+A2W64KAmcA/qlxzJrZKwOjLLzLZzgTYBDsH5nE2zjD
 IrE7Zb3iE/dDprGZTEjdzXbmKhqGONoQ1hSwuz+YopUkosRPGCxSHmLXuKcbcLhWByqU
 oSw1/xX6K63GfVwWDNt4c5Q6l0ltW6My4QN4lEBhpBMJNqzVfijjsiJngvENRDnyf6gE
 5HRw9CqfivI4v4ofXTTOB/KmMbgeXy20AHrgxCArl29cPJ0MamehnprleZNP4vIBXIZ6
 VLi0nzqp7ej1d2LhWp6+YosCVg8JaQcgwTUl+el6Xk5QSVaJVl//t3t3VGqM6s3RlJWJ
 Euzg==
X-Gm-Message-State: APjAAAXkOzsHCsuYQfRBzVHpM26yt/g6XbIZpqD5PvuzWFW8hghb9LOb
 wD7s8ki9GiFdiO3zpnSjvLQosUKHG30R6Q==
X-Google-Smtp-Source: APXvYqzN3GpptnWglr1sHzqpr5fi36O37NokdPsxQcInJMu9m3rCJacQn0Njs9sKw5d1z+NrVKGfDA==
X-Received: by 2002:a5d:534d:: with SMTP id t13mr76229720wrv.77.1582628530594; 
 Tue, 25 Feb 2020 03:02:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id n8sm22483092wrx.42.2020.02.25.03.02.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 03:02:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] docs: Move qemu-option-trace.rst.inc to docs/
Date: Tue, 25 Feb 2020 11:02:03 +0000
Message-Id: <20200225110204.30662-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225110204.30662-1-peter.maydell@linaro.org>
References: <20200225110204.30662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20200217155415.30949-3-peter.maydell@linaro.org
---
 Makefile                                     | 5 ++---
 docs/interop/qemu-img.rst                    | 2 +-
 docs/interop/qemu-nbd.rst                    | 2 +-
 docs/{interop => }/qemu-option-trace.rst.inc | 0
 4 files changed, 4 insertions(+), 5 deletions(-)
 rename docs/{interop => }/qemu-option-trace.rst.inc (100%)

diff --git a/Makefile b/Makefile
index c4c2eba7a7c..4a27be1cde9 100644
--- a/Makefile
+++ b/Makefile
@@ -1049,7 +1049,6 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
 build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" $(SPHINX_BUILD) $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
-              $(wildcard $(SRC_PATH)/docs/$1/*.rst.inc) \
               $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
 # Macro to write out the rule and dependencies for building manpages
 # Usage: $(call define-manpage-rule,manualname,manpage1 manpage2...[,extradeps])
@@ -1063,7 +1062,7 @@ endef
 $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
 	$(call build-manual,devel,html)
 
-$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC_PATH)/qemu-img-cmds.hx
+$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc
 	$(call build-manual,interop,html)
 
 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
@@ -1078,7 +1077,7 @@ $(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools)
 $(call define-manpage-rule,interop,\
        qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
        virtiofsd.1 virtfs-proxy-helper.1,\
-       $(SRC_PATH)/qemu-img-cmds.hx)
+       $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc)
 
 $(call define-manpage-rule,system,qemu-block-drivers.7)
 
diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
index 5f40137c100..0080f83a76c 100644
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


