Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BE4C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D57206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D57206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYuXl-0001Sb-FR
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 11:43:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYuT8-0005sU-Lx
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYuT7-0006B4-5v
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:38:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hYuT4-00060S-0f; Thu, 06 Jun 2019 11:38:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E5CD3092667;
	Thu,  6 Jun 2019 15:38:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BF4DD5F7D8;
	Thu,  6 Jun 2019 15:38:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 966AB113861C; Thu,  6 Jun 2019 17:38:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 17:38:01 +0200
Message-Id: <20190606153803.5278-6-armbru@redhat.com>
In-Reply-To: <20190606153803.5278-1-armbru@redhat.com>
References: <20190606153803.5278-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 06 Jun 2019 15:38:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 5/7] qapi: Allow documentation for features
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Features will be documented in a new part introduced by a "Features:"
line, after arguments and before named sections.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qapi/common.py | 43 ++++++++++++++++++++++++++++++++++++++----
 scripts/qapi/doc.py    | 12 ++++++++++++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index f40a2cd4c5..1164301edf 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -129,6 +129,7 @@ class QAPIDoc(object):
           optional overview
         * an ARGS part: description of each argument (for commands and
           events) or member (for structs, unions and alternates),
+        * a FEATURES part: description of each feature,
         * a VARIOUS part: optional tagged sections.
=20
         Free-form documentation blocks consist only of a BODY part.
@@ -136,7 +137,8 @@ class QAPIDoc(object):
         # TODO Make it a subclass of Enum when Python 2 support is remov=
ed
         BODY =3D 1
         ARGS =3D 2
-        VARIOUS =3D 3
+        FEATURES =3D 3
+        VARIOUS =3D 4
=20
     def __init__(self, parser, info):
         # self._parser is used to report errors with QAPIParseError.  Th=
e
@@ -149,6 +151,7 @@ class QAPIDoc(object):
         self.body =3D QAPIDoc.Section()
         # dict mapping parameter name to ArgSection
         self.args =3D OrderedDict()
+        self.features =3D OrderedDict()
         # a list of Section
         self.sections =3D []
         # the current section
@@ -197,6 +200,8 @@ class QAPIDoc(object):
             self._append_body_line(line)
         elif self._part =3D=3D QAPIDoc.DocPart.ARGS:
             self._append_args_line(line)
+        elif self._part =3D=3D QAPIDoc.DocPart.FEATURES:
+            self._append_features_line(line)
         elif self._part =3D=3D QAPIDoc.DocPart.VARIOUS:
             self._append_various_line(line)
         else:
@@ -229,6 +234,8 @@ class QAPIDoc(object):
             if name.startswith('@') and name.endswith(':'):
                 self._part =3D QAPIDoc.DocPart.ARGS
                 self._append_args_line(line)
+            elif line =3D=3D 'Features:':
+                self._part =3D QAPIDoc.DocPart.FEATURES
             elif self._is_section_tag(name):
                 self._part =3D QAPIDoc.DocPart.VARIOUS
                 self._append_various_line(line)
@@ -248,6 +255,28 @@ class QAPIDoc(object):
             self._part =3D QAPIDoc.DocPart.VARIOUS
             self._append_various_line(line)
             return
+        elif (self._section.text.endswith('\n\n')
+              and line and not line[0].isspace()):
+            if line =3D=3D 'Features:':
+                self._part =3D QAPIDoc.DocPart.FEATURES
+            else:
+                self._start_section()
+                self._part =3D QAPIDoc.DocPart.VARIOUS
+                self._append_various_line(line)
+            return
+
+        self._append_freeform(line.strip())
+
+    def _append_features_line(self, line):
+        name =3D line.split(' ', 1)[0]
+
+        if name.startswith('@') and name.endswith(':'):
+            line =3D line[len(name)+1:]
+            self._start_features_section(name[1:-1])
+        elif self._is_section_tag(name):
+            self._part =3D QAPIDoc.DocPart.VARIOUS
+            self._append_various_line(line)
+            return
         elif (self._section.text.endswith('\n\n')
               and line and not line[0].isspace()):
             self._start_section()
@@ -274,17 +303,23 @@ class QAPIDoc(object):
=20
         self._append_freeform(line)
=20
-    def _start_args_section(self, name):
+    def _start_symbol_section(self, symbols_dict, name):
         # FIXME invalid names other than the empty string aren't flagged
         if not name:
             raise QAPIParseError(self._parser, "Invalid parameter name")
-        if name in self.args:
+        if name in symbols_dict:
             raise QAPIParseError(self._parser,
                                  "'%s' parameter name duplicated" % name=
)
         assert not self.sections
         self._end_section()
         self._section =3D QAPIDoc.ArgSection(name)
-        self.args[name] =3D self._section
+        symbols_dict[name] =3D self._section
+
+    def _start_args_section(self, name):
+        self._start_symbol_section(self.args, name)
+
+    def _start_features_section(self, name):
+        self._start_symbol_section(self.features, name)
=20
     def _start_section(self, name=3DNone):
         if name in ('Returns', 'Since') and self.has_section(name):
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 433e9fcbfb..5fc0fc7e06 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -182,6 +182,17 @@ def texi_members(doc, what, base, variants, member_f=
unc):
     return '\n@b{%s:}\n@table @asis\n%s@end table\n' % (what, items)
=20
=20
+def texi_features(doc):
+    """Format the table of features"""
+    items =3D ''
+    for section in doc.features.values():
+        desc =3D texi_format(section.text)
+        items +=3D '@item @code{%s}\n%s' % (section.name, desc)
+    if not items:
+        return ''
+    return '\n@b{Features:}\n@table @asis\n%s@end table\n' % (items)
+
+
 def texi_sections(doc, ifcond):
     """Format additional sections following arguments"""
     body =3D ''
@@ -201,6 +212,7 @@ def texi_entity(doc, what, ifcond, base=3DNone, varia=
nts=3DNone,
                 member_func=3Dtexi_member):
     return (texi_body(doc)
             + texi_members(doc, what, base, variants, member_func)
+            + texi_features(doc)
             + texi_sections(doc, ifcond))
=20
=20
--=20
2.21.0


