Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E6CC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7578A205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7578A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53458 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfSzC-0003It-16
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 13:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48755)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfSwj-00018S-8W
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfSwc-0004em-6c
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:39:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfSwV-00047e-EV; Mon, 24 Jun 2019 13:39:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8A84882FB;
 Mon, 24 Jun 2019 17:39:39 +0000 (UTC)
Received: from localhost (ovpn-204-152.brq.redhat.com [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80D6A60BE2;
 Mon, 24 Jun 2019 17:39:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 24 Jun 2019 19:39:21 +0200
Message-Id: <20190624173935.25747-2-mreitz@redhat.com>
In-Reply-To: <20190624173935.25747-1-mreitz@redhat.com>
References: <20190624173935.25747-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 24 Jun 2019 17:39:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 01/14] qapi: Parse numeric values
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qapi-schema/bad-type-int.json      |  1 -
 tests/qapi-schema/enum-int-member.json   |  1 -
 scripts/qapi/common.py                   | 25 ++++++++++++++++++++----
 scripts/qapi/introspect.py               |  2 ++
 tests/qapi-schema/bad-type-int.err       |  2 +-
 tests/qapi-schema/enum-int-member.err    |  2 +-
 tests/qapi-schema/leading-comma-list.err |  2 +-
 7 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/tests/qapi-schema/bad-type-int.json b/tests/qapi-schema/bad-=
type-int.json
index 56fc6f8126..81355eb196 100644
--- a/tests/qapi-schema/bad-type-int.json
+++ b/tests/qapi-schema/bad-type-int.json
@@ -1,3 +1,2 @@
 # we reject an expression with a metatype that is not a string
-# FIXME: once the parser understands integer inputs, improve the error m=
essage
 { 'struct': 1, 'data': { } }
diff --git a/tests/qapi-schema/enum-int-member.json b/tests/qapi-schema/e=
num-int-member.json
index 6c9c32e149..6958440c6d 100644
--- a/tests/qapi-schema/enum-int-member.json
+++ b/tests/qapi-schema/enum-int-member.json
@@ -1,3 +1,2 @@
 # we reject any enum member that is not a string
-# FIXME: once the parser understands integer inputs, improve the error m=
essage
 { 'enum': 'MyEnum', 'data': [ 1 ] }
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d61bfdc526..3396ea4a09 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -498,6 +498,8 @@ class QAPISchemaParser(object):
             raise QAPISemError(info, "Unknown pragma '%s'" % name)
=20
     def accept(self, skip_comment=3DTrue):
+        num_match =3D re.compile(r'([-+]?inf|nan|[-+0-9.][0-9a-f.ex]*)')
+
         while True:
             self.tok =3D self.src[self.cursor]
             self.pos =3D self.cursor
@@ -584,7 +586,22 @@ class QAPISchemaParser(object):
                     return
                 self.line +=3D 1
                 self.line_pos =3D self.cursor
-            elif not self.tok.isspace():
+            elif self.tok.isspace():
+                pass
+            elif num_match.match(self.src[self.pos:]):
+                match =3D num_match.match(self.src[self.pos:]).group(0)
+                try:
+                    self.val =3D int(match, 0)
+                except ValueError:
+                    try:
+                        self.val =3D float(match)
+                    except ValueError:
+                        raise QAPIParseError(self,
+                                '"%s" is not a valid integer or float' %=
 match)
+
+                self.cursor +=3D len(match) - 1
+                return
+            else:
                 raise QAPIParseError(self, 'Stray "%s"' % self.tok)
=20
     def get_members(self):
@@ -617,9 +634,9 @@ class QAPISchemaParser(object):
         if self.tok =3D=3D ']':
             self.accept()
             return expr
-        if self.tok not in "{['tfn":
+        if self.tok not in "{['tfn-+0123456789.i":
             raise QAPIParseError(self, 'Expected "{", "[", "]", string, =
'
-                                 'boolean or "null"')
+                                 'boolean, number or "null"')
         while True:
             expr.append(self.get_expr(True))
             if self.tok =3D=3D ']':
@@ -638,7 +655,7 @@ class QAPISchemaParser(object):
         elif self.tok =3D=3D '[':
             self.accept()
             expr =3D self.get_values()
-        elif self.tok in "'tfn":
+        elif self.tok in "'tfn-+0123456789.i":
             expr =3D self.val
             self.accept()
         else:
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index f62cf0a2e1..6a61dd831f 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -57,6 +57,8 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
         ret +=3D indent(level) + '}))'
     elif isinstance(obj, bool):
         ret +=3D 'QLIT_QBOOL(%s)' % ('true' if obj else 'false')
+    elif isinstance(obj, int) and obj >=3D -(2 ** 63) and obj < 2 ** 63:
+        ret +=3D 'QLIT_QNUM(%i)' % obj
     else:
         assert False                # not implemented
     if level > 0:
diff --git a/tests/qapi-schema/bad-type-int.err b/tests/qapi-schema/bad-t=
ype-int.err
index da89895404..e22fb4f655 100644
--- a/tests/qapi-schema/bad-type-int.err
+++ b/tests/qapi-schema/bad-type-int.err
@@ -1 +1 @@
-tests/qapi-schema/bad-type-int.json:3:13: Stray "1"
+tests/qapi-schema/bad-type-int.json:2: 'struct' key must have a string v=
alue
diff --git a/tests/qapi-schema/enum-int-member.err b/tests/qapi-schema/en=
um-int-member.err
index 071c5213d8..112175f79d 100644
--- a/tests/qapi-schema/enum-int-member.err
+++ b/tests/qapi-schema/enum-int-member.err
@@ -1 +1 @@
-tests/qapi-schema/enum-int-member.json:3:31: Stray "1"
+tests/qapi-schema/enum-int-member.json:2: Member of enum 'MyEnum' requir=
es a string name
diff --git a/tests/qapi-schema/leading-comma-list.err b/tests/qapi-schema=
/leading-comma-list.err
index f5c870bb9c..fa9c80aa57 100644
--- a/tests/qapi-schema/leading-comma-list.err
+++ b/tests/qapi-schema/leading-comma-list.err
@@ -1 +1 @@
-tests/qapi-schema/leading-comma-list.json:2:13: Expected "{", "[", "]", =
string, boolean or "null"
+tests/qapi-schema/leading-comma-list.json:2:13: Expected "{", "[", "]", =
string, boolean, number or "null"
--=20
2.21.0


