Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2436C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 18:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE47E20866
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 18:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE47E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEHoX-0001mF-9z
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 14:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iEHd9-0008S8-84
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iEHd5-0003ux-OV
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iEHd5-0003sh-9r
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 793A73D94D
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 18:39:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2242C3DE2;
 Sat, 28 Sep 2019 18:39:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 572E41138528; Sat, 28 Sep 2019 20:39:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/27] qapi: Move check for reserved names out of add_name()
Date: Sat, 28 Sep 2019 20:39:20 +0200
Message-Id: <20190928183934.12459-14-armbru@redhat.com>
In-Reply-To: <20190928183934.12459-1-armbru@redhat.com>
References: <20190928183934.12459-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Sat, 28 Sep 2019 18:39:38 +0000 (UTC)
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The checks for reserved names are spread far and wide.  Move one from
add_name() to new check_defn_name_str().  This is a first step towards
collecting them all in dedicated name checking functions next to
check_name().

While there, drop the quotes around the meta-type in
check_name_str()'s error messages: "'command' uses ... name 'NAME'"
becomes "command uses ... name 'NAME'".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190927134639.4284-13-armbru@redhat.com>
---
 scripts/qapi/common.py                   | 16 ++++++++++------
 tests/qapi-schema/bad-ident.err          |  2 +-
 tests/qapi-schema/reserved-command-q.err |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index a4cf41f13e..111a4bbe55 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -741,6 +741,13 @@ def check_name_str(name, info, source,
     assert not membername.startswith('*')
=20
=20
+def check_defn_name_str(name, info, meta):
+    check_name_str(name, info, meta, permit_upper=3DTrue)
+    if name.endswith('Kind') or name.endswith('List'):
+        raise QAPISemError(
+            info, "%s '%s' should not end in '%s'" % (meta, name, name[-=
4:]))
+
+
 def add_name(name, info, meta):
     global all_names
     # FIXME should reject names that differ only in '_' vs. '.'
@@ -748,9 +755,6 @@ def add_name(name, info, meta):
     if name in all_names:
         raise QAPISemError(info, "%s '%s' is already defined"
                            % (all_names[name], name))
-    if name.endswith('Kind') or name.endswith('List'):
-        raise QAPISemError(info, "%s '%s' should not end in '%s'"
-                           % (meta, name, name[-4:]))
     all_names[name] =3D meta
=20
=20
@@ -1162,7 +1166,7 @@ def check_exprs(exprs):
         name =3D expr[meta]
         check_name_is_str(name, info, "'%s'" % meta)
         info.set_defn(meta, name)
-        check_name_str(name, info, "'%s'" % meta, permit_upper=3DTrue)
+        check_defn_name_str(name, info, meta)
         add_name(name, info, meta)
         if doc and doc.symbol !=3D name:
             raise QAPISemError(
@@ -1889,13 +1893,13 @@ class QAPISchema(object):
=20
     def _make_implicit_enum_type(self, name, info, ifcond, values):
         # See also QAPISchemaObjectTypeMember.describe()
-        name =3D name + 'Kind'   # Use namespace reserved by add_name()
+        name =3D name + 'Kind'    # reserved by check_defn_name_str()
         self._def_entity(QAPISchemaEnumType(
             name, info, None, ifcond, self._make_enum_members(values), N=
one))
         return name
=20
     def _make_array_type(self, element_type, info):
-        name =3D element_type + 'List'   # Use namespace reserved by add=
_name()
+        name =3D element_type + 'List'    # reserved by check_defn_name_=
str()
         if not self.lookup_type(name):
             self._def_entity(QAPISchemaArrayType(name, info, element_typ=
e))
         return name
diff --git a/tests/qapi-schema/bad-ident.err b/tests/qapi-schema/bad-iden=
t.err
index ddc96bd3a9..79d14758ce 100644
--- a/tests/qapi-schema/bad-ident.err
+++ b/tests/qapi-schema/bad-ident.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/bad-ident.json: In struct '*oops':
-tests/qapi-schema/bad-ident.json:2: 'struct' uses invalid name '*oops'
+tests/qapi-schema/bad-ident.json:2: struct uses invalid name '*oops'
diff --git a/tests/qapi-schema/reserved-command-q.err b/tests/qapi-schema=
/reserved-command-q.err
index 0844e14b26..631cb5cdcc 100644
--- a/tests/qapi-schema/reserved-command-q.err
+++ b/tests/qapi-schema/reserved-command-q.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/reserved-command-q.json: In command 'q-unix':
-tests/qapi-schema/reserved-command-q.json:5: 'command' uses invalid name=
 'q-unix'
+tests/qapi-schema/reserved-command-q.json:5: command uses invalid name '=
q-unix'
--=20
2.21.0


