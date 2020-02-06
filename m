Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F500C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3A820659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPnRFdK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3A820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlFF-0007en-7c
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izl08-0006u1-Vq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izl05-0006oh-CO
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:40 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:51969)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izl03-0006dz-KT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:37 -0500
Received: by mail-wm1-x32a.google.com with SMTP id t23so902361wmi.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uG5NDXEGg3myTzZttWMRSQ2riVD+Wnq5tJN9+Gr0JO8=;
 b=HPnRFdK9v97HwNjA4B3poqNfGABq1ap6SUXDpGg+vWCinCBZx3FB+bIgbSv/eES2z/
 Uj7wq41REfVF9ffgmNoWTSM45J8C2BOSBwVkrqi0ncL9YTSTW2e3MYIESuqkfQCuS0g3
 x39OITu1A2G5DXcU9hJuLXgJRloksM6TaVJp4VlHAYTVyh7G9gcERt1JW4LfrfM2QKOQ
 5VsCmeFjBoBsuff62JBZyc7ZXklgFMA6ZmbUMUXFnK8Q/PAgrIan7ia+VUI3Qv87tLi/
 qybnbf5Jfd3KpamawVzyAbYZEN4a01RqhjhQsQnL+eAZax6QnLMj5ROKM38dxxTnNHyi
 IKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uG5NDXEGg3myTzZttWMRSQ2riVD+Wnq5tJN9+Gr0JO8=;
 b=ad12Pzm8hSXYTgO+USD1mKD+kwSvRJh1Rug8VGye/WCcg6m8MgwTj+dv4xex+wPObh
 E6Q3B85PKn92p7WiQAhFYcyDUdIcaHt2UlKIfGOuk4yCmx8MAhpzLTiAljNGk79xwarO
 vvFWaFEZWxWIA1NaEjhtmc4lLKalgn6EbRrsYnXRDknhqJHP2ZkDMNMCFvY1SyYQeGhv
 ONnmvsUkeYtidW4UzJOnejkdGezRw8kqxpgCKlnoNl2nLqQAyYAN3qoV9Tlf46C2RrDQ
 FapujLX3xpfH2MCXEnq2anPYPrtmDUxsNWdnmgf850FN+6VB1lTrs+AaV6qgfsOLm31t
 ZhaQ==
X-Gm-Message-State: APjAAAUzhbkPwBnsnmoATt3iWyqWTNj9AQ1n3G+Bp0/sgafeYuToTXKB
 sKyZZyt0jsZoHnCg3AhrxWxiRQtmYz8=
X-Google-Smtp-Source: APXvYqxIM0Ms/6ImsqOQDuVxmnk57D3ewuFU639UWvjrhoT6zCvNijit4pCbHlUWpei7MsBIxghMYQ==
X-Received: by 2002:a1c:113:: with SMTP id 19mr5930397wmb.95.1581010293124;
 Thu, 06 Feb 2020 09:31:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/29] scripts/qapi/parser.py: improve doc comment indent
 handling
Date: Thu,  6 Feb 2020 17:30:33 +0000
Message-Id: <20200206173040.17337-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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

Make the handling of indentation in doc comments more
sophisticated, so that when we see a section like:

Notes: some text
       some more text
          indented line 3

we save it for the doc-comment processing code as:
some text
some more text
   indented line 3

and when we see a section with the heading on its own line:

Notes:

some text
some more text
   indented text

we also accept that and save it in the same form.

The exception is that we always retain indentation as-is
for Examples sections, because these are literal text.

If we detect that the comment document text is not indented
as much as we expect it to be, we throw a parse error.
(We don't complain about over-indented sections, because
for rST this can be legitimate markup.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/qapi/parser.py | 82 +++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 17 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 2196ec5de1e..66f802641c9 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -313,18 +313,32 @@ class QAPIDoc(object):
     """
 
     class Section(object):
-        def __init__(self, name=None):
+        def __init__(self, parser, name=None, indent=0):
+            # parser, for error messages about indentation
+            self._parser = parser
             # optional section name (argument/member or section name)
             self.name = name
             # the list of lines for this section
             self.text = ''
+            # the expected indent level of the text of this section
+            self._indent = indent
 
         def append(self, line):
+            # Strip leading spaces corresponding to the expected indent level
+            # Blank lines are always OK.
+            if line:
+                spacecount = len(line) - len(line.lstrip(" "))
+                if spacecount > self._indent:
+                    spacecount = self._indent
+                if spacecount < self._indent:
+                    raise QAPIParseError(self._parser, "unexpected de-indent")
+                line = line[spacecount:]
+
             self.text += line.rstrip() + '\n'
 
     class ArgSection(Section):
-        def __init__(self, name):
-            QAPIDoc.Section.__init__(self, name)
+        def __init__(self, parser, name, indent=0):
+            QAPIDoc.Section.__init__(self, parser, name, indent)
             self.member = None
 
         def connect(self, member):
@@ -338,7 +352,7 @@ class QAPIDoc(object):
         self._parser = parser
         self.info = info
         self.symbol = None
-        self.body = QAPIDoc.Section()
+        self.body = QAPIDoc.Section(parser)
         # dict mapping parameter name to ArgSection
         self.args = OrderedDict()
         self.features = OrderedDict()
@@ -443,7 +457,18 @@ class QAPIDoc(object):
 
         if name.startswith('@') and name.endswith(':'):
             line = line[len(name)+1:]
-            self._start_args_section(name[1:-1])
+            if not line or line.isspace():
+                # Line was just the "@arg:" header; following lines
+                # are not indented
+                indent = 0
+                line = ''
+            else:
+                # Line is "@arg: first line of description"; following
+                # lines should be indented by len(name) + 1, and we
+                # pad out this first line so it is handled the same way
+                indent = len(name) + 1
+                line = ' ' * indent + line
+            self._start_args_section(name[1:-1], indent)
         elif self._is_section_tag(name):
             self._append_line = self._append_various_line
             self._append_various_line(line)
@@ -465,7 +490,17 @@ class QAPIDoc(object):
 
         if name.startswith('@') and name.endswith(':'):
             line = line[len(name)+1:]
-            self._start_features_section(name[1:-1])
+            if not line or line.isspace():
+                # Line is just the "@name:" header, no ident for following lines
+                indent = 0
+                line = ''
+            else:
+                # Line is "@arg: first line of description"; following
+                # lines should be indented by len(name) + 3, and we
+                # pad out this first line so it is handled the same way
+                indent = len(name) + 1
+                line = ' ' * indent + line
+            self._start_features_section(name[1:-1], indent)
         elif self._is_section_tag(name):
             self._append_line = self._append_various_line
             self._append_various_line(line)
@@ -498,11 +533,23 @@ class QAPIDoc(object):
                                  % (name, self.sections[0].name))
         elif self._is_section_tag(name):
             line = line[len(name)+1:]
-            self._start_section(name[:-1])
+            if not line or line.isspace():
+                # Line is just "SectionName:", no indent for following lines
+                indent = 0
+                line = ''
+            elif name.startswith("Example"):
+                # The "Examples" section is literal-text, so preserve
+                # all the indentation as-is
+                indent = 0
+            else:
+                # Line is "SectionName: some text", indent required
+                indent = len(name) + 1
+                line = ' ' * indent + line
+            self._start_section(name[:-1], indent)
 
         self._append_freeform(line)
 
-    def _start_symbol_section(self, symbols_dict, name):
+    def _start_symbol_section(self, symbols_dict, name, indent):
         # FIXME invalid names other than the empty string aren't flagged
         if not name:
             raise QAPIParseError(self._parser, "invalid parameter name")
@@ -511,21 +558,21 @@ class QAPIDoc(object):
                                  "'%s' parameter name duplicated" % name)
         assert not self.sections
         self._end_section()
-        self._section = QAPIDoc.ArgSection(name)
+        self._section = QAPIDoc.ArgSection(self._parser, name, indent)
         symbols_dict[name] = self._section
 
-    def _start_args_section(self, name):
-        self._start_symbol_section(self.args, name)
+    def _start_args_section(self, name, indent):
+        self._start_symbol_section(self.args, name, indent)
 
-    def _start_features_section(self, name):
-        self._start_symbol_section(self.features, name)
+    def _start_features_section(self, name, indent):
+        self._start_symbol_section(self.features, name, indent)
 
-    def _start_section(self, name=None):
+    def _start_section(self, name=None, indent=0):
         if name in ('Returns', 'Since') and self.has_section(name):
             raise QAPIParseError(self._parser,
                                  "duplicated '%s' section" % name)
         self._end_section()
-        self._section = QAPIDoc.Section(name)
+        self._section = QAPIDoc.Section(self._parser, name, indent)
         self.sections.append(self._section)
 
     def _end_section(self):
@@ -548,7 +595,7 @@ class QAPIDoc(object):
     def connect_member(self, member):
         if member.name not in self.args:
             # Undocumented TODO outlaw
-            self.args[member.name] = QAPIDoc.ArgSection(member.name)
+            self.args[member.name] = QAPIDoc.ArgSection(self._parser, member.name)
         self.args[member.name].connect(member)
 
     def connect_feature(self, feature):
@@ -556,7 +603,8 @@ class QAPIDoc(object):
             raise QAPISemError(feature.info,
                                "feature '%s' lacks documentation"
                                % feature.name)
-            self.features[feature.name] = QAPIDoc.ArgSection(feature.name)
+            self.features[feature.name] = QAPIDoc.ArgSection(self._parser,
+                                                             feature.name)
         self.features[feature.name].connect(feature)
 
     def check_expr(self, expr):
-- 
2.20.1


