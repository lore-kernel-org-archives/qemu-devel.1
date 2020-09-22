Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34D5C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C73A2076E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daCcEvv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C73A2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqyn-0004aw-ES
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqt8-0004qA-4L
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqt4-0007g6-E8
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3czMzA7jYvQ1EYINs1q1A8p7rMTBFDZJx5iX7pQP+o=;
 b=daCcEvv4ULad8fw2bwUkM84QQ9eR6PkIYwbmgwPz1rA8FnHe6b4WsH1No/dakontKIgoer
 X0cLoafGH262iJ93hMdDKuEr5arRFAy6LmeXBKouYw/rzBXv1L/1ZvbNSKwBat0uFhoDne
 oqTxQe1twDOt3tntxSLYlmcn2WWS+xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-Fnyoah9MMr6hkkOa34iVPg-1; Tue, 22 Sep 2020 18:35:46 -0400
X-MC-Unique: Fnyoah9MMr6hkkOa34iVPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8733A1074669;
 Tue, 22 Sep 2020 22:35:45 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABFA560BF4;
 Tue, 22 Sep 2020 22:35:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 17/26] qapi/pragma.py: Move pragma parsing out of parser.py
Date: Tue, 22 Sep 2020 18:35:16 -0400
Message-Id: <20200922223525.4085762-18-jsnow@redhat.com>
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

parser.py is a JSON parser at heart and shouldn't necessarily understand
what it is parsing on a semantic level. Move pragma parsing to pragma.py,
and leave the parser a little more happily ignorant.

Note: the type annotation in error.py now creates a cyclic import, because
error -> source -> pragma -> error. Use the magical mypy constant TYPE_CHECKING
to avoid this cycle at runtime. pylint dislikes this cycle still, but it can
be safely ignored.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/error.py  |  8 +++---
 scripts/qapi/parser.py | 41 ++++---------------------------
 scripts/qapi/pragma.py | 55 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/scripts/qapi/error.py b/scripts/qapi/error.py
index ab6a0f6271..be5fd24218 100644
--- a/scripts/qapi/error.py
+++ b/scripts/qapi/error.py
@@ -11,9 +11,11 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
-from typing import Optional
+from typing import Optional, TYPE_CHECKING
 
-from .source import QAPISourceInfo
+if TYPE_CHECKING:
+    # pylint: disable=cyclic-import
+    from .source import QAPISourceInfo
 
 
 class QAPIError(Exception):
@@ -23,7 +25,7 @@ class QAPIError(Exception):
 class QAPISourceError(QAPIError):
     """Error class for all exceptions identifying a source location."""
     def __init__(self,
-                 info: QAPISourceInfo,
+                 info: 'QAPISourceInfo',
                  msg: str,
                  col: Optional[int] = None):
         super().__init__()
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index f65afa4eb2..5b3a9b5da8 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -26,10 +26,10 @@
     Type,
     TypeVar,
     Union,
-    cast,
 )
 
 from .error import QAPIError, QAPISourceError, QAPISemError
+from .pragma import PragmaError
 from .source import QAPISourceInfo
 
 
@@ -151,14 +151,10 @@ def _parse(self) -> None:
                     self.docs.extend(exprs_include.docs)
             elif "pragma" in expr:
                 self.reject_expr_doc(cur_doc)
-                if len(expr) != 1:
-                    raise QAPISemError(info, "invalid 'pragma' directive")
-                pragma = expr['pragma']
-                if not isinstance(pragma, dict):
-                    raise QAPISemError(
-                        info, "value of 'pragma' must be an object")
-                for name, value in pragma.items():
-                    self._pragma(name, value, info)
+                try:
+                    info.pragma.parse(expr)
+                except PragmaError as err:
+                    raise QAPISemError(info, str(err)) from err
             else:
                 if cur_doc and not cur_doc.symbol:
                     raise QAPISemError(
@@ -204,33 +200,6 @@ def _include(cls,
 
         return QAPISchemaParser(incl_fname, previously_included, info)
 
-    @classmethod
-    def _pragma(cls,
-                name: str,
-                value: object,
-                info: QAPISourceInfo) -> None:
-        if name == 'doc-required':
-            if not isinstance(value, bool):
-                raise QAPISemError(info,
-                                   "pragma 'doc-required' must be boolean")
-            info.pragma.doc_required = value
-        elif name == 'returns-whitelist':
-            if (not isinstance(value, list)
-                    or any([not isinstance(elt, str) for elt in value])):
-                raise QAPISemError(
-                    info,
-                    "pragma returns-whitelist must be a list of strings")
-            info.pragma.returns_whitelist = cast(List[str], value)
-        elif name == 'name-case-whitelist':
-            if (not isinstance(value, list)
-                    or any([not isinstance(elt, str) for elt in value])):
-                raise QAPISemError(
-                    info,
-                    "pragma name-case-whitelist must be a list of strings")
-            info.pragma.name_case_whitelist = cast(List[str], value)
-        else:
-            raise QAPISemError(info, "unknown pragma '%s'" % name)
-
     def accept(self, skip_comment: bool = True) -> None:
         """
         Read the next lexeme.
diff --git a/scripts/qapi/pragma.py b/scripts/qapi/pragma.py
index 7f3db9ab87..03ba3cac90 100644
--- a/scripts/qapi/pragma.py
+++ b/scripts/qapi/pragma.py
@@ -9,17 +9,60 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
-from typing import List
+from typing import Mapping, Sequence
+
+from .error import QAPIError
+
+
+class PragmaError(QAPIError):
+    """For errors relating to Pragma validation."""
 
 
 class QAPISchemaPragma:
-    # Replace with @dataclass in Python 3.7+
-    # pylint: disable=too-few-public-methods
-
     def __init__(self) -> None:
         # Are documentation comments required?
         self.doc_required = False
         # Whitelist of commands allowed to return a non-dictionary
-        self.returns_whitelist: List[str] = []
+        self.returns_whitelist: Sequence[str] = tuple()
         # Whitelist of entities allowed to violate case conventions
-        self.name_case_whitelist: List[str] = []
+        self.name_case_whitelist: Sequence[str] = tuple()
+
+    def _add_doc_required(self, value: object) -> None:
+        if not isinstance(value, bool):
+            raise PragmaError("pragma 'doc-required' must be boolean")
+        self.doc_required = value
+
+    def _add_returns_whitelist(self, value: object) -> None:
+        if (not isinstance(value, list)
+                or any([not isinstance(elt, str) for elt in value])):
+            raise PragmaError(
+                "pragma returns-whitelist must be a list of strings")
+        self.returns_whitelist = tuple(value)
+
+    def _add_name_case_whitelist(self, value: object) -> None:
+        if (not isinstance(value, list)
+                or any([not isinstance(elt, str) for elt in value])):
+            raise PragmaError(
+                "pragma name-case-whitelist must be a list of strings")
+        self.name_case_whitelist = tuple(value)
+
+    def add(self, name: str, value: object) -> None:
+        if name == 'doc-required':
+            self._add_doc_required(value)
+        elif name == 'returns-whitelist':
+            self._add_returns_whitelist(value)
+        elif name == 'name-case-whitelist':
+            self._add_name_case_whitelist(value)
+        else:
+            raise PragmaError(f"unknown pragma '{name}'")
+
+    def parse(self, expression: Mapping[str, object]) -> None:
+        if expression.keys() != {'pragma'}:
+            raise PragmaError("invalid 'pragma' directive")
+
+        body = expression['pragma']
+        if not isinstance(body, dict):
+            raise PragmaError("value of 'pragma' must be an object")
+
+        for name, value in body.items():
+            self.add(name, value)
-- 
2.26.2


