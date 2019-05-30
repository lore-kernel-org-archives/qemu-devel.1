Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD1AC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770E724DB3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770E724DB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52094 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIu5-00058a-Nu
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:07:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWIq9-0001nI-Ui
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWIq8-0003l6-K3
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:03:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hWIq5-0003ak-D1; Thu, 30 May 2019 07:03:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FC613082135;
	Thu, 30 May 2019 11:03:16 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-119.ams2.redhat.com
	[10.36.116.119])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F31C56FC06;
	Thu, 30 May 2019 11:03:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 30 May 2019 13:02:54 +0200
Message-Id: <20190530110255.16225-6-kwolf@redhat.com>
In-Reply-To: <20190530110255.16225-1-kwolf@redhat.com>
References: <20190530110255.16225-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Thu, 30 May 2019 11:03:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 5/6] qapi: Allow documentation for features
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, armbru@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Features will be documented in a new part introduced by a "Features:"
line, after arguments and before named sections.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qapi/common.py | 42 ++++++++++++++++++++++++++++++++++++++----
 scripts/qapi/doc.py    | 12 ++++++++++++
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 55ccd216cf..bc09e7d358 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -127,6 +127,7 @@ class QAPIDoc(object):
           optional overview
         * an ARGS part: description of each argument (for commands and
           events) or member (for structs, unions and alternates),
+        * a FEATURES part: description of each feature,
         * a VARIOUS part: optional tagged sections.
=20
         Free-form documentation blocks consist only of a BODY part.
@@ -134,7 +135,8 @@ class QAPIDoc(object):
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
@@ -147,6 +149,7 @@ class QAPIDoc(object):
         self.body =3D QAPIDoc.Section()
         # dict mapping parameter name to ArgSection
         self.args =3D OrderedDict()
+        self.features =3D OrderedDict()
         # a list of Section
         self.sections =3D []
         # the current section
@@ -192,6 +195,8 @@ class QAPIDoc(object):
             self._append_body_line(line)
         elif self._part =3D=3D QAPIDoc.DocPart.ARGS:
             self._append_args_line(line)
+        elif self._part =3D=3D QAPIDoc.DocPart.FEATURES:
+            self._append_features_line(line)
         elif self._part =3D=3D QAPIDoc.DocPart.VARIOUS:
             self._append_various_line(line)
         else:
@@ -226,6 +231,8 @@ class QAPIDoc(object):
             if name.startswith('@') and name.endswith(':'):
                 self._part =3D QAPIDoc.DocPart.ARGS
                 self._append_args_line(line)
+            elif line =3D=3D 'Features:':
+                self._part =3D QAPIDoc.DocPart.FEATURES
             elif self.symbol and self._check_named_section(name):
                 self._append_various_line(line)
             else:
@@ -243,6 +250,27 @@ class QAPIDoc(object):
         elif self._check_named_section(name):
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
+        elif self._check_named_section(name):
+            self._append_various_line(line)
+            return
         elif (self._section.text.endswith('\n\n')
               and line and not line[0].isspace()):
             self._start_section()
@@ -269,17 +297,23 @@ class QAPIDoc(object):
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
2.20.1


