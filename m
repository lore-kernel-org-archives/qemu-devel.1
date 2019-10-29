Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2882DCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60BA2087E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgidRPSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60BA2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPOl8-0005eL-23
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPOeA-0005Te-LQ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPOe9-000194-4v
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPOe9-00018b-0Y
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572344560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y9Ey/EUrymiudN60r02MqqCrJg8LPl6HqqAmQ4TOoVM=;
 b=OgidRPSaS4Ok11OmlmwHAlYjA80m1UCJEqHqE1f7I1cViAVqJRkXGappbhsm2whFaAlgNh
 5FB8COG2H2/QhtdvbxSqOz5TlrgM8bk56yjamzi2Ot7Ii1R+XinpOh5DWgWvE4BQvY64tK
 jFf2inj9c68O1obK2NOggCidmAA2Fkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-bN8FrCo6NfqZkv_7GeYhWg-1; Tue, 29 Oct 2019 06:22:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B33F5107AD28
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80B1860BF1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A15941132941; Tue, 29 Oct 2019 11:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/19] qapi: Simplify ._make_implicit_object_type()
Date: Tue, 29 Oct 2019 11:22:21 +0100
Message-Id: <20191029102228.20740-13-armbru@redhat.com>
In-Reply-To: <20191029102228.20740-1-armbru@redhat.com>
References: <20191029102228.20740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: bN8FrCo6NfqZkv_7GeYhWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

All callers now pass doc=3DNone.  Drop the argument.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191024110237.30963-13-armbru@redhat.com>
---
 scripts/qapi/schema.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 06e37c9c49..27da4e0f7d 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -920,8 +920,7 @@ class QAPISchema(object):
             self._def_entity(QAPISchemaArrayType(name, info, element_type)=
)
         return name
=20
-    def _make_implicit_object_type(self, name, info, doc, ifcond,
-                                   role, members):
+    def _make_implicit_object_type(self, name, info, ifcond, role, members=
):
         if not members:
             return None
         # See also QAPISchemaObjectTypeMember.describe()
@@ -939,7 +938,7 @@ class QAPISchema(object):
             # TODO kill simple unions or implement the disjunction
             assert (ifcond or []) =3D=3D typ._ifcond # pylint: disable=3Dp=
rotected-access
         else:
-            self._def_entity(QAPISchemaObjectType(name, info, doc, ifcond,
+            self._def_entity(QAPISchemaObjectType(name, info, None, ifcond=
,
                                                   None, members, None, [])=
)
         return name
=20
@@ -986,7 +985,7 @@ class QAPISchema(object):
             assert len(typ) =3D=3D 1
             typ =3D self._make_array_type(typ[0], info)
         typ =3D self._make_implicit_object_type(
-            typ, info, None, self.lookup_type(typ),
+            typ, info, self.lookup_type(typ),
             'wrapper', [self._make_member('data', typ, None, info)])
         return QAPISchemaObjectTypeVariant(case, info, typ, ifcond)
=20
@@ -999,7 +998,7 @@ class QAPISchema(object):
         tag_member =3D None
         if isinstance(base, dict):
             base =3D self._make_implicit_object_type(
-                name, info, None, ifcond,
+                name, info, ifcond,
                 'base', self._make_members(base, info))
         if tag_name:
             variants =3D [self._make_variant(key, value['type'],
@@ -1046,7 +1045,7 @@ class QAPISchema(object):
         features =3D expr.get('features', [])
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
-                name, info, None, ifcond, 'arg', self._make_members(data, =
info))
+                name, info, ifcond, 'arg', self._make_members(data, info))
         if isinstance(rets, list):
             assert len(rets) =3D=3D 1
             rets =3D self._make_array_type(rets[0], info)
@@ -1062,7 +1061,7 @@ class QAPISchema(object):
         ifcond =3D expr.get('if')
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
-                name, info, None, ifcond, 'arg', self._make_members(data, =
info))
+                name, info, ifcond, 'arg', self._make_members(data, info))
         self._def_entity(QAPISchemaEvent(name, info, doc, ifcond, data, bo=
xed))
=20
     def _def_exprs(self, exprs):
--=20
2.21.0


