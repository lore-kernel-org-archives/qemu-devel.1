Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56063C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA0C20684
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgzPXx8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA0C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hl1-0000UA-6t
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hgw-0000iv-F1
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hgu-0004pD-E0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:42 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:56004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hgu-0004om-7o
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:40 -0500
Received: by mail-wm1-x32e.google.com with SMTP id q9so3601947wmj.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5mqiLofDp/L60BXQJA+re7pBGl6lJhGCyMOeQLGbGDE=;
 b=HgzPXx8ocuRr834uUW2Pv3p+GnMe2tnWC3Q8xTPJ0CbT3qdkXA4AYL7pcCi8UOpPkU
 HOKvlI2z7gU+eYxmb8U3+zJBnDwpkFBSY23KhhHDfqKwAugSjQHK6Ltt6sw6AriClo0h
 omL6EX8FJ5uMMPnE/0FnuwJA9Qs2lG+wW/teX19byhXeE5tBxE4WVut3rTgp8MtUG5/M
 r68VJUpyM6JW/HoTZz6AuBNlRjMBNA+fxCVgT81eetXWdXKp08KHT45BDWq1Ta6Ctswp
 Y1VWZS2HD6MCgZCbob6r/mE9bGCSXZQ9A3sVMVPaEKiqasgzs2UbPWvTQt1ZJqH+d6QM
 fhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5mqiLofDp/L60BXQJA+re7pBGl6lJhGCyMOeQLGbGDE=;
 b=jluCA2Pgby0Y724wF0LzJXUb12wVvU2nVoEQ1PiG9C4jatjkxPRIY3GPXebwNSHdN0
 DlVgT6fQYxi2XGykOk2xzyT9gMyULU6ucQLJ4t8nt19OCycBXyPuBAJsuwaNOqt7jJXG
 VY6++4+S5Vx/jH7btPdGmiZylCXksizMc9USbEiUMyRl4RHUIaVMqly9HZyYZe8TZ9gP
 spZEPtwUhxFdpOYGKj/MPRK/lKSLGXpmUh9UkMVRWDWjuro0m+0E2j8iX6yDrPISJYMX
 CChPmOCUX6Ar3pizya6kbaj9ZnNdL0Vn2gLaVSlE+CU82/m0l0lHxIPTzmCIxEu+aFdb
 3nMw==
X-Gm-Message-State: APjAAAXeUnyIt5N03BlR+98GySeNCNeVXSD1WQJs/AXtuCv7mb8o2Uy/
 JbIPWpkGuWLBFLm7cVFtD81SY+AQ74qUSg==
X-Google-Smtp-Source: APXvYqz5GwSuT7ztCitfhAN3YNUZtP6tuXx/XFFHtLNkim6Ji4sftz1J3BMaqCxX0AvJk+X25Q+hVQ==
X-Received: by 2002:a1c:ddd7:: with SMTP id u206mr5219831wmg.164.1582904198992; 
 Fri, 28 Feb 2020 07:36:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:36:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/33] qemu-doc: move qemu-tech.texi into main section
Date: Fri, 28 Feb 2020 15:35:56 +0000
Message-Id: <20200228153619.9906-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

The only remaining content in qemu-tech.texi is a few paragraphs
about managed start up options.  Move them in the main section
about full system emulation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20200226113034.6741-11-pbonzini@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile                                           | 2 +-
 qemu-tech.texi => docs/system/managed-startup.texi | 9 +--------
 qemu-doc.texi                                      | 5 ++---
 3 files changed, 4 insertions(+), 12 deletions(-)
 rename qemu-tech.texi => docs/system/managed-startup.texi (92%)

diff --git a/Makefile b/Makefile
index 9790a0fd15b..56382a45936 100644
--- a/Makefile
+++ b/Makefile
@@ -1120,7 +1120,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-options.texi \
-	qemu-tech.texi qemu-option-trace.texi \
+	qemu-option-trace.texi \
 	qemu-deprecated.texi qemu-monitor.texi \
 	qemu-monitor-info.texi \
         docs/system/quickstart.texi \
diff --git a/qemu-tech.texi b/docs/system/managed-startup.texi
similarity index 92%
rename from qemu-tech.texi
rename to docs/system/managed-startup.texi
index 35da6a40af1..ec168095cc4 100644
--- a/qemu-tech.texi
+++ b/docs/system/managed-startup.texi
@@ -1,11 +1,4 @@
-@node Implementation notes
-@appendix Implementation notes
-
-@menu
-* Managed start up options::
-@end menu
-
-@node Managed start up options
+@node managed_startup
 @section Managed start up options
 
 In system mode emulation, it's possible to create a VM in a paused state using
diff --git a/qemu-doc.texi b/qemu-doc.texi
index f702dce4557..e4bff7edbee 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -39,7 +39,6 @@
 * QEMU System emulator::
 * QEMU System emulator targets::
 * Security::
-* Implementation notes::
 * Deprecated features::
 * Recently removed features::
 * Supported build platforms::
@@ -144,6 +143,7 @@ accelerator is required to use more than one host CPU for emulation.
 * vnc_security::       VNC security
 * network_tls::        TLS setup for network services
 * gdb_usage::          GDB usage
+* managed_startup::    Managed startup options
 @end menu
 
 @include docs/system/quickstart.texi
@@ -159,6 +159,7 @@ accelerator is required to use more than one host CPU for emulation.
 @include docs/system/vnc-security.texi
 @include docs/system/tls.texi
 @include docs/system/gdb.texi
+@include docs/system/managed-startup.texi
 
 @node QEMU System emulator targets
 @chapter QEMU System emulator targets
@@ -190,8 +191,6 @@ various targets are mentioned in the following sections.
 
 @include docs/security.texi
 
-@include qemu-tech.texi
-
 @include qemu-deprecated.texi
 
 @include docs/system/build-platforms.texi
-- 
2.20.1


