Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EADC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C73120A8B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xW0Tgk+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C73120A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYVG-0006fR-Dt
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 13:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYYUW-0005pJ-1x
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:47:08 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:38931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYYUU-0002cE-BJ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:47:07 -0400
Received: by mail-wm1-x330.google.com with SMTP id d3so3697260wma.4
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 10:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=28SgNa3EluWUvbAzV8yhw6h4WUxhavGJS1xTF5jSc7o=;
 b=xW0Tgk+/e+5YCX0etdavOkr/d5VuOH9G3UcNn82btAN4Id6xUf8FMny0JvRKi6w2P6
 sPIHcRjOBP7r3B5uYqfv3nKy4vcstoPGv3W6TjW5wA3Nfm5j55+vt0JsiYz3YhasuQ4R
 j+9B2S0NX37bPNCCmzkjYHhCFHbFcIoTFRfZDjNqpJloK1N2EHY7Zfddn1wZMa9OQnpz
 B7PpPlwl77Ge6qfWxyrpH2gF+DkvNUpQ5Ms13yXowKPz9V2aL7himQjtEKk+NRAYzcNl
 /vM9suF9NIJ/1YI0uPrOQrR/EdO+PGL2cWLht8FPA8djsHP/FCjDV3CkWz3q6uHs5v78
 xaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=28SgNa3EluWUvbAzV8yhw6h4WUxhavGJS1xTF5jSc7o=;
 b=AtQAt8Fc3x0NobxedpXDssTwmSg61+GAFVLyiw7Mh/o3ogPowrku3N4KREWcbcQycl
 u7P4dg1KI46GexYHFhwr5XniAosiqJ3XLnqdeZXMkgpBbn4DKCFGklUDbLbBkWygWvf6
 Rnedhw+eOqyJjAbE9ffxQmFk359izdqHni/AJzWN/j6udbuO8rdNsxvV2Y1SQUBRnFqL
 juMKSKJCPkQCOoNhEl4ayy4Qs3IkDJd1gpKjUDiXUqzwCVzQrsEUXdJXjW/A8H664GII
 YqHNBXpnfSiQXFdsGxhP/+HwYNIucANcG1lBwPk5jvLnp9nZPW3G10cIUNgiy9NtVRO8
 lvUA==
X-Gm-Message-State: AOAM530PUSXZDV3uurN2WB/hjX99Bac1L0EoX57ZGJ9M+tDZUtfdnHUd
 YX/sXUNJ3HXsqgyb7HnqGnGcQD0aKsd/hg==
X-Google-Smtp-Source: ABdhPJzaToe3/QPz8pUIe9JSbB7FQ5LCgGznWmd9BUzygqdEPlxVFULsxHLAmQf9+eWbKLGHbJYKlg==
X-Received: by 2002:a05:600c:218a:: with SMTP id
 e10mr3899763wme.7.1604080024164; 
 Fri, 30 Oct 2020 10:47:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 1sm12522655wre.61.2020.10.30.10.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 10:47:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] scripts/kerneldoc: For Sphinx 3 use c:macro for macros
 with arguments
Date: Fri, 30 Oct 2020 17:46:59 +0000
Message-Id: <20201030174700.7204-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201030174700.7204-1-peter.maydell@linaro.org>
References: <20201030174700.7204-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kerneldoc script currently emits Sphinx markup for a macro with
arguments that uses the c:function directive. This is correct for
Sphinx versions earlier than Sphinx 3, where c:macro doesn't allow
documentation of macros with arguments and c:function is not picky
about the syntax of what it is passed. However, in Sphinx 3 the
c:macro directive was enhanced to support macros with arguments,
and c:function was made more picky about what syntax it accepted.

When kerneldoc is told that it needs to produce output for Sphinx
3 or later, make it emit c:function only for functions and c:macro
for macros with arguments. We assume that anything with a return
type is a function and anything without is a macro.

This fixes the Sphinx error:

/home/petmay01/linaro/qemu-from-laptop/qemu/docs/../include/qom/object.h:155:Error in declarator
If declarator-id with parameters (e.g., 'void f(int arg)'):
  Invalid C declaration: Expected identifier in nested name. [error at 25]
    DECLARE_INSTANCE_CHECKER ( InstanceType,  OBJ_NAME,  TYPENAME)
    -------------------------^
If parenthesis in noptr-declarator (e.g., 'void (*f(int arg))(double)'):
  Error in declarator or parameters
  Invalid C declaration: Expecting "(" in parameters. [error at 39]
    DECLARE_INSTANCE_CHECKER ( InstanceType,  OBJ_NAME,  TYPENAME)
    ---------------------------------------^

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/kernel-doc | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 0ff62bb6a2d..4fbaaa05e38 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -839,7 +839,23 @@ sub output_function_rst(%) {
 	output_highlight_rst($args{'purpose'});
 	$start = "\n\n**Syntax**\n\n  ``";
     } else {
-	print ".. c:function:: ";
+        if ((split(/\./, $sphinx_version))[0] >= 3) {
+            # Sphinx 3 and later distinguish macros and functions and
+            # complain if you use c:function with something that's not
+            # syntactically valid as a function declaration.
+            # We assume that anything with a return type is a function
+            # and anything without is a macro.
+            if ($args{'functiontype'} ne "") {
+                print ".. c:function:: ";
+            } else {
+                print ".. c:macro:: ";
+            }
+        } else {
+            # Older Sphinx don't support documenting macros that take
+            # arguments with c:macro, and don't complain about the use
+            # of c:function for this.
+            print ".. c:function:: ";
+        }
     }
     if ($args{'functiontype'} ne "") {
 	$start .= $args{'functiontype'} . " " . $args{'function'} . " (";
-- 
2.20.1


