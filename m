Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4EDC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F2921D7A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsjiq9QK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F2921D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqa5-0003SE-57
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVL-0006WK-2S
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:55838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVJ-0006nR-0d
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id d4so3598733wmd.5
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sj15rBZcZbKv+lDFIRDA3aSKWbqE5DeyxJYs1f/78+s=;
 b=zsjiq9QKBCY7K0vEygnVbhoAWKBjuMR/fNFmwA80AtO9oEs9XMyzyD5DChesqOi8LT
 6j35iJksBtkoklpg9RUMZHHyfnZNNl0vQAHBMj8D5TrJy8obrPqahaY2od0syyB32Gqy
 KR1kupSZNGZ5AnbRz2xEEPufT1WJeC2VMl0/fFaWOcwI54Xuzv5EpGapSrQGUr40l9ms
 cux2ydxMYnHOFM4e7exQuPRjUBt8PNPCzSbjOI9nhT6HO0aWUxr9Cj4P9LHe2NXsPY/H
 jHMq7MrU8mSFOP7Krruuatm97gRXS7yXUqRUENDSwjEhDGDg8gac6i41VQgXgPwEiW7z
 K6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sj15rBZcZbKv+lDFIRDA3aSKWbqE5DeyxJYs1f/78+s=;
 b=KzPWvXk9HXBGKn/W5EEDX8nvY71KGKmtNp1VuQ6PLprivDJScu1sDUOAVQyqRTsa7h
 LquSw5Kgy3gxAteoqRbCHB/qFJBPcrFE/m58ZaV009TAVz4CN6UIjDLaa4yg1AZI6nSS
 biOB2oO+WJytYHtF2uWrPI5oZEksDGFRHBhC8G7qS5wMu7yMpWwaaLR7d/QOMc9rAagL
 b6IXTnCBnxgYCg/C3qP5yAZ5WvoJmTvTp7S32HSJGC5buIoDtg5GfAGPGNUFUBu+MJli
 CNntg/gD2HaYmswbADouhTSvAtSx5U6rka0NOCaAZCdoUSqjCxEKrDoeVA5S1k/jVI4X
 4u+A==
X-Gm-Message-State: AOAM532MldLkDgOTOrfWJP7zi0ey12uNMsFzuIrfkXTlR+DZJC5gzBxj
 3Zrry2xk3pw1ExyMh6LVzBaEqRW3S5zs2L/7
X-Google-Smtp-Source: ABdhPJykv2BC6dB67kcxMP0frM9Ukqpw+RTiMZfkN2PBVBUIGvK5s5agvfFZ2Vernpc29axjcNzjGw==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr3925780wme.89.1601051002845;
 Fri, 25 Sep 2020 09:23:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 04/21] scripts/qapi: Move doc-comment whitespace stripping
 to doc.py
Date: Fri, 25 Sep 2020 17:22:59 +0100
Message-Id: <20200925162316.21205-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

As we accumulate lines from doc comments when parsing the JSON, the
QAPIDoc class generally strips leading and trailing whitespace using
line.strip() when it calls _append_freeform().  This is fine for
Texinfo, but for rST leading whitespace is significant.  We'd like to
move to having the text in doc comments be rST format rather than a
custom syntax, so move the removal of leading whitespace from the
QAPIDoc class to the texinfo-specific processing code in
texi_format() in qapi/doc.py.

(Trailing whitespace will always be stripped by the rstrip() in
Section::append regardless.)

In a followup commit we will make the whitespace in the lines of doc
comment sections more consistently follow the input source.

There is no change to the generated .texi files before and after this
commit.

Because the qapi-schema test checks the exact values of the
documentation comments against a reference, we need to update that
reference to match the new whitespace.  In the first four places this
is now correctly checking that we did put in the amount of whitespace
to pass a rST-formatted list to the backend; in the last two places
the extra whitespace is 'wrong' and will go away again in the
following commit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/qapi/doc.py            |  1 +
 scripts/qapi/parser.py         | 12 ++++--------
 tests/qapi-schema/doc-good.out | 12 ++++++------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 92f584edcf1..7764de1e4bc 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -79,6 +79,7 @@ def texi_format(doc):
     inlist = ''
     lastempty = False
     for line in doc.split('\n'):
+        line = line.strip()
         empty = line == ''
 
         # FIXME: Doing this in a single if / elif chain is
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 165925ca728..04bf10db378 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -427,10 +427,10 @@ class QAPIDoc:
                 self._append_line = self._append_various_line
                 self._append_various_line(line)
             else:
-                self._append_freeform(line.strip())
+                self._append_freeform(line)
         else:
             # This is a free-form documentation block
-            self._append_freeform(line.strip())
+            self._append_freeform(line)
 
     def _append_args_line(self, line):
         """
@@ -463,7 +463,7 @@ class QAPIDoc:
                 self._append_various_line(line)
             return
 
-        self._append_freeform(line.strip())
+        self._append_freeform(line)
 
     def _append_features_line(self, line):
         name = line.split(' ', 1)[0]
@@ -482,7 +482,7 @@ class QAPIDoc:
             self._append_various_line(line)
             return
 
-        self._append_freeform(line.strip())
+        self._append_freeform(line)
 
     def _append_various_line(self, line):
         """
@@ -505,10 +505,6 @@ class QAPIDoc:
             line = line[len(name)+1:]
             self._start_section(name[:-1])
 
-        if (not self._section.name or
-                not self._section.name.startswith('Example')):
-            line = line.strip()
-
         self._append_freeform(line)
 
     def _start_symbol_section(self, symbols_dict, name):
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index acb00ade17b..9993ffcd89d 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -78,20 +78,20 @@ doc freeform
 
 * List item one
 * Two, multiple
-lines
+  lines
 
 * Three
-Still in list
+  Still in list
 
 Not in list
 
 - Second list
-Note: still in list
+  Note: still in list
 
 Note: not in list
 
 1. Third list
-is numbered
+   is numbered
 
 2. another item
 
@@ -159,7 +159,7 @@ doc symbol=Alternate
 
     arg=i
 an integer
-@b is undocumented
+    @b is undocumented
     arg=b
 
     feature=alt-feat
@@ -174,7 +174,7 @@ doc symbol=cmd
 the first argument
     arg=arg2
 the second
-argument
+       argument
     arg=arg3
 
     feature=cmd-feat1
-- 
2.20.1


