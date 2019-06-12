Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E51C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2118C21019
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2118C21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33984 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6oD-0007E5-9E
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 13:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57905)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hb6Ub-0007SE-RY
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hb6UU-0006SB-IS
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hb6UP-0006Ef-SF
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 181FBC18B2E9
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 16:52:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B71FF60BF1;
 Wed, 12 Jun 2019 16:52:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C7FE41136423; Wed, 12 Jun 2019 18:52:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 18:52:29 +0200
Message-Id: <20190612165229.26976-12-armbru@redhat.com>
In-Reply-To: <20190612165229.26976-1-armbru@redhat.com>
References: <20190612165229.26976-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 12 Jun 2019 16:52:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/11] qapi: Simplify how QAPIDoc implements its
 state machine
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
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QAPIDoc uses a state machine to for processing of documentation lines.
Its state is encoded as an enum QAPIDoc._state (well, as enum-like
class actually, thanks to our infatuation with Python 2).

All we ever do with the state is calling the state's function to
process a line of documentation.  The enum values effectively serve as
handles for the functions.

Eliminate the rather wordy indirection: store the function to call in
QAPIDoc._append_line.  Update and improve comments.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190606153803.5278-8-armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
[Commit message typo fixed]
---
 scripts/qapi/common.py | 125 ++++++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 57 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 1164301edf..d61bfdc526 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -102,6 +102,24 @@ class QAPISemError(QAPIError):
=20
=20
 class QAPIDoc(object):
+    """
+    A documentation comment block, either expression or free-form
+
+    Expression documentation blocks consist of
+
+    * a body section: one line naming the expression, followed by an
+      overview (any number of lines)
+
+    * argument sections: a description of each argument (for commands
+      and events) or member (for structs, unions and alternates)
+
+    * features sections: a description of each feature flag
+
+    * additional (non-argument) sections, possibly tagged
+
+    Free-form documentation blocks consist only of a body section.
+    """
+
     class Section(object):
         def __init__(self, name=3DNone):
             # optional section name (argument/member or section name)
@@ -120,26 +138,6 @@ class QAPIDoc(object):
         def connect(self, member):
             self.member =3D member
=20
-    class DocPart:
-        """
-        Describes which part of the documentation we're parsing right no=
w.
-
-        Expression documentation blocks consist of
-        * a BODY part: first line naming the expression, plus an
-          optional overview
-        * an ARGS part: description of each argument (for commands and
-          events) or member (for structs, unions and alternates),
-        * a FEATURES part: description of each feature,
-        * a VARIOUS part: optional tagged sections.
-
-        Free-form documentation blocks consist only of a BODY part.
-        """
-        # TODO Make it a subclass of Enum when Python 2 support is remov=
ed
-        BODY =3D 1
-        ARGS =3D 2
-        FEATURES =3D 3
-        VARIOUS =3D 4
-
     def __init__(self, parser, info):
         # self._parser is used to report errors with QAPIParseError.  Th=
e
         # resulting error position depends on the state of the parser.
@@ -156,7 +154,7 @@ class QAPIDoc(object):
         self.sections =3D []
         # the current section
         self._section =3D self.body
-        self._part =3D QAPIDoc.DocPart.BODY
+        self._append_line =3D self._append_body_line
=20
     def has_section(self, name):
         """Return True if we have a section with this name."""
@@ -171,21 +169,10 @@ class QAPIDoc(object):
=20
         The way that the line is dealt with depends on which part of
         the documentation we're parsing right now:
-
-        BODY means that we're ready to process free-form text into
-        self.body.  A symbol name is only allowed if no other text was
-        parsed yet.  It is interpreted as the symbol name that
-        describes the currently documented object.  On getting the
-        second symbol name, we proceed to ARGS.
-
-        ARGS means that we're parsing the arguments section.  Any
-        symbol name is interpreted as an argument and an ArgSection is
-        created for it.
-
-        VARIOUS is the final part where free-form sections may appear.
-        This includes named sections such as "Return:" as well as
-        unnamed paragraphs.  Symbols are not allowed any more in this
-        part.
+        * The body section: ._append_line is ._append_body_line
+        * An argument section: ._append_line is ._append_args_line
+        * A features section: ._append_line is ._append_features_line
+        * An additional section: ._append_line is ._append_various_line
         """
         line =3D line[1:]
         if not line:
@@ -195,17 +182,7 @@ class QAPIDoc(object):
         if line[0] !=3D ' ':
             raise QAPIParseError(self._parser, "Missing space after #")
         line =3D line[1:]
-
-        if self._part =3D=3D QAPIDoc.DocPart.BODY:
-            self._append_body_line(line)
-        elif self._part =3D=3D QAPIDoc.DocPart.ARGS:
-            self._append_args_line(line)
-        elif self._part =3D=3D QAPIDoc.DocPart.FEATURES:
-            self._append_features_line(line)
-        elif self._part =3D=3D QAPIDoc.DocPart.VARIOUS:
-            self._append_various_line(line)
-        else:
-            assert False
+        self._append_line(line)
=20
     def end_comment(self):
         self._end_section()
@@ -219,6 +196,19 @@ class QAPIDoc(object):
                         'TODO:')
=20
     def _append_body_line(self, line):
+        """
+        Process a line of documentation text in the body section.
+
+        If this a symbol line and it is the section's first line, this
+        is an expression documentation block for that symbol.
+
+        If it's an expression documentation block, another symbol line
+        begins the argument section for the argument named by it, and
+        a section tag begins an additional section.  Start that
+        section and append the line to it.
+
+        Else, append the line to the current section.
+        """
         name =3D line.split(' ', 1)[0]
         # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
         # recognized, and get silently treated as ordinary text
@@ -230,38 +220,49 @@ class QAPIDoc(object):
             if not self.symbol:
                 raise QAPIParseError(self._parser, "Invalid name")
         elif self.symbol:
-            # We already know that we document some symbol
+            # This is an expression documentation block
             if name.startswith('@') and name.endswith(':'):
-                self._part =3D QAPIDoc.DocPart.ARGS
+                self._append_line =3D self._append_args_line
                 self._append_args_line(line)
             elif line =3D=3D 'Features:':
-                self._part =3D QAPIDoc.DocPart.FEATURES
+                self._append_line =3D self._append_features_line
             elif self._is_section_tag(name):
-                self._part =3D QAPIDoc.DocPart.VARIOUS
+                self._append_line =3D self._append_various_line
                 self._append_various_line(line)
             else:
                 self._append_freeform(line.strip())
         else:
-            # This is free-form documentation without a symbol
+            # This is a free-form documentation block
             self._append_freeform(line.strip())
=20
     def _append_args_line(self, line):
+        """
+        Process a line of documentation text in an argument section.
+
+        A symbol line begins the next argument section, a section tag
+        section or a non-indented line after a blank line begins an
+        additional section.  Start that section and append the line to
+        it.
+
+        Else, append the line to the current section.
+
+        """
         name =3D line.split(' ', 1)[0]
=20
         if name.startswith('@') and name.endswith(':'):
             line =3D line[len(name)+1:]
             self._start_args_section(name[1:-1])
         elif self._is_section_tag(name):
-            self._part =3D QAPIDoc.DocPart.VARIOUS
+            self._append_line =3D self._append_various_line
             self._append_various_line(line)
             return
         elif (self._section.text.endswith('\n\n')
               and line and not line[0].isspace()):
             if line =3D=3D 'Features:':
-                self._part =3D QAPIDoc.DocPart.FEATURES
+                self._append_line =3D self._append_features_line
             else:
                 self._start_section()
-                self._part =3D QAPIDoc.DocPart.VARIOUS
+                self._append_line =3D self._append_various_line
                 self._append_various_line(line)
             return
=20
@@ -274,19 +275,29 @@ class QAPIDoc(object):
             line =3D line[len(name)+1:]
             self._start_features_section(name[1:-1])
         elif self._is_section_tag(name):
-            self._part =3D QAPIDoc.DocPart.VARIOUS
+            self._append_line =3D self._append_various_line
             self._append_various_line(line)
             return
         elif (self._section.text.endswith('\n\n')
               and line and not line[0].isspace()):
             self._start_section()
-            self._part =3D QAPIDoc.DocPart.VARIOUS
+            self._append_line =3D self._append_various_line
             self._append_various_line(line)
             return
=20
         self._append_freeform(line.strip())
=20
     def _append_various_line(self, line):
+        """
+        Process a line of documentation text in an additional section.
+
+        A symbol line is an error.
+
+        A section tag begins an additional section.  Start that
+        section and append the line to it.
+
+        Else, append the line to the current section.
+        """
         name =3D line.split(' ', 1)[0]
=20
         if name.startswith('@') and name.endswith(':'):
--=20
2.21.0


