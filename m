Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA873C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E662076E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZfqKNqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E662076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKr5O-0005tC-Au
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqt5-0004jN-Im
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqt2-0007fs-St
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UtEbxEEmIN+hGEWS4thp55WZFeorkKDSjE+eFLo91xc=;
 b=hZfqKNqN+JhmF0+y3y+RqdoO3LW+9aHIoOE5HBBwqOtd/KPww/rHZ/3aWj9Ihlojazug1w
 Inf0R2JqExPPqA+HtY5M2SjEt+0z50/CQVA3C6mppnh65/U79g9a9MRXsL+R5z6hUiCowH
 63qDMq7AwD7bPVwdN2r/Q7VKnsAuy7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-ZwgtsrW-PTKl5bdz19JcUA-1; Tue, 22 Sep 2020 18:35:44 -0400
X-MC-Unique: ZwgtsrW-PTKl5bdz19JcUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EB491005E64;
 Tue, 22 Sep 2020 22:35:43 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E6DD60BF4;
 Tue, 22 Sep 2020 22:35:42 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 15/26] qapi/parser.py: add ParsedExpression type
Date: Tue, 22 Sep 2020 18:35:14 -0400
Message-Id: <20200922223525.4085762-16-jsnow@redhat.com>
In-Reply-To: <20200922223525.4085762-1-jsnow@redhat.com>
References: <20200922223525.4085762-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an immutable, named, typed tuple; it's nicer than arbitrary
dicts for passing data around when using strict typing.

Turn parser.exprs into a list of ParsedExpressions instead, and adjust
expr.py to match.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/expr.py   | 56 +++++++++++++++---------------------------
 scripts/qapi/parser.py | 32 +++++++++++++-----------
 scripts/qapi/schema.py |  6 ++---
 3 files changed, 41 insertions(+), 53 deletions(-)

diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index cfd342aa04..f2059c505c 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -46,7 +46,7 @@
 
 from .common import c_name
 from .error import QAPISemError
-from .parser import QAPIDoc
+from .parser import ParsedExpression
 from .source import QAPISourceInfo
 
 
@@ -517,7 +517,7 @@ class ExpressionType(str, Enum):
 }
 
 
-def check_exprs(exprs: List[_JSObject]) -> List[_JSObject]:
+def check_exprs(exprs: List[ParsedExpression]) -> List[ParsedExpression]:
     """
     Validate and normalize a list of parsed QAPI schema expressions. [RW]
 
@@ -526,49 +526,33 @@ def check_exprs(exprs: List[_JSObject]) -> List[_JSObject]:
 
     :param exprs: The list of expressions to normalize/validate.
     """
-    for expr_elem in exprs:
-        # Expression
-        assert isinstance(expr_elem['expr'], dict)
-        expr: Expression = expr_elem['expr']
-        for key in expr.keys():
-            assert isinstance(key, str)
-
-        # QAPISourceInfo
-        assert isinstance(expr_elem['info'], QAPISourceInfo)
-        info: QAPISourceInfo = expr_elem['info']
-
-        # Optional[QAPIDoc]
-        tmp = expr_elem.get('doc')
-        assert tmp is None or isinstance(tmp, QAPIDoc)
-        doc: Optional[QAPIDoc] = tmp
-
+    for expr in exprs:
         for kind in ExpressionType:
-            if kind in expr:
+            if kind in expr.expr:
                 meta = kind
                 break
         else:
-            raise QAPISemError(info, "expression is missing metatype")
+            raise QAPISemError(expr.info, "expression is missing metatype")
 
         if meta == ExpressionType.INCLUDE:
             continue
 
-        name = cast(str, expr[meta])  # asserted right below:
-        check_name_is_str(name, info, "'%s'" % meta.value)
-        info.set_defn(meta.value, name)
-        check_defn_name_str(name, info, meta.value)
+        name = cast(str, expr.expr[meta])  # asserted right below:
+        check_name_is_str(name, expr.info, "'%s'" % meta.value)
+        expr.info.set_defn(meta.value, name)
+        check_defn_name_str(name, expr.info, meta.value)
 
-        if doc:
-            if doc.symbol != name:
-                raise QAPISemError(
-                    info, "documentation comment is for '%s'" % doc.symbol)
-            doc.check_expr(expr)
-        elif info.pragma.doc_required:
-            raise QAPISemError(info,
-                               "documentation comment required")
+        if expr.doc:
+            if expr.doc.symbol != name:
+                msg = f"documentation comment is for '{expr.doc.symbol}'"
+                raise QAPISemError(expr.info, msg)
+            expr.doc.check_expr(expr.expr)
+        elif expr.info.pragma.doc_required:
+            raise QAPISemError(expr.info, "documentation comment required")
 
-        _CHECK_FN[meta](expr, info)
-        check_if(expr, info, meta.value)
-        check_features(expr.get('features'), info)
-        check_flags(expr, info)
+        _CHECK_FN[meta](expr.expr, expr.info)
+        check_if(expr.expr, expr.info, meta.value)
+        check_features(expr.expr.get('features'), expr.info)
+        check_flags(expr.expr, expr.info)
 
     return exprs
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 490436b48a..f65afa4eb2 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -19,9 +19,8 @@
 import os
 import re
 from typing import (
-    Any,
-    Dict,
     List,
+    NamedTuple,
     Optional,
     Set,
     Type,
@@ -34,13 +33,18 @@
 from .source import QAPISourceInfo
 
 
-Expression = Dict[str, Any]
 _Value = Union[List[object], 'OrderedDict[str, object]', str, bool]
 # Necessary imprecision: mypy does not (yet?) support recursive types;
 # so we must stub out that recursion with 'object'.
 # Note, we do not support numerics or null in this parser.
 
 
+class ParsedExpression(NamedTuple):
+    expr: 'OrderedDict[str, object]'
+    info: QAPISourceInfo
+    doc: Optional['QAPIDoc']
+
+
 class QAPIParseError(QAPISourceError):
     """Error class for all QAPI schema parsing errors."""
     T = TypeVar('T', bound='QAPIParseError')
@@ -87,7 +91,7 @@ def __init__(self,
         self.line_pos = 0
 
         # Parser output:
-        self.exprs: List[Expression] = []
+        self.exprs: List[ParsedExpression] = []
         self.docs: List[QAPIDoc] = []
 
         # Showtime!
@@ -139,8 +143,7 @@ def _parse(self) -> None:
                                        "value of 'include' must be a string")
                 incl_fname = os.path.join(os.path.dirname(self._fname),
                                           include)
-                self.exprs.append({'expr': {'include': incl_fname},
-                                   'info': info})
+                self._add_expr(OrderedDict({'include': incl_fname}), info)
                 exprs_include = self._include(include, info, incl_fname,
                                               self._included)
                 if exprs_include:
@@ -157,20 +160,21 @@ def _parse(self) -> None:
                 for name, value in pragma.items():
                     self._pragma(name, value, info)
             else:
-                expr_elem = {'expr': expr,
-                             'info': info}
-                if cur_doc:
-                    if not cur_doc.symbol:
-                        raise QAPISemError(
-                            cur_doc.info, "definition documentation required")
-                    expr_elem['doc'] = cur_doc
-                self.exprs.append(expr_elem)
+                if cur_doc and not cur_doc.symbol:
+                    raise QAPISemError(
+                        cur_doc.info, "definition documentation required")
+                self._add_expr(expr, info, cur_doc)
             cur_doc = None
         self.reject_expr_doc(cur_doc)
 
     def _parse_error(self, msg: str) -> QAPIParseError:
         return QAPIParseError.make(self, msg)
 
+    def _add_expr(self, expr: 'OrderedDict[str, object]',
+                  info: QAPISourceInfo,
+                  doc: Optional['QAPIDoc'] = None) -> None:
+        self.exprs.append(ParsedExpression(expr, info, doc))
+
     @classmethod
     def reject_expr_doc(cls, doc: Optional['QAPIDoc']) -> None:
         if doc and doc.symbol:
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 121d8488d2..51af0449f5 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1106,9 +1106,9 @@ def _def_event(self, expr, info, doc):
 
     def _def_exprs(self, exprs):
         for expr_elem in exprs:
-            expr = expr_elem['expr']
-            info = expr_elem['info']
-            doc = expr_elem.get('doc')
+            expr = expr_elem.expr
+            info = expr_elem.info
+            doc = expr_elem.doc
             if 'enum' in expr:
                 self._def_enum_type(expr, info, doc)
             elif 'struct' in expr:
-- 
2.26.2


