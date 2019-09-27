Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF02BC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31C2217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31C2217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrPe-0007TD-8C
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iDqa7-0001Bi-5D
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iDqa4-00061c-Rp
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iDqa4-000618-Iv
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CC77C2BFDC;
 Fri, 27 Sep 2019 13:46:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB5A31000232;
 Fri, 27 Sep 2019 13:46:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 69EB41138661; Fri, 27 Sep 2019 15:46:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/26] qapi: New QAPISourceInfo, replacing dict
Date: Fri, 27 Sep 2019 15:46:16 +0200
Message-Id: <20190927134639.4284-4-armbru@redhat.com>
In-Reply-To: <20190927134639.4284-1-armbru@redhat.com>
References: <20190927134639.4284-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 27 Sep 2019 13:46:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We track source locations with a dict of the form

    {'file': FNAME, 'line': LINENO, 'parent': PARENT}

where PARENT is None for the main file, and the include directive's
source location for included files.

This is serviceable enough, but the next commit will add information,
and that's going to come out cleaner if we turn this into a class.  So
do that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 69 +++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index bfb3e8a493..5843f3eeb2 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -13,6 +13,7 @@
=20
 from __future__ import print_function
 from contextlib import contextmanager
+import copy
 import errno
 import os
 import re
@@ -53,34 +54,50 @@ struct_types =3D {}
 union_types =3D {}
 all_names =3D {}
=20
+
 #
 # Parsing the schema into expressions
 #
=20
+class QAPISourceInfo(object):
+    def __init__(self, fname, line, parent):
+        self.fname =3D fname
+        self.line =3D line
+        self.parent =3D parent
=20
-def error_path(parent):
-    res =3D ''
-    while parent:
-        res =3D ('In file included from %s:%d:\n' % (parent['file'],
-                                                   parent['line'])) + re=
s
-        parent =3D parent['parent']
-    return res
+    def next_line(self):
+        info =3D copy.copy(self)
+        info.line +=3D 1
+        return info
+
+    def loc(self):
+        return '%s:%d' % (self.fname, self.line)
+
+    def include_path(self):
+        ret =3D ''
+        parent =3D self.parent
+        while parent:
+            ret =3D 'In file included from %s:\n' % parent.loc() + ret
+            parent =3D parent.parent
+        return ret
+
+    def __str__(self):
+        return self.include_path() + self.loc()
=20
=20
 class QAPIError(Exception):
-    def __init__(self, fname, line, col, incl_info, msg):
+    def __init__(self, info, col, msg):
         Exception.__init__(self)
-        self.fname =3D fname
-        self.line =3D line
+        self.info =3D info
         self.col =3D col
-        self.info =3D incl_info
         self.msg =3D msg
=20
     def __str__(self):
-        loc =3D '%s:%d' % (self.fname, self.line)
+        loc =3D str(self.info)
         if self.col is not None:
+            assert self.info.line is not None
             loc +=3D ':%s' % self.col
-        return error_path(self.info) + '%s: %s' % (loc, self.msg)
+        return loc + ': ' + self.msg
=20
=20
 class QAPIParseError(QAPIError):
@@ -91,14 +108,12 @@ class QAPIParseError(QAPIError):
                 col =3D (col + 7) % 8 + 1
             else:
                 col +=3D 1
-        QAPIError.__init__(self, parser.fname, parser.line, col,
-                           parser.incl_info, msg)
+        QAPIError.__init__(self, parser.info, col, msg)
=20
=20
 class QAPISemError(QAPIError):
     def __init__(self, info, msg):
-        QAPIError.__init__(self, info['file'], info['line'], None,
-                           info['parent'], msg)
+        QAPIError.__init__(self, info, None, msg)
=20
=20
 class QAPIDoc(object):
@@ -382,12 +397,11 @@ class QAPISchemaParser(object):
     def __init__(self, fp, previously_included=3D[], incl_info=3DNone):
         self.fname =3D fp.name
         previously_included.append(os.path.abspath(fp.name))
-        self.incl_info =3D incl_info
         self.src =3D fp.read()
         if self.src =3D=3D '' or self.src[-1] !=3D '\n':
             self.src +=3D '\n'
         self.cursor =3D 0
-        self.line =3D 1
+        self.info =3D QAPISourceInfo(self.fname, 1, incl_info)
         self.line_pos =3D 0
         self.exprs =3D []
         self.docs =3D []
@@ -395,8 +409,7 @@ class QAPISchemaParser(object):
         cur_doc =3D None
=20
         while self.tok is not None:
-            info =3D {'file': self.fname, 'line': self.line,
-                    'parent': self.incl_info}
+            info =3D self.info
             if self.tok =3D=3D '#':
                 self.reject_expr_doc(cur_doc)
                 cur_doc =3D self.get_doc(info)
@@ -456,9 +469,9 @@ class QAPISchemaParser(object):
         # catch inclusion cycle
         inf =3D info
         while inf:
-            if incl_abs_fname =3D=3D os.path.abspath(inf['file']):
+            if incl_abs_fname =3D=3D os.path.abspath(inf.fname):
                 raise QAPISemError(info, "Inclusion loop for %s" % inclu=
de)
-            inf =3D inf['parent']
+            inf =3D inf.parent
=20
         # skip multiple include of the same file
         if incl_abs_fname in previously_included:
@@ -552,7 +565,7 @@ class QAPISchemaParser(object):
                 if self.cursor =3D=3D len(self.src):
                     self.tok =3D None
                     return
-                self.line +=3D 1
+                self.info =3D self.info.next_line()
                 self.line_pos =3D self.cursor
             elif not self.tok.isspace():
                 # Show up to next structural, whitespace or quote
@@ -1172,7 +1185,7 @@ class QAPISchemaEntity(object):
     def check(self, schema):
         assert not self._checked
         if self.info:
-            self._module =3D os.path.relpath(self.info['file'],
+            self._module =3D os.path.relpath(self.info.fname,
                                            os.path.dirname(schema.fname)=
)
         self._checked =3D True
=20
@@ -1781,9 +1794,9 @@ class QAPISchema(object):
         include =3D expr['include']
         assert doc is None
         main_info =3D info
-        while main_info['parent']:
-            main_info =3D main_info['parent']
-        fname =3D os.path.relpath(include, os.path.dirname(main_info['fi=
le']))
+        while main_info.parent:
+            main_info =3D main_info.parent
+        fname =3D os.path.relpath(include, os.path.dirname(main_info.fna=
me))
         self._def_entity(QAPISchemaInclude(fname, info))
=20
     def _def_builtin_type(self, name, json_type, c_type):
--=20
2.21.0


