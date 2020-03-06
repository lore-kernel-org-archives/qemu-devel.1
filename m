Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47A0C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9241A2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmuHnI0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9241A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAB03-0001r9-Nc
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAs0-0003Un-T4
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAArz-0004tg-EE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:20 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:52273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAArz-0004rF-4w
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:19 -0500
Received: by mail-wm1-x32b.google.com with SMTP id p9so1929455wmc.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=mNOrUoT3bCfvO4OZzuFjnUHE7wBwBkiVahftIHFPTTM=;
 b=lmuHnI0bglwEBcFtkRwVjXGwrrlhKmC5wG68+MUYhEfPktIL+q+xOgJfCGa80+LY5B
 a70Nw3xuorHOkiV7ptwXb3j3+EuZaQrttNyEMrWyK20iS0bhIxpiBXMCK1sGKDo+1O69
 rWJBCEFhEaqH7fFgiVoGe/LrITnbB63Zn3HULWc/Q9bCE0syZXsV3pm0NWlYnaAc48gE
 OCk7jq5ph+7fqGrUDbX0qyyYluLxT+zxckiQ6zPN5ZCERfp0fn1ryBH//p0xsixpwZXU
 E3CoOVtrISCixu7NUbiYJTT3HejMWjuOOG3j13sSqF7wEZda+t9QdnYfHwkJaFvl3hcu
 eKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mNOrUoT3bCfvO4OZzuFjnUHE7wBwBkiVahftIHFPTTM=;
 b=LIVnG3twv/JKLkKw0/HCRPvMfJepPiUD6WWpq/4sY27QUnsxE6xWSilT2LkF8MKx1P
 66Ph+DRg34cqw3pl/Vs8nshmY7EjJprd6hudu3Imfp+0sOXpeupbW6gzrJGJRSS85K5I
 gNUvP2PW6h3FwodXRss2cLSc4fyRt21qrzfAFAFahKF67hv03wyF6taCI7uXRpc4lrV+
 VJ6Tnya9qPmAPHS/vmWeXToUTcDVWiyMUNe6qCV9m8l1nJzLhh5ZD3JynX905C9fjCa+
 dzrVMSta54HKASrGXbakorbABZTl+J7OjhC/ss8TmkTTSbDz2M3yiHaR66O7oLc5b0Yk
 /iOA==
X-Gm-Message-State: ANhLgQ3eWXOnK1Tv0Ynbt8k0+PKwP+DnqNM5C9VN/tZP8aV8ZdwT5VwF
 kM+8vYTopbsoDV9BiJGY3YmAmd+P/k+r0A==
X-Google-Smtp-Source: ADFU+vv8Qwt/O707rM3+VmTZm+RQ9UXca8KRtq4xT3N8Hk+v5CRTkQpiJCSz+jdDgxQAQ8ZvkjND4g==
X-Received: by 2002:a1c:9dc9:: with SMTP id g192mr1580529wme.48.1583493016865; 
 Fri, 06 Mar 2020 03:10:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/33] qemu-doc: move qemu-tech.texi into main section
Date: Fri,  6 Mar 2020 11:09:36 +0000
Message-Id: <20200306110959.29461-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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

From: Paolo Bonzini <pbonzini@redhat.com>

The only remaining content in qemu-tech.texi is a few paragraphs
about managed start up options.  Move them in the main section
about full system emulation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200228153619.9906-11-peter.maydell@linaro.org
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


