Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258D1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D8C22BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qoFwy4I7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D8C22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Dq8-0003dd-Vd
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Doc-0000Kw-2y
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Doa-0004kz-4p
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:37 -0400
Received: by mail-wr1-x441.google.com with SMTP id c15so9293830wrs.11
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e0cYa2LpgDtFPEx6dbDjbhZ7m+B+8SmWLGFLVWEF5JA=;
 b=qoFwy4I7lwv+KfNqEeMprNM3B5CBTEDKAzGEaq9BEcHBVUHIUXbelf85gUJdVhi71L
 W7uF8P9XFy4YETsxBRXONwXJ6Uc5ydg7itBPaZ+1mXhBoftWr4/Bih2BTHPyRVQsRJKQ
 uJcZrlpqydhjEMNUxyvQaDrUZiIMqIC7i02ypYvQKN9VBVIj/3oHb4R6VazKWs9Ex/7F
 ZR/j7RdLKVzT/DskaZgc9vZOKBfq4Npf+K40OI9T7BVCjPFZryGgqvsMvqw4XdRXzZ5X
 6ivEBmBs8oAkhqkUyZ9lhHZniv87f2WZUsn1vb0cShsLp0AfIuO5lXYKzDIBK1RJu4DG
 rZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e0cYa2LpgDtFPEx6dbDjbhZ7m+B+8SmWLGFLVWEF5JA=;
 b=RbxzIf50b8nSepOsZ3w+bWmhWsz9EHrWEvJWDTGycl7VJK8WoOEbJySuQQxhzEbKho
 JX0xfIZcUp544s/BgJlf0uJC5aYk9xzzaMCop5rSyexJpr+SFYrNv5XSgU+PdgJbmLHc
 U6m/i1b46W8fVNVpCy0hFoXrQekrygDtUVfbIUKqsmsfQSN4yNCf8sFGUQ1T0ecQD6OR
 zToJ22Sk4LMGNXRlEthE1PB8el1xA8V/QtpKSVutgd2upOKMWfAYAzRKzM/4OjnV48dQ
 n8MEMv6sQdDO1eTUCSLXqnvBN+ZaBB84TvDoB4mH9yeEsVWoRD67KWaIuiThmZU280wm
 zSCw==
X-Gm-Message-State: AOAM533+9EXrYrMIRZyvxXmRajCTqpInbnbut9AdNJBScZtf9h9qRCGA
 K+Kxe1MpUVkXSudfV6sySsI8wnUUdQP/Mw==
X-Google-Smtp-Source: ABdhPJyJJWeNeJSU1em6JiPRw8PNkcCgebBwIy1zbRFa0bNKPHIlgOYO1HzFozWR3k635T0D/xM0Xw==
X-Received: by 2002:adf:9ed4:: with SMTP id b20mr26158582wrf.206.1597089033962; 
 Mon, 10 Aug 2020 12:50:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/20] scripts/qapi: Move doc-comment whitespace stripping
 to doc.py
Date: Mon, 10 Aug 2020 20:50:06 +0100
Message-Id: <20200810195019.25427-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>
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
v4->v5: just fixed the caps in 'Texinfo' in commit message
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
index abadacbb0e8..7fae4478d34 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -417,10 +417,10 @@ class QAPIDoc:
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
@@ -453,7 +453,7 @@ class QAPIDoc:
                 self._append_various_line(line)
             return
 
-        self._append_freeform(line.strip())
+        self._append_freeform(line)
 
     def _append_features_line(self, line):
         name = line.split(' ', 1)[0]
@@ -472,7 +472,7 @@ class QAPIDoc:
             self._append_various_line(line)
             return
 
-        self._append_freeform(line.strip())
+        self._append_freeform(line)
 
     def _append_various_line(self, line):
         """
@@ -495,10 +495,6 @@ class QAPIDoc:
             line = line[len(name)+1:]
             self._start_section(name[:-1])
 
-        if (not self._section.name or
-                not self._section.name.startswith('Example')):
-            line = line.strip()
-
         self._append_freeform(line)
 
     def _start_symbol_section(self, symbols_dict, name):
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 4c24eb96486..0ef85d959ac 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -77,20 +77,20 @@ doc freeform
 
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
 
@@ -158,7 +158,7 @@ doc symbol=Alternate
 
     arg=i
 an integer
-@b is undocumented
+    @b is undocumented
     arg=b
 
     feature=alt-feat
@@ -173,7 +173,7 @@ doc symbol=cmd
 the first argument
     arg=arg2
 the second
-argument
+       argument
     arg=arg3
 
     feature=cmd-feat1
-- 
2.20.1


