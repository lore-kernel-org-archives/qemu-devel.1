Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4F7C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4BD2469D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByUseoSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4BD2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hjj-0005rP-7N
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hgy-0000lm-0T
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hgw-0004qa-Fy
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:43 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:36973)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hgw-0004pa-7y
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:42 -0500
Received: by mail-wm1-x330.google.com with SMTP id a141so3661284wme.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U862vG7Fdl7BX8Wv4FvC5jN5hJ6A7muzrQ44SVHcxuw=;
 b=ByUseoSOIV4EYF4gE6bsE8Wk2gVbWE2GUYk3kWGnJJxwVMtI2+6LuBnhMLfoc9nmMB
 nbnzPQQwyZgmZYVRg9ZDfT2LYtSIe0Wh5rWEFRntcYhOXQqEBuNSOLuJaenOqAez6SlX
 xZO/oWzvXZu4KHmAIS1KxKxKPIMeRUFq181ykm2v0e2fMeE6g0ALVN41CHnEOGnGzIyt
 xMd+4VoHYdiV/wO5idMISabFjXt8LnHW6BLbkmr0hRP7qK14GL43qmZPJZBg7S4H716b
 lARhn7Kgpo/b3VtDILTldsRTq0pELYntpLknnr1hdrLpyumZJEZTQTGojs3B4yXw0Cz4
 /4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U862vG7Fdl7BX8Wv4FvC5jN5hJ6A7muzrQ44SVHcxuw=;
 b=Ef8l0Vt6UVxuHZtxaVuxgNNM2VaLQ/UC6JNqhR4C5fftMESDlcMAVlYsvOQwbLkObt
 WeysD6C2NJw9LxSpGNwmBSAspJvUUYGpZ3/JV4qqdISu7VNXN4tIyyHjFWUDd1ZCOn5Y
 LKfQ2/m+X6rUfxXhP4vDRPpT1G/XEg6xoZV0uJvYZ4Gs+I9rjTyiI/PW5aPC8I6m5ZhB
 Sv994U4XIOil/vZr8ThI997nGnqb+78MHNYsSvPx6UUVwknDo+Ny8bD+Q6eotZ0pCEXO
 dNXlgH8pE9DZkf6CxYYYZ81jto1XGAaQWfEh0maghdGFBJlXxLXbiOiz3d0/fx5fuup0
 /GeA==
X-Gm-Message-State: APjAAAXNZ9mJB3KUC/uX4sVbxpVTMqEJRq5ZusQt/m4VW+u8algvtq88
 3mMa3al1W7cBs6rzKDrOz+VOFBPdqAB/pA==
X-Google-Smtp-Source: APXvYqxWHquSklRyy1mHnSN1+abaUT8RNkvZ/imfTbVHPG9zkBgqTX3jMA6NlZ7M9bjoiC18GLsl8w==
X-Received: by 2002:a1c:5684:: with SMTP id k126mr5440101wmb.181.1582904200154; 
 Fri, 28 Feb 2020 07:36:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:36:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/33] qemu-doc: move included files to docs/system
Date: Fri, 28 Feb 2020 15:35:57 +0000
Message-Id: <20200228153619.9906-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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

From: Paolo Bonzini <pbonzini@redhat.com>

Since qemu-doc.texi is mostly including files from docs/system,
move the existing include files there for consistency.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20200226113034.6741-12-pbonzini@redhat.com
[PMM: update MAINTAINERS line for qemu-option-trace.texi]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile                                                  | 8 ++++----
 MAINTAINERS                                               | 5 +++--
 qemu-deprecated.texi => docs/system/deprecated.texi       | 0
 .../system/qemu-option-trace.texi                         | 0
 docs/{ => system}/security.texi                           | 0
 qemu-doc.texi                                             | 4 ++--
 qemu-options.hx                                           | 2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)
 rename qemu-deprecated.texi => docs/system/deprecated.texi (100%)
 rename qemu-option-trace.texi => docs/system/qemu-option-trace.texi (100%)
 rename docs/{ => system}/security.texi (100%)

diff --git a/Makefile b/Makefile
index 56382a45936..7e60a435426 100644
--- a/Makefile
+++ b/Makefile
@@ -1110,7 +1110,7 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
 	@cp -p $< $@
 
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
-qemu.1: qemu-option-trace.texi
+qemu.1: docs/system/qemu-option-trace.texi
 docs/system/qemu-cpu-models.7: docs/system/qemu-cpu-models.texi docs/system/cpu-models-x86.texi docs/system/cpu-models-mips.texi
 
 html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
@@ -1120,8 +1120,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-options.texi \
-	qemu-option-trace.texi \
-	qemu-deprecated.texi qemu-monitor.texi \
+	qemu-monitor.texi \
 	qemu-monitor-info.texi \
         docs/system/quickstart.texi \
         docs/system/invocation.texi \
@@ -1140,7 +1139,8 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
         docs/system/build-platforms.texi \
         docs/system/license.texi \
 	docs/system/cpu-models-x86.texi docs/system/cpu-models-mips.texi \
-	docs/security.texi
+	docs/system/deprecated.texi docs/system/qemu-option-trace.texi \
+	docs/system/security.texi
 
 docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
     docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
diff --git a/MAINTAINERS b/MAINTAINERS
index 8c6d8f533ce..74b025fb806 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2232,7 +2232,7 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
 S: Maintained
 F: trace/
 F: trace-events
-F: qemu-option-trace.texi
+F: docs/system/qemu-option-trace.texi
 F: scripts/tracetool.py
 F: scripts/tracetool/
 F: scripts/qemu-trace-stap*
@@ -2802,7 +2802,8 @@ F: contrib/gitdm/*
 
 Incompatible changes
 R: libvir-list@redhat.com
-F: qemu-deprecated.texi
+F: docs/system/deprecated.texi
+F: docs/system/deprecated.rst
 
 Build System
 ------------
diff --git a/qemu-deprecated.texi b/docs/system/deprecated.texi
similarity index 100%
rename from qemu-deprecated.texi
rename to docs/system/deprecated.texi
diff --git a/qemu-option-trace.texi b/docs/system/qemu-option-trace.texi
similarity index 100%
rename from qemu-option-trace.texi
rename to docs/system/qemu-option-trace.texi
diff --git a/docs/security.texi b/docs/system/security.texi
similarity index 100%
rename from docs/security.texi
rename to docs/system/security.texi
diff --git a/qemu-doc.texi b/qemu-doc.texi
index e4bff7edbee..d3e743719ab 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -189,9 +189,9 @@ various targets are mentioned in the following sections.
 @include docs/system/target-m68k.texi
 @include docs/system/target-xtensa.texi
 
-@include docs/security.texi
+@include docs/system/security.texi
 
-@include qemu-deprecated.texi
+@include docs/system/deprecated.texi
 
 @include docs/system/build-platforms.texi
 
diff --git a/qemu-options.hx b/qemu-options.hx
index ac315c1ac45..5fbfa2797cb 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4221,7 +4221,7 @@ HXCOMM This line is not accurate, as some sub-options are backend-specific but
 HXCOMM HX does not support conditional compilation of text.
 @item -trace [[enable=]@var{pattern}][,events=@var{file}][,file=@var{file}]
 @findex -trace
-@include qemu-option-trace.texi
+@include docs/system/qemu-option-trace.texi
 ETEXI
 DEF("plugin", HAS_ARG, QEMU_OPTION_plugin,
     "-plugin [file=]<file>[,arg=<string>]\n"
-- 
2.20.1


