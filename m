Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413B8C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01BE206FC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLqGX4uN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01BE206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqAK-00075s-Oj
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpj9-0003L8-4R
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpj5-000750-JM
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d1w7A9tf/5Qzt1yH408ACdCWC7OW5p+S8aaxkJNuoPE=;
 b=ZLqGX4uNnQwFkGCCuOEd2ryka/C/DNnHVQDI0SjdpnKJ+IPwAVmlhd3syXnMPcZM85AxLB
 v+8c/JEn8CwXKy69grz5qihFFTyC29DekGYczcNSmwq+XTekoQFUN7wVIWMHg3yb2ccqz9
 xXc0XSL5Bm6Tku8M83sK5CbmSqbhprE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-g7yzsh0ENwqX1za9HGQXlw-1; Tue, 22 Sep 2020 17:21:22 -0400
X-MC-Unique: g7yzsh0ENwqX1za9HGQXlw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1FE01DE09;
 Tue, 22 Sep 2020 21:21:21 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FB0D5DE86;
 Tue, 22 Sep 2020 21:21:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/6] qapi/parser.py: remove parser context from QAPIDoc
Date: Tue, 22 Sep 2020 17:21:11 -0400
Message-Id: <20200922212115.4084301-3-jsnow@redhat.com>
In-Reply-To: <20200922212115.4084301-1-jsnow@redhat.com>
References: <20200922212115.4084301-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We only need the parser context for the purpose of raising
exceptions. What we can do instead is to raise a unique document parsing
error and affix additional context from the caller. This way, the
document parsing can be isolated.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 56 ++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 327cf05736..cb2595ce60 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -18,10 +18,14 @@
 import re
 from collections import OrderedDict
 
-from .error import QAPIParseError, QAPISemError
+from .error import QAPIError, QAPIParseError, QAPISemError
 from .source import QAPISourceInfo
 
 
+class QAPIDocError(QAPIError):
+    """Documentation parsing error."""
+
+
 class QAPISchemaParser:
 
     def __init__(self, fname, previously_included=None, incl_info=None):
@@ -265,13 +269,13 @@ def get_expr(self, nested):
                 self, "expected '{', '[', string, boolean or 'null'")
         return expr
 
-    def get_doc(self, info):
+    def _get_doc(self, info):
         if self.val != '##':
             raise QAPIParseError(
                 self, "junk after '##' at start of documentation comment")
 
         docs = []
-        cur_doc = QAPIDoc(self, info)
+        cur_doc = QAPIDoc(info)
         self.accept(False)
         while self.tok == '#':
             if self.val.startswith('##'):
@@ -292,12 +296,22 @@ def get_doc(self, info):
                 if cur_doc.body.text:
                     cur_doc.end_comment()
                     docs.append(cur_doc)
-                    cur_doc = QAPIDoc(self, info)
+                    cur_doc = QAPIDoc(info)
             cur_doc.append(self.val)
             self.accept(False)
 
         raise QAPIParseError(self, "documentation comment must end with '##'")
 
+    def get_doc(self, info):
+        try:
+            return self._get_doc(info)
+        except QAPIDocError as err:
+            # Tie the Doc parsing error to our parsing state. The
+            # resulting error position depends on the state of the
+            # parser. It happens to be the beginning of the comment.
+            # More or less servicable, but action at a distance.
+            raise QAPIParseError(self, str(err)) from err
+
 
 class QAPIDoc:
     """
@@ -335,12 +349,7 @@ def __init__(self, name):
         def connect(self, member):
             self.member = member
 
-    def __init__(self, parser, info):
-        # self._parser is used to report errors with QAPIParseError.  The
-        # resulting error position depends on the state of the parser.
-        # It happens to be the beginning of the comment.  More or less
-        # servicable, but action at a distance.
-        self._parser = parser
+    def __init__(self, info):
         self.info = info
         self.symbol = None
         self.body = QAPIDoc.Section()
@@ -377,7 +386,7 @@ def append(self, line):
             return
 
         if line[0] != ' ':
-            raise QAPIParseError(self._parser, "missing space after #")
+            raise QAPIDocError("missing space after #")
         line = line[1:]
         self._append_line(line)
 
@@ -411,11 +420,11 @@ def _append_body_line(self, line):
         # recognized, and get silently treated as ordinary text
         if not self.symbol and not self.body.text and line.startswith('@'):
             if not line.endswith(':'):
-                raise QAPIParseError(self._parser, "line should end with ':'")
+                raise QAPIDocError("line should end with ':'")
             self.symbol = line[1:-1]
             # FIXME invalid names other than the empty string aren't flagged
             if not self.symbol:
-                raise QAPIParseError(self._parser, "invalid name")
+                raise QAPIDocError("invalid name")
         elif self.symbol:
             # This is a definition documentation block
             if name.startswith('@') and name.endswith(':'):
@@ -498,9 +507,8 @@ def _append_various_line(self, line):
         name = line.split(' ', 1)[0]
 
         if name.startswith('@') and name.endswith(':'):
-            raise QAPIParseError(self._parser,
-                                 "'%s' can't follow '%s' section"
-                                 % (name, self.sections[0].name))
+            raise QAPIDocError("'%s' can't follow '%s' section"
+                               % (name, self.sections[0].name))
         if self._is_section_tag(name):
             line = line[len(name)+1:]
             self._start_section(name[:-1])
@@ -514,10 +522,9 @@ def _append_various_line(self, line):
     def _start_symbol_section(self, symbols_dict, name):
         # FIXME invalid names other than the empty string aren't flagged
         if not name:
-            raise QAPIParseError(self._parser, "invalid parameter name")
+            raise QAPIDocError("invalid parameter name")
         if name in symbols_dict:
-            raise QAPIParseError(self._parser,
-                                 "'%s' parameter name duplicated" % name)
+            raise QAPIDocError("'%s' parameter name duplicated" % name)
         assert not self.sections
         self._end_section()
         self._section = QAPIDoc.ArgSection(name)
@@ -531,8 +538,7 @@ def _start_features_section(self, name):
 
     def _start_section(self, name=None):
         if name in ('Returns', 'Since') and self.has_section(name):
-            raise QAPIParseError(self._parser,
-                                 "duplicated '%s' section" % name)
+            raise QAPIDocError("duplicated '%s' section" % name)
         self._end_section()
         self._section = QAPIDoc.Section(name)
         self.sections.append(self._section)
@@ -541,17 +547,15 @@ def _end_section(self):
         if self._section:
             text = self._section.text = self._section.text.strip()
             if self._section.name and (not text or text.isspace()):
-                raise QAPIParseError(
-                    self._parser,
+                raise QAPIDocError(
                     "empty doc section '%s'" % self._section.name)
             self._section = None
 
     def _append_freeform(self, line):
         match = re.match(r'(@\S+:)', line)
         if match:
-            raise QAPIParseError(self._parser,
-                                 "'%s' not allowed in free-form documentation"
-                                 % match.group(1))
+            raise QAPIDocError("'%s' not allowed in free-form documentation"
+                               % match.group(1))
         self._section.append(line)
 
     def connect_member(self, member):
-- 
2.26.2


