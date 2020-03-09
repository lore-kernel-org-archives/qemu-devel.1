Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE44CC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1F5208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGoLeNuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1F5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKh9-0004SP-Pc
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZw-00025V-Ov
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZv-0001Ts-3b
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:28 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBKZu-0001T5-Sl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:27 -0400
Received: by mail-wm1-x341.google.com with SMTP id m3so18490wmi.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AtxEKrKRqNjfOrT9JbNHlMjgTudjr9VoMdnqfaiOYHo=;
 b=TGoLeNuEJ/TkzEEkucpSjmr87po1trVzN4R2j50DSb4Hru8kMGvalx697qakamPQd2
 5FXyUw8LXPqyjzsOMN+bpgQFLz5X4Shs+OXR5h/d4ORCyw3m5OJnSb/20blOUZGg+OAd
 J4EYKcgkjP69lvVpZbYGy77oKP1PZFv8Twroi8q8E/iK3KY90ND1PsSq1DQu1ih0Khv2
 6rNW5xpmyrOg9trLjm2fQBJKc25b5ZZ4QcE8NtB2C17KrIcn4mvxZ/ANb/44mlJZptx6
 2Xq9S22CuvZjQQQzekwsF7bIAc4oZjGfhwQKZblYsQIZqHd+mQG9NoTuTPxIJMeqnOE4
 bGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AtxEKrKRqNjfOrT9JbNHlMjgTudjr9VoMdnqfaiOYHo=;
 b=ZtDEbGqrXB6il6Gz5N2NOKUByxOv24I/42t4c5VGWMVnq754zOQItcWtEvTgJSw52S
 KKfWEVp82B0lUP6pNRyF6WQerlNQ0gZC2/JH0jXDG79ba02iRNMmH7ctyJAk/oJS2XJV
 ZxdBaNi3R/GgpF/8Hq/k+HnRw6njRoeSv0lt3vLMxiTxOAZCbXnLwQ760D7aB0XkKxns
 APAKI8y1hLevssUfQiLEIHP5WczW8ezTih5OobL1tnOg2zWh33yYIOswVZPyFRen2mwv
 nIv74wz5oSi4YD6bFAN6XmOqKDgepKIbvxsV1cAfiSqDC3fCsy+EZVi23AEa7eZsLy2t
 BAQA==
X-Gm-Message-State: ANhLgQ1FPEl+AWhTDBYwMo/Nb98rMw63HQ3yaWSF/c1PVgAtgYJU1Uuu
 obbkWqRSmi0TnqGf8akIZXZPTN39gOQ4dg==
X-Google-Smtp-Source: ADFU+vuGhX+RwyBU5IWua38XiGPf4N2victvAnVK+6ufOjq79v0h38BjQfQ0PIHfc32OgHXXDRsZsw==
X-Received: by 2002:a05:600c:22cd:: with SMTP id
 13mr13157162wmg.186.1583768665188; 
 Mon, 09 Mar 2020 08:44:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm25932166wmd.44.2020.03.09.08.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 08:44:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/18] docs/devel/qapi-code-gen.txt: Update to new rST
 backend conventions
Date: Mon,  9 Mar 2020 15:44:00 +0000
Message-Id: <20200309154405.13548-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309154405.13548-1-peter.maydell@linaro.org>
References: <20200309154405.13548-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the documentation of QAPI document comment syntax to match
the new rST backend requirements. The principal changes are:
 * whitespace is now significant, and multiline definitions
   must have their second and subsequent lines indented to
   match the first line
 * general rST format markup is permitted, not just the small
   set of markup the old texinfo generator handled. For most
   things (notably bulleted and itemized lists) the old format
   is the same as rST was.
 * Specific things that might trip people up:
   - instead of *bold* and _italic_ rST has **bold** and *italic*
   - lists need a preceding and following blank line
   - a lone literal '*' will need to be backslash-escaped to
     avoid a rST syntax error
 * the old leading '|' for example (literal text) blocks is
   replaced by the standard rST '::' literal block.
 * headings and subheadings must now be in a freeform
   documentation comment of their own
 * we support arbitrary levels of sub- and sub-sub-heading, not
   just a main and sub-heading like the old texinfo generator

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/qapi-code-gen.txt | 90 ++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 59d6973e1ec..688eb2a0237 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -795,21 +795,39 @@ See below for more on definition documentation.
 Free-form documentation may be used to provide additional text and
 structuring content.
 
+==== Headings and subheadings ====
+
+A free-form documentation comment containing a single line
+which starts with some '=' symbols and then a space defines
+a section heading:
+
+    ##
+    # = This is a top level heading
+    ##
+
+    ##
+    # This is a free-form comment which will go under the
+    # top level heading.
+    ##
+
+    ##
+    # == This is a second level heading
+    ##
+
+Section headings must always be correctly nested, so you can only
+define a third-level heading inside a second-level heading, and so
+on. The documentation generator will catch nesting mistakes and report
+a syntax error.
 
 ==== Documentation markup ====
 
-Comment text starting with '=' is a section title:
+Documentation comments can use most rST markup. In particular,
+a '::' literal block can be used for examples:
 
-    # = Section title
-
-Double the '=' for a subsection title:
-
-    # == Subsection title
-
-'|' denotes examples:
-
-    # | Text of the example, may span
-    # | multiple lines
+    # ::
+    #
+    #   Text of the example, may span
+    #   multiple lines
 
 '*' starts an itemized list:
 
@@ -825,37 +843,35 @@ A decimal number followed by '.' starts a numbered list:
     #    multiple lines
     # 2. Second item
 
-The actual number doesn't matter.  You could even use '*' instead of
-'2.' for the second item.
+The actual number doesn't matter.
 
-Lists can't be nested.  Blank lines are currently not supported within
-lists.
+Lists of either kind must be preceded and followed by a blank line.
+If a list item's text spans multiple lines, then the second and
+subsequent lines must be correctly indented to line up with the
+first character of the first line.
 
-Additional whitespace between the initial '#' and the comment text is
-permitted.
-
-*foo* and _foo_ are for strong and emphasis styles respectively (they
-do not work over multiple lines).  @foo is used to reference a name in
-the schema.
+The usual '**strong**', '*emphasised*' and '``literal``' markup should
+be used. If you need a single literal '*' you will need to backslash-escape it.
+As an extension beyond the usual rST syntax, you can also
+use '@foo' to reference a name in the schema; this is rendered
+the same way as '``foo``'.
 
 Example:
 
 ##
-# = Section
-# == Subsection
-#
-# Some text foo with *strong* and _emphasis_
+# Some text foo with **bol** and *emphasis*
 # 1. with a list
 # 2. like that
 #
 # And some code:
-# | $ echo foo
-# | -> do this
-# | <- get that
 #
+# ::
+#
+#   $ echo foo
+#   -> do this
+#   <- get that
 ##
 
-
 ==== Definition documentation ====
 
 Definition documentation, if present, must immediately precede the
@@ -870,6 +886,12 @@ commands and events), member (for structs and unions), branch (for
 alternates), or value (for enums), and finally optional tagged
 sections.
 
+Descriptions of arguments can span multiple lines; if they
+do then the second and subsequent lines must be indented
+to line up with the first character of the first line of the
+description. The parser will report a syntax error if there
+is insufficient indentation.
+
 FIXME: the parser accepts these things in almost any order.
 FIXME: union branches should be described, too.
 
@@ -883,6 +905,16 @@ The section ends with the start of a new section.
 A 'Since: x.y.z' tagged section lists the release that introduced the
 definition.
 
+The text of a section can start on a new line, in
+which case it must not be indented at all. It can also start
+on the same line as the 'Note:', 'Returns:', etc tag. In this
+case if it spans multiple lines then second and subsequent
+lines must be indented to match the first.
+
+An 'Example' or 'Examples' section is automatically rendered
+entirely as literal fixed-width text. In other sections,
+the text is formatted, and rST markup can be used.
+
 For example:
 
 ##
-- 
2.20.1


