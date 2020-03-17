Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBAFC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547A42051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmvzlUGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547A42051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJVt-0001Yk-DF
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEJL9-0002p8-JV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEJL4-0002dt-8h
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56395)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEJL3-0002Yi-OC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584478884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lp5+I2Q6/0GMIaSXt4j64JZYjft38qKP8t8u2n3VHyA=;
 b=JmvzlUGjWFH4zMGEJql/d8kEbYnpIEkCEqSrMlUlbHAbFgKQMLep9efgW/H6r3ugT/AMev
 rfVURhgYezwh1+Pscj8010GWEL5BRj8WC37dXpKtQlAl/Tla85rmI/LV3g/l2nLqdX0saV
 0UddWRT/Djoz2MneJdVboRgw/32rNnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-PbWXti7dPtCAe-jWXMuS5A-1; Tue, 17 Mar 2020 17:01:22 -0400
X-MC-Unique: PbWXti7dPtCAe-jWXMuS5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FE17107ACC9
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 21:01:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09B545C1BB;
 Tue, 17 Mar 2020 21:01:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6976A1135A5A; Tue, 17 Mar 2020 22:01:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/30] qapi/schema: Change _make_features() to a take feature
 list
Date: Tue, 17 Mar 2020 22:01:02 +0100
Message-Id: <20200317210115.8864-18-armbru@redhat.com>
In-Reply-To: <20200317210115.8864-1-armbru@redhat.com>
References: <20200317210115.8864-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

QAPISchema._make_features() takes a definition expression, and
extracts its 'features' member.  The other ._make_FOO() leave
destructuring expressions to their callers.  Change ._make_features()
to match them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200317115459.31821-17-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/schema.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 958756ecd6..4d8ad67303 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -904,8 +904,9 @@ class QAPISchema:
         self._def_entity(QAPISchemaEnumType('QType', None, None, None, Non=
e,
                                             qtype_values, 'QTYPE'))
=20
-    def _make_features(self, expr, info):
-        features =3D expr.get('features', [])
+    def _make_features(self, features, info):
+        if features is None:
+            return []
         return [QAPISchemaFeature(f['name'], info, f.get('if'))
                 for f in features]
=20
@@ -955,7 +956,7 @@ class QAPISchema:
         data =3D expr['data']
         prefix =3D expr.get('prefix')
         ifcond =3D expr.get('if')
-        features =3D self._make_features(expr, info)
+        features =3D self._make_features(expr.get('features'), info)
         self._def_entity(QAPISchemaEnumType(
             name, info, doc, ifcond, features,
             self._make_enum_members(data, info), prefix))
@@ -979,7 +980,7 @@ class QAPISchema:
         base =3D expr.get('base')
         data =3D expr['data']
         ifcond =3D expr.get('if')
-        features =3D self._make_features(expr, info)
+        features =3D self._make_features(expr.get('features'), info)
         self._def_entity(QAPISchemaObjectType(
             name, info, doc, ifcond, features, base,
             self._make_members(data, info),
@@ -1002,7 +1003,7 @@ class QAPISchema:
         data =3D expr['data']
         base =3D expr.get('base')
         ifcond =3D expr.get('if')
-        features =3D self._make_features(expr, info)
+        features =3D self._make_features(expr.get('features'), info)
         tag_name =3D expr.get('discriminator')
         tag_member =3D None
         if isinstance(base, dict):
@@ -1032,7 +1033,7 @@ class QAPISchema:
         name =3D expr['alternate']
         data =3D expr['data']
         ifcond =3D expr.get('if')
-        features =3D self._make_features(expr, info)
+        features =3D self._make_features(expr.get('features'), info)
         variants =3D [self._make_variant(key, value['type'], value.get('if=
'),
                                        info)
                     for (key, value) in data.items()]
@@ -1052,7 +1053,7 @@ class QAPISchema:
         allow_oob =3D expr.get('allow-oob', False)
         allow_preconfig =3D expr.get('allow-preconfig', False)
         ifcond =3D expr.get('if')
-        features =3D self._make_features(expr, info)
+        features =3D self._make_features(expr.get('features'), info)
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
                 name, info, ifcond,
@@ -1070,7 +1071,7 @@ class QAPISchema:
         data =3D expr.get('data')
         boxed =3D expr.get('boxed', False)
         ifcond =3D expr.get('if')
-        features =3D self._make_features(expr, info)
+        features =3D self._make_features(expr.get('features'), info)
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
                 name, info, ifcond,
--=20
2.21.1


