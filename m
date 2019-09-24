Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D055C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8382146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8382146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCkax-00076u-3J
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCk0r-0001Nm-NF
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCk0k-0006zs-Ne
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53444)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCk0k-0006x7-AG
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A57D8A1C82
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:33:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7B656017E;
 Tue, 24 Sep 2019 12:33:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A93B1136431; Tue, 24 Sep 2019 14:33:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/37] qapi: Assert .visit() and .check_clash() run only after
 .check()
Date: Tue, 24 Sep 2019 14:33:34 +0200
Message-Id: <20190924123334.30645-38-armbru@redhat.com>
In-Reply-To: <20190924123334.30645-1-armbru@redhat.com>
References: <20190924123334.30645-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 24 Sep 2019 12:33:41 +0000 (UTC)
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

Easy since the previous commit provides .checked.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190914153506.2151-20-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index c199a2b58c..b00caacca3 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1190,7 +1190,7 @@ class QAPISchemaEntity(object):
         return not self.info
=20
     def visit(self, visitor):
-        pass
+        assert self._checked
=20
=20
 class QAPISchemaVisitor(object):
@@ -1245,6 +1245,7 @@ class QAPISchemaInclude(QAPISchemaEntity):
         self.fname =3D fname
=20
     def visit(self, visitor):
+        QAPISchemaEntity.visit(self, visitor)
         visitor.visit_include(self.fname, self.info)
=20
=20
@@ -1309,6 +1310,7 @@ class QAPISchemaBuiltinType(QAPISchemaType):
         return self.json_type()
=20
     def visit(self, visitor):
+        QAPISchemaType.visit(self, visitor)
         visitor.visit_builtin_type(self.name, self.info, self.json_type(=
))
=20
=20
@@ -1344,6 +1346,7 @@ class QAPISchemaEnumType(QAPISchemaType):
         return 'string'
=20
     def visit(self, visitor):
+        QAPISchemaType.visit(self, visitor)
         visitor.visit_enum_type(self.name, self.info, self.ifcond,
                                 self.members, self.prefix)
=20
@@ -1386,6 +1389,7 @@ class QAPISchemaArrayType(QAPISchemaType):
         return 'array of ' + elt_doc_type
=20
     def visit(self, visitor):
+        QAPISchemaType.visit(self, visitor)
         visitor.visit_array_type(self.name, self.info, self.ifcond,
                                  self.element_type)
=20
@@ -1461,6 +1465,7 @@ class QAPISchemaObjectType(QAPISchemaType):
     # and update seen to track the members seen so far. Report any error=
s
     # on behalf of info, which is not necessarily self.info
     def check_clash(self, info, seen):
+        assert self._checked
         assert not self.variants       # not implemented
         for m in self.members:
             m.check_clash(info, seen)
@@ -1498,6 +1503,7 @@ class QAPISchemaObjectType(QAPISchemaType):
         return 'object'
=20
     def visit(self, visitor):
+        QAPISchemaType.visit(self, visitor)
         visitor.visit_object_type(self.name, self.info, self.ifcond,
                                   self.base, self.local_members, self.va=
riants,
                                   self.features)
@@ -1665,6 +1671,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
         return 'value'
=20
     def visit(self, visitor):
+        QAPISchemaType.visit(self, visitor)
         visitor.visit_alternate_type(self.name, self.info, self.ifcond,
                                      self.variants)
=20
@@ -1698,6 +1705,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
             assert isinstance(self.ret_type, QAPISchemaType)
=20
     def visit(self, visitor):
+        QAPISchemaEntity.visit(self, visitor)
         visitor.visit_command(self.name, self.info, self.ifcond,
                               self.arg_type, self.ret_type,
                               self.gen, self.success_response,
@@ -1723,6 +1731,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
             raise QAPISemError(self.info, "Use of 'boxed' requires 'data=
'")
=20
     def visit(self, visitor):
+        QAPISchemaEntity.visit(self, visitor)
         visitor.visit_event(self.name, self.info, self.ifcond,
                             self.arg_type, self.boxed)
=20
--=20
2.21.0


