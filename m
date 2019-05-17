Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAF9C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5F02082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5F02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49715 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hReB0-0006mb-Fq
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 10:49:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hRe4f-0001n3-2L
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hRe4d-00043S-Kt
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:43:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17787)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hRe4a-00040E-DH; Fri, 17 May 2019 10:43:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF92E369CC;
	Fri, 17 May 2019 14:42:54 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-213.ams2.redhat.com
	[10.36.116.213])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 493915D719;
	Fri, 17 May 2019 14:42:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 17 May 2019 16:42:30 +0200
Message-Id: <20190517144232.18965-5-kwolf@redhat.com>
In-Reply-To: <20190517144232.18965-1-kwolf@redhat.com>
References: <20190517144232.18965-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 17 May 2019 14:42:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 4/6] qapi: Disentangle QAPIDoc code
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

Documentation comment follow a certain structure: First, we have a text
with a general description (called QAPIDoc.body). After this,
descriptions of the arguments follow. Finally, we have part that
contains various named sections.

The code doesn't show this structure but just checks the right side
conditions so it happens to do the right set of things in the right
phase. This is hard to follow, and adding support for documentation of
features would be even harder.

This restructures the code so that the three parts are clearly
separated. The code becomes a bit longer, but easier to follow.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qapi/common.py | 107 ++++++++++++++++++++++++++++++++---------
 1 file changed, 83 insertions(+), 24 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 71944e2e30..1d0f4847db 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -120,6 +120,27 @@ class QAPIDoc(object):
         def connect(self, member):
             self.member =3D member
=20
+    class SymbolPart:
+        """
+        Describes which part of the documentation we're parsing right no=
w.
+
+        BODY means that we're ready to process freeform text into self.b=
ody. A
+        symbol name is only allowed if no other text was parsed yet. It =
is
+        interpreted as the symbol name that describes the currently docu=
mented
+        object. On getting the second symbol name, we proceed to ARGS.
+
+        ARGS means that we're parsing the arguments section. Any symbol =
name is
+        interpreted as an argument and an ArgSection is created for it.
+
+        VARIOUS is the final part where freeform sections may appear. Th=
is
+        includes named sections such as "Return:" as well as unnamed
+        paragraphs. No symbols are allowed any more in this part.
+        """
+        # Can't make it a subclass of Enum because of Python 2
+        BODY =3D 0
+        ARGS =3D 1
+        VARIOUS =3D 2
+
     def __init__(self, parser, info):
         # self._parser is used to report errors with QAPIParseError.  Th=
e
         # resulting error position depends on the state of the parser.
@@ -135,6 +156,7 @@ class QAPIDoc(object):
         self.sections =3D []
         # the current section
         self._section =3D self.body
+        self._part =3D QAPIDoc.SymbolPart.BODY
=20
     def has_section(self, name):
         """Return True if we have a section with this name."""
@@ -154,37 +176,84 @@ class QAPIDoc(object):
             raise QAPIParseError(self._parser, "Missing space after #")
         line =3D line[1:]
=20
+        if self._part =3D=3D QAPIDoc.SymbolPart.BODY:
+            self._append_body_line(line)
+        elif self._part =3D=3D QAPIDoc.SymbolPart.ARGS:
+            self._append_args_line(line)
+        elif self._part =3D=3D QAPIDoc.SymbolPart.VARIOUS:
+            self._append_various_line(line)
+        else:
+            assert False
+
+
+    def end_comment(self):
+        self._end_section()
+
+    def _check_named_section(self, line, name):
+        if name in ('Returns:', 'Since:',
+                    # those are often singular or plural
+                    'Note:', 'Notes:',
+                    'Example:', 'Examples:',
+                    'TODO:'):
+            self._part =3D QAPIDoc.SymbolPart.VARIOUS
+            return True
+        return False
+
+    def _append_body_line(self, line):
+        name =3D line.split(' ', 1)[0]
         # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
         # recognized, and get silently treated as ordinary text
-        if self.symbol:
-            self._append_symbol_line(line)
-        elif not self.body.text and line.startswith('@'):
+        if not self.symbol and not self.body.text and line.startswith('@=
'):
             if not line.endswith(':'):
                 raise QAPIParseError(self._parser, "Line should end with=
 :")
             self.symbol =3D line[1:-1]
             # FIXME invalid names other than the empty string aren't fla=
gged
             if not self.symbol:
                 raise QAPIParseError(self._parser, "Invalid name")
+        elif self.symbol:
+            # We already know that we document some symbol
+            if name.startswith('@') and name.endswith(':'):
+                self._part =3D QAPIDoc.SymbolPart.ARGS
+                self._append_args_line(line)
+            elif self.symbol and self._check_named_section(line, name):
+                self._append_various_line(line)
+            else:
+                self._append_freeform(line.strip())
         else:
-            self._append_freeform(line)
-
-    def end_comment(self):
-        self._end_section()
+            # This is free-form documentation without a symbol
+            self._append_freeform(line.strip())
=20
-    def _append_symbol_line(self, line):
+    def _append_args_line(self, line):
         name =3D line.split(' ', 1)[0]
=20
         if name.startswith('@') and name.endswith(':'):
             line =3D line[len(name)+1:]
             self._start_args_section(name[1:-1])
-        elif name in ('Returns:', 'Since:',
-                      # those are often singular or plural
-                      'Note:', 'Notes:',
-                      'Example:', 'Examples:',
-                      'TODO:'):
+        elif self._check_named_section(line, name):
+            return self._append_various_line(line)
+        elif (self._section.text.endswith('\n\n')
+              and line and not line[0].isspace()):
+            self._start_section()
+            self._part =3D QAPIDoc.SymbolPart.VARIOUS
+            return self._append_various_line(line)
+
+        self._append_freeform(line.strip())
+
+    def _append_various_line(self, line):
+        name =3D line.split(' ', 1)[0]
+
+        if name.startswith('@') and name.endswith(':'):
+            raise QAPIParseError(self._parser,
+                                 "'%s' can't follow '%s' section"
+                                 % (name, self.sections[0].name))
+        elif self._check_named_section(line, name):
             line =3D line[len(name)+1:]
             self._start_section(name[:-1])
=20
+        if (not self._section.name or
+            not self._section.name.startswith('Example')):
+            line =3D line.strip()
+
         self._append_freeform(line)
=20
     def _start_args_section(self, name):
@@ -194,10 +263,7 @@ class QAPIDoc(object):
         if name in self.args:
             raise QAPIParseError(self._parser,
                                  "'%s' parameter name duplicated" % name=
)
-        if self.sections:
-            raise QAPIParseError(self._parser,
-                                 "'@%s:' can't follow '%s' section"
-                                 % (name, self.sections[0].name))
+        assert not self.sections
         self._end_section()
         self._section =3D QAPIDoc.ArgSection(name)
         self.args[name] =3D self._section
@@ -219,13 +285,6 @@ class QAPIDoc(object):
             self._section =3D None
=20
     def _append_freeform(self, line):
-        in_arg =3D isinstance(self._section, QAPIDoc.ArgSection)
-        if (in_arg and self._section.text.endswith('\n\n')
-                and line and not line[0].isspace()):
-            self._start_section()
-        if (in_arg or not self._section.name
-                or not self._section.name.startswith('Example')):
-            line =3D line.strip()
         match =3D re.match(r'(@\S+:)', line)
         if match:
             raise QAPIParseError(self._parser,
--=20
2.20.1


