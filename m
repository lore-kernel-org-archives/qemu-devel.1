Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24B5C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992BA207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992BA207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCkQ9-00074e-9c
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 08:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCk0q-0001MS-Cz
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCk0k-0006zF-If
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCk0k-0006wg-1U
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F370B307D923
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:33:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CF5610013D9;
 Tue, 24 Sep 2019 12:33:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2AE36113642B; Tue, 24 Sep 2019 14:33:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/37] qapi: Normalize 'if' in check_exprs(), like other sugar
Date: Tue, 24 Sep 2019 14:33:28 +0200
Message-Id: <20190924123334.30645-32-armbru@redhat.com>
In-Reply-To: <20190924123334.30645-1-armbru@redhat.com>
References: <20190924123334.30645-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 24 Sep 2019 12:33:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We normalize shorthand to longhand forms in check_expr(): enumeration
values with normalize_enum(), feature values with
normalize_features(), struct members, union branches and alternate
branches with normalize_members().  If conditions are an exception: we
normalize them in QAPISchemaEntity.check() and
QAPISchemaMember.__init(), with listify_cond().  The idea goes back to
commit 2cbc94376e "qapi: pass 'if' condition into QAPISchemaEntity
objects", v3.0.0.

Normalize in check_expr() instead, with new helper normalize_if().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190914153506.2151-14-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index cacee9b8bb..4d1f62e808 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -804,6 +804,7 @@ def check_type(info, source, value,
         check_known_keys(info, "member '%s' of %s" % (key, source),
                          arg, ['type'], ['if'])
         check_if(arg, info)
+        normalize_if(arg)
         check_type(info, "Member '%s' of %s" % (key, source),
                    arg['type'], allow_array=3DTrue,
                    allow_metas=3D['built-in', 'union', 'alternate', 'str=
uct',
@@ -904,6 +905,7 @@ def check_union(expr, info):
         check_known_keys(info, "member '%s' of union '%s'" % (key, name)=
,
                          value, ['type'], ['if'])
         check_if(value, info)
+        normalize_if(value)
         # Each value must name a known type
         check_type(info, "Member '%s' of union '%s'" % (key, name),
                    value['type'],
@@ -933,6 +935,7 @@ def check_alternate(expr, info):
                          "member '%s' of alternate '%s'" % (key, name),
                          value, ['type'], ['if'])
         check_if(value, info)
+        normalize_if(value)
         typ =3D value['type']
=20
         # Ensure alternates have no type conflicts.
@@ -978,6 +981,7 @@ def check_enum(expr, info):
         check_known_keys(info, "member of enum '%s'" % name, member,
                          ['name'], ['if'])
         check_if(member, info)
+        normalize_if(member)
         check_name(info, "Member of enum '%s'" % name, member['name'],
                    enum_member=3DTrue)
=20
@@ -1003,6 +1007,7 @@ def check_struct(expr, info):
                              ['name'], ['if'])
=20
             check_if(f, info)
+            normalize_if(f)
             check_name(info, "Feature of struct %s" % name, f['name'])
=20
=20
@@ -1067,6 +1072,12 @@ def normalize_features(features):
                        for f in features]
=20
=20
+def normalize_if(expr):
+    ifcond =3D expr.get('if')
+    if isinstance(ifcond, str):
+        expr['if'] =3D [ifcond]
+
+
 def check_exprs(exprs):
     global all_names
=20
@@ -1123,6 +1134,7 @@ def check_exprs(exprs):
         else:
             raise QAPISemError(expr_elem['info'],
                                "Expression is missing metatype")
+        normalize_if(expr)
         name =3D expr[meta]
         add_name(name, info, meta)
         if doc and doc.symbol !=3D name:
@@ -1177,14 +1189,6 @@ def check_exprs(exprs):
 # Schema compiler frontend
 #
=20
-def listify_cond(ifcond):
-    if not ifcond:
-        return []
-    if not isinstance(ifcond, list):
-        return [ifcond]
-    return ifcond
-
-
 class QAPISchemaEntity(object):
     def __init__(self, name, info, doc, ifcond=3DNone):
         assert name is None or isinstance(name, str)
@@ -1197,7 +1201,7 @@ class QAPISchemaEntity(object):
         # such place).
         self.info =3D info
         self.doc =3D doc
-        self._ifcond =3D ifcond  # self.ifcond is set only after .check(=
)
+        self._ifcond =3D ifcond or []
=20
     def c_name(self):
         return c_name(self.name)
@@ -1209,7 +1213,7 @@ class QAPISchemaEntity(object):
             typ.check(schema)
             self.ifcond =3D typ.ifcond
         else:
-            self.ifcond =3D listify_cond(self._ifcond)
+            self.ifcond =3D self._ifcond
         if self.info:
             self.module =3D os.path.relpath(self.info['file'],
                                           os.path.dirname(schema.fname))
@@ -1515,7 +1519,7 @@ class QAPISchemaMember(object):
     def __init__(self, name, ifcond=3DNone):
         assert isinstance(name, str)
         self.name =3D name
-        self.ifcond =3D listify_cond(ifcond)
+        self.ifcond =3D ifcond or []
         self.owner =3D None
=20
     def set_owner(self, name):
--=20
2.21.0


