Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5534BC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 23:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5EEE208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 23:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heE2qJJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EEE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIK0W-0002Yn-VV
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 19:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdk-0007YD-Pi
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59702
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdg-0002hp-TR
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600209688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r+ZVSYm0Ts4O68qcgdwGBJc5+14Ww2TemJhgzswZgEI=;
 b=heE2qJJzbhpXad1CpdWO79sKwAIAErPF/LYbqy6t+u9ezBdmKqO3o65jMG8i+wS+wz440l
 asaXtoD3vHgl2oX01dRd94J4jgttAJtmfbFwJvpuLtOapJzbYWSG8eTuIjr8RBZGp5jtLK
 fcX2l1tHtdOoic1X7G4Lva/j18j2tPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-7gTsV6wEPD6nBDQGcTQywQ-1; Tue, 15 Sep 2020 18:41:24 -0400
X-MC-Unique: 7gTsV6wEPD6nBDQGcTQywQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B81FD107B11B;
 Tue, 15 Sep 2020 22:41:12 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D11D360BE5;
 Tue, 15 Sep 2020 22:41:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 25/37] qapi/gen.py: add notational type hints
Date: Tue, 15 Sep 2020 18:40:15 -0400
Message-Id: <20200915224027.2529813-26-jsnow@redhat.com>
In-Reply-To: <20200915224027.2529813-1-jsnow@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 18:41:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/gen.py | 105 +++++++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 49 deletions(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index fc46813d1a..c87c84e7c9 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -15,6 +15,7 @@
 import errno
 import os
 import re
+from typing import Dict, Generator, List, Optional, Tuple
 
 from .common import (
     c_fname,
@@ -24,32 +25,34 @@
     guardstart,
     mcgen,
 )
-from .schema import QAPISchemaVisitor
+from .schema import (
+    QAPISchemaVisitor,
+)
+from .source import QAPISourceInfo
 
 
 class QAPIGen:
-
-    def __init__(self, fname):
+    def __init__(self, fname: Optional[str]):
         self.fname = fname
         self._preamble = ''
         self._body = ''
 
-    def preamble_add(self, text):
+    def preamble_add(self, text: str) -> None:
         self._preamble += text
 
-    def add(self, text):
+    def add(self, text: str) -> None:
         self._body += text
 
-    def get_content(self):
+    def get_content(self) -> str:
         return self._top() + self._preamble + self._body + self._bottom()
 
-    def _top(self):
+    def _top(self) -> str:
         return ''
 
-    def _bottom(self):
+    def _bottom(self) -> str:
         return ''
 
-    def write(self, output_dir):
+    def write(self, output_dir: str) -> None:
         # Include paths starting with ../ are used to reuse modules of the main
         # schema in specialised schemas. Don't overwrite the files that are
         # already generated for the main schema.
@@ -74,7 +77,7 @@ def write(self, output_dir):
         f.close()
 
 
-def _wrap_ifcond(ifcond, before, after):
+def _wrap_ifcond(ifcond: List[str], before: str, after: str) -> str:
     if before == after:
         return after   # suppress empty #if ... #endif
 
@@ -91,40 +94,38 @@ def _wrap_ifcond(ifcond, before, after):
 
 
 class QAPIGenCCode(QAPIGen):
-
-    def __init__(self, fname):
+    def __init__(self, fname: Optional[str]):
         super().__init__(fname)
-        self._start_if = None
+        self._start_if: Optional[Tuple[List[str], str, str]] = None
 
-    def start_if(self, ifcond):
+    def start_if(self, ifcond: List[str]) -> None:
         assert self._start_if is None
         self._start_if = (ifcond, self._body, self._preamble)
 
-    def end_if(self):
+    def end_if(self) -> None:
         assert self._start_if
         self._wrap_ifcond()
         self._start_if = None
 
-    def _wrap_ifcond(self):
+    def _wrap_ifcond(self) -> None:
         self._body = _wrap_ifcond(self._start_if[0],
                                   self._start_if[1], self._body)
         self._preamble = _wrap_ifcond(self._start_if[0],
                                       self._start_if[2], self._preamble)
 
-    def get_content(self):
+    def get_content(self) -> str:
         assert self._start_if is None
         return super().get_content()
 
 
 class QAPIGenC(QAPIGenCCode):
-
-    def __init__(self, fname, blurb, pydoc):
+    def __init__(self, fname: str, blurb: str, pydoc: str):
         super().__init__(fname)
         self._blurb = blurb
         self._copyright = '\n * '.join(re.findall(r'^Copyright .*', pydoc,
                                                   re.MULTILINE))
 
-    def _top(self):
+    def _top(self) -> str:
         return mcgen('''
 /* AUTOMATICALLY GENERATED, DO NOT MODIFY */
 
@@ -140,7 +141,7 @@ def _top(self):
 ''',
                      blurb=self._blurb, copyright=self._copyright)
 
-    def _bottom(self):
+    def _bottom(self) -> str:
         return mcgen('''
 
 /* Dummy declaration to prevent empty .o file */
@@ -150,16 +151,16 @@ def _bottom(self):
 
 
 class QAPIGenH(QAPIGenC):
-
-    def _top(self):
+    def _top(self) -> str:
         return super()._top() + guardstart(self.fname)
 
-    def _bottom(self):
+    def _bottom(self) -> str:
         return guardend(self.fname)
 
 
 @contextmanager
-def ifcontext(ifcond, *args):
+def ifcontext(ifcond: List[str],
+              *args: QAPIGenCCode) -> Generator[None, None, None]:
     """A 'with' statement context manager to wrap with start_if()/end_if()
 
     *args: any number of QAPIGenCCode
@@ -185,15 +186,17 @@ def ifcontext(ifcond, *args):
 
 
 class QAPIGenDoc(QAPIGen):
-
-    def _top(self):
+    def _top(self) -> str:
         return (super()._top()
                 + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
 
 
 class QAPISchemaMonolithicCVisitor(QAPISchemaVisitor):
-
-    def __init__(self, prefix, what, blurb, pydoc):
+    def __init__(self,
+                 prefix: str,
+                 what: str,
+                 blurb: str,
+                 pydoc: str):
         self._prefix = prefix
         self._what = what
         self._genc = QAPIGenC(self._prefix + self._what + '.c',
@@ -201,38 +204,42 @@ def __init__(self, prefix, what, blurb, pydoc):
         self._genh = QAPIGenH(self._prefix + self._what + '.h',
                               blurb, pydoc)
 
-    def write(self, output_dir):
+    def write(self, output_dir: str) -> None:
         self._genc.write(output_dir)
         self._genh.write(output_dir)
 
 
 class QAPISchemaModularCVisitor(QAPISchemaVisitor):
-
-    def __init__(self, prefix, what, user_blurb, builtin_blurb, pydoc):
+    def __init__(self,
+                 prefix: str,
+                 what: str,
+                 user_blurb: str,
+                 builtin_blurb: Optional[str],
+                 pydoc: str):
         self._prefix = prefix
         self._what = what
         self._user_blurb = user_blurb
         self._builtin_blurb = builtin_blurb
         self._pydoc = pydoc
-        self._genc = None
-        self._genh = None
-        self._module = {}
-        self._main_module = None
+        self._genc: Optional[QAPIGenC] = None
+        self._genh: Optional[QAPIGenH] = None
+        self._module: Dict[Optional[str], Tuple[QAPIGenC, QAPIGenH]] = {}
+        self._main_module: Optional[str] = None
 
     @staticmethod
-    def _is_user_module(name):
+    def _is_user_module(name: Optional[str]) -> bool:
         return name is not None and not name.startswith('./')
 
     @staticmethod
-    def _is_builtin_module(name):
+    def _is_builtin_module(name: Optional[str]) -> bool:
         return not name
 
-    def _module_dirname(self, what, name):
+    def _module_dirname(self, what: str, name: Optional[str]) -> str:
         if self._is_user_module(name):
             return os.path.dirname(name)
         return ''
 
-    def _module_basename(self, what, name):
+    def _module_basename(self, what: str, name: Optional[str]) -> str:
         ret = '' if self._is_builtin_module(name) else self._prefix
         if self._is_user_module(name):
             basename = os.path.basename(name)
@@ -244,27 +251,27 @@ def _module_basename(self, what, name):
             ret += re.sub(r'-', '-' + name + '-', what)
         return ret
 
-    def _module_filename(self, what, name):
+    def _module_filename(self, what: str, name: Optional[str]) -> str:
         return os.path.join(self._module_dirname(what, name),
                             self._module_basename(what, name))
 
-    def _add_module(self, name, blurb):
+    def _add_module(self, name: Optional[str], blurb: str) -> None:
         basename = self._module_filename(self._what, name)
         genc = QAPIGenC(basename + '.c', blurb, self._pydoc)
         genh = QAPIGenH(basename + '.h', blurb, self._pydoc)
         self._module[name] = (genc, genh)
         self._genc, self._genh = self._module[name]
 
-    def _add_user_module(self, name, blurb):
+    def _add_user_module(self, name: str, blurb: str) -> None:
         assert self._is_user_module(name)
         if self._main_module is None:
             self._main_module = name
         self._add_module(name, blurb)
 
-    def _add_system_module(self, name, blurb):
+    def _add_system_module(self, name: Optional[str], blurb: str) -> None:
         self._add_module(name and './' + name, blurb)
 
-    def write(self, output_dir, opt_builtins=False):
+    def write(self, output_dir: str, opt_builtins: bool = False) -> None:
         for name in self._module:
             if self._is_builtin_module(name) and not opt_builtins:
                 continue
@@ -272,13 +279,13 @@ def write(self, output_dir, opt_builtins=False):
             genc.write(output_dir)
             genh.write(output_dir)
 
-    def _begin_system_module(self, name):
+    def _begin_system_module(self, name: None) -> None:
         pass
 
-    def _begin_user_module(self, name):
+    def _begin_user_module(self, name: str) -> None:
         pass
 
-    def visit_module(self, name):
+    def visit_module(self, name: Optional[str]) -> None:
         if name is None:
             if self._builtin_blurb:
                 self._add_system_module(None, self._builtin_blurb)
@@ -292,7 +299,7 @@ def visit_module(self, name):
             self._add_user_module(name, self._user_blurb)
             self._begin_user_module(name)
 
-    def visit_include(self, name, info):
+    def visit_include(self, name: str, info: QAPISourceInfo) -> None:
         relname = os.path.relpath(self._module_filename(self._what, name),
                                   os.path.dirname(self._genh.fname))
         self._genh.preamble_add(mcgen('''
-- 
2.26.2


