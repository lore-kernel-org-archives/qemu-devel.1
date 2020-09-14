Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F85C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F206F2074B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CyETJ6tG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F206F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHp92-00041k-19
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp89-000282-NJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:53 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:37004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp87-0007Xp-La
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id a9so200258wmm.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=z3+dVa+XKMSVJBjdjYmI3jiS50/vtSpLwi7l2pD3ZbU=;
 b=CyETJ6tG4l2WaL0ShSbjSeN6zvQeFzt2lLBwqPZw/eRFLACg2ZZ0Dy2necqHOZMQPL
 mr7IJ/NE/YI9NcqK2FwWtHMj7owa/vMvgg2x9Txrrd2zk1vWV0tG6qnGHYWTcOlqdKWA
 b9ZrKIpyi63IZq7+jR2DOCv7RuRfMJfDDW+KoA5yymmv25ugY4ivIQ1Vhdl43EgXL2gv
 lgIJKW3dkvvxaOtqIJiJvKwrxEK0XFMdKEhFEb4Rf5nrWaHs0sMmNvMK/qCzD07FfzBL
 eMgY5W7haZExlCCNkQo1oqULO93oGNpaozkiO2XQlNEc8yCEAQK/0sRvRAvw5fNqdayJ
 AYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z3+dVa+XKMSVJBjdjYmI3jiS50/vtSpLwi7l2pD3ZbU=;
 b=CNjjeSfVwCSF1ac5KuyC1aIU3hiJeAKV3sLqAIBzXwCVY3vWR20rKbViouwAAecN15
 m6EMnpw6spx04KcDAYGRIijI6PzPG18i6e28EIzE53Ce/eEzJWsjj09j8FX4+Eatd3nj
 AiKFNcknP5uD4EF3lcA1LwvNfQknleRswk5xktf5iaSjxFqnkMP3l1GNP+vJhyTEwWJn
 qcj9xu34j01P5ZDBiQmhY5cqOe2bPSp/1MATfWFYlLERWwouTE+XZiCEeuURCcvTTEcO
 NsZvdS9+yg0FtLjRzCL9S8/JPFgsAq+g9chezRsuxdLRIYJS834yD8yQ6QVuC4mVhA7e
 H3Tg==
X-Gm-Message-State: AOAM533knmn/LrsqHt4EWC+MghpwTmUAuKK4pt0b+DyFQHb5t3/ID/qJ
 uFZraiZcX0QYav0Lj3909wRmPn11FkZ4/U4c
X-Google-Smtp-Source: ABdhPJwURO2UDlj2k5AELrLZsa/xMzbM0Onoqm3h//l/wrVn21yTQ+iDl2FxPzIQL70ZjfN+gDOcjA==
X-Received: by 2002:a1c:80d7:: with SMTP id
 b206mr15193802wmd.161.1600092409880; 
 Mon, 14 Sep 2020 07:06:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/36] decodetree: Improve identifier matching
Date: Mon, 14 Sep 2020 15:06:11 +0100
Message-Id: <20200914140641.21369-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Only argument set members have to be C identifiers, everything
else gets prefixed during conversion to C.  Some places just
checked the leading character, and some places matched a leading
character plus a C identifier.

Convert everything to match full identifiers, including the
[&%@&] prefix, and drop the full C identifier requirement.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200903192334.1603773-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/decode/succ_ident1.decode |  7 +++++
 scripts/decodetree.py           | 46 +++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 16 deletions(-)
 create mode 100644 tests/decode/succ_ident1.decode

diff --git a/tests/decode/succ_ident1.decode b/tests/decode/succ_ident1.decode
new file mode 100644
index 00000000000..f15cfbe1470
--- /dev/null
+++ b/tests/decode/succ_ident1.decode
@@ -0,0 +1,7 @@
+%1f   0:8
+%2f   8:8
+%3f   16:8
+
+&3arg a b c
+@3arg ........ ........ ........ ........  &3arg a=%1f b=%2f c=%3f
+3insn 00000000 ........ ........ ........  @3arg
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 4cd1e109046..c02de9865b2 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -42,8 +42,14 @@ output_fd = None
 insntype = 'uint32_t'
 decode_function = 'decode'
 
-re_ident = '[a-zA-Z][a-zA-Z0-9_]*'
+# An identifier for C.
+re_C_ident = '[a-zA-Z][a-zA-Z0-9_]*'
 
+# Identifiers for Arguments, Fields, Formats and Patterns.
+re_arg_ident = '&[a-zA-Z0-9_]*'
+re_fld_ident = '%[a-zA-Z0-9_]*'
+re_fmt_ident = '@[a-zA-Z0-9_]*'
+re_pat_ident = '[a-zA-Z0-9_]*'
 
 def error_with_file(file, lineno, *args):
     """Print an error message from file:line and args and exit."""
@@ -632,7 +638,6 @@ class ExcMultiPattern(MultiPattern):
 def parse_field(lineno, name, toks):
     """Parse one instruction field from TOKS at LINENO"""
     global fields
-    global re_ident
     global insnwidth
 
     # A "simple" field will have only one entry;
@@ -641,7 +646,7 @@ def parse_field(lineno, name, toks):
     width = 0
     func = None
     for t in toks:
-        if re.fullmatch('!function=' + re_ident, t):
+        if re.match('^!function=', t):
             if func:
                 error(lineno, 'duplicate function')
             func = t.split('=')
@@ -695,7 +700,7 @@ def parse_field(lineno, name, toks):
 def parse_arguments(lineno, name, toks):
     """Parse one argument set from TOKS at LINENO"""
     global arguments
-    global re_ident
+    global re_C_ident
     global anyextern
 
     flds = []
@@ -705,7 +710,7 @@ def parse_arguments(lineno, name, toks):
             extern = True
             anyextern = True
             continue
-        if not re.fullmatch(re_ident, t):
+        if not re.fullmatch(re_C_ident, t):
             error(lineno, 'invalid argument set token "{0}"'.format(t))
         if t in flds:
             error(lineno, 'duplicate argument "{0}"'.format(t))
@@ -791,7 +796,10 @@ def parse_generic(lineno, parent_pat, name, toks):
     global arguments
     global formats
     global allpatterns
-    global re_ident
+    global re_arg_ident
+    global re_fld_ident
+    global re_fmt_ident
+    global re_C_ident
     global insnwidth
     global insnmask
     global variablewidth
@@ -807,7 +815,7 @@ def parse_generic(lineno, parent_pat, name, toks):
     fmt = None
     for t in toks:
         # '&Foo' gives a format an explcit argument set.
-        if t[0] == '&':
+        if re.fullmatch(re_arg_ident, t):
             tt = t[1:]
             if arg:
                 error(lineno, 'multiple argument sets')
@@ -818,7 +826,7 @@ def parse_generic(lineno, parent_pat, name, toks):
             continue
 
         # '@Foo' gives a pattern an explicit format.
-        if t[0] == '@':
+        if re.fullmatch(re_fmt_ident, t):
             tt = t[1:]
             if fmt:
                 error(lineno, 'multiple formats')
@@ -829,19 +837,19 @@ def parse_generic(lineno, parent_pat, name, toks):
             continue
 
         # '%Foo' imports a field.
-        if t[0] == '%':
+        if re.fullmatch(re_fld_ident, t):
             tt = t[1:]
             flds = add_field_byname(lineno, flds, tt, tt)
             continue
 
         # 'Foo=%Bar' imports a field with a different name.
-        if re.fullmatch(re_ident + '=%' + re_ident, t):
+        if re.fullmatch(re_C_ident + '=' + re_fld_ident, t):
             (fname, iname) = t.split('=%')
             flds = add_field_byname(lineno, flds, fname, iname)
             continue
 
         # 'Foo=number' sets an argument field to a constant value
-        if re.fullmatch(re_ident + '=[+-]?[0-9]+', t):
+        if re.fullmatch(re_C_ident + '=[+-]?[0-9]+', t):
             (fname, value) = t.split('=')
             value = int(value)
             flds = add_field(lineno, flds, fname, ConstField(value))
@@ -866,7 +874,7 @@ def parse_generic(lineno, parent_pat, name, toks):
             fixedmask = (fixedmask << shift) | fms
             undefmask = (undefmask << shift) | ubm
         # Otherwise, fieldname:fieldwidth
-        elif re.fullmatch(re_ident + ':s?[0-9]+', t):
+        elif re.fullmatch(re_C_ident + ':s?[0-9]+', t):
             (fname, flen) = t.split(':')
             sign = False
             if flen[0] == 's':
@@ -971,6 +979,10 @@ def parse_generic(lineno, parent_pat, name, toks):
 
 def parse_file(f, parent_pat):
     """Parse all of the patterns within a file"""
+    global re_arg_ident
+    global re_fld_ident
+    global re_fmt_ident
+    global re_pat_ident
 
     # Read all of the lines of the file.  Concatenate lines
     # ending in backslash; discard empty lines and comments.
@@ -1063,14 +1075,16 @@ def parse_file(f, parent_pat):
             continue
 
         # Determine the type of object needing to be parsed.
-        if name[0] == '%':
+        if re.fullmatch(re_fld_ident, name):
             parse_field(start_lineno, name[1:], toks)
-        elif name[0] == '&':
+        elif re.fullmatch(re_arg_ident, name):
             parse_arguments(start_lineno, name[1:], toks)
-        elif name[0] == '@':
+        elif re.fullmatch(re_fmt_ident, name):
             parse_generic(start_lineno, None, name[1:], toks)
-        else:
+        elif re.fullmatch(re_pat_ident, name):
             parse_generic(start_lineno, parent_pat, name, toks)
+        else:
+            error(lineno, 'invalid token "{0}"'.format(name))
         toks = []
 
     if nesting != 0:
-- 
2.20.1


