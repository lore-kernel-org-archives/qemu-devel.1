Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52916C34022
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2129124656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aT9zNobk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2129124656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7KRH-00013R-B5
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j7KQ9-0008A4-27
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j7KQ7-0000U9-Lv
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:45:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23610
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j7KQ6-0000TW-Tg
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582814745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7V8UF6Cf3fS9oY+IzuxU5Whk6ky4D6soSWJw9gWzPY=;
 b=aT9zNobk2z3W5qw2hF+L5q8XIWDTPKALFrlXbX1My7llD3hvydcgNJaEKi11OvYVkQ845C
 nfyAXDwkIj57csNmQ7GOwEGFEpIEac+/GjGbYnLR3hKPyfHJsAahVE9fmMXMC+R4XGFHkH
 ROizstiQJA8Wx6NLqr+pI8/HTJR2q3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-IazRcMC-NamVjmwI7mmcnQ-1; Thu, 27 Feb 2020 09:45:38 -0500
X-MC-Unique: IazRcMC-NamVjmwI7mmcnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA4F180572B;
 Thu, 27 Feb 2020 14:45:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6433184779;
 Thu, 27 Feb 2020 14:45:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2190A11366CB; Thu, 27 Feb 2020 15:45:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] qapi: Brush off some (py)lint
Date: Thu, 27 Feb 2020 15:45:31 +0100
Message-Id: <20200227144531.24309-5-armbru@redhat.com>
In-Reply-To: <20200227144531.24309-1-armbru@redhat.com>
References: <20200227144531.24309-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: mdroth@linux.vnet.ibm.com, jsnow@redhat.com, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/commands.py   | 2 +-
 scripts/qapi/expr.py       | 3 +--
 scripts/qapi/gen.py        | 9 ++++++---
 scripts/qapi/introspect.py | 2 --
 scripts/qapi/parser.py     | 6 ++----
 scripts/qapi/schema.py     | 9 ++++-----
 6 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 8bb6316061..0e13e82989 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -274,7 +274,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCVis=
itor):
=20
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
-                       c_prefix=3Dc_name(self._prefix, protect=3DFalse)))
+                             c_prefix=3Dc_name(self._prefix, protect=3DFal=
se)))
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-commands.h"
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index d7a289eded..fecf466fa7 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -35,7 +35,6 @@ def check_name_is_str(name, info, source):
 def check_name_str(name, info, source,
                    allow_optional=3DFalse, enum_member=3DFalse,
                    permit_upper=3DFalse):
-    global valid_name
     membername =3D name
=20
     if allow_optional and name.startswith('*'):
@@ -249,7 +248,7 @@ def check_union(expr, info):
 def check_alternate(expr, info):
     members =3D expr['data']
=20
-    if len(members) =3D=3D 0:
+    if not members:
         raise QAPISemError(info, "'data' must not be empty")
     for (key, value) in members.items():
         source =3D "'data' member '%s'" % key
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index e17354392b..33690bfa3b 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -45,10 +45,10 @@ class QAPIGen:
=20
     def write(self, output_dir):
         pathname =3D os.path.join(output_dir, self.fname)
-        dir =3D os.path.dirname(pathname)
-        if dir:
+        odir =3D os.path.dirname(pathname)
+        if odir:
             try:
-                os.makedirs(dir)
+                os.makedirs(odir)
             except os.error as e:
                 if e.errno !=3D errno.EEXIST:
                     raise
@@ -261,6 +261,9 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor):
             genc.write(output_dir)
             genh.write(output_dir)
=20
+    def _begin_system_module(self, name):
+        pass
+
     def _begin_user_module(self, name):
         pass
=20
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 0cc655fd9f..b5537eddc0 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -10,8 +10,6 @@ This work is licensed under the terms of the GNU GPL, ver=
sion 2.
 See the COPYING file in the top-level directory.
 """
=20
-import string
-
 from qapi.common import *
 from qapi.gen import QAPISchemaMonolithicCVisitor
 from qapi.schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 340f7c4633..abadacbb0e 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -282,8 +282,7 @@ class QAPISchemaParser:
                 doc.end_comment()
                 self.accept()
                 return doc
-            else:
-                doc.append(self.val)
+            doc.append(self.val)
             self.accept(False)
=20
         raise QAPIParseError(self, "documentation comment must end with '#=
#'")
@@ -492,7 +491,7 @@ class QAPIDoc:
             raise QAPIParseError(self._parser,
                                  "'%s' can't follow '%s' section"
                                  % (name, self.sections[0].name))
-        elif self._is_section_tag(name):
+        if self._is_section_tag(name):
             line =3D line[len(name)+1:]
             self._start_section(name[:-1])
=20
@@ -556,7 +555,6 @@ class QAPIDoc:
             raise QAPISemError(feature.info,
                                "feature '%s' lacks documentation"
                                % feature.name)
-            self.features[feature.name] =3D QAPIDoc.ArgSection(feature.nam=
e)
         self.features[feature.name].connect(feature)
=20
     def check_expr(self, expr):
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index e132442c04..cfbb9758c4 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -19,7 +19,7 @@ import re
 from collections import OrderedDict
=20
 from qapi.common import c_name, pointer_suffix
-from qapi.error import QAPIError, QAPIParseError, QAPISemError
+from qapi.error import QAPIError, QAPISemError
 from qapi.expr import check_exprs
 from qapi.parser import QAPISchemaParser
=20
@@ -96,14 +96,14 @@ class QAPISchemaVisitor:
     def visit_end(self):
         pass
=20
-    def visit_module(self, fname):
+    def visit_module(self, name):
         pass
=20
     def visit_needed(self, entity):
         # Default to visiting everything
         return True
=20
-    def visit_include(self, fname, info):
+    def visit_include(self, name, info):
         pass
=20
     def visit_builtin_type(self, name, info, json_type):
@@ -576,7 +576,7 @@ class QAPISchemaObjectTypeVariants:
             assert self.tag_member.ifcond =3D=3D []
         if self._tag_name:    # flat union
             # branches that are not explicitly covered get an empty type
-            cases =3D set([v.name for v in self.variants])
+            cases =3D {v.name for v in self.variants}
             for m in self.tag_member.type.members:
                 if m.name not in cases:
                     v =3D QAPISchemaObjectTypeVariant(m.name, self.info,
@@ -1098,7 +1098,6 @@ class QAPISchema:
=20
     def visit(self, visitor):
         visitor.visit_begin(self)
-        module =3D None
         for mod in self._module_dict.values():
             mod.visit(visitor)
         visitor.visit_end()
--=20
2.21.1


