Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA30C47420
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1696420738
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqioRCOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1696420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqcX-0007A0-1G
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVJ-0006TG-VM
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:25 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:39036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVH-0006nA-JY
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id b79so3925128wmb.4
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=28aaJgz0ty8/sYEIPpfI2vKzBd+chPmkWk9I0NSqY4U=;
 b=WqioRCOfWLsxsp81/p2JCCxH1vqj5S3zAWscXOPyGvgr/qp+0bSAIvFNasVTZGr9z2
 zIGIafMq3D6fkr9zIiLmk8jhWGMcDFtgxRzmQutigVMuxa9uJnjRNhx7IGmZT+Dg/aNA
 uOibvBQRdDSzvDviWzWiMTG91WQvBGZiQ7KAu+d+fCPRcJ36lmGgkufz8nFiB9cvN7b3
 xm/MPCNE3cFXlwziiNdKmDGCA6F0GDMRu55kiBWC1N1Up9HdzxowKr01ZjXl6UWaMAq3
 GVML4bu/Xt3lK6lpmWPbF5xb0BSBHaLVsKgDSAJ2pIa+RboV0STP9jweR9gjqcra5Q2L
 bkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=28aaJgz0ty8/sYEIPpfI2vKzBd+chPmkWk9I0NSqY4U=;
 b=l8BJDfDAMon4/gAeGSjLbyAyqR0I53Jrxyk9UaYYLoNKCQ4f4jxL5TLEGdMbqFBYy6
 wiSTHCuQWU39vs4iFtPvHUOSNkhOSSLfXuuFV1OtpBPLV91Sf2K/dnjXJ3+kcUzQw51x
 O38QcUMfHfuKGmsYHVu5OXaM15FvTjYYdbOFETcmLQAqzd/J7nTSmaz/bNYAeNcRMCsW
 zDTSA3s/WXvH55BRE1z0Dqht8E6lvHTgBH2w5lI2hIzcdo6AXNrzgo0ob+6tgkaQBHg0
 ZyvtjGSn8Xt16IUytjvseJn/W7S4HPv7MmR1Si5iD9fP6NPcGtPS8awCLXBDT8GMLB5J
 hRgQ==
X-Gm-Message-State: AOAM5308b7IjB5dd09b0D4Z8UrsFuhFlynyio+0+grQcquH4CkJBsyDD
 IAf+Nbl8iLkIBjR5+MZjcJbRG8/QScVBjQnr
X-Google-Smtp-Source: ABdhPJzuET/4bR0sH1/ZLRz0mNavC3ja8ssuIBCfbEss0x71t/OGFP07cEcjnl80WVq1GDa1yU1lnQ==
X-Received: by 2002:a1c:9c8c:: with SMTP id f134mr3950038wme.27.1601051001790; 
 Fri, 25 Sep 2020 09:23:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 03/21] tests/qapi/doc-good.json: Prepare for qapi-doc
 Sphinx extension
Date: Fri, 25 Sep 2020 17:22:58 +0100
Message-Id: <20200925162316.21205-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

doc-good.json tests doc comment parser corner cases.  We're about to
largely replace it by a Sphinx extension, which will have different
corner cases.  Tweak the test so it passes both with the old parser
and the Sphinx extension, by making it match the more restrictive
rST syntax:

 * in a single list the bullet types must all match
 * lists must have leading and following blank lines
 * the rules on when and where indentation matters differ
 * the '|' example syntax is going to go away entirely, so stop
   testing it

This will avoid the tests spuriously breaking when we tighten up the
parser code in the following commits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qapi-schema/doc-good.json | 25 +++++++++++++------------
 tests/qapi-schema/doc-good.out  | 12 ++++++------
 tests/qapi-schema/doc-good.texi | 12 +++---------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 9da72a1f556..c6822145c49 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -12,25 +12,25 @@
 #
 # *strong* _with emphasis_
 # @var {in braces}
+#
 # * List item one
-# - Two, multiple
+# * Two, multiple
 #   lines
 #
-# 3. Three
-# Still in list
+# * Three
+#   Still in list
+#
+# Not in list
 #
-#   Not in list
 # - Second list
-# Note: still in list
+#   Note: still in list
 #
 # Note: not in list
+#
 # 1. Third list
 #    is numbered
 #
-# - another item
-#
-# | example
-# | multiple lines
+# 2. another item
 #
 # Returns: the King
 # Since: the first age
@@ -68,7 +68,7 @@
 ##
 # @Base:
 # @base1:
-#   the first member
+# the first member
 ##
 { 'struct': 'Base', 'data': { 'base1': 'Enum' } }
 
@@ -116,7 +116,7 @@
 ##
 # @Alternate:
 # @i: an integer
-# @b is undocumented
+#     @b is undocumented
 #
 # Features:
 # @alt-feat: a feature
@@ -134,7 +134,7 @@
 # @arg1: the first argument
 #
 # @arg2: the second
-# argument
+#        argument
 #
 # Features:
 # @cmd-feat1: a feature
@@ -143,6 +143,7 @@
 # Returns: @Object
 # TODO: frobnicate
 # Notes:
+#
 # - Lorem ipsum dolor sit amet
 # - Ut enim ad minim veniam
 #
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index d78a424cd9d..acb00ade17b 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -75,25 +75,25 @@ doc freeform
 
 *strong* _with emphasis_
 @var {in braces}
+
 * List item one
-- Two, multiple
+* Two, multiple
 lines
 
-3. Three
+* Three
 Still in list
 
 Not in list
+
 - Second list
 Note: still in list
 
 Note: not in list
+
 1. Third list
 is numbered
 
-- another item
-
-| example
-| multiple lines
+2. another item
 
 Returns: the King
 Since: the first age
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index 7f28fb7a0fb..12808989ffb 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -6,6 +6,7 @@
 
 @strong{strong} @emph{with emphasis}
 @code{var} @{in braces@}
+
 @itemize @bullet
 @item
 List item one
@@ -20,6 +21,7 @@ Still in list
 @end itemize
 
 Not in list
+
 @itemize @minus
 @item
 Second list
@@ -28,6 +30,7 @@ Note: still in list
 @end itemize
 
 Note: not in list
+
 @enumerate
 @item
 Third list
@@ -36,15 +39,6 @@ is numbered
 @item
 another item
 
-@example
-example
-@end example
-
-@example
-multiple lines
-@end example
-
-
 @end enumerate
 
 Returns: the King
-- 
2.20.1


