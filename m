Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDB5C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64AFD21D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JrLqcbFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AFD21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdfz-0002LW-E6
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdM2-0001HH-Fo
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:50 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLz-0006dN-H1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:50 -0500
Received: by mail-wm1-x32a.google.com with SMTP id 205so2472310wma.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KnPXJ6NqptesuWN0QOJA3/7JLRDcQ5MPX9LbhM6n5G4=;
 b=JrLqcbFGMBk3yfGooxAODLMRIsLrQ2y2MW+X8r/4W5pIPI6dGQhVdVy/hFEwjKEuho
 tiSLZnw/5CFJAAjBgaPRiTChn/Bt6htSknaDCnww+0mo81aj2MMfgl5sIcZ9YgCj8+jw
 AQCB1CwaQP6k+e0a6bQD+HZ7VdlVtB0HshLH+x5GLI+BA8HGgYglw4veFYR7qxX5m2l9
 I88gkIxrPRCuchtRrXpKtQ7DyS3BLhsmBle6/mDPesa6v2rONlwTbXwE88yR58ZZRefQ
 dr8xXBhur/9f6bwVZhZ8b+19m3YyR7sOyH1UBjeQCeNW+Ch5gUvjl9bVYLKi69yrwQMJ
 viRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KnPXJ6NqptesuWN0QOJA3/7JLRDcQ5MPX9LbhM6n5G4=;
 b=MU9d0rxkAE+G/kKGzpzjfAS8HKe4R1UeZH+3XpZIwK23IlOAz7UQwYI1GuGDiEW1ts
 W74ZTlG0P75+u/pe9QxkJjHUa/mvxuP+Nw2fQqArwjEa4SlKQEyUp1UPv6EuZDUJaMuN
 UJRadTBnnx8OtYOZw3HtmP8uqDEi57N085kiyBtbeFxG81GVY/D/cHo2+s8nVWSTroaB
 3FP2UI7XsD3s1ZpameiK1YA52M+tKlgS/UlxFqKKeCkQpTm1Xvyw6UJhcGXX5oTcR+m4
 qevXicJtnqZ4M4LpMFv3IWagkw6H/UZAW+0E++NK6/zeUrKAxMm3Avkhkombm+pYa8Xa
 LEyA==
X-Gm-Message-State: AOAM532Mh4j11B75DJsuLdv/FFrene4+miCxAvOpHsjlv/McyU1znqqc
 JlSQugiFPIj/qsF22pNfB1nf1QcmNPJnmg==
X-Google-Smtp-Source: ABdhPJzUlHkgxwrN3ysatg0fgf/GBQRFk8S0qZA+HCh9FPJjQVhw7OHuzn5dZTlhINSd7G0w4UdoGA==
X-Received: by 2002:a1c:5946:: with SMTP id n67mr3550105wmb.162.1604337045863; 
 Mon, 02 Nov 2020 09:10:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/26] scripts/kerneldoc: For Sphinx 3 use c:macro for macros
 with arguments
Date: Mon,  2 Nov 2020 17:10:03 +0000
Message-Id: <20201102171005.30690-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20201030174700.7204-2-peter.maydell@linaro.org
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


