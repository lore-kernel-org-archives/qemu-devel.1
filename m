Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13A8C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6CC22262
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSqsYwof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6CC22262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKq7q-0003Oz-EL
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpjO-0003kF-U7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpjL-00076E-RI
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+2DkJ41FXrYPe/QdNiQI4Frq9BhZCYdbi+2TVHr0zEY=;
 b=DSqsYwofmjrrMK5MU2MD4SvgOND6UQi4+zW2cnirVAnb5UXNpM24L8EldlsdMYVN201NFF
 YaQ+DZXK06Ajl/GnzgeMaRa+2sUAPAJVgLb5R467m9HiLDkDBVTHy2nSiBT/l4b/yaMNvJ
 bluk9LeKM+4QGFPM92IJ1jVV53VoB78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-PDM9HDmtOtOMJqa7tSIuSQ-1; Tue, 22 Sep 2020 17:21:24 -0400
X-MC-Unique: PDM9HDmtOtOMJqa7tSIuSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF0298030B8;
 Tue, 22 Sep 2020 21:21:23 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B2F65DA7B;
 Tue, 22 Sep 2020 21:21:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 4/6] qapi/parser.py: refactor QAPIParseError
Date: Tue, 22 Sep 2020 17:21:13 -0400
Message-Id: <20200922212115.4084301-5-jsnow@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
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

Instead of rewriting the constructor with arguments incompatible to the
base class we're extending, add a constructor-like class method that
accepts a QAPISchemaParser as an argument and builds the correct
Exception type.

Because this is a little extra typing, create a new helper in
QAPISchemaParser to build these exception objects.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 58 ++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 7e7eda9ed9..8be4570c31 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -17,6 +17,7 @@
 import os
 import re
 from collections import OrderedDict
+from typing import Type, TypeVar
 
 from .error import QAPIError, QAPISourceError, QAPISemError
 from .source import QAPISourceInfo
@@ -24,14 +25,18 @@
 
 class QAPIParseError(QAPISourceError):
     """Error class for all QAPI schema parsing errors."""
-    def __init__(self, parser, msg):
+
+    T = TypeVar('T', bound='QAPIParseError')
+
+    @classmethod
+    def make(cls: Type[T], parser: 'QAPISchemaParser', msg: str) -> T:
         col = 1
         for ch in parser.src[parser.line_pos:parser.pos]:
             if ch == '\t':
                 col = (col + 7) % 8 + 1
             else:
                 col += 1
-        super().__init__(parser.info, msg, col)
+        return cls(parser.info, msg, col)
 
 
 class QAPIDocError(QAPIError):
@@ -112,6 +117,9 @@ def __init__(self, fname, previously_included=None, incl_info=None):
             cur_doc = None
         self.reject_expr_doc(cur_doc)
 
+    def _parse_error(self, msg: str) -> QAPIParseError:
+        return QAPIParseError.make(self, msg)
+
     @staticmethod
     def reject_expr_doc(doc):
         if doc and doc.symbol:
@@ -183,13 +191,12 @@ def accept(self, skip_comment=True):
                     ch = self.src[self.cursor]
                     self.cursor += 1
                     if ch == '\n':
-                        raise QAPIParseError(self, "missing terminating \"'\"")
+                        raise self._parse_error("missing terminating \"'\"")
                     if esc:
                         # Note: we recognize only \\ because we have
                         # no use for funny characters in strings
                         if ch != '\\':
-                            raise QAPIParseError(self,
-                                                 "unknown escape \\%s" % ch)
+                            raise self._parse_error(f"unknown escape \\{ch}")
                         esc = False
                     elif ch == '\\':
                         esc = True
@@ -198,8 +205,7 @@ def accept(self, skip_comment=True):
                         self.val = string
                         return
                     if ord(ch) < 32 or ord(ch) >= 127:
-                        raise QAPIParseError(
-                            self, "funny character in string")
+                        raise self._parse_error("funny character in string")
                     string += ch
             elif self.src.startswith('true', self.pos):
                 self.val = True
@@ -220,7 +226,7 @@ def accept(self, skip_comment=True):
                 # character
                 match = re.match('[^[\\]{}:,\\s\'"]+',
                                  self.src[self.cursor-1:])
-                raise QAPIParseError(self, "stray '%s'" % match.group(0))
+                raise self._parse_error("stray '%s'" % match.group(0))
 
     def get_members(self):
         expr = OrderedDict()
@@ -228,24 +234,24 @@ def get_members(self):
             self.accept()
             return expr
         if self.tok != "'":
-            raise QAPIParseError(self, "expected string or '}'")
+            raise self._parse_error("expected string or '}'")
         while True:
             key = self.val
             self.accept()
             if self.tok != ':':
-                raise QAPIParseError(self, "expected ':'")
+                raise self._parse_error("expected ':'")
             self.accept()
             if key in expr:
-                raise QAPIParseError(self, "duplicate key '%s'" % key)
+                raise self._parse_error("duplicate key '%s'" % key)
             expr[key] = self.get_expr(True)
             if self.tok == '}':
                 self.accept()
                 return expr
             if self.tok != ',':
-                raise QAPIParseError(self, "expected ',' or '}'")
+                raise self._parse_error("expected ',' or '}'")
             self.accept()
             if self.tok != "'":
-                raise QAPIParseError(self, "expected string")
+                raise self._parse_error("expected string")
 
     def get_values(self):
         expr = []
@@ -253,20 +259,20 @@ def get_values(self):
             self.accept()
             return expr
         if self.tok not in "{['tfn":
-            raise QAPIParseError(
-                self, "expected '{', '[', ']', string, boolean or 'null'")
+            raise self._parse_error(
+                "expected '{', '[', ']', string, boolean or 'null'")
         while True:
             expr.append(self.get_expr(True))
             if self.tok == ']':
                 self.accept()
                 return expr
             if self.tok != ',':
-                raise QAPIParseError(self, "expected ',' or ']'")
+                raise self._parse_error("expected ',' or ']'")
             self.accept()
 
     def get_expr(self, nested):
         if self.tok != '{' and not nested:
-            raise QAPIParseError(self, "expected '{'")
+            raise self._parse_error("expected '{'")
         if self.tok == '{':
             self.accept()
             expr = self.get_members()
@@ -277,14 +283,14 @@ def get_expr(self, nested):
             expr = self.val
             self.accept()
         else:
-            raise QAPIParseError(
-                self, "expected '{', '[', string, boolean or 'null'")
+            raise self._parse_error(
+                "expected '{', '[', string, boolean or 'null'")
         return expr
 
     def _get_doc(self, info):
         if self.val != '##':
-            raise QAPIParseError(
-                self, "junk after '##' at start of documentation comment")
+            raise self._parse_error(
+                "junk after '##' at start of documentation comment")
 
         docs = []
         cur_doc = QAPIDoc(info)
@@ -293,8 +299,7 @@ def _get_doc(self, info):
             if self.val.startswith('##'):
                 # End of doc comment
                 if self.val != '##':
-                    raise QAPIParseError(
-                        self,
+                    raise self._parse_error(
                         "junk after '##' at end of documentation comment")
                 cur_doc.end_comment()
                 docs.append(cur_doc)
@@ -302,8 +307,7 @@ def _get_doc(self, info):
                 return docs
             if self.val.startswith('# ='):
                 if cur_doc.symbol:
-                    raise QAPIParseError(
-                        self,
+                    raise self._parse_error(
                         "unexpected '=' markup in definition documentation")
                 if cur_doc.body.text:
                     cur_doc.end_comment()
@@ -312,7 +316,7 @@ def _get_doc(self, info):
             cur_doc.append(self.val)
             self.accept(False)
 
-        raise QAPIParseError(self, "documentation comment must end with '##'")
+        raise self._parse_error("documentation comment must end with '##'")
 
     def get_doc(self, info):
         try:
@@ -322,7 +326,7 @@ def get_doc(self, info):
             # resulting error position depends on the state of the
             # parser. It happens to be the beginning of the comment.
             # More or less servicable, but action at a distance.
-            raise QAPIParseError(self, str(err)) from err
+            raise self._parse_error(str(err)) from err
 
 
 class QAPIDoc:
-- 
2.26.2


